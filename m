Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Jan 2016 10:13:20 -0800
From: Tony Lindgren <tony@atomide.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, nsekhar@ti.com,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 0/2] DRA72/DRA74: Add 2 lane support
Message-ID: <20160107181320.GO12777@atomide.com>
References: <1452077393-25880-1-git-send-email-kishon@ti.com>
 <20160107174126.GB14105@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160107174126.GB14105@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Bjorn Helgaas <helgaas@kernel.org> [160107 09:42]:
> [+cc Richard]
> 
> Hi Kishon,
> 
> On Wed, Jan 06, 2016 at 04:19:51PM +0530, Kishon Vijay Abraham I wrote:
> > Add driver modifications in pci-dra7xx to get x2 mode working in
> > DRA72 and DRA74. Certain modifications is needed in PHY driver also
> > which will be sent as a separate series.
> > 
> > Certain board modifications has to be done in order to test
> > x2 mode in dra72-evm.
> > 
> > These patches were created on pci next.
> > 
> > Changes from RFC:
> > *) .b1co_mode_sel_mask is now set with the correct value.
> > *) cleanup the patch
> > 
> > Kishon Vijay Abraham I (2):
> >   pci: host: pci-dra7xx: use "num-lanes" property to find phy count
> >   pci: host: pci-dra7xx: Enable x2 mode support
> > 
> >  Documentation/devicetree/bindings/pci/ti-pci.txt |    8 +-
> >  drivers/pci/host/pci-dra7xx.c                    |  104 +++++++++++++++++++---
> >  2 files changed, 97 insertions(+), 15 deletions(-)
> 
> Apparently dra7xx in mainline doesn't work [1].  Until that's
> resolved, I'm going to ignore dra7xx patches.

Agreed. Guys, please do the development _and_ testing on the mainline
kernel. We do have the mainline kernel usable for probably a few
tens of omap SoC variants. If you have issues using dra7 with mainline,
please fix those issues ASAP.

Ideally of course please also use the device you're working on to
send out the patches :)

Regards,

Tony

> [1] http://lkml.kernel.org/r/20160106214518.GA6106@localhost.localdomain
