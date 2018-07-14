Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeGNHdm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Jul 2018 03:33:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 14 Jul 2018 12:45:38 +0530
From: poza@codeaurora.org
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Enable SERR# forwarding in non ACPI flow
In-Reply-To: <BL0PR02MB4849D9F256912CC9B869A20EA5580@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1531406719-18606-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <b5ba83a0fd8694905528f740a186b891@codeaurora.org>
 <BL0PR02MB4849D9F256912CC9B869A20EA5580@BL0PR02MB4849.namprd02.prod.outlook.com>
Message-ID: <3bd31b729f9f335fcd906a8164c0a4cb@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-13 19:25, Bharat Kumar Gogada wrote:
>> > Currently PCI_BRIDGE_CTL_SERR is being enabled only in ACPI flow.
>> > This bit is required for forwarding errors reported by EP devices to
>> > upstream device.
>> > This patch enables SERR# for Type-1 PCI device.
>> >
>> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>> > ---
>> >  drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
>> >  1 files changed, 23 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c index
>> > a2e8838..943e084 100644
>> > --- a/drivers/pci/pcie/aer.c
>> > +++ b/drivers/pci/pcie/aer.c
>> > @@ -343,6 +343,19 @@ int pci_enable_pcie_error_reporting(struct
>> > pci_dev
>> > *dev)
>> >  	if (!dev->aer_cap)
>> >  		return -EIO;
>> >
>> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
>> > +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> > +		u16 control;
>> > +
>> > +		/*
>> > +		 * A Type-1 PCI bridge will not forward ERR_ messages
>> coming
>> > +		 * from an endpoint if SERR# forwarding is not enabled.
>> > +		 */
>> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
>> &control);
>> > +		control |= PCI_BRIDGE_CTL_SERR;
>> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>> > +	}
>> > +
>> >  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
>> > PCI_EXP_AER_FLAGS);  }
>> > EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>> > @@ -352,6 +365,16 @@ int pci_disable_pcie_error_reporting(struct
>> > pci_dev *dev)
>> >  	if (pcie_aer_get_firmware_first(dev))
>> >  		return -EIO;
>> >
>> > +	if (!IS_ENABLED(CONFIG_ACPI) &&
>> > +	    dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
>> > +		u16 control;
>> > +
>> > +		/* Clear SERR Forwarding */
>> > +		pci_read_config_word(dev, PCI_BRIDGE_CONTROL,
>> &control);
>> > +		control &= ~PCI_BRIDGE_CTL_SERR;
>> > +		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
>> > +	}
>> > +
>> >  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
>> >  					  PCI_EXP_AER_FLAGS);
>> >  }
>> 
>> 
>> Should this configuration no be set by Firmware ? why should Linux 
>> dictate it
>> ?
> Hi Oza, Can you please let us know why this should be set by firmware ?
> Spec clearly states ERR_CORR,ERR_FATAL/NON FATAL will be forwarded
> only if this bit is set.
> If linux AER service is being enabled without checking/setting this
> bit, then AER service will
> not do anything even ERR_* is seen on link.
> 
> Regards,
> Bharat


The ERR_* to be forwarded or not to be forwarded could be decision of 
the platform.
hence I think it is best left to firmware to decide if it want to enable 
this for particular platform.

although,
There are 2 cases
Hotplug capable bridge and otherwise.

1) If Firmware sets them, I do not think during enumeraion linux will 
loose those settings.

2) I do not see any integration of hotplug with AER currently, so if the 
PCIe switch is plugged into Hotplug
capable RP, I am not very sure if this functions get called.

Keith, Lukas and Bjorn any comments ?

Regards,
Oza.
