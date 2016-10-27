Return-Path: <hare@suse.de>
Return-Path: <hare@suse.de>
Subject: Re: [PATCH] pci: Don't set RCB bit in LNKCTL if the upstream bridge
 hasn't
To: Bjorn Helgaas <helgaas@kernel.org>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <1477490014-115917-1-git-send-email-jthumshirn@suse.de>
 <20161026194317.GC17507@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <41d13b8c-98f5-af26-534e-37ceafd68eb3@suse.de>
Date: Thu, 27 Oct 2016 07:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <20161026194317.GC17507@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 10/26/2016 09:43 PM, Bjorn Helgaas wrote:
> Hi Johannes,
> 
> On Wed, Oct 26, 2016 at 03:53:34PM +0200, Johannes Thumshirn wrote:
>> The Read Completion Boundary bit must only be set on a device or endpoint if
>> it is set on the upstream bridge.
>>
>> Fixes: 7a1562d4f ("PCI: Apply _HPX Link Control settings to all devices with a link")
> 
> Can you please include a spec citation and a pointer to the bug report?
> 
PCI Express Base Specification 1.1,
section 2.3.1.1. Data Return for Read Requests:

The Read Completion Boundary (RCB) parameter determines the naturally
aligned address boundaries on which a Read Request may be serviced with
multiple Completions
o For a Root Complex, RCB is 64 bytes or 128 bytes
  o This value is reported through a configuration register
    (see Section 7.8)
  Note: Bridges and Endpoints may implement a corresponding command
  bit which may be set by system software to indicate the RCB value
  for the Root Complex, allowing the Bridge/Endpoint to optimize its
  behavior when the Root Complex’s RCB is 128 bytes.
o For all other system elements, RCB is 128 bytes

In this particular case the _HPX method was causing the RCB for all PCI
devices to be set to 128 bytes, while the root bridge remained at 64 bytes.
While this is arguably a BIOS bug, earlier linux version (ie without the
mentioned patch) were running fine, so this is actually a regression.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
