Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4D1EBA14;
	Mon, 23 Feb 2026 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873106; cv=none; b=WnW+QdH9FhDobC6n2gwzj15Qhp/UETDQli4jNQsKdqRXkWP/VdeP/ev7pz6EC093rSrMJVrTDTZcE3kz2+l4vO3rLDPI+fn8F5xXECf53CvGM9uDzOKYbLDViq4NSdF15AOGBBUvXyB0Jb3a+sfhvr/6a4ZFUfBC3T2Y9brlTLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873106; c=relaxed/simple;
	bh=RlFm2DX5UJyHTxSeOJs+DVk8ybc74g+uGIUo3UtIR78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2/g4wzdwsmreLFc3qKPDj05lUBhXfNWVM+xD9OXzfgDIsUTN7j3sHzmVfg9glWSMsRpH9oKWD4UowcjmzTpQsDMoY7yj0wd0YRNlydo95e9OT7hfvIKQwikPmj8w32ZMxbAdk7oG0hFRn5ahTcnCog1eF3tVHmbgPrVCAhu72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIclU7g3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIclU7g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA6CC116C6;
	Mon, 23 Feb 2026 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771873105;
	bh=RlFm2DX5UJyHTxSeOJs+DVk8ybc74g+uGIUo3UtIR78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIclU7g3GUTmBcdrYQSax95mczGgQ4/tUmIPR1U0TAgpMscTXrJ1xh2VNeqGQQ5Jb
	 dG4ni+rQ0qfJxOO3VOYE8yXGrVFNGRSAGW2C+MeTzErxnHku5bSQtyHxxhPrJ3cE1v
	 Cc9701P9zPoTDPHm6V/DUTEIoAlwQ6leGsj5aXLzQkniTLgPYWnscG5mTQYvP5veP2
	 gaugfnYNPk4uFgeZy5UPnB1oTB4h1gUZxtO/9I7afwSxa1MZqhxZYaO449ScjqLo9i
	 9hxBkhHVDAtcZwM2FCZwrXYrUP+6RZA9EvtSJPXduJsyqfxWwF82T95BKR6ypbxdpA
	 1zwsas28KbhQw==
Date: Mon, 23 Feb 2026 12:58:24 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/1] PCI: dwc: Remove not-going-to-be-supported code
 for Baikal SoC
Message-ID: <177187310274.163191.14167430732235845058.robh@kernel.org>
References: <20260220142600.2397070-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220142600.2397070-1-andriy.shevchenko@linux.intel.com>


On Fri, 20 Feb 2026 15:21:12 +0100, Andy Shevchenko wrote:
> As noticed in the discussion [1] the Baikal SoC and platforms
> are not going to be finalized, hence remove stale code.
> 
> Link: https://lore.kernel.org/lkml/22b92ddf-6321-41b5-8073-f9c7064d3432@infradead.org/ [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: removed YAML file
> 
>  .../bindings/pci/baikal,bt1-pcie.yaml         | 168 -----
>  drivers/pci/controller/dwc/Kconfig            |   9 -
>  drivers/pci/controller/dwc/Makefile           |   1 -
>  drivers/pci/controller/dwc/pcie-bt1.c         | 645 ------------------
>  4 files changed, 823 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/baikal,bt1-pcie.yaml
>  delete mode 100644 drivers/pci/controller/dwc/pcie-bt1.c
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

