Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AD42E004
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341458; cv=none; b=PjLeWHZAJPhRa29MwttO4FIi9J6fVPtE/buBJTy7lQuO9A04skJpp5J7XDRAjfp7+/pUtKaqfjsDtFsTGINpT1UrUCKAVwyNhdMpd5TdOU1XmZ5Yy2n2y4t2aByndkVR4y95/AsFWrG/122A7Djjadv2/rdV00fVZRItdH8hKzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341458; c=relaxed/simple;
	bh=A+TzSzTWMVwGu/4O/ST/AhSChLuRtfENjmPqTz2jWfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LMKwgPWivWJR3C14KTnpTvP6g5q0I2R/FrnuKbATLDiRqoagztLo6cC2NXtv8nsEzyxYGHGPjmUYf7FVBCdB5AAs56sANBKi5y6d0Klp/tFaoktbi+n2xczw1bOW8/PYJTHAEzw+bn4YMoGgLh4rKv0cURQM5WsEsRecDiAElYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf20jMnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf20jMnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE8E1F00A3A;
	Mon,  6 Jul 2026 12:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341455;
	bh=Dkwciwub+LC3jtmcGo18YxxwOqPtztOBGVcQ1TkgDsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lf20jMnqvCEOW4zQrrQfnQ/ToPd3XNy/+FgrjoiQ5zhllV6vJoOxE8QePM569Dcze
	 h3kDWCSchOBOl6dyraQyQQ9B2SAhVnbxlEktbIPGItMWyebpp8tFnX64JVyAoMGays
	 gPXAzlwxPZffMee8OuIH9ufwFOmcRrBKDTyB1GABf2rPy+d6UJmxRA/VXyGnvgmTOF
	 Noci46RsqLtuTODX8gZ6FMd1EZf6XXM9Dd8uFGpR413LYO4Aaf1fNR8H535JsvcP8g
	 O9tgGoxLPTm1/nc4N9keBENnF+0en93FiPXiNofFEPWnBqNmzt8yKQARlPvpCoSNwb
	 lfy7jWmathr+g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PCI: Get the hotplug bridge window sizes from DT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260706123133.545104-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260706123133.545104-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:37:34 +0000
Message-Id: <20260706123735.7AE8E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Most of the PCI hotplug bridges used in Devicetree platforms do not have
> their bridge windows populated by firmware. So the PCI core allocates the
> bridge windows based on the requirements below:
>=20
> 1. Total size needed by the downstream devices
> 2. Default size (2MiB for MMIO, 256 bytes for IO) if no devices are
>    available during the initial bus scan
> 3. Command line params like hpmemsize etc...
>=20
> If no devices are available during the initial bus scan, then the PCI core
> allocates the default conservative 2MiB MMIO bridge windows. But this size
> sometimes becomes insufficient when a BAR hungry device like a GPU gets
> plugged in later. So users have to resort to command line params to
> increase the window sizes. But this is very inconvenient and causes a lot
> of pain in distro integration.
>=20
> To address this issue, parse the 'ranges' property from the bridge DT node
> (if available) and use the sizes for each bridge window. This works well
> because the 'ranges' property is already allowed by the DT binding for PCI
> bridges and it lets system designers pre-define the hotplug bridge window
> size requirements in firmware.
>=20
> The DT derived sizes are applied as the additional (hotplug) reservation =
for
> each window. Command line parameters (hpmemsize etc...) continue to take
> precedence over DT.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706123133.5451=
04-1-manivannan.sadhasivam@oss.qualcomm.com?part=3D1

