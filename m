Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAD47607E;
	Tue, 29 Sep 2026 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671364; cv=none; b=dd43oS3c7fs2p1JABPNmrrxA//Q2ZC/kUzmjfIB1VGEorW9ZdzIgFTP8SOKvc/ODeNj8zZmkgGVLNIQI30Fvybuv91Q5DGw/LML2HmyCnRgtGmTWuDpRtOT64WF2ugJWc0kY6Yfp6U7JIAaiQX/UBW3MQgGdjzWJcHrMYIxGM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671364; c=relaxed/simple;
	bh=kGJckGzjUH3sN2zj4PCeC1+yf+SKxMwbG8dw7Wq2d3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FVlwtHCa5C6mdSYQg1oZrXIjGlntLCxGTrImHExMcI5Bcqrk94bSTy22svK/WfM3ae06RJlm/OAaKmdvQqBv14q0par+SQed2VgvIw/2T2VcjCeLrAppAvcM00EBSFW6gPApv8jaeroeqg4gfCSRDtrCSAsTJ3Fb2+9KvAFLR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/S+kId8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/S+kId8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1801F00898;
	Tue, 29 Sep 2026 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671363;
	bh=kGJckGzjUH3sN2zj4PCeC1+yf+SKxMwbG8dw7Wq2d3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/S+kId87Cpbo0ujJC8vqMGE05k/NdYm/Xk2VJqMTXBnvTYsOdTesUO9zLcHxGtcz
	 nnuLZPgsCT2XRJGT+2BuyiyvTnbLuON356pvFk0rSm+zEmRTj6e1e7aggeHCdfHVol
	 3cSzvetYl8EZh0TAiFxHExldXdWO+WpMzPpdIAXYnHt9SeYSh/AJ9pOF6C8XzPC3F7
	 LRHw57soeH+ru3a11STneSZEfa+35KBboA6/DolZETmOSqbr0HM8VRrLfQKc9iAHpc
	 Lw96XZoV8sT4zLpP+2VoiWr1YhHcQ4DgfV8EGd29YJdCwlWVcBwhadxxS9xpnwfmMO
	 op/rSvR5v1DBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent
 for MSI handle check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929083755.458238-5-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:42:42 +0000
Message-Id: <20260929084243.2B1801F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The IMSIC device on RISC-V based system does not require ID
> remapping for MSI. So this device only needs "msi-parent"
> property for IMSIC-based SoC, and the "msi-map" is not a
> necessary property.
>=20
> Add new condition for MSI handling on IMSIC based SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929083755.4582=
38-1-inochiama@gmail.com?part=3D4

