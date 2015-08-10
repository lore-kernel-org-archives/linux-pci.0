Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADaLNDk=+J_yOer1ferSCNb_xAC42ULtP2FyCLmYMwa+Gj=vfA@mail.gmail.com>
References: <20150724224258.GA23990@google.com> <CADaLNDmYZ=8XQt82W_H74QaOiX3UwkVxkE1_EWRgzhkG1boebw@mail.gmail.com>
 <CAErSpo549xfAnx62quCqGHh3DNay5Lfb6EhEG+4EXooEuueQFQ@mail.gmail.com>
 <CADaLNDn95H=g73DKWRsrB4SuWcf+-8mkepbwb_DC-sFsVkrk6g@mail.gmail.com>
 <20150728212944.GA12958@google.com> <CADaLNDkOLiyPmVC3VwpnbrfAKFmNwSVJKdChjQFdQqs7XP-Ddg@mail.gmail.com>
 <20150729012255.GA18606@google.com> <20150729155509.GA31170@google.com> <CADaLNDk=+J_yOer1ferSCNb_xAC42ULtP2FyCLmYMwa+Gj=vfA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 10 Aug 2015 11:18:23 -0500
Message-ID: <CAErSpo4VFh7rv81sCAG-eCXVyZh4ub8Trh-ntZhyfy7BzqTr5g@mail.gmail.com>
Subject: Re: X-Gene: Unhandled fault: synchronous external abort in pci_generic_config_read32
To: Duc Dang <dhdang@apm.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 31, 2015 at 12:00 PM, Duc Dang <dhdang@apm.com> wrote:
> On Wed, Jul 29, 2015 at 8:55 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Jul 28, 2015 at 08:22:55PM -0500, Bjorn Helgaas wrote:
>>> On Tue, Jul 28, 2015 at 02:50:39PM -0700, Duc Dang wrote:
>>
>>> > Do you have another PCIe card to try on the same reboot test on this board?
>>>
>>> I've seen this on at least two Mellanox cards.  I'm running similar tests
>>> on a different type of card now.
>>
>> FWIW, reboot tests on two machines with Mellanox cards failed, while the
>> same test on a machine with a different proprietary card succeeded.
>
> Thanks, Bjorn.
>
> I don't have the same Mellanox card as yours, but I will also run
> similar reboot test to see if I hit the same issue with my card.

Any more hints on this?  Nothing has changed on my end, so of course
I'm still seeing this, always on machines with Mellanox, and never on
other machines.  Could this be a hardware issue like a signal
integrity or margin issue?  I don't know where to go from here because
I'm not a hardware person, and I don't know anything to do in
software.

Bjorn
