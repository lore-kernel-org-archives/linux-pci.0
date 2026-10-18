Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024263DBD76
	for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792354804; cv=none; b=OvWwbPEJxSNk0bJm5pqndsSk0g+UNgBNWPvPPSPqIRmGmjv6L+mJm98LKU/MjFLfJd183WOfM3uVCiNxUEzmFU7qlo34aPfuvPaixKZXSQygduxyPATEDkCpDw6jl1jQSgr0B8hMosrowCHqFXGiUR/fbKIQ2DSBRI4IRmN0QJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792354804; c=relaxed/simple;
	bh=gbMLJcTVulnft8kVuQrgyddCRO8ijTxbcMTNOX0tt2o=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ml7Mur+Om2cK+ZsHFFGgxYnZ56etLTXZFnNHC+m5Qw5uV1G8HB/dJh/y/qDCJ05M7sTFkz3DCEP6YnuSESYPgr3pEtOPz37hn8L63IsTMj3p8+5aPWY3ubwK+GgsBe36xIZngcFEU52AGGLHQGipa1P9oCIogeBMZPkGlztmmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fu+0nfHF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fu+0nfHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D5C1F000C4;
	Sun, 18 Oct 2026 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792354803;
	bh=gbMLJcTVulnft8kVuQrgyddCRO8ijTxbcMTNOX0tt2o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Fu+0nfHFF3HJF32gfmu8+vN3IVKuUMLl6gtsoFyDxAxi9Qlmy0biMPDiGHHnaWVr3
	 iduT3ubeqN+kK97QlLmMapu5CrWwithtsnJSHpHYz/DPKeIa9gdaZLIzn4Kg4c0haj
	 UfZFVtptIwhtJiIMb+aJF/VMWIoR9t9cRTqp8pqtLGUBSs6k80/J2KrDxI8b2qCW8Y
	 I3kYNkDmGA9aV5d+J8TL1k4sgG68YYrxPepojypgA6RjAsXLChRrNSbV/hlqqjiTJM
	 1koois8twsN4W+oJRf5mQhqMxaosxoEfs1LpgUkWbFEAuSOELQVq+mHm0/Q3HTaibG
	 wgTXQrT6hO8KA==
Message-ID: <sashiko-outbox-176364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Avoid bus reset on NVIDIA GB202 and GB203 GPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: mark-ship-it <williamwoodstock79@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261018201727.96924-1-williamwoodstock79@gmail.com>
References: <20261018201727.96924-1-williamwoodstock79@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 20:20:03 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> NVIDIA GB202 (GeForce RTX 5090, RTX PRO 6000) and GB203 (GeForce RTX
> 5080/5070 Ti/5070) GPUs train their link at x16 at boot, but after a
> Secondary Bus Reset the link comes back at x8 and stays there until the
> next cold boot.
>=20
> The GPU's HD Audio function (e.g. 10de:22e9 on GB203) has no reset method,
> so when both functions are assigned to a VM, vfio-pci falls back to a bus
> reset at VM start and again at release, and the GPU then runs at half
> width. Assigning only function 0 avoids the bus reset because the GPU
> itself supports FLR, which is why the problem is usually reported as
> "passing the audio function breaks x16".
>=20
> Observed on an RTX 5080 (10de:2c02) behind an AMD Root Port, kernel
> 7.0.14, Proxmox VE host with a Windows 11 Pro guest:
>=20
> [ ... ]
> kept x16.
>=20
> Link: https://forum.proxmox.com/threads/asus-x870e-pcie-x8-bifurcation-bu=
g-with-rtx-5090-vfio-passthrough.178461/
>=20
> Signed-off-by: mark-ship-it <williamwoodstock79@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018201727.9692=
4-1-williamwoodstock79@gmail.com?part=3D1

