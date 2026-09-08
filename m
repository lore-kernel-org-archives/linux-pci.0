Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332253A88D;
	Tue,  8 Sep 2026 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881679; cv=none; b=UE0tqUDblzpOTnKSSCu3X0K24GkeyEyYDcVz6F7dsB885oc/9eZa2mIsG46t/WqS54dGB8mWE6jm4KqoQYGMHPqP8kILx7BzvQfgGdh+tBbxQ3ysF/MIEWNtOKb6wzKdjiSWdcn1pKbBwxkB8ejW1Tfxo1x5X2vxkDpVF0u1bOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881679; c=relaxed/simple;
	bh=crZk0K9G9y+Hv5CV7VCvUe9/180iqcKz2cQsBplxnYg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5dPITxjoNhUqmOWGXwD5fv6dbXqqAOVnrGXvS6EzPQeBUga6uhYiqde59EQBIctQYWf9XnhjgPM1jImGNyX2duDl70+NslxnhVBG5L8I6jIGfAqiTOjCZn+UJ39jCr8aUDSzWNNTy71f55GPxjpneYwY2FiYQwRb9aeZLVfTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BD21F00A3D;
	Tue,  8 Sep 2026 15:34:29 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: PCI: toshiba,tc9563: Document
 embedded GPIO controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260908-pci-tc9563-aux-v4-1-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
 <20260908-pci-tc9563-aux-v4-1-c7fc7778292b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:34:28 +0000
Message-Id: <20260908153429.F3BD21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added GPIO provider capabilities 'gpio-controller' and=
 '#gpio-cells' are missing from the schema's 'required' list.
--

commit 6d6cb30a1eb86b847e98eea66d5ba6cc77a091a7
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller

The TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
lines. Describe the switch node itself as the embedded GPIO controller
and document the per-port reset-gpios property.

> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/=
Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> index f084830c6d0cb..2f03e4e45114d 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> @@ -31,6 +31,11 @@ properties:
>      description:
>        GPIO controlling the RESX# pin.
> =20
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +

[Severity: Medium]
Should these newly added GPIO provider capabilities be included in the
schema's required properties list?

Looking at the required list in
Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml:

required:
  - resx-gpios
  - vdd18-supply
  - vdd09-supply
  - vddc-supply
  - vddio1-supply
  - vddio2-supply
  - vddio18-supply
  - i2c-parent

If the new capabilities are omitted from this list, device tree nodes missi=
ng
gpio-controller and #gpio-cells will silently pass schema validation,
allowing incomplete configurations to enter the device tree.

At runtime, dependent nodes (such as the downstream ports attempting to use
reset-gpios) could fail when the provider is misconfigured.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-pci-tc9563=
-aux-v4-0-c7fc7778292b@oss.qualcomm.com?part=3D1
