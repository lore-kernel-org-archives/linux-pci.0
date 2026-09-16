Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290E44C51D;
	Wed, 16 Sep 2026 20:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588886; cv=none; b=JFr0DM1YhYObBheU/dJfzlyCbTRroKJrD4QR26Sg1jeygK5qJaKN5/Z8sob011imPw18nb0rFdfZAZ4AiAucZkYxKv1wprm5snjyJp9K37hc6WRmAHk1vrImx2sRsCOQAC0MnZCOXcOG4e/DCjZxd6P7i3kg/werJLsZEHXbEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588886; c=relaxed/simple;
	bh=RvN0J0UBJMKy7/DK2I49rA5VsLB7Um0+jPX+19k/xa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gBGatr877aeH1V0AlOvX2yp54f7PBLZApfdLrgwfopeR9Shl5SuNDtNfkvFjXnLRJDyLQkJizVslOq+LtYxXs1lLDdjO9Lr1TbPAKJmQuVPdgj2Zd3iDUO54AEA33fzKSvQC1VrttaLDXf+1wABCSRw2LRlSRWQyj7JrxcOjzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEqUV1Vp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEqUV1Vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CF21F00893;
	Wed, 16 Sep 2026 20:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588872;
	bh=CkFS2RoyA+07ZxHlU+uw0X4GaSf3vVxWtakGxkASFeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=LEqUV1VpofbnLuWsygj6ZAvuIsFrCuY6Tm1SK9vITmVujmVT483iZRsIgLn1M/uya
	 vjwNmWwjOy0zrmsJoa4M1KuzvSuqnDMTroANUvF6ZAsSTVrP4JF2kHsLVxkrlxEE1B
	 C39BBOBfQrv2jxKvndmHdYPWS7prM+wzk571/hp7Kvw35bezsn6bHSTNGjUiCjgmc9
	 pBpt16uV9xBFzL5ejInz8okEY05TF+eAhdXAlSd/0MLB/FCW2WcfqQIpP/9iq6MIm/
	 Fvr0VkBEVWf0EwMUkA343OMMnq0kQXdTM1L2LBjuGUcxAWDNNC8Q/d/f37+1PROAup
	 HChP8Ij6iJ23g==
Date: Wed, 16 Sep 2026 15:01:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	rafal@milecki.pl, zajec5@gmail.com, florian.fainelli@broadcom.com,
	arnd@arndb.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rosenp@gmail.com, rani.hod@gmail.com
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Message-ID: <20260916200110.GA979975@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAsRjRmur6jr6mOt4ifSc7DA3k7z31qZ5AWwoJ2qK8qV26eqpg@mail.gmail.com>

On Wed, Sep 16, 2026 at 11:12:28AM +0300, Semih Baskan wrote:
> On Mon, Sep 14, 2026 at 12:46:24PM -0500, Bjorn Helgaas wrote:
> > I guess this goes back to 767012397976 ("ARM: dts: BCM5301X: Describe
> > PCIe controllers fully"), but I'm confused about this.  Why are two
> > incompatible devices (rev 0x01 and 0x07) described with the same DT
> > with address ranges that are wrong for rev 0x01?  I thought DT was
> > supposed to be matched with the hardware in the box?
> 
> Yes, it goes back to that commit. The PCIe nodes are in bcm-ns.dtsi,
> the include behind bcm4708.dtsi, bcm47081.dtsi, bcm4709.dtsi and
> bcm47094.dtsi. Before 767012397976 they had reg and the cell sizes
> only. That commit added the compatible, the interrupt maps, bus-range
> and one set of ranges, and widened the axi node's ranges to the same
> three windows. Its log says it was tested on BCM47094 with the
> platform driver.
> 
> Both revisions are the same PCIe Gen 2 core, BCMA_CORE_NS_PCIEG2, and
> pcie-iproc-bcma matches it at BCMA_ANY_REV. The difference this driver
> meets is the fixed outbound window base. The first controller decodes
> 0x08000000 on both. The second and third decode 0x20000000/0x28000000
> on revision 0x07 (BCM47094) and 0x40000000/0x48000000 on revision 0x01
> (BCM47081 and BCM4709, measured). The values in the DT are the
> revision 0x07 ones. Broadcom's own driver in the 2.6.36 vendor
> kernels, arch/arm/plat-brcm/bcm5301x_pcie.c, has 0x40000000 and
> 0x48000000 as its default table and switches to 0x20000000 and
> 0x28000000 only when the core revision reads 0x7. The enumeration ROM
> reports the same base per core, and that is what the applied patch
> reads through bcma.
> 
> > And I guess I missed this part about the platform and the bcma drivers
> > both trying to claim the same device.  That seems like something that
> > should be solved somewhere in the bus drivers (platform, bcma), not in
> > pcie-iproc-bcma.c and pcie-iproc-platform.c.
> 
> Yes. Both drivers have bound these nodes since 767012397976 in any
> build with both enabled, and neither the applied patch nor the
> follow-up changes which one binds first. The follow-up only stops this
> driver from requesting windows it never programs. It is in the commit
> log because that changes what happens after the collision on revision
> 0x01, and multi_v7_defconfig builds both drivers (both symbols default
> to y under ARCH_BCM_5301X). OpenWrt builds only the BCMA one.
> 
> > Why is this not a problem for other BCMA devices (bgmac_bcma_driver,
> > b43_bcma_driver, brcms_bcma_driver, bcma_hcd_driver)?
> 
> Because the pcie nodes are the only children of the axi node in
> bcm-ns.dtsi with a compatible at all. bcma_bus_register() runs
> of_platform_default_populate() on the axi node before it registers its
> cores, so a core whose node has a compatible gets a device from both
> sides.
> 
> The gmac nodes have no compatible, so only bgmac-bcma binds them;
> bgmac-platform matches brcm,amac, brcm,nsp-amac and brcm,ns2-amac,
> none of which appear there. The usb2 and usb3 nodes have no compatible
> either; bcma-hcd claims the core and populates the generic-ehci, ohci
> and xhci children itself. b43 and brcmsmac have no platform
> counterpart.
> 
> > Is this another consequence of using a DT that describes
> > "brcm,iproc-pcie" controllers that don't match the hardware?  Why
> > don't we have different DTs for these two kinds of hardware?
> 
> The double claim comes from the compatible. Revision 0x07, where the
> DT window matches the EROM, gets the two probes as well, so the ranges
> play no part in it. bcma attaches the node to the core by its reg
> either way, and the wifi child nodes in bcm4709-netgear-r8000.dts hang
> off it, so both drivers see the same node however the ranges are
> split.

If bcma finds both of these devices via EROM, why do they need a
"brcm,iproc-pcie" compatible?  If we omitted that compatible, what
would break?

Sorry to be dense, I'm probably asking dumb questions because I'm not
a DT expert.  I just imagine DT as being a substitute for native
enumeration protocols (e.g., PCI, ACPI, EROM), and as specific to a
piece of hardware, so this single DT that describes enumerable devices
with incompatible addresses doesn't fit my simple mental model.

Bjorn
