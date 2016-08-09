Return-Path: <benh@kernel.crashing.org>
Return-Path: <benh@kernel.crashing.org>
Message-ID: <1470787179.3015.78.camel@kernel.crashing.org>
Subject: Re: [PATCHv2 3/4] pci: Determine actual VPD size on first access
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Bjorn Helgaas
 <helgaas@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@oracle.com>,
        Paul
 Mackerras <paulus@samba.org>,
        Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 10 Aug 2016 09:59:39 +1000
In-Reply-To: <bc3c39b1-cbff-99a5-8fe7-9add14f2c6f5@ozlabs.ru>
References: <1452684335-46107-1-git-send-email-hare@suse.de>
	 <1452684335-46107-4-git-send-email-hare@suse.de>
	 <20160209210458.GB32530@localhost>
	 <bc3c39b1-cbff-99a5-8fe7-9add14f2c6f5@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> On Tue, 2016-08-09 at 22:54 +1000, Alexey Kardashevskiy wrote:
> The cxgb3 driver is reading the second bit starting from 0xc00 but since
> the size is wrongly detected as 0x7c, VFIO blocks access beyond it and the
> guest driver fails to probe.
> 
> I also cannot find a clause in the PCI 3.0 spec saying that there must be
> just a single block, is it there?
> 
> What would the correct fix be? Scanning all 32k of VPD is not an option I
> suppose as this is what this patch is trying to avoid. Thanks.

Additionally, Hannes, Alex, I argue that for platforms with proper HW isolation
(such as ppc with EEH), we shouldn't have VFIO try to virtualize that stuff.

It's the same problem with the bloody MSIs. Just let the guest config space
accesses go straight through. Its drivers knows better what the HW needs and
if it crashes the card, too bad for that guest.

That being said, we don't have fine grained per-device PERST control on
all systems so there may not be recovery from that but on the other hand,
our constant attempts at "filtering" what the guest does to the HW is
imho, doomed.

Cheers,
Ben.
