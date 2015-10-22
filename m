Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:56622 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbJVRs3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2015 13:48:29 -0400
Date: Thu, 22 Oct 2015 18:48:13 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: WingMan Kwok <w-kwok2@ti.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com,
	rogerq@ti.com, bhelgaas@google.com, ssantosh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] Common SerDes driver for TI's Keystone Platforms
Message-ID: <20151022174812.GX32532@n2100.arm.linux.org.uk>
References: <1445432201-16007-1-git-send-email-w-kwok2@ti.com>
 <5628FB36.4010303@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5628FB36.4010303@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 11:05:26AM -0400, Murali Karicheri wrote:
> On 10/21/2015 08:56 AM, WingMan Kwok wrote:
> >On TI's Keystone platforms, several peripherals such as the
> >gbe ethernet switch, 10gbe ethernet switch and PCIe controller
> >require the use of a SerDes for converting SoC parallel data into
> >serialized data that can be output over a high-speed electrical
> >interface, and also converting high-speed serial input data
> >into parallel data that can be processed by the SoC.  The
> >SerDeses used by those peripherals, though they may be different,
> >are largely similar in functionality and setup.
> >
> >This patch series provides a SerDes phy driver implementation that can be
> >used by the above mentioned peripheral drivers to configure their
> >respective SerDeses.
> >
> >As an example of the using the SerDes driver, this patch series also
> >updates the Keystone PCIe host driver to enable and use its SerDes block.
> >
> >References:
> >[1] KeyStone II Architecture Serializer/Deserializer (SerDes) User's Guide
> >     (http://www.ti.com/lit/ug/spruho3a/spruho3a.pdf)
> >
> >v3:
> >	- addresses the following review comments
> >		1. https://lkml.org/lkml/2015/10/19/756
> >			-- included sizes.h
> >		2. https://lkml.org/lkml/2015/10/19/781
> >			-- updated base on Fengguang Wu's suggestions.
> >		3. https://lkml.org/lkml/2015/10/15/896
> >			-- clarified here https://lkml.org/lkml/2015/10/20/512
> >			-- nothing to do.
> >
> >v2:
> >	- addresses the following review comments on v1:
> >		1. https://lkml.org/lkml/2015/10/15/896
> >			-- this does not address the question:
> >			   "The current code does not do this when compiled,
> >			    which might be a problem for distributors.
> >			    Can you clarify the license?"
> >			-- the question is still under discussion here:
> >			   https://lkml.org/lkml/2015/10/19/471
> >		2. https://lkml.org/lkml/2015/10/15/895
> >
> >v1:
> >	- addresses the following review comments
> >		1. https://lkml.org/lkml/2015/10/13/803
> >		2. https://lkml.org/lkml/2015/10/14/613
> >		3. https://lkml.org/lkml/2015/10/13/818
> >
> >	- An update to PCIe dts bindings to enable the PCIe SerDes is
> >	  submitted in a separate patch.
> >
> >WingMan Kwok (2):
> >   phy: keystone: serdes driver for gbe 10gbe and pcie
> >   PCI: keystone: update to use generic keystone serdes driver
> >
> >  Documentation/devicetree/bindings/phy/ti-phy.txt |  239 +++
> >  drivers/pci/host/pci-keystone.c                  |   24 +-
> >  drivers/pci/host/pci-keystone.h                  |    1 +
> >  drivers/phy/Kconfig                              |    8 +
> >  drivers/phy/Makefile                             |    1 +
> >  drivers/phy/phy-keystone-serdes.c                | 2366 ++++++++++++++++++++++
> >  6 files changed, 2629 insertions(+), 10 deletions(-)
> >  create mode 100644 drivers/phy/phy-keystone-serdes.c
> >
> Kishon, Bjorn
> 
> Who will pick this up? Do we have time to get this in 4.4?

I've been avoiding this since my initial comments, but if you're wanting
to get it into v4.4, then I have to say something.

Again, there's other SoCs out there which have serdes.  Adding 2.5k of
lines for vendor serdes implementations does not scale - this needs to
be re-thought in a way which reduces the code maintanence burden.

Other SoCs like Marvell Armada have serdes links which can be configured
between SATA, PCIe and Gbe.  Should Armada end up adding another 2.5k
lines to support their device too?  What happens when we have 10 of
these, and we have 25k lines of code here?

Again, this does not scale.  Please look at what can be done to reduce
the code size when other implementations come along.

(I am aware that guys working on Marvell Armada are looking into this
problem - but I know they're ready to post anything yet.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
