Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F6445AD3;
	Mon,  7 Sep 2026 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780954; cv=none; b=sN/RpmGy5oMh7CLDD31dSuY27wgO1Sa2eQ0PXuIbbZY5UQB95jClAYPCPjpwO89JA/b/0DtjbKRf/c4bw9nOIF8CRIg+MEhhg+W1tWm8PyGSAtONRi0hjOgA60MbuTtCNqS3UnZ4FEU9dt7ESKZ7+geOVGBA/6k3NXPC0c17vuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780954; c=relaxed/simple;
	bh=VwYxdIDLOrha6IPI8gJtgMxjpIPwLrbnbxn666dpNIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HsXg9XB/Jx30Ty6j5SBImYfTDrYfUO678ogF6zA+aE7hkrzw1EDMbBl42Y8Tr4qlsgDK4dmYatdwTkekhCfAzx6DyL9zk27HEO42W2/clgiSahnxCHs/FVkkPAF8sgPwCowg8ZUqkANwwVY7VGmELflnaxxVr/NMAd5GARtkEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2iLVxfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2iLVxfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1E11F00A3A;
	Mon,  7 Sep 2026 11:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788780953;
	bh=VwYxdIDLOrha6IPI8gJtgMxjpIPwLrbnbxn666dpNIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O2iLVxfr5GnOj0UPLdxJn2m/5e7k3oEuxY++M2IDKlDRPn6dlo8agQM3klaRI8CU5
	 DU2k6hsP1j06v3oav6MW0CwdSNX+nldRvmTbrhdtN68+iP6WNTRjFNTMhQDpdJCmOj
	 7ANbHldIebhZ1eglvADi5v1TZTkw22uWjzCDHe0/FSNhuAq90qCy83QIeMvW2TVu40
	 zwRP+Sxj5s27fdCErKW4q5xWwAKtiRN+MBAHxfuCpppR5LxjU2yixDfcFTyQF9HqtQ
	 aIXIGJYCUOQ/eNSorYPauupzgho2BP0JQ1fi9AAgKnStupPXpT7RZdkxTUqRLBPaTX
	 107MlRl8xb9nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent
 for MSI handle check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260907112606.465778-5-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:35:51 +0000
Message-Id: <20260907113552.9B1E11F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907112606.4657=
78-1-inochiama@gmail.com?part=3D4

