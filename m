Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6681E89C;
	Thu, 23 Apr 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970847; cv=none; b=gUN8tRCA/jxnLCEdciIFzuf7d/04wIS81D/DcKEjEAWRgLoeZuxg9Mikm1TYiLe5hnzBUJNzyaOGnuihKAErePfzykehioCLFmiunO/hEzfAlSYDTYQMJZ7ZfKPLvH1+nb7DyHAvlRqwhqVhcjQiIg2GNvs1Kh6nY6dFRRGPHMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970847; c=relaxed/simple;
	bh=ttpltMQhZGuUtpUXtuyxrd4NzolrST+hEhEzFm38PN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+Hd6ApqNZtaDHe33tV8XTSTcdRCdxk305sfwAXIAWGIaOC7p85qhXvLjSR6Oaz6neMR+8ilRaKpliKqrve+BHlac2GANztmabOps4PQfniBtX7r5Wfo6KbiF2Ey0SugDt0XpRwgHq7V5nM/s5kXc6nWnmmTVcBD9IdPAS2fro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAXXtHHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAXXtHHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76723C2BCF4;
	Thu, 23 Apr 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970846;
	bh=ttpltMQhZGuUtpUXtuyxrd4NzolrST+hEhEzFm38PN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAXXtHHbpPfK5J2qgcvC0vshyq0zsDC6ZbCzgHkVg6BjWdvItjP+AdCNnFfvpFxog
	 XxxvegegcyfD+kjrsilRbowaYs21edmABok1uZBSoPp3MOx04cwKENVKPz/RiChszx
	 Gw5x5COXOAcV9Lj5mfi0GgkU//GVUJSROAeaXGcAO+k/z22cxLJzWPb4lHY7LjZ1pw
	 P6Sboxq2rOJvQHExMKdhTqxeJW+VG49igk6EVGKMxTWWSRjAw76WL7dWE7npf90Hn5
	 TAZ01soe6DIEGorbb1Il8Fp+soQGZR4w3QipthwM6OIzOqVBkRyV6CgcTQaH9eMQVw
	 t/r8CTx3NigTQ==
Date: Fri, 24 Apr 2026 04:00:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Christophe Leroy <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, Lukas Wunner <lukas@wunner.de>, 
	Oliver O'Halloran <oohall@gmail.com>, Saurabh Singh Sengar <ssengar@microsoft.com>, 
	Shuan He <heshuan@bytedance.com>, Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 00/24] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260423183940.GA3350984@rocinante>
References: <20260423172200.GA2271460@rocinante>
 <20260423182359.GA33696@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423182359.GA33696@bhelgaas>

Hello,

> >   Sashiko's feedback:
> >     - https://sashiko.dev/#/patchset/20260422161407.118748-1-kwilczynski%40kernel.org
> >     - https://sashiko.dev/#/patchset/20260416180107.777065-1-kwilczynski%40kernel.org
> >     - https://sashiko.dev/#/patchset/20260411080148.471335-1-kwilczynski%40kernel.org
> >     - https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40kernel.org
> 
> Thanks for all this work!  I think this will be a great step forward.
> I assume you've probably looked at the sashiko feedback and concluded
> that no changes are needed, e.g., the feedback is out of scope for
> this series?  Your thoughts there would help me out.

The only actionable feedback would be to update commit message of patch 18,
so that it mentions pci_stop_dev() rather than pci_stop_bus_device(),
something we can do later.

One could also drop #if guard from the struct pci_dev as added in the patch 9,
which is later removed completely anyway.  There is no ODR violation or ABI
break there.

We won't be fixing any more kernel lock-down issues at this time, and the
value of legacy I/O space size (the 0xffff) is something that was there
from 2005, so not something this series introduced or changed.

Using HAVE_PCI_MMAP and/or ARCH_GENERIC_PCI_MMAP_RESOURCE to stop the
resizable BAR resources from being included on platforms that do not
provide either, like Alpha, should not be a problem.

So, no.  No serious issues there.  But let me know if you want to change
something, so I can send next version if needed.

Thank you!

	Krzysztof
