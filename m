Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44914 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbcDMRE7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 13:04:59 -0400
Subject: Re: [PATCH 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
To: Thierry Reding <thierry.reding@gmail.com>
References: <1457452094-5409-1-git-send-email-thierry.reding@gmail.com>
 <56E98F2E.5010307@wwwdotorg.org> <20160413162203.GB30129@ulmo.ba.sec>
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
Message-ID: <570E7C38.3070005@wwwdotorg.org>
Date: Wed, 13 Apr 2016 11:04:56 -0600
MIME-Version: 1.0
In-Reply-To: <20160413162203.GB30129@ulmo.ba.sec>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/13/2016 10:22 AM, Thierry Reding wrote:
> On Wed, Mar 16, 2016 at 10:51:58AM -0600, Stephen Warren wrote:
>> On 03/08/2016 08:48 AM, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> Changes to the pad controller device tree binding have required that
>>> each lane be associated with a separate PHY.
>>
>> I still don't think this has anything to do with DT bindings. Rather, the
>> definition of a PHY (in HW and the Linux PHY subsystem) is a single lane.
>> That fact then requires drivers to support a PHY per lane rather than a
>> single multi-lane PHY, and equally means the DT bindings must be written
>> according to the correct definition of a PHY.
>>
>> Still, I suppose the commit description is fine as is.
>
> I've reworded the commit message to give a more accurate rationale for
> the change. I'll be posting a v5 soon.
>
>>> Update the PCI host bridge
>>> device tree binding to allow each root port to define the list of PHYs
>>> required to drive the lanes associated with it.
>>
>>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>>
>>> +Required properties for Tegra124 and later:
>>> +- phys: Must contain an phandle to a PHY for each entry in phy-names.
>>> +- phy-names: Must include an entry for each active lane. Note that the number
>>> +  of entries does not have to (though usually will) be equal to the specified
>>> +  number of lanes in the nvidia,num-lanes property. Entries are of the form
>>> +  "pcie-N": where N ranges from 0 to the value specified in nvidia,num-lanes.
>>
>> When would the number of PHYs not equal the number of lanes? I thought the
>> whole point of this patch was to switch to per-lane PHYs? Perhaps I'm just
>> misremembering some exception, so there may be no need to change this.
>
> This is useful to support the case where we want to connect a x1 or x2
> device to a root port that is configured to drive more lanes. It's a
> rather unusual configuration, but it would be possible for example to
> have an onboard x1 ethernet card, but the board layout is such that it
> runs in x1/x2 mode, with the ethernet card connected to the x2 port.

Does the controller HW actually work correctly in such a mode?

Obviously a fully initialized x4 controller has to correctly handle 
being attached solely to a x1 device. However, that's a different case 
to simply not initializing 3 of the 4 PHYs. It's plausible the 
controller handles this just fine, or that it hangs up or otherwise 
misbehaves if some of the PHYs aren't enabled and hence it can't even 
detect whether something is attached to them or not. Either way, adding 
your explanation into the binding would be useful to highlight the 
reason for the special case.
