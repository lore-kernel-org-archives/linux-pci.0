Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH 1/2] PCI: save and restore device state during bus reset
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1472770801-30671-1-git-send-email-okaya@codeaurora.org>
 <20160913164205.GD4138@localhost>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f9a1ed53-f83c-1ab2-1679-b23b4a9f1843@codeaurora.org>
Date: Tue, 13 Sep 2016 13:22:42 -0400
MIME-Version: 1.0
In-Reply-To: <20160913164205.GD4138@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 9/13/2016 12:42 PM, Bjorn Helgaas wrote:
> 
> This comment is no longer correct (you don't leave the devices in
> power-on state).

Sorry about that, I can fix the comment.

> 
>> + */
>> +void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
>> +{
>> +	pci_bus_save_and_disable(dev->bus);
> 
> "dev" is a bridge, and dev->bus is the bus on the *primary* side of
> the bridge, so I think this saves and disables the bridge itself.
> Don't you want dev->subordinate here instead?

Yes, I need the subordinate. 

> 
>> +	pcibios_reset_secondary_bus(dev);
>> +	pci_bus_restore(dev->bus);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
>> +


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
