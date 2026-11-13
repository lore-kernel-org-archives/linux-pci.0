Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531595;
	b=nnM/31TTfGpGSsoDbJePo025T5kDZv5nWaREvuZM4tdlrWXDlvTpaJ5diy6zG29sJ534
	 3IRNeAlEa37wVGI0mti+fsvcZI1viRPaLdV/MbUTY33PCRerAHqzsuxkktEV39FDUHB68
	 YVaEoVMWxfdtLzLdJejKW5UsDBVPbzHmI5rKflpuAGiqXHNPIfSMxfa15Ax9Zbc9/RcWk
	 +Lj3NA9SxDGYgsr0aibaReiu6ZgMC2Q5336RdqdaYe4XWLFs0uRd4JKqjotdUhoP1NOh0
	 raFsmLaWdZvXCiAbBldVf0RTOace/z4DL1FwT2YrmNw0vhx9AnHY+aPTVOUbTc2DIDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531595;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SOodtrZpOD1+CaWARbBLA2Y6OiS4B4c1IxG3MXyXdgM=;
	b=b6JXoAEubqXIL3jmMGlIf0QmmzeKyTOjz30uYxWsAC+EO9sM8/GNpR3bjA8RVMrF76sT
	 R3wb5p4YUxssuNxBQLh+ta6u1xmpZMhrvAjyhcbd0s1raqJYHxLWoWFPQFK8nnJ5dKXaP
	 cuoC2/ZXnueQVqpPoXrkCmbeCA4xUoSaDLAHXnh96ST+y4bh9KO5cvah2JmbqEgH1CzAJ
	 Ap+ZrkadzRCeMwERLUNNW/GwYnslsr8chmq/d6zeVWI0PP/mrackpRiuyNRGqUnJ24A7y
	 Zrcx9uHSk2yWb9V0qNQu9FVPBe9YC8F6jMENtzM0daRM/fzDcKMnDb7iFoiFnZaHC6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZsL2a1y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59601606A330
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZsL2a1y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C423A1F000C4;
	Fri, 13 Nov 2026 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531594;
	bh=SOodtrZpOD1+CaWARbBLA2Y6OiS4B4c1IxG3MXyXdgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZsL2a1yiOYJle5S24WJdaZAfwPksVa2eA7JdEgqNwIH1dn1Tl9rxJ4FdKLxGyou2
	 kVfb8+5mjYj/nmJyT5l50pvV7uyDCMYLvRJKvC10VIMliDl2MD//U3cSrUJnMDjFAC
	 VZSPvgnRJthZUXku6kJV6Ykl/ZdXk/nSWUd27peAPHSQcdIy37HMLv9xlXSzFvft66
	 kWooOwqFxGzMcPoINpmIlFG6Wxnan+lF3i0IF5VLhqWBCe0s0XpcyGndE+Qb+JDxXD
	 L7WlwKBifJJ6dQqMd+QrS9HS5yfDg7F8qqjLmdxXM87G1s9F5PZBcwXbVr3Is4y+fO
	 vHMg6nNZYYrEw==
Message-ID: <sashiko-outbox-212025@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] drm/amdgpu: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112-vfct-regression-v7-2-69b1e0cf45c2@amd.com>
References: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
 <20261112-vfct-regression-v7-2-69b1e0cf45c2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 00:59:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikza=
dch@gmail.com/
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft=
 filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-vfct-regre=
ssion-v7-0-69b1e0cf45c2@amd.com?part=3D2

