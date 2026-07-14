Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0612E35F193;
	Tue, 14 Jul 2026 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783992296; cv=none; b=kBB4C6CtC9CwSLRjciOPjXaxOz3nLLhtoFcwanxvcaPvpbClRRdsUFCIUIHK2lIdiC8C0BPeORfWoUwz1DU+c0aFuMEql3EA8jAvEHrkItuj6pbmGtIleLbkBrVdpixLpUkNYOtuaKDviWwe4KYU24OhSul/4IfCzesGGhj/ZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783992296; c=relaxed/simple;
	bh=+3CjGrzNfGi7D7HdRPZFQSdt4JuVA5AZSOA0yxhdMns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0LhK09GMX5BsvM/0Kiu+S+SMm01cmvsANLToi/Rg4Rw0UHs6NtGZ7vMK4rzjtHl8zocIdapXURb/qadgKkN6gq/JGK6XwRdlcWTOg6ABGgfePEzuC7dMZwve3cU+BAo495R939DgPNvTqS1Y//TAkB9Xqpcqp/SKqY/uIeJFXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRu4CpqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRu4CpqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D1B1F00A3A;
	Tue, 14 Jul 2026 01:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783992294;
	bh=6F1a4emDdCxMFhN8jLfPD22diUhuH+XjVSblcnLaZ4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KRu4CpqYMVGRrGsDkO58ZcRtMHV37SSJVjzMXpernE/pE2+tLS/VNAxf59xV3etid
	 TgSGS0lsUZBYdg26Genoa3s3Mjk6wkbX8254T8QpL5nO+iwvknQnHxbjE5XI0LkptS
	 f5c+RfcU/r2S0XZIlQZ5DRook9A8M46d4CXkYbhRj8S67yUeceZzzQO/9zqDc5lENL
	 3Ixt6dk13Hy6QCN7xPp3cZghiFIxjpZhiwJZWdDrAp5BtLgqcSyaRwM5AcVLbO5sZG
	 zNdlONrjHdIeNoIwf+KVZJMHhAJ9OIAVqcbpAxCHXvyGq3OUsYeTHkPAwENmc2U3o5
	 vsJ0GmsQYA1hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: pci: ultrarisc: add required DP1000
 PCIe clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang" <wangjia@ultrarisc.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714-ultrarisc-pci-clk-v3-1-e72723fc0ef1@ultrarisc.com>
References: <20260714-ultrarisc-pci-clk-v3-0-e72723fc0ef1@ultrarisc.com>
 <20260714-ultrarisc-pci-clk-v3-1-e72723fc0ef1@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:24:53 +0000
Message-Id: <20260714012454.55D1B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing driver clock management. The DP1000 PCIe driver fails to i=
mplement support for the newly mandated `core`, `dbi`, and `aux` clocks, le=
ading to unclocked hardware register accesses.
--

--- Patch [1]: [PATCH v3 1/3] dt-bindings: pci: ultrarisc: add required DP1=
000 PCIe clocks ---
commit 04ce10fff5fc6c7c7dc6e7380ab1ae6a1209bb14
Author: Jia Wang <wangjia@ultrarisc.com>

dt-bindings: pci: ultrarisc: add required DP1000 PCIe clocks

This commit mandates that DP1000 PCIe controller nodes provide the standard
DesignWare clock names "core", "dbi", and "aux" in the device tree bindings.

> diff --git a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.=
yaml b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> --- a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> @@ -43,6 +43,18 @@ properties:
[ ... ]
> +  clocks:
> +    items:
> +      - description: PCIe core clock
> +      - description: Data Bus Interface (DBI) clock
> +      - description: Auxiliary clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: dbi
> +      - const: aux

[Severity: High]
This is a pre-existing issue, but since these clocks are now formally requi=
red
by the binding, does the pcie-ultrarisc driver also need to be updated to
manage them?

Looking at drivers/pci/controller/dwc/pcie-ultrarisc.c, ultrarisc_pcie_prob=
e()
does not appear to fetch or enable these clocks. Because of this, hardware
registers are accessed before clocks are explicitly enabled by the driver:

drivers/pci/controller/dwc/pcie-ultrarisc.c:ultrarisc_pcie_host_init() {
    ...
    val =3D dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
    ...
}

Will this unclocked hardware register access trigger a synchronous bus error
and kernel panic during the device probe path on boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-ultrarisc-=
pci-clk-v3-0-e72723fc0ef1@ultrarisc.com?part=3D1
