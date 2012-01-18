Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65262 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947Ab2ARHvi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2012 02:51:38 -0500
Received: by ghbg16 with SMTP id g16so2795141ghb.19
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2012 23:51:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120118003512.467.60770.stgit@bhelgaas.mtv.corp.google.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
	<20120118003512.467.60770.stgit@bhelgaas.mtv.corp.google.com>
Date: Tue, 17 Jan 2012 23:51:35 -0800
Message-ID: <CAE9FiQXvLAJVY-t8EJHkJgugtRsPdT9SS=60vA+by6qMCd5-Wg@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: restrict subordinate buses to those reachable
 via host bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 17, 2012 at 4:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> When we scan the bus behind a bridge (pci_scan_bridge()), we sometimes
> ignore any bus numbers assigned by the BIOS and try to assign our own
> bus numbers.  But this can only work if the new bus number is inside
> the range reachable via the host bridge.
>
> This patch prevents us from creating a new bus under the wrong host
> bridge.  (Obviously, if the arch doesn't tell the PCI core about the
> host bridge configuration, we can't detect this problem, so this check
> is only useful if the arch uses pci_scan_host_bridge() or similar.)
>
> Here's a sample problem scenario:
>
>    ACPI: PCI Root Bridge [VP18] (domain 0000 [bus 30-32])
>    pci 0000:30:1e.0: PCI bridge to [bus 33-ff]
>    pci 0000:33:00.0: PCI bridge to [bus 34-34]
>    pci 0000:34:00.0: reg 10: [mem 0xe6100000-0xe613ffff 64bit]
>    ACPI: PCI Root Bridge [VP10] (domain 0000 [bus 33-34])
>
> We silently reconfigured 30:1e.0 (changing its subordinate buses from
> [bus 31] to [bus 33-ff]) because the bridge looked "broken."  Devices on
> bus 33 exist, but they are reached via the VP10 host bridge, *not* VP18.
>
> The 33:00.0 resources must be allocated from VP10 host bridge windows,
> not from VP18 windows.  We mistakenly think 33:00.0 is under VP18, so
> we reallocate its resources from VP18 windows, and the device no longer
> works.
>
> Reference: https://bugzilla.novell.com/show_bug.cgi?id=735909

looked at that bug:
it is hw bug that will hard-wired some pri bus number to 00.
(BIOS or OS can not write to PRIMARY BUS bits)

right way could be use quirk to assume primary equal to bus->number to
pass the valid checking.

Thanks

Yinghai
