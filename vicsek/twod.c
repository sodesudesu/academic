#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <SDL2/SDL.h>

#define PI 3.14159265358979323846

// バクテリアの構造体
typedef struct {
    int id;
    double x;
    double y;
    double theta;
} Bacteria;

// パラメータ
int time = 10000;
int n = 1000000;
int l = 10;
double eta = 0.01;
double R = 1;
double v_0 = 0.1;

// SDL関連のグローバル変数
SDL_Window* window;
SDL_Renderer* renderer;
const int SCREEN_WIDTH = 600;
const int SCREEN_HEIGHT = 600;

// ランダムな初期条件を設定する関数
void initialize(Bacteria* bact) {
    int i;
    for (i = 0; i < n; i++) {
        bact[i].id = i + 1;
        bact[i].x = (double)rand() / RAND_MAX * l;
        bact[i].y = (double)rand() / RAND_MAX * l;
        bact[i].theta = (double)rand() / RAND_MAX * 2 * PI;
    }
}

// 2次元の距離を計算する関数
double distance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));
}

// 角度を正規化する関数
double normalize_angle(double angle) {
    while (angle > 2 * PI) {
        angle -= 2 * PI;
    }
    while (angle < 0) {
        angle += 2 * PI;
    }
    return angle;
}

// Vicsekモデルのシミュレーションを行う関数
void vicsek(Bacteria* bact) {
    int t, i, j;
    double neighbor_real, neighbor_imag, d;

    for (t = 0; t < time; t++) {
        for (i = 0; i < n; i++) {
            neighbor_real = 0;
            neighbor_imag = 0;

            for (j = 0; j < n; j++) {
                if (i != j) {
                    d = distance(bact[i].x, bact[i].y, bact[j].x, bact[j].y);
                    if (d > 0 && d < R) {
                        neighbor_real += cos(bact[j].theta);
                        neighbor_imag += sin(bact[j].theta);
                    }
                }
            }

            // 角度を更新
            bact[i].theta = atan2(neighbor_imag, neighbor_real) + eta;
            bact[i].theta = normalize_angle(bact[i].theta);

            // 位置を更新
            bact[i].x = fmod(bact[i].x + v_0 * cos(bact[i].theta), l);
            bact[i].y = fmod(bact[i].y + v_0 * sin(bact[i].theta), l);
        }

        // アニメーションを描画
        SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
        SDL_RenderClear(renderer);

        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
        for (i = 0; i < n; i++) {
            SDL_RenderDrawLine(renderer, (int)(bact[i].x * SCREEN_WIDTH / l), (int)(bact[i].y * SCREEN_HEIGHT / l),
                               (int)((bact[i].x + 0.04 * cos(bact[i].theta)) * SCREEN_WIDTH / l),
                               (int)((bact[i].y + 0.04 * sin(bact[i].theta)) * SCREEN_HEIGHT / l));
        }

        SDL_RenderPresent(renderer);
        SDL_Delay(40);  // 40ミリ秒待つ
    }
}

int main() {
    // SDLの初期化
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        printf("SDLの初期化に失敗しました: %s\n", SDL_GetError());
        return 1;
    }

    // ウィンドウの作成
    window = SDL_CreateWindow("Vicsek Model Animation", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
                              SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN);
    if (window == NULL) {
        printf("ウィンドウの作成に失敗しました: %s\n", SDL_GetError());
        return 1;
    }

    // レンダラーの作成
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    if (renderer == NULL) {
        printf("レンダラーの作成に失敗しました: %s\n", SDL_GetError());
        return 1;
    }

    // ランダムなシードを設定
    srand(0);

    // バクテリアの配列を作成して初期化
    Bacteria* bact = (Bacteria*)malloc(n * sizeof(Bacteria));
    initialize(bact);

    // Vicsekモデルのシミュレーションを実行
    vicsek(bact);

    // メモリの解放
    free(bact);

    // SDLの終了処理
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
