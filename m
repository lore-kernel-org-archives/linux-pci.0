Return-Path: <SRS0=BEfK=5T=broadcom.com=oza.oza@kernel.org>
Return-Path: <SRS0=BEfK=5T=broadcom.com=oza.oza@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170612234344.GD4379@bhelgaas-glaptop.roam.corp.google.com>
References: <1497153938-26074-1-git-send-email-oza.oza@broadcom.com>
 <1497153938-26074-3-git-send-email-oza.oza@broadcom.com> <20170612234344.GD4379@bhelgaas-glaptop.roam.corp.google.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Wed, 14 Jun 2017 10:24:11 +0530
Message-ID: <CAMSpPPfVeN-RVHtLMLmduo+S8dNFMB0mn7sZRGSpJsfka+bu2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: iproc: add device shutdown for PCI RC
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
	BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 5:13 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sun, Jun 11, 2017 at 09:35:38AM +0530, Oza Pawandeep wrote:
>> PERST# must be asserted around ~500ms before
>> the reboot is applied.
>>
>> During soft reset (e.g., "reboot" from Linux) on some iProc based SoCs
>> LCPLL clock and PERST both goes off simultaneously.
>> This will cause certain Endpoints Intel NVMe not get detected, upon
>> next boot sequence.
>>
>> This happens because; Endpoint is expecting the clock for some amount of
>> time after PERST is asserted, which is not happening in our case
>> (Compare to Intel X86 boards, will have clocks running).
>> this cause NVMe to behave in undefined way.
>
> This doesn't smell right.  The description makes this sound like a
> band-aid that happens to "solve" a problem with one particular device.
> It doesn't sound like this is making iProc adhere to something in the
> PCIe spec.
>
> Is there some PCIe spec timing requirement that tells you about this
> 500ms number?  Please include the reference if so.

On chip PLL which sources the reference clock to the device gets reset
when soft reset is applied; the soft reset also asserts PERST#.
This simultaneous assertion of reset and clock being lost is a problem
with some NVME cards.
The delay is added to keep clock alive while PERST gets asserted.
The time delay number can be set to a number that will allow the NVME
device to go into reset state.
500 ms delay is picked for that reason only, which is long enough to
get EP into reset correctly.

>
>> Essentially clock will remain alive for 500ms with PERST# = 0
>> before reboot.
>
>> This patch adds platform shutdown where it should be
>> called in device_shutdown while reboot command is issued.
>>
>> So in sequence first Endpoint Shutdown (e.g. nvme_shutdown)
>> followed by RC shutdown is called, which issues safe PERST
>> assertion.
>>
>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>
>> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
>> index 90d2bdd..9512960 100644
>> --- a/drivers/pci/host/pcie-iproc-platform.c
>> +++ b/drivers/pci/host/pcie-iproc-platform.c
>> @@ -131,6 +131,13 @@ static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
>>       return iproc_pcie_remove(pcie);
>>  }
>>
>> +static void iproc_pcie_pltfm_shutdown(struct platform_device *pdev)
>> +{
>> +     struct iproc_pcie *pcie = platform_get_drvdata(pdev);
>> +
>> +     iproc_pcie_shutdown(pcie);
>> +}
>> +
>>  static struct platform_driver iproc_pcie_pltfm_driver = {
>>       .driver = {
>>               .name = "iproc-pcie",
>> @@ -138,6 +145,7 @@ static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
>>       },
>>       .probe = iproc_pcie_pltfm_probe,
>>       .remove = iproc_pcie_pltfm_remove,
>> +     .shutdown = iproc_pcie_pltfm_shutdown,
>>  };
>>  module_platform_driver(iproc_pcie_pltfm_driver);
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> index 05a3647..bb61376 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -608,32 +608,40 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
>>       .write = iproc_pcie_config_write32,
>>  };
>>
>> -static void iproc_pcie_reset(struct iproc_pcie *pcie)
>> +static void iproc_pcie_perst_ctrl(struct iproc_pcie *pcie, bool assert)
>>  {
>>       u32 val;
>>
>>       /*
>> -      * PAXC and the internal emulated endpoint device downstream should not
>> -      * be reset.  If firmware has been loaded on the endpoint device at an
>> -      * earlier boot stage, reset here causes issues.
>> +      * The internal emulated endpoints (such as PAXC) device downstream
>> +      * should not be reset. If firmware has been loaded on the endpoint
>> +      * device at an earlier boot stage, reset here causes issues.
>>        */
>>       if (pcie->ep_is_internal)
>>               return;
>>
>> -     /*
>> -      * Select perst_b signal as reset source. Put the device into reset,
>> -      * and then bring it out of reset
>> -      */
>> -     val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
>> -     val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
>> -             ~RC_PCIE_RST_OUTPUT;
>> -     iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
>> -     udelay(250);
>> -
>> -     val |= RC_PCIE_RST_OUTPUT;
>> -     iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
>> -     msleep(100);
>> +     if (assert) {
>> +             val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
>> +             val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
>> +                     ~RC_PCIE_RST_OUTPUT;
>> +             iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
>> +             udelay(250);
>> +     } else {
>> +             val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
>> +             val |= RC_PCIE_RST_OUTPUT;
>> +             iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
>> +             msleep(100);
>> +     }
>> +}
>> +
>> +int iproc_pcie_shutdown(struct iproc_pcie *pcie)
>> +{
>> +     iproc_pcie_perst_ctrl(pcie, true);
>> +     msleep(500);
>> +
>> +     return 0;
>>  }
>> +EXPORT_SYMBOL(iproc_pcie_shutdown);
>>
>>  static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
>>  {
>> @@ -1310,7 +1318,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>>               goto err_exit_phy;
>>       }
>>
>> -     iproc_pcie_reset(pcie);
>> +     iproc_pcie_perst_ctrl(pcie, true);
>> +     iproc_pcie_perst_ctrl(pcie, false);
>>
>>       if (pcie->need_ob_cfg) {
>>               ret = iproc_pcie_map_ranges(pcie, res);
>> diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
>> index 0bbe2ea..a6b55ce 100644
>> --- a/drivers/pci/host/pcie-iproc.h
>> +++ b/drivers/pci/host/pcie-iproc.h
>> @@ -110,6 +110,7 @@ struct iproc_pcie {
>>
>>  int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
>>  int iproc_pcie_remove(struct iproc_pcie *pcie);
>> +int iproc_pcie_shutdown(struct iproc_pcie *pcie);
>>
>>  #ifdef CONFIG_PCIE_IPROC_MSI
>>  int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node);
>> --
>> 1.9.1
>>
