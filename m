Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 15 Oct 2015 17:51:06 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: WingMan Kwok <w-kwok2@ti.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com,
	rogerq@ti.com, m-karicheri2@ti.com, bhelgaas@google.com,
	ssantosh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/2] Common SerDes driver for TI's Keystone Platforms
Message-ID: <20151015165105.GE32532@n2100.arm.linux.org.uk>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 10:25:43AM -0400, WingMan Kwok wrote:
> On TI's Keystone platforms, several peripherals such as the
> gbe ethernet switch, 10gbe ethether switch and PCIe controller
> require the use of a SerDes for converting SoC parallel data into
> serialized data that can be output over a high-speed electrical
> interface, and also converting high-speed serial input data
> into parallel data that can be processed by the SoC.  The
> SerDeses used by those peripherals, though they may be different,
> are largely similar in functionality and setup.

Given that serdes is not specific to TI, should this be specific to
TI, or should there be an effort to come up with something which
everyone who has serdes links can make use of?

Serdes comes in multiple different forms: PCIe, 1G SGMII ethernet,
1000base-X ethernet, 10g ethernet, SATA... I'd hate to see a
plethora of SoC specific stuff for this.

When serdes is combined with SFP cages, the situation becomes much
more fun, because the serdes link then needs to become hotpluggable
(SFP modules are designed to be hotplugged) which means you have to
be able to switch between (at least) 1G SGMII and 1000base-X modes,
and probably 10G mode as well.  There's even a SFP module that has
a SATA connector on it, though I believe there's no standard for
that, and it's more a hardware hack.

I've been working in this area but from the Ethernet side on an
Armada 38x based board which has a SFP cage on it, though it's
slightly simpler there because there is no support (or I believe
any desire) to reconfigure the serdes lanes between PCI, ethernet
and SATA - that's all setup and initialised for us by uboot.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
