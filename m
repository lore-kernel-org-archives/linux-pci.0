Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55921 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630AbaJHGpZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Oct 2014 02:45:25 -0400
Message-ID: <1412746096.30859.229.camel@pasglop>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>
Cc: Brian King <brking@linux.vnet.ibm.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 08 Oct 2014 16:28:16 +1100
In-Reply-To: <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
References: <1412656696.30859.122.camel@pasglop>
	 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-10-07 at 19:47 -0400, Alex Deucher wrote:
> > This moves the setting of the quirk flag to the audio driver.
> >
> > While recent ASICs have that problem fixed, they don't seem to
> > be listed in the PCI IDs of the current driver, so let's quirk all
> > the ATI HDMI for now. The consequences are nil on x86 anyway.
> >
> > Signed-off-by: Alex Deucher <alexdeucher@gmail.com>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: <stable@vger.kernel.org>
> 
> Further discussion with the hw teams have revealed that this is still
> an issue on newer asics so I think your original patch is correct
> after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.

Allright, I won't resend the whole series, I can just pickup my previous
patch. Takashi, Bjorn, Dave, this series covers your 3 areas of
maintainership, how do you want to proceed ? I'm happy to merge the
whole lot via powerpc ASAP (since it's all CC'ed stable) if you guys
send me the appropriate acks, otherwise, let me know.

Cheers,
Ben.


