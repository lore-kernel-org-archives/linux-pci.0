Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21BA3ACF1E
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968725; cv=none; b=jY6Xw/LZk8NeXLTBlv/yIrBYWSO7jqcCgVnsaxTd63F5Bo8hsNRrVzvOSKPDrQ+mBYJgDeZGrGoRHIMMRnsKw8rT7L9ezF3Zdxq/ngnlkQq/y+l6R2W/fsmB8zI6O5YaK66hMYbUhUylIyldmi8IwQgW0O/BtoVoMXVcSZWVDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968725; c=relaxed/simple;
	bh=YAbSpizlNdk5Dng2F3JVq2x9zZNv5alW5DTR7SHyc7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQjoQZHmjGGUHJT2j9nnFvWH/BHcvk9oNHiQuV/Wo/sobZf0j5YT5ewgG3CPjoN08PidFhrVDiNDUNiCmav756+SyM0jqiVzJzvcaGrZvtC18C+dTWe1P8TxfoXGWz3C6wlVpKtnQggPTVcfMALYyzKKWfvLtZjXjxrRSm9Nol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEpG5H+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEpG5H+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280D61F000E9;
	Thu, 28 May 2026 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779968724;
	bh=gEi184HfDcVPaKXibGS6kW3PEzHLasenZkKhYg26Fpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEpG5H+HAGvSsLxGw2JJ1Bf/tvusHOFzgL+9ticycOXiBX9LKycbQtQ65/vhRyBbe
	 VEPe2q8ocYHoEmNkTmLuFEG/YTZomd0bzCYSWG9yakl71e/Rs55tH305LSZgGOhMCo
	 sc38uf3yH/8uxVdPnIs8fKZgCf8PKadz1MQmQHyOv6KJZ17GoL1Zt63aDXXF7O2BM3
	 6ESQ94Or7vP+1tceHBnJddaGtO3tEbVZLlOw736LlhPiLsphxuacmvKZt+hXnd3InG
	 Gq0dmH5Fmreh+y1ckDEcruS6D4FA3KXyPqu/vkPnYKPqED5U2REay0hMLckMv5SLd1
	 BfdK9WwOeia5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] iommu/arm-smmu-v3: Drain in-flight fault
 handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <c107dd18765780ad48c3f6d30e52cbe33fb34e22.1779944354.git.nicolinc@nvidia.com>
References: <c107dd18765780ad48c3f6d30e52cbe33fb34e22.1779944354.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 11:45:23 +0000
Message-Id: <20260528114524.280D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The EVTQ drain logic introduced to fix a Use-After-Free vulnerabil=
ity is flawed: it fails to fully prevent the UAF and introduces a new deadl=
ock vector.
--

commit 0c247207412e55b576df6d5bf6788056a0ed654c
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Drain in-flight fault handlers

This commit attempts to fix a use-after-free vulnerability by draining
the SMMU hardware event queue and the IOMMU core IOPF software
workqueue during a domain detach or replace operation. It introduces
logic to poll the event queue and synchronize the IRQ handlers before
flushing the IOPF queue.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3267,10 +3267,29 @@ void arm_smmu_attach_release(struct arm_smmu_atta=
ch_state *state)
>  	struct arm_smmu_master_domain *master_domain =3D state->old_master_doma=
in;
>  	struct arm_smmu_master *master =3D state->master;
> =20
> +	lockdep_assert_not_held(&arm_smmu_asid_lock);
>  	iommu_group_mutex_assert(master->dev);
> =20
>  	if (!master_domain)
>  		return;
> +
> +	if (master_domain->using_iopf) {
> +		struct arm_smmu_device *smmu =3D master->smmu;
> +
> +		/* Drain the hardware eventq */
> +		if (master->stall_enabled) {
> +			arm_smmu_drain_queue_for_iopf(smmu, &smmu->evtq.q);
> +			/* Ensure pending events have reached the IOPF queue */
> +			if (smmu->evtq.q.irq)
> +				synchronize_irq(smmu->evtq.q.irq);

[Severity: High]
Since arm_smmu_attach_dev() installs the new Stream Table Entry (STE)
before calling arm_smmu_attach_release(), the SMMU can start generating
new faults under the new domain's configuration while this code executes.

Because the attach_dev driver callback hasn't returned yet, the IOMMU
core hasn't updated the device's attach_handle.

Could the concurrent event queue threaded handler read the old
attach_handle and route these new faults to the old domain's handler?

Since arm_smmu_drain_queue_for_iopf() only drains up to a snapshot of
the queue producer index, wouldn't these newly generated faults remain
queued against the old handle, leading to the same use-after-free this
attempts to fix when the core frees the old handle?

Additionally, is it safe to call synchronize_irq() here while holding
the iommu_group_mutex?

Since the event queue is shared across all devices on the SMMU, and the
arm_smmu_evtq_thread() handler processes faults in an unbounded loop,
could a continuous stream of faults from another device prevent the
handler from exiting? This might cause synchronize_irq() to block
indefinitely and deadlock the attach operation.

> +		}
> +		/* Pending events might be in the combined_irq handler */
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779944354.gi=
t.nicolinc@nvidia.com?part=3D4
