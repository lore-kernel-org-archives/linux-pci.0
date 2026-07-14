Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1D3EB0F6
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056589; cv=none; b=NtA5qF+/T7HU2ecIaKwa84fM++Pk5YLM3VhgBY/HG5ro8VzoqG7OeX28X5UIq6p6wG4+hndTWQ0bEqL2urnUKj3mQ4+Js8cC/fxB0hFmP4rZUZVnC6ND0PQt/PxaPiYkl5tMySbZAKLI4agfaVKfu6/KqioEw91DuaBwRUvtG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056589; c=relaxed/simple;
	bh=eM0MSLDjU1TDXcCNiYRGkllA/rLMgSR7ZGl6PVIjU5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BmrcM8aDJL4xXvLVdMjNmbcRNJgKLYsS9EwkG2psL5NfB3l7y7qoM2NTQVKHAXaknQsRSpk2KycpRoKy5leQDD7fgCpVExk2DC1WRU0TsgECgS/cN+6VPagQaHeZ2Wb5XrT/hpEL2zTXvSY0gGaZ/TsA1OHARb4qZkJmKSB2VM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7ZfiFki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7ZfiFki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E381F000E9;
	Tue, 14 Jul 2026 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784056583;
	bh=77KMNyf4paOeQM4cEkMaa/LOJzkMTt8Iw4MLA+ppeP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7ZfiFkiyxa3/Kw205v5tcX1uivaBU54EJ4pXJ3YzpzyZgOw0yocSET7UfUnaMZ46
	 ZvVqTKX/h7mcX86m5ZEYVUMLRwiWB7cg8j7hVbSJZ5NeXdViN1eGZOJMJHwfvzUN5v
	 R74tZhYsqsK4O0V4fjjQZzhav1LY7iWtlRHjO2DK5WY6QDWVwQK2JMJ8SfsY2r8Ihc
	 ghl++OGc19Ma69XpkhDfyyysshRhRRSdz3za6NhOO5vCfjkWBo/vDF5sICNFJ6nOOS
	 vGY7BA9W4OLNMg14FJ4S5ldSfZXJksBAVTkZzh9+WidhK8wV9dyhgAoq6eaX4/8xEe
	 yi3dtrqq6HeFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] PCI/FLIT: Add trace event for flit errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714183950.1620016-5-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
 <20260714183950.1620016-5-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:16:22 +0000
Message-Id: <20260714191623.17E381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite loop in threaded IRQ handler due to missing check for PCI=
 device removal/error.
--

--- Patch [4]: [PATCH 4/5] PCI/FLIT: Add trace event for flit errors ---
commit e2a5453df78634ff77f29016af766d1994cda605
Author: Yazen Ghannam <yazen.ghannam@amd.com>

PCI/FLIT: Add trace event for flit errors

This commit emits a trace event for each erroneous flit logged by the Flit
Error Counter. It captures the counter control/status and both Error Log
registers to provide a structured record for userspace RAS tooling.

> diff --git a/drivers/pci/pcie/flit.c b/drivers/pci/pcie/flit.c
> index 12f2b6fbf1de0..83cf53f392913 100644
> --- a/drivers/pci/pcie/flit.c
> +++ b/drivers/pci/pcie/flit.c

[ ... ]

> @@ -84,6 +85,7 @@ static irqreturn_t flit_isr(int irq, void *context)
> =20
>  		pci_read_config_dword(pdev, flit + PCI_FLIT_ERR_LOG2, &err_log2);
>  		pci_info(pdev, HW_ERR "  Error Log1: 0x%08x Error Log2: 0x%08x\n", err=
_log1, err_log2);
> +		trace_flit_event(pci_name(pdev), cntr_ctrl, cntr_sta, err_log1, err_lo=
g2);
> =20
>  		pci_write_config_dword(pdev, flit + PCI_FLIT_ERR_LOG1, err_log1);
>  	} while (err_log1 & PCI_FLIT_ERR_LOG_MORE);

[Severity: High]
If the PCI device is hot-unplugged or the link goes down while flit_isr()
is executing, pci_read_config_dword() will fail and set err_log1 to all 1s
(0xFFFFFFFF).

Because 0xFFFFFFFF has all bits set, it will bypass any valid bit checks and
the loop condition (err_log1 & PCI_FLIT_ERR_LOG_MORE) will evaluate to true.

Could this trap the kernel thread in an infinite loop and flood the trace
buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714183950.1620=
016-1-yazen.ghannam@amd.com?part=3D4
