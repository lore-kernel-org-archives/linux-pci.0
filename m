Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A5388890
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762432; cv=none; b=CmigTEIm2iC1sd4+lr4QJlDBQ5+8fD7dsjWUFTXIeCXoU9koAU0lwRZrYIvOpFUFVZckMUwRS0Q+6dkt57kkeujnoK7ANcBRSrIWVhZOf/z5j3SRp/XWYSBLo6MpfF9J+AcH7t98XjAZAsXY27TdBeAelHnnWP5/C7spoAQLtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762432; c=relaxed/simple;
	bh=QA7xVg91K1PPVfERY29K5FKl4mvm4OpN55ecFOcPwQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WhCMPMN7xSkVY9tqQrtR5SxioSPUsW2vly7xCha26rmtHDdgk7XOD1xFUfD783TQku1Adu2Nzh3wjeiaaANhoK22+/kQWvyifmu5LqEdsWoEhx2enUrfBRSyIlFaHT/5uX0ppZQpzbYQ0Q+JcC6PMuQNm65XCirrOl858fDLx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceCH7DKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceCH7DKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544A31F000E9;
	Wed, 22 Jul 2026 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762431;
	bh=0Q4uitDAeIe6tbG15ZOHbWVwRj2tX5Y8moxczl/kb0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ceCH7DKgd/2IVdNnCC1eACpYG+uRBqHXOUKvw+9M5J1Ll0dMTcuPz+ksfucUquMPi
	 faJ4i5ebRHQu8DH6J0MJJbZ914RI64/B1gBBLCKDnaNEykY8C0ZbIy9eJPM7UlUxH3
	 f0mjtIZzACqoV0+oKlLj7dORUyiVFBEiCm1/zK6NDDEuEeSUoaHRyLccmBZ11eYH2e
	 +NrmaX2nAC24KGFnof6553uSHl6JSaoWoY+Zqx7+qAp8fQhG5hfn/jYO+EYXjIdhoI
	 +Utni15g+dzpAAa6BH06OWdcJiEAqk7hLoC8ccx0n8+kxNv0YLHeZC7neCNck66TDG
	 r7iDvSP7QEnMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI/portdrv: Allow probing even without child
 services
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Norris" <briannorris@chromium.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260722160942.v4.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
References: <20260722160942.v4.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:20:30 +0000
Message-Id: <20260722232031.544A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe port driver fails to probe if it finds no child services,
> presumably under the assumption that the driver is not useful in that cas=
e.
> However, the driver *can* still be useful for power management support --
> namely, it still configures the port for runtime PM / D3, which may be
> important for allowing a bridge to enter low power modes.
>=20
> Thus, allow probe to succeed even if no IRQs and no child services are
> available. This also mirrors existing behavior for ports that don't suppo=
rt
> any portdrv services (PCIe hotplug, AER, DPC, PME, bwctrl), where we'd al=
so
> probe successfully.
>=20
> This change is a bit more important after commit f5cd8a929c82 ("PCI: dwc:
> Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> controller"), because it's common for some DWC-based systems to:
>=20
>   1. have only the "aer" and "pcie_pme" port services available and
>=20
>   2. not define legacy INTx interrupts properly in their device tree.
>=20
> After commit f5cd8a929c82, such systems may fail pcie_init_service_irqs()
> and so exit with -ENODEV.
>=20
> Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnq=
dwb33xkcdwk@76vnrx45fsfd/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722160942.v4.1=
.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid?part=3D1

