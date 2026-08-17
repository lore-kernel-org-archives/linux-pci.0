Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27588279DB1;
	Mon, 17 Aug 2026 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934602; cv=none; b=CvOVHXNhOiDwkGRYs0QDamZy+WSHSJxyyW6k4+BXDdj96MeK3PsvBhJI0rfwlWukL3ICtzNZ6b8DP3vRPGuGk5G2o62hc3mQXiZFeBrCd7NN7/nAkajhAQvasGf4tYrlZ42+/1RHicwosGHQJj8wf/Z6IFXHQa+UJHLSd4hyA08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934602; c=relaxed/simple;
	bh=6KoLb6V1wakUUHtIMt2ZsPtlmcFuYksJYtHI94fDaxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFsiqX5fMQZb+4kGqouLU11TTe8mDoStXo7onmiedwRc1YalffxFILSXNrwk9PZrgxwGdr8HIQMegGi4lqTccRnn0anThCShjYDFy4ofwEffRCMadZnSz57I5YTxXUd+7nIbMq7SSyx6OUc24BLpGw82IRfKKvEDMql8wJMjEuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmpBv7LM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmpBv7LM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1821F000E9;
	Mon, 17 Aug 2026 02:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786934600;
	bh=mjxD5Rm7fLxIUgWAAf13NLw5hSP2HshJwYzbeI7nZYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NmpBv7LMCjeBmTSyJmodTVMHa/5C/z7VAT8UkafDw5dtEEaxEEtfA1EzFmxXbTkKa
	 SQv1PEfV3TzWC5E+rkqqjo7gF94sL4R8K5yBt3lXEfPacl4A3k3K7/Ioe7l5dwAVhI
	 0LThpSGihM+C9w01zxVPVFMMd6BlE0QpbGlhctxyZTZ/W/rLu5UpgRTB0CPebXLLx3
	 4zl9jYlT7qk5r9UCC7xpuiZeoCXsgXM6p/EzmK8C9BLhBQYM23e5Twu8TvIT3GHNIS
	 HFmLELEjecn2VQn+xdI462SKZxDxdh2//15xYF9nvvx0huIKtLVQIXC8YX9k+t6rJw
	 FbmcY52U7TgCA==
Date: Sun, 16 Aug 2026 21:43:17 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, bhelgaas@google.com,
	daniel@riscstar.com, mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
Message-ID: <20260817024317.GA32943-robh@kernel.org>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813222943.1655453-2-elder@riscstar.com>

On Thu, Aug 13, 2026 at 05:29:41PM -0500, Alex Elder wrote:
> Define the binding for the Toshiba TC9564 PCI endpoint function device.
> The third downstream PCIe switch port within this chip has an embedded
> PCIe controller, and that implements two of these PCIe functions.

A better subject would be "dt-bindings: misc: Add Toshiba PC9564 
endpoint functon device".

> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/misc/pci1179,0220.yaml           | 150 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/pci1179,0220.yaml b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
> new file mode 100644
> index 0000000000000..30a76f377eec8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/pci1179,0220.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba TC9564 internal PCI endpoint function
> +
> +maintainers:
> +  - Alex Elder <elder@kernel.org>
> +  - Daniel Thompson <danielt@kernel.org>
> +
> +description: >
> +  The Toshiba TC9564 is specialized SoC that implements a PCIe switch
> +  as well as an Ethernet AVB/TSN bridge.  In addition to these, the SoC
> +  implements other functions, including a reset and clock controller,
> +  an address translation unit, and a few other devices.
> +
> +  The PCI switch has three downstream ports.  The first two are exposed
> +  externally, while the third is used by an internal PCIe endpoint.  The
> +  internal endpoint implements two PCIe functions, and attached to each
> +  of these is a 10 Gbps capable Synopsys Ethernet controller and an
> +  interrupt controller that converts internal "wired" interrupts into
> +  MSIs delivered to the host.
> +
> +  PCIe BARs provide access to registers that manage almost all IP blocks.
> +  The SoC is modeled using a PCI endpoint bus.  The IP blocks are bound
> +  to platform drivers that access the hardware using MMIO through the
> +  PCI BARs.
> +
> +          ------------------------------------
> +          |               Host               |
> +          -----........---------------...-----
> +              |        |             |   |
> +              |  PCIe  |             |I2C|
> +              |        |             |   |
> +    ----------+........+-------------+...+---------------------------
> +    |         |upstream|          |          |     ---------------- |
> +    | Toshiba | Port 0 |          |          +-----+ PCIe pwrctrl | |
> +    | TC9564  ----++----          |   I2C    |     ---------------- |
> +    |  SoC        ||              |controller|     ---------------- |
> +    |             ||              |          +-----+     GPIO     | |
> +    |             ||              |          |     |  controller  | |
> +    |       ------++------        ------------     ---------------- |
> +    |       |     US     |                                          |
> +    |       |            |    ------------------------------------- |
> +    |       |         DS3+====+          downstream port 3        | |
> +    |       |            |    |-----------------------------------| |
> +    |       |    PCIe    |    |       embedded PCIe endpoint      | |
> +    |       |            |    |~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~| |
> +    |       |   Switch   |    | PCIe function 0 | PCIe function 1 | |
> +    |       |            |    |-----------------+-----------------| |
> +    |       |            |    |  BAR  | |  BAR  |         |  BAR  | |
> +    |       |            |    |   0   | |   4   |         |   4   | |
> +    |       | DS1    DS2 |    ----.---- ----.----         ----.---- |
> +    |       --++------++--        :      ...:                 :...  |
> +    |         ||      ||          :      :  :   -------       :  |  |
> +    |         ||      ||   -------.---  -.- :...|clock|       : -.- |
> +    |         ||      ||   |translate|  |M| :   -------       : |M| |
> +    |         ||      ||   -----------  |S| :                 : |S| |
> +    |         ||      ||                |I| :   -------       : |I| |
> +    |         ||      ||                |G| :...|reset|       : |G| |
> +    |         ||      ||                |E| :   -------       : |E| |
> +    | --------++--  --++--------        |N| :                 : |N| |
> +    | |downstream|  |downstream|      ------.----       ------.---- |
> +    | |  port 1  |  |  port 2  |      | XGMAC 0 |       | XGMAC 1 | |
> +    --+..........+--+..........+-------+.......+---------+.....+-----
> +                                      |       |          |     |
> +                                      |USXGMII|          |SGMII|
> +                                      |       |          |     |
> +                                    ---+.....+---      --+.....+--
> +                                    |  Ethernet |      | Ethernet|
> +                                    |    PHY    |      |   PHY   |
> +                                    -------------      -----------
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-ep-bus.yaml
> +
> +properties:
> +  compatible:
> +    const: pci1179,0220 # Toshiba TC96564 (a.k.a. Qualcomm QPS615)

Perhaps somewhere besides a comment say what the relationship to a 
Qualcomm device is.

Rob
