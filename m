Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F23F1AB7;
	Fri, 25 Sep 2026 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317733; cv=none; b=h4DQe/I7DTNNXl9PGr/NQzdfjlSCrxYeIacQmwYvcIR85cOiI4z04/ltjHdLCYOw+MkxPYhfXtYZSrw807+c5UWHth8Upzd/G89Tau8KzrDb+MCEvGJ0QFP6/KwifO66Jxqr44CZ4SKFt3OFi6d32Sd9L85ZK++r0I8VscTPCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317733; c=relaxed/simple;
	bh=GgGYAhAKf4iLWFMmTXFcapoTzJU8y1vLSxmdqD5JJ68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzreX4OnwoOlIjKo4JVy8s3FOHZZ34vEEEnAmi2lFQeevhuWFxULZmg0Y97OK8JlEQ2avavvxd18V6YkcfnVWZ0DRp2mzwL0VtxXIZ1MswSlsATonDXfJxE+mhWuOZczDl02tGfY1/kE6/8gVHIJ2d9yOb+DwicP9o/kyhjp5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFWHnpDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFWHnpDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71241F000FF;
	Fri, 25 Sep 2026 06:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790317729;
	bh=BPPjjn1CvKsUI7yM/hq8jU+Pg8KjNYzEAq1cyTZMulw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hFWHnpDQrT3THQcEbsmGsm9HiEjbg8wN/Bdd0IEQGC8H8v0+iy+stF8sAMhhf701S
	 v5lAENcU4rRSWVs3xFhfrDTxSz/LJwl0b2V69EomdKpi5FsJNGQmptda9K/wIH35Qb
	 7yZ2wnz1AxDDi5xxzkuAYkUFHd81rFImIKz+l5yMz2t9E+4B8Zm/oq/b96Nta5CnJH
	 gXuYwoopEnQW7LBUV5HLwYfdI9OMvgpWBKfdxpdHk6qpGZTlzBOkuu6Vk1VjA74XYL
	 AZjXMOJtMzX/ywRBsyPQt5gx6PNDQVOqD6/zrbeCo9wGbvei9HF217PI39GeK2ps3X
	 ym3LV0LFdcdRA==
Message-ID: <89bdd01c-74b5-4425-9ef1-19a69b9a07a5@kernel.org>
Date: Fri, 25 Sep 2026 08:28:40 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, shengchao.guo@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-1-ed05c6e09240@oss.qualcomm.com>
 <20260924-lumpy-robust-fulmar-1bfbe0@quoll>
 <050f7d22-48a2-4114-babf-7cf21c4bc08b@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <050f7d22-48a2-4114-babf-7cf21c4bc08b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/09/2026 06:08, Krishna Chaitanya Chundru wrote:
> 
> 
> On 9/24/2026 6:52 PM, Krzysztof Kozlowski wrote:
>> On Mon, Sep 21, 2026 at 11:07:09AM +0530, Krishna Chaitanya Chundru wrote:
>>> +
>>> +  vdda-pll-d-supply: true
>>> +
>>> +  qcom,link-mode:
>>> +    description:
>>> +      Reference to the TCSR syscon register containing the PCIe link mode
>>> +      selected by firmware. The property consists of the TCSR syscon
>>> +      phandle followed by the offset of the TCSR_PCIE_LINK_CONFIG_MODE
>>> +      register.
>>> +      The register value selects one of these topologies.
>>> +        0 (QMP_PCIE_NORD_MODE_X16)         — all ports combined as one x16 PHY
>>> +        1 (QMP_PCIE_NORD_MODE_X8_X8)       — port A as x8 and ports B+C+D as x8
>>> +        2 (QMP_PCIE_NORD_MODE_X8_X4_X4)    — port A as x8, port B as x4, and ports C+D as x4
>>> +        3 (QMP_PCIE_NORD_MODE_X8_X4_X2_X2) — port A as x8, port B as x4, and ports C and D as x2
>> Same question as last time. phy-cells tells which mode you are here.
>> This is duplicating it and the register value CANNOT choose the
>> topology. If it does, then phy-cells should be 0 as topology is defined
>> by hardware already, no?
> phy-cells does not describe the topology. The PHY argument is only used by the
> PCIe controller to identify the PHY instance associated with that controller
> (for example, phys = <&pcie_phy 2> selects PHY instance 2).
> 
> The qcom,link-mode property serves a different purpose. It provides access to
> the firmware-programmed TCSR_PCIE_LINK_CONFIG_MODE register, which describes
> the global lane partitioning (x16, x8+x8, x8+x4+x4, x8+x4+x2+x2, etc.).
> 
>   - phy-cells identifies which PHY instance a controller is using.
>   - qcom,link-mode reports the overall topology selected by firmware.
OK, I assumed the cell argument defines the instance in that topology,
but it seems not. I think that was the misunderstanding.

Best regards,
Krzysztof
