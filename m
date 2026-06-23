Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBD30D3E7;
	Tue, 23 Jun 2026 05:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191782; cv=none; b=FhD319rtj7DXtH3lA91dZh1OnnVDSZPgBA42lkhWcGvfEz0XRAcp/G/al+XsjY6xCnVMb//v/rZAFXibvnSujr7wkEK68qY57N/BmSFMMBY7xbsgvgbc3zKTWrMGo+deL+9dAU3dP9FQ+ZIRmF6wcmiXB4B0HSHB14ropGpSq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191782; c=relaxed/simple;
	bh=19h73++45BIrgajM6KDs1ITNwy3lqIbe5Yz2+UVpPYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vn50iockVPNRIeAkFu/y9doBJUXejAlG3mh/MmLQmTAkuNrx2T6643k0IsDJKxkpMXAH79cC20f8atDtSaAwN3UxoXgBJvGj0aY1JMtiwf3SJJeyPdS96PpTRXrtvcDeCZEcXbwdr7rH5RO5uQOCvJfOlzvFv0xU2js8omRCKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYJN8ECZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYJN8ECZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CD11F000E9;
	Tue, 23 Jun 2026 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191780;
	bh=ZgAaqJvUL1O6OMjMcMOymeEzNcjAajkuQikSI7dp4jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WYJN8ECZRP1PetJUsRCmL2to4orhn5gRDpRzAG9WaSww9HIIy1aJT3ILiwHVv/Wj6
	 CXaY7l5MiKcgt9Is1YeuCpEFs/M3SC7rgr51jgAPw7nXwNh9jFtx2vo76uC0Q84IYY
	 z6eJjbHEiGnFS+Gsxqk9Q0rpPEPDNFW9/QcoV3o6ksGFuoMG2xOZU+0Z/OffyI6Efj
	 nylnDUpUNgmfZLm0NJ/QDapJtDglHPPMlJ9Eolx6dQVNuXaDyhMlkgvHgf2zfjsjAg
	 acYPbqAosioo30nCPlgCTYoj420OFZYZWxk3nCrRBIBPASqaOz9suHHQcZRefkhT4B
	 cLUGVma9LdSOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/21] PCI/TSM: Support connecting to PCIe CMA
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-12-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-12-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:16:20 +0000
Message-Id: <20260623051620.95CD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bypassing the function 0 check for CMA-capable devices breaks the =
subsystem's architectural assumptions and physical function iteration logic=
, leading to UAF when unlocking a freed mutex on disconnect.
- [High] Calling `pci_find_doe_mailbox()` inside `is_pci_tsm_host()` introd=
uces a Use-After-Free vulnerability when iterating over PCI devices, as DOE=
 mailboxes can be concurrently freed by device removal.
--

commit 4f85c4326e0a051322285638e0233e1946a251be
Author: Alistair Francis <alistair.francis@wdc.com>

PCI/TSM: Support connecting to PCIe CMA devices

In the next patch we are going to add a PCIe CMA TSM driver, as such we
need to ensure that is_pci_tsm_host() will allow us to connect to CMA
capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
support.

> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
[ ... ]
> @@ -142,6 +143,14 @@ static inline bool is_pci_tsm_host(struct pci_dev *p=
dev)
>  	if (pdev->is_virtfn)
>  		return false;
> =20
> +	/*
> +	 * Report capable if CMA is supported, which can be supported on any PC=
Ie
> +	 * device.
> +	 */
> +	if (pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +				 PCI_DOE_FEATURE_CMA))
> +		return true;

[Severity: High]
Does returning true for devices where the function is not 0 cause a use
after free during device disconnect?

If a CMA-capable device connects where its function number is greater
than 0, when the device is disconnected, __pci_tsm_disconnect() invokes
pci_tsm_walk_fns_reverse().

The reverse walk hardcodes the assumption that the host is function 0:

drivers/pci/tsm.c:pci_tsm_walk_fns_reverse() {
    ...
		/* on exit, caller will run @cb on function 0 */
		if (i > 0)
			cb(pf, data);
    ...
}

Because the host is a non-zero function, the walk mistakenly runs remove_fn
on the host itself, freeing the memory containing tsm_host.

drivers/pci/tsm.c:__pci_tsm_disconnect() {
	guard(mutex)(&tsm_host->lock);
	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
	ops->disconnect(pdev);
}

When __pci_tsm_disconnect() returns, does dropping the guard unlock a mutex
in the already freed memory?


[Severity: High]
Is it safe to call pci_find_doe_mailbox() here while iterating over PCI
devices without holding the device lock?

The TSM subsystem iterates over all PCI devices using for_each_pci_dev(),
repeatedly invoking is_pci_tsm_host(). While this holds a kref on the
device, pci_find_doe_mailbox() performs a lockless iteration over the xarray
without an RCU read lock:

drivers/pci/doe.c:pci_find_doe_mailbox() {
    ...
	xa_for_each(&pdev->doe_mbs, index, doe_mb)
		if (pci_doe_supports_feat(doe_mb, vendor, type))
			return doe_mb;
    ...
}

During concurrent device hot-removal, pci_destroy_dev() unconditionally
destroys mailboxes directly, without waiting for an RCU grace period:

drivers/pci/doe.c:pci_doe_destroy_mb() {
    ...
	kfree(doe_mb);
    ...
}

Can this lead to a use after free where pci_find_doe_mailbox() dereferences
mailboxes that have already been freed by a concurrent removal thread?

> +
>  	/*
>  	 * Allow for a Device Security Manager (DSM) associated with function0
>  	 * of an Endpoint to coordinate TDISP requests for other functions

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D11
