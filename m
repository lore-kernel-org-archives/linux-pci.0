Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Oct 2014 08:23:01 +0200
From: Robert Richter <robert.richter@caviumnetworks.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Robert Richter <rric@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Goutham <sgoutham@cavium.com>
Subject: Re: [PATCH 3/6] pci, thunder: Add PCIe host controller devicetree
 bindings
Message-ID: <20141009062301.GJ31556@rric.localhost>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-4-git-send-email-rric@kernel.org>
 <3082935.e3X4GsVUDn@wuerfel>
 <20141007142744.GE31556@rric.localhost>
 <20141007150149.GW4652@e106497-lin.cambridge.arm.com>
 <20141008084927.GH31556@rric.localhost>
 <20141008164432.GC15382@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141008164432.GC15382@e106497-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08.10.14 17:44:32, Liviu Dudau wrote:
> On Wed, Oct 08, 2014 at 09:49:27AM +0100, Robert Richter wrote:
> > On 07.10.14 16:01:49, Liviu Dudau wrote:
> > I am quite confused a bit on which is the latest code base now. I was
> > looking into Bjorn's pci/host-generic and there is a different
> > implemetation:

> > This differs also from v13. Please check.

> I'm not sure what you are looking at. Commit 41e5c0f81d3e does look like
> my v13. Not sure why you are still seeing this v11 version.

Right, my bad. Sorry for the noise.

-Robert
