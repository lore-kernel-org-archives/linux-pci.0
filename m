Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9B4F30C4
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779938; cv=none; b=Myu2CHOcAMwLXsdDRV0k1RZMAlzdL8uQmtaUb4betcbxHmO//KPW+RGUmzzvbrWaWV2N9ihKYPTDnOGnp6WoVVAnf16JrqMOfVxM7rE6YLbDcIK7pOfzsa1LsBgQGCS5URPgnyTvhpBBt1Pr3rB1CRWCrUWUOSYKjNLHLI3BD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779938; c=relaxed/simple;
	bh=tpyo+2UwzI5VmJ2rPxg7mG5onH4fcLyStorD3/5bCuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A74vYq0rahK4fMkptT36MwmCOotqo7aYU4L+JTQkhQh46Y/Z2kErhr7FDvE+dYBYNgI121H6goPbMFgndOiJwALOEyp76pfM+e4gSL/S3rdsTiMwACTSLn9stzYlMEy2ELPDbUFMGkrtFi9T+CEMCa+1vlAIqqmjw2jF5ek0XJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5a3TU5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5a3TU5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6B61F000FF;
	Wed, 30 Sep 2026 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779926;
	bh=tpyo+2UwzI5VmJ2rPxg7mG5onH4fcLyStorD3/5bCuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5a3TU5xno638hRmwot9vSP4cFP+Rj+ShiNnzZUTuZdP6w3YzcNxSbj1YHEbMWLsb
	 cPyIlwI32ujLMKju6lj4vxEt2CWGEWuWBViBlney0J41LbT0ivSpe8wfJ00UpW/ILs
	 Q4C4mgDUOYiXBXVhXATSHJUefedwR9ZG/0ffJjUVavdLU8f830hXWayQ+bHOMMwhvf
	 Qddv4tqUXq5NCvLlbIoP4yLXO3UUV6GL07ODdn/ITnJTmBLFLWmK1aJGVLo/aom9H9
	 6VhLPgLc1e9Bgg91ApLduHiS2qrQyKMEodaK2cTah8QUJJPn+r+kF5LOjTi7KBRfkA
	 oxsMg4LNlYL3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Write RCB only when it changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Roese" <stefan.roese@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930144650.3701516-2-stefan.roese@mailbox.org>
References: <20260930144650.3701516-1-stefan.roese@mailbox.org>
 <20260930144650.3701516-2-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:52:05 +0000
Message-Id: <20260930145206.4E6B61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_configure_rcb() does a read-modify-write of the Link Control
> register of every endpoint at enumeration, even when RCB already has
> the right value. Some devices react to any write of this register.
>=20
> The Renesas uPD720201 xHCI (1912:0014) comes out of reset with ASPM L0s
> and L1 enabled in Link Control. On a link whose Root Port supports no
> ASPM, nothing else writes that register before the driver loads, and
> the chip clears ASPM Control itself during the firmware download. After
> a host write, even of the unchanged value 0x0003, it no longer does
> so. ASPM stays enabled, and the first access to the xHCI BAR runs into
> PCIe completion timeouts that hang the system.
>=20
> Seen on an AMD Versal board (CPM Root Port without ASPM support): the
> hang bisects to this commit, reverting it fixes it, and on a kernel
> without it a single setpci write of the unchanged value reproduces it.
>=20
> Read Link Control first and write it only when RCB has to change.
>=20
> Fixes: 1a6845aaa6de ("PCI: Initialize RCB from pci_configure_device()")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930144650.3701=
516-1-stefan.roese@mailbox.org?part=3D1

