Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E139E177;
	Fri, 10 Apr 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820432; cv=none; b=H54DSQ23TypqFKsh4UI3F0rznrdIjhxd9JOD551qLRGx/0mvk3cycUfhMTOpIsxD0/rHAKTDQwROGhqD17UuME/Bg2+ehIm/ZJmRHKK253nR6lvutIKJLpRtd60DbfCmZFqKKHcxjzW0EeNnfgZuCDVckocsRHxlGv+j0INXeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820432; c=relaxed/simple;
	bh=1su7Hk+2MPUWstIkBAykmSdSjnEsIRdA/siC5BZw4x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3E0yMTgtOKUUzdZCCfKUkpFozU0Ki+JkcWIke+PWV8ZAkmEb87xRz+9a4QQZernv3mzo2DUwdyWOscUCFeSoEax6sdMAxaJ7NOZkvXoYndvPRnc099g6TQAepIhF4CE4eEegUM6Rk9Vg+xK6GZLTzraFV3FnbF564+4vjzKfUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PysyFQl6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PysyFQl6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB18C19421;
	Fri, 10 Apr 2026 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775820431;
	bh=1su7Hk+2MPUWstIkBAykmSdSjnEsIRdA/siC5BZw4x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PysyFQl6cHHK121wyAz9FjAkUHXRBYYV0l8JL1w0Gb3CrDtM52JIADeYXSy+RQj90
	 Rb/QLPZTrzyCHpZpi94xhrHAMOOVLE9rvMBQryCpadewXyqKFsDh/XybTPr4riFcYM
	 nYY+Q5cJDURPt+QOYNqDRYm85T+qux6XCyHhsFcTZH83F9yfxGVA1e+cNapPmnasqD
	 qRgemNPh5xlNYZehbYiW4cWaNj43FUqgxa92TiIK5ZRPEklq5HcGupxDe8+zrOHP8G
	 qHs3LHYYSm66jU2NtITeLSEd9oucxEHQp3zhnAqNqGK/AQ+slZFYKeKB+wrfJ37oBZ
	 2uHS+pp7Hhd2w==
Date: Fri, 10 Apr 2026 20:27:09 +0900
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
Subject: Re: [PATCH 12/20] alpha/PCI: Use PCI resource accessor macros
Message-ID: <20260410112709.GB1756033@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-13-kwilczynski@kernel.org>
 <f36a3096-4a9c-93f7-48cb-e6f4c60fdb93@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f36a3096-4a9c-93f7-48cb-e6f4c60fdb93@linux.intel.com>

Hello,

> > -	if (pdev->resource[num].flags & IORESOURCE_MEM) {
> > +	if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> I started wonder though if we'd want to add pci_resource_is_mem/io() 
> shortcuts for these, as it's largely what
> 
>     git grep pci_resource_flags
> 
> results contain.

I see what you mean...  We can introduce such helpers here, and be the first
users within the PCI tree, that is, before someone will do a tree-wide or some
more granular update eventually.

Should I do it?  Thoughts?

Thank you!

	Krzysztof
