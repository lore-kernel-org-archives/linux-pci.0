Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD41D6BB
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783043502; cv=none; b=t6ksaBe4lhlvJo9Nj1mrlD74mJiOSZr+9sLu4GBJL7T5y44iOXJOjZo4+vzC/Qr04z9qzmyXZbCCcikW0VMriViDu0W55ZECZAmd26wEgcwP/XKe0t3iqLXi5l0k2ov6FF2ytEIpcA7blrONiCbSRb8yjeng8wAPwG0Z8qyVRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783043502; c=relaxed/simple;
	bh=b5whjc3gJgzLr/xpZRDwWBd8d15pv5MvoPIhIx6ndbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEyrL5Ex0Lig7WJQOyiT+hkTg6sQ71JYHKc8TVI0Rn5tCG+0Bq9oLtxaH4A07tRHrPuogGfvDZ4KmpuGo+BedbGayym5CvhocvFVtAAkMJu9STpBQVTUOH1U4BoQDjH+pVwpFfOvOzI+SApEmWOH7JBqvDuqOpDri88c29cM9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euOBhVEN; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euOBhVEN"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-845c92bc464so31665b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 18:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783043499; x=1783648299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uucYeY9/tilSu22+Lvc2ys3l48BWNkemNgiDbDRjkc8=;
        b=euOBhVENJxd+cDJRjEkAVOav2ELJ++qZAqrh+eNxjPKcQVcui/ybDK6YRmoaSMKDX+
         /gl7ZoQC41TQ5d3SrJiEAi5T6QEocQ2pW7DfDkMmZ4a3J/LcBg+MbMMH7SYVFjJKA3Ud
         WLkh8vpGRsUwI9s5Kdch5WZGRzVQtpOwdu6ZNufO4p9/GzaCl0WQN0SwtVLSSFixmhL4
         SIPRMaFEwCZUT5Ssjf8JTaytIJteB802JeLeX38ALUh3BDBRwrbQGUgCJM/RROr6rrSL
         HnOGXNv+DPDE9u6oqc8Kse2uy1+bbI0K1JvH00WnxSHn7r49Jec1YPKDDCL3whoD/Q3J
         APNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783043499; x=1783648299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uucYeY9/tilSu22+Lvc2ys3l48BWNkemNgiDbDRjkc8=;
        b=LJvg+lQWAlhxoswF8Lf6TIWWTVuhcB/p+5bvan6KtwbF4WYS8t6xhsxtAHnw01eol3
         3MegWTeMrNe+seBG1WAoHSMj2RW5td/y/wMC2UMjSwO+ocGIfOq2WP3RVFDAZDfR0f0v
         Vn6bSYFTAhz7XnOHtIBuT8L08wM2izNObtmcpxwuagu/Lj06HtcfpjuzCHtae0SfB4d9
         sWMyTLf2/3so8eJ0GvWuY89qbbWUj2b0ijGeifQfb6DObqrN+LpRbWQIVZAGbDMAXOST
         ntbdI6e8fY7GZej794yHOoPCQQm3I8w1tc1CEGJCXvkDGGQ1VbIZ0/DQBITjIRie5ilt
         30hw==
X-Forwarded-Encrypted: i=1; AFNElJ+1yYGya73dxyJ7HT0+ppZ3B/sOpiotidhXCyxUiumvXf7OEH/DlI5+YGnayiYTOBBUX7rZDoxkqwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT0gYJGxkM3REpk9OJEibdn9jcH9nGJYlveFkyKJXwWFaSPl/j
	Q20L4ikwqd/BcfgNlE5gAhgQ2GZYlgVNyj0Z/kt5ru4PAg4tPA9bxIHL
