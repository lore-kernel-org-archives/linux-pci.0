Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AC73BED4F;
	Mon, 21 Sep 2026 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989010; cv=none; b=ltN6DI92D7YL5TjcssLYQvLEMCk2kLnPNfsoIWy6dM5CqcawZVcdrABurRvmq9XCrATyoBof12GI8zlAPKeKLocDjO1OMrc1h21CN9z0kgcIlvEqDnHUC3xNYZH4+RvYl5nlCsNF77yU6DMihwiMlGZDdskF1CePzKSQ27HS8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989010; c=relaxed/simple;
	bh=JJn6wSf27kNFuCZM7DptDuqmnkk5h95PDPqY1aCVerI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EyxiTVHdQsBznldscPjgj1DDubaAZ5p6iteZcDDtnPam4BqiCEe1JVvsw40q/LcIxTYRxJftwz7XKPuwU4PzcKvN926pfm4k/Xxwz6ngr+kSL/lFehNpc0409CPxAup2MdCSJ+BZn1pvIPsFe+zSrEuLeW2UUcOW4zUi8o0nXZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1UvCnHY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1UvCnHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4841F000FF;
	Mon, 21 Sep 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989006;
	bh=4Q3bDigOlcfpvCpMmi9ikgHhneOy5h8tNUgqTX3xxiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1UvCnHYpP+4853Goc5Qpi9SiS5OUIyIJZnpHJVVvTjtgsmjlJIH6lP4leTycaUhl
	 ioKzH4FHj+HBQX/NEE4FbnA1kriaytKgYiEcSKf4n000vWgBlCnjdjc3qCNNfbCqAa
	 7hylIge2gh6Sjc3MVTZhRc00JLJdUqifd9/tcOj48QQPM8bocovaqe/JU10cCca/61
	 aNf96P6xQWz1JeWc6S3PlwjauKVVRTKh+G2h+2M9Y2KFzHLn3f4+IhfmHNzK6r1LAs
	 Gfj6nEshdWHlXeM5934vFDgeg/CWqWx7PoyaTZkq7/Fjct4EuemkpsQG9ZgKV82KRo
	 5v8vupBvfx8uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: PCI: qcom-ep: Add QCS8300 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: olteanv@gmail.com, neil.armstrong@linaro.org, robh@kernel.org, vkoul@kernel.org, linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260921-monaco_ep-v1-2-63c5282fb0db@oss.qualcomm.com>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-2-63c5282fb0db@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:10:05 +0000
Message-Id: <20260921111005.BE4841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing QCS8300 compatible string in conditional bl=
ock
--

commit e543ce399a6b1c737f9d5a524c907cd7d96b4ffb
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

dt-bindings: PCI: qcom-ep: Add QCS8300 compatible

The QCS8300 PCIe Endpoint controller is compatible with the SA8775P PCIe
Endpoint controller. This commit documents the QCS8300 compatible string
and its fallback to the SA8775P compatible.

> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Do=
cumentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index bed9a40b186bc..7f9a0bc958d1b 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -13,10 +13,15 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,qcs8300-pcie-ep
>            - qcom,sa8775p-pcie-ep

[Severity: Medium]
Will a device tree node using only "qcom,qcs8300-pcie-ep" silently bypass
the clock and clock-names constraints?

Since this compatible string is now allowed as standalone in the
properties:compatible:oneOf:enum block, it appears to be missing from the
allOf:if:properties:compatible:contains:enum conditional block enforcing
SA8775P constraints later in the file:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - qcom,sa8775p-pcie-ep
    then:
      properties:
        clocks:
...

Should qcom,qcs8300-pcie-ep be added to this enum as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-monaco_ep-=
v1-0-63c5282fb0db@oss.qualcomm.com?part=3D2
