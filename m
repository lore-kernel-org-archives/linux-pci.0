Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 13:17:06 +0300
Message-ID: <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
To: honghui.zhang@mediatek.com, Arnd Bergmann <arnd.bergmann@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree <devicetree@vger.kernel.org>,
 hongkun.cao@mediatek.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 sean.wang@mediatek.com, xinping.qian@mediatek.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yt.shen@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, ryder.lee@mediatek.com,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 yong.wu@mediatek.com, Bjorn Helgaas <bhelgaas@google.com>,
 yingjoe.chen@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>

> +#ifdef CONFIG_PM_SLEEP
> +static int mtk_pcie_suspend_noirq(struct device *dev)

__maybe_unused

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
