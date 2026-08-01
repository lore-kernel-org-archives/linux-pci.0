Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7A242D89
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557360; cv=none; b=UDcsQGT4bGEOVviMS58cd8jbh0wi9ReVzFJsXc0LqNI8Urtc2GV0sfH8JBXIpjtgZqzfECl1Rrl8YmlTVyEMoXgw8blBskpoa5wbFqDODl3omvvXZKZZBqyOkYRDrLKL8vSQlg2VWd9UFtBJHiPjMSAapGq3axakI4AZZyTrHdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557360; c=relaxed/simple;
	bh=SObZPa72eALJR6JiFSFCKajKpU346Yj/q6uIrI1aftk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIfztoMItydW47Pu9tjobkwpzmJFe7iQJmLEGSh0couoigSiOHhSL2ebgwT//Y5mz8jgu2qGnUvXWJXbpq7CCTWJobKMZjQQ8YpMhOHKQB0IsKkiTxnjljGo6D2WedzDQcs/dwHNuJ476n8EhUMQdxFZJCTnz16AwqQ88ppPeIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqPkp7GE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqPkp7GE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CE11F00AC4;
	Sat,  1 Aug 2026 04:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785557359;
	bh=zNGum7pySS+QMFDmVgPmyhtKu43R9l00Ruw26SOQL0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DqPkp7GENHafQ5KsCc/tyqkQoyi3p1pwdYmBkT0K/GYAQ8crPLl6Li1BwsGEEvKwe
	 r3k2DMSvihD0KDgGePvAsDvTRNN52WJS7C+P8+l6EYEtwtrT0AH0moIybNNDEFgI8X
	 mOwuDatoRBXRPDs66+r4+fdMecwLidORZrHqZmtsMv9C3MzExJj0pCvF7663e/dlAw
	 5Nw8oX1ARo1H/d4+Lqsc807c8tVJEhcnbAf/f6W9bm3PsvWjjcJ20K9ss15K24InbN
	 9FDf+VBHa8csWPxqHyWqwDqpIS45nSLeQP7Gdoin6dHq6Nz1sQ7HvVtWCo24f9H3iE
	 wd2Ht1ElmvmAw==
Date: Sat, 1 Aug 2026 13:09:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Kees Cook <kees@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Add lockdown checks to legacy I/O and memory
 handlers
Message-ID: <20260801040854.GG3183355@rocinante>
References: <20260720211541.1509744-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720211541.1509744-1-kwilczynski@kernel.org>

Hello,

> Currently, the legacy I/O and memory sysfs handlers do not
> check security_locked_down(LOCKDOWN_PCI_ACCESS), leaving the
> legacy_io and legacy_mem files unprotected when the kernel is
> locked down.
> 
> Commit eb627e17727e ("PCI: Lock down BAR access when the
> kernel is locked down") added the check to pci_write_config(),
> pci_mmap_resource(), and pci_write_resource_io() to prevent
> userspace from programming DMA-capable hardware that could be
> used to modify kernel code, but did not cover the legacy
> handlers.
> 
> As a result, root can still write arbitrary I/O ports and map
> the legacy I/O and memory spaces while the kernel is locked
> down, which is the same capability the lockdown is meant to
> remove.
> 
> Thus, add the same check to pci_write_legacy_io(),
> pci_mmap_legacy_mem(), and pci_mmap_legacy_io().
> 
> These generic handlers cover both architectures that
> define HAVE_PCI_LEGACY (such as Alpha and PowerPC).

Applied to the sysfs branch.

Thank you!

	Krzysztof
