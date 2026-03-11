Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4BD30F803
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211589; cv=pass; b=GuroEtZGaVm93lJ1xra4O4eYJCOPU/PudiLy2mmSs1xsuK2O0seyBKdxLqFqJ1nkf45bJh3UqQglP6LDHpmaMYWqIV3K4rPJ2BmYPCx0UjFXpphxG36Makn02V2Ga1GZE4U2ra+M3K8o3ISKdPPErCfHrHYvKjDETgTKYS/sZLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211589; c=relaxed/simple;
	bh=LkW8aNJ2+N/qPgMrXjRIQ2Omn4bJonn/dBA+P8cWsww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGLIIboK1431YNc3/9sMbmR6ERPVOcjl5i3FF/eMSROEF9GqquDYCu4s77F+h6bQz+yRCgcmJZWDmfPTntiAr8cg5r9BKyXv+oWhDXiLsOhDWeRoERV2CZcwVvEPZ5o1YbkyxAK75L9IvUvM8nh5bA6PDCzNzr8zzyinMNPljns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8lnAOpQ; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8lnAOpQ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso8334377a12.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 23:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773211585; cv=none;
        d=google.com; s=arc-20240605;
        b=ap4rHmLQ133xDngFCjvqgTLVTal85kY+Cl4rrcRowX+MALoLxO5QNUq5pr7iuRzk1V
         qfrOxk+SzT90/pQdo9pj8XvXZyjx35HKpAPBl5Fb19kL3M9BvQeT8bYCU7l1Uk2eg7NV
         AL4Q3stOENk572fI30GRLpSjkEstOVQcNFY7zc6ZIKySmbtAfgM36tmM+jWeJRZZhWZU
         EN/OXOQ+oKLtjO3q/p8ioy6ZqCIXKgwsLn7XiXLRxJMAyxbs3fRMUHQrxZ8h1hCTT0DD
         j3eBnF9sW+86px/BFwrwnxuxy23ruO9DpW3kb/9Ehk80V7BocLmG9nSzwtKO0j5BjLIC
         xBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=baZMbuJRCD7J4EDCgJhUtwmHw4BySP0mKp1E9krNdQU=;
        fh=dL53CrDFqs39z2Wo10ILahV2vIKEyaDXDRp1HMfJPkY=;
        b=liK2rJ5MhDgs0K2n+kEkpIli36GhYLKIKhp2SZym3xmglOjefM2JEGb4P/2iBTIWUN
         G6LcjtDbYphnoHT9cs5krKsRkVHaw2kL9rIBWaPUzQmZE58yN5fE1gqbmGbk6fNh1Shp
         d7LQCSCl/zWTuQP7/ato7l+/FEkgsTn1HK/v1CE/VRvmKnpBiMWDzvYjg+cxYCUxWgqC
         Dhfy3yvdt2sXjJn6By1fNs8skSA84qQ6c0CgNFcWd1ii6TiIvhkapP+IvxYVvUTbf5Hb
         hE9HyK1ZpezZJN/4g2yAqPMmEzrui1aOBnTRsLyU1doN8fUe9J8CUKh5MfRlEdAjOZBo
         H6sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773211585; x=1773816385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=baZMbuJRCD7J4EDCgJhUtwmHw4BySP0mKp1E9krNdQU=;
        b=U8lnAOpQccIcP86Wmi5MI5KI8/X6sbwMHWkrHcAfKSg8qxlp/Kup9uZuYNimasRCFv
         knordMhno7ePInCeMmCnS64bLOTLGTFxdF7qxcS8hcZTGOtF/h/BF40L/4noTwmfDkko
         OEbFVzpwPHLQi/5MWoYZ2b9FqFdiBzwiykOIg3oUOYY2nDV6fceKpTbY2gh6xw4IW+Qe
         pUoecOjIcNFetNyZHhPPXNwAPvKo/ZEnbUrN0HoOeDThRphRk5YVAqgvWDew7HAjAEFG
         T15yJpNVC2DxeYTr+lBkb5UaThAFaD5v6QZoGsbWKFMlrYPqIz9gtgOuyVFD4zB9Y9SN
         +eGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211585; x=1773816385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baZMbuJRCD7J4EDCgJhUtwmHw4BySP0mKp1E9krNdQU=;
        b=efjILj8ZlzLcIxsYB/AIWpgFlw1keDwv1u5x4lph6TAZ9dUvpCvG5FmFi+7JjODX6L
         lOeR0gvTKPxK6OB0HX+3AZeXh8YnaBGYwkDI66XBF7hxqrAgbaFkpO9vY0bojyeUhM3W
         n7s3KC/VpvGk6ldvGPSZ9TzesjmtSY++c4fjotTYBYi7KgMwlsnWmv/rkOx0oOQivx1F
         ZT1GTJ2e03iSZBVMd/DrBgqrrYLnclTn4/yAkiPcyF643MCCC9RtzAGTjD0aXa3+6v64
         eO9RV81ivOI5E4H0PcpTTVc8fSoPibs4BvWgJHJp6kR3jgjjmpAFjUZrSIZYZb+w5yHD
         xe4g==
