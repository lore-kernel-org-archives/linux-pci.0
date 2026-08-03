Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEF1DFFB
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794690; cv=none; b=edAUeCHYZXFzD4bQBYyw3HFHFp2pAn6B1f1q60As5XxDaS+1fv8axrk9hnftSYHupkIN4Fh0Cay6ph9Sa9vRUr6/leXV8h6Slv3NrDdSOa1AYA/hI0k9RpZ5gFoZ4EzFQbN6oaclS2T4Pne9YI4ivFdmUfQaK4CR2LRU5Gt8bvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794690; c=relaxed/simple;
	bh=OsULSN3nvR36nwxmHxKbPDMkvsWVSUHflw4vVDOH+34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ERNT6PaBPMBjrNCxSuyuBJAs8I233z3iiSRJAYYcxygblRwSAUbREduBYJr8BKYwG/kj9emp3ycIDIjirN8Pmegc0WE2NuSED3sqnNAHMbHCZoG9i6LFf3KxWLDJYTBSIFztolyPZBOwVaDc63bu+/KBNx7AvLF0VJqYkDuA18o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fInEXUQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fInEXUQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC28F1F000E9;
	Mon,  3 Aug 2026 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785794689;
	bh=Jz495jn8dWKwiS1xFzMIYMe8i9MpfODphz9Wc6bzpBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fInEXUQHASkfQmVQ4Hk4kNZY5JoHLuKAVaam09yo5q6YCsujYCrw1z8gXr127Civh
	 BpEeCTmCPadlmZ3tGAoO3rhR8KIIhymyC1yWWuF61caM0WEtQPw7TfITcJMdrs9Twa
	 U2wOVjIf4waFUgMIU36hkJG6HnRqehiX0M4kerUE9c1jUxjnN/rTkQTr17iTLZ69AE
	 BteSQyCdWq5SAaihSIGBWFZHAV1eH3/0YcYxmMkVNTsiIhDKmqYMmhlerZn0r//svL
	 L0SJTWMvIZpuLNsB7vHGukoWwy1j0jXAUZVE0P+P3uxuwvTbALo/Ji89LEx0cRbwMI
	 PtewsppS71B0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI/AER: Fix memory leak in aer_recover_queue()
 on kfifo buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803-b4-fix-aer-memleaks-v3-1-e87159611933@google.com>
References: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
 <20260803-b4-fix-aer-memleaks-v3-1-e87159611933@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:04:48 +0000
Message-Id: <20260803220448.DC28F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing memory leak of `entry.regs` in `aer_recover_work_func=
()` when the target PCI device is not found.
--

--- Patch [1]: [PATCH v3 1/2] PCI/AER: Fix memory leak in aer_recover_queue=
() on kfifo buffer overflow ---
commit d5a765be7d938a7478de89568f1bd78dc7110e67
Author: Priyank Rathod <rathodpriyank@google.com>

PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overflow

This commit addresses a memory leak that occurs when ACPI APEI/GHES attempts
to enqueue a new AER error record but the kfifo buffer overflows. It ensures
that the dynamically allocated memory for aer_regs is properly freed using
ghes_estatus_pool_region_free() when kfifo_in_spinlocked() fails.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a548..967cde9dd5191 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1274,9 +1274,12 @@ void aer_recover_queue(int domain, unsigned int bu=
s, unsigned int devfn,
>  	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
>  				 &aer_recover_ring_lock))
>  		schedule_work(&aer_recover_work);
> -	else
> +	else {
>  		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
>  		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> +		ghes_estatus_pool_region_free((unsigned long)aer_regs,
> +					    sizeof(struct aer_capability_regs));
> +	}

[Severity: High]
This is a pre-existing issue, but while reviewing this fix, I noticed
another potential memory leak of entry.regs in aer_recover_work_func().

When aer_recover_work_func() dequeues an entry, it attempts to find the pde=
v:

drivers/pci/pcie/aer.c:aer_recover_work_func() {
	...
	while (kfifo_get(&aer_recover_ring, &entry)) {
		pdev =3D pci_get_domain_bus_and_slot(entry.domain, entry.bus,
						   entry.devfn);
		if (!pdev) {
			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
					   ...);
			continue;
		}
	...
}

If pdev is not found, the continue statement bypasses the subsequent call to
ghes_estatus_pool_region_free().

Does this code permanently leak the constrained ghes_estatus_pool memory for
entry.regs when a device is not enumerated or hot-removed?

>  }
>  EXPORT_SYMBOL_GPL(aer_recover_queue);
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-b4-fix-aer=
-memleaks-v3-0-e87159611933@google.com?part=3D1
