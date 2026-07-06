Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DD3BADA2;
	Mon,  6 Jul 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360780; cv=none; b=NGp+KYPQ5sWecfyUl7iJJw4VCzzL0+DW7e0lvRPr1dkP0ZyM2dV29yDBJSQcxeEvtL53MKJJis5KqDtnff8cqCFe9vZQEenI1Dxbu1jStnklr6UgJkHL9AHehx/Dm3+DGTS74FrVpiqHZUsDKq60v7pPG2cSfTFX0rY4tN+wwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360780; c=relaxed/simple;
	bh=WIYEhUw3d4RKjlE0gxYRgjzRAxb2z61qwjDGfTaBUZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPpY7cmdK+sLP77jMh7XreVcpomXm5AaXH1j2Xad6JSKifof3H+wx+xLspGH5qTvWQSlwY1hI9mUSPp2mpJ5rY0t57AyaSb/GA0YMR8Rqm/MqC8Itjc9gcOh96TT5mLjD8jE6TRxyT19TRgSV4d6B6dvJTurTwX4F72tLUnSgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e14/gzWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e14/gzWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCFF1F000E9;
	Mon,  6 Jul 2026 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360778;
	bh=HmJC/8vvDL2HoOKSt77yU01Xd8+oFpwXQVS5MUC1ip4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e14/gzWo6xW3YOVH51Kits+m+wP2GGjgCPTFCZzuQY2e4zbXL/oW0CbOJFthhXV6W
	 TH/fIo4ygI1HJ2OEZJ+m8tmUalcJDi+rjiPiAAU6xkaqavP3GELwrAB/tugOUc6nm0
	 pOxxaO6ql7oe0jGraejMO3iq+bl2FyOjkcYRL6+/8L7Z8WD78Kp+gHBD8R5kCGA0xM
	 W0u6YoEvDio+HO1z6tbnV8plCvPwugzTqZFAzPUPINGUlOSK1DU4mEJIpV6awT4/2M
	 rXLjKkIyroNo3Q5IPiKbUzUThbfBGIa7YUUeW513KasCfefHfz065nMGrxrDPQfjs3
	 aQJA7FFNz4K3Q==
Date: Tue, 7 Jul 2026 02:59:36 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Alex Williamson <alex@shazbot.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Christophe Leroy <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Dexuan Cui <decui@microsoft.com>, Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, 
	Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
	Saurabh Singh Sengar <ssengar@microsoft.com>, Shuan He <heshuan@bytedance.com>, 
	Srivatsa Bhat <srivatsabhat@microsoft.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 00/25] PCI: Convert all dynamic sysfs attributes to
 static
Message-ID: <20260706175653.GB265195@rocinante>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>

Hello,

> Changes in v8:
>   https://lore.kernel.org/linux-pci/20260508043543.217179-1-kwilczynski@kernel.org/
> 
>   - Renamed the generic resource attributes from dev_resourceN_{io,uc,wc}_attr
>     to pci_dev_resourceN_{io,uc,wc}_attr, for consistency, and cleaned up
>     resource macros definitions.
>   - Changed resource macros argument order to fix checkpatch.pl
>     complaint.
>   - Added two new macros, pci_legacy_resource_io_attr() and
>     pci_legacy_resource_mem_attr(), used for the legacy I/O and memory
>     conversion instead of open-coding each struct bin_attribute.  No
>     functional changes intended.

I will send a follow-up patch with the above changed, mainly to
clean the code up, as v8 didn't made it in time before the merge
window closed.  There were no functional changes.

Thank you!

	Krzysztof
