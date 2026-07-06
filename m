Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1427A107;
	Mon,  6 Jul 2026 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361148; cv=none; b=M4iy30LCSLwZztHq2kvJr8HVPiX+toomQ7uxvNTY+UPOPsI48TLhup6N+Y3uZu9XmEoJPS7aM6cici+eJDcFohKICqR8LouuREdz1mENilL8T5n6j+f20gMcFi7JvlrBs1K94/C0PQPGmmJN67SvNJD+iOpLxmZeSCwRxgvR9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361148; c=relaxed/simple;
	bh=Rp8b8yhxo3uquTyDhveP6UHaKzB9XtoYtMB6Z2woCug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5ebT25Fh4fs2L4DbINyF9C2kcjGqFofmOIrrkMo311X4iGK3829Pn/Pb86G+zUUw05H8gSxL4+twiGRDke7YPa3AoYrhr9z/jq1symkfE6q3uSf5kzxkPDCmC1U+U++1DOgJ4cAVcJniUUrWSa1ceVrsbvboc1YFBlDW68ge+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mThbQP0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mThbQP0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03E31F000E9;
	Mon,  6 Jul 2026 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361147;
	bh=lS5mQ8jxBl2iII3sye5/k61Ij6XIW0SLlPx3ORBjMOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mThbQP0Basmxs9eRhzjXAjifVVsdk5rdVEEOd/kevttMi1gacBMgRcKY2XemUdnpJ
	 yq6WxLgYPq+adOButB24df822RmfCsSkd8m4ETWURm8HOViCmzONZRF4KrchnEtif+
	 14nILHnzGeaC8a7DV2PUAnKj8bGqPMFNNIuYh/7njFoY7kjoDOLDqtwpQEH78ki2GC
	 xTm9DJb6p+vaML+XjB4639WzBm5+XenJm2EsOlBXAHxzbKUoQZQ+zNcYVF9j5pHhDq
	 Em4xzMaL69KoIavoPnl6H611ydaQbyyTZ2xmYPtFfUoOdTctdImF9Q1QVYQJs/xbo6
	 R1UgX+sTznfGg==
Date: Tue, 7 Jul 2026 03:05:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/sysfs: Fix out-of-bounds read in
 pci_write_legacy_io()
Message-ID: <20260706180158.GC265195@rocinante>
References: <20260616163131.2763281-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616163131.2763281-1-kwilczynski@kernel.org>

Hello,

> pci_write_legacy_io() loads 4 bytes from the kernfs write buffer
> regardless of how many bytes userspace wrote:
> 
>   if (count != 1 && count != 2 && count != 4)
>           return -EINVAL;
> 
>   return pci_legacy_write(bus, off, *(u32 *)buf, count);
> 
> kernfs_fop_write_iter() allocates the buffer with kmalloc(len + 1),
> so a 1-byte write to the legacy_io sysfs file allocates 2 bytes and
> the unconditional u32 load reads up to 2 bytes past the end of the
> allocation, which KASAN reports as a slab-out-of-bounds read.
> Similarly, a 2-byte write overreads by 1 byte.
> 
> Thus, read only the number of bytes requested using get_unaligned_le16()
> and get_unaligned_le32() for the 2 and 4 byte cases, interpreting the
> buffer as little-endian to match the byte ordering of PCI I/O port
> space.
> 
> The PowerPC implementation previously compensated for the generic
> code's native-endian 32-bit load by shifting the value into place
> for the 1 and 2 byte cases.  The shifts were only correct on
> big-endian kernels.
> 
> On little-endian PowerPC (POWER8 and later), they extracted the wrong
> bytes, so a 1-byte write wrote an out-of-bounds byte instead of the
> requested value.  On big-endian, the native load also caused out_le16()
> and out_le32() to reverse the user's bytes on the wire for 2 and 4 byte
> writes.  The little-endian helpers resolve both issues, so the shifts
> are removed.
> 
> No changes are needed for the Alpha platform.
> 
> The legacy_io file is root-only and exists only on Alpha and PowerPC,
> the two architectures that define HAVE_PCI_LEGACY.

Applied to the sysfs branch.  I would like for the 0-day bot to pick this
up, and also to have some linux-next soak time, if possible.

Thank you!

	Krzysztof
