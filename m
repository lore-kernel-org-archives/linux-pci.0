Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A02D661C;
	Fri, 31 Jul 2026 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785461118; cv=none; b=WAx/hl0mepdAq3B91suNLl3nt/JCXax6DG1pmqmsmOR85FLlYvkP+CGJoC46S6IrIP3CAMiOi/+++4OOwo2OP1D96ZNGUdD6Mb9xcr4zLXqsf6vZbSiHhXO/oIewbIz5L8bS+QCZh5WhvqyVN7DXHhG/MOtKhO5kTGikd58laic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785461118; c=relaxed/simple;
	bh=UovsrzL3Yg1zTOEYvS+BcSdP4T8fxL9IyqTZVZGHIfQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SQa20n+XkAbYt1VCzcfJqoc9gxkLkTXx5Hqba0MLn1I2N8VgPn6FcBltV1EMOegQO/JMU3quHIUk2V+gGrjQwQYw15nAcZkJipJsSEI5N3SGuIcsar7KorNBug3jRL+vIt29fbu6L890X6LPlOhUL+/qLMGMb+b9DjLwMUtlA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTQL6Mfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTQL6Mfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC6C1F000E9;
	Fri, 31 Jul 2026 01:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785461116;
	bh=UovsrzL3Yg1zTOEYvS+BcSdP4T8fxL9IyqTZVZGHIfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTQL6MfpSXDry/GLr3TqXOPR1hKraDJsZxvFUpIe6TZIoXSlepJtfmB60jKtqaRVN
	 nKIRnvTh16/2ahI5Q+btxnnZHOf+FeL1tVLzUjsdGhF63GGs98Y2V6vfLoyLovg+J8
	 WrKC8Cxq9r0Yo61AmQtTx+z4AE+zqryUFOaq7VqeShKx9t9PIRkma2WDFEG0WoBb9Q
	 KvUCm2btk0lKD9NdmBcH5O4Iab7+gRZ80HYSNDf3m489pc3gUaD3oodWdYN+pnkgoi
	 +PCg4itpdG8GjgSb1ZjoqrknTOn/VjUht48n/H7YOS9SQXELlrHGim2zWF9QY+FDKK
	 H5h+tUeQcKLMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: pci: ultrarisc: add required DP1000
 PCIe clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang" <wangjia@ultrarisc.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260731-ultrarisc-pci-clk-v4-1-d738b491e49a@ultrarisc.com>
References: <20260731-ultrarisc-pci-clk-v4-0-d738b491e49a@ultrarisc.com>
 <20260731-ultrarisc-pci-clk-v4-1-d738b491e49a@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 01:25:15 +0000
Message-Id: <20260731012516.1FC6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jia Wang <wangjia@ultrarisc.com>
>=20
> Require the DP1000 PCIe controller nodes to provide clocks and
> clock-names, using the standard DesignWare clock names "core",
> "dbi", and "aux".
>=20
> Fixes: d9ff07f45955 ("dt-bindings: PCI: Add UltraRISC DP1000 PCIe control=
ler")
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-ultrarisc-=
pci-clk-v4-0-d738b491e49a@ultrarisc.com?part=3D1

