Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50458 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbaJOW4H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Oct 2014 18:56:07 -0400
Message-ID: <1413413732.11213.27.camel@pasglop>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dave Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>,
	Brian King <brking@linux.vnet.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Oct 2014 09:55:32 +1100
In-Reply-To: <20141015221914.GD15225@google.com>
References: <1412656696.30859.122.camel@pasglop>
	 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
	 <1412746096.30859.229.camel@pasglop> <20141015221914.GD15225@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
>   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
> 
> I'd be happy to merge it, but given what I know now, I would wait and merge
> it during the v3.19 merge window.  It sounds like it's more urgent than
> that and should be merged earlier, but from the changelogs, it looks like
> we're just replacing the powerpc-specific quirk with a more generic one.
> 
> So I assume you'll merge it via powerpc unless I hear otherwise.

Either way works but it's easy to keep it all in one series in one tree.

The urgency is that the current powerpc quirk works only with one specific
card (ie, one device ID for gfx and one for audio) and misses the DMA limitation
of the sound driver (which is a somewhat orthogonal issue but the patch for it is
in the series).

Any other radeon card causes the machine to crash at boot (the driver doesn't
recover well from the EEH error triggered by the bad MSI address and the world
falls over from there).

So I want this to go back into distros.

Cheers,
Ben.