X-Gm-Gg: AfdE7ckQb0cqKquiwUH1pjAC3gn4m/LVgo3/Pw2UWWyB+Dn3LskIsmm4OIX9r4HQnGU
	3yv1nQ1B/nvDR6KW0h+xN0//d2ORfDfBc1VIc9BmC4Khi5Qd/56bMT4Rwfvo/SdmUrbH/tav30l
	KRTmmYlNgR9fJlEHD/IZvpP+VzEJQVdC+IWakdPDmoLfACIbatNQ2Y/au8bCovGHmVeI2GCY5dU
	jIyVKpm21z2cLfGNo0CFnL+wwsQP7j1a8vHTq+aOnNFv/fEppuz/rqXAxZnioS36vABsiY2mSF5
	z9hx6ieK5eVi0SbzIX9KNNRHCbzeQ98zJRvQr0IziiNfrTpIksXCsHUkE5GzbHkRSKKfEpen02o
	XNwjj9Lt6abqgU112o+Jcqq3LgD4Sm9kK4q6KMHSFXsooMzPetluIuLgAlNLS7SNCGwnW/fyDs4
	M=
X-Received: by 2002:a05:6a00:4388:b0:847:1013:f8e0 with SMTP id d2e1a72fcca58-847c4ffbc14mr7392325b3a.7.1783043498765;
        Thu, 02 Jul 2026 18:51:38 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9d80c0sm2123471b3a.54.2026.07.02.18.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 18:51:38 -0700 (PDT)
Date: Fri, 3 Jul 2026 09:51:08 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alex Elder <elder@riscstar.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Bruel <christian.bruel@foss.st.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Nam Cao <namcao@linutronix.de>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Randolph Lin <randolph@andestech.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: PCI: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <akcVSzsJmLs-YNRG@inochi.infowork>
References: <20260517014841.254085-1-inochiama@gmail.com>
 <20260517014841.254085-5-inochiama@gmail.com>
 <kwan2ci7umcckod2623tt2ebwaz6v7ypczz3bqmhfxc6awrkfc@jrjf73wzehcc>
 <8010bb91-77e1-42b4-9f19-d9e70e385d00@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8010bb91-77e1-42b4-9f19-d9e70e385d00@riscstar.com>

On Tue, Jun 09, 2026 at 11:11:20AM -0500, Alex Elder wrote:
> On 6/9/26 9:03 AM, Manivannan Sadhasivam wrote:
> > On Sun, May 17, 2026 at 09:48:39AM +0800, Inochi Amaoto wrote:
> > > Add binding support for the PCIe controller on the SpacemiT K3 SoC.
> > > This controller is almost a standard Synopsys DesignWare PCIe IP,
> > > with some extra link and reset state control.
> > > 
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > 
> > Why can't you reuse the existing spacemit,k1-pcie-host.yaml binding? I see very
> > few differences which could be added using conditionals. Also, this binding
> > defines the PHY property in the controller node, which is a way backwards as we
> > now prefer to define these in Root Port node as spacemit,k1-pcie-host.yaml does.
> 
> I agree.  I have another couple of comments below, including several
> things that just point out what's the same and what's different.
> 
> 					-Alex
> 

A good caught, I have confirmed, they share the same topology so it can
be reused.

Regards,
Inochi

