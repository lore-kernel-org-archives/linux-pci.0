Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC4340A6A
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308804; cv=none; b=cnknlQlRfWCy4Txmt3YRoFHXm88oBkRD4r0wXz02DhWp8QoR/T2HczgFUbeGryjOlNTJNjwpDbUvnmXYd/sGg/cKriaqyRghTJTh/myILBrZPmg1DAbTco1TiC+8dzMlEEaWcOOGckdLZAEgRFm853H21RGJcH6iWZ8yed1nVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308804; c=relaxed/simple;
	bh=edaaRPXuInxr/VcgYk1rzxmc85gr9BZGTAzp7QRvPF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P+/YiQM2cv40O4KIaI5NAVOZt/6t7aXSl5Hw4QdfWLFFlE4GxiFohPv8F23+Inp1SQyl0mTSpNW0GHVjlaaaD0OwjNYrR8aBKoYdQNidI3Beo3vWQ116h6BL48LTbqvEnXRMadl6eFQ47fkFH4rClF6EAFmi6IZre2+9DsIhGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+KMN6vh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+KMN6vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470AF1F000E9;
	Wed, 20 May 2026 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779308803;
	bh=S5v9BzA9R/JfOGUmRaDEH44tVY2s1ikMbqP+ZD6iNA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+KMN6vhQ86635bu5zg/JU5QpToNYqi3aih5cg+lclaH7VOyEXWXeUdHtG7cyNuqt
	 C9k1oYNMkGZzkOEjSWs+Xkmvt4kDYWqQvtMeu0+KrkJplrkMkcti6Oajti5kEUfUX0
	 rCLE5GrTJHCEMfq2cz1l6I4i7HINfM5qM0+GuaGg0nt6yFdYB4COAMa70DCv24aR/4
	 yKbcB6FpBmpfkiKJK8d+Ph6y7B8/H8FGe+opO0/OlOStdydTf3GD3KrSe7UIdda/uX
	 8H225PX21W/ZVH7PBC/gBcu+jyJJx3nDS4FvlFR3Tw4cPglIMyXfo6xvp9p4qzYbY9
	 2SBTrjRhK5Ozw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] PCI: Add pci_ats_required() for CXL.cache
 capable devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <9e01e6d39deff2bf751da3e1abb43f35a9169194.1779304390.git.nicolinc@nvidia.com>
References: <9e01e6d39deff2bf751da3e1abb43f35a9169194.1779304390.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 20:26:42 +0000
Message-Id: <20260520202643.470AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The logic intended to allow a Virtual Function (VF) to inherit its=
 Physical Function's (PF) ATS requirements is dead code. As a result, pci_a=
ts_required() will always incorrectly return false for VFs.
--

commit 0af55683d00886be6357cf5cf0cf3df17b4c4b9b
Author: Nicolin Chen <nicolinc@nvidia.com>

PCI: Add pci_ats_required() for CXL.cache capable devices

This commit introduces pci_ats_required() to allow IOMMU drivers to keep
ATS always on for specific devices, like CXL.cache devices. It includes
logic for Virtual Functions (VFs) to inherit the ATS requirements of their
Physical Functions (PFs).

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
[ ... ]
> +bool pci_ats_required(struct pci_dev *pdev)
> +{
> +	if (pci_ats_disabled() || !pci_ats_supported(pdev))
> +		return false;
> +
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev =3D pci_physfn(pdev);

[Severity: High]
Will this VF inheritance logic ever be reached?

According to the PCIe SR-IOV specification (section 9.3.3.1), VFs do not
implement the ATS Extended Capability, which means pdev->ats_cap is always
0 for VFs.

Because of this, pci_ats_supported(pdev) will unconditionally return false
for any VF. This causes the function to return false before it can ever
reach the pdev->is_virtfn check.

Could this prevent VFs from correctly enabling the ATS always on feature
and leave them unable to access host memory without triggering IOMMU
faults?

> +
> +	return pci_cxl_ats_required(pdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779304390.gi=
t.nicolinc@nvidia.com?part=3D1
