Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1526030149-23985-2-git-send-email-chenyao11@huawei.com>
References: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
 <1526030149-23985-2-git-send-email-chenyao11@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 02:16:08 +0300
Message-ID: <CAHp75VfqfnTw6PkQq_sGeTe+RpV6iqNEf5JV1TQgpNhMk=VyeA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: kirin: Add MSI support
To: Yao Chen <chenyao11@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, dimitrysh@google.com,
 guodong.xu@linaro.org, linux-pci@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, suzhuangluan@hisilicon.com,
 wangbinghui@hisilicon.com, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>, kongfei@hisilicon.com,
 Rob Herring <robh+dt@kernel.org>, songxiaowei@hisilicon.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 12:15 PM, Yao Chen <chenyao11@huawei.com> wrote:
> Add support for MSI.


> +       int ret;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {

> +               pci->pp.msi_irq = platform_get_irq(pdev, 0);
> +               if (pci->pp.msi_irq < 0) {
> +                       dev_err(&pdev->dev, "failed to get MSI IRQ (%d)\n",
> +                               pci->pp.msi_irq);

> +                       return -ENODEV;

Why shadowing actual error code?

> +               }
> +               ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> +                                      kirin_pcie_msi_irq_handler,
> +                                      IRQF_SHARED | IRQF_NO_THREAD,
> +                                      "kirin_pcie_msi", &pci->pp);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
> +                               pci->pp.msi_irq);
> +                       return ret;
> +               }

It would be easy to read and maintain if this would be a separate function.

> +       }



-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
