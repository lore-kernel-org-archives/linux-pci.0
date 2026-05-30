Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427D19ABD8
	for <linux-pci@vger.kernel.org>; Sat, 30 May 2026 04:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780117152; cv=none; b=TfHmq6Vy1H4iZKBzTiWS3ZuxoxRIjl5hMJWRYgEFo+ycrBtiqUncthw7k/U9KnIayZdl8vkTft2NOWTTvlQqPVkhtQCYwYBoUAjeUiScPeTUkAgqR/Yxft5PCer511spnS4ZByLb3/nnJIJSop9HTMshwJdukk12lL5MoR1uREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780117152; c=relaxed/simple;
	bh=e3PmXAI+p39v7VJwt5cgfWnoZXR4pnFsKXV4zb1Mhvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DpYvgiqN3LmD4oFXxTP3tU3yR9Fk91WM3HLilJ4AO72SFG03z1OKtfsamjqVtNVIehs2CVtyQYIEsX0jeLKsIwE66tZjFBtooZnGl6oJgHNrA09TU/nsfeuGrK1tz78TMcGmc/coFErUrJW/ABePkENcKay0YvhG30KfUAFVwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiMsvRdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiMsvRdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C781F00893;
	Sat, 30 May 2026 04:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780117150;
	bh=M4Ir//HMC0l8Tfb6iRmP/bOFSIxhXpuHFcAI8lbDC4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FiMsvRdEppCoeMAdud28L9BGYG9TZOUX+t7egQG471WyLIOZZ3RYi+rBZwePtHYz1
	 EtSzCxSxyWdgNfZmySvAgmmqIcxdmSciyAvj8acRa3+JANqI8DI6GefInzl6XKBIxo
	 6BvpNmWHgrIa6KR3tQJ18Rh7Zs9LNYaslDeG9MY210v6eP74VAeDFkgieCy1T6KKlA
	 zNm3HHSiB7aUDSHtjV3UOtOa6XdV11IteUPILK7iV02MtsFrw4aRKb570d+z/6IfYS
	 Y8QATzjeqDlkcm5b94eoIq2R53+ZTRN4pUPsdXYtdJRdFA1k5opdhQdacrpfXG849u
	 hU3KbF39LMgPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <bfb23bc455b4f3d8c39663fb2316dbede8f5e7d9.1779944354.git.nicolinc@nvidia.com>
References: <bfb23bc455b4f3d8c39663fb2316dbede8f5e7d9.1779944354.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 04:59:10 +0000
Message-Id: <20260530045910.73C781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded memory allocation in report_partial_fault() allows a mal=
icious PCIe endpoint to exhaust kernel memory (OOM).
- [High] Unratelimited logging of unexpected PRI requests allows a maliciou=
s endpoint to flood the kernel log.
--

commit 9904fc0d39f6cc48ddad4141a58759c0d2ae2811
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Support PRI Page Request in arm_smmu_handle_ppr()
   =20
Now, arm_smmu_page_response() can issue CMDQ_OP_PRI_RESP for page requests
from the IOPF infrastructure. Forward PRI requests from the priq into the
IOPF infrastructure for PRI-enabled masters by building an iopf_fault from
the priq entry and calling iommu_report_device_fault().

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 061f1d46fda0d..371a8bbdf6756 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2252,6 +2253,37 @@ static void arm_smmu_handle_ppr(struct arm_smmu_de=
vice *smmu, u64 *evt)
>  	last =3D FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
>  	grpid =3D FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
> =20
> +	mutex_lock(&smmu->streams_mutex);
> +	master =3D arm_smmu_find_master(smmu, sid);
> +	if (master && master->pri_enabled) {
> +		struct iopf_fault iopf_fault =3D {0};
> +		struct iommu_fault *fault =3D &iopf_fault.fault;
> +
> +		fault->type =3D IOMMU_FAULT_PAGE_REQ;
> +		if (last)
> +			fault->prm.flags |=3D IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;

[ ... ]

> +		fault->prm.addr =3D FIELD_GET(PRIQ_1_ADDR_MASK, evt[1]) << 12;
> +
> +		iommu_report_device_fault(master->dev, &iopf_fault);

[Severity: High]
This isn't a bug introduced by this patch, but does the path handling parti=
al
faults lack bounds checking?

When a PRI request lacks the LAST_PAGE flag, the fault is processed via
report_partial_fault() in drivers/iommu/io-pgfault.c, which dynamically
allocates memory for it:

drivers/iommu/io-pgfault.c:report_partial_fault() {
...
        iopf =3D kzalloc_obj(*iopf);
        if (!iopf)
                return -ENOMEM;

        iopf->fault =3D *fault;

        mutex_lock(&fault_param->lock);
        list_add(&iopf->list, &fault_param->partial);
        mutex_unlock(&fault_param->lock);
...
}

Is it possible for a compromised PCIe endpoint to exhaust kernel memory by
spamming partial page requests with the PRG_LAST bit cleared, completely
bypassing IOMMU queue limits and triggering an OOM condition?

> +		mutex_unlock(&smmu->streams_mutex);
> +		return;
> +	}
> +	mutex_unlock(&smmu->streams_mutex);
> +
>  	dev_info(smmu->dev, "unexpected PRI request received:\n");
>  	dev_info(smmu->dev,
>  		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%01=
6llx\n",

[Severity: High]
This is a pre-existing issue, but could this logging lead to log flooding o=
r a
soft lockup?

Since this message is unratelimited and can be triggered by external device
events in arm_smmu_handle_ppr(), an endpoint sending millions of invalid PRI
requests for disabled or unrecognized Stream IDs could force the kernel to
synchronously print to the log buffer.

Would it make sense to use dev_info_ratelimited() here to prevent CPU
starvation and disk space exhaustion?

>  		 sid, ssid, grpid, last ? "L" : "",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779944354.gi=
t.nicolinc@nvidia.com?part=3D6
