Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37041 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965039AbcBCS50 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Feb 2016 13:57:26 -0500
Subject: Re: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
To: Bjorn Helgaas <helgaas@kernel.org>,
	Jake Oshins <jakeo@microsoft.com>
References: <1454434903-1680-1-git-send-email-jakeo@microsoft.com>
 <1454434903-1680-2-git-send-email-jakeo@microsoft.com>
 <20160203182528.GB10879@localhost>
 <DM2PR0301MB12328FC565D58EB8F995DECFABD00@DM2PR0301MB1232.namprd03.prod.outlook.com>
 <20160203185127.GE10879@localhost>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <56B24D93.4040202@arm.com>
Date: Wed, 3 Feb 2016 18:57:23 +0000
MIME-Version: 1.0
In-Reply-To: <20160203185127.GE10879@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/02/16 18:51, Bjorn Helgaas wrote:
> On Wed, Feb 03, 2016 at 06:32:20PM +0000, Jake Oshins wrote:
>>> -----Original Message-----
>>> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>>> Sent: Wednesday, February 3, 2016 10:25 AM
>>> To: Jake Oshins <jakeo@microsoft.com>
>>> Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
>>> kernel@vger.kernel.org; devel@linuxdriverproject.org; Haiyang Zhang
>>> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
>>> bhelgaas@google.com; linux-pci@vger.kernel.org
>>> Subject: Re: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
>>>
>>> Hi Jake,
>>>
>>> On Tue, Feb 02, 2016 at 05:41:41PM +0000, jakeo@microsoft.com wrote:
> 
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h index
>>>> 27df4a6..cd05a8e 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -1515,6 +1515,10 @@ static inline int pci_get_new_domain_nr(void) {
>>>> return -ENOSYS; }
>>>>
>>>>  #include <asm/pci.h>
>>>>
>>>> +#ifndef pci_root_bus_fwnode
>>>> +#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
>>>
>>> Huh, interesting.  This is new for me; I guess the idea is that we at least
>>> evaluate "bus" even when pci_root_bus_fwnode isn't defined, so the
>>> compiler can catch egregious errors?
>>>
>>
>> This was a suggestion by Mark Zyngier.  It made the non-x86 architectures build benignly.  If you'd like it done differently, I'm open to suggestion.

I don't remember suggesting the use of the comma operator, but just to
check that pci_root_bus_fwnode wasn't previously defined.

> Something like "#define pci_root_bus_fwnode(bus) NULL" would be
> typical.  What I'm curious about is the use of the comma operator.
> I'm not opposed to it; I'm just trying to understand why it makes a
> difference.

I guess it flags the variable as used, and prevents an overly sensitive
compiler from being loud and obnoxious... Just a guess though.

	M.
-- 
Jazz is not dead. It just smells funny...
