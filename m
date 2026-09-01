Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09F37F8DD
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224020; cv=none; b=hbHlmeXFqJkPBNbY5McK0Unl7m6FcEuPhJkIW169WgXbZLzN3FWXAOVoSKGCMlKjR3ChgWrFcTNtZhihRug6TBu85fOXuZf2JwOqD88Fu9sz0iuSHuZvpLZqow8847/44DVrsZXkLu8z/kivJc2lzldH4EyqqkxzP6mwzQVqwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224020; c=relaxed/simple;
	bh=PHLrUY4nkfYElbT5xRG2Ey/MN9uTKT6QAz2V5vavPqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cTDFZsiaTUsvNEuhQdDfKGYkMdxFdKOKyHX2+QLwxgf0H5nB2zfuj1VnQRGIIqtEfFISgx18K1KqI3kjV5rycTA5O8ZZUw1L/prLFsPsLNSgxxXaHNDAW1X+loz14jOTum6wOBYQc38RXjDerpM7vtGvOSdPtZb0+FXKurj5Ol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brIKgYm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brIKgYm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B141F000E9;
	Tue,  1 Sep 2026 00:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224016;
	bh=TggtmFurxxsY+y0eTYe6jsDBUz/uyt0NrWkjTGpCzUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brIKgYm+jkFpR4IeXRLOr6S5W99OWIXJ01MZC8pC3/TK91+o1SOuN7QGnUB+mDRdl
	 rLJUBE/6Dk2g8A7c0WBS+w1UKFKxk7PVptPQ5rQgV8TgV562bRaqBNDvI921xRv4qO
	 IL8gFNQIWb6DxfYHnZUHycSXj6RECpUIn0XMh9AnbKj7rCiYoBeax3bNLUZse7YoNu
	 SqA2vQ27s8djKxwy5QC3Ch8+/qLAbOHmkVR3GZkKFz7oB3tH6eo7lToj7t42Ts/aHh
	 SWirMolXF9WZKAdE4Eamqsakitecsz/s6e/RkiCyGzbX7+xHV7mCK+P0j9DekQavas
	 XJK8f++bgl1HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/13] iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for
 IOPF event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <9280aea7ae7197eca3f223ef5b998aa25afb29d6.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <9280aea7ae7197eca3f223ef5b998aa25afb29d6.1788222485.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:53:36 +0000
Message-Id: <20260901005336.B6B141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If a multi-stream master device (`num_streams > 1`) has `stall_ena=
bled` set, any stalled transaction on a stream other than index 0 will be r=
eplied to with the wrong Stream ID, permanently locking up the stalled stre=
am and the interconnect.
--

commit e5bd1a5ac6f06fe386135f8eef6843d3096e660e
Author: Malak Marrid <mmarrid@nvidia.com>

iommu/arm-smmu-v3: Submit CMDQ_OP_PRI_RESP for IOPF event

This commit updates arm_smmu_page_response() to issue a CMDQ_OP_PRI_RESP
for IOMMU_FAULT_PAGE_REQ events when PRI is enabled. It maps IOMMU page
response codes to PRI response codes and extends arm_smmu_enable_iopf()
to allow PRI-enabled masters.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 352c916b2a572..64540cfb73244 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

[ ... ]

> @@ -1028,32 +1028,69 @@ static int arm_smmu_drain_queue(struct arm_smmu_d=
evice *smmu,
>  static void arm_smmu_page_response(struct device *dev, struct iopf_fault=
 *evt,
>  				   struct iommu_page_response *resp)
>  {
>  	struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +	struct arm_smmu_cmd cmd;
> +	int sid;
> =20
> +	if (WARN_ON_ONCE(evt->fault.type !=3D IOMMU_FAULT_PAGE_REQ))
>  		return;
> =20
> +	/* IOPF is gated to num_streams =3D=3D 1 in arm_smmu_enable_iopf() */
> +	sid =3D master->streams[0].id;

[Severity: High]
This is a pre-existing issue, but does this hardcoded stream ID assignment
handle multi-stream devices correctly?

If a multi-stream master device (num_streams > 1) has the dma-can-stall
property enabled, arm_smmu_probe_device() unconditionally sets
master->stall_enabled =3D true.

If a translation fault occurs on any stream ID other than index 0, the
hardware generates a stall event. Because arm_smmu_enable_iopf() rejects
num_streams !=3D 1, the IOMMU fault framework fails to find a registered
IOPF handler and falls back to an error response via
arm_smmu_page_response().

Since this function hardcodes sid =3D master->streams[0].id for the
CMDQ_OP_RESUME command, the actual faulting stream never receives a resume
command.

Can this result in a hardware interconnect lockup because the SMMU
permanently stalls the transaction on the faulting stream?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D6
