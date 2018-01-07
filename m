Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50054.outbound.protection.outlook.com ([40.107.5.54]:37312
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751481AbeAGHDL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Jan 2018 02:03:11 -0500
Subject: Re: [PATCH next 1/3] pci: Report PCI device link status
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>
References: <1514993062-7328-1-git-send-email-talgi@mellanox.com>
 <1514993062-7328-2-git-send-email-talgi@mellanox.com>
 <20180103235728.GA189897@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <cb6a2cb8-18d6-2399-744f-8e906d542f7b@mellanox.com>
Date: Sun, 7 Jan 2018 09:03:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180103235728.GA189897@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for the quick feedback. Will fix and send V2 ASAP.

On 1/4/2018 1:57 AM, Bjorn Helgaas wrote:
> Hi Tal,
> 
> s/pci: Report PCI device link status/
>    PCI: Add pcie_print_link_status()/
> 
> But I think maybe this could be split into two patches (one to get the
> caps and another for the status/warning bit), and then the title would
> change.  But please preserve the "PCI: " styling to match the
> convention.
> 
> On Wed, Jan 03, 2018 at 05:24:20PM +0200, Tal Gilboa wrote:
>> Add a function for querying and verifying a PCI device link
>> status. The PCI speed and width are reported in kernel log.
>> In case the PCI device went up with non-maximized speed/width,
>> a warning would be reported in kernel log.
>>
>> This would allow for a generic way for all PCI devices to
>> report status and issues in the same manner, instead of each
>> device reporting in a different place, using different code.
> 
> I like the idea of this a lot.
> 
>> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
>> Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
>> Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
>> ---
>>   drivers/pci/pci.c             | 107 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci.h           |   3 ++
>>   include/uapi/linux/pci_regs.h |   1 +
>>   3 files changed, 111 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 4a7c686..f8499ba 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5050,6 +5050,113 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
>>   EXPORT_SYMBOL(pcie_get_minimum_link);
>>   
>>   /**
>> + * pcie_get_link_caps - queries for the PCI device's link speed and width
>> + *			capabilities.
>> + * @dev: PCI device to query
>> + * @speed: storage for link speed
>> + * @width: storage for link width
>> + *
>> + * This function queries the PCI device speed and width capabilities.
>> + */
>> +int pcie_get_link_caps(struct pci_dev *dev, enum pci_bus_speed *speed,
>> +		       enum pcie_link_width *width)
>> +{
>> +	u32 lnkcap1, lnkcap2;
>> +	int err1, err2;
>> +
>> +	*speed = PCI_SPEED_UNKNOWN;
>> +	*width = PCIE_LNK_WIDTH_UNKNOWN;
>> +
>> +	err1 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP,
>> +					  &lnkcap1);
>> +	err2 = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2,
>> +					  &lnkcap2);
>> +
>> +	if (err1 && err2)
>> +		return err1;
>> +
>> +	if (!err2 && lnkcap2) { /* PCIe r3.0-compliant */
>> +		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
>> +			*speed = PCIE_SPEED_8_0GT;
>> +		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
>> +			*speed = PCIE_SPEED_5_0GT;
>> +		else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
>> +			*speed = PCIE_SPEED_2_5GT;
>> +	}
>> +	if (!err1 && lnkcap1) {
>> +		*width = (lnkcap1 & PCI_EXP_LNKCAP_MLW) >>
>> +				PCI_EXP_LNKCAP_MLW_SHIFT;
>> +		if (*speed == PCI_SPEED_UNKNOWN) { /* pre-r3.0 */
>> +			if (lnkcap1 & PCI_EXP_LNKCAP_SLS_8_0GB)
>> +				*speed = PCIE_SPEED_8_0GT;
>> +			else if (lnkcap1 & PCI_EXP_LNKCAP_SLS_5_0GB)
>> +				*speed = PCIE_SPEED_5_0GT;
>> +			else if (lnkcap1 & PCI_EXP_LNKCAP_SLS_2_5GB)
>> +				*speed = PCIE_SPEED_2_5GT;
>> +		}
>> +	}
> 
> There are several copies of this code:
> 
>    drm_pcie_get_speed_cap_mask()
>    cxgb4_get_pcie_dev_link_caps()
>    mlx4_get_pcie_dev_link_caps()
>    qla24xx_pci_info_str()
>    pcie_speeds() (in drivers/infiniband/hw/hfi1/pcie.c)
>    max_link_speed_show()
>    max_link_width_show()
> 
> so it's great to clean this up.  The version in max_link_speed_show()
> is simpler (it doesn't need PCI_EXP_LNKCAP2) and looks sufficient to
> me.  I *think* something like this should be enough:
> 
>    u32 lnkcap;
> 
>    pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> 
>    if (!lnkcap) {
>      *speed = PCI_SPEED_UNKNOWN;
>      *width = PCIE_LNK_WIDTH_UNKNOWN;
>      return;
>    }
> 
>    switch (lnkcap & PCI_EXP_LNKCAP_SLS) {
>    case PCI_EXP_LNKCAP_SLS_2_5GB:
>      *speed = PCIE_SPEED_2_5GT;
>      break;
>    case PCI_EXP_LNKCAP_SLS_5_0GB:
>      *speed = PCIE_SPEED_5_0GT;
>      break;
>    case PCI_EXP_LNKCAP_SLS_8_0GB:
>      *speed = PCIE_SPEED_8_0GT;
>      break;
>    default:
>      *speed = PCI_SPEED_UNKNOWN;
>    }
> 
>    *width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
> 
> Prior to PCIe r3.0, only PCI_EXP_LNKCAP_SLS_2_5GB and
> PCI_EXP_LNKCAP_SLS_5_0GB were defined.
> 
> PCIe r3.0 renamed the Link Capabilities "Supported Link Speeds" to
> "Max Link Speed", and made the bits refer to the new Supported Link
> Speeds Vector in Link Capabilities 2.  But the mapping is such that
> PCI_EXP_LNKCAP_SLS_2_5GB refers to SLSV bit 0 (still 2.5GT/s),
> PCI_EXP_LNKCAP_SLS_5_0GB refers to SLSV bit 1 (still 5.0GT/s), and
> PCI_EXP_LNKCAP_SLS_8_0GB refers to SLSV bit 2 (now 8.0GT/s).
> 
> So I don't think there's really anything new to be learned by reading
> Link Capabilities 2.  Or am I missing something?
> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(pcie_get_link_caps);
>>
>> +/**
>> + * pcie_print_link_status - Reports the PCI device's link speed and width.
>> + * @dev: PCI device to query
>> + *
>> + * This function will check the PCI device current speed and width are equal
>> + * to the maximum PCI device capabilities. Will issue a warning in cases
>> + * there's a mismatch between current status and maximum capabilities.
> 
> I need to think about this part.  As far as I can tell, the only
> reason to look up the link speed and width is to warn that the device
> might not be able to perform to its maximum capability.  Everything
> should still *work*, but possibly not as fast as expected.
> 
> I wonder if there's a way to do this automatically in the PCI core,
> without any driver interaction at all.  It would have to be a little
> less noisy than what you have here, e.g., we might be able to print
> one line to indicate sub-optimal situations.
> 
> The idea of pcie_get_minimum_link() seems a little suspect to me.
> Isn't it possible that an upstream link could be narrower but faster
> than the one directly connected to the endpoint?  In that case, the
> device might be able to work at full performance, and we wouldn't want
> to warn about the narrow upstream link.
> 
> So I'm not sure what to do here.  Maybe we can track the max available
> bandwidth (the combination of link width and speed) at each point in
> the hierarchy, and only warn if the device is capable of more than is
> available.
> 
> But if you split this into two patches and consolidate the
> pcie_get_link_caps() stuff, that would be a good start.
> 
>> + */
>> +void pcie_print_link_status(struct pci_dev *dev)
>> +{
>> +	enum pcie_link_width width, width_cap;
>> +	enum pci_bus_speed speed, speed_cap;
>> +	int err;
>> +
>> +	err = pcie_get_link_caps(dev, &speed_cap, &width_cap);
>> +	if (err) {
>> +		dev_warn(&dev->dev,
>> +			 "Warning: unable to determine PCIe device BW capabilities (err = %d)\n",
>> +			 err);
>> +		return;
>> +	}
>> +
>> +	err = pcie_get_minimum_link(dev, &speed, &width);
>> +	if (err) {
>> +		dev_warn(&dev->dev,
>> +			 "Warning: unable to determine PCIe device chain minimum BW (err = %d)\n",
>> +			 err);
>> +		return;
>> +	}
>> +
>> +	if (speed == PCI_SPEED_UNKNOWN)
>> +		dev_warn(&dev->dev,
>> +			 "Warning: unable to determine PCIe device chain minimum speed\n");
>> +	else if (speed != speed_cap)
>> +		dev_warn(&dev->dev,
>> +			 "Warning: PCIe speed is slower than device's capability\n");
>> +
>> +	if (width == PCIE_LNK_WIDTH_UNKNOWN)
>> +		dev_warn(&dev->dev,
>> +			 "Warning: unable to determine PCIe device chain minimum width\n");
>> +	else if (width != width_cap)
>> +		dev_warn(&dev->dev,
>> +			 "Warning: PCIe width is lower than device's capability\n");
>> +
>> +#define PCIE_SPEED2STR(speed) \
>> +	(speed == PCIE_SPEED_8_0GT ? "8.0GT/s" : \
>> +	 speed == PCIE_SPEED_5_0GT ? "5.0GT/s" : \
>> +	 speed == PCIE_SPEED_2_5GT ? "2.5GT/s" : \
>> +	 "Unknown")
>> +	dev_info(&dev->dev, "PCIe link speed is %s, device supports %s\n",
>> +		 PCIE_SPEED2STR(speed), PCIE_SPEED2STR(speed_cap));
>> +	dev_info(&dev->dev, "PCIe link width is x%d, device supports x%d\n",
>> +		 width, width_cap);
>> +}
>> +EXPORT_SYMBOL(pcie_print_link_status);
>> +
>> +/**
>>    * pci_select_bars - Make BAR mask from the type of resource
>>    * @dev: the PCI device for which BAR mask is made
>>    * @flags: resource type mask to be selected
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 978aad7..51845fc 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1080,6 +1080,9 @@ static inline int pci_is_managed(struct pci_dev *pdev)
>>   int pcie_set_mps(struct pci_dev *dev, int mps);
>>   int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
>>   			  enum pcie_link_width *width);
>> +int pcie_get_link_caps(struct pci_dev *dev, enum pci_bus_speed *speed,
>> +		       enum pcie_link_width *width);
>> +void pcie_print_link_status(struct pci_dev *dev);
>>   void pcie_flr(struct pci_dev *dev);
>>   int __pci_reset_function_locked(struct pci_dev *dev);
>>   int pci_reset_function(struct pci_dev *dev);
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 70c2b2a..a5f9aed 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -521,6 +521,7 @@
>>   #define  PCI_EXP_LNKCAP_SLS_5_0GB 0x00000002 /* LNKCAP2 SLS Vector bit 1 */
>>   #define  PCI_EXP_LNKCAP_SLS_8_0GB 0x00000003 /* LNKCAP2 SLS Vector bit 2 */
>>   #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
>> +#define  PCI_EXP_LNKCAP_MLW_SHIFT 4	   /* Start of MLW mask in link capabilities */
> 
> I wouldn't add this.  We have PCI_EXP_LNKCAP_MLW, which is enough for
> grep/cscope to find the related code.  And hopefully you'll reduce the
> number of places that use PCI_EXP_LNKCAP_MLW significantly.
> 
>>   #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
>>   #define  PCI_EXP_LNKCAP_L0SEL	0x00007000 /* L0s Exit Latency */
>>   #define  PCI_EXP_LNKCAP_L1EL	0x00038000 /* L1 Exit Latency */
>> -- 
>> 1.8.3.1
>>
