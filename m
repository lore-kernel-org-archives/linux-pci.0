Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60F2D0602;
	Mon, 20 Jul 2026 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560656; cv=none; b=pBJCen30ysErT3UXORdYK/i0WYj6F2YlObasK4np+Fry2Dc+xDWPmob2OMbDbUczSD8upQHDOMkRCKl4rc3GGC5EeWCoG/u+MtrjKjPiDDyFfbaoBjeCFnyItudWETA/qv0aVfHTeEGBkhE7bSKMzsOxfVWER7TYPS8IJvph8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560656; c=relaxed/simple;
	bh=kQKeHQW5Hf9Oh+OLiAkewPX/VETX7xVtIz2zGnWEnr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VyH9/8R/XgvguB1/vHepB1u4vicCFcspyic8IIqQUE73dn6QYBtx8JqkPOFBJorqnDwR/AAvKKcRdE3VyHw2Gjn0vGQjql7kdRt7wWC6Po5C6XLIl7OmCd03yKHRjVQpJyNWtQMz/020Xz+xcINz3vpaAr5uq7bY9pLmGShYM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUIvap2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUIvap2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAB91F000E9;
	Mon, 20 Jul 2026 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560651;
	bh=kQKeHQW5Hf9Oh+OLiAkewPX/VETX7xVtIz2zGnWEnr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUIvap2xjB22A3fiIQSiYDrXZ4w7iffoc845FjQ6iph3LceewYmde3Hhh34us3iPp
	 4DUTGKnwOkrXBXUM0poE2p5dF7PC2ISL9koeKovkRVZVDo8vnbQ8WV3aQ5d5tWjXlg
	 004GeVU3M3Ksnd0KX1010+vYhgsTtT+9JI3RWfr6Gv4QB3t5jEXCLqP+9Wy1SwNaHv
	 hxcDj9O22XwszEc1Gw11KPD11y9p3yu8jHSm3x4dd2KL9JnvnhP1K0Xi89RH4IZVcX
	 a4R74z7rui469MbSIIEGZjQ1jqRcZPQSQ+eo+6h7fxPl3UMpcCyDmy2IEJqo4kkZ0p
	 bmUNqVaXP3SIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/16] PCI: dwc: meson: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, neil.armstrong@linaro.org, Frank.Li@kernel.org, linux-amlogic@lists.infradead.org, imx@lists.linux.dev
In-Reply-To: <20260720150619.24733-6-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-6-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:17:31 +0000
Message-Id: <20260720151731.7FAB91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> dw_pcie_host_init() calls pp->ops->init (meson_pcie_host_init) before
> caching the offset. Therefore, inside .init we must call
> dw_pcie_get_pcie_cap() to obtain the offset (the helper will perform the
> DBI read and cache the result). This is safe because the hardware is
> already enabled by the driver's own initialization.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D5

