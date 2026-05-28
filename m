Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540239F19C
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959634; cv=none; b=qvCL6JRBaOUPDqQjTeT04ZgwSg2qBsoS6VC80wJf+yWbrvTN/+EkOdiFhqITvdqnLZbmeJxOsxJTXf5VWmRNEVAhRIBeL/YQtfbdnE4HWxbJMV7OP+nzROWZs/9BlYJxtTh9yrIdKfVHeJa6sGZ5bIH8f6j4wqC71wGN2V+HA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959634; c=relaxed/simple;
	bh=yGvljmuUcf00d+GDlBOWLDE5H+mX0W9VH7EM0p0u6LA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Grloh1Z1gKdo5T+HP0Ci2QMv7wGxylCBqgdSK8m38kWtz8rAz5UURE0EyVQHCNOg3bJNBAPia2RYWcVFTNmSGXCGyQAoqBTWE0KSoMbv5dlcnN/VzyVQO3s1tgPBsM3p5M+tP26/Jd5gJnCDus9O3AZbfDZz+fC5bYiivG3OJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThlKeo+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThlKeo+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C8F1F000E9;
	Thu, 28 May 2026 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779959633;
	bh=Y7KijmQWgaiPbKbfPF9CNim4scrPtp+Q3FZ+dW3DZ9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ThlKeo+hEbOnT4wbslZ4uwLYKmqD68FyLfr3t1cDp+xTfmn34LQAIKD8g4gpFj7uy
	 bmpCJAasnkVvGWcS82LOs0lQy9tZzpcWZACsmZ9w+8/N98MdNH2tvkNcFtdiDivpVe
	 p2blZaAY13+JfZLbXfzF0Z3O4lz6hzvk0OQq4gUIV+ibFn5bwjsCoiMGI6EAckkYQq
	 cUKhnqaUiAaDs1ZirIhqEqWPc/16Cd/df2hlai9NdTI4swymcypW05+h/BC90syeoj
	 UHvbZp8v0xQsoz1sbdvl7vRy1/X++wqKEDTvsTv77bMLxtN1HhQ5dNEZUEek7CH0Nj
	 qPZ4QheZTmxeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <9b99c4ae66653e49b849dbca0ed2caee1cceb368.1779944354.git.nicolinc@nvidia.com>
References: <9b99c4ae66653e49b849dbca0ed2caee1cceb368.1779944354.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 09:13:52 +0000
Message-Id: <20260528091353.22C8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Updating multiple CR0 enable bits in a single write causes CONSTRA=
INED UNPREDICTABLE behavior.

Pre-existing issues:
- [High] The kdump kernel path forcibly disables the PRI queue in hardware =
but leaves the ARM_SMMU_FEAT_PRI software flag set.
- [High] Failure to enable IRQ generation in hardware bypasses the PRI disa=
bling logic, leaving the PRI queue enabled without functioning interrupts.
- [High] SMMU interrupts (EVTQ and GERROR) are enabled in hardware even if =
the OS fails to register their IRQ handlers, leading to potential unhandled=
 interrupts.
--

commit cbf6d221eefa894b802ea8dddcf53abb97fab008
Author: Nicolin Chen <nicolinc@nvidia.com>

iommu/arm-smmu-v3: Disable PRI when no IRQ handler is registered

This patch updates the SMMUv3 driver to clear the ARM_SMMU_FEAT_PRI flag
when PRI queue IRQ setup fails. It also ensures that the PRI queue is
disabled in the hardware CR0 register if the feature is no longer supported
after IRQ setup.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 371a8bbdf6756..72fd5caa27368 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4738,11 +4738,14 @@ static void arm_smmu_setup_unique_irqs(struct arm=
_smmu_device *smmu)
>  							IRQF_ONESHOT,
>  							"arm-smmu-v3-priq",
>  							smmu);
> -			if (ret < 0)
> +			if (ret < 0) {
>  				dev_warn(smmu->dev,
>  					 "failed to enable priq irq\n");
> +				smmu->features &=3D ~ARM_SMMU_FEAT_PRI;
> +			}
>  		} else {
>  			dev_warn(smmu->dev, "no priq irq - PRI will be broken\n");
> +			smmu->features &=3D ~ARM_SMMU_FEAT_PRI;
>  		}
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but EVTQ and GERROR interrupts are enabled in
the hardware IRQ_CTRL register even if their IRQ handlers fail to register
earlier in arm_smmu_setup_unique_irqs():

    irq =3D smmu->evtq.q.irq;
    if (irq) {
        ret =3D devm_request_threaded_irq(...);
        if (ret < 0)
            dev_warn(smmu->dev, "failed to enable evtq irq\n");

Does the unconditional propagation of EVTQ and GERROR enable bits to the
hardware trigger persistent unhandled IRQ storms if registration fails?

[ ... ]

> @@ -4771,8 +4774,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_dev=
ice *smmu)
>  					arm_smmu_combined_irq_thread,
>  					IRQF_ONESHOT,
>  					"arm-smmu-v3-combined-irq", smmu);
> -		if (ret < 0)
> +		if (ret < 0) {
>  			dev_warn(smmu->dev, "failed to enable combined irq\n");
> +			smmu->features &=3D ~ARM_SMMU_FEAT_PRI;
> +		}
>  	} else
>  		arm_smmu_setup_unique_irqs(smmu);
> =20

[Severity: High]
This is a pre-existing issue, but if arm_smmu_write_reg_sync() fails to ena=
ble
IRQ generation in hardware at the end of arm_smmu_setup_irqs(), the function
still returns 0:

    ret =3D arm_smmu_write_reg_sync(smmu, irqen_flags,
                                  ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
    if (ret)
        dev_warn(smmu->dev, "failed to enable irqs\n");
   =20
    return 0;

Does this silent fall-through bypass the PRI disabling logic in the caller
and leave the hardware PRI queues enabled without functioning interrupt
drainers, potentially causing unrecoverable PCIe bus stalls?

[ ... ]

> @@ -4931,6 +4936,10 @@ static int arm_smmu_device_reset(struct arm_smmu_d=
evice *smmu)
>  		return ret;
>  	}
> =20
> +	/* arm_smmu_setup_irqs() might have unset the ARM_SMMU_FEAT_PRI */
> +	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
> +		enables &=3D ~CR0_PRIQEN;
> +
>  	if (is_kdump_kernel())
>  		enables &=3D ~(CR0_EVTQEN | CR0_PRIQEN);

[Severity: High]
This isn't a bug introduced by this patch, but the kdump kernel path forcib=
ly
disables the PRI queue in hardware here while leaving the ARM_SMMU_FEAT_PRI
software flag set.

Does bypassing the clearance of ARM_SMMU_FEAT_PRI force active endpoint
capabilities against disabled hardware queues, causing permanent SMMU abort=
s?

[Severity: High]
Further down in arm_smmu_device_reset(), the SMMU interface is enabled using
the updated enables mask:

    enables |=3D CR0_SMMUEN;
    ret =3D arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
                                  ARM_SMMU_CR0ACK);

Does updating multiple CR0 enable bits in a single write cause CONSTRAINED
UNPREDICTABLE behavior?

By clearing CR0_PRIQEN above and setting CR0_SMMUEN simultaneously here,
might this trigger an unpredictable hardware state? Would sequenced
write-and-ACK patterns for each enable bit resolve this synchronization fla=
w?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779944354.gi=
t.nicolinc@nvidia.com?part=3D7
