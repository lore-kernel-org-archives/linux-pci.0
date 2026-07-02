Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E3481220;
	Thu,  2 Jul 2026 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996838; cv=none; b=LvczYBDTkUiQ02hMmb9BRENvTHAKXVSM6ANdm9fRw7xz4TlpALyDZwj0/lgG2nwnAG5aIGJLBPH0pcAmNWQn6TtoHxKrPdSbzqzR2JrL2hmKyEee3ibkRj3rBYBdqjCR2egHp/FnxWaobT1j9CR7KuyDcFrxIEWANrb293yAf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996838; c=relaxed/simple;
	bh=qE4ph1tcbs01hmtAafMXMtEVq3ADFh4Vuo0oH4dqzlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udvaptNHGmivCsjcErtSR3FNVeQmUlDGjhu7AUTwJRktMiJxHHq2EC7iqucTYFzGeb9Dj1TKvtdkVYr2/1IiI8SOgPxr2NK4XnxAPqF1lK2An9meQeqSoPwRVMie/KMcfdMpAHxmNA4K2ejVYo6ouVJ+HXFlBCgwQe7p/2Esa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZg0dFP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZg0dFP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EEB1F000E9;
	Thu,  2 Jul 2026 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996837;
	bh=H5V00x2TkoYnTxCaFhzjlkNGX6cuCgvnrkUFwdd39a4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oZg0dFP+FQ3zR3ATXq9VFuxenk1yuvQ+SU0Lw12XyEMbA7UQBpAsHyNJ2UeoGJUWx
	 fri+9N+fvHdgN5vbYfPLsmb0iyzxBadD0x5uf2IpHMVbeKoN7eZw1l/bqzGpALMSEM
	 bX7YUHzLob8doFCz9Nlv4N0r8VE4BYFh5sWLr6FIpyh3ko2NkUGrJFjZEiX9Mi9i4N
	 Z8CEt6uWEUhlfBriakFVkxdhlU4fzpTjGiQUo1+z+naiZuI0WNVrWOuZ8XjyiW3Bmj
	 jYmsqYHE/C7vYKWjG6cIStT+4mr5iXe7RoJgpnp2fvXPTJBN0ASTijeRCKki7qWrL5
	 rqgxCb3ayZ32A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 07/18] PCI/TPH: Add pcie_tph_supported() helper to
 check TPH capability attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-8-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-8-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:53:57 +0000
Message-Id: <20260702125357.63EEB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pcie_tph_supported() does not check the system-wide pci_tph_disa=
bled flag, leading to falsely reporting TPH support when it has been explic=
itly disabled by the administrator.
--

commit 089d399dcdf1ae5d6be4d557f772bf15c0d7d461
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Add pcie_tph_supported() helper to check TPH capability attributes

Add new helper pcie_tph_supported() to check if a device has a valid TPH
capability or hardware Extended TPH support. This helper is intended for
follow-up VFIO TPH virtualization patches to uniformly query basic TPH
existence and Extended TPH capability.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index ea777cc33ae61..c080cf5401a31 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c

[ ... ]

> @@ -596,3 +596,22 @@ void pci_tph_init(struct pci_dev *pdev)
>  	save_size =3D sizeof(u32) + num_entries * sizeof(u16);
>  	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
>  }
> +
> +/**
> + * pcie_tph_supported - Check TPH capability attribute
> + * @pdev: PCI device to query
> + * @want_ext: false - check TPH cap exists; true - check EXT_TPH support
> + *
> + * Return: true on matched condition, false otherwise
> + */
> +bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
> +{
> +	if (!pdev->tph_cap)
> +		return false;

[Severity: Medium]
Does this introduce a regression by failing to check the system-wide
pci_tph_disabled flag?

Since pci_tph_disabled is static to drivers/pci/tph.c, external callers like
VFIO have no other way to know if TPH has been administratively disabled. If
the host is booted with the 'notph' kernel parameter, this will still return
true.

If this incorrectly advertises the TPH capability to a guest VM via VFIO,
could it lead to an inconsistent state when the guest attempts to configure=
 it,
since other functions honor the pci_tph_disabled flag?

> +
> +	if (!want_ext)
> +		return true;
> +
> +	return pdev->tph_ext_support;
> +}
> +EXPORT_SYMBOL(pcie_tph_supported);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D7
