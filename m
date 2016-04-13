Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in
 pci_generic_config_read32
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20150724224258.GA23990@google.com>
 <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
 <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
 <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
 <20150728212944.GA12958@google.com>
 <CAPKp9ub7KDCvK_hhJWR4LfFGqBkYGtD2Pb8cLsd_7bQ4bK3j2w@mail.gmail.com>
 <20160413132101.GA22699@localhost>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Duc Dang <dhdang@apm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <570E49AB.1090509@arm.com>
Date: Wed, 13 Apr 2016 14:29:15 +0100
MIME-Version: 1.0
In-Reply-To: <20160413132101.GA22699@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 13/04/16 14:21, Bjorn Helgaas wrote:
> On Wed, Apr 13, 2016 at 10:58:18AM +0100, Sudeep Holla wrote:
>> Hi,
>>
>> (sorry for replying on the old thread, but I found it could be related
>> to the issue
>> I have now)
>>
>> On Tue, Jul 28, 2015 at 10:29 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

[...]

>>>>
>>>> Our latest U-Boot is 1.15.15, but U-Boot 1.15.12 is already a good
>>>> version to use. Are you running any PCIe traffic test when the error
>>>> happens?
>>>
>>> Nope, the machine was either idle or running a reboot test; no PCIe stress
>>> test or anything.
>>>
>>
>> Was there any conclusion on this ?
>> I am having similar issue[1] on my Juno with sky2 PCIe driver during reboot.
>
> We found that the unhandled faults occurred when using an extender
> card.  After removing the extender card, we didn't see the faults any
> more.
>

Thanks for the response. It's not related then, I saw report referencing
reboot tests and hence linked them together. Sorry for the noise.

-- 
Regards,
Sudeep

>> [1] http://marc.info/?l=linux-netdev&m=146046999701956&w=2
