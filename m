Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A7185B48;
	Sun, 11 Oct 2026 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791705761; cv=none; b=D9Glw8Qqrs9aEC84L1O0vHjzQ32wZ9DvZLMCuapf3l5X08v8ZmIKpn2Xp5D+0siK1YFC2yne7GB1OhyRKat676dt0eRntRqowNC+nxn6cz2Z/rYRJ8cDcn1MeZ6FTurtfe1J9qlL/ZzEjzr50p85OCP9vs/WsoF7h+7qIW9u45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791705761; c=relaxed/simple;
	bh=MU8L6IXmZrkKoGlxyStZ1+wlog92a8D9WjnxI6oDcC0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=IWWznqPaaQh4GZQ2AU9Hg3fdqen8J8ooG+j9IvqN/r0mu9yh2N+3tEKQLQDFVzxt7fBch2+ylME/bqjItL2KSWkwXbGgF9rornYf23YPkGoYAEYgmjlg2Gkj7CYjg2M/EE8XLKrW5jzOV557LN8loTtZwuZM/e/Yj/buFVw7F7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/vLLDRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/vLLDRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CBF1F0089B;
	Sun, 11 Oct 2026 08:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791705760;
	bh=6CvTNez7l115GOm6YA/6USarFPxsqboXk4k3/cvkQZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/vLLDRrvYrxY+jm8X/xuPdYAFANjAdhYqVeS6NRwABNlWXPqPXnmy2oL83Y+NOOU
	 qjbjmASXvGQ9vIF9QuXv+hF+KnkqlL0vFcBuNPFT/HFf2WMmydjWjt6wRbg2RzTjfl
	 LG0w9wL6v9n/F6CIU/Dp5WzGJsc4ZN1UHR6Vc+MA1d4Gc7r2HxlbuDStPgJsdYwQLu
	 JBFHCYqEdYXgwtpD+7fF4ffIsDH4l6FaL4fzg4Hir4XpyXM+1Nltel0ZG8sJ6AhqbD
	 8qybRugYJw5CrW05ypbOGXKF7RmkUP3mIkfafDQqBfiISKSaktbckBcnc6bYubrcRJ
	 vYwSQb3uHOxPg==
Message-ID: <sashiko-outbox-167115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] ath12k: Use VFIO MSI cache when available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011074514.515894-8-jtornosm@redhat.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
 <20261011074514.515894-8-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 08:02:39 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: unsafe linear scan of extended config space on baremetal
--

commit 7935697effd72af8780a5758936f11256bc2c6d5
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

ath12k: Use VFIO MSI cache when available

This commit modifies the ath12k driver to search for a VFIO MSI cache in the
PCIe extended config space. It uses these cached host MSI physical addresses
for firmware configuration instead of guest IOVA addresses, resolving issues
when the device is passed through to a VM via VFIO.

> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless=
/ath/ath12k/pci.c
> index f7879fb48d32e..8e92213fd3fce 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
[ ... ]
> @@ -811,6 +815,39 @@ static int ath12k_pci_msi_alloc(struct ath12k_pci *a=
b_pci)
> =20
>  	ath12k_info(ab, "MSI vectors: %d\n", num_vectors);
> =20
> +	/*
> +	 * Try to get host MSI address from VFIO cache.
> +	 * When running on a VM, the ath12k firmware requires physical host
> +	 * MSI addresses and cannot handle guest IOVA addresses.
> +	 * qcom-vfio-pci writes host MSI values to extended config space with
> +	 * a magic signature "QMSI" for discovery. Search for it.
> +	 */
> +	msi_offset =3D qcom_vfio_find_msi_cache(ab_pci->pdev);

[Severity: Medium]
Is it safe to unconditionally call qcom_vfio_find_msi_cache() on all setups,
including baremetal hardware?

This function performs a linear scan of the extended config space:

include/linux/qcom_vfio.h:qcom_vfio_find_msi_cache() {
    ...
    for (offset =3D PCI_CFG_SPACE_SIZE;
         offset <=3D PCI_CFG_SPACE_EXP_SIZE - QCOM_VFIO_MSI_SPACE_SIZE;
         offset +=3D 4) {
        if (pci_read_config_dword(pdev, offset, &magic))
            continue;
    ...
}

Reading arbitrary PCIe configuration registers on baremetal hardware can
trigger read-to-clear side effects, unsupported request (UR) errors, or
Advanced Error Reporting (AER) faults.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011074514.5158=
94-1-jtornosm@redhat.com?part=3D7
