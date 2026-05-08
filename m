Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA825F994
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276963; cv=none; b=TLzMJoeKTkNTQ3W9XzDaPRQXmSwx3kpZw5MmwRcklc561rj7i2E1D8FKXP2eU+k1Ry8La5Cfn+xr7ucZtr/Z5ev9cj4dmmXArS8jCSCxEbfzO+BAb6fvm/n5JKd5+p1nRAYA+lMBCA8s7ptyJ+28R32GHs4gt3K6F3OvtJTF76c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276963; c=relaxed/simple;
	bh=UoBIY/XvUtd54XfIjiSNJsMkB2cFeCiSK4L3rHDoVNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OuddDzsKdH0ugPX5+5TjH6INOtiMZb0KVzVYFhZrjlinftQu76n1Fyzu4TBFd6PjBYeX1CUgneJkCr44dPpA3yQ9rzdDdx5JKk1bDVMeEShJbzL7RCJ0QW0qO2XRSV05029VXNvIrJ97fvpmu3oDhiSMUr502u7Z6/X/IuZKxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4OTP0IZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4OTP0IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44016C2BCB0;
	Fri,  8 May 2026 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778276963;
	bh=UoBIY/XvUtd54XfIjiSNJsMkB2cFeCiSK4L3rHDoVNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d4OTP0IZ+5A4gZZUfutqz4iaoj6wRroH6ZV/Bg+KvL3rXnCEV6Yrh1OTAd7BW+xfg
	 6VNNpk5YdkxjbQmDI64Qq9JFLJobpkn5CvrM7aCruHIzH+tu//Iq+L2DSNGcvcfkrE
	 2fu3caC2VYvf4ZRmLmmSgfnFLyBQ2KUbhb6Fy7+PK0a1GaOrym0PMsoE4TtuCijlJn
	 uDuOjva8d29PDMcO0gT1nZhO0zVza/wjD04Yb0ZqRS8nTyTM/QmqF9i8V49dOlBF/c
	 md/yi9lF6+//rbX9UKZWd57HgNUvvOl1inWziKefzhM2gX2WdgNC+MWFu1jkY4/UEx
	 YgRgwd2sylkSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/7] vfio/pci: Add PCIe TPH SET_ST interface
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508064053.37529-8-fengchengwen@huawei.com>
References: <20260508064053.37529-8-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:49:22 +0000
Message-Id: <20260508214923.44016C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The error path in `vfio_pci_tph_set_st()` destructively zeroes out=
 successfully programmed ST entries on partial failure, causing an unknown =
and inconsistent device state.
- [High] Positive PCIBIOS error codes from `pcie_tph_set_st_entry()` are pr=
opagated to userspace `ioctl()`, resulting in false success reporting.
--

commit c7946d420debcc101b2f2daf21858db188b20ee7
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH SET_ST interface

This commit adds the VFIO_PCI_TPH_SET_ST operation to support batch program=
ming
of steering tag entries. It includes an error path that attempts to roll ba=
ck
successfully programmed entries to 0 if any entry fails.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -1606,6 +1606,94 @@ static int vfio_pci_tph_get_st(struct vfio_pci_cor=
e_device *vdev,
>  	return err;
>  }
> =20
> +static int vfio_pci_tph_set_st(struct vfio_pci_core_device *vdev,
> +			       struct vfio_device_pci_tph_op *op,
> +			       void __user *uarg)
> +{

[ ... ]

> +		if (ents[i].cpu =3D=3D U32_MAX) {
> +			err =3D pcie_tph_set_st_entry(pdev, ents[i].index, 0);
> +			if (err)
> +				goto out;

Could this return a positive PCIBIOS error code to userspace?

pcie_tph_set_st_entry() eventually calls pci_write_config_word(), which ret=
urns
positive PCIBIOS_* error codes (like PCIBIOS_SET_FAILED). Since the VFS ioc=
tl
handler only treats strictly negative values as errors, returning a positive
value directly will cause userspace to falsely assume the ioctl succeeded.

Should this error be converted using pcibios_err_to_errno()?

> +			continue;
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

Does this error path actually leave the device in an inconsistent state if =
the
entries contained valid non-zero tags before this ioctl was called?

Since the original ST values are not read or saved prior to modification,
this "rollback" destructively overwrites them with 0 rather than restoring =
the
true previous state.

Could we read and save the original values before modifying them, or return
an error without attempting a partial revert?

> +	}
> +	kvfree(ents);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508064053.3752=
9-1-fengchengwen@huawei.com?part=3D7
