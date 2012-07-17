Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37289 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602Ab2GQRPN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2012 13:15:13 -0400
Received: by lbbgm6 with SMTP id gm6so879880lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 17 Jul 2012 10:15:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1342521498.3669.7.camel@pasglop>
References: <1342491799-30303-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1342491799-30303-6-git-send-email-shangw@linux.vnet.ibm.com>
 <20120717050547.GD2369@ram-ThinkPad-T61> <20120717052333.GE2369@ram-ThinkPad-T61>
 <20120717053648.GA18497@shangw> <20120717055715.GF2369@ram-ThinkPad-T61>
 <1342516619.3669.5.camel@pasglop> <20120717100314.GB25613@ram-ThinkPad-T61> <1342521498.3669.7.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 17 Jul 2012 11:14:51 -0600
Message-ID: <CAErSpo4AS=QCRE3w-QBzuuSSEK8VeQ+PXxyp3mTyDAEvASxQcQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] pci: resource assignment based on p2p alignment
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org,
	yinghai@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 17, 2012 at 4:38 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2012-07-17 at 18:03 +0800, Ram Pai wrote:
>>         Lets say we passed that 'type' flag to size the minimum
>>         alignment constraints for that b_res.  And window_alignment(bus,
>>         type) of your platform  used that 'type' information to
>>         determine whether to use the alignment constraints of 32-bit
>>         window or 64-bit window.
>>
>>         However, later when the b_res is actually allocated a resource,
>>         the pci_assign_resource() has no idea whether to allocate 32-bit
>>         window resource or 64-bit window resource, because the 'type'
>>         information is not captured anywhere in b_res.
>>
>>         You would basically have a disconnect between what is sized and
>>         what is allocated. Unless offcourse you pass that 'type' to
>>         the b_res->flags, which is currently not the case.
>
> Right, we ideally would need the core to query the alignment once per
> "apertures" it tries as a candidate to allocate a given resource... but
> that's for later.
>
> For now we can probably live with giving out the max of the minimum
> alignment we support for M64 and our M32 segment size.

We already know the aperture we're proposing to allocate from (the
result of find_free_bus_resource()), don't we?  What if we passed it
to pcibios_window_alignment() along with the struct pci_bus *, e.g.:

  resource_size_t pcibios_window_alignment(struct pci_bus *bus, struct
resource *window)
