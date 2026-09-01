Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A58353A99;
	Tue,  1 Sep 2026 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225518; cv=none; b=rigBf7nJgF6FZrB8+e4dGsSaHjwn0YJ9xL/nPShvcU6aqOqkes1xrZRwZ+GpwCYTfpTL8wClTWhxwFylq+rVpXhKLaEKZQbz86xb3yjE/wK4ltKWkLKEK2/05l+1gfvrererdpExoFxoJmerOQw41xHUU9sNUacMu2Rn9gylVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225518; c=relaxed/simple;
	bh=idIHRkof8sbeVcjiaCH8kNeaLFfAjiPoLmWRaE51QNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AaTHNFzq6F247bPT1XRfJbmmAA5m7tBVmQwPjr9NWBO1VKNDbu23Z5To72rzQb6xsEgReIPfoh6SaC2bJL1p5AHROk8lzeyZmQ35vonxKGRsJei9/lMbLfRkJlI2zcBm8aycNjHT2FKsH/M92oquWDzsFgmKcAqhLDE9+9FHiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKyMFy3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKyMFy3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730521F000E9;
	Tue,  1 Sep 2026 01:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225507;
	bh=zJFEinLEVg2Xx5rSQCnDDXDnX23VEz8h7PfP63s3Vxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UKyMFy3skW9UJXL1IN9drPxuuURVyimgadX2iCnT+2z4apMYJTdvO2Dt1qSE0upRy
	 IrK1vdqvVUbKK8l9+RHk7NsI5csbdEkxFSIQ40xtUZHVP48bv/A4dSGaRYF9jmjyxQ
	 hiy95J0463CoqKbBcKWzTgFJvgjitG3ffyD8mckra2wH1sOE6faDFIEJDF3w8gYaoP
	 9sTwctGYXU62k6S9V1+1jrb4SxDufkO/ZqH2gFm6m2vR2/BHw47iXCT+3Tsn7diyAZ
	 +DY0Rfa6erEg+Ak9LP+LxlMZphDTOWKKJcsQDohJndo9ijqYxcd+5zDfmLKQMgXCVi
	 WHt2szrFGYx+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] of: address: kill of_node_is_pcie()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901011338.1323243-5-elder@riscstar.com>
References: <20260901011338.1323243-1-elder@riscstar.com>
 <20260901011338.1323243-5-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:18:26 +0000
Message-Id: <20260901011827.730521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Outdated comment in `of_bus_pci_match()` incorrectly claims a warni=
ng is issued.
--

commit 0ffaade5a7eebd20cc4d79d7c8ed0d49f6da1857
Author: Alex Elder <elder@riscstar.com>

of: address: kill of_node_is_pcie()

The of_bus->match function for the "PCI" bus type is fairly liberal
in what it accepts as a PCI bus devicetree node.  If a node has no
device_type property, it even allows a node named "pcie@" to be
accepted as represnting a devicetree bus, though it issues a warning
in that case.

> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 499d37ceae210..ee2eb44884d85 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c

[ ... ]

> @@ -156,7 +146,7 @@ static int of_bus_pci_match(struct device_node *np)
>  	 * "ht" is hypertransport
>  	 *
>  	 * If none of the device_type match, and that the node name is
>  	 * "pcie", accept the device as PCI (with a warning).
>  	 */
>  	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
>  		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
> -		of_node_is_pcie(np);
> +		of_node_name_eq(np, "pcie");
>  }

[Severity: Low]
Does the comment block above this return statement need to be updated?

Since the patch replaces the call to of_node_is_pcie() with a direct check
of the node name to avoid duplicate warnings, the comment in of_bus_pci_mat=
ch()
claiming that it accepts the device "(with a warning)" seems to be a minor
documentation regression.

Could we update the comment to reflect the new behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901011338.1323=
243-1-elder@riscstar.com?part=3D4
