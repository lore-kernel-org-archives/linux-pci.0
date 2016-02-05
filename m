Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:52041 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbcBEOvq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2016 09:51:46 -0500
Subject: Re: [PATCH v8 2/2] add new platform driver for PCI RC
To: Arnd Bergmann <arnd@arndb.de>, Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1454600622.git.jpinto@synopsys.com>
 <20160204234334.GH7031@localhost> <56B47D0D.5030204@synopsys.com>
 <4427983.0G6mVNKP5W@wuerfel>
CC: Bjorn Helgaas <helgaas@kernel.org>, <Vineet.Gupta1@synopsys.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B4B6FB.1040500@synopsys.com>
Date: Fri, 5 Feb 2016 14:51:39 +0000
MIME-Version: 1.0
In-Reply-To: <4427983.0G6mVNKP5W@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/5/2016 2:39 PM, Arnd Bergmann wrote:
> On Friday 05 February 2016 10:44:29 Joao Pinto wrote:
>> Hi,
>>
>> On 2/4/2016 11:43 PM, Bjorn Helgaas wrote:
>>>> What do you think?
>>>
>>> I don't think the "dw" part is relevant (none of the other
>>> DesignWare-based drivers includes it in the driver or file name).
>>>
>>> How do people typically refer to this board?
>>>
>>> I really like "synopsys" because it fits the pattern of being
>>> recognizable and pronounceable like "altera", "designware", "qcom",
>>> "keystone", "layerscape", "tegra", etc.  But I can't tell whether it's
>>> too generic.
>>>
>>> "ipk" or "haps" would be fine with me.  I think it's OK if it doesn't
>>> cover 100% of the possible systems.
>>
>> I think we should follow the iproc example: pcie-iproc-platform.c
>> In this case we would have pcie-designware-platform.c
>> I think this would be the best name because the driver is a non soc specific
>> designware platform driver.
>>
>> Arnd and Bjorn agree on this name?
> 
> Sorry, I did not realize that your submission was for the generic dw-pcie
> implementation rather than a particular product integrating it.
> 

It is a driver that is useful for PCIe RC prototyping and to be a reference
platform driver for DesignWare PCIe RC, I don't know if merging some of the
driver's code into pcie-designware is really necessary depends on the usefulness
of it. I would suggest that bigger step to be done in a 2nd stage since I will
be around to maintain what's necessary. Agree?

I made a patch that is applicable to Bjorn's host/pcie-synopsys that tries to
match your suggestions and Bjorn's. Could you please comment check it?

> I think in this case, we should do this completely differently:
> 
> How about putting all the new code into drivers/pci/host/pcie-designware.c
> as functions that can be used by the other drivers in absence of a chip
> specific handler?
> 
> Instead of providing a new instance of struct pcie_host_ops, maybe add
> it as a default implementation in dw_pcie_link_up() and dw_pcie_host_init()
> for drivers that don't provide their own. "hisi_pcie_host_ops" currently
> provides no host_init() callback function, so you will have to change
> the hisi frontend to a provide nop-function.
> 
> For all other drivers, check if they can be changed to use your generic
> implementation and remove their private callbacks if possible.
> 
> I think the MSI implementation should be split out into a separate file
> though, as not everyone uses this.
> 
> 	Arnd
> 

Joao


