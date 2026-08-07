Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D90318ECD;
	Fri,  7 Aug 2026 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112358; cv=none; b=Yv0B6XGg3l02NQ6WNBg0W+BFk+Z66OsOBR+xeBrKSofh2Cm/goo3dvQgpviOlRAZ4g5ZiXG03cjueiBTrrNA4n6zUZLznivfuQY+8IPyqmTKGCV5kPlpeDxbKlQWHdaMLJw/kpUsxg7lFusMjJfwdxej9SXaME+i3EjFA+Dg82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112358; c=relaxed/simple;
	bh=GoXpUay2PTSm4kM5NvQFUz2gIsbh4vhnmGcXD3Gy0ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEdpqGlWpTQlkl48smM1I9IAQWIdVAR1nut/VSR/fQVWJsGTFp4rezViGfZ3Er5KLvEOrJhQHvxNMYieuDleYPfpLh5sOPpa1qu3mwV1J1iiAyLAVwFHCVGD5L5iuOvOq8VJDwi19zvcdtH74sQ0/riVDokMxpMCT/WWmlGmIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVsePdVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVsePdVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BB71F000E9;
	Fri,  7 Aug 2026 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112356;
	bh=GoXpUay2PTSm4kM5NvQFUz2gIsbh4vhnmGcXD3Gy0ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JVsePdVf2Y/7g/w9l7oQIS8utyiN0na39kz7EWB1/dyG2xxey3nmSyjbzmSqTQbMb
	 Cgohy4ABKLuM2awbtgCT/SXMzhe+/YxDdnrsa5wl7XrTLdAlNKGo15X4U5lDroMo7Q
	 KCuUvVX41jGgL6EC4kooT7D/hd3Wm/l30Bcs22NTYhwY0aoUqDM1Lj2I6BUvQbL9wg
	 wD5qvAUtGhFR0y1HaEPWFC/K9kmjEAYwOYcSin04fM/WHrWL8sT/CuQciQo/Or2k6/
	 zJecAo7O87P74JB7fR0WlHyoNQz5ztU+Avndacb4B11b94x4vNAIKq+rtbRUVGiAln
	 GctDo6Mj8qjGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: PCI: xilinx-versal-cpm: Add PERST#
 and reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260807140205.1070367-2-sai.krishna.musham@amd.com>
References: <20260807140205.1070367-1-sai.krishna.musham@amd.com>
 <20260807140205.1070367-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:19:15 +0000
Message-Id: <20260807141916.91BB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the optional 'resets' property to manage the PCIe IP reset, and the
> 'reset-gpios' property on the Root Port child node for GPIO-based control
> of the PCIe RP PERST# signal (assert/deassert). Both are optional to keep
> backward compatibility with existing device trees.
>=20
> Update the examples to show the reset controller and PERST# GPIO wiring.
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807140205.1070=
367-1-sai.krishna.musham@amd.com?part=3D1

