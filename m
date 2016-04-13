Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44882 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbcDMRCC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 13:02:02 -0400
Subject: Re: [PATCH v3 2/2] PCI: tegra: Support per-lane PHYs
To: Thierry Reding <thierry.reding@gmail.com>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <1457452094-5409-2-git-send-email-thierry.reding@gmail.com>
 <56E9915F.9040608@wwwdotorg.org> <20160413160112.GA30129@ulmo.ba.sec>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <570E7B86.1040909@wwwdotorg.org>
Date: Wed, 13 Apr 2016 11:01:58 -0600
MIME-Version: 1.0
In-Reply-To: <20160413160112.GA30129@ulmo.ba.sec>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/13/2016 10:01 AM, Thierry Reding wrote:
> On Wed, Mar 16, 2016 at 11:01:19AM -0600, Stephen Warren wrote:
>> On 03/08/2016 08:48 AM, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> The current XUSB pad controller bindings are insufficient to describe
>>> PHY devices attached to USB controllers. New bindings have been created
>>> to overcome these restrictions. As a side-effect each root port now is
>>> assigned a set of PHY devices, one for each lane associated with the
>>> root port. This has the benefit of allowing fine-grained control of the
>>> power management for each lane.
>>
>>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>>
>>> +static int tegra_pcie_port_phy_power_on(struct tegra_pcie_port *port)
>>> +{
>>> +	struct device *dev = port->pcie->dev;
>>> +	unsigned int i;
>>> +	int err;
>>> +
>>> +	for (i = 0; i < port->lanes; i++) {
>>> +		err = phy_power_on(port->phys[i]);
>>
>> This assume the number of array entries is precisely the number of lanes.
>> That seems to contradict the binding update which said the number might not
>> match. Perhaps there's an expectation that phy_power_on() is a no-op for
>> some "invalid" values like NULL or an error-pointer value? But...
>>
>>> +static struct phy *devm_of_phy_optional_get_index(struct device *dev,
>>> +						  struct device_node *np,
>>> +						  const char *consumer,
>>> +						  unsigned int index)
>>> +{
>>> +	struct phy *phy;
>>> +	char *name;
>>> +
>>> +	name = kasprintf(GFP_KERNEL, "%s-%u", consumer, index);
>>> +	if (!name)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	phy = devm_of_phy_get(dev, np, name);
>>> +	kfree(name);
>>> +
>>> +	if (IS_ERR(phy) && PTR_ERR(phy) == -ENODEV)
>>> +		phy = NULL;
>>> +
>>> +	return phy;
>>> +}
>>
>> The error-handling there looks wrong. The function generally returns either
>> a valid PHY or an error pointer. However, in the case of -ENODEV, NULL is
>> returned. Subsystems are supposed to encode their handles as, and functions
>> are supposed to return, either NULL or an error pointer for error cases, not
>> both/either. Is the PHY API broken in this regard? If so, then this code is
>> fine, but if not it might need a fix.
>
> This function mimics phy_optional_get() which similarily returns NULL
> for -ENODEV. The remainder of the PHY API treats NULL pointers as
> "dummy" PHYs and returns early. I think that's a sensible approach to
> handling optional resources.
>
> It might have been more obvious had I implemented this function within
> phy-core.c, but I didn't think it universally useful because it uses a
> rather uncommon lookup pattern. I did keep a generic name in case it's
> ever deemed useful outside of this driver, at which point it could
> simply be moved into phy-core.c without requiring this driver to
> change.

Ah OK, so if a caller of this function is expected to only use IS_ERR(), 
and hence treat NULL as a perfectly valid PHY value, and all the PHY 
APIs deal with NULL correctly, then this is probably OK.

