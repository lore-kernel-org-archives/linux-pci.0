Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
References: <99B4C6BADD9E3241B25E52B02BA737C54127E3BF@DGGEMA505-MBS.china.huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 10:16:54 +0300
Message-ID: <CAHp75VfHfUCNKNun4-bb2BhwV6D9jg2+hzVjrDER+af0SrzqjA@mail.gmail.com>
Subject: Re: reply: [PATCH v3 1/2] PCI: kirin: Add MSI support
To: songxiaowei <songxiaowei@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "dimitrysh@google.com" <dimitrysh@google.com>,
 "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzhuangluan <suzhuangluan@hisilicon.com>,
 Wangbinghui <wangbinghui@hisilicon.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kongfei <kongfei@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 "xuwei \(O\)" <xuwei5@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 "chenyao \(F\)" <chenyao11@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 14, 2018 at 4:11 AM, songxiaowei <songxiaowei@hisilicon.com> wrote:

>> > +       int ret;
>> > +
>> > +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>
>> > +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
>> > +               if (pci->pp.msi_irq < 0) {
>> > +                       dev_err(&pdev->dev, "failed to get MSI IRQ
>> (%d)\n",
>> > +                               pci->pp.msi_irq);
>>
>> > +                       return -ENODEV;
>>
>> Why shadowing actual error code?
> [songxiaowei]  Sorry, I can't get your point about this, would you explain it for me.

platform_get_irq() returns either correct IRQ number or negative error code.
In the code above you shadow the actual error (as returned by that
call) by -ENODEV. Any reason why?

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
