Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8342F9984;
	Thu, 21 May 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373299; cv=none; b=p8/FrwmSg+Xc9+bhTCVwktdrhUn8J5fIfQg9fk6heIusz1Y8Fcc7UwvNET/2zZA2dtbILxf0lEDWHWyirQW7drjifMXl4gz2HdzkZO/EtS8DpOynxMeNklOQZzHutw7E5t09u05duJqZBtUKTjV1Wgn9eXn7t0mrCU5+qO/vdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373299; c=relaxed/simple;
	bh=8/zOJGVqbG8WkMSpL0rE5OU1P/oB8KWOP88zXYNdpIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IHxOHxMO2aBxiZTkENUXfDh0Jj6jVEmD+sElN3njsffHXYG5uuNQ483HeR38DT6KbKeRjQQAQorwqnYGa+wIxj/o6U8CRE9o+BlHtTW3JNcnzYxsfTWVp+t+atbQdDj/3pZ20AtWqgT2EdGyiL9RF4+NH49VeWpgRhIRyGbXC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqTD+sH7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqTD+sH7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57351F000E9;
	Thu, 21 May 2026 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779373298;
	bh=fXNXvZeGZU6zo0w0DvYrpbPu84Phh7+Vv2XwyeB5E+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqTD+sH7PieVWqil4NR9j2NqFo84bYhpNfZEZ+sGln1yZGeXt7AW0YDlbPXRPhnW7
	 6dkt2WQOLdA0so8pkIChMaF4R9SBPm1qWj4WyAVGck2dKw06b5OeLLeffrWRxGL+Bb
	 WSL9xwJESX4Lw9nj8dQ186HiyRjJmiJbcjqB+yeMOq5A/zO7DKbvTIw0xWQkaUfFnA
	 Mq7TofFi/wfkYNO64sUkdTz46lC59hmqSp3brDTtpDBN37ue3KBpxzzlyxCxJEVpFT
	 rD7lkcVgI0Im74IQV3UG9uUp4vCCuv/PydPiz0qcl+p1GTKX83r26eCmD3mcuIRx3Y
	 u0U/QOt8mdfcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: phy: sc8280xp-qmp-pcie: Document Eliza
 PCIe phy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, conor+dt@kernel.org, linux-phy@lists.infradead.org, olteanv@gmail.com, neil.armstrong@linaro.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260521-eliza-v1-1-97cdbe88389d@oss.qualcomm.com>
References: <20260521-eliza-v1-1-97cdbe88389d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:21:37 +0000
Message-Id: <20260521142137.B57351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The new Eliza PCIe PHY compatibles are placed in the wrong conditi=
onal blocks, incorrectly constraining them to require 6 clocks and 2 resets.
--

commit 8532696e8f5cf63303348c425688fe2c2383eed6
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

dt-bindings: phy: sc8280xp-qmp-pcie: Document Eliza PCIe phy

Add compatibles for the Eliza PCIe QMP PHY's, which supports Gen3x1 and
Gen3x2 configurations.

> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie=
-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-ph=
y.yaml
> index 3a35120a77ec0..be4bbc327982f 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.ya=
ml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.ya=
ml

[ ... ]

> @@ -181,6 +183,8 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,eliza-qmp-gen3x1-pcie-phy
> +              - qcom,eliza-qmp-gen3x2-pcie-phy
>                - qcom,glymur-qmp-gen4x2-pcie-phy
>                - qcom,glymur-qmp-gen5x4-pcie-phy
>                - qcom,qcs8300-qmp-gen4x2-pcie-phy

[Severity: High]
Are these compatibles placed in the correct conditional block?

By placing the Eliza compatibles in this group, the schema enforces a
minimum of 6 clocks and 2 resets. However, the driver implementation
introduced in the series expects only 1 reset.=20

This mismatch will prevent structurally correct device tree nodes from
passing schema validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521-eliza-v1-0=
-97cdbe88389d@oss.qualcomm.com?part=3D1
