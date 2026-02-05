Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF00426D13
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306458; cv=none; b=Q/yMmCJIa+z9DsfIqH+WTuJ7To5jhx/03ntWq/aydNmueVRc6irwfuiUZ2J5IqtBRQYN3HFma5g+3pG1Ydb1jAKSmRkWnMnXPQYrqGfsBYulLhEb4AtIttraC8gm19Fgj6QDyy86NW8JrUOEJGA5C0PrwSLRuP1gfhcFd+FeOa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306458; c=relaxed/simple;
	bh=bS/kZvy8tZYNQg3VLit2AvM8e7GNggEfQq/VeCoKaf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXYIV6Q9T5qo58NeRzee3PBjA16G1sYGh1o+5dZEBJ9Dq3b4zgYO4wsi1VBoMAtLE/HiOWFSWb0I1e7OQyJA4f/vTNfVWizKWyYJdX2dPYd0qaYEzTcuRJGH4LBXixebX5KKqOsmCGe28rXcKsUgRPELqEv6pZi66ue+mFI2ddM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UTOeXipt; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UTOeXipt"
Message-ID: <89516358-7b13-43ad-b303-1731f61d72e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770306446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcTjrwZnRUs6I9pb05yvCe0/2ynz4xeAqxjhsg9PbTA=;
	b=UTOeXiptGYn1ElFY5mxb7dWkCFuSyO2HKHmDBQKd7HpV4fhN5sVrCBUDUEqz7PTZcEyETF
	tmA/rGRsphpF59I8fqd5xqe8VBy4i2VSmCDBEYNyOy0AurXOIYFlNcg/D7w0Xn5KnuGZe2
	r8zPdD9Nw/t/9p5tEJ1Oi834cE8kLWk=
Date: Thu, 5 Feb 2026 10:47:21 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] dt-bindings: pci: xilinx-nwl: Add resets
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Vinod Koul <vkoul@kernel.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20260203002128.935842-1-sean.anderson@linux.dev>
 <20260203002128.935842-2-sean.anderson@linux.dev>
 <MN0PR12MB59537BC8B60D76CCE0B1391CB798A@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB59537BC8B60D76CCE0B1391CB798A@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/4/26 03:32, Pandey, Radhey Shyam wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Tuesday, February 3, 2026 5:51 AM
>> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>; Vinod Koul
>> <vkoul@kernel.org>; linux-phy@lists.infradead.org
>> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>; Lorenzo Pieralisi
>> <lpieralisi@kernel.org>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; linux-kernel@vger.kernel.org; Simek, Michal
>> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; linux-
>> pci@vger.kernel.org; Neil Armstrong <neil.armstrong@linaro.org>; Rob Herring
>> <robh@kernel.org>; Havalige, Thippeswamy <thippeswamy.havalige@amd.com>;
>> Manivannan Sadhasivam <mani@kernel.org>; Bjorn Helgaas
>> <bhelgaas@google.com>; Sean Anderson <sean.anderson@linux.dev>; Conor
>> Dooley <conor+dt@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
>> devicetree@vger.kernel.org
>> Subject: [PATCH 1/8] dt-bindings: pci: xilinx-nwl: Add resets
>>
>> Add resets so we can hold the bridge in reset while we perform phy calibration.
> 
> Seems like this should a required property?

It's optional as it does not exist in previous versions of the
devicetree. In the past I have received pushback against making these
sort of properties required.

If the resets don't exist we just don't assert them and assume the
bootloader has deasserted them.

--Sean

> Rest looks fine to me.
> 
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>>  .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml  | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> index 9de3c09efb6e..7efb3dd9955f 100644
>> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
>> @@ -69,6 +69,18 @@ properties:
>>    power-domains:
>>      maxItems: 1
>>
>> +  resets:
>> +    maxItems: 3
>> +
>> +  reset-names:
>> +    items:
>> +      - description: APB register block reset
>> +        const: cfg
>> +      - description: AXI-PCIe bridge reset
>> +        const: bridge
>> +      - description: PCIe MAC reset
>> +        const: ctrl
>> +
>>    iommus:
>>      maxItems: 1
>>
>> @@ -117,6 +129,7 @@ examples:
>>      #include <dt-bindings/interrupt-controller/irq.h>
>>      #include <dt-bindings/phy/phy.h>
>>      #include <dt-bindings/power/xlnx-zynqmp-power.h>
>> +    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>>      soc {
>>          #address-cells = <2>;
>>          #size-cells = <2>;
>> @@ -146,6 +159,10 @@ examples:
>>              msi-parent = <&nwl_pcie>;
>>              phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
>>              power-domains = <&zynqmp_firmware PD_PCIE>;
>> +            resets = <&zynqmp_reset ZYNQMP_RESET_PCIE_CFG>,
>> +                     <&zynqmp_reset ZYNQMP_RESET_PCIE_BRIDGE>,
>> +                     <&zynqmp_reset ZYNQMP_RESET_PCIE_CTRL>;
>> +            reset-names = "cfg", "bridge", "ctrl";
>>              iommus = <&smmu 0x4d0>;
>>              pcie_intc: legacy-interrupt-controller {
>>                  interrupt-controller;
>> --
>> 2.35.1.1320.gc452695387.dirty
> 