X-Forwarded-Encrypted: i=1; AJvYcCWjHXuoMlFgETXGn069/uNQv2Vrz6tDMo4hEbKXkCZ8KkYiZyo5O09uM8n+RgCq6+wJZY5xD0F8Lq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4VVoRyo9bsNPNrAWzwBrvs1xGBhT5CDbY+uwqMTF/512/oa8
	92IyMl5AHsRfypn1rRkc5251R6BcFG+KztTBABSbdQgII3nWIezZfxWXnA6jnA6BxfsSOmJMl48
	xocVUIrT1/ChH981iBdHjwf2psA0YwVo=
X-Gm-Gg: ATEYQzy21VMbxf1a26kmDoQkSNIFVubmKvVV3YmDhelRzwhTiZifObRRmaSfNpA4HC4
	mhdeqrlUP/yKwDhYIe/mnE+04zgFq4mSo+EXf8QA3XbjKQb9zryWiGgfxOPv8BEJGmqFT5puZRE
	j36C/SMGkYElft5hNt+TmC+0JwUFsjnixdm26YN5bGiHfYkzCGswwAtF6ccCsfsrEmRrWCqZGir
	BbUHPafvspCH74zmQKrngUtu1EEz1pDoyqNjebKtIdrgNQKor3c1EFuYpSjLL1Tccgvre6b3Qts
	Y5xDIQ==
X-Received: by 2002:a17:907:d20:b0:b96:dd1c:9408 with SMTP id
 a640c23a62f3a-b972e5a7e72mr66861466b.54.1773211585130; Tue, 10 Mar 2026
 23:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224121948.25218-1-linux.amoon@gmail.com> <20260224121948.25218-2-linux.amoon@gmail.com>
 <20260306004333.GA863798-robh@kernel.org>
In-Reply-To: <20260306004333.GA863798-robh@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 11 Mar 2026 12:16:08 +0530
X-Gm-Features: AaiRm50BSR-A9EzoSJRmZ4OfsKGsGf90EKdlcvFqkSo-zZd_l9GtX7eOstz-4x8
Message-ID: <CANAwSgS7RhZ1D-zPR8LpvrQJVp+1be9ALC5HcE1XhouyNOS6Jg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

Thanks for your review comments. Sorry for the late reply.

On Fri, 6 Mar 2026 at 06:13, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 24, 2026 at 05:48:57PM +0530, Anand Moon wrote:
> > Convert the existing text-based DT bindings documentation for the
> > NVIDIA Tegra PCIe host controller to a DT schema format.
>
> I just reviewed the same thing from Thierry... This one looks a bit
> better for overall structure (fewer if/then schemas), but I think misses
> some things like deprecated supplies. Please resolve the differences
> between the 2 and coordinate who is going to send the next version.
>
Ok, I checked this, but couldn't find the deprecated supplies.

The drive code maps SoC-supplied regulators to an array for the buck regulators.
[1] https://github.com/torvalds/linux/blob/master/drivers/pci/controller/pci-tegra.c#L1929-L2078

