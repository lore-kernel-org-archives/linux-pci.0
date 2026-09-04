Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF93F1AB7;
	Fri,  4 Sep 2026 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530950; cv=none; b=FdLAtJ1C98dvwrJQ/HPOQp/lpTC4+9Jwh7I2AK8XoDIIT3uwAUzXEDAnOirIpAwKLt2fWKuhgiIX8Lcpz+icIE05RXFa2o6WOznyalpAKAH6mvYWk2Fp3PkD1C12+73LlDFM5vkh3skGcNN/oPROVgmKtLTkf3NEkj9nA5ECOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530950; c=relaxed/simple;
	bh=Zj9h5S2VXafl+CTynjxHlzAG4klzE+UAyteWh7bfOK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nij/ltZU3Mea1AN7U3oFWC0Q1NMksGc2OQHK5YYyHewLT8XgfzdSIqjm3DfJJVABLvm7UVPvaShDZtsjmIGSgm1hqDi7nT/IiPv0/dUcWfQ22bh0zLKtvmTjr1X9keReAqL5rcAYN8gOOS3JZSjug9I/41wn4AuAOk8X3Saj5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbkdWWcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbkdWWcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5443C1F00A3D;
	Fri,  4 Sep 2026 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530948;
	bh=4B6tJbNxk4UUtCkA2PmEgMU8FmOLXGVSLferrCLFqyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbkdWWcMCcD6ufZREkNEcOrStBoUkNP0vRIK5pSdeEquX/RkBtj+0tktY+0T2eIIj
	 1dstKVYYQUN8Q6gHsUZcW766RgKh+yDpDDySnBwvb0PrITWgG6Ixjjir0ZS8Z0UjkZ
	 S6WWhjCR1PV2dSHKLSMJVz3Li/HZepNaGgCXyzgwpeO4CpnBCerfZ9iRaK4J6VF3AI
	 Gdlo0spOxa2ddaW7vN8f7FBrd1SMDRGgxkHU7ZApcLRnaNVZiCibrwGjp74/rHFrUn
	 1Ei8fH+sCIizoXiPjOy17ycWWOWyWXRQbIsnM13+q29Ae6anWNHqEvRq6mhBWolAsk
	 NDyrzxAI8UFbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] PCI: of: introduce of_pci_verify_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904134607.1856121-5-elder@riscstar.com>
References: <20260904134607.1856121-1-elder@riscstar.com>
 <20260904134607.1856121-5-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:09:07 +0000
Message-Id: <20260904140908.5443C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit 407d1a51921e9 ("PCI: Create device tree node for bridge") linked
> the PCI enumeration process together with devicetree, creating a devicetr=
ee
> node for discovered PCI bridges.  Its successor commit ae9813db1dc5a ("PC=
I:
> Add quirks to generate device tree node for Xilinx Alveo U50") shows how
> to use a PCI final fixup quirk to also create a devicetree node for a
> non-bridge PCI device.  These changes allowed devicetree overlays to
> describe components downstream of a PCI device, by providing a place to
> attach the overlay.
>=20
> Note that the dynamic devicetree node is only created if the device didn't
> already have an assigned node.
>=20
> Later, commit aa7b4bbcb3a1d ("arm64: dts: qcom: qcs6490-rb3gen2: Add
> TC9563 PCIe switch node") *pre-defined* devicetree nodes to represent the
> PCI device nodes that would (also) be discovered via the PCI enumeration
> [ ... ]
> property, with value "pci".  We also accept "pciex" as the value of the
> device_type property for bridges.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904134607.1856=
121-1-elder@riscstar.com?part=3D4

