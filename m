Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170312222352.2413-1-linus.walleij@linaro.org>
References: <20170312222352.2413-1-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Mar 2017 10:54:14 +0100
Message-ID: <CACRpkdZ7mQuaYUTVuKEC=FRmx7ie64cd_R0O58C10Kpm75-mAA@mail.gmail.com>
Subject: Re: [PATCH 1/4 v5] PCI: add DT bindings for Faraday Technology PCI
 Host Bridge
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: openwrt-devel@openwrt.org, Rob Herring <robh@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Feng-Hsin Chiang <john453@faraday-tech.com>,
 Paulius Zaleckas <paulius.zaleckas@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Greentime Hu <green.hu@gmail.com>,
 Janos Laube <janos.dev@gmail.com>, Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 12, 2017 at 11:23 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> This adds device tree bindings for the Faraday technology PCI
> Host Bridge. This IP is found in the Storlink/Storm/Cortina
> Gemini SoC platform.
>
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v4->v5:
> - No changes, just resend as everything else is rebased onto
>   v4.11-rc1.

Bjorn do you have any further comments or can we queue patch
1+2 of this series?

I want to submit the DTS patches to the ARM SoC tree, so I need
to be sure the bindings+driver are merge material first.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
