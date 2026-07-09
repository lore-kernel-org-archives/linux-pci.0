Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19000DF6C;
	Thu,  9 Jul 2026 01:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559787; cv=none; b=Oayyn/Vf+nChAubyhpsMiOnJBNpFjEJUHFWzX7djD3p+mIst+nFfmKDpP+IduQeBOHP49ySiRaYLVLUN9cpS+QIUVNDWriWAKj63jzEV++ZDRf4XTf0QYLph0EZpift2UN+0qyLLDeiex1ixIaiF9uiJSdNabf9RYofB/k+1R5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559787; c=relaxed/simple;
	bh=ITPBp8p8DF+gNTmAW7Nwi3usxB8BGAIZqGH0Kwf9s6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PGF+1KULgxBGxzQkL1bgRJNTixSIwmU6phA79yEWd0O5MlAMiwADBQDqxPDpNk3lFSywLWvKE6zRb9EPj6xxb54m0WhhFA/AIWQlgOfs8Iu3E2cfpVJZElFJkjJc7/tY4fu+BkUS4kLIIzxKG5rGeNmMpOP17dojDANurJm8XxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzoWfOEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzoWfOEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CE21F000E9;
	Thu,  9 Jul 2026 01:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559785;
	bh=1Evh+pKETM9vTaKIQQxL/GKkI8E0dN28t7+aJXtcOlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FzoWfOEEpdQAoRFtM9VWBV3jRxV1GuI/JV4ZbssAhixZ6J2iRby2OyROThdl7KB7n
	 l75YXNb7GMLR3WruDYL0jwLMgYcD0tw60s3ZqxiMNbeGE2ZfGACXS9Kh0gaXwbsjge
	 OK42z8a45fUwyXjHyyLFGxLoUBE3V3qd0y0cVuM9Adki89vm4vQrST8/iKf0mD8HYk
	 DvScr3dM/7BU3+DmdF/AVcpnLpPIkiQ6VZhCCOmfdJLn3DL+pVLm6+dwxUZmmyCqHW
	 IjcPyDj8+qDcTpJ16KQUoQEOgi7U1u5w7rA8b0NZUGXH7kuS1hKZmFbrelBDGzESDZ
	 n2kWfXm71U74Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/11] cxl: Cache decoder settings on PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260709010304.680422-3-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:16:25 +0000
Message-Id: <20260709011625.76CE21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Resource Leak / Devres Lifecycle Bug

Pre-existing issues:
- [Critical] Out-of-bounds Read / Information Leak
- [High] Endianness / Byte Order Logic Error
--

--- Patch [2]: [PATCH v9 02/11] cxl: Cache decoder settings on PCI devices =
---
commit b30e35d89911fd38d088f7e8ed1637175c1c6ae9
Author: Srirangan Madhavan <smadhavan@nvidia.com>
cxl: Cache decoder settings on PCI devices

This commit caches CXL core's HDM decoder settings in pci_dev->hdm as decod=
ers
are enumerated, committed, or reset. PCI reset paths can use this snapshot =
to
restore HDM programming without walking CXL topology during reset recovery.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index fa978c297546f..83cda63f76a5a 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c

[ ... ]

> +static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_port *port =3D cxlhdm->port;
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev;
> +	struct device *uport;

[ ... ]

> +	if (!dev_is_pci(uport))
> +		return 0;
> +
> +	pdev =3D to_pci_dev(uport);
> +	info =3D devm_kzalloc(&pdev->dev,
> +			    struct_size(info, settings, cxlhdm->decoder_count),
> +			    GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->decoder_count =3D cxlhdm->decoder_count;
> +	WRITE_ONCE(pdev->hdm, info);
> +
> +	return devm_add_action_or_reset(&pdev->dev, clear_hdm_info, pdev);
> +}

[Severity: High]
Could this cause a memory leak if the CXL port driver is unbound and rebound
by a user via sysfs?

Because pdev is the long-lived parent PCI device rather than the child
cxl_port device being probed, these devres resources are tied to the
parent's lifecycle. Repeated bind/unbind cycles on the port driver could
cause the devres allocations and cleanup actions to accumulate infinitely
on the parent device.

[ ... ]

> @@ -989,6 +1061,7 @@ static int init_hdm_decoder(struct cxl_port *port, s=
truct cxl_decoder *cxld,
>  		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value =3D (hi << 32) + lo;

[Severity: High]
This is a pre-existing issue, but does this byte-by-byte access of a
native 64-bit integer break on big-endian architectures?

Since hi and lo are correctly read as native 32-bit CPU-endian integers
and combined into a native 64-bit integer, accessing individual bytes via
target_list.target_id[i] on a big-endian system will place the most
significant byte at index 0. This would reverse the target IDs and result
in incorrect downstream port routing.

> +		cxld->targets =3D target_list.value;
>  		for (i =3D 0; i < cxld->interleave_ways; i++)
>  			cxld->target_map[i] =3D target_list.target_id[i];

[Severity: Critical]
This isn't a bug introduced by this patch, but can this loop read past the
end of the 8-byte union and leak kernel stack memory?

Looking at parse_hdm_decoder_caps(), cxld->interleave_ways can be set
to 16. The target_list union is only 8 bytes long (containing an 8-byte
u64 value and an 8-byte unsigned char target_id[8]). If a device
reports a 16-way interleave, this loop will read uninitialized stack memory
from indices 8 through 15, which could then be exposed to userspace via
the sysfs target_list attribute.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D2
