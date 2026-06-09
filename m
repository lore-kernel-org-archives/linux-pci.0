Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288272F747A;
	Tue,  9 Jun 2026 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044434; cv=none; b=e2HNMgNc+WZM0EUr7FEdon0AmtV7X+QROFefTPwtCeqOrCw+Zp88/9jvNIRcmxgRfNy7kMsPQrbNrtdPiTTR9t9q964p+RhtPm5fuTl5xUEn6NPiBPHOTcvhPNOCOVa532NghzH3nskihMNvSD+CIRHJTFKeQoinosow9K4+TAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044434; c=relaxed/simple;
	bh=r71GeF13z15/J+HWB5HHcrrSSYx99fBCkIAz4OZaV2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uTNiNfhG/dOZ3I3+BwHLx0vbxgKJqJyJVpx2LlHo3MfYqmf/J4HiPgbS6a4B732Vpee3J0znfK9E84Au6bBpqF9cmb7YbGo1cjuu02dAkkE3qkVIyotwzD/vXLWhsrfKRZXix6fhCVo+beboR4yJ+jnMNykzx/4vQjNzaDiKY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOFDXQbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOFDXQbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9639A1F00893;
	Tue,  9 Jun 2026 22:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781044432;
	bh=//wNI/+v4p0T0vyPB0Hadc2N7fJrb9Azl2VcVsk9x0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fOFDXQbs8X5/s8PEGI/WaRbxbbWfghylGp7IxMLULFUw7SZbxALZZXw5B7ziDqJVk
	 ev2pUi7EJuxgfYCWqPkBD8sEknGbySHXi1b94rdsiDjNPni6kUaoNzqc6xCEHrZSNl
	 cAmdwpUHwSjafmQkncemn7ByQ4ExPu5VYty3mdk42MIqGY+bck0cfbj4Z2uCOTzsQI
	 qYF5IyMbo7ztHUQ3vEpdnHh4Pw0bEload78ljk21e93LDoG2ogGzW7YfQhTBOlpPSJ
	 IEuDO7FTutbTOxBE1XyvJHIqiI/CZVjQkm3enNz5rkBQdcVY39ei6/znm1VveQuLdd
	 sxZih9rO6wpRg==
Date: Tue, 9 Jun 2026 17:33:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
Message-ID: <20260609223351.GA157386@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603185736.8345C1F00893@smtp.kernel.org>

On Wed, Jun 03, 2026 at 06:57:36PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The config space accessibility check is placed in pcie_reset_flr() instead of pcie_flr(), leaving direct callers of pcie_flr() exposed to 60-second hangs.
> ...

I don't know why sashiko calls this a "pre-existing" issue.  This
patch *adds* the config space accessibility check, so it looks like an
issue with this patch to me.

> > +++ b/drivers/pci/pci.c
> > @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
> >  	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
> >  		return -ENOTTY;
> >  
> > +	if (!pci_dev_config_accessible(dev, "FLR"))
> > +		return -ENOTTY;
> > +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does placing this check in
> pcie_reset_flr() leave direct callers of pcie_flr() exposed to 60-second
> hangs?
> 
> Direct callers of pcie_flr() (like network and storage drivers during error
> recovery) bypass this wrapper. They will still experience a stall in
> pci_dev_wait() when attempting to reset a device with an inaccessible config
> space. Should this accessibility check be moved into pcie_flr() instead to
> protect all callers?

I can't remember why we have both pcie_reset_flr() and pcie_flr(),
other than the fact that callers don't need to supply a "probe"
argument to pcie_flr().

Is there a reason to call pci_dev_config_accessible() here rather than
in pcie_flr()?
