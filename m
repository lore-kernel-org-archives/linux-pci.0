Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D03112AB
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224127; cv=none; b=GC6peDlPa8fLPPrmK9zxg/EO+2PgZtxzbcWTslq+515qTNoGupqN9MEDezFnhYQqgJuti59BsVS9x0avSs5nqu6kNwaFxZw9o/ZxSbqP24umnWzCWg4sKRtPvIWX2TiV9Z1DmKdLh4q4xQozxDsl0Nle0cHTRhRyEkfg9JLdQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224127; c=relaxed/simple;
	bh=L7FGpSnJpY2I7mL3iL5cZWRbRdAn05m1p2pNmGQHoZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bS1UTJyLkvhkZsIHULnc/fyEMParxLAYzRgBsS4nXY/DzmeDoYuLgl45NjqL1xqcpDT0ELYWierp8riPE3o6Mwaafde0UiUuc+20w8Nf2fiKVfv1oazNoX+dOaqsYgRrUVg0ZG81NMEL/0nlfNafvQpFgLFxf3Rbac4vT4DRR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1kPcADQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1kPcADQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DDA1F000E9;
	Tue,  1 Sep 2026 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224123;
	bh=78zd7UZknGn2qhMezmHs1mH6v8/XvkDKxNamPVVlXBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1kPcADQlghn5Hbzjl/QqK0HcJuWFbrXbQ4w1cHN8afpxdXgM7wkugPQSF6BdrgOT
	 UUwxhNk9Bm1WM2+HYJ/YCxijkF7TwNj2awqlHeay9xPSwkf6n7AbWJZ+99fMoVJ/bd
	 J/gX/CZoXnDY0VTFzhGX+6bPMU4WN3vGKoBN7Tk/6No2y2OZ2YgKpB6FPIeImtyuZa
	 pJAde2PGuALNez59lS2NzjJDNz5hrUbTVzBrEg2jeY+xYulNldQXKCvf8OA3YxqwWF
	 j1ryLdzGh6yX12iWKrLLC+wSmUaNnThQq7pXFO2QFc8vfXWWWSBrWr/jy+i+D95koq
	 SjBbfZOcmjxBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/13] iommu/arm-smmu-v3: Flush in-flight fault work
 on domain detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <45b6e8c6dab5b67a91ba54c32bf11ab3347d80f5.1788222485.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <45b6e8c6dab5b67a91ba54c32bf11ab3347d80f5.1788222485.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:55:22 +0000
Message-Id: <20260901005523.68DDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pre-existing UAF on the IOMMU core domain during a race window=
 between IOPF queue flush and IOMMU core handle update.
--

commit fe39d3d0018e082fcdaca3fbd4d2a4bd526c0f92
Author: Nicolin Chen <nicolinc@nvidia.com>

    iommu/arm-smmu-v3: Flush in-flight fault work on domain detach

This commit adds synchronization and flushing of the IOPF queue during doma=
in
detach. It ensures that all in-flight stall events and fault work are handl=
ed
or safely leaked in case of timeouts.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index d255ff2519f9d..1851ee7ec15b9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3412,8 +3413,40 @@ void arm_smmu_attach_release(struct arm_smmu_attac=
h_state *state)
[ ... ]
> +	/*
> +	 * Only IOPF-enabled attachments queue fault work, and such work
> +	 * references the old domain via its attach handle. Flush it, as
> +	 * the IOMMU core might free the old domain once this returns.
> +	 */
> +	if (master_domain->using_iopf) {
> +		/* Lastly, drain the IOPF queue */
> +		iopf_queue_flush_dev(master->dev);

[Severity: Critical]
This is a pre-existing issue, but does flushing the IOPF queue here leave a
race window open for new faults to be resolved to the old domain before the
function returns and the IOMMU core updates the attach handle?

During a domain transition, the hardware is reconfigured to the new domain,
and arm_smmu_attach_release() calls iopf_queue_flush_dev(). If the device
immediately generates a new fault, the EVTQ IRQ thread reads it and calls
iommu_report_device_fault().

Because the IOMMU core only updates the attach handle after the driver's
operation returns, the new fault is incorrectly resolved to the old domain's
handle and queued as fault work.

The IOMMU core then frees the old domain, and the queued work executes,
dereferencing the freed domain via
group->attach_handle->domain->iopf_handler(group).

Can this result in a Use-After-Free of the iommu_domain structure by an
untrusted guest or device generating faults immediately after a domain
transition?

> +
> +		/*
> +		 * A timed-out drain may leave fault work in flight, and
> +		 * iopf_queue_remove_device() would free iopf groups that
> +		 * such work still references. Skip the iopf teardown and
> +		 * leak master_domain, rather than risk a UAF.
> +		 */
> +		if (WARN_ON(ret)) {
> +			state->old_master_domain =3D NULL;
> +			return;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D4
