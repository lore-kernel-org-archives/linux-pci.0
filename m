Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594813382F0
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140807; cv=none; b=TunLThEZH8xisIhygif/psyekRNaZHbsN3SiZXFpH44Gece/hyFZQCXixTiKnJbq6F1F9izkGoGmMccubbDTcH8yiKAYgUFVCkrIz+iiIswC3X8D2zsNi554mW3puMmBdifLzVn6q1vV9gxZN2SJaPmHIn92siYPDMdTk2HIG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140807; c=relaxed/simple;
	bh=7ZwbYkzLEXxB3Jt+BW5gluU8xy5uO5ls+LcUcmykheA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XyH6clG+wBVRE9HxeZ9/qDThiIUoLLtnG4MNcJPsfRpuNNH36RpmnrqwcgRIK4YN50nyi3FhYu+ACRfrW+BKAh46Mbm4c/anm+vfwMuCGaSu3fCsDCw1A9mOKlWdWpXmEfw36Xjq2HXR8XtcfwJboI/mocb+dUTzZxvwGphCWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDzqBBPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDzqBBPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF59C2BCB8;
	Thu,  7 May 2026 08:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140805;
	bh=7ZwbYkzLEXxB3Jt+BW5gluU8xy5uO5ls+LcUcmykheA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YDzqBBPvkbFz16EgeUr0EHCTmdAECuCJYHzQAlv1LrCzseOSoz2vQgdj45dbQ4Dd7
	 7S24s7WGMs3KOQBOEVEQs3MwqBUc12SeOht0W2AdRFyqolMrsji8nRbnenNevMD2gh
	 SYHlqZy0r+KSFbXX3kJl5TQi8cuvDcU5WEqqNgZ+la91hkG+pClL8rlc2j0WVZtRJh
	 N7+d7uy39wPNTPwKPAy+NcmuvuY5iYPQA/3qIu35EiKBuLKfIuTbHCTJNOwaRJn5LE
	 Z9m4lpPJZuwvD0jSvGbpuxFfS2CgGPurd3Q1H5AxHj4AsBVsjePFNS2G7sN7KYutiP
	 FQQ0s1/TsXBCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 17/31] usb: gadget: tegra-xudc: avoid direct
 dereference of phy->dev.of_node
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260505100523.1922388-18-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-18-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:04 +0000
Message-Id: <20260507080005.6BF59C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing error code assignment when `of_property_match_string()` fa=
ils.
- [Low] Stray newline in error log format string.
--

commit 4dab65591b625c1473fa4d0a6d9ad7c5d6b74f8e
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

usb: gadget: tegra-xudc: avoid direct dereference of phy->dev.of_node

This commit reworks the Tegra XUDC driver to implement a parallel OF node
lookup path based on the "phys" phandle and the #phy-cells of the padctl
provider. This avoids directly dereferencing phy->dev.of_node.

> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc=
/tegra-xudc.c
> index e9d33be028664..f93e0a5651ab7 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
[ ... ]
> @@ -3515,7 +3516,10 @@ static int tegra_xudc_phy_get(struct tegra_xudc *x=
udc)
[ ... ]
> +		index =3D of_property_match_string(np, "phy-names", phy_name);
> +		if (index < 0) {
> +			dev_err(xudc->dev,
> +				"no \"phy-names\" entry for \"%s\": %pe\n",
> +				phy_name, ERR_PTR(index));
> +			goto clean_up;

When of_property_match_string() fails, index receives a negative error code,
but the err variable is not updated before the jump.

Because err remains 0, will tegra_xudc_phy_get() incorrectly return 0 (succ=
ess)
after the clean_up block clears the PHY arrays to NULL?

> +		}
> +
> +		err =3D of_parse_phandle_with_args(np, "phys", "#phy-cells",
> +						 index, &args);
> +		if (err) {
> +			dev_err(xudc->dev,
> +				"failed to follow \"%s\" reference\n: %pe\n",

This isn't a bug, but there is an extra newline character right before the
colon in this format string.

Could this be adjusted to prevent the log output from awkwardly splitting=20
across two lines in dmesg?

> +				phy_name, ERR_PTR(err));
> +			goto clean_up;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D17
