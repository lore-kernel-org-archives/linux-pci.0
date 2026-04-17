Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1183A9625;
	Fri, 17 Apr 2026 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422884; cv=none; b=rb5KJTgSVJXD1J6iSRkWsIkvrpVFAlnq8626KVkqmenfBdfN9FGY03z+nbmfRwHlXmy2VHREFftJex1wMmwfIf3TAuSl89OKSgKioafigPrumiVnTKzQaf54uYRgBcOKZ3oD6U6S2nKRS9MjbDM+MWMzUJjstU37X+D42R8/1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422884; c=relaxed/simple;
	bh=oxr6eE6Obo6lF5D8WNr7OZWHz+CUrPikD4kF6XrOpmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txdAN+vqQBcYrDn3kCwGiaK9phyV3XhL6eYpN5ULQIFHmcrVtVs2Kz+X1I5hGKLlekL9Z8uflEbaP1GEDDX1pnmPwg++bQAO2dyCRL1sCYgMdYmcPCMx22emshebuZAPEala412Au4eYP70mHRpMY++S+6i/UFslPrVbP5gXK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMra/N/C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMra/N/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCA6C2BCF5;
	Fri, 17 Apr 2026 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776422883;
	bh=oxr6eE6Obo6lF5D8WNr7OZWHz+CUrPikD4kF6XrOpmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMra/N/CRaay6MuBJEKTzbjwp4QFtwHyhlyzls4H1s7tTZ0WjwDXSsYEXbsiDYs/5
	 bvK7GPmttjJ6bHbn/IBRHmLZxI0Q5EEmXRqL4lK/a5unV4P9nck5DMS68ySGAjMgBy
	 NX0oN3EycSD6w8qsVZAHmy70ASZ4by6UgfYs7fU8tlqoTMZvmld/GQKS6dwohAHeqd
	 OJq9QdxPWtPGBA8rSX5h8D3a8Vao1y6HoS3Jh9sXkkoVNnRsoLZdRtONPJreu+SDu5
	 3vRv5oRarX4kqoVLP/Fl7LE4QiBHtDZXeaCjCOvPAuFTVNv+IcAaC9KFaGasbx94BB
	 gAmAcs0s9ChHA==
Date: Fri, 17 Apr 2026 19:48:01 +0900
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
Subject: Re: [PATCH v4 13/24] alpha/PCI: Use PCI resource accessor macros
Message-ID: <20260417104801.GB1625998@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <20260411080148.471335-14-kwilczynski@kernel.org>
 <5c4f32d1-0648-31d1-d7c0-661ccec4f8bc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c4f32d1-0648-31d1-d7c0-661ccec4f8bc@linux.intel.com>

Hello,

> > @@ -181,7 +181,7 @@ static int pci_create_attr(struct pci_dev *pdev, int num)
> >  	suffix = "";	/* Assume bwx machine, normal resourceN files. */
> >  	nlen1 = 10;
> >  
> > -	if (pdev->resource[num].flags & IORESOURCE_MEM) {
> > +	if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {
> 
> This could have used the new helper but since this code is going away 
> anyway in a later patch it doesn't matter,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Taken care of in v5.

Thank you!

	Krzysztof
