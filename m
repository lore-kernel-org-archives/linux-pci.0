Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF889366075;
	Thu, 27 Aug 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855276; cv=none; b=TsuzLNqoSOJf3sdiIcxdn4Dyh0mvwIfdZVrgVG26r+oievIc5hwvbkoHrUEZcMJ17Pn/1ii1OR5FF0FJxNH0XVJ0ap0lZ8z8UKKNoa9/QMugcSNjrxA56vJGLYiVqfBlQioiadEsHJSn7eLwRBreexX/yKq4A7K3qMJI1Nw9VdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855276; c=relaxed/simple;
	bh=gsx8Vq0iiFDxzgOliFD2WOCypCVzy2KWLuiUYfkP+m0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ry8R9jabGJnV52mKuWxdJXj+d3cb2z0MtvF/X1np8CTsFxcOQr/lNnuGODRvIkYWB/g/gAQJLr3XnCFV2MbLl8TMMjs+r5vgCRZCi5u16u74LJTRi6cI1mdCsB68E/56jrVf8e6CtvuhRgqfLZ1ktj06FwuXlbS1fMxEsy7rsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD/HjMt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD/HjMt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B651F000E9;
	Thu, 27 Aug 2026 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787855275;
	bh=gsx8Vq0iiFDxzgOliFD2WOCypCVzy2KWLuiUYfkP+m0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZD/HjMt+gvAtSGBXY1rZpHbflHmq6rA/9InBLCdFalnXA5HTDa5UisHBSu9GgSdpC
	 5XqM7S5+PmD1GQ0Q8P5cOW9pQAiNswQKkK+yCERcfMyzNhLFnWR7g0qajDYMJ2UvCL
	 ptRAGwUN53uGazzYNFlA7Cf0f0u67N04F6KFnCZbbrurqHR+EzmuABLUXRZ294bM4c
	 SsBPzKIsQ9+Y97BQ03oyMQ2uW0cAkK5D1NuQYSZhj9qHwBupz+ewnznMCgYxaKyqEO
	 gO83QIvfkyNQnOw5w/fR02FId7Q/46duJtdia+e090eZBrDER9JiXSQSVFG2IZrreJ
	 gYyKutieSCWJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: Support hardware-owned MSI-X table
 and PBA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260827182012.1984960-2-den@valinux.co.jp>
References: <20260827182012.1984960-1-den@valinux.co.jp>
 <20260827182012.1984960-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:27:54 +0000
Message-Id: <20260827182755.26B651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Some endpoint controllers expose the MSI-X table and Pending Bit Array
> (PBA) in fixed, hardware-owned BAR regions. The EPC set_msix() callback
> currently receives only the table BAR and offset and assumes that the PBA
> immediately follows the table in the same BAR. It cannot describe a fixed
> layout whose table and PBA have independent locations.
>=20
> Add struct pci_epc_msix_layout and pass the full layout to
> pci_epc_set_msix(). Leave layout selection to EPF implementations. For
> instance, pci-epf-ntb reads the MSI-X Table from its own BAR. Using a
> fixed layout there would require a way to read hardware-owned Table
> entries. Add pci_epc_get_hw_msix_layout() for EPFs that want the fixed
> layout. Update the existing callers and validate the supplied layout.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827182012.1984=
960-1-den@valinux.co.jp?part=3D1

