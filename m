Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:34963
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757711Ab1LGS7m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Dec 2011 13:59:42 -0500
Message-ID: <4EDFB792.3040302@freescale.com>
Date: Wed, 7 Dec 2011 12:59:30 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joerg Roedel <joerg.roedel@amd.com>
CC: Stuart Yoder <b08248@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Alexey Kardashevskiy <aik@au1.ibm.com>, <aafabbri@cisco.com>,
	<kvm@vger.kernel.org>, <pmac@au1.ibm.com>, <qemu-devel@nongnu.org>,
	<konrad.wilk@oracle.com>, <agraf@suse.de>, <dwg@au1.ibm.com>,
	<chrisw@sous-sol.org>, <B08248@freescale.com>,
	<iommu@lists.linux-foundation.org>, <avi@redhat.com>,
	<linux-pci@vger.kernel.org>, <B07421@freescale.com>,
	<benve@cisco.com>, <benh@kernel.crashing.org>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: vfio / iommu domain attributes
References: <CALRxmdDS4qas9fyHXeDVw2e_yMCTqzMi6VXUF-q+eYwgMwg7tw@mail.gmail.com> <20111207163842.GC29680@amd.com>
In-Reply-To: <20111207163842.GC29680@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/07/2011 10:38 AM, Joerg Roedel wrote:
> On Wed, Dec 07, 2011 at 09:54:39AM -0600, Stuart Yoder wrote:
>> Alex, Alexey I'm wondering if you've had any new thoughts on this over
>> the last week.
>>
>> For Freescale, our iommu domain attributes would look something like:
>>     -domain iova base address
>>     -domain iova window size
> 
> I agree with that.
> 
>>     -domain enable/disable
>>     -number of subwindows
>>     -operation mapping table index
>>     -stash destination CPU
>>     -stash target (cache– L1, L2, L3)
> 
> Why does the user of the IOMMU-API need to have control over these
> things?

Stash configuration needs to match what the user of the device is doing
(in particular, which CPU(s) it is accessing the device's ring buffer
from).  Operation mapping table is related to stashing, and while
perhaps not as critical to be controlled by the driver (though I'm not
too familiar with the details here), it seems better than hardcoding
this knowledge elsewhere in the system -- it does relate to the kind of
things that the specific device is doing.

Domain enable/disable is something we'd use when we reset a KVM or
userspace device user (or reassign the device).  We need the device to
not be able to DMA until it has been quiesced from previous activity,
and we don't have anything like PCIe function-level reset or the PCI
bus-master enable bit.  The driver needs to let us know when it's safe
to enable DMA.  This *could* be done via map/unmap, but in
configurations where maps are static, we'd like to not risk the map
failing post-init.  Plus, it's simpler to just have a toggle rather than
need to tear down and rebuild the maps, and guest reset/failover is a
performance-critical path for some of our customers.

Number of subwindows goes along with iova base/size.  It affects which
mappings will be valid.  If you're using large pages and a small iova
window, a smaller number of subwindows may suffice.  We could just
always use the maximum number of subwindows, but that has a good chance
of thrashing the IOMMU's cache.  On p4080, max subwindows per device is
256 and the cache can hold 128 entries globally.  Lower-end chips may
have a smaller cache.

-Scott

