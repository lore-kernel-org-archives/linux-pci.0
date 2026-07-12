Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF69449985
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783893702; cv=none; b=e/ThMZS3PaQlw8Wtv3mDzsiCftNBvROUZtQOVK4s/CE8ZUmWkXkw4zHOb3Emzp+0wl9t0Z5HXzVxHFTLOxxbjPwtH0Bk187JoZgUKqtt0Tcm+WmQ6yY1fAGwqRARoCUvbISIAQARBff5P+X2x86vn1ajD3Vw1AUAtYHq6LF6jzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783893702; c=relaxed/simple;
	bh=D/2+PRiWAN492aOwPFBPgbPGq+CYzcqHZ52uvN14YNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qCOVeNjRVOoMB/M6gv857bymhzeY82Wyyuc3hl6xMI3OXsL1sM6BHPLuNk5oznMqLWes+Mqs8NDDe8Bq2Ps+RKqvmdKe58ZwYQEXQG1eFFm4/zWNLROkG/VgOnPfHNee2QNo1IXAlG9HBWszctBM7Z8DjvJ67ovn5S/85hTPfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS1cCIvd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS1cCIvd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0589B1F000E9;
	Sun, 12 Jul 2026 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783893701;
	bh=D/2+PRiWAN492aOwPFBPgbPGq+CYzcqHZ52uvN14YNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HS1cCIvdtAbldOCb9IdmsTsyYcvYNXXIfELblIlrHSZ/WZgSz91wceze3aDUW+f9n
	 tF06Wx7kubiYZ4fl6NvhxRhCOwcLJVYYfO567s1Qk1a4opye9S9//ophUEHcQrNnFp
	 s0yqH26vJ8f2A12TKtk0NKLPuuT+K3hMZ0uDPI1f/QiAeLrTMlute1PZId/x2gbf15
	 7ejLUQj/Fp126pPMlutyw9iqL3g2fDjXP/UUx9pYsLmXbSgUp7dLQKSFcC0UfAZI8B
	 qagUMkkAGM1egB+I/rRvmshEdH5uM4S1Z2MasEp/yQfsr/lvk8wnEZY/DVZ56QbqOe
	 q8jRSpXAOKE8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liz Fong-Jones" <lizf@honeycomb.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 22:01:40 +0000
Message-Id: <20260712220141.0589B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Liz Fong-Jones <lizf@honeycomb.io>
>=20
> pci_do_resource_release_and_resize() releases the device BARs that
> share a bridge window with the BAR being resized, but when the device
> sits directly on a root bus (pdev->bus->self =3D=3D NULL) it then skips
> resource assignment entirely and returns success, leaving the BARs it
> just released unassigned (IORESOURCE_UNSET).
>=20
> Skipping pbus_reassign_bridge_resources() is correct in that case --
> there is no bridge window to adjust -- but the device BARs still have
> to be reassigned. Before the BAR release was consolidated into the PCI
> core, this case worked for amdgpu because the driver released the BARs
> itself and then called pci_assign_unassigned_bus_resources()
> unconditionally after the resize, which assigns unassigned device BARs
> also on a root bus. Commit db92e3fef53e ("drm/amdgpu: Remove driver
> [ ... ]
> Cc: stable@vger.kernel.org
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/2159596
> Assisted-by: Claude:claude-fable-5 checkpatch
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-pci-rebar-=
root-bus-v2-1-a1b9107a82dc@honeycomb.io?part=3D1

