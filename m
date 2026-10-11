Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250F225A38;
	Sun, 11 Oct 2026 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685507; cv=none; b=SCKXoo+4adZKIJR/j16DgcVA/RoAly1NJ7KnuwggRkPTacv7b9AGztGwQEaCSXDdJsRg3LCu5xLH8H1k5yVAm13SH74M1b+41+lNqYkR7ovlJz1z11szjT7aTeB7s9DKEpJ5IE0bWVB9Q/w+enH5hIbX4NdLH8pTimxQO+fHIsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685507; c=relaxed/simple;
	bh=wSb5IUBOdcU8yATmKit2M4Y/85syzXkGyv7HX9iiCU8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CyWymH/Wz1cUWku32EaoTcm/EHbdtpgV7PpmRgbZYpDdWFK4g/fpiD48p2/aoGRcmAv0JFb2gejymOONrOOR/njJJyS23sfPX1dW1jhs4KSADhUcnsUhya/lcyTNwFHx3rlR6b4On1vq9BL7xCCLo34KAgtK8sUfpoXwCaxeYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJpMgfGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJpMgfGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A966B1F000FF;
	Sun, 11 Oct 2026 02:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685506;
	bh=Ubc62XHeJBXunDdpp+0BCjXhuNw0IiBtKNplN7dDA4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mJpMgfGBa/xjERU4P/I78X7bImWs6ptIxiUdYkR5sipazy2bnccJZWaNmpg5NeRdU
	 N0VOzjhkmPF0n2tR3cAnDeW6r/EUj/9uA61/i5SAoxvF+QOsDOZcMKXFN/lDsZyceN
	 pDrg67LDpWCEtjrrd7bfsZXnW25y3XxP/p9N8Ssao6r2GaBjN68JG3rmm3VYT+/gU6
	 L+H5o+F2XIv2bg0QdNVv37Zl5QotKnJI8j+AK/NpEugvs6uv3YCQZuPfpxujbdSW+6
	 DrCVLpsjFhKnsEcCLjSJgkxl1pdzfW+AwB5IkvvyCt5PjQBTJ81Xs71fTyr8JCRdNp
	 dcNE9z3L1XF5Q==
Message-ID: <sashiko-outbox-166975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/16] PCI/CXL: Add CXL Device Reset sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-11-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:25:05 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: CXL reset timeout silently clamped to 20s, invalidating 100=
s capability
--

commit 40437b091280a3bac8200508563fab32b5d72e62
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Add CXL Device Reset sequencing

This commit implements CXL Device Reset for eligible Type 2 devices. It
introduces functions to disable CXL.cache, initiate reset with Memory
Clear, and wait for completion.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/comm=
it/?id=3D04f8f84816d724f8b47f4d47a77916ac37c63a49

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index 471b57391593e..9eb13adf0daa3 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c

[ ... ]

> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
> +	int idx, rc;
> +
> +	idx =3D FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >=3D ARRAY_SIZE(cxl_reset_timeout_ms)) {
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
> +			 idx, CXL_RESET_MAX_WAIT_MS);
> +		idx =3D ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +	}
> +
> +	/* Allow one retry after the mandatory 100 ms quiet period. */
> +	timeout_ms =3D clamp_t(u32, cxl_reset_timeout_ms[idx],
> +			     CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS,
> +			     CXL_RESET_MAX_WAIT_MS);

[Severity: Medium]
Does this clamp_t() logic unintentionally override the 100-second=20
capability?

The CXL 4.0 specification defines reset timeout encodings up to 100 seconds=
,=20
and the array cxl_reset_timeout_ms correctly defines 100,000 ms at index 4.=
=20
However, the timeout calculation explicitly applies clamp_t() with a=20
hardcoded upper bound of CXL_RESET_MAX_WAIT_MS, which is defined as 20,000=
=20
(20 seconds).

When a device legitimately advertises a 100-second wait requirement via=20
capability encodings, this silent truncation to 20 seconds could cause=20
reset operations for compliant devices to prematurely fail with -ETIMEDOUT.

> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +	deadline =3D jiffies + msecs_to_jiffies(timeout_ms -
> +					      CXL_RESET_RRS_WAIT_MS);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D10
