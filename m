Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229411A262A;
	Fri,  8 May 2026 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778216700; cv=none; b=OcgIA6B0Qcvub+16a23qUFgcC5jD65iDrupZX575FEP+sKheOe9LqIL0q36kbqg8P2TjmyxO3lC0jOEtxPIj38simBilAppp/kDjpt2gbNSaxzeAoqDpAT8zuEiagFJnxYBkTVAX+OFxrzpyXZaLkv9LT34bocRxhRbvdGCTfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778216700; c=relaxed/simple;
	bh=HgAFgTK0Uj0l6KRrkFYk1UjE/6jWW0FN56RqvZciSww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX+KepDZEJFQazK+V33bfwXUqIl3oae01uzLDJWkpTlSgSNDBIYEYt7NaRs+/TywAvf+lSuMlXAQ9qBQ2dyOXcEXwPrIhHS9N99l7cchTmL42wDfLiFdA30Uq2kMUcPZLgzZKzFFBA4VgTNXIQXHf7UPXrEpPm84+PNVieN60qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui8RYGry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui8RYGry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F41DC2BCB0;
	Fri,  8 May 2026 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778216699;
	bh=HgAFgTK0Uj0l6KRrkFYk1UjE/6jWW0FN56RqvZciSww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ui8RYGryHvSVkHN/0G15CIgX14+5XhsDV/Uk/mjbqIdm6As1t4gLqsEqwkM1sH2dY
	 9S197I3rMElNAUB59t2lB1hXzOVWX1PP3RTxEPC4qlbBBvFzLc4C3bru6/O+56rfNs
	 XqONWMWHkRhHjlaYWSFPOg7Ohr4WtGfZ24312j7fJxqvF8ZZ9XFiMraqE5i8E3RXPX
	 Kl7uLaJwhJH/enszFQz6p1HQd2ViNfk86V3frLK08phXIsjL4XVdvhKUu0/NEmTO/P
	 pVyJ5AL7MYr5jOhWVLfzKYoDinCsXhx8Xx0VqLR9fcqD+yqLQvbZczyEgIYcpW+F0h
	 FwN9FqvJChshQ==
Date: Fri, 8 May 2026 14:04:57 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 15/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
 and __legacy_mmap_fits()
Message-ID: <20260508045824.GA3160093@rocinante>
References: <20260508043543.217179-16-kwilczynski@kernel.org>
 <20260508045452.15B72C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508045452.15B72C2BCB0@smtp.kernel.org>

Hello,

> >  static int __legacy_mmap_fits(struct pci_controller *hose,
> >  			      struct vm_area_struct *vma,
> > -			      unsigned long res_size, int sparse)
> > +			      unsigned long res_size)
> 
> This isn't a bug, but since the WARN() statement that used hose->index was
> removed below, is the hose parameter still needed? It appears to be completely
> unused in the function body now.

Ah, yes, darn.  Forgot to remove this one, too.  A quick fix:

diff --git i/arch/alpha/kernel/pci-sysfs.c w/arch/alpha/kernel/pci-sysfs.c
index 7dae4999c5e3..94dbc470cd6c 100644
--- i/arch/alpha/kernel/pci-sysfs.c
+++ w/arch/alpha/kernel/pci-sysfs.c
@@ -143,8 +143,7 @@ static int sparse_mem_mmap_fits(struct pci_dev *pdev, int num)
 
 /* Legacy I/O bus mapping stuff. */
 
-static int __legacy_mmap_fits(struct pci_controller *hose,
-			      struct vm_area_struct *vma,
+static int __legacy_mmap_fits(struct vm_area_struct *vma,
 			      unsigned long res_size)
 {
 	unsigned long nr, start, size;
@@ -179,7 +178,7 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
 	if (sparse)
 		res_size <<= 5;
 
-	if (!__legacy_mmap_fits(hose, vma, res_size))
+	if (!__legacy_mmap_fits(vma, res_size))
 		return -EINVAL;
 
 	return hose_mmap_page_range(hose, vma, mmap_type, sparse);

Which can be applied/squashed later.

Thank you!

	Krzysztof
