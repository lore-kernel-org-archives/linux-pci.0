Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C03033DE
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521481; cv=none; b=Mk3vIcW2BIMC+hlvCWI8xsDdBVNkv9ZBlCg8V1yxN8TG7OF1glE++uNgZwSNIwfIXmmYZGPuCAuRqrhX0pVCNSliF2Bhhl+0AShr6KGcl8HUyZlEcr+oE9pLDn6ujKS4BGG+KwtuvIs6FQ+NMJ+EOc/+X7e7lBXdaoRgOVOl8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521481; c=relaxed/simple;
	bh=ryKeeYNqWzd3TG6eSYgMN9cr23biI4zNGhFk9MHQYts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mdw9dk99XVwH5KmDI48i4AQhAYMogp+tZ8pU6NrtwVLHSjXlJMyhB4i1BMFs0yQzHyJdJRlq1ANH44uQDbUxKjdG/Fu6NqHm2vtWNhnri+KGJ51OQKMWqINV6oqZrBaLaz1Te1hNGiw4a4imTNPX4qGjr6qVoj8bhvPSt6jjftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUAnzQCn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUAnzQCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC52E1F000E9;
	Wed,  8 Jul 2026 14:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521479;
	bh=0Z7UlLWutAXYFRu0qm7PFsAiMJV/mmRDlyn61S3rgBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUAnzQCn7COLTkB+WL7CN5ylKYJ+0MwEZw+orNnowm+U2hUB/+68gvO9ckFCLgjst
	 GtzoZz72fQ/X9YQ0mlDcmoMsXJG1T0FdhxOFHVhM0eEswW73OdSsH5gvksN6pEkn6p
	 R2Gslg6s+eM4xH9b9lsQSdrb3SgZHDucU05XTV68IPqJVxq1LT7eC3iyWULMTqIIdP
	 YzCrD78lCN8zJu+OMlEz0D+/BVDXAy7vev7XmHreHQ61VJMvsGx1XC9/mytuOuiyry
	 CsSCy4h3iqqp+2auLX3UIHS86q0ld0zFVaquLOTN9+tZ2Z0E3WEVxTyCLT4SrN/4Ze
	 Rts3rY4+5H75w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] PCI/ASPM: Improve the kernel-doc for
 pci_{enable,disable}_link_state*() APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708-pci-aspm-fix-v3-4-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
 <20260708-pci-aspm-fix-v3-4-6bd72451746e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:37:59 +0000
Message-Id: <20260708143759.BC52E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The kernel-doc for pci_enable_link_state_locked() incorrectly advi=
ses callers to use an incompatible API, which can lead to a recursive read =
lock deadlock.
- [Medium] The commit message claims to fix the kernel-doc for `pci_disable=
_link_state()`, but no such change is included in the patch.
--

--- Patch [4]: [PATCH v3 4/8] PCI/ASPM: Improve the kernel-doc for pci_{ena=
ble,disable}_link_state*() APIs ---
commit 544fcb510ac42577bcfc280750b6446d3bc52764
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI/ASPM: Improve the kernel-doc for pci_{enable,disable}_link_state*() APIs

This commit updates the kernel-doc comments for the PCI ASPM link state
management functions. It standardizes the format for the enable APIs and
adds missing documentation for the locked disable API.

> Add kernel-doc for pci_disable_link_state_locked() API and fix the
> kernel-doc for pci_disable_link_state() API.

[Severity: Medium]
Is the commit message accurate about fixing the kernel-doc for
pci_disable_link_state()?

Looking at the diff, it does not appear that pci_disable_link_state() was
modified in this patch, and its return format seems to remain as "Return: 0
or a negative errno" instead of the standard format applied to the other
functions.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 6d6862fd2ebb7..5e7e199c78d26 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -1574,19 +1588,22 @@ int pci_enable_link_state(struct pci_dev *pdev, i=
nt state)
>  EXPORT_SYMBOL(pci_enable_link_state);
> =20
>  /**
> - * pci_enable_link_state_locked - Clear and set the default device link =
state
> - * so that the link may be allowed to enter the specified states. Note t=
hat if
> - * the BIOS didn't grant ASPM control to the OS, this does nothing becau=
se we
> - * can't touch the LNKCTL register. Also note that this does not enable =
states
> - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + * pci_enable_link_state_locked - Enable device's link state
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + *
> + * Enable device's link state, so the link will enter the specified stat=
es.
> + * Note that if the BIOS didn't grant ASPM control to the OS, this does
> + * nothing because we can't touch the LNKCTL register. Also note that th=
is
> + * does not enable states disabled by pci_disable_link_state(). Use
> + * pci_force_enable_link_state() for that.

[Severity: High]
Does suggesting pci_force_enable_link_state() here introduce a deadlock ris=
k?

The context for this function requires the caller to hold the pci_bus_sem
read lock. However, pci_force_enable_link_state() is an unlocked API that
internally calls down_read(&pci_bus_sem).

If a developer follows this documentation and replaces
pci_enable_link_state_locked() with pci_force_enable_link_state() while
holding pci_bus_sem, could this cause a recursive read lock deadlock if a
writer is queued in between the two acquisitions?

>  *
>  * Note: The device will be transitioned to D0 state if the PCI-PM L1 Sub=
states
>  * are getting enabled.
>  *
> - * @pdev: PCI device
> - * @state: Mask of ASPM link states to enable
> - *
>  * Context: Caller holds pci_bus_sem read lock.
> + *
> + * Return: 0 on success, a negative errno otherwise.
>  */
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-pci-aspm-f=
ix-v3-0-6bd72451746e@kernel.org?part=3D4
