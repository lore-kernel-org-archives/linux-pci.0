Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729BE3A3E9E;
	Fri, 10 Apr 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822700; cv=none; b=BbNz2DyhbtEq4XDZ+BoapOGQygK653A6j21OLsCU3mu4UZ9AJWpMwvNRov6e7IGTkE2/wFpJ3JqlU9kxvmeSOmI6xABQvJHEVU+3zzwQVp1RQ17AWrGZt9IW6tqTZ9D4RRL8erKbAWBQqnvhMbBV7H4xPA+J4EyZj++FMmsKS7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822700; c=relaxed/simple;
	bh=g4mf8jIyz2Yyw0wByKD90nIRoBjbahgRzYirW2U5NPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk3porf3Hip9VoNp/0V7r9Zs6JIcKSWa38mrCqy22GcpJXbThb01MPfg1f7PLAkjwXVY1tZ1mXIyN7ZfExX6/HAQTwApfjNlI4RoIqYzSrcc68MlMKLkkbM7LT0jQ4ZPe7DAdeYSZ79hG1M/letZac3EfA0Q8H9aSydrQL4Tv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+N6pl49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+N6pl49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7C9C19421;
	Fri, 10 Apr 2026 12:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775822700;
	bh=g4mf8jIyz2Yyw0wByKD90nIRoBjbahgRzYirW2U5NPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+N6pl49rZtSUtIekcaWHqJh0s8QPcIJClDtbMJCck0OPociCN/nvqJ+ZJXS0Ztc9
	 fbSU/X4dCcxznxYYCwW8Z+bFFX4MxROerDt7mlN0CSkcYaMgVvNiCuM+kxRNEsfrnb
	 XJoJF/N970ODaAsQjtyzo6dLqn5HFQsBl539kH5B6zkaAK70ZWH1f8hMv7okcs3jIr
	 bJ+L+Jz3FTIf8v/r9xDj9yecFJ/L/2rwwRyyQTc5mbf0YdtGl0S3zQEMIXi79tpHv1
	 OLYcHl1kdFl/g8UzYRSDUNc3OJhaZH6U8g4qz5CRM0vceard8FuNYV+CpRrCCL/FMz
	 xW06SPmUTOIlA==
Date: Fri, 10 Apr 2026 21:04:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 19/20] PCI/sysfs: Convert legacy I/O and memory
 attributes to static definitions
Message-ID: <20260410120458.GA1775649@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-20-kwilczynski@kernel.org>
 <13001ba0-35fb-f38d-5764-3c95fc3eb074@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13001ba0-35fb-f38d-5764-3c95fc3eb074@linux.intel.com>

Hello,

> > +static const struct bin_attribute pci_legacy_mem_sparse_attr = {
> > +	.attr = { .name = "legacy_mem_sparse", .mode = 0600 },
> > +	.size = 0x100000 << 5,
> 
> I suggest naming these legacy literals with defines. At least the mem one 
> could also use SZ_1M:
> 
> #define PCI_LEGACY_MEM_SIZE	SZ_1M

Sounds good.  Will do.

Thank you!

	Krzysztof
