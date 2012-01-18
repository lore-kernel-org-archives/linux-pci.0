Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56531 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932111Ab2ARQwu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Jan 2012 11:52:50 -0500
Received: by lahc1 with SMTP id c1so2337826lah.19
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 08:52:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXvLAJVY-t8EJHkJgugtRsPdT9SS=60vA+by6qMCd5-Wg@mail.gmail.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
 <20120118003512.467.60770.stgit@bhelgaas.mtv.corp.google.com> <CAE9FiQXvLAJVY-t8EJHkJgugtRsPdT9SS=60vA+by6qMCd5-Wg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 18 Jan 2012 09:52:25 -0700
Message-ID: <CAErSpo7xgJmT=gs8axiY-OseyurqwUEqYixm692kmZAoA-2sNw@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: restrict subordinate buses to those reachable
 via host bridge
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2012 at 12:51 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, Jan 17, 2012 at 4:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> When we scan the bus behind a bridge (pci_scan_bridge()), we sometimes
>> ignore any bus numbers assigned by the BIOS and try to assign our own
>> bus numbers.  But this can only work if the new bus number is inside
>> the range reachable via the host bridge.
>>
>> This patch prevents us from creating a new bus under the wrong host
>> bridge.  (Obviously, if the arch doesn't tell the PCI core about the
>> host bridge configuration, we can't detect this problem, so this check
>> is only useful if the arch uses pci_scan_host_bridge() or similar.)
>>
>> Here's a sample problem scenario:
>>
>>    ACPI: PCI Root Bridge [VP18] (domain 0000 [bus 30-32])
>>    pci 0000:30:1e.0: PCI bridge to [bus 33-ff]
>>    pci 0000:33:00.0: PCI bridge to [bus 34-34]
>>    pci 0000:34:00.0: reg 10: [mem 0xe6100000-0xe613ffff 64bit]
>>    ACPI: PCI Root Bridge [VP10] (domain 0000 [bus 33-34])
>>
>> We silently reconfigured 30:1e.0 (changing its subordinate buses from
>> [bus 31] to [bus 33-ff]) because the bridge looked "broken."  Devices on
>> bus 33 exist, but they are reached via the VP10 host bridge, *not* VP18.
>>
>> The 33:00.0 resources must be allocated from VP10 host bridge windows,
>> not from VP18 windows.  We mistakenly think 33:00.0 is under VP18, so
>> we reallocate its resources from VP18 windows, and the device no longer
>> works.
>>
>> Reference: https://bugzilla.novell.com/show_bug.cgi?id=735909
>
> looked at that bug:
> it is hw bug that will hard-wired some pri bus number to 00.
> (BIOS or OS can not write to PRIMARY BUS bits)
>
> right way could be use quirk to assume primary equal to bus->number to
> pass the valid checking.

The Novell bugzilla is not public, so for discussion purposes, here's
the patch you're proposing:

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7cc9e2f..1e255c8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -651,6 +651,10 @@ int __devinit pci_scan_bridge(struct pci_bus
*bus, struct pci_dev *dev, int max,
 	dev_dbg(&dev->dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
 		secondary, subordinate, pass);

+	/* some bridge primary bus is hard wired to 0 */
+	if (!primary && (primary != bus->number) && secondary && subordinate)
+		primary = bus->number;
+
 	/* Check if setup is sensible at all */
 	if (!pass &&
 	    (primary != bus->number || secondary <= bus->number)) {


The bridge in question is 30:1e.0.  It has its primary bus number
hard-wired to 0 (not 30 as one would expect), and BIOS sets its
secondary == subordinate == 31.  The current code in pci_scan_bridge()
decides the bridge is "broken" because primary (0) != bus->number
(30).

I like your idea.  It might be better to use a quirk to avoid the
reconfiguration we do in the "broken" case.  Then we'd simply scan bus
31, as the BIOS configured it, find nothing, and be finished.  We
wouldn't change the bridge's secondary/subordinate bus numbers as we
do with my patches.

If we go that route, though, I'd prefer something specific to this
hardware and packaged as an actual fixup in drivers/pci/quirks.c.
pci_scan_bridge() is already a hodge-podge of hacks for issues that
are now lost and forgotten, and I don't like the idea of adding more.
It just makes it too difficult to maintain.

If we make a quirk for this machine, we still have the question of
what to do with my patches.  I assert that if Linux ever reconfigures
any bus numbers or does any configuration of hot-added P2P bridges, it
must pay attention to the host bridge bus number window.  Therefore, I
think we need something like this series even if we make a quirk.

Bjorn
