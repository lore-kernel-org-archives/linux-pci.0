Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60859 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbLATVv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2015 14:21:51 -0500
Message-ID: <565DF34C.6030606@codeaurora.org>
Date: Tue, 01 Dec 2015 14:21:48 -0500
From: Christopher Covington <cov@codeaurora.org>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
	Sinan Kaya <okaya@codeaurora.org>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
CC: linux-pci@vger.kernel.org, timur@codeaurora.org, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: enable SERR# forwarding and role-based
 error reporting
References: <1445894704-28277-1-git-send-email-okaya@codeaurora.org> <20151201185157.GE9306@localhost>
In-Reply-To: <20151201185157.GE9306@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/01/2015 01:51 PM, Bjorn Helgaas wrote:
> [+cc Taku]

It looks to me like Bjorn intended to add Taku to the distribution list,
but accidentally left him off, so I'm adding him to the To field in this
reply.

Regards,
Christopher Covington

> Hi Sinan,
> 
> On Mon, Oct 26, 2015 at 05:25:02PM -0400, Sinan Kaya wrote:
>> A PCIe card behind a PCIe switch is unable to report its errors
>> when SERR# forwarding is not enabled on the PCIe switch's
>> secondary interface. This is required by the PCIe  spec. 
> 
> I think enabling SERR# forwarding is only "required by the spec" in
> the sense that bridges do not forward errors upstream unless the
> SERR# Enable bit is set, right?  So I would say this is just an
> ordinary enable bit in the bridge, not a special spec requirement.
> 
> The Linux AER code doesn't poll for errors; it assumes errors will be
> propagated upstream to the Root Port, where they will cause an
> interrupt, so I agree that it doesn't really make sense to enable AER
> for a device unless we also enable SERR# forwarding in all the bridges
> leading to it.
> 
> I assume this patch fixes a problem, e.g., errors reported by a device
> are not forwarded upstream, so AER never logs them, and with this
> patch, AER does log them?  I suppose we didn't notice this before
> because some firmware enables SERR# forwarding for us, but yours
> doesn't?
> 
>> This patch
>> enables SERR# forwarding and also cleans out compatibility
>> mode so that AER reporting is enabled.
>>
>> Tested with PEX8749-CA RDK.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/pci/pcie/aer/aerdrv_core.c | 56 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
>> index 9803e3d..acd22d7 100644
>> --- a/drivers/pci/pcie/aer/aerdrv_core.c
>> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
>> @@ -37,21 +37,75 @@ module_param(nosourceid, bool, 0);
>>  
>>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>  {
>> +	u8 header_type;
>> +	int pos;
>> +
>>  	if (pcie_aer_get_firmware_first(dev))
>>  		return -EIO;
>>  
>> -	if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR))
>> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>> +	if (!pos)
>>  		return -EIO;
>>  
>> +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
>> +
>> +	/* needs to be a bridge/switch */
>> +	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
>> +		u32 status;
>> +		u16 control;
>> +
>> +		/*
>> +		 * A switch will not forward ERR_ messages coming from an
>> +		 * endpoint if SERR# forwarding is not enabled.
>> +		 * AER driver is checking the errors at the root only.
>> +		 */
>> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
>> +		control |= PCI_BRIDGE_CTL_SERR;
>> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
> 
> Does this work for hot-added devices?  I don't see a path that calls
> pci_enable_pcie_error_reporting() for hot-added devices, so I don't
> know how the PCI_EXP_AER_FLAGS bits would get set for them.
> 
> Taku, we recently merged your patch: b07461a8e45b ("PCI/AER: Clear
> error status registers during enumeration and restore").  The
> changelog mentions errors recorded by hot-added devices.  Did you test
> AER on hot-added devices, or did you just notice that they recorded
> errors?
> 
> Do you think we could enable PCI_BRIDGE_CTL_SERR and set the
> PCI_EXP_AER_FLAGS bits from pci_init_capabilities()?  That path would
> work for all devices, whether present at boot or hot-added later.
> 
> I know the AER driver won't attach to the Root Port and set up its
> interrupts until after enumeration, so AER would be enabled before we
> set up an ISR for the AER interrupts and turn them on in the Root
> Port.  But I think any errors in the interim should be logged and
> shouldn't cause a problem.
> 
>> +		/*
>> +		 * Need to inform hardware that we support
>> +		 * Role-Based Error Reporting.
>> +		 */
>> +		pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &status);
>> +		status &= ~PCI_ERR_COR_ADV_NFAT;
>> +		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, status);
> 
> Let's do this in a separate patch.  The SERR# thing is related to
> propagating error messages upstream.  PCI_ERR_COR_ADV_NFAT is a bit
> different.
> 
> I don't understand all the implications of Role-Based Error Reporting.
> Can you include a pointer to the Linux code that comprehends it?
> It looks like the section 6.2.7 implementation note is relevant, but I
> don't understand it yet.
> 
> Do we need to pay attention to the Role-Based Error Reporting bit in
> the Device Capabilities register for any reason?  I guess maybe it
> doesn't matter because Role-Base Error Reporting appeared in PCIe 1.1,
> and the PCI_ERR_COR_ADV_NFAT bit was reserved prior to that, so it
> shouldn't do anything if we clear it.
> 
> Bjorn
> 
>> +	}
>> +
>>  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
>>  }
>>  EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>>  
>>  int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>>  {
>> +	int pos;
>> +	u8 header_type;
>> +
>>  	if (pcie_aer_get_firmware_first(dev))
>>  		return -EIO;
>>  
>> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>> +	if (!pos)
>> +		return -EIO;
>> +
>> +	pci_read_config_byte(dev, PCI_HEADER_TYPE, &header_type);
>> +
>> +	/* needs to be a bridge/switch */
>> +	if (header_type == PCI_HEADER_TYPE_BRIDGE) {
>> +		u32 status;
>> +		u16 control;
>> +
>> +		/* clear serr forwarding */
>> +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
>> +		control &= ~PCI_BRIDGE_CTL_SERR;
>> +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>> +
>> +		/* set compatibility mode */
>> +		pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, &status);
>> +		status |= PCI_ERR_COR_ADV_NFAT;
>> +		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, status);
>> +	}
>> +
>>  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>>  					  PCI_EXP_AER_FLAGS);
>>  }
>> -- 
>> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
