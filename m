Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35537 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088AbbEZQHd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 12:07:33 -0400
Received: by iesa3 with SMTP id a3so95758841ies.2
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 09:07:32 -0700 (PDT)
Date: Tue, 26 May 2015 11:07:16 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Initial APCI root bus discovery vs. rescan
Message-ID: <20150526160716.GM32152@google.com>
References: <5563B21A.8080504@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5563B21A.8080504@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Prarit,

On Mon, May 25, 2015 at 07:36:58PM -0400, Prarit Bhargava wrote:
> During system init, acpi_pci_root_add() is called which uses ACPI information to
> reserve memory and IO regions for PCI devices under the root bridge.
> 
> If I hot remove a device, by echo'ing 1 into its remove file, and then
> rescanning the parent bus (in this case the same bridge discovered by
> acpi_pci_root_add()) by echo'ing 1 into the rescan file, the code path calls
> 
> unsigned int pci_rescan_bus(struct pci_bus *bus)
> {
>         unsigned int max;
> 
>         max = pci_scan_child_bus(bus);
>         pci_assign_unassigned_bus_resources(bus);
>         pci_bus_add_devices(bus);
> 
>         return max;
> }
> 
> which AFAICT does not take into account ACPI Memory and IO regions for devices
> under the bridge.  Is there an obvious reason to do this?  Or is there some
> other init required before I issue the rescan on the bus?
> 
> Or ... is this a bug?
>
> FWIW, I am removing a PCI Serial port card by echo'ing 1 into its remove file
> and then reinserting it by doing a rescan on the parent bus.  The card does not
> come up with the same memory & IO as it initially had.  I would have expected
> that it did come up with the same resources as the memory & IO are free... but
> maybe that expectation is incorrect.

It might be quicker if you posted the complete dmesg log, along with
pointers to the specific things that look wrong.

In this scenario, I assume the serial port device remains powered all the
time, even while it is logically removed from the system, so when we
re-enumerate and find the device, I would think its BARs would still
contain whatever they had before, and since they are still valid, we should
still use them.

So I think my expectation is the same as yours, and I don't know why it
doesn't work that way.  I assume the device actually *works* with the new
resources, so it's not really broken in that sense, but it does bother me
if we're changing something when we don't need to change it.

Bjorn
