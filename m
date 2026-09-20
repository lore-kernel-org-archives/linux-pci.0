Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4034B1A6
	for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 03:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875937; cv=none; b=SAFTEfCc8v9zQi39tBvsgSc/NxQ0weEEd32z2rgxWlFPvtZVqABC0WGzms+41SMEhH7M1sOmp5r3yDtnJ76arFQrm2ihWPJWW2quKcx4npS/voS3Xir0I3FlKMoMnobCPo4YFS6QFXD7OWSTacCwl5qKv+RrmCyQsYrPh7VB0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875937; c=relaxed/simple;
	bh=u1dEeBi00JMqZeFmAy1HyhtDnn9h08Tp/JnnFNpWcsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TmkP80RniuWZv6MyhX9PxSyIJlP80pdxQR6CIXIzSxWrKyGt3Z6ySEg+OzHEw71UhPHyucCighTnc9H8MtsgSAS49mw+J2XLpm+K1L2tDeqHguBxemX/beK60Wula+iMMXEihqqtucTIXdePkwpUjEj3iA0YpG1YtEPp+u8uj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPuAVcxI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPuAVcxI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618561F00893;
	Sun, 20 Sep 2026 03:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789875936;
	bh=u1dEeBi00JMqZeFmAy1HyhtDnn9h08Tp/JnnFNpWcsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hPuAVcxIrP5+uvzEusrupGhAI5sN/MVBF265EyF6G3chsBtQn5Uu7TfC8q+kX8to5
	 OrmpF97isrLrG9a1ZcuV+JWxeNiNvndHaAnNhGDK6f6y73ImX91uMD76y0HA7Zchfa
	 0ulbd+IpQclGLkzrXK5DQToc2cG92ubPliy/pYN0ckAm4zl5iwYnPvtYdc8iZXNHM1
	 KPO4SOiS8ACnjy1gXetQMn3hjIY5gseaV+JzYLfe5d80WT0V/wP+Dca4OZnzh+SBZv
	 mqM0Q9Z8f9ZypUVtTlYqpfP2kiR6XyxFqioEXOMVaC64H0Q02JJlfYFm0xuCMg6NFu
	 PPRgwu/CFgAww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: eswin: Publish the platform driver OF alias
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <hppiscas@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260920033737.13957-1-hppiscas@163.com>
References: <20260920033737.13957-1-hppiscas@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 03:45:36 +0000
Message-Id: <20260920034536.618561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PCIE_ESWIN is tristate and eswin_pcie_driver uses an OF match table, but
> the table is not exported. The resulting module lacks the OF alias
> needed for automatic loading on an ESWIN PCIe host controller.
>=20
> Export the OF table. Keep builtin_platform_driver() and the intentional
> absence of an unregister path unchanged; module alias publication does
> not require making this interrupt-controller driver unloadable.
>=20
> The issue was found by our static-analysis tool.
>=20
> Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920033737.1395=
7-1-hppiscas@163.com?part=3D1

