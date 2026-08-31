Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85E44E037
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194004; cv=none; b=inp62MGkJcmN/130LPEYU4x/ou7Gq7CtA9k4Kgh+hiqpUaY72IVgbOOVgjnk5r1364W9nEorpx/3DDemrttFtkKDbStPvBR2R7GsQkuJTDPOduHbp5mk8qV54XVFK+p1b2TBblnU6R5dQvjNMzDL7H4dvikPniDGE/pl71WN+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194004; c=relaxed/simple;
	bh=J+VEL5KdBkgAuk8mer4s4NYIHLUOZvWgtHlKYs5ZNL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IB3a1vhZb1gPiYA2UlOl/m3USBfA5dacHy8bCdBGEjHUrLU+qJd5qb292VJYvaG7boDmIyqF+4kAOFZB6qnfx3/ZYxqBmOs+dUtALJo1KhQwf6t9aUT/xrslizzEihT7nRx6hX02qSGa23NwBP5pnhrAkcF7K5JEeB2h2C3JKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUeS4jg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUeS4jg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C100F1F000E9;
	Mon, 31 Aug 2026 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194002;
	bh=J+VEL5KdBkgAuk8mer4s4NYIHLUOZvWgtHlKYs5ZNL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TUeS4jg5aveHblPASbpYNX6qSoNe/j/mhl1YHgkAXlkxmQLSx15FeS4fxzA7cvNoR
	 fpzmCRCZKhhC8hfxPJPI5ckIJGpL7qB4Mft1flT1FpSU6Kp6ZIDEDDe6I26eLnCIVK
	 VqNu4IPQyypw1w7ORJHM/DcicrhYz0FvZZyq37C9RIvrVshoNH5/3G/jRaDUyD+q1E
	 AyjjEXDorGRk9dlV7UTDaGlgvbeTdHR6Z6DBp9roWIwn3pWoom8tJbi1JFVH1uHG3M
	 kkWDMk2aDK/+FQHMPe3EyVQtB7YQj/s4YtLD5vHiJDpZOLNFRZKw9icY0rYv6y8V7R
	 dnBsgvAztSfrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.15] ACPI: PCI: Clear _DEP dependencies
 after PCI root bridge attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-474-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-474-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:33:22 +0000
Message-Id: <20260831163322.C100F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Chen Pei <cp0613@linux.alibaba.com>
>=20
> [ Upstream commit 3a59c3b772e5dc0cedecce8e7fbf7c2d6245b643 ]
>=20
> PCI root bridges enumerated by acpi_pci_root_add() can be the _DEP
> supplier for other ACPI consumers, most notably ACPI0017 CXL root
> devices whose probe path depends on acpi_pci_find_root() succeeding.
> Once the root bus has been added, those consumers can safely be
> enumerated, so notify them by clearing the dependency.
>=20
> Call acpi_dev_clear_dependencies() at the end of acpi_pci_root_add(),
> after pci_bus_add_devices(), following the same pattern used by other
> ACPI suppliers such as the EC (drivers/acpi/ec.c) and the ACPI PCI
> Link device (drivers/acpi/pci_link.c). The clear is intentionally
> done only on the success path; on the error paths the supplier did
> not attach and consumers must keep dep_unmet set.
>=20
> This is a prerequisite for honoring _DEP on ACPI0016 host bridges,
> which matters on architectures where the probe order of acpi_pci_root
> relative to cxl_acpi is not guaranteed (e.g. RISC-V).
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> Suggested-by: Dan Williams (nvidia) <djbw@kernel.org>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Link: https://patch.msgid.link/20260526025118.38935-2-cp0613@linux.alibab=
a.com
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-474-sashal@kernel.org?part=3D1

