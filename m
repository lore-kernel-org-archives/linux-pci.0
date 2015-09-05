Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46501 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbbIEUNO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 5 Sep 2015 16:13:14 -0400
Message-ID: <55EB4CD8.8080405@redhat.com>
Date: Sat, 05 Sep 2015 16:13:12 -0400
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, Duc Dang <dhdang@apm.com>
CC: Tanmay Inamdar <tinamdar@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in pci_generic_config_read32
References: <20150724224258.GA23990@google.com> <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com> <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com> <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com> <20150728212944.GA12958@google.com> <CADaLNDkOLiyPmVC3VwpnbrfAKFmNwSVJKdChjQFdQqs7XP-Ddg@mail.gmail.com> <20150729012255.GA18606@google.com> <20150729155509.GA31170@google.com> <CADaLNDk=+J_yOer1ferSCNb_xAC42ULtP2FyCLmYMwa+Gj=vfA@mail.gmail.com> <CAErSpo4VFh7rv81sCAG-eCXVyZh4ub8Trh-ntZhyfy7BzqTr5g@mail.gmail.com> <CADaLNDkUQHzGACfFmYDeJWnaNrKmJUDx4Rby60OWr4FzOjx3rA@mail.gmail.com> <CAErSpo7aDYKwy4MC6ZPf7hNd4MPE-LARiOVKutFfDFFkHY7qjQ@mail.gmail.com> <CADaLNDmnnZOoB1fxO=rQQa-eqT=B9G24rUrN_GzwAkFoC3Acbw@mail.gmail.com> <CAErSpo59jH3qeqThG-OO_dqB0fU5gmgC89Xued5QKrbB0dt2yg@mail.gmail.com>
In-Reply-To: <CAErSpo59jH3qeqThG-OO_dqB0fU5gmgC89Xued5QKrbB0dt2yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/11/2015 03:28 PM, Bjorn Helgaas wrote:
> On Mon, Aug 10, 2015 at 2:07 PM, Duc Dang <dhdang@apm.com> wrote:
>> On Mon, Aug 10, 2015 at 10:42 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Mon, Aug 10, 2015 at 12:16 PM, Duc Dang <dhdang@apm.com> wrote:
>>>> On Monday, August 10, 2015, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>>>
>>>>> On Fri, Jul 31, 2015 at 12:00 PM, Duc Dang <dhdang@apm.com> wrote:
>>>>>> On Wed, Jul 29, 2015 at 8:55 AM, Bjorn Helgaas <bhelgaas@google.com>
>>>>>> wrote:
>>>>>>> On Tue, Jul 28, 2015 at 08:22:55PM -0500, Bjorn Helgaas wrote:
>>>>>>>> On Tue, Jul 28, 2015 at 02:50:39PM -0700, Duc Dang wrote:
>>>>>>>
>>>>>>>>> Do you have another PCIe card to try on the same reboot test on this
>>>>>>>>> board?
>>>>>>>>
>>>>>>>> I've seen this on at least two Mellanox cards.  I'm running similar
>>>>>>>> tests
>>>>>>>> on a different type of card now.
>>>>>>>
>>>>>>> FWIW, reboot tests on two machines with Mellanox cards failed, while
>>>>>>> the
>>>>>>> same test on a machine with a different proprietary card succeeded.
>>>>>>
>>>>>> Thanks, Bjorn.
>>>>>>
>>>>>> I don't have the same Mellanox card as yours, but I will also run
>>>>>> similar reboot test to see if I hit the same issue with my card.
>>>>>
>>>>> Any more hints on this?  Nothing has changed on my end, so of course
>>>>> I'm still seeing this, always on machines with Mellanox, and never on
>>>>> other machines.  Could this be a hardware issue like a signal
>>>>> integrity or margin issue?  I don't know where to go from here because
>>>>> I'm not a hardware person, and I don't know anything to do in
>>>>> software.
>>>>
>>>>
>>>> Hi Bjorn,
>>>>
>>>> I tried to run similar reboot tests on 2 different Mellanox cards (Connect-X
>>>> family, one card has 2 10G interfaces, the other one has 1 port that
>>>> supports InfiniBand) with U-Boot 1.15.12 and linux 4.2-rc5 and I did not see
>>>> the crash that you encounterred.
>>>>
>>>> Did you check if your Mellanox cards have latest firmware? I did see some
>>>> link issues on my Mellanox cards with its old firmware before.
>>>
>>> Good idea; I'll check that, too.  Also, I just learned that these
>>> cards on installed with an extender card because of some space issues,
>>> so we're going to test again without the extender.
>>
>> Hi Bjorn,
>>
>> Are other cards that passed your test installed directly to the
>> on-board PCIe slot?
>> If yes, then this is a good data point and it will be useful to test
>> the case where
>> your Mellanox cards are directly installed into the on-board PCIe slot.
> 
> The cards that passed the test were installed directly, with  no
> extender.  We removed the extender from one of the machines with the
> Mellanox card and have not seen this issue since then.  I think it's
> very likely that the problem is related to using the extender.

If you're trying to use Mellanox cards in (for example) an APM Mustang
like system with a PCIe extender card (for example a 90 degree angle
adjustment for a low profile server case), you might want to ping me
offline. I have procured a number of these over the past couple of years
for my home lab and have found one that works (almost) reliably on that
particular hardware platform and does 10G in my home lab.

Jon.


