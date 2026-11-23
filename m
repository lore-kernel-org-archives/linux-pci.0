Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402112;
	b=o0fzRJGxMNTrb4eKEkovzk/RhtHVpuKT8oiAY5+9Z1Oetg7N7r8dyJIz9fZiOQFObx1E
	 SVLR3BcxwPzuj0rJr9RQSAs5WKYko+3H9CupPNoAmt32EKDtABXbFw55bXIrCBEKi5XaC
	 WUz2Foag2BYwRcgIdZF26b1fUrNXamIJLvrukcFOkZLRj5jlGHWTC6aUOBSymR3CLZx2i
	 mOUAt6PQFLypSr33StfnGiyCG8XZ0izurM5b8guQVbx9PDQPmtqhKFIcQz8OUXliUaY+k
	 Ye4NMKkrt35hHJkaH2t8Flzx9mKXqSqEDm3A9F23PIuB/vlz+aWwfXLFEvm2st6QYJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wGUExjr0dCj0IssSnl/1LHSjaWBQaUlt2jLUhwCpASA=;
	b=p+/cwBEV44mtM3QUNLQ4CM8pPIytzFgWJn03dWQfRRP18/ebc6F99dMWrJ9pH5om94eQ
	 uLR0Dj9KTcR64uTEWdbGnG2cwZKl+fa1/g+mPPzd00hyvYT7c935h3vUAyEZLKjAc4Fxl
	 +JWP6YzzxvJUCpwZ+U3qhn23e/5tGE+ORqfo3jzI+MsHAxB8pK2hs58himtpxjDqBKfIU
	 QvV6avfUREAcxHiH8BGN++ZtqrS219uJuyNadyxpjg1WyzGAyMk8PPHyodJEMJKIxtvdK
	 P8JtzEZbFlYteTPsJ5RaAfwFSjT1njFxqUxpnRrWiicKxgjKG4AfGMokyrpz5Ikig9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcK3hoO1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35998606A31A;
	Mon, 23 Nov 2026 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jcK3hoO1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F9F1F000CF;
	Mon, 23 Nov 2026 02:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402112;
	bh=wGUExjr0dCj0IssSnl/1LHSjaWBQaUlt2jLUhwCpASA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jcK3hoO1YTgPREmhBbGZr4MUQZRI49w1IZJ/LcJ8P5ui9x6n7He/g/MqEsUQsqxTX
	 HNuEk33GSQIA8SIe40NhI5emZmUSkq6TCYnb5nkK3lArmUrt2FyNKobpVmXDW3VQuz
	 OT4djmqxr5FT3X7BxxDhkUSbfgdx6t7ESmO7AFqPxV1uJFUsjaO6DwQBnbkLd4GpR2
	 o/e3T+5T6F/edF8D4iRs3nMvNajy1atpKqidlEIGrtQql417ip3IFo0lfkDBK4NV3i
	 zHFUXZqrARtXp/1R/DWiqw6tbggZWIlTmyn2GaZ6N076NG0hrmyiRcMfsnA8dYoOdy
	 NzOEhD6v9bRMg==
Message-ID: <sashiko-outbox-228564@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 07/13] PCI/TPH: Add pcie_tph_set_st_entries() batch
 ST entry programming helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261123023628.7728-8-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
 <20261123023628.7728-8-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 02:48:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI/TPH: pcie_tph_set_st_entries() re-enables TPH on error
--

commit 3ea3b71b1fd03bc517b1fa817329d811df87ed27
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add pcie_tph_set_st_entries() batch ST entry programming helper

This commit adds pcie_tph_set_st_entries() to program a contiguous range
of Steering Tag table entries in a batch, and reimplements
pcie_tph_set_st_entry() as a wrapper around it.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 51a065d83104b..be44b27bd1ce4 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -311,21 +311,19 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum =
tph_mem_type mem_type,

[ ... ]

> @@ -344,29 +345,47 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, uns=
igned int index, u16 tag)
>  	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
> =20
>  	loc =3D pcie_tph_get_st_table_loc(pdev);
> -
> -	switch (loc) {
> -	case PCI_TPH_LOC_MSIX:
> -		err =3D pci_msix_write_tph_tag(pdev, index, tag);
> -		break;
> -	case PCI_TPH_LOC_CAP:
> -		err =3D write_tag_to_st_table(pdev, index, tag);
> -		break;
> -	default:
> -		err =3D -EINVAL;
> -	}
> -
> -	if (err) {
> -		pcie_disable_tph(pdev);
> -		return err;
> +	for (i =3D 0; i < count; i++) {
> +		switch (loc) {
> +		case PCI_TPH_LOC_MSIX:
> +			err =3D pci_msix_write_tph_tag(pdev, start + i, tags[i]);
> +			break;
> +		case PCI_TPH_LOC_CAP:
> +			err =3D write_tag_to_st_table(pdev, start + i, tags[i]);
> +			break;
> +		default:
> +			err =3D -EINVAL;
> +		}
> +		if (err !=3D 0) {
> +			pci_err(pdev, "failed to set steering tag: %s table, index=3D%u, tags=
=3D%u, ret=3D%d\n",
> +				(loc =3D=3D PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST",
> +				start + i, tags[i], err);
> +			set_ctrl_reg_req_en(pdev, pdev->tph_req_type);
> +			return i > 0 ? i : (err > 0 ? -EINVAL : err);
> +		}
>  	}

[Severity: Medium]
Should the error path here call pcie_disable_tph(pdev) instead of
re-enabling TPH with set_ctrl_reg_req_en()?

Before this change, pcie_tph_set_st_entry() called pcie_disable_tph(pdev)
on failure, clearing PCI_TPH_CTRL and pdev->tph_enabled.
pci_msix_write_tph_tag() relies on the caller to disable TPH when it
returns -EIO on an offline PCIe channel:

drivers/pci/msi/msi.c:pci_msix_write_tph_tag() {
    ...
	/*
	 * The tag update below is a write to the MSI-X Table followed by a
	 * flush read, neither of which can be completed while the Link is
	 * down. Check as late as possible, as the Link can go down at any
	 * point. Let the caller disable TPH.
	 */
	if (pci_channel_offline(pdev))
		return -EIO;
    ...
}

Re-enabling TPH on failure leaves hardware TPH active with an unprogrammed
or partially programmed ST table, and callers such as bnxt_request_irq()
that loop over vectors without checking pcie_tph_set_st_entry()'s return
value will keep issuing tag writes instead of short-circuiting on
!pdev->tph_enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123023628.7728=
-1-fengchengwen@huawei.com?part=3D7
