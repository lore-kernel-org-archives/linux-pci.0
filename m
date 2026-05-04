Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B234CFDD;
	Mon,  4 May 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914583; cv=none; b=S0rTdCpzY6uFnVbPnG1PgGQGqIMJhz9EQzYhU/N2rwF6boHzGaHHsu2nGm0qhPirGpqALeKnxvKRuUYDUEezYSnx9X6Ffy1qFrrQeLI1QPWPzequ0r2H4P7R0KJNsq80KhnQ1YCv62xek4K9Sq2Avz6iIbwrrqTAGRm3XzljHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914583; c=relaxed/simple;
	bh=DL0oHUGtIQtcJa3UvSNpsHCUpyj2484rSE3g3qjViQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T3OhXHfUumo7kIx156edUgGzEXfsjBrhUQIw3qUMXTfDfW0VDq11/KhzS//xRYZ66nBkOtlxg/rEJT/F7kXJj1TA12eOrtKL62DANQSkHgwDJX23wq4wCcUeDj4bCEamuCRghpmjBQ4PkZDx7Wkbuqfu3YPYf04UFiRQRiMKJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+ExzHbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+ExzHbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A32C2BCB8;
	Mon,  4 May 2026 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777914583;
	bh=DL0oHUGtIQtcJa3UvSNpsHCUpyj2484rSE3g3qjViQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c+ExzHbkvgNEzyWPuMePVK7/qM3PkmMH8cReatgKVTb/LzMSV9LSqIPWnv697dlWi
	 3mLiiH1X6QLMZ7ybpXAKRvcX2dsdoIxwtYJVgDUInk9NaFkvQBvGpyqDJJ2zTvuyUr
	 hZQUTzB1PhVaThjECxs1NHsx2tHPGq74bwKz7Ij+6s+gRlMq3WYwPwAA+nwCB+fKIH
	 dn7BZbvQcKme6hm1HNmQuYPoi4HEFw4f/DhPKkofQAFSjbLuH+fHKzMuh/iu5CWdXG
	 vROeYjpR/0UCmkpqWD3c50PvHYXNLs+/XjFbO1n7y0XqA3pNfQso2Of3X61Qe2ZXNq
	 ZP9HVavj8R25g==
Date: Mon, 4 May 2026 12:09:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
	sashiko@lists.linux.dev, Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
Message-ID: <20260504170941.GA648635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afhPkLynt7vS793r@wunner.de>

[+cc Mario]

On Mon, May 04, 2026 at 09:49:36AM +0200, Lukas Wunner wrote:
> On Sun, May 03, 2026 at 01:51:08PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider:
> > - [High] Removing the read-back and retry loop for BAR restoration in
> > `pci_restore_state()` introduces a risk of silent regressions for
> > hardware resuming from non-FLR resets (such as D3hot to D0 transitions
> > or custom driver resets). The commit incorrectly assumes the 60s delay
> > from `pci_dev_wait()` covers all usages, but standard PM resume paths
> > only delay for 10ms (`PCI_PM_D3_WAIT`) before calling `pci_restore_state()`.
> > Historically, hardware that needed slightly longer to accept
> > configuration writes relied on the 10x 1ms retry loop to successfully
> > restore BARs. By removing both the retry and the read-back verification,
> > BAR writes to slow devices will be silently dropped, leaving hardware
> > unconfigured and causing MMIO accesses to result in IOMMU faults or
> > kernel crashes.
> 
> Hallucination alert:
> 
> PCI_PM_D3_WAIT does not exist, it was renamed to PCI_PM_D3HOT_WAIT
> six years ago by commit 3789af9a13e5, which went into v5.10.
> 
> The macro is used in:
> 
> pci_pm_resume_noirq()
>   pci_pm_default_resume_early()
>     pci_pm_power_up_and_verify_state()
>       pci_power_up()
>         pci_dev_d3_sleep()
> 
> However before pci_power_up() calls pci_dev_d3_sleep(), it reads
> the PMCSR register and errors out if config space is inaccessible.
> 
> Hence when pci_restore_state() is invoked a bit later, config space
> can be assumed to be accessible.

I don't quite follow this.  In this path, pci_power_up() changes a
device from some low-power state to D0.  If the device was in D3hot or
D3cold, we must delay at least 10ms before any access to it (PCIe
r7.0, sec 5.9).  pci_power_up() doesn't do any delay before the PMCSR
read.  That part seems like a pre-existing issue even before this
patch.

If the PMCSR read returns PCI_POSSIBLE_ERROR(), pci_power_up() does
complain "Unable to change power state ... to D0" and return -EIO, but
pci_pm_power_up_and_verify_state() doesn't look at it, and
pci_pm_default_resume_early() continues on to pci_restore_state(), so
it looks to me like we could try to restore state to an inaccessible
device.

We do call pci_dev_wait() in pci_pm_reset(), which does a D3hot -> D0
transition; shouldn't we do the same in pci_power_up()?
