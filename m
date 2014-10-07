Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48218 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932134AbaJGXuX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 7 Oct 2014 19:50:23 -0400
Message-ID: <1412725790.30859.214.camel@pasglop>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dave Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@ozlabs.org
Date: Wed, 08 Oct 2014 10:49:50 +1100
In-Reply-To: <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
References: <1412656696.30859.122.camel@pasglop>
	 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-10-07 at 19:47 -0400, Alex Deucher wrote:
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

Ok. You confirm that this is however good on newer video side right ?

Also, is there a known issue that if MSI were once enabled, the chip
still shoots them even if we disable them in config space ?

When testing my new patch set, I was trying to test the error path
when the arch does *not* honor the limitation. The error went back
up to the driver as far as I can tell (ie, pci_enable_msi() failed),
but the system still got into error state as if the card had tried
to shoot an MSI to the wrong address.

(I suspect the graphics side)

Cheers,
Ben.


