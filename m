Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51067 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252Ab2ARSHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2012 13:07:05 -0500
Received: by yhoo21 with SMTP id o21so883279yho.19
        for <linux-pci@vger.kernel.org>; Wed, 18 Jan 2012 10:07:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7Awb97fn=bZECqaf4RF4Tmkh1_sUf6_Vk+jgv5jCYNTw@mail.gmail.com>
References: <20120118003335.467.71863.stgit@bhelgaas.mtv.corp.google.com>
	<20120118003512.467.60770.stgit@bhelgaas.mtv.corp.google.com>
	<CAE9FiQXvLAJVY-t8EJHkJgugtRsPdT9SS=60vA+by6qMCd5-Wg@mail.gmail.com>
	<CAErSpo7xgJmT=gs8axiY-OseyurqwUEqYixm692kmZAoA-2sNw@mail.gmail.com>
	<CAE9FiQUMEv+=mXzGc_muM_zTQ14S8tVex+bYgyyM1F++37Cu8w@mail.gmail.com>
	<CAErSpo7Awb97fn=bZECqaf4RF4Tmkh1_sUf6_Vk+jgv5jCYNTw@mail.gmail.com>
Date: Wed, 18 Jan 2012 10:07:04 -0800
Message-ID: <CAE9FiQWTE2fqe7q1KepBNT9MwW0z9+FoJeN8=caYsZ6RYj_QJw@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: restrict subordinate buses to those reachable
 via host bridge
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 18, 2012 at 9:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> your patches should be ok, only exception should be considered: some
>> default link root bus could access
>> out of bus range state with _CRS stating.  some kind of transparent
>> bridge concept.
>
> I'm afraid I couldn't make any sense out of the paragraph above.  If
> we don't have any information about host bridge bus number windows
> (for example, for bridges not described in ACPI), I think we'll have
> to default to [bus 00-ff].  That's effectively what these patches
> already do.  We only build the struct pci_host_bridge for ACPI
> bridges, so the check I added in pci_add_new_bus() does nothing for
> non-ACPI bridges.
>
> If you're suggesting that we need to add some exception (a
> "transparent bridge concept"?), can you clarify or suggest a patch?

for example: acpi said one peer root bus should be in [0,20) : the default link.
other peer root bus could be [80,a0).
chipset will route bus other than [80,a0) all to default link.

One transparent bridge 00:1c.0 will have 10:00.0 and 10:01.0

10:01.0 is cardbus bridge, if it states with bus [1e-22).

bus  20-22 still can be accessible.

Thanks

Yinghai
