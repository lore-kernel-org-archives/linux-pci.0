Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60337DE84
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709449; cv=none; b=BdphCucvrlc8jPcD3oIXUsmwxGchTOHMHt4k2GkklXXEPJgGP5velvHITYSFclvXuF4ngbo/2mHsrkmpvC37RtTPVHsi8aQyGAzQrIJN+AWMcl9ZthdX6HGWtFY6YxC3JmwMvTAD5rpPvCDwa9UzHrFXLPZ2REGSqTBDakCPseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709449; c=relaxed/simple;
	bh=Up8gAvVN7OzRa6/2USEmJ6GZwKTSaMLtlveDHSnTHJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RgxTI8WNaYae+BZZA4lXObYxG6/eOtJFPb+KM5qyrMfbC12gusW07rluw+Ai1qIqRXJs+S2HhB/29Ongh9GW8vus3S1C7U7VajBFmi2L4hzYqEvikkkCorL23F86ksGX2f4uqEcjvx5M5n0WP+enHBS0Kvj5RL0DPO006+vuBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Y4btJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Y4btJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9261F000E9;
	Fri, 10 Jul 2026 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783709448;
	bh=kI8fAHe0xmX/hOZxKnUoon27Ai9JaOEyFDifmQGxQSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=N4Y4btJbhyTsrSyvmaBB8OC5cZUmYyVzNrA+ESNRdzKUJjzGzuTK3bORM6YHhypx0
	 bVKKciY5KwBQdEMHwURQA1OIF3Xr9MQ9PDiN/tLhNW4NPLPWOEPaU0uBZHHZD8LFoi
	 GJTeHB8pgnP4HSAMCkYA/IUjvhznARagiULt6DXNmfK5V/op8eULcwHN6c1pgRaHrJ
	 Cm6TpST3XLANd3Sr4MqCeqAWVPeRwCK6R4BV7S94ROkpTZxrQYzy6ri4ZdjVqoFcZq
	 BpEJ6VrZBk1Kayg9hVkLqraiS4J8S0tQMO5j4eZvSOZPC5I3AVg+AnlnQ0swAJmbNb
	 AYSsKQVzKMbjQ==
Date: Fri, 10 Jul 2026 13:50:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [pci:controller/dwc-rcar-gen4] BUILD SUCCESS
 6bd0f589488396d14c4d9e4f030954ccc2ee4f93
Message-ID: <20260710185046.GA979125@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607110222.SU1ivW18-lkp@intel.com>

On Sat, Jul 11, 2026 at 02:32:33AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/dwc-rcar-gen4
> branch HEAD: 6bd0f589488396d14c4d9e4f030954ccc2ee4f93  irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround

I don't think this "BUILD SUCCESS" is accurate.  On x86_64, defconfig
plus all PCI drivers enabled, building this same commit:

  01:42:29 ~/linux (controller/dwc-rcar-gen4)$ git --no-pager show -s --pretty=format:"%h (\"%s\")%n"
  6bd0f5894883 ("irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround")

  01:42:32 ~/linux (controller/dwc-rcar-gen4)$ make drivers/pci/
    DESCEND objtool
    CC      drivers/pci/controller/dwc/pcie-rcar-gen4.o
  In file included from drivers/pci/controller/dwc/pcie-rcar-gen4.c:16:
  ./include/linux/irqchip/arm-gic-v3.h:605:10: fatal error: asm/arch_gicv3.h: No such file or directory
    605 | #include <asm/arch_gicv3.h>
	|          ^~~~~~~~~~~~~~~~~~
