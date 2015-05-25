Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58983 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbbEYXg7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 May 2015 19:36:59 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id A3A695B
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2015 23:36:59 +0000 (UTC)
Received: from [10.16.186.145] (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4PNawKO002220
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2015 19:36:59 -0400
Message-ID: <5563B21A.8080504@redhat.com>
Date: Mon, 25 May 2015 19:36:58 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Linux PCI <linux-pci@vger.kernel.org>
Subject: Initial APCI root bus discovery vs. rescan
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During system init, acpi_pci_root_add() is called which uses ACPI information to
reserve memory and IO regions for PCI devices under the root bridge.

If I hot remove a device, by echo'ing 1 into its remove file, and then
rescanning the parent bus (in this case the same bridge discovered by
acpi_pci_root_add()) by echo'ing 1 into the rescan file, the code path calls

unsigned int pci_rescan_bus(struct pci_bus *bus)
{
        unsigned int max;

        max = pci_scan_child_bus(bus);
        pci_assign_unassigned_bus_resources(bus);
        pci_bus_add_devices(bus);

        return max;
}

which AFAICT does not take into account ACPI Memory and IO regions for devices
under the bridge.  Is there an obvious reason to do this?  Or is there some
other init required before I issue the rescan on the bus?

Or ... is this a bug?

FWIW, I am removing a PCI Serial port card by echo'ing 1 into its remove file
and then reinserting it by doing a rescan on the parent bus.  The card does not
come up with the same memory & IO as it initially had.  I would have expected
that it did come up with the same resources as the memory & IO are free... but
maybe that expectation is incorrect.

P.


P.
