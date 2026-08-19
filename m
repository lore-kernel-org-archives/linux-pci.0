Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF14490C13;
	Wed, 19 Aug 2026 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160322; cv=none; b=t/t430YufEs2aEF3vIjZDUd6TjR/IvOugeEzgGc3Mz95lRgOJURM+HWD5YfKvZOjRWmHMygqeALZTDe1VyKgvnYQ0Cy3wGrp4BRNDhsbCFAf/x7x/1PpN+HToiJq06AX0ltOK2iN6LWT0kmgg14VgEAfWKuWb5HpuusoVK6agSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160322; c=relaxed/simple;
	bh=AOilTw1gm53Ym9j39ahLZKmGPOesfwGXaH70R0rAnIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BounM8/QbJPNSxs4d+E7yM90yP9xqfZ7Vp7vBSMYuvRVUsR0rDlm1NF+ObYmy8t4pAoZ+zXSArcBeyGyq8w+PfTmEQhUe/2Jk4dFViMvzFAaIlKHIlZa4hEM1DZ+B7huNxTBw1p5OU3/fkkvIfL08qv3eMEbmBjM/2o8t0eZlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDh1JmKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDh1JmKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A649C1F00A3D;
	Wed, 19 Aug 2026 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160317;
	bh=AOilTw1gm53Ym9j39ahLZKmGPOesfwGXaH70R0rAnIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDh1JmKoQhbUnoW/0A8NSCKwevhWXodTC7/5INsOsT06NVx3rr7C7Um4cs2Ans2fT
	 Bv7i3ULQOVilBmTJeva7aaCvefMAydkGe6Mp/Y+Qv++F/xYyzDyeG1iB8cO9p8wKyQ
	 cGkKmrr/ataPOJh/VqNrylsvq+DSwZ7OPyeF6Qa2QejBztK2ZakK/W2gY69Yi2Kg1h
	 K2KEq0mT9pyB6BZM1nLh7BYxmnuvJ/20GsDLyKsgYEIFPotmOKn/jpoN2RAFnm/EpD
	 QAPYGMabSciUWZXZxA4lEc8ytsQGRtoW63AzuSDIsOi8amabJy3I0ichUAcqGXlZzJ
	 1XA4yHx0coE9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260819172057.3636214-2-sai.krishna.musham@amd.com>
References: <20260819172057.3636214-1-sai.krishna.musham@amd.com>
 <20260819172057.3636214-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 17:25:17 +0000
Message-Id: <20260819172517.A649C1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
> IP and integrates two PCIe host controller instances. Add the
> "amd,versal2-cpm6-host" and "amd,versal2-cpm6-host1" compatible strings
> to describe the HOST0 and HOST1 controller instances.
>=20
> Add "intr" to the vendor-specific reg-names in snps,dw-pcie.yaml for
> the per-controller interrupt register region used by CPM6.
>=20
> Update amd,versal2-mdb-host.yaml with separate register definitions:
> - MDB5: 4 regions (slcr, config, dbi, atu)
> - CPM6: 5 regions (slcr, config, dbi, atu, intr)
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819172057.3636=
214-1-sai.krishna.musham@amd.com?part=3D1

