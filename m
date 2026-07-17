Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9C43F08A;
	Fri, 17 Jul 2026 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328187; cv=none; b=Bd10vZEo7JvmTn4T4UmvXz8aM14hSDcA/qIh+Zoy/n/apLY58Zpk5JSg71a29vnoiIuMK8iO0XrxJLU88OVMBsaBUjpefjV6xGi0X1xDRTxDbtZjgrQbZ4a+OJf58n3FyRY/6rKwD0NLd/H6aOoDMuYSpUyKFWjaSXKABrjffj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328187; c=relaxed/simple;
	bh=gzA6Nz87+KpQB9JpmQNImkmKNmU55kuWv2/6j5OPkxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FAMVtXOVMRnsucVFiFcornQ67xOi19n3VJPCqGDzCOGtBtaceNCHJbdaHHZjwR+GNZMs+cfVGG1K/Pw+86RbnEkUVvMZ5dKiTVO3qeDWoxB/p+YppiSYgBeWP3D+H2i+2JPDQDXFhCZu0xlVbVrYHoO9wEaALULi388uFhK0GaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT20Tw8X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT20Tw8X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEE61F000E9;
	Fri, 17 Jul 2026 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328185;
	bh=oT0R4YF6S5jMBE7cPOn63KOHWRjQeyGr73qJiW2RDaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RT20Tw8XzBcJ0fm1XnkuqxXGK8zzJUT3jUm99HycTaL5NEHBYiRxSP6+BejHV/BBS
	 ezdXhaugqxm8vSyNSWbeOj7njAmeLou0bKF9PxRRv/r8HwlbkmURNz9QxB3RaJ+fTI
	 kCBAmAYASjTVWdOpzsghb+fNyw3MvtEYeFAeXprAGscAn7HiNHuQG9qBCZEOCZ96C3
	 NfWzr0JzKmcHeETBDN4tm7fOCK1ASXPCnww/dwQ5Y4CHGj4tzXgcvUr25MBD8NLM9+
	 DhrrGR0nFRS4VhK2rA/rtQPDgR8j2BFAAAm+2br7rMeqdEU7C0IfwxKnl2y/5UQ/x4
	 RmOPeN87FwBpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-2-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:43:04 +0000
Message-Id: <20260717224305.3EEE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_rch_get_aer_info() uses sizeof(struct aer_capability_regs) to =
perform a linear MMIO read block copy, but the struct contains software-def=
ined fields that break physical hardware layout parity, causing out-of-boun=
ds MMIO reads and a stack data leak.
- [Medium] Correctable errors are silently dropped and permanently lost if =
uncorrectable errors are simultaneously present.
--

--- Patch [1]: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wr=
ong severity register ---
commit 900d8b615c2219573e44e775aca2f70550afbe9a
Author: Terry Bowman <terry.bowman@amd.com>
cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register

This commit fixes the AER severity classification for RCH Downstream
Port uncorrectable errors by correctly checking the unmasked uncor_status
against uncor_severity.

Cc: stable@vger.kernel.org

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b63884..44b335d560708 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -80,7 +80,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capabil=
ity_regs *aer_regs,
>  				     int *severity)
>  {
>  	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +		if ((aer_regs->uncor_status & ~aer_regs->uncor_mask) &
> +		    aer_regs->uncor_severity)
>  			*severity =3D AER_FATAL;
>  		else
>  			*severity =3D AER_NONFATAL;

[Severity: Medium]
This isn't a bug introduced by this patch, but does this logic permanently
lose correctable errors if both types are logged simultaneously?

Looking at cxl_rch_get_aer_info(), it reads the entire AER capability and
clears both error types in hardware:

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info() {
    ...
    writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
    writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
    ...
}

Then here in cxl_rch_get_aer_severity(), it evaluates the uncorrectable
error, assigns the severity, and returns early without checking for
correctable errors:

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_severity() {
    if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
        ...
        return true;
    }
    ...
}

Returning true immediately bypasses the correctable error check, preventing
cxl_handle_cor_ras() from being called on the same pass.

[Severity: High]
This is a pre-existing issue, but do the MMIO reads in the related
cxl_rch_get_aer_info() perform out-of-bounds hardware access?

drivers/cxl/core/ras_rch.c:cxl_rch_get_aer_info() {
    int read_cnt =3D sizeof(struct aer_capability_regs) / sizeof(u32);
    ...
    for (n =3D 0; n < read_cnt; n++)
        aer_regs_buf[n] =3D readl(aer_base + n * sizeof(u32));
}

Since struct aer_capability_regs includes struct pcie_tlp_log, recent
additions to struct pcie_tlp_log (such as header_len and flit) increase
the size of the software struct well beyond the standard physical AER
capability size.

Would this loop copy unmapped PCIe config space (typically returning
0xFFFFFFFF) into software fields like header_len, leading
pcie_print_tlp_log() to later loop over an inflated log->header_len value
and trigger an out-of-bounds read on the kernel stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D1
