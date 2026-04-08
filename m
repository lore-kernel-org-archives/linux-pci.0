Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE0219EB;
	Wed,  8 Apr 2026 03:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775619305; cv=none; b=EBbEWgCLpXZSsIb8etSLljGCSNTwPCMT0lOKppkCBQlncCgu0SppoSfhxUzyKX/+E3NwuALty0SL777bGXg9elhp8iFWm++BiJgnyxtBYnax1GU5MXFt9i3lnioH05rurLZmi8H+PzpTPSnpWscIZXNYYEOOeRSXJIs7ix/Q3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775619305; c=relaxed/simple;
	bh=5la8CRAdDuUDc6rkvbIsHPPfssVpZdKPTuUeV/zhRz8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=gOaPAqvli8fUHcP3QxPs0om0/mzIrvMkUyCPxMoTnJxL4a3HNcmiANFvxtiRbNrdYVZn3E9loSKJ3ACxAtoWiems3jUcUoGueZKEGrvW2pqrsZ2PR2RoB7/1WQsFJL/nS8108K8n3hyXELi+yKQgjLeIejB9HketyeU3XyIrNz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=LVD6ylXG; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="LVD6ylXG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=vG3/pdjoIZItHKQazJgRke/Wa2WdN3UPI
	svM8pFQjRM=; b=LVD6ylXGm3Ui4VQBRnVocWGMJZQn4ekVRycQVd3w4RQcCee4G
	4nQ9IyCCVZeQB+SJmFZTg6LoGMDaowIyMc2pnwLcnj731wc16TsASsIhTLbDf2+8
	t0FpXw8bPYlv/RQM0YjtS5x1oI6hc/cCklKUBtk7Me/PndatUerNp6uqls=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkP_zNVpV6sBAA--.1112S2;
	Wed, 08 Apr 2026 11:35:28 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: Add UltraRISC DP1000 PCIe
 controller
From: Jia Wang <wangjia@ultrarisc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jia Wang <wangjia@ultrarisc.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20260407-uptight-tody-of-weather-ae1e35@quoll>
References: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
 <20260407-ultrarisc-pcie-v2-3-2aa2a19a7fb3@ultrarisc.com>
 <20260407-uptight-tody-of-weather-ae1e35@quoll>
Date: Wed, 08 Apr 2026 11:34:40 +0800
Message-Id: <177561928084.2918127.18218641774926914517.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775619281; l=4541;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=5la8CRAdDuUDc6rkvbIsHPPfssVpZdKPTuUeV/zhRz8=;
 b=dNr++OKPc9m38bhIY1CFbpsyWH0yP50Ln1rEpXsdmec/eAOpiFkqyaf50ge/3yWaWCJFW4eh7
 MA1OB+7WY0DBVTtMWjL9eq1MWKWwTmdFRXQqGcHVtWtkklZZenYtsoQ
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnEkP_zNVpV6sBAA--.1112S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4kZr13Gw4xAFWkWw1xZrb_yoWrWr4rpa
	yUGayDCFsavr13ZF4Sq3W8GFnxJF4vyF95Cr4Ygw17JFZ09Fy0qFWakw15G3s5ArsrAw12
	vF1jvw17tw4UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQALEWnUfzsAQQABsi

On 2026-04-07 09:50 +0200, Krzysztof Kozlowski wrote:
> On Tue, Apr 07, 2026 at 10:40:54AM +0800, Jia Wang wrote:
> > Add UltraRISC DP1000 SoC PCIe controller devicetree bindings.
> > 
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 103 +++++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> > new file mode 100644
> > index 000000000000..d0517130e127
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/ultrarisc,dp1000-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: UltraRISC DP1000 PCIe Host Controller
> > +
> > +description: |
> 
> Do not need '|' unless you need to preserve formatting.
>

Hi Krzysztof,

Thanks. I’ll remove the `|` in v3.
 
> > +  UltraRISC DP1000 SoC PCIe host controller is based on the DesignWare PCIe IP.
> > +  This binding describes the UltraRISC specific extensions to the base
> > +  DesignWare PCIe binding.
> 
> Drop sentence. Do not describe in description what the binding
> describes. It's circular / repetitive. Just describe that.
> 

Will simplify the description to a single concise statement in v3.

> > +
> > +maintainers:
> > +  - Xincheng Zhang <zhangxincheng@ultrarisc.com>
> > +  - Jia Wang <wangjia@ultrarisc.com>
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: ultrarisc,dp1000-pcie
> > +
> > +  reg:
> > +    items:
> > +      - description: Data Bus Interface (DBI) registers.
> > +      - description: PCIe configuration space region.
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: config
> > +
> > +  num-lanes:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [4, 16]
> > +    description: Number of lanes to use.
> > +
> > +  max-link-speed:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    const: 4
> 
> If const then deducible from the compatible. Drop the property.
> 

Will replace `const: 4` with `maximum: 4` in v3.

> > +    description: Maximum PCIe link speed supported.
> > +
> > +  interrupts:
> > +    description: List of interrupt specifiers used by the controller
> 
> Drop description. Obvious.
> 

Will drop the description in v3.

> > +    items:
> > +      - description: MSI interrupt
> > +      - description: Legacy INTA interrupt
> > +      - description: Legacy INTB interrupt
> > +      - description: Legacy INTC interrupt
> > +      - description: Legacy INTD interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: msi
> > +      - const: inta
> > +      - const: intb
> > +      - const: intc
> > +      - const: intd
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      pcie_x16: pcie@21000000 {
> 
> Drop unused label
> 

Will drop it in v3.

> > +        compatible = "ultrarisc,dp1000-pcie";
> 
> reg, names and ranges go here. Please follow DTS coding style.
> 

Will update the example to include reg, reg-names, and ranges following DTS
coding style in v3.

> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        #interrupt-cells = <1>;
> > +        reg = <0x0 0x21000000 0x0 0x01000000>,
> > +              <0x0 0x4fff0000 0x0 0x00010000>;
> > +        reg-names = "dbi", "config";
> > +        device_type = "pci";
> > +        dma-coherent;
> > +        bus-range = <0x0 0xff>;
> > +        num-lanes = <16>;
> > +        ranges = <0x81000000  0x0 0x4fbf0000  0x0 0x4fbf0000  0x0 0x00400000>,
> > +                 <0x82000000  0x0 0x40000000  0x0 0x40000000  0x0 0x0fbf0000>,
> > +                 <0xc3000000 0x40 0x00000000 0x40 0x00000000  0xd 0x00000000>;
> > +
> > +        max-link-speed = <4>;
> 
> Drop, compatible defines this.
> 
> Best regards,
> Krzysztof
> 
> 

Best regards,
Jia Wang


