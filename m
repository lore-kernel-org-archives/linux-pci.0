Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8858 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756354AbbAPVYF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Jan 2015 16:24:05 -0500
Date: Fri, 16 Jan 2015 21:24:04 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Rajat Jain <rajatxjain@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] pci: Use hot-plug capable for testing presence on
In-Reply-To: <CAA93t1r==Ybtz=r-5gB7AiXgsCD4mqN=FwGK8yQSEgSCUT3+5A@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1501162052510.15481@localhost.lm.intel.com>
References: <1419275223-14602-1-git-send-email-keith.busch@intel.com> <20150116203330.GJ29776@google.com> <CAA93t1r==Ybtz=r-5gB7AiXgsCD4mqN=FwGK8yQSEgSCUT3+5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 16 Jan 2015, Rajat Jain wrote:
>> 2b3940b60626 ("PCI: pciehp: Remove a non-existent card, regardless of
>> "surprise" capability") made it so we handle unexpected loss of presence
>> detect even if the slot doesn't advertise Hot-Plug Surprise.  I suppose we
>> could make a similar argument that if a card shows up, maybe we should do
>> something with it regardless of what the slot advertises for Hot-Plug
>> Capable.
>
> Ummm ... may be not. From The PCI Hotplug Spec ver 1.1. section 2.2.2
> (Hot Insertion)
> ==================================================================
> A slot must be powered down and isolated from the bus before an add-in
> card can be
> inserted. The process of making a slot ready for insertion depends
> upon the particular
> Platform and operating system. The following general sequence of steps
> is necessary to
> insert an add-in card into a slot after it is powered down and ready
> for insertion:
>
> 1. The user inserts the new add-in card.
> 2. The user notifies the Hot-Plug Service to turn on the slot
> containing the new add-in
> card.
> 3. The Hot-Plug Service issues a Hot-Plug Primitive to the Hot-Plug
> System Driver to
> turn on the appropriate slot.
> ===============================================================
>
> Also, I recall I read somewhere in the specs about the need to use the
> button to initiate hot-plug. This change would make the button
> useless, no?
>
> I'm thinking the user may have reasons to have the card plugged-in,
> but not have it turned on. The card may be a back-up for example, to
> be turned on (to enable an alternate path) in case of some other card
> fails etc. Or may be other application reasons. Thoughts?

Maybe I need to try this on an add-in card. I'm using front-loading
SFF devices which don't have attention buttons. I would have expected
these slots to have the hot-plug surprise capability set, but there's
enough platforms in existnace that don't have it set, but can handle
add events just fine otherwise. So while this patch fixes that scenario,
I don't want to break others.