I will fix it if I need to.
> >
> > Also update the MAINTAINERS file to reflect this change.
> >
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v3: Tried to address the issues Krzysztof pointed out.
> >    Added missing regulator binding as suggeested by Jon.
> > v2: Tried to address the isssue Rob pointed
> > [1] https://lkml.org/lkml/2025/9/26/704
> > improve the $suject and commit message
> > drop few examples only nvidia,tegra20-pcie and nvidia,tegra210-pcie
> >
> > $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > ---
> >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 528 ++++++++++++++
> >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
> >  MAINTAINERS                                   |   2 +-
> >  3 files changed, 529 insertions(+), 671 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > new file mode 100644
> > index 000000000000..0675bec205e8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > @@ -0,0 +1,528 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVIDIA Tegra PCIe Controller
> > +
> > +maintainers:
> > +  - Jon Hunter <jonathanh@nvidia.com>
> > +  - Thierry Reding <treding@nvidia.com>
> > +
> > +description:
> > +  PCIe controller found on NVIDIA Tegra SoCs which supports multiple
> > +  root ports and platform-specific clock, reset, and power supply
> > +  configurations.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nvidia,tegra20-pcie
> > +      - nvidia,tegra30-pcie
> > +      - nvidia,tegra124-pcie
> > +      - nvidia,tegra210-pcie
> > +      - nvidia,tegra186-pcie
> > +
> > +  reg:
> > +    items:
> > +      - description: PADS registers
> > +      - description: AFI registers
> > +      - description: Configuration space region
> > +
> > +  reg-names:
> > +    items:
> > +      - const: pads
> > +      - const: afi
> > +      - const: cs
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Controller interrupt
> > +      - description: MSI interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: intr
> > +      - const: msi
> > +
> > +  clocks:
> > +    minItems: 3
> > +    items:
> > +      - description: PCIe clock
> > +      - description: AFI clock
> > +      - description: PLL_E clock
> > +      - description: Optional CML clock
> > +
> > +  clock-names:
> > +    description: Names of clocks used by the PCIe controller
> > +    minItems: 3
> > +    items:
> > +      - const: pex
> > +      - const: afi
> > +      - const: pll_e
> > +      - const: cml
> > +
> > +  resets:
> > +    items:
> > +      - description: PCIe reset
> > +      - description: AFI reset
> > +      - description: PCIe-X reset
> > +
> > +  reset-names:
> > +    items:
> > +      - const: pex
> > +      - const: afi
> > +      - const: pcie_x
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  interconnects:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interconnect-names:
> > +    items:
> > +      - const: dma-mem
> > +      - const: write
> > +
> > +  pinctrl-names:
> > +    items:
> > +      - const: default
> > +      - const: idle
> > +
> > +  pinctrl-0: true
> > +  pinctrl-1: true
> > +
> > +  operating-points-v2:
> > +    description:
> > +      Defines operating points with required frequency and voltage values,
> > +      and the opp-supported-hw property.
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  avdd-pex-supply:
> > +    description: Power supply for analog PCIe logic. Must supply 1.05 V.
> > +
> > +  vdd-pex-supply:
> > +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> > +
> > +  avdd-pex-pll-supply:
> > +    description: Power supply for dedicated (internal) PCIe PLL. Must supply 1.05 V.
> > +
> > +  avdd-plle-supply:
> > +    description: Power supply for PLLE, which is shared with SATA. Must supply 1.05 V.
> > +
> > +  vddio-pex-clk-supply:
> > +    description: Power supply for PCIe clock. Must supply 3.3 V.
> > +
> > +  vddio-pex-ctl-supply:
> > +    description: Power supply for PCIe control I/O partition. Must supply 1.8 V.
> > +
> > +  hvdd-pex-supply:
> > +    description: High-voltage supply for PCIe I/O and PCIe output clocks. Must supply 3.3 V.
> > +
> > +  avdd-pexa-supply:
> > +    description: Power supply for analog PCIe logic. Must supply 1.05 V.
> > +
> > +  vdd-pexa-supply:
> > +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> > +
> > +  avdd-pexb-supply:
> > +    description: Power supply for analog PCIe logic. Must supply 1.05 V.
> > +
> > +  vdd-pexb-supply:
> > +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> > +
> > +  avddio-pex-supply:
> > +    description: Power supply for analog PCIe logic. Must supply 1.05 V.
> > +
> > +  dvddio-pex-supply:
> > +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> > +
> > +  hvddio-pex-supply:
> > +    description: High-voltage supply for PCIe I/O and PCIe output clocks. Must supply 1.8 V.
> > +
> > +  dvdd-pex-supply:
> > +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> > +
> > +  hvdd-pex-pll-supply:
> > +    description: High-voltage supply for PLLE (shared with USB3). Must supply 1.8 V.
> > +
> > +  vddio-pexctl-aud-supply:
> > +    description: Power supply for PCIe side band signals. Must supply 1.8 V.
> > +
> > +patternProperties:
> > +  "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
> > +    type: object
> > +    allOf:
>
> Don't need allOf.
Ok.
>
> > +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +      nvidia,num-lanes:
> > +        description: Number of lanes used by this PCIe port
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [1, 2, 4]
> > +
> > +      phys:
> > +        description: Phandles to PCIe PHYs
> > +        items:
> > +          maxItems: 1
>
> How many cells a phy entry has depends on the provider, which is outside
> the scope of this binding.
Ok, actually, phys and phys-name are not part of patternProperties.

