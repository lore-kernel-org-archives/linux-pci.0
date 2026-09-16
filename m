Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A150A3E6DC9
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546377; cv=pass; b=EAXD7Hm56ess9uYgrQxdQmubE9GSw6F5LHGtlZs0sRwkao+FLnVFmdzqAhTEe3X8p4M1Ljw6S6u/SyqpCUMxwh51jFT4B9tEGxJ+FGHJCT7Yd2nw0WqBX1fneDUYsg1JrKDfbbzNDXnD+T2kAWrOikBqJyklsNC0aWhdpE3x9Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546377; c=relaxed/simple;
	bh=vtzklOp5Xc3g/KxmtFeZ6TN32AvYKrtilRPIXnxGc48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCPm9k3i+5yFI2f3c3NLkTrybmBvuy6qJdaVBxlaY7jkfmfgVWi9E8WDdyXS/0OsLE9L7bHcJpoPD4bsHjSgVBj+Vl93fokEHi/xf/3QlH8YiyyIqi0CHTwGCzQaDwM9WQN/HMEkQDuQVmt7+imHWUvC6TyyvlBiRK7YaauKzyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb3x2UBy; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb3x2UBy"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f6so4337485ad.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 01:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789546360; cv=none;
        d=google.com; s=arc-20260327;
        b=sJcln914ScIrSyxl3fG+N9uqTvRqg/PhHBAq+PmhtWgma9/XyK7zrOjMclfXDHsX0C
         thR4nAy1alW06i3OhVRkAtUGzCFL4JAWWWNVQvdgEC++fqk6/vop5EiYqtYrJe8ia0ul
         FDiDDHo9rJPts/M2zbhQ3cYl3cvnIw32N11ET71E4PCKBSNf77xtGsmUsotYpDu8STBI
         98L7dTWc3LAcg8/E8kn/kNJ3dBoQ19Jh95rUfBoIDU9h8FDidozJoX5MxVt3bnvyWd8w
         veoLWVj99HZty7zvnvmi+cDboKLF+NjQ/HBRM6kb5Tgv0NLbhw3eyDk3/rGRY4h9zo3s
         0Jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t14AObIR2QBOUNMncWOce2WTBgZep0rHd7yi7bMhncY=;
        fh=DWo5I+B8YD/tR487Fxilh0/D1aHWrzegPuqE+0Y4fcc=;
        b=ov2z7RUgNZ/5Z9UuLqyQ8Ri9l6o7DIpyJE758OrIcKgpxKmLhQ8K3hLDQ8ayiNl3Ed
         UxW1tj16nVnuzbojYziwPZDLD/T6ybwvzEwHig8DWlvHTrw8D4KGMegoOOCnVZtWEdaS
         xhx7i5eWXO1KcRr8ZPRJ+LKDqUuTtL7S6RA/HuYaJCYVpsh9LvNdbqhsNHOdwxtpj/n/
         2XzjBy7UBlqGc59ZFyoF0vyLViQuRGQ9fsVoWYOY5PvHY6mS9EQq0nU5nsXvbXGhK+MZ
         YC17N40jQiIWfISVk59hNT2g5foC+nv52u5pgxQt86Kdgz1fN4NjSO2t8BcQ5K03Pmny
         RGYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789546360; x=1790151160; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t14AObIR2QBOUNMncWOce2WTBgZep0rHd7yi7bMhncY=;
        b=Mb3x2UByLaiTS1wbzyN1Js7JSTj+P1dZX3KPIYnsVv6Uyr2KWXxiJvTfE7QZeCxieY
         Zr6wfATGgWXv99wkpMrpJeTdsaZ+Ut/a+GdWm1BARW0SPtUE2ioIajmSe0S8HKeIZE6c
         C769V7A33EBQHBS5DzkWi4614teS1BUhah+1LpwUd/kGWAwhkd8A7URpVK9dG4VtPCKw
         Wvz8zcGUI2FXxSJizx+xDHd6h1O7dpVAW4r6QMxLDvIKQpjeffbTG278eIZsnQXUcOeO
         aFVuFbZnvMR8MgF0AOj2bMVeUPHpQsgDn5Ap3dbqHZkcJ9V4/x2pFStrP3osuVXwrYYU
         sO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789546360; x=1790151160;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t14AObIR2QBOUNMncWOce2WTBgZep0rHd7yi7bMhncY=;
        b=xt7r3jyEz+UB+Aah/LgD4A8UZKfg4VMYFReJVMneeb3vRaiu593H+u4EJQ9osKpWUT
         g9iiG2+XzeYRVK4Xim5szbylNTBM1BCaKYKhQXZm6M2KREXzmUpViZg5u1x4Tqsx1z7/
         mnGf8zAKHXTDBI84qFBhg/1VbQQembcOTeAae4mNa4qn+bIWrsqR/6zeMuq/dUFeywE/
         1I7hgesU/XTm7iqor3HZJrOWF0LB4CTppKku1lIBVmJGbXPm4/ilvNQFKQ8jugEL9m7z
         5rZxdUJtqixXMDZRDHylsoaiFKDxzqrdiEonKf2RbV8pZmUSCaCCPxSVuUPDrLykrc5+
         A3WA==
