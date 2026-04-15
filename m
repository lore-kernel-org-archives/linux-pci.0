Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F532D0CF;
	Wed, 15 Apr 2026 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245051; cv=none; b=KlKhD7xZzaYPYYpe6ddbwhnlKO7wFz/0vXB2+FNTgOhI3jJt7EMgFCrEL87Nyh4eEG7xBUX0aY6+2UQnKUQd4zjgRWoZULwMjw5gvlrEq60yGROPnt7FdwNwBVQU2hW0Lstxu+u6+9kyAddD5SUDQgb3o/2XWk+9t68gOypfwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245051; c=relaxed/simple;
	bh=wsSRf+FgtSM4Tmbmls0rwxi6ii/1NE9W0IbBIkaPRi0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=eXP++HTpUQyQ9NBb/SUvKN+bzgT0rtl+Y/as50+XFIe1foo5syxB1DULaGeAIIDffnnjkPFFhfiLI5hGxvexVPTWOabCSjL+U+Yiewv3oem66CUwvuF4pvqKVLcE/5l8iOwCVUu0T1rUVdQb/AOlnqYgmiNyA3ZmM0pj3sxMRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JypY5ms0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JypY5ms0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB9CC19424;
	Wed, 15 Apr 2026 09:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776245051;
	bh=wsSRf+FgtSM4Tmbmls0rwxi6ii/1NE9W0IbBIkaPRi0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JypY5ms0Oq9lbJcBPtM6l1MYZ3oGXeytjMCYXkAPu9kQAfw9pNXar0uj6kMjdm/Xo
	 1dCOmw8/X3BYlIt7+BcJDgQ/6FQrzXOclf0JP1e0yIO9WZ3BDe8RgxsQ2dCR+aQVey
	 8rsXyqOkhf1/J37L28oS9EDouk/94Hv3VVfiBAU9hLW94ETfL4Phu2uhQ3ndL4BXdh
	 PaFZp5OYGqsubwy+rYV4z+WurFS7AMW897ygRtPL4cu8BaZWCDfWJWtXnm8BWa+Hr4
	 jNCrW/0HEtl/onZGcftqqtIq8USkacoumHdLvP9/MYb8pv5P/n/F4Z0C0N+FC72KOL
	 ZUo4FuWvGFX2A==
Date: Wed, 15 Apr 2026 04:24:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Eckert.Florian@googlemail.com, 
 ms@dev.tdt.de, Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>, 
 Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
In-Reply-To: <20260415-pcie-intel-gw-v4-7-ad45d2418c8e@dev.tdt.de>
References: <20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de>
 <20260415-pcie-intel-gw-v4-7-ad45d2418c8e@dev.tdt.de>
Message-Id: <177624504894.3320247.14684447771089927124.robh@kernel.org>
Subject: Re: [PATCH v4 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu
 resource


On Wed, 15 Apr 2026 10:01:53 +0200, Florian Eckert wrote:
> The 'atu' information is already set in the dwc core, if it is specified
> in the devicetree. The driver uses its own default, if not set in the
> devicetree. This information is hardware specific and should therefore be
> maintained in the devicetree rather than in the source.
> 
> To be backward compatible, this field is not mandatory. If 'atu'
> resource is not specified in the devicetree, the driver’s default value
> is used.
> 
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Lexical error: Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dts:28.30-36 Unexpected 'config'
Error: Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dts:28.30-36 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1601: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260415-pcie-intel-gw-v4-7-ad45d2418c8e@dev.tdt.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