phys and phy-name are required properties for Tegra124 and later.

[2] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/pci/nvidia%2Ctegra20-pcie.txt#L153-L158

And the board's example is as follows.

[3] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts#L11-L32

[4] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts#L36-L63
>
> > +        minItems: 1
> > +        maxItems: 4
>
So I have modified the device tree binding as follows.
-----8<----------8<----------8<----------8<----------8<----------8<-----

$ git diff .
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
index 0675bec205e8..73af8d2895a8 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
@@ -103,6 +103,18 @@ properties:
   iommus:
     maxItems: 1

+  phys:
+    description: Phandles to PCIe PHYs
+    minItems: 1
+    maxItems: 4
+
+  phy-names:
+    description: Names of PCIe PHYs
+    items:
+      pattern: "^pcie(-[0-3])?$"
+    minItems: 1
+    maxItems: 4
+
   avdd-pex-supply:
     description: Power supply for analog PCIe logic. Must supply 1.05 V.

@@ -157,8 +169,8 @@ properties:
 patternProperties:
   "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
     type: object
-    allOf:
-      - $ref: /schemas/pci/pci-pci-bridge.yaml#
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
     properties:
       reg:
         maxItems: 1
@@ -168,20 +180,6 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [1, 2, 4]

-      phys:
-        description: Phandles to PCIe PHYs
-        items:
-          maxItems: 1
-        minItems: 1
-        maxItems: 4
-
-      phy-names:
-        description: Names of PCIe PHYs
-        items:
-          pattern: "^pcie(-[0-3])?$"
-        minItems: 1
-        maxItems: 4
-
     required:
       - nvidia,num-lanes

@@ -274,6 +272,33 @@ allOf:
         - pinctrl-0
         - pinctrl-1

+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra124-pcie
+              - nvidia,tegra210-pcie
+    then:
+      required:
+        - phys
+        - phy-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra20-pcie
+              - nvidia,tegra30-pcie
+              - nvidia,tegra186-pcie
+    then:
+      properties:
+        phys:
+          deprecated: true
+        phy-names:
+          deprecated: true
+
   - if:
       properties:
         compatible:
@@ -495,34 +520,19 @@ examples:
             dvddio-pex-supply = <&reg_pex_1v05>;
             vddio-pex-ctl-supply = <&reg_pexctl_1v8>;

-            status = "okay";
-
             pci@1,0 {
-                device_type = "pci";
-                assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
-                reg = <0x000800 0 0 0 0>;
-                bus-range = <0x00 0xff>;
+                phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>,
+                    <&{/padctl@7009f000/pads/pcie/lanes/pcie-1}>,
+                    <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>,
+                    <&{/padctl@7009f000/pads/pcie/lanes/pcie-3}>;
+                phy-names = "pcie-0", "pcie-1", "pcie-2", "pcie-3";
                 status = "okay";
-
-                #address-cells = <3>;
-                #size-cells = <2>;
-                ranges;
-
-                nvidia,num-lanes = <4>;
             };

             pci@2,0 {
-                device_type = "pci";
-                assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
-                reg = <0x001000 0 0 0 0>;
-                bus-range = <0x00 0xff>;
+                phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
+                phy-names = "pcie-0";
                 status = "okay";
-
-                #address-cells = <3>;
-                #size-cells = <2>;
-                ranges;
-
-                nvidia,num-lanes = <1>;
             };
         };
     };

-----8<----------8<----------8<----------8<----------8<----------8<-----

But I am not able to resolve the build error

$ make -j$(nproc) dt_binding_check DT_SCHEMA_FILES=nvidia,tegra-pcie.yaml
  DTC [C] Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dtb
Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dts:179.25-186.19:
Warning (unit_address_vs_reg): /example-1/bus/pcie@1003000/pci@1,0:
node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dts:188.25-192.19:
Warning (unit_address_vs_reg): /example-1/bus/pcie@1003000/pci@2,0:
node has a unit name, but no reg or ranges property
FATAL ERROR: Can't generate fixup for reference to path
&{/padctl@7009f000/pads/pcie/lanes/pcie-0}
make[2]: *** [scripts/Makefile.dtbs:140:
Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dtb]
Error 1
make[1]: *** [/media/nvme0/mainline/linux-tegra-6.y-devel/Makefile:1597:
dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Thanks
-Anand
