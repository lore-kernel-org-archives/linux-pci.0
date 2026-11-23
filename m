Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446702;
	b=2Tai4jv/EsZT9QHEPanw+TIYetQAZXpD8qXSOfXPL8exCgS4zyOJ7vKK3W3ukEuLkGAk
	 wrJWeTZNdFUmj3E89aAHbp94skBX393wyj8exK7meTazZxID1M6a81KPRpM4zqHzaPbWW
	 xagHxWHWJFG1KhXZcfMuuqQpe+AbIFJAhiRz01Gb1vT5D6Me5M9AOLnFPlE4e5djmZ6PQ
	 dTj+Bih34sB2O1EgpcbICQzxZBuaW2SMGQhP78mN8E7jbuyCwlxpZEjHlwIKLRDNp+Nyx
	 k+5msawMJ0/ZKs1RQw8s6xomfyn/d1uoDedRISCToP+JRDBEIq/00j61et2cR7Q4U6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446702;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=QCzRfh4M2xi2pXwv4ABbYym7LuD9ue+4jUDWszr2SaE=;
	b=qo8NPELnp008dC4vigMdMp0CibCkTwD6qe9vYj/THfVUTtO2k8YEVWF2FgTbzTiwXlOC
	 coL63HU4JcmZnGhcmCQXVBMjGeoyOEoRkibSPIQJ/5f6+Q7rcc5TPbq2vMLowECafBIRf
	 PpeEc87IpX0GcUbl2T5Utq8LuAop6VZEHT6AjRY38KmfdibbjPqSzXNQ+vLFU3lVAt1/h
	 dg1BXJ0NW4ZA0C9idsjp2lWVaoIvmH+U6qQJWYp1DlKqLVubp/zACDva8R/sGzZlOUQQO
	 dk499i4m3G0EIE2KkiFR76n9o7szTTLLPFmYlm+9F5lx6R58EYFbFMF3CDwG1rKc20A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJjmS6LV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8F606A31A;
	Mon, 23 Nov 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJjmS6LV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754A31F0156B;
	Mon, 23 Nov 2026 15:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446701;
	bh=QCzRfh4M2xi2pXwv4ABbYym7LuD9ue+4jUDWszr2SaE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=KJjmS6LVz7sMP6X9D8FAmNG6oJ1mhVTWDzknPUP72QyBgmIEc0EcJDFblFYjrR3wf
	 NE3BDqpT7hog6Vz8q9/xjrofdnAsDl1xpM86/ML9wsRPlTYTUsngTfj0uiYbHdoGRR
	 ON9zOr7chqR3l32Lr06L4iX5DZEyoM+abt/nshg5wfp73xC7oelNmiO2n+ir1i1M0M
	 4vZN5Zgkdr9PedqJIHzuOsfjt6ehR/3od1ktVFPPBsHuw+L0JByopp9cqrPXLo1aKU
	 eFd9T+szQ85SDxoweyH+L5U+Slu7Sb1xo/c38Gqm2mJ4TU8k3V8yl8vrGEVoT93IK1
	 Rpo6H2Fcs572g==
Date: Mon, 23 Nov 2026 09:11:39 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, 
 linux-pci@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, alchark@flipper.net, 
 Conor Dooley <conor+dt@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
 <20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com>
Message-Id: <179544616248.2477523.14949102413448950913.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key B connector


On Sun, 22 Nov 2026 12:15:51 +0530, Krishna Chaitanya Chundru wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> connector is used to attach WWAN Adapters to the host machine over
> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0. The slot also
> accepts SATA and PCIe SSD Adapters, which use the same pins.
> 
> Interfaces that share connector pins are described as one graph port
> per pin group, with the endpoint number selecting between the mutually
> exclusive interfaces.
> 
> The connector provides a primary power supply of 3.3V/VBAT, along with
> optional GPIO signals: FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1# and DPR
> for WWAN Adapters, and DEVSLP, PLN# and SMBus ALERT# for SSD Adapters,
> plus an I2C parent for the SSD SMBus.
> 
> The function of the GPIO_0..GPIO_11 pins depends on the Port
> Configuration, so they are described by gpioN-gpios properties with the
> function of each pin per configuration documented in the binding. The
> Adapter configuration is either sensed through config-gpios
> (CONFIG_0..3) or fixed with config-state, which defaults to WWAN PCIe.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-b-connector.yaml    | 332 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 333 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/connector/pcie-m2-b-connector.example.dtb: connector (pcie-m2-b-connector): config-gpios: [[4294967295,124,0],[4294967295,125,0,0],[4294967295,127,0]] has less than 4 items
	from schema $id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261122-pcie6_fix-v2-1-2e0fe615d90b@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

