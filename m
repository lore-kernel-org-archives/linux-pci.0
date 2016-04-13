Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44642 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbcDMWRz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 Apr 2016 18:17:55 -0400
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in
 pci_generic_config_read32
To: Sudeep Holla <sudeep.holla@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <20150724224258.GA23990@google.com>
 <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
 <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
 <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
 <20150728212944.GA12958@google.com>
 <CAPKp9ub7KDCvK_hhJWR4LfFGqBkYGtD2Pb8cLsd_7bQ4bK3j2w@mail.gmail.com>
 <20160413132101.GA22699@localhost> <570E49AB.1090509@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Duc Dang <dhdang@apm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <570EC58C.8070705@jonmasters.org>
Date: Wed, 13 Apr 2016 18:17:48 -0400
MIME-Version: 1.0
In-Reply-To: <570E49AB.1090509@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/13/2016 09:29 AM, Sudeep Holla wrote:
> 
> 
> On 13/04/16 14:21, Bjorn Helgaas wrote:
>> On Wed, Apr 13, 2016 at 10:58:18AM +0100, Sudeep Holla wrote:
>>> Hi,
>>>
>>> (sorry for replying on the old thread, but I found it could be related
>>> to the issue
>>> I have now)
>>>
>>> On Tue, Jul 28, 2015 at 10:29 PM, Bjorn Helgaas <bhelgaas@google.com>
>>> wrote:
> 
> [...]
> 
>>>>>
>>>>> Our latest U-Boot is 1.15.15, but U-Boot 1.15.12 is already a good
>>>>> version to use. Are you running any PCIe traffic test when the error
>>>>> happens?
>>>>
>>>> Nope, the machine was either idle or running a reboot test; no PCIe
>>>> stress
>>>> test or anything.
>>>>
>>>
>>> Was there any conclusion on this ?
>>> I am having similar issue[1] on my Juno with sky2 PCIe driver during
>>> reboot.
>>
>> We found that the unhandled faults occurred when using an extender
>> card.  After removing the extender card, we didn't see the faults any
>> more.
>>
> 
> Thanks for the response. It's not related then, I saw report referencing
> reboot tests and hence linked them together. Sorry for the noise.

For the record, I've had success with this cable on X-Gene:

http://www.amazon.com/PCI-E-Riser-Flexible-Ribbon-Extension/dp/B00H8VVD00?ie=UTF8&psc=1&redirect=true&ref_=oh_aui_search_detailpage

But it's hit or miss. The only public platform where I've been reliably
able to use an extender cable so far is AMD Seattle. On that platform,
the PCIe IP is so rock solid that I can talk to very funky PCIe IP I've
implemented myself in a FPGA (and I can see link quality is fine too).

There's one other non-public platform so far where PCIe extenders work
without a single hitch as well, and a number where more work is needed.

Jon.

-- 
Computer Architect

