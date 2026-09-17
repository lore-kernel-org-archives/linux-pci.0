Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15C4DDB49;
	Thu, 17 Sep 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660772; cv=none; b=tC6yEreMH91aQLOnM4dKli0ALr20ZEsrKI7LvFti7+Ul9/6ypiQx38wibKFw8K8VE8Gi2cfQK++nhK9xMeIlzL9l1vkO7hyjyeip7JIiVHtEJTWleGm0QQdTHDTyHf+cTKKQ38YSjwFfn8btQSLFXR0/NuClu0+Po2AfaNvJ5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660772; c=relaxed/simple;
	bh=GlD+BDb/vo59gvtL5PqGUBZy8bJ8YSdQKEYNTKrrP0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Kna15nRr5eiAwZs78K9mkXyMxU3YvRR43nPjxA/9a+D5SVdmgs2b8JZwsYbRNlGj14hQ5UHKwjfb+RuFlIQeud5ZRfCHhRfOf3++B4M22HEV8GvrsCkVKq72O+O4Oj5spguOvK2/8lxiLoo83rktYA/LpviUuXsBY5FT4qBiNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOt1Pnuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOt1Pnuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176A61F00893;
	Thu, 17 Sep 2026 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660771;
	bh=BcZKonsEm6iNlR2z607KW+Ej9GYIpjgHVKnzVdpC+VI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=VOt1Pnuv0J5qzuS/czmoPrZ8YpgfWW/bLej1RS+9XXu3txiRsUSdsbe7m1OdNV5gK
	 /MQk0j+5+h1hcHe6uQMCH6HujFlskKkENo9k/vZCLIobcHKtgndh0c0Rlhql0kcO58
	 sa8QWn67QcAeLJ5FX071zkZKGrG1FAiJu5AluIffCCebomScUSrr46rSHYRGg9OIu0
	 OkZudqQwsJnlrOTmYUd2ypaQqcQsqHpgKfjtrCX+x127+ynJIrc8zD8bdDLAYXUEii
	 +gmKPPmcWrW6XXfIpA4cq0YZX8tXsjwqj+LD9tom6Ndhs6EaCf5+5jF3taEo7s4oux
	 a2GvJXCj3TlLg==
Date: Thu, 17 Sep 2026 10:59:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	rafal@milecki.pl, zajec5@gmail.com, florian.fainelli@broadcom.com,
	arnd@arndb.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rosenp@gmail.com, rani.hod@gmail.com
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Message-ID: <20260917155929.GA1023894@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAsRjR=1iL+Nw0+0erVH2t8igpobXBfcqijz4vzMO7cW=ryHPw@mail.gmail.com>

On Thu, Sep 17, 2026 at 08:40:00AM +0300, Semih Baskan wrote:
> On Wed, Sep 16, 2026 at 03:01:10PM -0500, Bjorn Helgaas wrote:
> > If bcma finds both of these devices via EROM, why do they need a
> > "brcm,iproc-pcie" compatible?  If we omitted that compatible, what
> > would break?
> 
> bcma does not need it. pcie-iproc-platform does.

And why do we need pcie-iproc-platform, since pcie-iproc-bcma.c will
claim them?

Is there a requirement that pcie-iproc-platform must be able to claim
the PCI host bridge if CONFIG_PCIE_IPROC_BCMA is not enabled?