X-Forwarded-Encrypted: i=1; AKwUvBz3hcUiZHmWR6ddw6jpKsCnUhjKloPUoe1uS2tMBCcnNpCkk7scp0ThSzc4edP72KqqObG7BfYX0aw=@vger.kernel.org
X-Gm-Message-State: AFuF++kCG/i1J34jZ+NEqEC9yS4qNqZPuy0yC0PA5NmsKVbajkxEXCFy
	O5GOCdbTxle9dXTo7ZNKNtP695djfOR3eFlBzHUNTtp/doU7vT4DtFYNKAkyHbS/ce6wqc+FK0w
	/6Jjz1dW5SvBEzK8J5lPkP0gCnp4MYLo=
X-Gm-Gg: AYBFou2vv2WvupWxvOGVMpMh9DUwbUwP4S9vxlHbirzSPxrLhQig3GJ4TqczXTMQLbj
	HQ3+Y8QLTGRTJqjQPb9+9o0pw+az6+wb2Hem0oMzFDSrZJtegF70461E+FzIO1ISLQpBAz/9wgc
	k4u+He0CX65798rHuNg+4D45u0uVMSjChEENlFykzq4DoOVTSLXrADA2frPjFH/M8tL1E9aPkoo
	CMqS/CVd7uzhqYxpzd3/dtcBOlRLkYlpLxqia5hhziUR/DVKEyE0xleZEhEIXjVYmCnvBNXK+eo
	9uP0xNTIr2cZxlIRrz12XK89He5bg2aIN6tpYrCejY737Zgre4yzIEkMh1ReRu+rqACb5A6rF1w
	/RI21F35Q2F9U1AIfJjxLwMOmx1/zAWwGb9nblnh8Co6nYgZY
X-Received: by 2002:a17:902:f787:b0:2dd:4070:8f5 with SMTP id
 d9443c01a7336-2dd8e75ca6emr35576805ad.21.1789546360033; Wed, 16 Sep 2026
 01:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912043626.437-1-strst.gs@gmail.com> <20260914174624.GA663242@bhelgaas>
In-Reply-To: <20260914174624.GA663242@bhelgaas>
From: Semih Baskan <strst.gs@gmail.com>
Date: Wed, 16 Sep 2026 11:12:28 +0300
X-Gm-Features: AcwNN1Uc845XdVMCaRf6nH7tbJM_-GdS3-1HqZH4tFRgRtiorOZOnG7_uldSdsw
Message-ID: <CAAsRjRmur6jr6mOt4ifSc7DA3k7z31qZ5AWwoJ2qK8qV26eqpg@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	rafal@milecki.pl, zajec5@gmail.com, florian.fainelli@broadcom.com, 
	arnd@arndb.de, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rosenp@gmail.com, rani.hod@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 14, 2026 at 12:46:24PM -0500, Bjorn Helgaas wrote:
