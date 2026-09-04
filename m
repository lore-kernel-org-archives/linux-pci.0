Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F9509F09;
	Fri,  4 Sep 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542476; cv=none; b=t2v9MgbkAtQZqSj56RzZow2TZDwKGa0zwg9p93AzhK8v1r7iISZmLTKX/aukn8MFMcWmiSo7DFSqH38Q4acXbCP1OXMOHMhCVouJoXF9Fej+YP7rxeRF/GTzhzoY0DK9ET4Rsc3GdL9tOH0ol28Ksc7ooPRE/BTKO+JwSVnsaoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542476; c=relaxed/simple;
	bh=J/rtfwaHLsbVjpBNpraIHO3BgCwEI8gsM1UU7ScBgG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eaqyO1rb5Uzz7HhragqnA2cG6qE4wFJ198ks/ukUMcQj0pvefL9AgvxjibarUEng69pnk8tiXo4khasELD4cO+rSAVtRekklILYsewHiYqzX7R6lz3b1UYlyxI6tmWOwmjOv6GCDE0ET507CNms4u2Ojcc4fu6U9lLM1KTtfk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFjebjna; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFjebjna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF8F1F00A3D;
	Fri,  4 Sep 2026 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788542474;
	bh=PsiobePkYfB1Ps6G29+kMZlOEyUXLATj6UB1j9ZtB+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NFjebjnahu6mryTM1IutIrTnxakyPnx1dwrOVMluof9veGOiBozXxkWBDcfXzm7VI
	 eWoOGxDLo5Mh7DbI5Y0/MTrzmJUXVqliY056mYtx3y5bWJgmCJPlsK1QWVK1mPNLT4
	 MJv668QqbNThbWsQaR1yKXVcjAAuJFag5+jqhzxmCzlzD/F7uqX/rN+1/FP4L+XQk3
	 sYmdAczQ/ttMLxtiD86WJBizd6azBkuf867MCxFXehUP1GHWOuvrUWsVvC4oaxKKII
	 Dli2avxij5OCK1jc49f320NrkKm4AFq3/xXyp8SIEppzaKKW1Jb517N8XVgmqaCkCX
	 lD/wzHTTj5DVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: toshiba,tc9563: Document
 embedded GPIO controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-pci-tc9563-aux-v3-1-5b1449d62ba2@oss.qualcomm.com>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-1-5b1449d62ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:21:13 +0000
Message-Id: <20260904172114.2CF8F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The 'gpio-controller' and '#gpio-cells' properties were added to=
 the binding to document GPIO provider capabilities, but were not added to =
the 'required' list.
--

commit 167159eda5a6932cbffa6730117f8dd7e23b2970
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller

This commit documents the embedded GPIO controller within the TC9563 PCIe
switch. It adds gpio-controller and #gpio-cells properties to the device
tree binding, along with the reset-gpios property for the downstream port.

> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/=
Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> index f084830c6d0cb..c4cd162cb084b 100644
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
Should gpio-controller and #gpio-cells be added to the required list?

Looking at the required list in
Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml around line 108,
these newly added GPIO provider capabilities are missing:

required:
  - resx-gpios
  - vdd18-supply
  - vdd09-supply
  - vddc-supply

Without being added to the required list, device trees with incomplete
configurations (missing the newly added GPIO controller properties) will
silently pass schema validation when running dt_binding_check or dtbs_check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pci-tc9563=
-aux-v3-0-5b1449d62ba2@oss.qualcomm.com?part=3D1
