Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0944BB26F
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491472; cv=none; b=YppRdafaQ+RCpgvhly3GUHqdz4nUFcgPiTsPaF/FJ+fNO9AwhtxHZsWiBHzPqx9O8cDCY+JiyUHm8/A1qOy5KFgRF0+cBp5d9Do+MHxcDQprYU/szNQLoDumHsNpjFZ2q/BjNvGfatZgcjKQQfAl+YY+7LdQdWnrfem1NnbQaOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491472; c=relaxed/simple;
	bh=l+FW1mRMycGxqPyZqi/omJzwtvXfJJU+euOL2/rObkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=esxtkoLQDz9VA1NA1LHvYsA6uPsOCxeRecSl6pRpsgG0k0JT5U0mhTOnF+9M/NledwTBV/207el080IJk1+2gY7ck0b0ao7aIFlAbXA02FA1SZFjsAv+Z1/vBlTiayfJrV18iZbuIQDu/cjz9MVbZtke1bPUEfxAxlAy7Oj8tOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo+uwrdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo+uwrdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE72C1F000FF;
	Tue, 15 Sep 2026 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491459;
	bh=NC7jFieYBnh57n69QR08hLcwj9LsfhAz3dkXEB/Ot1s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fo+uwrdmVWr1bEFj3XO5MUAkza4glAKtAa3lfPWPjHcgU69aPufdZZwCsVYmjYVvG
	 u8XXLuAUWFSlrS6boTP208CyTTT2f4k3TyXrM1SKfUidW7In89U1hFu0zvpcSXB0uz
	 s+rShushk6U0q/Q7c/lKGo3cGkctpdf+uKptlGBn+bUA8jz8U4H1Ek/Be8NUS8la1B
	 JYqvL/SMG1YYA0ZINwB6MAuY8b3wpsrk1Epk2r7z7kJZt1DUT33+gbmfIsxck4tJAr
	 QDYfG6nC0Mo1Fl3qXkyLm3ZRTSbxIl3tJWD4iTjD9MdZ+xGBlNEjIfTt2m2CeqMi6w
	 Tp0NEneJklFtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/15] iommu/arm-smmu-v3: Flush in-flight fault work
 on domain detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <9692efc467c4dff1de7ad58bfce087ad0d263bd9.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <9692efc467c4dff1de7ad58bfce087ad0d263bd9.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:57:38 +0000
Message-Id: <20260915165738.DE72C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] iommu/arm-smmu-v3: memory leak of master_domain on timeout path
--

commit 93bfbb1f6ed056db517f551ddf8e2b1b26915570
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Flush in-flight fault work on domain detach

This commit flushes in-flight fault work on domain detach and skips IOPF
teardown if the hardware queue drain times out. This aims to prevent a
use-after-free by intentionally leaking the master_domain and iopf refcount
on timeout.

> If arm_smmu_wait_for_queue_drained() times out, fault work may still be in
> flight, and iopf_queue_remove_device() would free iopf groups that the wo=
rk
> also references. Skip the iopf teardown and leak the master_domain, rather
> than risk a use-after-free.

[Severity: Medium]
The commit message states the intent to leak master_domain to avoid a
use-after-free. Is this description accurate?

The risk appears to apply exclusively to the iopf_group structures that
would be freed by the skipped iopf_queue_remove_device() call. The
master_domain structure is entirely driver-internal, has already been
unlinked from the smmu_domain->devices list in
arm_smmu_remove_master_domain(), and is not referenced by in-flight IOPF
works or any other background threads.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 9e657d075f387..c8fb1c38090d1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[ ... ]
> @@ -3422,8 +3423,38 @@ void arm_smmu_attach_release(struct arm_smmu_attac=
h_state *state)
[ ... ]
> +	/* Lastly, flush the fault work that the drained events queued */
> +	if (master_domain->using_iopf) {
> +		iopf_queue_flush_dev(master->dev);
> +
> +		/*
> +		 * A timed-out drain may leave fault work in flight, and
> +		 * iopf_queue_remove_device() would free iopf groups that
> +		 * such work still references. Skip the iopf teardown and
> +		 * leak master_domain, rather than risk a UAF.
> +		 */
> +		if (WARN_ON(timed_out)) {
> +			state->old_master_domain =3D NULL;
> +			return;
> +		}

[Severity: Medium]
Does this early return leak master_domain unnecessarily?

Since kfree(master_domain) appears safe to call here even if the drain
times out, could we free it before returning to avoid leaking master_domain?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D5
