Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CB50AC00;
	Thu,  3 Sep 2026 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469051; cv=none; b=st+jVqzlGk85c3P+KmiR7MulxCYD2nBMJ2r5ghDUR/LfayAFkMmX5e11R/h5wbRzDLYzLSHa9O3lQk2weiJtKR1YOVRW92S0KQdCPfZMCCEymMd8pNN8qU25x7cJql670/Vt2biZRgAKwd9O/L/GRdWmidRSiapJ6hEFvYOGEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469051; c=relaxed/simple;
	bh=L+fEmJKz+rhvghPXacD2T72+d4iNguuCfIN4uNAeM+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L8rk2RZ4g97n3pj1uHa4rNTuHiP19uGU//MI8yVaKYIErd4P6xVIzWSToqn8WDhRbgqjZWBMrshJYlfcr+Wr8dpr1Y3H/+LfhB52EKSTx5lwTUoHVQcALiuynT3Sr8bfxHRn/qGrfekD/ThKAv497K2zfeDnaM9FP3KYPcErwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAZQKj9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAZQKj9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239221F000E9;
	Thu,  3 Sep 2026 20:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469038;
	bh=L+fEmJKz+rhvghPXacD2T72+d4iNguuCfIN4uNAeM+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MAZQKj9NOS3wAVu2hsQcpVw+YQOQ+8a+ufOKGPvbXizDTKmxBcUnK37oFcQAsV1SQ
	 9BLZovX3Y9bhlQ1fIL5SPlv2AkC1nsQahYCbEm0BUXVIarLH7XSUWzG8L8hgwCKGTq
	 83eIIlDJfdk8gHOOIkSUkXGCdUJ1Q9vj96nxzgh09KaLhOyMj9qFoNIhslVtNz3TCw
	 F4JM+VS83dZlr0kD5sjTNCD7Lmzho1bWhfDvgNRYduTOgsqV189SiywvG5+eoTyN7I
	 N9sK7RVEssaTtJZNBj5lM6hEmG+6KCq20TAKhxN/6jk3FfxduM6jYtqPQpdxSmm8cz
	 tKIB6W+WELfFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: PCI: rcar-gen4-pci-ep: Document
 Application/Local register reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260903205153.283553-2-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
 <20260903205153.283553-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 20:57:17 +0000
Message-Id: <20260903205718.239221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The R-Car Gen4 PCIe controller does contain core reset, which puts
> the controller back into well defined state, but it does also tear
> down the PCIe link. This is called Application/Local register reset
> in the documentation. Document this reset.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903205153.2835=
53-1-marek.vasut+renesas@mailbox.org?part=3D2

