Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35934 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbaKKVMy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 16:12:54 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn18so1779700igb.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2014 13:12:53 -0800 (PST)
Date: Tue, 11 Nov 2014 14:12:48 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>,
	Brian King <brking@linux.vnet.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
Message-ID: <20141111211248.GI28161@google.com>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop>
 <20141015221914.GD15225@google.com>
 <1413413732.11213.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1413413732.11213.27.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 16, 2014 at 09:55:32AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
> >   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
> > 
> > I'd be happy to merge it, but given what I know now, I would wait and merge
> > it during the v3.19 merge window.  It sounds like it's more urgent than
> > that and should be merged earlier, but from the changelogs, it looks like
> > we're just replacing the powerpc-specific quirk with a more generic one.
> > 
> > So I assume you'll merge it via powerpc unless I hear otherwise.
> 
> Either way works but it's easy to keep it all in one series in one tree.
> 
> The urgency is that the current powerpc quirk works only with one specific
> card (ie, one device ID for gfx and one for audio) and misses the DMA limitation
> of the sound driver (which is a somewhat orthogonal issue but the patch for it is
> in the series).
> 
> Any other radeon card causes the machine to crash at boot (the driver doesn't
> recover well from the EEH error triggered by the bad MSI address and the world
> falls over from there).
> 
> So I want this to go back into distros.

I'm still assuming you're going to merge this series, but I don't see it in
your tree (https://git.kernel.org/cgit/linux/kernel/git/benh/powerpc.git/)
yet.  Do you want me to do anything with it?

Bjorn
