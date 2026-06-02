Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4F61A680A;
	Tue,  2 Jun 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411870; cv=none; b=J56+LDJaG6SuDg+JVXKFbXUzjkQV96XunJl9XqVWm9MWYrfXGfclhJCLI0/gnP28pXjXIWKMkbANPcCrxsL/3Bd+squwTqAkFxjhGquJAacxJFvOkC3ho516mGB1pY/MF9a5RlwYpEiOgrG57wgJKTgmfCif2tR5pQoWfKba7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411870; c=relaxed/simple;
	bh=SLwWttDn3k5FQZ2q5Nj0YUZCB9ZepPeV/LKiK8n81Hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GVOjqVIhWJZiFGredrJnUZs28LUHU0ph4ROr9FyBa48RYJrPdxutswZVqqvbw9wioFKXzPQPdwIWSbGvfmZ8OwGje51GYYFrhocYSzcW1rvRF8ubdgwAX8f5JQVYOHK1bcirXyy+KWgjO/Z7tpygFg3931BnuieD3Scm/L92yvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc9Zy7+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc9Zy7+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DBC1F00893;
	Tue,  2 Jun 2026 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411868;
	bh=iq7eFTFcaEKeTlx//+qKopKgIn0aGGgXACZxQfs4Sss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oc9Zy7+4GwTOvX5c5dEfM/nL0jSzfMlfISTNjvKS0zsuOHf5CCEpw4Sllkr6wWqIJ
	 wTJeW3Zv2iEPDx5Xllkye1l9ToHCYcSTBKAPsv9W8veKD/px++6YlKIKxhxbGDSYhn
	 cNh12liGNkUi1dnpOSyd3B9vXQsBwJQLA9HkFzOA6wB77yWr4nskmu4EDtoIe3m5/c
	 zebXOYit4TKEFVqq3K6e5g5HxQ00Sh1z0dk+IMkHDUuzgnvT/feaFo4eavpZu2lqqR
	 P8pOgY9RbiqrOfe3uRp8K45BWhCjgrVkfa9b8p+ap9oXgRuQndsdLGSCkVEGKsR5pv
	 RZ8wUpOwoTkjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 05/10] PCI/TPH: Refactor pcie_tph_get_cpu_st & add
 explicit variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260602144023.25254-6-fengchengwen@huawei.com>
References: <20260602144023.25254-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:51:08 +0000
Message-Id: <20260602145108.B3DBC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `pcie_tph_get_cpu_st_explicit()` lacks a base TPH capability che=
ck, allowing userspace to query standard Steering Tags for devices that do =
not support TPH.
--

commit 43e15224048bcf8d87137edee77bb1e0fa7f45ae
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Refactor pcie_tph_get_cpu_st & add explicit variant

This commit refactors pcie_tph_get_cpu_st() to extract core logic into a
static helper. It also adds an exported pcie_tph_get_cpu_st_explicit()=20
function with an extended parameter for manual requester selection.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> +int pcie_tph_get_cpu_st_explicit(struct pci_dev *pdev,
> +				 enum tph_mem_type mem_type,
> +				 bool extended, unsigned int cpu, u16 *tag)
> +{
> +	u8 req_type =3D extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
> +
> +	if (extended && !pdev->tph_ext_requester)
> +		return -EINVAL;
> +
> +	return get_cpu_st(pdev, mem_type, req_type, cpu, tag);

[Severity: Medium]
Should there be a base TPH capability check here when extended is false?

If extended is false but the device lacks base TPH support (for example, if
pdev->tph_cap is zero), this bypasses capability validation and proceeds
to call get_cpu_st().=20

When called via the VFIO_DEVICE_FEATURE_TPH_CPU_ST ioctl for a device lacki=
ng
TPH, get_cpu_st() will successfully query the root port's ACPI DSM and retu=
rn
a valid 8-bit steering tag.=20

Does this expose system topology tags to userspace for unsupported devices
and mislead callers about device capabilities, creating an inconsistency=20
compared to how extended requests correctly return -EINVAL?

> +}
> +EXPORT_SYMBOL(pcie_tph_get_cpu_st_explicit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602144023.2525=
4-1-fengchengwen@huawei.com?part=3D5
