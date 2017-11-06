Return-Path: <SRS0=4I1z=CE=ti.com=j-keerthy@kernel.org>
Return-Path: <SRS0=4I1z=CE=ti.com=j-keerthy@kernel.org>
Subject: Re: [PATCH v4] pci: dwc: dra7xx: Add shutdown handler to cleanly turn
 off clocks
To: Niklas Cassel <nks.gnu@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: <kishon@ti.com>, <bhelgaas@google.com>, <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <1505885055-30657-1-git-send-email-j-keerthy@ti.com>
 <20171011193207.GO25517@bhelgaas-glaptop.roam.corp.google.com>
 <CAD5ja62_fT+xg6G_ygN+8GScMYa62M7jNEoDxD89n7AUBjwPDw@mail.gmail.com>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <4ab0e697-b23b-0cc6-6ffa-8479e07c5aed@ti.com>
Date: Mon, 6 Nov 2017 10:34:28 +0530
MIME-Version: 1.0
In-Reply-To: <CAD5ja62_fT+xg6G_ygN+8GScMYa62M7jNEoDxD89n7AUBjwPDw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>



On Friday 03 November 2017 08:00 PM, Niklas Cassel wrote:
> dra7xx_pcie_shutdown should be static.
> 
> This patch introduces a new sparse warning.

Thanks Niklas for reporting.

Bjorn,

Should i send a next version or just a fix patch on top of this?

Regards,
Keerthy

> 
> On Wed, Oct 11, 2017 at 9:32 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Wed, Sep 20, 2017 at 10:54:15AM +0530, Keerthy wrote:
>>> Add shutdown handler to cleanly turn off clocks. This will help
>>> in cases of kexec where in a new kernel can boot abruptly.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Applied to pci/host-dra7xx for v4.15, thanks!
>>
>>> ---
>>>
>>> Changes in v4:
>>>
>>>   * Added the missing changes from v2!
>>>
>>> Changes in v3:
>>>
>>>   * Pushed the function outside #ifdef CONFIG_PM_SLEEP.
>>>   * Added more details to commit log.
>>>
>>> Changes in v2:
>>>
>>>   * used a local dev pointer instead of dereferencing dev at multiple places.
>>>   * dra7xx_pcie_stop_link before disabling clks in the shutdown path.
>>>
>>>  drivers/pci/dwc/pci-dra7xx.c | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
>>> index 34427a6..d084800 100644
>>> --- a/drivers/pci/dwc/pci-dra7xx.c
>>> +++ b/drivers/pci/dwc/pci-dra7xx.c
>>> @@ -794,6 +794,22 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
>>>  }
>>>  #endif
>>>
>>> +void dra7xx_pcie_shutdown(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
>>> +     int ret;
>>> +
>>> +     dra7xx_pcie_stop_link(dra7xx->pci);
>>> +
>>> +     ret = pm_runtime_put_sync(dev);
>>> +     if (ret < 0)
>>> +             dev_dbg(dev, "pm_runtime_put_sync failed\n");
>>> +
>>> +     pm_runtime_disable(dev);
>>> +     dra7xx_pcie_disable_phy(dra7xx);
>>> +}
>>> +
>>>  static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
>>>       SET_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend, dra7xx_pcie_resume)
>>>       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(dra7xx_pcie_suspend_noirq,
>>> @@ -807,5 +823,6 @@ static int dra7xx_pcie_resume_noirq(struct device *dev)
>>>               .suppress_bind_attrs = true,
>>>               .pm     = &dra7xx_pcie_pm_ops,
>>>       },
>>> +     .shutdown = dra7xx_pcie_shutdown,
>>>  };
>>>  builtin_platform_driver_probe(dra7xx_pcie_driver, dra7xx_pcie_probe);
>>> --
>>> 1.9.1
>>>
