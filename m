Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794996377;
	b=yDluqlIU0OPNBqyWYSXSKeAVYJWpiGHxmMTM1TuH7FKMRMLb+r7cBmK0A2n4qo87zfs5
	 qiYITm7GdejVqi9VWPOS5YpvrDvSn+Vq0x9PXj3aEFcntbZxHDR0s+ul7nrY/0+RgMgQL
	 7zPQY0zIjWTOp9gR9EXVkNWCI8DfjU+LPc8AA3Qvv/DzIlNQcAcW7hislLccgZLQ/QSkG
	 vfVjeAd7W/jtEbnGy9nU6cvTQwEvXpO/BMZmOpWmzb0eiiDFEAJmOcDrYQkNPL4SLxjTg
	 iMf3EU+iI3UNtXtyFreHg6XDsUYLvpM+VbZrntrEvelkmj6lMUcnxYh9Cqis9CDo2sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794996377;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/y/BI38+Wr2DmR3gZbmuNB65fKyw6bGdS1gcYbxWjno=;
	b=an2T6INfmQ70vc+sm5dN1Hg/jyNlmt1EOcve8XM/r+tMZhAuhdgZg5x3FNIq73hrAv0h
	 b+eKI+6Tmq+V0OCxpHH9scBgHizGJFsiTm0jsFmUSzRvyGaboH1m+zYzysyODd5dCpFly
	 EzDkQuxnTfjE/D8AMMIOHao483dL6NDMNWv4XGcQDNZe5P1x4r3ghGMqbQE7PZeineT7t
	 UOhRZrq9airIF7MsOC0cjW5mL7WwI/cQPPbaM1tUkdh7hD/SBKxv1r9UudCTeN5HIOuFf
	 pcqvF+LqePvobWmaCevvAhhR29p7Wwci5d3m4wsVVzgY/UhPolTTkBFRH5NlasYixog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2QF93dA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9746606A325;
	Wed, 18 Nov 2026 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e2QF93dA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF9C1F000C4;
	Wed, 18 Nov 2026 10:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794996376;
	bh=/y/BI38+Wr2DmR3gZbmuNB65fKyw6bGdS1gcYbxWjno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e2QF93dAJQVfhM83WeVCui/scM67d/E1N46RRKmX6TV8sjjxDsmjhEKSwsqGByJCM
	 8J3gdT08Xgv/3aaxWxEgwnhph93EMNuCvxphPEY2diNmihLirewkHiMKopPfa4NHEK
	 aGuPqWBpujDEbkN1yo+NLU8B0G/OktksUcdPUIiEbKdsndEd7wkYe7sNk6BVNIspoV
	 9gB5NsYnhD1/X/HHf3Dv/kdLgdzjfArdqi04O7duO1nfMhS6/6m/rxLiLwnObpQk30
	 R/cmeJq7W7FWJjWEYADxrxv2coZk+6FVUnC2cgWjZ8b5OqqEEiGL5J4gtbuKbG9tpp
	 trZ0FqiO1r64Q==
Message-ID: <sashiko-outbox-220654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 06/13] PCI/TPH: Add macros to check standard and
 extended TPH support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-7-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:06:16 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] PCI/TPH: pcie_*_tph_supported() macros return true when
  pci=3Dnotph is set
- [Medium] PCI/TPH: pcie_*_tph_supported() macro stubs do not evaluate
  or type-check pdev
--

commit 80062e3e48e12a212317dc82386d43fd4c4bb4c9
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add macros to check standard and extended TPH support

This commit adds the pcie_std_tph_supported() and pcie_ext_tph_supported()
helper macros to query standard and extended TPH requester support via
pdev->tph_max_type, along with stub definitions for !CONFIG_PCIE_TPH.

> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index b2bec02f3ea0e..50640fdc84e14 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
[ ... ]
> @@ -21,6 +23,18 @@ enum tph_mem_type {
>  };
> =20
>  #ifdef CONFIG_PCIE_TPH
> +/**
> + * pcie_std_tph_supported - check standard TPH requester support
> + * @pdev: PCI device
> + */
> +#define pcie_std_tph_supported(pdev) \
> +	((pdev)->tph_max_type >=3D PCI_TPH_REQ_TPH_ONLY)
> +/**
> + * pcie_ext_tph_supported - check extended TPH requester support
> + * @pdev: PCI device
> + */
> +#define pcie_ext_tph_supported(pdev) \
> +	((pdev)->tph_max_type =3D=3D PCI_TPH_REQ_EXT_TPH)

[Severity: Medium]
Do pcie_std_tph_supported() and pcie_ext_tph_supported() return true even
when the kernel is booted with pci=3Dnotph?

pci_tph_init() populates pdev->tph_max_type during probe without checking
pci_tph_disabled, while pcie_enable_tph_ext() checks pci_tph_disabled and
returns -EINVAL.  With pci=3Dnotph on the command line, callers such as the
VFIO TPH code later in this series treat TPH as supported and expose it in
virtual config space, only for hardware enablement to fail with -EINVAL.

>  int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  			  unsigned int index, u16 tag);
>  int pcie_tph_get_cpu_st_ext(struct pci_dev *dev, enum tph_mem_type mem_t=
ype,
> @@ -33,6 +47,8 @@ int pcie_enable_tph(struct pci_dev *pdev, u8 mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>  #else
> +#define pcie_std_tph_supported(pdev) false
> +#define pcie_ext_tph_supported(pdev) false

[Severity: Medium]
Should pcie_std_tph_supported() and pcie_ext_tph_supported() be static
inline functions taking struct pci_dev *pdev instead of macros?

Because the !CONFIG_PCIE_TPH macros discard pdev without evaluating or
type-checking it, callers whose local pdev variable is only passed to
these helpers (such as vfio_tph_vcap_rewrite() later in this series)
trigger a -Wunused-variable warning and break the build under
CONFIG_WERROR=3Dy when CONFIG_PCIE_TPH is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D6
