Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C9032B9B5;
	Mon,  3 Aug 2026 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796952; cv=none; b=W68vYIJk9c6aiN4lqILSAxlrDiffcqF764zJNBbGbWN6ftNQeDTINSEiiEg+TNpUlEVimgLOoTw+q3NUW+q4FhvUwmH0CI65q+5bJR/4x3TBvB6UbUEZ5v3XhJZTVVbnY9bq4v9fQudefzZ/burN8YTXtQ1eRUsN3aqpm/MCjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796952; c=relaxed/simple;
	bh=k+JXjFRXxdWYBpRs+Xg3DKRY7KexCqPjqxLgI8r1OGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G05/0hdP8QD76K6qZzdXh3bEFWqifROF3nwSC28k6faEW3AsBQ6QrxufKbjPlU9UrYymuzSIf58jm1u+MA6jrWRCtp6pZvfBxQq9VHdy4+t4skYKMX7baA4DLuTWeOJ1oHQjNCT2XR3TuuNZ1PEPTUIuShtxxnxMXRn+s5H0AHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiF+MruO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiF+MruO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CD81F000E9;
	Mon,  3 Aug 2026 22:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796950;
	bh=IXjPXXAfrLQ5B2n4vI7A35sNwCenq2IZVFohxsAffYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MiF+MruOqzAJE4tEhdS0TCGu2FlX/Md+1++AjhNZr7gmy/goL4t93GY7bciM86Xsp
	 jlUTBbOYQXJ95vh0KTfYwwzhCk+8V3zjEcPEeOvqBAPkPQgARIqmzC1ByIFG+dN9lD
	 cWm4wuWgnhxqfoxYwFEVyDgycXdQybAIqkOpIPYs8MX/p7xz6LmN9lmeEnIyV9caxf
	 Aw9zBCig6s0pZZqtq/hH+8ZPL/KCvCq7BkPgA5vshRo5Xx3w8VaDlAxtwZLzztvFEt
	 6zLn3aS0X9HFqPudTKKzy8VzEwOWUUPrbSxwfuToa/JXREci5f9mnGjD4BI7g9LjKz
	 YpEfBsHNNqsuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 01/14] cxl/ras: Fix cxl_rch_get_aer_info()
 out-of-bounds AER register read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-2-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:42:29 +0000
Message-Id: <20260803224230.85CD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cxl_dport_map_rch_aer() requests an MMIO region using the software=
-only size of struct aer_capability_regs, over-reserving memory beyond the =
physical capability.
--

--- Patch [1]: [PATCH v19 01/14] cxl/ras: Fix cxl_rch_get_aer_info() out-of=
-bounds AER register read ---
commit b208d5e7d4a18c48dd06f33bc3c5667e9a2c13dd
Author: Terry Bowman <terry.bowman@amd.com>

cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read
   =20
cxl_rch_get_aer_info() copies the RCH Downstream Port AER capability from
the RCRB MMIO block using a readl() loop bounded by sizeof(struct
aer_capability_regs). This struct is a software layout and its embedded
struct pcie_tlp_log is larger than the on-wire AER capability. As a
result the loop reads past the mapped AER register block.

> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b63884..8a3965edaa12c 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -58,13 +58,28 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dpor=
t)
>  static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>  				 struct aer_capability_regs *aer_regs)
>  {
> -	int read_cnt =3D sizeof(struct aer_capability_regs) / sizeof(u32);
> +	/*
> +	 * Bound the copy to the physically-defined AER registers (header
> +	 * through the 16-byte Header Log). struct aer_capability_regs is a
> +	 * software layout whose embedded struct pcie_tlp_log is larger than
> +	 * the on-wire AER capability; copying sizeof(*aer_regs) would
> +	 * over-read the RCRB-mapped MMIO block.
> +	 */
> +	int read_cnt =3D (PCI_ERR_HEADER_LOG + 16) / sizeof(u32);

[Severity: High]
This is a pre-existing issue, but since you are fixing the oversized read
here, should we also fix the initial mapping size in cxl_dport_map_rch_aer(=
)?

In drivers/cxl/core/ras_rch.c:cxl_dport_map_rch_aer():

	dport->regs.dport_aer =3D
		devm_cxl_iomap_block(host, aer_phys,
				     sizeof(struct aer_capability_regs));

This uses the same oversized software struct size to request the MMIO regio=
n.

If another CXL Extended Capability is densely packed immediately following =
the
AER block, won't any subsequent driver attempting to map it (e.g.,
cxl_dport_map_rcd_linkcap()) fail with a -EBUSY conflict and break device
initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D1
