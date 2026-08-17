Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFE3C456F
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957608; cv=none; b=L1mAkgldmRJwiYpMzAtb0B08yphUKqiKzLpIdDfdqUSxpwVUIZ9M3PK14B+HOEGdL2XE9WhxJnJUpticq7vJbAh7rEweFwOOw4meH6aKtADE0tGpOR6vu83GIGdpxG7w94XpN4+nlPKMslF/Br8fIglLfHnJ6S448bEVUCcYV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957608; c=relaxed/simple;
	bh=XjMsQkfB6N+25FTMob30+mv/Tb2p/vhC0h5bd/QUyoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aNafKYMIjT6MerXsM+ZrNLCWXyJAdVQrmNh8Cb20UxOz68yVGksI0c+q/Q4845AXThM6LI5OeIipR9VHHSfXz8/oSkhY+d6wcjEAWmfUD8jmfd+ttXrwMdKbIisplj0pKQoagRyh2ExmUTLV6SrLqOnryueK3qNJCpGjuusiYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ2abRz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ2abRz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45151F00A3D;
	Mon, 17 Aug 2026 09:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786957607;
	bh=XjMsQkfB6N+25FTMob30+mv/Tb2p/vhC0h5bd/QUyoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJ2abRz6fDoZKS8XOxCksopKyyE3AuwiBT3yU456d/e1ya8kH5ZweTF5rNn0aJUa7
	 zWoXkv1OwV4HdOne0V92lmx/wIvAy+G47XoLasXRlwQnQdRxgwdj8pxl78gBeW0e/g
	 8L3/DBrEeO+S73WkdgNgZWEZXZvtOgX8efSqWBnEbEOmDW51fWU/BVN0AG8xGk0X/B
	 tvK5MVJNeAVzXOadLvV38CH8NJvdBslfruJqACAqPn/qpOsbThcCtPV3dyd7ah41FY
	 lkCgAtQ5+AZny+7JQpnBBvKV6ExQze2vYxKdY7L3Us7FCzH/RJWm0+elJbPj5xlOFq
	 goaEg44F8c6Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <thorsten.blum@linux.dev>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260817090011.26011-3-thorsten.blum@linux.dev>
References: <20260817090011.26011-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:06:46 +0000
Message-Id: <20260817090646.D45151F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> returns nonzero, which avoids probing functions 1-7 on single-function
> devices, but also stops scanning when a function is absent on a
> multifunction device.
>=20
> This can skip early quirks on multifunction devices with holes in their
> function numbering.
>=20
> On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> 00:1c.3, also documented by the model list in commit abb2bafd295f
> ("x86/quirks: Add early quirk to reset Apple AirPort card").
>=20
> Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> is silently skipped on these machines.
>=20
> Check function 0 first, and if it indicates a multifunction device, scan
> functions 1-7 independently so that absent functions do not cause later
> ones to be skipped.
>=20
> Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817090011.2601=
1-3-thorsten.blum@linux.dev?part=3D1

