Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75832D45B
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161768; cv=none; b=anl3MTNeoni2nCAu69sxn25k+YwnVI8zf3CcBNxx+PAvugNzS2YHfeMNM9hnBqSW2jiLOEInDGAFQNqiEXAMvo3rujYc3jxYhzc8tlyFo2RA6G2QMWJdEktVRTBSRHEGUltNKCLBX58pH4H1ZY9R86KWE2mtmqJOBYx8C0JRmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161768; c=relaxed/simple;
	bh=dSgWNlphk8ZIgjE5lGP+Plbn9mmBiIL/FaYYdF2h4Y8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjpqAVKNSZBC2g0GfduliaS0gFMiba/oVC/wyx/tdK17cy4KlxbbKVsr2TbEjyKhepBhE8YSNZGVK/8Fj6rKBZzesS1TkRSSIpI/IhoSCtlntBOTTjU7GagSAv1oqB8Sq1YJIaNVw0a0SVhLVb9pAy6RcWVOVkdol26+1hcb4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuqC3LX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuqC3LX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945781F000E9;
	Mon, 27 Jul 2026 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785161766;
	bh=dSgWNlphk8ZIgjE5lGP+Plbn9mmBiIL/FaYYdF2h4Y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MuqC3LX9KV7x0ZUnCztgO6iH4rrVYb9+6YstYvLKaTGHdiqrQLU6LWwKGer3FMzgi
	 DCjj0lsvvHsdBT3NUr50UOKs4kTAPuH/Ze/zfn0krtLupIoc4lMN7owwXhau3NtZIZ
	 tSGs85D1GvNM35dzTjGrkplOzWHSva5w4jmclL0HazYi1YV9/erpJjrzDMmb+ZtC4E
	 3IKxP32CqLshC/kKa0Gbh3bFfADkR/aT2HxQsOzdzErIteBTwcB67ZkA1MU0lZlW9h
	 +wC6HXtR7f/xldqVWWgr/D1KE6DMntvjn5Fg29EeFV8aisP0PIsvCNS6UR1lI45EnT
	 thm1cN0u3YALQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: iproc: Use the EROM outbound window on BCMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Semih Baskan" <strst.gs@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727140939.389-1-strst.gs@gmail.com>
References: <20260727140939.389-1-strst.gs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:16:06 +0000
Message-Id: <20260727141606.945781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
> revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
> controllers 0 to 2, while revision 0x07 (NS-B0) uses 0x08000000,
> 0x20000000 and 0x28000000. Broadcom's own driver branches on the core
> revision for exactly this reason.
>=20
> bcm-ns.dtsi is shared by every Northstar SoC, so it cannot carry a value
> that is correct on both. Commit 767012397976 ("ARM: dts: BCM5301X:
> Describe PCIe controllers fully") gave the controllers a ranges property.
> The commit shipped in v7.1.
>=20
> With that property present, two things go wrong with this driver:
>=20
> devm_pci_alloc_host_bridge() parses those ranges and requests them, then
> this driver adds its own window and requests the whole list a second
> [ ... ]
>=20
> Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully=
")
> Tested-by: Rani Hod <rani.hod@gmail.com>
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727140939.389-=
1-strst.gs@gmail.com?part=3D1

