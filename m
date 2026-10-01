Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600A83BBA0E;
	Thu,  1 Oct 2026 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849544; cv=none; b=QGNnYiOaDZ59685Eph0j9bIyGVrUz2wBoVwmQbc0U4iiyOmCh15KESW7HFxA2DP8UJVZfVlhyQ9KpVTnfUML0ph4DKgL8MSmwVmfmSYMo8fVYbmCiWD1Ce+x6oqYwwGrk4obrjdfbSd7LTSOLTEoou0/cRwQvm3l2eG6foYLfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849544; c=relaxed/simple;
	bh=Bwdep+0/J9TUqvbcNA4WBWKBxuXxhAwBpPO3gLVk+rM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nz6QgqmnMcFkBljzUhgqvF/zDnyFpY1sHlRBdyMxPPc7l0b5skCXVfxu7vUevR0ohsYhmMkyOrPbC7YRh5r7VW1RUYCVVxOD222TjVWB8UnUqtiw3H0vmwKBhNys7+6PnXe83nj1Gk9IZBIsHR0tBP0A+ScPXhsifxfh+RintYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXdhki6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXdhki6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841621F000FF;
	Thu,  1 Oct 2026 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849538;
	bh=g88N/KUiM752d0hLIkpP+5SZo9eO9CalihwMae892ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dXdhki6/CicLNM6kL5bG4ezokzgf0FS4isgkZHPuxNfQsFWMWOjdKjrxZvjUdr/WZ
	 8Xhjrevy+jsGOd6bEmai/sa/JGBweTSuKzvgT2btBzkBkMW0BgAbgl9dvdH3UDo878
	 y1q1Qg8ywT4PO1Y+aMRxgo7vk4SHdTsVto0j33zefGydIaHYPZQYAH5LcZM6RLsZvl
	 ss4WPfKb9jT+G8E12Os6gUFYziJTKaNfuPNRO5B0KDEQejIj2ZuyQxJ3auB0vA05l1
	 zmn6YPhIrpopB/gOP7SczzUe757VhyLtv5F+ljgKiQSfTg/HcqWo6pd/x766BIDrDw
	 +HxO/HpTcPKFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 10/16] cxl: Cache endpoint HDM state during PCI
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-11-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:12:18 +0000
Message-Id: <20261001101218.841621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cxl: Misplaced error logging suppresses PCI_COMMAND restore fail=
ure logs
--

commit 62840404e5420d7cde318d8a3f21873bf84154cf
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Cache endpoint HDM state during PCI enumeration

This commit introduces a cache for CXL HDM state during PCI enumeration
to support driver-independent resets. It temporarily modifies PCI_COMMAND
to access MMIO, reads the cache state, and then restores the PCI_COMMAND
register.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 8d2fbc49a06fb..c3f53c1b93fd8 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c

[ ... ]

> +static struct cxl_hdm_info *cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +						  struct cxl_register_map *map,
> +						  int dvsec)
> +{

[ ... ]

> +	info =3D __cxl_pci_hdm_read_info(pdev, map, dvsec);
> +	rc =3D pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (!rc)
> +		return info;
> +
> +	if (IS_ERR(info)) {
> +		pci_err(pdev,
> +			"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +			pcibios_err_to_errno(rc));
> +		return info;
> +	}
> +
> +	kfree(info);
> +	return ERR_PTR(pcibios_err_to_errno(rc));
> +}

[Severity: Medium]
Is the error logging for the PCI_COMMAND restore correctly scoped here?

If __cxl_pci_hdm_read_info() succeeds (info is a valid pointer) but the
subsequent pci_write_config_word() to restore PCI_COMMAND fails, this skips
the if (IS_ERR(info)) block entirely.

As a result, it correctly frees info and returns an error pointer, but
silently suppresses the pci_err() log about the restore failure. Conversely,
if both the read and the restore fail, it logs the restore failure but
returns the read failure.=20

Does this code unintentionally hide the restore failure logs when the cache
read is successful?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D10
