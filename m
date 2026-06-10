Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAB3939AE;
	Wed, 10 Jun 2026 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781135074; cv=none; b=Gz339Jef+fqMN8SScjM480iM9FLagXXKtMSvj5qG+7NaNPGMDY7LqAFM+8xfRSKPcN0ofqCJOQFvl3E1OyrAcJhBoPQQ3w7glxpv1sXhJi+JK6ksUCL4f/Wkbu18wHq71vSBlZhjSvIzrzvEKgqBYBayV/SetyULKbBaQQBVm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781135074; c=relaxed/simple;
	bh=k8zFLbtWL36/f99gYgUe9zs7pR5hvQMl1oPa28vx3UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ByYl0CHWXLbizVmP7NhohF9zBGCEhT3VJNSIV4kgH14pZzOPei3mOnrXha+kqGICGY0Qu6TPM7N+mI43d2WuLZTnFHJTv9iV3zpvZCIBJnP5mSrYkzhl1w+mqvdQ6DIDKp0twf0CEX17LE8HcWzydG+dBrtsD9PlMGp+5bBc6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRcZZy5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRcZZy5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167761F00893;
	Wed, 10 Jun 2026 23:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781135070;
	bh=LGUZmTMuoKlGnR0Wq8S+K5N9BQQN9AnKzFeoODD6Cm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ZRcZZy5SmBpmTU3DKyihFZJhIPkabiPpDYOIS3RkkmceYmR+R5ifcSSrsR4Hhoczt
	 iKOCs6bGQ3Rn353XfQ1tbxfBtdV4PbOSNEypy6x9NsaavDs9xttqEu+m6eopF/MpWH
	 lHUBbxzyfzV93eFdHqxPTcPRKdQLovGbuwz7pW+tb3trqftstE3rCwzHFpnq3eJbHs
	 AJf+x4m+AJZt/UU8Db+/KsO+OwmcxnCCxAfOwYgUsxnZteewvvfX3wyfxxiavG+m1m
	 qCdN76dpMeAZLQqacn8H0VhxxsBoT3FVv8+MZTKHC+l08wHdLc9B8cVQ7WI9BmO+NM
	 7CAbLZ3KfVHbA==
Date: Wed, 10 Jun 2026 18:44:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
Message-ID: <20260610234428.GA433532@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66cb5988-ce72-4acf-8e1c-0eb72b4fbd41@linux.ibm.com>

On Wed, Jun 10, 2026 at 09:51:55AM -0700, Farhan Ali wrote:
> On 6/9/2026 3:33 PM, Bjorn Helgaas wrote:
> > On Wed, Jun 03, 2026 at 06:57:36PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > > 
> > > Pre-existing issues:
> ...

> > > > +++ b/drivers/pci/pci.c
> > > > @@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
> > > >   	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
> > > >   		return -ENOTTY;
> > > > +	if (!pci_dev_config_accessible(dev, "FLR"))
> > > > +		return -ENOTTY;
> > > > +
> > > [Severity: High]
> > > This isn't a bug introduced by this patch, but does placing this
> > > check in pcie_reset_flr() leave direct callers of pcie_flr()
> > > exposed to 60-second hangs?
> > > 
> > > Direct callers of pcie_flr() (like network and storage drivers
> > > during error recovery) bypass this wrapper. They will still
> > > experience a stall in pci_dev_wait() when attempting to reset a
> > > device with an inaccessible config space. Should this
> > > accessibility check be moved into pcie_flr() instead to protect
> > > all callers?
> ...

> > Is there a reason to call pci_dev_config_accessible() here rather
> > than in pcie_flr()?
> 
> The reason we wanted the check in pcie_reset_flr() was so to be able
> to escalate to bus reset method if we can't do an FLR. I think the
> check could be moved to pcie_flr(). Is that more preferable?

I think so.  Doesn't the escalation still work if the check is in
pcie_flr()?
