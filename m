Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbdEHNZJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 May 2017 09:25:09 -0400
Date: Mon, 8 May 2017 08:25:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Wei Yang <weiyang@linux.vnet.ibm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] PCI: Add has_mem64 for struct host_bridge
Message-ID: <20170508132504.GA18996@bhelgaas-glaptop.roam.corp.google.com>
References: <20170421050500.13957-1-yinghai@kernel.org>
 <20170421050500.13957-12-yinghai@kernel.org>
 <20170504230425.GC9648@bhelgaas-glaptop.roam.corp.google.com>
 <734dd5df-1be5-9f97-b373-358b70d0b107@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <734dd5df-1be5-9f97-b373-358b70d0b107@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 08, 2017 at 10:54:55AM +0200, Christian König wrote:
> Am 05.05.2017 um 01:04 schrieb Bjorn Helgaas:
> >I *think* this will be broken by the current implementation of
> >Christian's patch to enable a 64-bit host bridge window:
> >
> >   https://lkml.kernel.org/r/1493890270-1188-5-git-send-email-deathsimple@vodafone.de
> >
> >because pci_register_host_bridge() runs before we scan the bus, and
> >Christian's patch adds a quirk that runs when we enumerate the AMD
> >host bridge device.
> >
> >If we apply this and Christian's patch, I think we could end up with
> >a host bridge window above 4G, but with bridge->has_mem64 not set.
> Yes, indeed. I can adjust my patch, but I would prefer not to do so.
> 
> I don't completely understand the background of this change, but
> from what I know how the BIOS (at least on X86) allocates resources
> it doesn't sounds correct to me.
> 
> Maybe we just need a Sparc specific quirk here instead of changing
> the common logic?

There's nothing in Yinghai's patch that's conceptually Sparc-specific,
so I would prefer not to artificially tie it to Sparc.

One possibility would be to compute has_mem64 when we need it instead
of caching it.
