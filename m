Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1blp0182.outbound.protection.outlook.com ([207.46.163.182]:38667
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751243AbaEVXkG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 May 2014 19:40:06 -0400
Message-ID: <537E8ACF.6000103@amd.com>
Date: Thu, 22 May 2014 18:39:59 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>
CC: Robert Richter <rric@kernel.org>,
	Daniel J Blueman <daniel@numascale.com>,
	Andreas Herrmann <herrmann.der.user@googlemail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Aravind Gopalakrishnan" <Aravind.Gopalakrishnan@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH V5 3/4] x86/PCI: Stop enabling ECS for AMD CPUs after
 Fam16h
References: <20140521231615.26447.38060.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140521231817.26447.55150.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140521233802.GA21575@pd.tnic>
 <CAErSpo4hcitey+jtZkgpbZsEswJJekStXONct9rrh0aQ_R0h8g@mail.gmail.com>
 <20140522191746.GL4383@pd.tnic>
 <CAErSpo7=0-xdnu4DQufu_6eS=6AYhnDRaQvzeiMEC5a=zKU0Jg@mail.gmail.com>
In-Reply-To: <CAErSpo7=0-xdnu4DQufu_6eS=6AYhnDRaQvzeiMEC5a=zKU0Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/22/2014 3:20 PM, Bjorn Helgaas wrote:
> On Thu, May 22, 2014 at 1:17 PM, Borislav Petkov <bp@alien8.de> wrote:
>> On Thu, May 22, 2014 at 11:56:03AM -0600, Bjorn Helgaas wrote:
>>> I chose Fam16h (0x16) because it looks like that's the newest stuff
>>> that's in the field. I suspect things would probably work if we
>>> changed this patch to leave ECS disabled on some Fam16h, Fam15h, etc.,
>>> but that would change behavior on existing systems, which obviously
>>> adds some risk. I didn't think there was much benefit that makes the
>>> risk worthwhile.
>>>
>>> My goal is to stop needing CPU-specific changes in the future, not
>>> necessarily to remove the CPU-specific code we already have.
>>>
>>> Does that make sense? I'm not sure whether I understood your real
>>> question.
>>
>> No, you got it right. I'm just wondering why only the newest stuff.
>> MMCONFIG is supposed to work just fine on everything from Fam10h
>> onwards, I'm not sure all Fam10h supported it though. Maybe Suravee can
>> verify that...
>
> Even if MMCONFIG does work fine on everything from Fam10h onwards, we
> still depend on the BIOS to provide a correct MCFG table.  I don't
> think we can guarantee that changing from ECS to MMCONFIG on a Fam16h
> box in the field is safe, because we'd then be using a feature we've
> never used before.
>
> Bjorn
>

At this point, family11h and later (upto 16h which is our most current 
processor) should already have supports for the MCFG. However, we can't 
guarantee that all the systems currently out there would not use the 
ECS. So, I think it is ok to say we won't support it post 16h as Bjorn 
suggests.

Suravee
