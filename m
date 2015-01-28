Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:55671 "EHLO smtp-o-3.desy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755248AbbA2B04 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 28 Jan 2015 20:26:56 -0500
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
	by smtp-o-3.desy.de (DESY-O-3) with ESMTP id A9570280322
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 08:51:38 +0100 (CET)
Received: from ZITSWEEP2.win.desy.de (zitsweep2.win.desy.de [131.169.97.96])
	by smtp-map-3.desy.de (DESY_MAP_3) with ESMTP id 9A77A10DF
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2015 08:51:37 +0100 (MET)
Message-ID: <54C89508.3080001@desy.de>
Date: Wed, 28 Jan 2015 08:51:36 +0100
From: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Paulo Fortuna Carvalho <pricardofc@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Hot add a PCIe device driver upon hotplug event
References: <CAH9N0t9KvhzmZDgD8PD5VBPR-pPhuE8MmBgK9RY8+ZtKyz++pQ@mail.gmail.com> <CAErSpo48mPENuHpES1Q73ep+NKG8x2Zgb+g71do02y7vufbtfQ@mail.gmail.com> <CAH9N0t8s+kcG_Qok0wpoDz9jzwvPk_QmBK_p-qbACZJjrr+iVQ@mail.gmail.com> <CAErSpo7NK6S8Dk3-FYFV=AVPR8cLRzmAWrBNQ2rke0BRADxAKw@mail.gmail.com> <CAH9N0t-+gog9wNFo7hqhzrWuttrRyf5HjjHciFrDGz1rZUiUfw@mail.gmail.com> <20150122222016.GF13072@google.com> <CAH9N0t_YoRZtPqWwAaNdHNW3m-HOfrCevBZGiOnM+VWGxeFwEQ@mail.gmail.com> <CAErSpo4bRnGkfmzLnGSUnv-aJfmZLtQ_jXhnZo+9Wm=CgHOB3A@mail.gmail.com> <54C5EF11.8070604@desy.de> <CAErSpo4EeEAA-ci1EfSKNijUJA_4uLMu+WU7ORpQPeR9T9Rr8g@mail.gmail.com>
In-Reply-To: <CAErSpo4EeEAA-ci1EfSKNijUJA_4uLMu+WU7ORpQPeR9T9Rr8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

yes this that are refer, more detailed version was in previous Workshop
https://indico.desy.de/getFile.py/access?contribId=5&sessionId=1&resId=0&materialId=slides&confId=7866
and additionally was presentation about driver part
https://indico.desy.de/getFile.py/access?contribId=32&sessionId=9&resId=0&materialId=slides&confId=10329

I hope this will help and may be I will get some feedback to improve
both and fix bugs

Cheers

Ludwig

On 01/27/2015 05:50 PM, Bjorn Helgaas wrote:
> Hi Ludwig,
>
> Thanks a lot for the pointers to MTCA information.  I found
> presentation slides here:
> https://indico.desy.de/getFile.py/access?contribId=33&sessionId=0&resId=1&materialId=slides&confId=10329,
> which I assume is that you're referring to.
>
> On Mon, Jan 26, 2015 at 1:38 AM, Ludwig Petrosyan
> <ludwig.petrosyan@desy.de> wrote:
>> Hello
>>
>> (I have send this email two days ago but got status undeliverable, so try to
>> send it again)
>>
>> We had the same problem on the MTCA system years ago, but now the problem is
>> solved.
>> The MTCA system is a kind of ATCA and I think attention Button problem could
>> be solved in the same way.
>> Ok, now what we have done:
>> First of all the main difference of the ATCA or MTCA PCIe system is what the
>> PCIe Switch which responsible for the HotPlug
>>
>> (I mean Switch which is connected to the crate slots, and hotplug
>> controllers of this are used in hotpluging ) and the Attention Button of the
>>
>> PCIe slot reside on the different boards (usually PCIe Switch is on the
>> Crate Manager  board and Attention Button is  the AMC module Latch ),
>>
>> So there are no any wired connections between Attention Button and PCIe
>> Switch. Than user pool out the AMC module Latch the PCIe Switch has no idea
>>
>> about that, BUT the AMC module controller (MMC) sends IPMI message to the
>> Crate Management Controller (MCMC)
>> and MCMC starts AMC powering down procedures. The idea was: usually MCMC and
>> PCIe Switch reside on the same board and MCMC getting IPMI message
>>
>> about state change of the AMC Latch (latch polled out or pressed) set
>> appropriate registers of the PCIe Switch or push high appropriate lines of
>> the PCIe Switch
>>
>> and PCIe Switch gets information that Attention Button is pressed and send
>> hotplug interrupt to the hotplug driver.
>> This approach works in our MTCA systems and we have a full working PCIe
>> HotPlug.
> It sounds like you basically have some IPMI glue between the the AMC
> latch and the PCIe Attention Button, and from the point of view of the
> pciehp (PCIe native hotplug) driver, it just sees a normal Attention
> Button.  That sounds like a reasonable thing to do.
>
> In Paulo's case, it sounds like there is some sort of switch related
> to the card, but the IPMI or similar glue that could potentially lead
> to the Attention Button line doesn't exist.  In that case, pciehp
> doesn't know anything about the switch.  If there's some other way,
> e.g., IPMI, to learn about the switch, maybe that could be done via a
> separate driver.
>
>> More detailed information one can get to look documents of the MTCA Workshop
>> (http://mtcaws.desy.de/) in tutorial section was presentation about
>>
>> PCIe Hotplug, or look in PICMIG recommendation (there is new recommendation
>> about PCIe HotPlug for MTC.4)
>>
>> With best regards
>>
>> Ludwig Petrosyan
>>
>>

