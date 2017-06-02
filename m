Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:32929 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBC3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2017 22:29:01 -0400
Received: by mail-pf0-f173.google.com with SMTP id e193so43333127pfh.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Jun 2017 19:29:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <397e2b1a-c62f-2df2-5eca-8e240ac65df5@broadcom.com>
References: <1496294871-5836-1-git-send-email-oza.oza@broadcom.com>
 <1496294871-5836-3-git-send-email-oza.oza@broadcom.com> <397e2b1a-c62f-2df2-5eca-8e240ac65df5@broadcom.com>
From: Oza Oza <oza.oza@broadcom.com>
Date: Fri, 2 Jun 2017 07:58:59 +0530
Message-ID: <CAMSpPPdYqDYcSj09080RinzoM1rwDT9Zgtghry35kuXUGM4p8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: iproc: add device shutdown for PCI RC
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 1, 2017 at 11:41 PM, Ray Jui <ray.jui@broadcom.com> wrote:
> Hi Oza,
>
> On 5/31/17 10:27 PM, Oza Pawandeep wrote:
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
>>
>> Essentially clock will remain alive for 500ms with PERST# = 0
>> before reboot.
>>
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
>> index 05a3647..e9afc63 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -608,31 +608,38 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
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
>
> Please export the symbol here to fix the build issue detected by kbuild
> test when the iProc PCIe platform driver is compiled as a kernel module.
>

Will take care of this Ray, Thanks for pointing it out.

Regards,
Oza.

>>
>>  static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
>> @@ -1310,7 +1317,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
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
>>
