Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1527850145.28160.6.camel@mhfsdcap03>
Subject: Re: [PATCH v3] PCI: mediatek: Add system pm support for MT2712
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 Jun 2018 18:49:05 +0800
In-Reply-To: <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
References: <1527822270-30280-1-git-send-email-honghui.zhang@mediatek.com>
 <CAHp75VeBTmC=3nJ-t+OO9bp0mzJuTYsGBwi8fokT16bu2nE9RA@mail.gmail.com>
MIME-Version: 1.0
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
 Matthias Brugger <matthias.bgg@gmail.com>, ryder.lee@mediatek.com, "moderated
 list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 yong.wu@mediatek.com, Bjorn
 Helgaas <bhelgaas@google.com>, yingjoe.chen@mediatek.com,
 Arnd Bergmann <arnd.bergmann@linaro.org>,
 Eddie Huang <eddie.huang@mediatek.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-06-01 at 13:17 +0300, Andy Shevchenko wrote:
> On Fri, Jun 1, 2018 at 6:04 AM,  <honghui.zhang@mediatek.com> wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> > +#ifdef CONFIG_PM_SLEEP
> > +static int mtk_pcie_suspend_noirq(struct device *dev)
> 
> __maybe_unused
> 

Hi, Andy, thanks for your review.
Bjorn had point this out that at:
https://www.spinics.net/lists/arm-kernel/msg656774.html

So __maybe_unused is not really needed.

thanks



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