> > 
> > - Mani
> > 
> > > ---
> > >   .../bindings/pci/spacemit,k3-pcie-host.yaml   | 135 ++++++++++++++++++
> > >   1 file changed, 135 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > > new file mode 100644
> > > index 000000000000..46147a37a9ce
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> > > @@ -0,0 +1,135 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/spacemit,k3-pcie-host.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SpacemiT K3 PCI Express Host Controller
> > > +
> > > +maintainers:
> > > +  - Inochi Amaoto <inochiama@gmail.com>
> 
> If you would like to maintain the (common) SpacemiT K1 host
> controller binding I'd be OK with that.
> 
> > > +
> > > +description:
> > > +  The SpacemiT K3 SoC PCIe host controller is based on the Synopsys
> > > +  DesignWare PCIe IP. The controller uses the external MSI interrupt
> > > +  controller.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: spacemit,k3-pcie
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: DesignWare PCIe registers
> > > +      - description: Data Bus Interface (DBI) shadow registers
> 
> The above is new (different from K1), as is "dbi2" as its name.
> 
> > > +      - description: ATU address space
> > > +      - description: PCIe configuration space
> > > +      - description: Link control registers
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: dbi2
> > > +      - const: atu
> > > +      - const: config
> > > +      - const: link
> > > +
> > > +  clocks:
> 
> Clocks and resets are the same as K1.
> 
> > > +    items:
> > > +      - description: DWC PCIe Data Bus Interface (DBI) clock
> > > +      - description: DWC PCIe application AXI-bus master interface clock
> > > +      - description: DWC PCIe application AXI-bus slave interface clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: mstr
> > > +      - const: slv
> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: DWC PCIe Data Bus Interface (DBI) reset
> > > +      - description: DWC PCIe application AXI-bus master interface reset
> > > +      - description: DWC PCIe application AXI-bus slave interface reset
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: mstr
> > > +      - const: slv
> > > +
> > > +  msi-parent: true
> 
> msi-parent and phys are not present in the K1 binding.
> 
> > > +
> > > +  phys:
> > > +    description:
> > > +      PHY phandle from the Combo PHY, the lane number does not depends
> > > +      on this, since the number of lanes provided by Combo PHY can be
> > > +      1 or 2.
> > > +    minItems: 1
> > > +    maxItems: 6
> > > +
> > > +  phy-names:
> > > +    minItems: 1
> > > +    maxItems: 6
> > > +
> 
> The following property is the same as K1.
> 
> > > +  spacemit,apmu:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    description:
> > > +      A phandle that refers to the APMU system controller, whose regmap is
> > > +      used in managing resets and link state, along with and offset of its
> > > +      reset control register.
> > > +    items:
> > > +      - items:
> > > +          - description: phandle to APMU system controller
> > > +          - description: register offset
> > > +
> > > +required:
> > > +  - clocks
> > > +  - clock-names
> > > +  - resets
> > > +  - reset-names
> > > +  - msi-parent
> > > +  - spacemit,apmu
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    soc {
> > > +      #address-cells = <2>;
> > > +      #size-cells = <2>;
> > > +
> > > +      pcie@80000000 {
> > > +        compatible = "spacemit,k3-pcie";
> > > +        reg = <0x0  0x80000000 0x0 0x00001000>,
> > > +              <0x0  0x80100000 0x0 0x00001000>,
> > > +              <0x0  0x80300000 0x0 0x00003f20>,
> > > +              <0x11 0x00000000 0x0 0x00010000>,
> > > +              <0x0  0x82900000 0x0 0x00001000>;
> > > +        reg-names = "dbi", "dbi2", "atu", "config", "link";
> > > +        device_type = "pci";
> > > +        #address-cells = <3>;
> > > +        #size-cells = <2>;
> > > +        clocks = <&syscon_apmu 89>,
> > > +                 <&syscon_apmu 56>,
> > > +                 <&syscon_apmu 57>;
> > > +        clock-names = "dbi", "mstr", "slv";
> > > +        msi-parent = <&simsic>;
> > > +        ranges = <0x01000000 0x00 0x00010000 0x11 0x00010000 0x0 0x00100000>,
> > > +                 <0x02000000 0x0  0x00110000 0x11 0x00110000 0x0 0x7fef0000>,
> > > +                 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x1 0x00000000>;
> > > +        resets = <&syscon_apmu 76>,
> > > +                 <&syscon_apmu 78>,
> > > +                 <&syscon_apmu 77>;
> > > +        reset-names = "dbi", "mstr", "slv";
> > > +        linux,pci-domain = <0>;
> > > +        spacemit,apmu = <&syscon_apmu 0x1f0>;
> > > +      };
> > > +    };
> > > +
> > > -- 
> > > 2.54.0
> > > 
> > 
> 