> I guess this goes back to 767012397976 ("ARM: dts: BCM5301X: Describe
> PCIe controllers fully"), but I'm confused about this.  Why are two
> incompatible devices (rev 0x01 and 0x07) described with the same DT
> with address ranges that are wrong for rev 0x01?  I thought DT was
> supposed to be matched with the hardware in the box?

Yes, it goes back to that commit. The PCIe nodes are in bcm-ns.dtsi,
the include behind bcm4708.dtsi, bcm47081.dtsi, bcm4709.dtsi and
bcm47094.dtsi. Before 767012397976 they had reg and the cell sizes
only. That commit added the compatible, the interrupt maps, bus-range
and one set of ranges, and widened the axi node's ranges to the same
three windows. Its log says it was tested on BCM47094 with the
platform driver.

Both revisions are the same PCIe Gen 2 core, BCMA_CORE_NS_PCIEG2, and
pcie-iproc-bcma matches it at BCMA_ANY_REV. The difference this driver
meets is the fixed outbound window base. The first controller decodes
0x08000000 on both. The second and third decode 0x20000000/0x28000000
on revision 0x07 (BCM47094) and 0x40000000/0x48000000 on revision 0x01
(BCM47081 and BCM4709, measured). The values in the DT are the
revision 0x07 ones. Broadcom's own driver in the 2.6.36 vendor
kernels, arch/arm/plat-brcm/bcm5301x_pcie.c, has 0x40000000 and
0x48000000 as its default table and switches to 0x20000000 and
0x28000000 only when the core revision reads 0x7. The enumeration ROM
reports the same base per core, and that is what the applied patch
reads through bcma.

> And I guess I missed this part about the platform and the bcma drivers
> both trying to claim the same device.  That seems like something that
> should be solved somewhere in the bus drivers (platform, bcma), not in
> pcie-iproc-bcma.c and pcie-iproc-platform.c.

Yes. Both drivers have bound these nodes since 767012397976 in any
build with both enabled, and neither the applied patch nor the
follow-up changes which one binds first. The follow-up only stops this
driver from requesting windows it never programs. It is in the commit
log because that changes what happens after the collision on revision
0x01, and multi_v7_defconfig builds both drivers (both symbols default
to y under ARCH_BCM_5301X). OpenWrt builds only the BCMA one.

> Why is this not a problem for other BCMA devices (bgmac_bcma_driver,
> b43_bcma_driver, brcms_bcma_driver, bcma_hcd_driver)?

Because the pcie nodes are the only children of the axi node in
bcm-ns.dtsi with a compatible at all. bcma_bus_register() runs
of_platform_default_populate() on the axi node before it registers its
cores, so a core whose node has a compatible gets a device from both
sides.

The gmac nodes have no compatible, so only bgmac-bcma binds them;
bgmac-platform matches brcm,amac, brcm,nsp-amac and brcm,ns2-amac,
none of which appear there. The usb2 and usb3 nodes have no compatible
either; bcma-hcd claims the core and populates the generic-ehci, ohci
and xhci children itself. b43 and brcmsmac have no platform
counterpart.

> Is this another consequence of using a DT that describes
> "brcm,iproc-pcie" controllers that don't match the hardware?  Why
> don't we have different DTs for these two kinds of hardware?

The double claim comes from the compatible. Revision 0x07, where the
DT window matches the EROM, gets the two probes as well, so the ranges
play no part in it. bcma attaches the node to the core by its reg
either way, and the wifi child nodes in bcm4709-netgear-r8000.dts hang
off it, so both drivers see the same node however the ranges are
split.

The DT is already split per SoC family, and BCM47094 has its own
dtsi. The shared part is the include. The per-SoC files can carry the
window difference; today they do not.

Best regards,
Semih
