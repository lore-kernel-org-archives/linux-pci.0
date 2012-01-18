Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56239 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932200Ab2ARRqu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Jan 2012 12:46:50 -0500
Received: by lahc1 with SMTP id c1so2372213lah.19
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 09:46:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUMEv+=mXzGc_muM_zTQ14S8tVex+bYgyyM1F++37Cu8w@mail.gmail.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
 <20120118003512.467.60770.stgit@bhelgaas.mtv.corp.google.com>
 <CAE9FiQXvLAJVY-t8EJHkJgugtRsPdT9SS=60vA+by6qMCd5-Wg@mail.gmail.com>
 <CAErSpo7xgJmT=gs8axiY-OseyurqwUEqYixm692kmZAoA-2sNw@mail.gmail.com> <CAE9FiQUMEv+=mXzGc_muM_zTQ14S8tVex+bYgyyM1F++37Cu8w@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 18 Jan 2012 10:46:28 -0700
Message-ID: <CAErSpo7Awb97fn=bZECqaf4RF4Tmkh1_sUf6_Vk+jgv5jCYNTw@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: restrict subordinate buses to those reachable
 via host bridge
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2012 at 10:27 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jan 18, 2012 at 8:52 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> If we make a quirk for this machine, we still have the question of
>> what to do with my patches.  I assert that if Linux ever reconfigures
>> any bus numbers or does any configuration of hot-added P2P bridges, it
>> must pay attention to the host bridge bus number window.  Therefore, I
>> think we need something like this series even if we make a quirk.
>
> We may need more smart way to find unused bus range instead of just
> just max+1 and ++max.
>
> For example:  one bridge (A) have two child bridges (B and C),
> A: bus range: 10-2f
> B: bus range: 11-1f
> C: bus range: 20-2f
>
> when some broken case happen, B bus BIOS assigned bus range will be
> all cleared in first pass.
> but C bus is ok.  but in second bus, bus will be assigned to 30- .
> that is totally wrong, We should still
> try to use bus 11-1f at first for bus B.

Yes, I agree we may need a better way to choose bus numbers in the
first place.  My current patch (3/4) doesn't change how we choose
them; it only rejects invalid ones.

> your patches should be ok, only exception should be considered: some
> default link root bus could access
> out of bus range state with _CRS stating.  some kind of transparent
> bridge concept.

I'm afraid I couldn't make any sense out of the paragraph above.  If
we don't have any information about host bridge bus number windows
(for example, for bridges not described in ACPI), I think we'll have
to default to [bus 00-ff].  That's effectively what these patches
already do.  We only build the struct pci_host_bridge for ACPI
bridges, so the check I added in pci_add_new_bus() does nothing for
non-ACPI bridges.

If you're suggesting that we need to add some exception (a
"transparent bridge concept"?), can you clarify or suggest a patch?

Bjorn
