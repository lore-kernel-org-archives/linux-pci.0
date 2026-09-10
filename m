Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989D3A872B
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083378; cv=none; b=WGXfc1s9wFxHJQzwcijGa5M+jmaJ0ij7Mjc+VIIfS6D90BBwP0oPvXeIOHauVVg1OT3z3Z56LzYxdIdX4j6ONsK8IKJQ67/RJoTiRE1XzEe9kvZskrYocqiuPHn4dDk2bdFLLlT7IMlh1D8QlMPITM7WX+Xf0u4xDn0qdhKacvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083378; c=relaxed/simple;
	bh=DN9HO3uItxDKA+khe0dzzzeKdhpa77I7NWsjRm6DF4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XtJplmOYDW8zkq5HaNweR8/33uQBJ0eRNW1Qxk1MeMqFwHLX2G46Vs+KqSwc5Teba6BAAhQlioLo7aW3KFXR15vYae5edEb48k6EedlGBAfWV4fAJ93hU3p2X4ZRzJx/Wb/pzYN8xRrS2IxktS9IdoOXoApEtYr1j8eoM2NYYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1tzkPne; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1tzkPne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F7B1F000FF;
	Thu, 10 Sep 2026 23:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789083374;
	bh=hem2MoSxGchpcPbPASzx7+ZOZC5M3zFjTbesmPs69LE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1tzkPnehGvZYgYxrjozm+1nBQ8icunZv4o1/K4+4SqNNDsZylfWDF0z/+/ZmDsfM
	 Fwa3ZToY7DETlw8RKjzYSksylZgIJyQ4ByKrkLVnLWmbBMSMdGM9AQYY5JHjslSMBW
	 WBIMmwf6WHevCfbOJwO61v1QdkJE1LSU/itZ45VgVxBwdxf+tlhre4hYuQfVAl7uH7
	 pbHiES1PGf1CoT+fss41k/iMpVQHYXPtclq8P0MGykJz9/KI5VUTlodeJjUYLkk1OR
	 I9NqCgpLwrAiLuH5capDP+3Mbu2z0D+hR4yvD5gVshT+ujTUrG3nC+SwSSF5ZZW9xk
	 WhX4TfQ5TDMrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/15] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for
 IOPF event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <ad96e41dec59e583822912f29d8bc7b443103519.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <ad96e41dec59e583822912f29d8bc7b443103519.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:36:13 +0000
Message-Id: <20260910233614.76F7B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] arm_smmu_page_response() incorrectly hardcodes streams[0].id, caus=
ing RESUME and PRI_RESP commands to target the wrong SID for multi-stream d=
evices during error fallback paths, leading to permanent hardware stalls.
--

commit 7f733f885611e1969870b8cc107b40c240d5c27d
Author: Malak Marrid <mmarrid@nvidia.com>

iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event
   =20
This patch updates arm_smmu_page_response() to issue a CMDQ_OP_PRI_RESP for
IOMMU_FAULT_PAGE_REQ events from the PRI queue. It also extends
arm_smmu_enable_iopf() to allow PRI-enabled masters to attach fault-capable
domains.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 8b7d88d469198..815847c2d7b43 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

[ ... ]

> -static void arm_smmu_page_response(struct device *dev, struct iopf_fault=
 *unused,
> +static void arm_smmu_page_response(struct device *dev, struct iopf_fault=
 *evt,
>  				   struct iommu_page_response *resp)
>  {
>  	struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> -	u8 resume_resp;
> +	struct arm_smmu_cmd cmd;
> +	int sid;
> =20
> -	if (WARN_ON(!master->stall_enabled))
> +	if (WARN_ON_ONCE(evt->fault.type !=3D IOMMU_FAULT_PAGE_REQ))
>  		return;
> =20
> -	switch (resp->code) {
> -	case IOMMU_PAGE_RESP_INVALID:
> -	case IOMMU_PAGE_RESP_FAILURE:
> -		resume_resp =3D CMDQ_RESUME_0_RESP_ABORT;
> -		break;
> -	case IOMMU_PAGE_RESP_SUCCESS:
> -		resume_resp =3D CMDQ_RESUME_0_RESP_RETRY;
> -		break;
> -	default:
> -		resume_resp =3D CMDQ_RESUME_0_RESP_TERM;
> -		break;
> +	/* IOPF is gated to num_streams =3D=3D 1 in arm_smmu_enable_iopf() */
> +	sid =3D master->streams[0].id;

[Severity: High]
This is a pre-existing issue, but does hardcoding streams[0].id here cause a
permanent hardware stall for multi-stream devices during error fallback pat=
hs?

Even though arm_smmu_enable_iopf() rejects enabling IOPF for devices with
num_streams !=3D 1, a multi-stream device with dma-can-stall can still gene=
rate
a stall event (EVTQ).

When this happens, arm_smmu_handle_event() converts it to a fault and calls
iommu_report_device_fault(). Since there is no IOPF handler, the fallback
iopf_error_response() will call arm_smmu_page_response() with
IOMMU_PAGE_RESP_INVALID.

Because streams[0].id is unconditionally used here, the RESUME command will
target the wrong SID if the fault originated from a different stream on the
master. The stalled transaction will never receive the RESUME command, leav=
ing
the hardware permanently stalled.

While PRI is disabled for multi-stream devices elsewhere, the STALL path
remains fully vulnerable, and this newly added comment propagates the false
assumption that IOPF gating prevents this scenario.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D7
