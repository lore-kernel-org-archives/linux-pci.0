Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:55231 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaJOWTS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Oct 2014 18:19:18 -0400
Received: by mail-ig0-f174.google.com with SMTP id a13so18376881igq.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2014 15:19:17 -0700 (PDT)
Date: Wed, 15 Oct 2014 16:19:14 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dave Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>,
	Brian King <brking@linux.vnet.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
Message-ID: <20141015221914.GD15225@google.com>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412746096.30859.229.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 08, 2014 at 04:28:16PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2014-10-07 at 19:47 -0400, Alex Deucher wrote:
> > > This moves the setting of the quirk flag to the audio driver.
> > >
> > > While recent ASICs have that problem fixed, they don't seem to
> > > be listed in the PCI IDs of the current driver, so let's quirk all
> > > the ATI HDMI for now. The consequences are nil on x86 anyway.
> > >
> > > Signed-off-by: Alex Deucher <alexdeucher@gmail.com>
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > CC: <stable@vger.kernel.org>
> > 
> > Further discussion with the hw teams have revealed that this is still
> > an issue on newer asics so I think your original patch is correct
> > after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.
> 
> Allright, I won't resend the whole series, I can just pickup my previous
> patch. Takashi, Bjorn, Dave, this series covers your 3 areas of
> maintainership, how do you want to proceed ? I'm happy to merge the
> whole lot via powerpc ASAP (since it's all CC'ed stable) if you guys
> send me the appropriate acks, otherwise, let me know.

It all looks beautiful to me.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If I were merging it, I would change this:

  pci/msi: Add device flag indicating that 64-bit MSIs don't work

to this:

  PCI/MSI: Add device flag indicating that 64-bit MSIs don't work

I'd be happy to merge it, but given what I know now, I would wait and merge
it during the v3.19 merge window.  It sounds like it's more urgent than
that and should be merged earlier, but from the changelogs, it looks like
we're just replacing the powerpc-specific quirk with a more generic one.

So I assume you'll merge it via powerpc unless I hear otherwise.

Bjorn
