Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A62F8E8F
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778201524; cv=none; b=JuucZr6w+gy+VX2w0YbXq7ksPqYiiRkocYgt4Z6Clfnkr4z+nY8k2glDXzGqaPrxPOuf2ZYNM6SAYo0miGiF2pDG3+smpEo2tKl0eHpozSMIJWcXY1ScabHCmWK+tGmdLJKQ9OSO0HCDg8OPErD2Kjly2YS8H3391uYVTuWMo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778201524; c=relaxed/simple;
	bh=W2WyodUP6OxGG+EVbRHquHrQbdQ+pUoIKYUjenKCMjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OHqwBww+/QseHUTn4fPSkfkhzH2p8zO586v8lt9L75wD7vpe8zuCWM9ns0VXlC1FEgJ2EJplARUlIHDpmfezZ8fucrRZACE1fVhfReH86YfmzHuO0U4NWqsM6BZQXa9/1DDOk0N6gWyCk4ZAVavY5g3Dl6vnXkDPgrHc0l/+ruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLbhIU0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLbhIU0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A9C2BCB2;
	Fri,  8 May 2026 00:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778201524;
	bh=W2WyodUP6OxGG+EVbRHquHrQbdQ+pUoIKYUjenKCMjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OLbhIU0vSDWqKOQuJDVAiPeutu9CRuhMnjUIRKUmqJC2OQ5O6xcgy76VXmaicDeWM
	 aEyzdoZYkEr/Qd1w1DDbyFBpyupMT9w4seuEwYRum2e4b3+OYMujpXDf6L9A+tNONn
	 wJJqW6EZEIRwCpx7F+V7oeBG7D6ziXSe4/LZi2waYQHHMvtuXNP2xxXZOuwYpZ3nDr
	 kCyip+GgsfJi8h+L1ddr0zig0REekjmH/9z0W2nVINJEb1Yb89ZgWtNljuyXjr60pB
	 mWwjte7BOMkDEn8IHCmhHFQgm2C12QaokyliwbIm+ZaYjvBOZe6EeezgI2CiVfhXoy
	 9OzSnT6DEe30Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/6] vfio/pci: Add PCIe TPH SET_ST interface
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507130956.34441-7-fengchengwen@huawei.com>
References: <20260507130956.34441-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 00:52:03 +0000
Message-Id: <20260508005204.2D2A9C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The rollback logic for successfully programmed steering tag entrie=
s silently fails when an entry write fails, leaving the device in an incons=
istent state.
- [Medium] The `mem_type` field of `struct vfio_pci_tph_entry` is not valid=
ated when `cpu =3D=3D U32_MAX`, breaking future ABI extensibility.
--

commit b4acf86102a9bd7b08e0de22fe836e8de9341956
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH SET_ST interface

This commit adds the VFIO_PCI_TPH_SET_ST operation to support batch
programming of steering tag entries. It includes logic to roll back
successfully programmed entries to 0 if any entry fails, aiming to prevent
inconsistent device states.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index c328515bcaaff..5d10de546d5c6 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -1604,6 +1604,90 @@ static int vfio_pci_tph_get_st(struct vfio_pci_cor=
e_device *vdev,
> +	for (; i < st.count; i++) {
> +		/* Check reserved fields and st are zero */
> +		if (memchr_inv(&ents[i].reserved0, 0, sizeof(ents[i].reserved0)) ||
> +		    memchr_inv(&ents[i].reserved1, 0, sizeof(ents[i].reserved1)) ||
> +		    ents[i].st !=3D 0) {
> +			err =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		if (ents[i].cpu =3D=3D U32_MAX) {
> +			err =3D pcie_tph_set_st_entry(pdev, ents[i].index, 0);
> +			if (err)
> +				goto out;
> +			continue;

If userspace sets cpu to U32_MAX to clear a steering tag, does this bypass
the validation of mem_type?=20

By skipping validation and allowing userspace to pass uninitialized data in
this field, could this break forward compatibility if mem_type needs to be
repurposed later for this case?

> +		}
> +
> +		if (ents[i].mem_type =3D=3D VFIO_PCI_TPH_MEM_TYPE_VM) {
> +			mtype =3D TPH_MEM_TYPE_VM;
> +		} else if (ents[i].mem_type =3D=3D VFIO_PCI_TPH_MEM_TYPE_PM) {
> +			mtype =3D TPH_MEM_TYPE_PM;
> +		} else {
> +			err =3D -EINVAL;
> +			goto out;
> +		}
> +
> +		err =3D pcie_tph_get_cpu_st(pdev, mtype, ents[i].cpu, &st_val);
> +		if (err)
> +			goto out;
> +		err =3D pcie_tph_set_st_entry(pdev, ents[i].index, st_val);
> +		if (err)
> +			goto out;
> +	}
> +
> +out:
> +	if (err) {
> +		/* Roll back previously programmed entries to 0 */
> +		for (j =3D 0; j < i; j++)
> +			pcie_tph_set_st_entry(pdev, ents[j].index, 0);

If a prior call to pcie_tph_set_st_entry() fails (e.g., due to an out of
bounds index) and disables TPH on the device internally, will these rollback
calls silently fail?

Since pcie_tph_set_st_entry() checks whether TPH is enabled and returns
-EINVAL if it is disabled, the partially programmed entries might remain on
the device without being cleared.

If the user later re-enables TPH, could the device end up using an
inconsistent steering tag table?

> +	}
> +	kvfree(ents);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507130956.3444=
1-1-fengchengwen@huawei.com?part=3D6
