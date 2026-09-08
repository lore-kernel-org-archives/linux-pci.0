Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3149AA28;
	Tue,  8 Sep 2026 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903579; cv=none; b=jQu5b7EXFpIqDxDNVwqa5O7PZfEPh1oV5UpfKHqQj5X22RXMhRCGx2hLYhnDr3v2TyG1XoA1MuxcamedRkE3zCWQhklUSUG4qI+TO9kbkwXLqB/o8Jo0CCENbzJEAST3O2Q1cdXhj5GWSO9cUhoannPLH8oPh5YF5X31qOFv4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903579; c=relaxed/simple;
	bh=PwWhbnSlJEjguxLVJLTvUZunX8TksPLLkEpSEvSMJaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uv0z2FtiQ4OqL5JkFe7BiqB4RqSoGdPYLZKJQl4paeoZkBVHyp7IBfYI5Obiag6hv0FpVR0k0+NsJpSSn2f9+PqAwhVkV/htEr9RghJPewyqGHKEw4BJV2BwrgASyzwipVvMWofxOjnuVN/bwN+ZUnkiPMDNBoaGmForN0A6NAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0YU6lNT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0YU6lNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C301F00A3A;
	Tue,  8 Sep 2026 21:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788903578;
	bh=Ld+e61O4cJNQkWBRF41aoQzL0pvjBNBwNnhY46wBcfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0YU6lNT6DECc7/cAkb4TcAA7c2umH8satejpc+yb5ik3HZ3CD82RKEuLyQNaufVv
	 7EUaUjjLDlzQWpCQr0p70EXDEctLQ0bnTse59IyfZp7U5pwhpnHxaXXLTd69+rB3We
	 wtxtxFyCAWEYzwcGZ/NHgeTP4nKzYWthOPmR3+qVJ5jL2l57elui5024QcA8/A83up
	 tddnHVRU41nrF82W1lOnc1kAmxfTqFuA+EeqaivwpfZp1XU6YfYGrz6k88+6CL675M
	 kiebA0O0o2F7WdoOORtIxCdkeySOQdWkUUytvmDIBlA7fbr7975+Jy74JeyaMVfBhR
	 xzXrkfvld68/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] PCI: of: introduce of_pci_verify_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260908213459.2519059-5-elder@riscstar.com>
References: <20260908213459.2519059-1-elder@riscstar.com>
 <20260908213459.2519059-5-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:39:37 +0000
Message-Id: <20260908213937.A9C301F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908213459.2519=
059-1-elder@riscstar.com?part=3D4

