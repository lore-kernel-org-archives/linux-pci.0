Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6887 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdJ3Dya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2017 23:54:30 -0400
Subject: Re: [PATCH 03/12] PCI: tegra: Retrain link for Gen2 speed
To: Vidya Sagar <vidyas@nvidia.com>, <thierry.reding@gmail.com>,
        <bhelgaas@google.com>, <jonathanh@nvidia.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>
References: <1509132569-9398-1-git-send-email-mmaddireddy@nvidia.com>
 <1509132569-9398-4-git-send-email-mmaddireddy@nvidia.com>
 <c8dc3a6e-21f2-a7bd-6a2f-5e14f7976dbf@nvidia.com>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <84b3fca4-54a0-63bc-fe67-95e73cee0cbf@nvidia.com>
Date: Mon, 30 Oct 2017 09:21:57 +0530
MIME-Version: 1.0
In-Reply-To: <c8dc3a6e-21f2-a7bd-6a2f-5e14f7976dbf@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 29-Oct-17 3:04 PM, Vidya Sagar wrote:
> 
> 
> On Saturday 28 October 2017 12:59 AM, Manikanta Maddireddy wrote:
>> Tegra124, 132, 210 and 186 supports Gen2 link speed. After the link is up
>> in Gen1, set target link speed as Gen2 and retrain link. Link switches to
>> Gen2 speed if Gen2 capable end point is connected, else link stays in Gen1.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   drivers/pci/host/pci-tegra.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>> index 2c64eb6cc3cc..15df60e13a14 100644
>> --- a/drivers/pci/host/pci-tegra.c
>> +++ b/drivers/pci/host/pci-tegra.c
>> @@ -232,6 +232,8 @@
>>   #define PADS_REFCLK_CFG_PREDI_SHIFT        8  /* 11:8 */
>>   #define PADS_REFCLK_CFG_DRVI_SHIFT        12 /* 15:12 */
>>   +#define LINK_RETRAIN_TIMEOUT HZ
>> +
>>   struct tegra_msi {
>>       struct msi_controller chip;
>>       DECLARE_BITMAP(used, INT_PCI_MSI_NR);
>> @@ -2133,6 +2135,42 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>>       }
>>   }
>>   +static void tegra_pcie_change_link_speed(struct tegra_pcie *pcie,
>> +        struct pci_dev *pci_dev)
>> +{
>> +    struct device *dev = pcie->dev;
>> +    unsigned long start_jiffies;
>> +    unsigned short val;
>> +
>> +    /* Skip if the current device is not a root port */
>> +    if (pci_pcie_type(pci_dev) != PCI_EXP_TYPE_ROOT_PORT)
>> +        return;
>> +
>> +    pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL2, &val);
>> +    val &= ~PCI_EXP_LNKSTA_CLS;
>> +    val |= PCI_EXP_LNKSTA_CLS_5_0GB;
>> +    pcie_capability_write_word(pci_dev, PCI_EXP_LNKCTL2, val);
>> +
>> +    /* Retrain the link */
>> +    pcie_capability_read_word(pci_dev, PCI_EXP_LNKCTL, &val);
>> +    val |= PCI_EXP_LNKCTL_RL;
>> +    pcie_capability_write_word(pci_dev, PCI_EXP_LNKCTL, val);
>> +
>> +    start_jiffies = jiffies;
>> +    for (;;) {
>> +        pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &val);
>> +        if (!(val & PCI_EXP_LNKSTA_LT))
>> +            break;
>> +        if (time_after(jiffies, start_jiffies + LINK_RETRAIN_TIMEOUT))
>> +            break;
>> +        usleep_range(2000, 3000);
>> +    }
>> +
>> +    if (val & PCI_EXP_LNKSTA_LT)
>> +        dev_err(dev, "link retrain of PCIe slot %u failed\n",
>> +                PCI_SLOT(pci_dev->devfn));
>> +}
>> +
>>   static const struct tegra_pcie_soc tegra20_pcie = {
>>       .num_ports = 2,
>>       .msi_base_shift = 0,
>> @@ -2334,6 +2372,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>>       struct pci_host_bridge *host;
>>       struct tegra_pcie *pcie;
>>       struct pci_bus *child;
>> +    struct pci_dev *pci_dev = NULL;
>>       int err;
>>         host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>> @@ -2399,6 +2438,9 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>>         pci_bus_add_devices(host->bus);
>>   +    for_each_pci_dev(pci_dev)
>> +        tegra_pcie_change_link_speed(pcie, pci_dev);
>> +
> Why can't we loop over only root ports using 'pcie->ports' like how it is done in tegra_pcie_enable_ports() ?
It can be done, but I chose use to pci subsystem calls & register defines so that it is easy understand.
>>       if (IS_ENABLED(CONFIG_DEBUG_FS)) {
>>           err = tegra_pcie_debugfs_init(pcie);
>>           if (err < 0)
> 
