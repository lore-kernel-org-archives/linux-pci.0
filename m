Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E73502A3
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662645; cv=none; b=pSvvjFLBqGv+5Au5YfXo8URNqbLhG5JPguV9anE8470qy0MvvwvP9EXykJ/zZDsyga1a/nWJeBzdBlb08KDHrN/42wL+k47n5PalyRTby8gSX0ghjLX7aL5VYjglI0M0Ge+OkPxK7ydskLsm4yxOx82ib7GNLBWKejtZmh1epp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662645; c=relaxed/simple;
	bh=6Rs6RtN8ajj7KU/CQm2+tEAPLKVx9Nw4zUJBlAgv5uQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwmDBn9CAToOH7iRnqNwFBJ223OOnSmHuYFzTgiB4S13NCVQJ7xlVUfH6e/hLymy41LfJ8teQ3TS+8QXHt7fJ4DQn9TfijZQ7uuqZW2BWM+4UBvN9hNzjnUrmtrvrij8LAs5aaiwvRY0Da3uwdHr+jzTI3DONluPnjIUz66nFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1SJjrBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1SJjrBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFA11F000FF;
	Tue, 29 Sep 2026 06:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790662644;
	bh=m1QVfeHVfD8TlKiRYZzXRO9DNP3eAvLqP2revg58HB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1SJjrBXPFnP/sp91GaQy5xhf1dK6dimG5I02EHSlH9w/SDryuZRL6Y3eFAw01/jd
	 Qv9YxcrKXil337NlV/yOVe8uVKvNZNKWACSy9wD89QLnCTs1x4LX+oS31RnWT3tUUz
	 JkOG5h0t01vfas1+HXr3rMuipxIUZIyLoPRWZWlFbxV8CuG7mDDJYrq99yCTszGTRF
	 ujRpnKtduOKllvLnW9mD5XgH3HMPavSH6z6q3/aO2B16aAmHBHZeT3tWE3l3k+3W82
	 LJa5W9lBf1A43hP6NCjDu49Pa3Jsioa2Ul58p+rVJUfvGSdAxzb5EgakpW7CyB17sE
	 /Qx+gev344k0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/16] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-14-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-14-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:17:23 +0000
Message-Id: <20260929061723.CBFA11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] iommu/arm-smmu-v3: invalid synchronize_irq(0) call when gerror I=
RQ is absent
- [Low] iommu/arm-smmu-v3: dead code via unconditional pm_ops assignment
--

commit f1b9ff2a5159bd528e9134e997eee772c624264d
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Implement pm_runtime & system sleep ops

This commit implements pm_runtime and system sleep operations for the=20
arm-smmu-v3 driver. It adds suspend and resume callbacks that coordinate=20
command queue draining and device resets to manage power state transitions.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 89a4e756ff174..e127e3be3a6ba 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

[ ... ]

> @@ -5830,6 +5930,150 @@ static void arm_smmu_device_shutdown(struct platf=
orm_device *pdev)
>  	arm_smmu_device_disable(smmu);
>  }
> =20
> +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu =3D dev_get_drvdata(dev);

[ ... ]

> +	/* Disable IRQ generation */
> +	arm_smmu_disable_irqs(smmu);
> +
> +	/* Wait for pending gerror handlers */
> +	synchronize_irq(smmu->combined_irq ? smmu->combined_irq : smmu->gerr_ir=
q);

[Severity: Medium]
Is there a risk of calling synchronize_irq(0) here if both smmu->combined_i=
rq
and smmu->gerr_irq are 0?

If the device firmware configuration lacks a combined IRQ and a gerror IRQ,=
=20
and MSI allocation fails or falls back to wired interrupts, both variables=
=20
would be initialized to 0. This evaluates to synchronize_irq(0), leading=20
to an erroneous synchronization on an unrelated system interrupt (like a=20
timer mapped to IRQ 0). Could this statement verify that the resulting IRQ=
=20
is non-zero before invoking synchronize_irq()?

> +
> +	/* Handle any pending gerrors before powering down */
> +	arm_smmu_handle_gerror(smmu);

[ ... ]

> @@ -5846,6 +6090,7 @@ static struct platform_driver arm_smmu_driver =3D {
>  	.driver	=3D {
>  		.name			=3D "arm-smmu-v3",
>  		.of_match_table		=3D arm_smmu_of_match,
> +		.pm                     =3D &arm_smmu_pm_ops,

[Severity: Low]
Does this code leave dead functions compiled into the binary when CONFIG_PM
is disabled?

Assigning the arm_smmu_pm_ops structure unconditionally instead of wrapping=
 it=20
in pm_ptr() prevents the compiler from discarding the unused suspend and re=
sume=20
functions. Should this be wrapped as pm_ptr(&arm_smmu_pm_ops) to avoid=20
dead code bloat?

>  		.suppress_bind_attrs	=3D true,
>  	},
>  	.probe	=3D arm_smmu_device_probe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D13
