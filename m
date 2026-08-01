Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71533546C1
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557291; cv=none; b=ej8uBbsCl0lsUK7YnQNDHk+FOk3bNWWqPKQv9mZQIqNTNCw0ea/2vxiVzA/Ci5is7eSuKZuSe7oSejRCgsAib0hQWPCNot3Qvb7iTe40OjRvkQ1eQJEMsX52oa9q7MfvoS4LGurWXmSmTikqPM7UvCQoTYl/E3bwZNyQFk8zxCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557291; c=relaxed/simple;
	bh=kLFdMKl/TVtmvn+/I/G3ClmYTxg7p0VRMUrl56WIG6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ND/6pToHhKeFULxp+FMv7g8n1HiK9sm/vkcmZEKsP9iomN53uiQ3zgyZAg3lRdsl3v/14h478PSlxKLkyae1JtxMndOFz+XBArUh00KxoTsaAIwlXOQ4uhmd6FxXEeli7Kl48Ry89iaoPS8DmNyaDbSOAdkFWe934n1lJcP7ZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC9EOAZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC9EOAZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9BB1F00AC4;
	Sat,  1 Aug 2026 04:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785557290;
	bh=JU4G9cRdwK1ZrrZZHqhP6wd+V/uo02ani2rwJhfEYe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XC9EOAZMVzksWpBlF4pcEWmz739XX3cTDc8AADM/w2V1ARAQ8CyDDM/+wgvrAavsY
	 Z506o0qawUzdBqdo0G0mhbEPhilUxCXSHGSB7RUbENjENM//p+xIR/xL+ZC8JtgRel
	 CeOzCunm2TMBXZuT2VfXNqEyBpAI88v2JFDRKnRL992vidUieXn9oucAOUBSiOP00H
	 y+Wfouli3T2I6CoU36jTzsK7aYrgIc/gbd+eeWTiAJg6XIgPP6VDmiblT/rgYJcrdp
	 MT2g3d9ujFcYwkQX2u5bHWfyPxePhsKMm1V3JriIqQBFhYPiwhVTqRljo2SIGZMon9
	 cRdgMFToncdOA==
Date: Sat, 1 Aug 2026 13:08:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Avoid spurious runtime PM wakeup on config
 space accesses
Message-ID: <20260801040752.GE3183355@rocinante>
References: <20260720204356.1501749-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720204356.1501749-1-kwilczynski@kernel.org>

Hello,

> Currently, the boundary checks in pci_read_config() and
> pci_write_config() reject only offsets beyond the effective
> configuration space size.
> 
> Thus, an access at an offset exactly equal to that size passes
> the check, has its length clamped to zero, and then invokes
> pci_config_pm_runtime_get() and pci_config_pm_runtime_put()
> around transfer blocks that do nothing.
> 
> This is a problem because pci_config_pm_runtime_get() synchronously
> resumes the upstream bridge through pm_runtime_get_sync(), and resumes
> the device itself through pm_runtime_resume() when it is in D3cold,
> only for the handler to return zero immediately afterwards.  Such a
> spurious wakeup wastes power and adds needless resume latency.
> 
> The sysfs core already clamps accesses against the attribute size set
> through the bin_size() callback, which reports either 256 or 4096
> bytes.  As such, the affected accesses are reads at offset 64 (or 128
> for CardBus devices) through files opened without CAP_SYS_ADMIN, and
> reads and writes at the exact configuration space size on devices
> where a quirk sets a non-standard size.
> 
> Therefore, reject accesses at the boundary offset as well, so that
> they return early before any runtime PM involvement, matching the
> procfs implementations in proc_bus_pci_read() and proc_bus_pci_write().
> 
> The value returned to userspace at these offsets remains zero,
> so the change is not visible to userspace.

Applied to the sysfs branch.

Thank you!

	Krzysztof
