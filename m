Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5174D373C13;
	Fri, 17 Apr 2026 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422821; cv=none; b=f9cyCZ9u8XFfpI+EQSrCWncPggKm4H/3+8adHBOMhqiTrXNXSKBu526hCeO50U1HwjkHJ3lgP/UBc0dSNUQnNV+5iDVzdpRqMARVY81Mr9GaeFt1Hwj7BHxc1XXgZmC/hrHo6E+7zotTEKHcqQrDecjOubEGht4oIEoSECj2XhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422821; c=relaxed/simple;
	bh=UvXWZOvTnm0NWz5LK6R3oW+P9THcCFDgcoMJOmweRAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt7VD2jJok29HrqTtviyhMomzDVJDl+XDEo+urWon/F99cXrbmmGyWsDGuP4IpiKEqOg9Xm5hRZYY3r9x6uuAtsmvfJlDHm2iRDpC7MzeQBNRugU2QTRXBGtSI2zR26aBOBK3ngavDFK0M6Y3l0P59d0e5mxYtPXlpla5+c05VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbioxR5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbioxR5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84137C19425;
	Fri, 17 Apr 2026 10:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776422820;
	bh=UvXWZOvTnm0NWz5LK6R3oW+P9THcCFDgcoMJOmweRAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbioxR5P1H0eF61qBn8Ob0PRTqf0B9BgcBoGvCOTg04M2A//ev5+VYJo7I34HDr1H
	 NAkPEB0XOaKIyy+nIOG15M285LES5Qfix3M/58yNHhe1+tc41NPjmqLO9arGKANGMx
	 TnGh8Zhtryjc05fOxnUvgP7IJHyJmT/Ip8LUNrR1Zym8q7Dwh94aTst8QV8DJjuBil
	 s/O9rUjVMIBmptz4Wp9kl8vPH0LdfHMHgZPjdI21c6d/c7/O0clSYIV2zwRHPNXMAK
	 LBGq7LBW9Cl7W6WkopP7gKKrWocPs3G71Ak7YUDbxnciZZeDhyoXB6xBAvf7R268ZC
	 xK7xWNdsuTctA==
Date: Fri, 17 Apr 2026 19:46:58 +0900
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
Subject: Re: [PATCH v4 20/24] PCI: Add macros for legacy I/O and memory
 address space sizes
Message-ID: <20260417104658.GA1625998@rocinante>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
 <20260411080148.471335-21-kwilczynski@kernel.org>
 <a73af6f4-9f9a-cff8-e00e-042dcf934708@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a73af6f4-9f9a-cff8-e00e-042dcf934708@linux.intel.com>

Hello,

> > +/* PCI legacy I/O port and memory address space sizes. */
> > +#define PCI_LEGACY_IO_SIZE	(SZ_64K - 1)
> > +#define PCI_LEGACY_MEM_SIZE	SZ_1M
> > +
> >  extern unsigned int pci_flags;
> >  
> >  static inline void pci_set_flags(int flags) { pci_flags = flags; }
> > 
> 
> Shouldn't this also convert the use in pci-sysfs.c (which you now mixed 
> into the static attrs conversion patch)?

I took care of this in v5.

Thank you!

	Krzysztof
