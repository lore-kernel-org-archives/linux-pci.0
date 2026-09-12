Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25504BEE43
	for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230339; cv=none; b=SdwcYDUDTnKfgRCR3y2I/yTM8ugssJ8txfOIDXkyYuGTIbpvyu1XquyW37EbL5mxKFM9iSsiBAIKfjoT0w2flJ7f7YH8m7Bucwcu1xzQdFhwfALgo82PkXHVvHBfwz+FZEcWXF9a1bZEYPBkiB9nrhb5D38lSLG98nGyUrglLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230339; c=relaxed/simple;
	bh=9NcMv3NTL5wVIVDyIHWRD/mes8Qtg5YQC23Is3evEEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uNg+6X5NIT/+PAhqKtpsWebLyho+BkjhY7GR84ohfdV+PioCv+2So0V1IprQyTkmmnMEDcsZgFTsVygxc+tW79alG8MxpMINrFg7LNSuuHkpHSEA5rYaqrJxasUv04so1VcdLrRtCccNwlALvLVzornFzzeX6ZntDrOde6K0cn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST2wCDEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST2wCDEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBB51F00893;
	Sat, 12 Sep 2026 16:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230338;
	bh=nijLYZ6JlR9VCwhiK1cJLJ34r/XXo1XrBnBACEn9nME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ST2wCDEc65ZR2ZV9O3dM82cwoBkcPGMI6ISDL/Ze2SgrlOe8ucFndj88/aS2A8LJ1
	 FVoLcJrJEGAH7VRZKwdDs5N50qePymNT+KOTNhVxTMHiOlfn5K3txQetTfxXj+4I0X
	 GfECS7XV2weNxPOcWih1Kyb9l+xVZfI6a0UO9F7IAuJGzTBCbNpzY7D+gCBjLkGIFm
	 ZqfBkGZaaJCcDqWgJGdZXqTO1kuNrw5OqMbJ0kFcJavdnpcXPKhRn5kGRsnCOnugXE
	 0q3PTVorX7tyebejzkodpPWJgdvp8RW4uDDpQ0G9SBhmGGVmdi02S/WDUBv5COh6x2
	 Xda9mwNf3oJsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: dra7xx: Remove device links to PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: vladimir.oltean@nxp.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260912161440.1032188-3-vladimir.oltean@nxp.com>
References: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
 <20260912161440.1032188-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 16:25:38 +0000
Message-Id: <20260912162538.6EBB51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Shared IRQ handler accesses hardware registers without checking if=
 the device is runtime active.
--

commit 5052482ced4c68a6a0a92320a0f14365dce06957
Author: vladimir.oltean@nxp.com <vladimir.oltean@nxp.com>

PCI: dra7xx: Remove device links to PHY

This is a full revert of commit 7a4db656a635 ("PCI: dra7xx: Create
functional dependency between PCIe and PHY"). The reverted functionality
is redundant since the PHY core now adds a device link to order PHY
provider and consumer suspend/resume operations.

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/contro=
ller/dwc/pci-dra7xx.c
> index 6ae5b27e27b32..6c9e881776002 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the shared IRQ handler access hardwa=
re
registers without checking if the device is runtime active?

If another device sharing the same IRQ line triggers an interrupt during or
after shutdown, the handler unconditionally accesses the powered-off regist=
ers:

drivers/pci/controller/dwc/pci-dra7xx.c:dra7xx_pcie_irq_handler() {
	...
	reg =3D dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
	...
}

In the driver's shutdown callback, the device is powered off
(pm_runtime_put_sync, clk_disable_unprepare) but the devm-managed IRQ is ne=
ver
freed.

Could this lead to a kernel panic (precise data abort on ARM) due to reading
from unclocked hardware registers, or spurious interrupt storms? Should the
handler use pm_runtime_get_if_active() before accessing registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912161440.1032=
188-1-vladimir.oltean@nxp.com?part=3D2
