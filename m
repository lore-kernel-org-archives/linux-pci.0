Return-Path: <hare@suse.de>
Return-Path: <hare@suse.de>
Subject: Re: Build warning regression (104daa71b396 ("PCI: Determine actual
 VPD size on first access"))
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160509195410.GB18166@localhost>
Cc: linux-pci@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57317B31.8030203@suse.de>
Date: Tue, 10 May 2016 08:09:53 +0200
MIME-Version: 1.0
In-Reply-To: <20160509195410.GB18166@localhost>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 05/09/2016 09:54 PM, Bjorn Helgaas wrote:
> Hi Hannes,
> 
> Geert's list of build regressions and improvements
> (http://lkml.kernel.org/r/1462782250-6231-1-git-send-email-geert@linux-m68k.org)
> shows these new warnings:
> 
>   drivers/pci/access.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 318:8
>   drivers/pci/access.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 340:6
> 
> which I think are due to 104daa71b396 ("PCI: Determine actual VPD size on
> first access").
> 
> Would you mind fixing those up and sending me a patch?  These were in
> the v4.6-rc1 regressions email, and I should have noticed then, but I
> didn't.
> 
This is curious.
The code has this:

size_t off = 0;

...

dev_warn(&dev->dev,
	"invalid large VPD tag %02x size at offset %zu",
	tag, off + 1);

Which, as per my reading, suggests that the last argument to
dev_warn() is of type size_t.

Which tree has generated the above warning?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
