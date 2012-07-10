Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:16257
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751455Ab2GJPcD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jul 2012 11:32:03 -0400
Message-ID: <4FFC4AD0.3070201@freescale.com>
Date: Tue, 10 Jul 2012 10:31:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Shengzhou-B36685 <B36685@freescale.com>
CC: Wood Scott-B07421 <B07421@freescale.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] PCI: Add pcie_irq=other to enable non MSI/INTx interrupt
 for port service driver
References: <1341830970-12779-1-git-send-email-Shengzhou.Liu@freescale.com> <4FFB0927.7080406@freescale.com> <3F453DDFF675A64A89321A1F3528102176B4BF@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <3F453DDFF675A64A89321A1F3528102176B4BF@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/10/2012 01:13 AM, Liu Shengzhou-B36685 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Tuesday, July 10, 2012 12:39 AM
>> To: Liu Shengzhou-B36685
>> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH] PCI: Add pcie_irq=other to enable non MSI/INTx interrupt
>> for port service driver
>>
>> On 07/09/2012 05:49 AM, Shengzhou Liu wrote:
>>> On some platforms, in RC mode, root port has neither MSI/MSI-X nor
>>> INTx interrupt generated, which are available only in EP mode on those
>> platform.
>>> In this case, we try to use other interrupt if supported (i.e. there
>>> is the shared error interrupt on platform P1010, P3041, P4080, etc) to
>>> have AER, Hot-plug, etc, services to work.
>>>
>>> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
>>> ---
>>>  Documentation/kernel-parameters.txt |    4 ++++
>>>  drivers/pci/pcie/portdrv_core.c     |   19 +++++++++++++++++++
>>>  2 files changed, 23 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/Documentation/kernel-parameters.txt
>>> b/Documentation/kernel-parameters.txt
>>> index a92c5eb..af97c81 100644
>>> --- a/Documentation/kernel-parameters.txt
>>> +++ b/Documentation/kernel-parameters.txt
>>> @@ -2218,6 +2218,10 @@ bytes respectively. Such letter suffixes can also be
>> entirely omitted.
>>>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
>>>  			all PCIe root ports use INTx for all services).
>>>
>>> +	pcie_irq=	[PCIE] Native PCIe root port interrupt options:
>>> +		other	Try to use other interrupt when root port has
>>> +			neither MSI/MSI-X nor INTx support.
>>
>> Why does the user need to specify this?  Shouldn't this be a matter of
>> communication between kernel internals?
>>
> 
> The "other interrupt" appears a non-standard interrupt way compared to MSI/MSI-X and INTx in point of PCIe spec.

It still shouldn't be the user's responsibility to pass this in.

> The intent of specifying this is to have an intervention and
> confirmation manually to avoid causing unexpected issue on some
> unknown platforms.
>
> I'm glad to remove the specified kernel parameter if it would be accepted upstream.

Hopefully someone will comment if there is harm in doing this
unconditionally.  If there is, then we should handle this via a quirk or
similar mechanism.

-Scott

