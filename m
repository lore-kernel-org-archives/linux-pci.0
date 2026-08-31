Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501183C13EE;
	Mon, 31 Aug 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161764; cv=none; b=RfCxnYDBMcGInoyMFVm9p1rjyNVo4a9R2/w+4JoN1vV+ncTx4wQ6laFbr3Tvkw65eEdVduPhhlhHDga9KVhWVlUgnixHDdlz45wvU0yLa0SiDhoC0rBAnVTkdzOtUGCqiIgCNRLOk8748dRe1z76L2DgHycSMi1U5HK6i4ZU7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161764; c=relaxed/simple;
	bh=THf5z2gfo1uoicsnLSMW6DTHLolUNav78BaF2vXFkSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FXnu8/lLsexTeIGMcEYwlrATKxkgdfZN8MDw76wTE/3pNT7Lw1nIOezzGczpm1d0gZEuNNl7Lyjt8E9VGGBDH2mN9kCifi3t4lGw2kRE4RFaIjJzaoxt2MIjNmPKLIz3alkfXb5M/RkJvh2mYGTj8lDReIAnLLFf8YWEyFzkudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbHxxELH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbHxxELH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0A21F000E9;
	Mon, 31 Aug 2026 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161763;
	bh=XZ1ojzXpjvALSsW1J2HhrT3FxnBEgPvR4qHa5xPNNnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbHxxELHj8EIsUsNJmg1P3WAmZ97v0Wf3zyMq0yNAeqghBtxVA/LYIkhyNZj9Wp0H
	 h0tMbTz6Tfm11/74Q264Nf476ekJbZ47KHqmqlC+MX/jdOR5WXChFNlumgvT0/bA04
	 2QHXF5WKp3tRXPP1OQ8k4+KDJ6euk8IKbNMVGuu2N12VrBcmmwtHUNb8PMYQm87O2q
	 qg6/D2eNpfrT+2RAjiSMZMAhNpDE/Nz4O4oAOpvvCiOqtUtXzpMjwN152J2AQh9LCw
	 nNLCOQpwe65sqUW7Vl23erqbOi/MxDaYRJxaCDAqeUC5xPHNDfooQg8WcUteSono/A
	 YVJksbMrTtQOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: PCI: qcom,shikra-pcie: Document the
 Shikra PCIe Controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sushrut Shree Trivedi" <sushrut.trivedi@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, olteanv@gmail.com, robh@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20260831-shikra-upstream-v2-2-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-2-406661d75afa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:36:02 +0000
Message-Id: <20260831073602.7D0A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The binding schema fails to structurally enforce the maximum lin=
k speed limitation of the hardware.
--

commit 97340dc07e6512ba3b927b4bb3ca4453e76e80c8
Author: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

dt-bindings: PCI: qcom,shikra-pcie: Document the Shikra PCIe Controller

Add a dedicated schema for the PCIe controller found on the Shikra platform.
The controller supports up to PCIe Gen3, but the PHY is limited to Gen2, so
the max link speed is restricted to avoid link-up failures.

> diff --git a/Documentation/devicetree/bindings/pci/qcom,shikra-pcie.yaml =
b/Documentation/devicetree/bindings/pci/qcom,shikra-pcie.yaml
> new file mode 100644
> index 0000000000000..73b8ec722f2a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,shikra-pcie.yaml
[ ... ]
> +description:
> +  Qualcomm Shikra SoC PCIe Root Complex is based on
> +  the Synopsys DesignWare PCIe IP.
> +
> +properties:
> +  compatible:
> +    const: qcom,shikra-pcie

[Severity: Medium]
Since the commit message notes the PHY is only capable of Gen2 and the max
link speed must be limited to Gen2, should we structurally enforce this lim=
it
in the properties block?

Without specifying max-link-speed: maximum: 2 (or enum: [1, 2]) here, the
schema inherits the default generic limit (maximum 5), allowing invalid
device trees with a max-link-speed greater than 2 to silently pass
dt_binding_check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-shikra-ups=
tream-v2-0-406661d75afa@oss.qualcomm.com?part=3D2
