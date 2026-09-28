Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D794EDCD0;
	Mon, 28 Sep 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614731; cv=none; b=lMD/m2p34NQF5MmvSn0U+Lwh4hw7Gyam4rZUc3y+Lu9SKhBB9Hpn1HhRUymg3M0k0167s+1nO4Sry7EHSMc9B9qDGSyKScDy6tdFoTWR0wAEukRKAHwF0C0MYpSQeMRLCM1m60/MqOCUsuF98xAVV6nqGUZPhL/NZMU44zhcfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614731; c=relaxed/simple;
	bh=LLwQt5mThBgmyGgWD6oBLUj1JmpLA0lPBIMKfllI+/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMGF+xiKPIK/bhyEp8cay3C9tGtJen6i6DTKsER4wreB8MQHadWIbAsBe+y6D2kVs+iuufuQ5QIrT/Ux3XxZ4lsmj9pJNOWdAFkiSR1cY1dSt68BMPCCMFZpNZBBifnEiAW/7mVrZV03I69vwez7KaoCrzL+kz7/8ujqxlqiISE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJXN88F7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJXN88F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03681F000FF;
	Mon, 28 Sep 2026 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614730;
	bh=LLwQt5mThBgmyGgWD6oBLUj1JmpLA0lPBIMKfllI+/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJXN88F7F8QuNgbmPGOlOgoTdVIqZPbhr0NrMwoTSP+fsUGVpWh1C+hHmYsXxNiET
	 amWEqfYWNBSxW7ZxUR1SUyVuUHVyLZRqZ2TdvxMfM4QLxmZ6m0tCfwGRPDE27/zBnW
	 2GVkgz5QuiUsE9ERFaC4paOk72re8RPX16sl/EcN6CizMT4jR4/3JzSv3nuIePNh/T
	 tUt66C/XxAd/jtV6P6p9DXmZ/HB7+C6cA4hxisJoxNc0zxxGgre/2VW7x0l7QZ8Ik7
	 Z+Pxrl6NSF4ergOLgUyeJDlQ8a3iCS4UNluMe6WpzICMo8ShdNH+JC3gbGOkcjDlqi
	 EuHEQxxQCAIsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/15] PCI: dwc: Export dw_handle_msi_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260928165230.3397664-5-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:58:49 +0000
Message-Id: <20260928165849.D03681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Not every platform brings the iMSI-RX interrupt out as a dedicated
> line. On spear13xx and keembay it is a status bit in the SoC wrapper's
> interrupt register that the glue driver has to check and clear, and on
> dra7xx it shares the line with other sources the glue driver has to
> demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
> not install its chained handler, and service the MSIs from a handler of
> their own. spear13xx and keembay call dw_handle_msi_irq() for that.
> Both are built-in, so the function was never exported. dra7xx can be a
> module and has an MSI loop of its own.
>=20
> Export the function so that modular glue drivers can use it as well.
> The R-Car Gen4 driver, where both situations apply, is the first user.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D4

