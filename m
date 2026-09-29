Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E423394A;
	Tue, 29 Sep 2026 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704273; cv=none; b=rD8nh/l7tB03hynRdble08MmG10w+F00R5mSLZ0GLVV6EgMcqH5aO7QVrdZueCXli4kN/fidu/j10jddcsS/mGatP4oL+fYA4G7qMECcO9Hi92DF4DPsM5u3MyySNdJ4z2kf9fDBOE+J6HA78la2KgQ7fczgPZB96WsfgT2fOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704273; c=relaxed/simple;
	bh=PzRO7iZxKad7zLZy20RqAA4LPdnscqXdcy1fni94Jwo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZP4KD3EfXn5DuY7BjOokne759rhYHaEdGKPLiSAGtLRZUp6INBxhVd1i7crj3K+2iKgcq52EYYINP4lczr15+PlWRoijQpxM5gadAYMWaXjnQ9xlnIT5b/rrIaBbts6ZnmlcZSDT00nTLMbebNKnXBBN/k9sIm1b9P+jYVx+TgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/tnewMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/tnewMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FA61F000FF;
	Tue, 29 Sep 2026 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790704272;
	bh=WdsYedQbxvNzvxZItlMmv+EVwSCS34Z3T4rR6imyunY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/tnewMHmuSD1Z9aypK8aPMMrVPdPM73VoZXYwH/8V1KCYP4Hf/acxq7zMJnpxbU9
	 D9q6WYNHXkmxcHDGz2UR0wrw1JRbPqWb/JA/ZGspiTKsvyHLPfkOdnE9xyFHxKQwkc
	 Z/6T2XJ+KpiggwTPLi2br5fiqpWF5cMCKioKGN3m0/t3v66x/4gCFK87asjp/2wVVI
	 Pt9cxP/CSjUUDfOh82yMRMy7xNuTmWY65h7JIW9DORPTXBVEzd7lNou12GXceYCwh4
	 MWROwFvbE5sErpwW3XwnzCN/XLvFI6Z+rqg/+yls7QyzdqArSS9eQQokQxeiel8g3v
	 Rc8iBNTJ7i1nw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 13/16] vfio/pci: Complete recovery in resume()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260929173305.204856-14-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-14-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:51:11 +0000
Message-Id: <20260929175111.F2FA61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI: deadlock in AER resume due to recursive pci_bus_sem read lock
--

commit ac6b588d8a9a2d9a21c17325b45933f079efe247
Author: Shameer Kolothum <skolothumtho@nvidia.com>

vfio/pci: Complete recovery in resume()

This commit adds the resume() callback to complete host transactions and no=
tify
userspace during VFIO PCI recovery. It restores device state, handles PCI
power state transitions, and finishes restoring hardware state before allow=
ing
accesses.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index a7b7499e071c1..d6cc34240b250 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -2615,6 +2616,87 @@ static pci_ers_result_t vfio_pci_core_aer_slot_res=
et(struct pci_dev *pdev)
>  	return PCI_ERS_RESULT_NONE;
>  }
> =20
> +static void vfio_pci_core_aer_resume(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);

[ ... ]

> +	/*
> +	 * Apply deferred D0 requests before restoring PCI_COMMAND.
> +	 * slot_reset() has already established D0 after a reset.
> +	 */
> +	power_up =3D vdev->power_up_pending;
> +	vdev->power_up_pending =3D false;
> +	if (power_up && !(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_RESET)) {
> +		ret =3D vfio_pci_set_power_state(vdev, PCI_D0);

[Severity: High]
Can this lead to a deadlock of the PCI subsystem?

An AER recovery event triggers the AER core, which acquires pci_bus_sem for
read via pci_walk_bridge().

The AER resume callback vfio_pci_core_aer_resume() then calls
vfio_pci_set_power_state(), which internally attempts to recursively acquire
pci_bus_sem for read via pcie_aspm_pm_state_change().

If a writer, such as a PCI hotplug event, requests pci_bus_sem between these
two read lock attempts, the second read attempt will deadlock.

While this is noted as an unresolved issue in the series cover letter, is
there a plan to mitigate this recursive lock before merging?

> +		if (ret)
> +			goto out_memory;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D13
