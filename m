Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88CC34CFA7;
	Mon,  3 Aug 2026 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796165; cv=none; b=KtZDax0jwJ4Sdvdr/q3EHBgTS3PRYXG4U7Y3QDwBrYDVF6+05om18Cq49x0bwkpaWebt0unXqKA94qY6Y/y7jqG65XSJsBVadHl1zMCbPW03Yb9OeDBSQVU9pTwIeDs91J0GEbMPUobK+s/+BtEBexrNPDLX0xfhXqZakS0C7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796165; c=relaxed/simple;
	bh=yzIKyjYnXgHQLBvU6GOHsGa57/bq6LYxCXOVMfscdn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJWMyXIO8tarrnj3iOR9zU16Q+BAouPpXcXoa5LvEORTRw6UrzHO2n5jir7aTHxYSxxhS6nAbjlImbXsBeWkRB5aEashxf1rcn+MBEL8bBzIoAhu3/ER5VXyo0EBo6q4pMRpDfQLwS+Tt8YmyYjoSgZHW/B1KGZZOL01SSIPKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0ApnxBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0ApnxBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517B11F00A3A;
	Mon,  3 Aug 2026 22:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796163;
	bh=dRZZxuQVZPXBuCL2Rx/gbX3lCTE3e5pO+TVFJlX53x4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0ApnxBOjcDlFxQEwmBIRnTkng/397G/1neoLrkP/LQ7Cjv/Npj4qWMT1cqvIDcwx
	 YQ9doO5sNfOB66hn1y4Ufvs5zFFb7ALU2JVo7SN7hvKOhdEFBMKA0yWAmMnNPJ0la9
	 i91U3B1Lbz4nkbNrYbF2CPU/3oms9F+leE7gxdkJDTQA7caFGdNGm1XZDGs3EcHUX/
	 Fz5Mk4Al7hezotGi12h1P55izdCnqCR+M9TWpHrSgOX3F0f9fzsYdn9UfNP68AMwGp
	 NhbBSfL+NM1NMotBLlk2tIz4xP8whvpvynHW8bzz024qKndDWzEST4ZbJzJ7Q73JqI
	 ePsIuKlYZJAtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 08/14] cxl/ras: Handle RCH correctable and
 uncorrectable errors in one pass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260803221810.3685703-9-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:29:22 +0000
Message-Id: <20260803222923.517B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incorrect inline severity calculation for uncorrectable errors fai=
ls to apply the uncorrectable error mask, potentially escalating unmasked n=
on-fatal errors to AER_FATAL.
--

--- Patch [8]: [PATCH v19 08/14] cxl/ras: Handle RCH correctable and uncorr=
ectable errors in one pass ---
commit 57f34ecdf069076e73ab0e60927403af518bdfc9
Author: Terry Bowman <terry.bowman@amd.com>

cxl/ras: Handle RCH correctable and uncorrectable errors in one pass

This commit modifies the handling of RCH correctable and uncorrectable erro=
rs
to process both in a single pass so co-logged events are not lost. It remov=
es
the cxl_rch_get_aer_severity helper and decodes the uncorrectable severity
inline.

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c

[ ... ]

> @@ -127,12 +106,21 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>  		return;
> =20
> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> -		return;
> +	/*
> +	 * Handle correctable and uncorrectable errors independently; both
> +	 * may be set in the same pass and cxl_rch_get_aer_info() has already
> +	 * cleared both status registers.
> +	 */
> +	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
> +		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
> +		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
> +	}
> +
> +	if (aer_regs.uncor_status & ~aer_regs.uncor_mask) {
> +		int severity =3D (aer_regs.uncor_status & aer_regs.uncor_severity) ?
> +			       AER_FATAL : AER_NONFATAL;

[Severity: High]
Does this inline calculation miss the uncorrectable error mask?=20

In the previous implementation, the severity check masked uncor_status:

    u32 uncor_status =3D aer_regs->uncor_status & ~aer_regs->uncor_mask;
    if (uncor_status) {
        *severity =3D (uncor_status & aer_regs->uncor_severity) ?
                     AER_FATAL : AER_NONFATAL;

Without applying ~aer_regs.uncor_mask here in the new inline code, if hardw=
are
simultaneously logs a masked fatal error and an unmasked non-fatal error, t=
he
masked fatal bit will be evaluated. Could this wrongly escalate the severity
to AER_FATAL?

> =20
> -	pci_print_aer(pdev, severity, &aer_regs);
> -	if (severity =3D=3D AER_CORRECTABLE)
> -		cxl_handle_cor_ras(&pdev->dev, to_ras_base(port, dport));
> -	else
> +		pci_print_aer(pdev, severity, &aer_regs);
>  		cxl_do_recovery(pdev, dport->port, dport);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D8
