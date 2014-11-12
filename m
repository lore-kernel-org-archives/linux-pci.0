Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:60402 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935129AbaKLCXl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 11 Nov 2014 21:23:41 -0500
Message-ID: <1415759019.10731.1.camel@concordia>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Anton Blanchard <anton@au1.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yijing Wang <wangyijing@huawei.com>,
	Brian King <brking@linux.vnet.ibm.com>,
	Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Nov 2014 13:23:39 +1100
In-Reply-To: <20141111211248.GI28161@google.com>
References: <1412656696.30859.122.camel@pasglop>
	 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
	 <1412746096.30859.229.camel@pasglop> <20141015221914.GD15225@google.com>
	 <1413413732.11213.27.camel@pasglop> <20141111211248.GI28161@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-11-11 at 14:12 -0700, Bjorn Helgaas wrote:
> On Thu, Oct 16, 2014 at 09:55:32AM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
> > >   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
> 
> I'm still assuming you're going to merge this series, but I don't see it in
> your tree (https://git.kernel.org/cgit/linux/kernel/git/benh/powerpc.git/)
> yet.  Do you want me to do anything with it?

I'm doing the powerpc tree this cycle, so it'd be in my tree, but it's not:

  https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/

Ben if you want me to take it let me know.

cheers


