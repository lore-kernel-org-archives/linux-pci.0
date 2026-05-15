Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3B38758B
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839263; cv=none; b=Nx8o5a7bgwIjXxIHNwWhY1ASDIdCunhtUxwsVGA/+pxqseEdIwD9ROWw1Z9s/qxQ+jymdjqps5Pc0LWKOhkQ9Kh7VvHOmqmFWl3HKiBeLdUi1DHIU8FybiniOo+pPxJ0grFxnDfAer4Mt9q8x4PPvBOki7Xb9Su4DjIrbuXXVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839263; c=relaxed/simple;
	bh=gzDUSPw0gfjFQqDB840Hw4vA1tS9ug6V5u70iBgP37I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k/Z4ODKdueI7spDpw4q9PcxtN08A5A4+Y/Kfg5lo09JjbKBbqVvUfFHGuoQaXMjOY87sK2G2Z9XNv8il1yfefIk6Fu9o3aTyuUsi0nuyBXTN6hIWAI5CjkNqgG/RnUuZW6SFSjg9K7OfZU7WJ7CSLdAS6/wKBSz56AmBuP4Zlus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS2mwY7z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS2mwY7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8D6C2BCB0;
	Fri, 15 May 2026 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778839263;
	bh=gzDUSPw0gfjFQqDB840Hw4vA1tS9ug6V5u70iBgP37I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LS2mwY7zFdI0OfT/3uPVQ6GxKccxMjODAoN32uiYUpP9slKA+pc1sx/RqOIRYQjBa
	 8bYoxQF/vSd+Xwcy38ijE17oS3YABqOyairw1gjU0BIUd9ulbkB/HyHBt4Pdj3vQ80
	 uOuAQXWOtH1CLn6AuUdgr8M0Hjzy+pYBIqwsVMyUUXCoC5bkEAh451aGhh4LfCwvvD
	 enUiOGjGlCXy6G+hT1yMvMZrow7mJaI5nufe1bQoLIEEfFOLvbEig3dl1CG2aTPZ4Q
	 XSoFZqCewXYXzOApSOtHNHb4050zh4FiiXoym73bmYpLlQSMqfEygF1s+zKczWa5A9
	 CFzdoAV6LzFXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/5] PCI/TPH: Fix pcie_tph_get_st_table_loc() field
 extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515094040.38496-2-fengchengwen@huawei.com>
References: <20260515094040.38496-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 10:01:02 +0000
Message-Id: <20260515100103.0C8D6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `pdev->tph_cap` validation leads to out-of-bounds configur=
ation space reads and bogus capability reporting.
- [High] Data race on the `PCI_TPH_CTRL` register during concurrent ST entr=
y updates.
--

commit 889112a3f9590eff0a1e2b0c7620742a7d6a8314
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction

This commit fixes ST table location detection by replacing an incorrect
FIELD_GET() usage with a bitwise AND in pcie_tph_get_st_table_loc(). It
also removes the now-redundant FIELD_PREP() conversions in the callers.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d951..877cf556242b4 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -170,7 +170,7 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> =20
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);

This problem wasn't introduced by this patch, but if a device doesn't
support TPH and pdev->tph_cap is 0, will this read from the standard PCI
Command and Status register at offset 0x04 instead?

Bits 9 and 10 of the Command register overlap exactly with
PCI_TPH_CAP_LOC_MASK (0x0600). If those bits are set, this could incorrectly
return PCI_TPH_LOC_CAP or PCI_TPH_LOC_MSIX, leading to bogus ST table size
extractions in pcie_tph_get_st_table_size().

Should this check if pdev->tph_cap is valid before reading, and return
PCI_TPH_LOC_NONE otherwise?

> -	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
> +	return reg & PCI_TPH_CAP_LOC_MASK;
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);

[ ... ]

> @@ -316,8 +313,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsig=
ned int index, u16 tag)
>  	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);

This wasn't introduced by this patch, but is there a potential data race he=
re
if multiple threads configure MSI-X vectors concurrently?

When set_ctrl_reg_req_en() is called, it performs an unlocked
read-modify-write on the PCI_TPH_CTRL register:

static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
{
        u32 reg;
        pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
        reg &=3D ~PCI_TPH_CTRL_REQ_EN_MASK;
        reg |=3D FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, req_type);
        pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
}

Could this cause unpredictable toggling of the device-wide TPH state while
tags are actively being written? Would it be safer to serialize these
modifications using a lock like pdev->pcie_cap_lock?

>  	loc =3D pcie_tph_get_st_table_loc(pdev);
> -	/* Convert loc to match with PCI_TPH_LOC_* */
> -	loc =3D FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
> =20
>  	switch (loc) {
>  	case PCI_TPH_LOC_MSIX:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515094040.3849=
6-1-fengchengwen@huawei.com?part=3D1
