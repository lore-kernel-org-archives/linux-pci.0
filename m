Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A99313545
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052732; cv=none; b=fOXfL+ja8lUcLTS2y0HuBBSta+jlPIq6rWERMbhFOE6iXcH7jawOZ8nxHRzAkqkrsRjbmq68hOUoBvdceXNTBo5W5IeBZh5AyfK9yNHsUp08KoOJ6TShCXqamNO9qVS4du54cHvsI3amHbUBNFAEorSbO5ikxLX7LGOgss41tww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052732; c=relaxed/simple;
	bh=1kXPlKrrX/Ec1GdLFGK29DDRZ5u8RbFsbbvQtP5tITg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tvQkljmF7/PKpmZJ+21Cmyc/h6a0sdZOCxdMLbRcIwz2emLJsLLSA6F5C8cSxp6E56m9gipJWJxM73zY+vqr+ih9Rs3+apl5Xe64GIHHdaehUjp+E+3qoOHd7w22oG2gb5ji4dERCiXU+iONODwQdDDvmQDroSRgWiuetW+LM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQaz5r78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQaz5r78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB36F1F000E9;
	Fri,  3 Jul 2026 04:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052719;
	bh=1kXPlKrrX/Ec1GdLFGK29DDRZ5u8RbFsbbvQtP5tITg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cQaz5r78GCtRZFi+9UgW9Tex3D+olDMN4w8U2dxBxWtNqkuzcNHSfo7YQueD5WM5j
	 d6ABh/N5+ADtOF5wTJ9RFm0RafkU1rb7piPbDwtk/rChWxM2nlgj221/pO6qD4B+JN
	 rqHvuZS2nAj8Euvvj9f8juwOxsiY+gxLh+M/AsyRfnT05RwYOHYgXcglKx0VSAiexl
	 4YqWAOhlk7ifx1TOB2z8sHYVdRVi+PXNJSCa25KUIYhnJFDhXBzqKLy1XF9h3UsDIq
	 1A1ox7A0v6+nijUwraI9RnnektotHGvkQoSWmS/m4aMKcea/ggAPJDnu0Xv7CrZjYC
	 kHTHaPyS1p0nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/18] PCI: Propagate FLR return values to callers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <b00acbe0755fa5999491368eaac26a78d522e2ed.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <b00acbe0755fa5999491368eaac26a78d522e2ed.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:25:19 +0000
Message-Id: <20260703042519.BB36F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A reset failure implies that the device might be unreliable. E.g. its ATC
> might still retain stale entries. Thus, the IOMMU layer cannot trust this
> device to resume its ATS function that can lead to memory corruption. So,
> a subsequent change to pci_dev_reset_iommu_done() will keep such a failed
> device blocked instead of recovering its IOMMU pathway.
>=20
> Several quirk functions in the pci_dev_reset_methods array call pcie_flr()
> but discard its return value and unconditionally report success, hiding a
> failed reset from __pci_reset_function_locked(). Return the value instead.
>=20
> Nothing is short-circuited on failure: each quirk still runs its restore =
or
> settle steps as before, and reset_hinic_vf_dev() also reports its firmware
> FLR-completion timeout, keeping an earlier pcie_flr() error if any.
>=20
> Note that a kept pcie_flr() error does not misreport a normal reset: as p=
er
> [ ... ]
> and the propagated values are only consumed by incoming work.
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D3

