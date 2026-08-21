Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266A37F00C;
	Fri, 21 Aug 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327726; cv=none; b=UivtsAk/ilXsmKZFY1Mc4UcbxkSGl+W7383HdEC4T58RFBsfDPCEmeRJIfimvNcNVEvtOqNU0ontpJ1RmVCl5YThhOsDxQUV0sT2EvaOWG/iMm8OopK0r1A4ROh8H83F+QFAsNlzJjZ0fq4QUveSC0182439eGEEqREHBY1gdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327726; c=relaxed/simple;
	bh=IWD0anpHPIrSXgefg98fwbVAdd7ldj/veFEIyS3xUlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJeNBJ2zFP9l5812FzLKmqZsBLy6R7OuJikBX6UDQOyk8rIC2CNNXWYaEfcnd3iZ5ObrvzM8in1BUWmNunqHAi/9yAcqu5WcO3PSmlJX86loEXjyAuMCGzVmLTDu7IrT+jBvIxPuPRSQocuzOV8HsKvKje+IcFJe9DKeBWk760w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxNw3ZjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxNw3ZjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6F11F000E9;
	Fri, 21 Aug 2026 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787327725;
	bh=+9b6rcYTQfmuI25hk8HLbuGADKmBW8CvR7tONpt3bF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NxNw3ZjZPfbOuTEcjj0JZiH6OzfbuBDq5dhc383ylCUBaOQ7NSmGtSReLGoIgG3Cx
	 8JitLJnr6QH0HTmXLmWWYGGxS9+pKydqM6eGUkkeFgGrnD0FG+tXrMnlQ7ksbh4aUI
	 dq1lu5g0HSwhDzM3VqMAj16I29ZjnkWY+LlLNv/VKqb4N+5n7H4ZLJtSNR3MJ0FfbQ
	 tjO88wMUm/9kF+yOTKjs2yr4hcG0+yw+AwT6YxnhOeA4EHeUpLfZTSPpkI+v2HWbeU
	 r1+KoEjrSanpqYg/yXsBiPi+bxgb/rOLNhLXqtbhH8m5FYVKjaAIDKFhWGBRzFsGZY
	 zf7E7YK/dfpJA==
Date: Fri, 21 Aug 2026 17:55:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>, Vinod Koul <vkoul@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.li@oss.nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <aoh05fY66kKxvxqD@ryzen>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
 <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
 <ztn47y23ctbjrbkmgyyhc6d5x3i2lzz5txotpgtbjtcsvbsvf4@fzadsvt5fl4d>
 <an3p_j-F10e9x0vM@SMW015318>
 <7kzvkrbc6w7yojufwekzjubndgg4ao2o65gnla6mjwhwn5ji2d@vhrj4kg6uia2>
 <fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh>

On Fri, Aug 14, 2026 at 02:57:12PM +0900, Koichiro Den wrote:
> On Fri, Aug 14, 2026 at 07:27:10AM +0200, Manivannan Sadhasivam wrote:
> > 
> > Testing is one thing, but using is what matters. Are there any products or
> > use case based on remote eDMA? Or even dw-edma-pcie.c?
> 
> My end goal for this work is this series:
> 
> https://lore.kernel.org/r/20260810165136.2292436-1-den@valinux.co.jp/
> 
> It now depends on the PCI DMA EPF. The host side controls the endpoint eDMA
> through dw-edma-pcie for one direction. This is for an industrial use case, not
> just testing.
> 
> The resulting ntb_netdev/ntb_transport improvement is substantial:
> 
>   (unit: Gbps) (UL=EP->RC, DL=RC->EP)
> 
>           UL UDP  DL UDP   UL TCP  DL TCP
>   ------- ------  -------  ------  ------
>   Before  ~0.6     ~0.6     ~0.6     ~0.6
>   After   ~19.5    ~17.3    ~12.3    ~10.8
> 
>   (On R-Car S4, PCIe Gen4 x2, controller IP v5.20a, eDMA)
> 

You have an industrial use case, and your performance numbers show that
remote eDMA can bring great performance gains for your use case.

I don't think anyone is arguing about that.

At least to me, the question is if you need a new PCI EPF driver to implement
the code for this use case. I think the answer is: No, it is not strictly
needed. You can extend vNTB EPF to support your use case.
(As that was your original approach.)



The question how you should test remote eDMA is a different question IMO.
I'm not an expert, but from a testing perspective, does it really matter if
it is the host or the endpoint itself that programs the eDMA hardware?

I understand that you gain performance by having the host program the eDMA
directly. But.. from a eDMA hardware verification standpoint, does it really
matter which side that writes the eDMA registers?
You should be able to test both dma directions, regardless of which side
programs the eDMA hardware, no?

I guess what you mentioned earlier, that the existing pci-epf-test tests
are not pushing sufficient concurrent data to trigger certain driver bugs
when multiple eDMA channels are used.

I guess you could have a test suite that does whatever you did to uncover
these bugs... vNTB + iperf? But I guess it could also be interesting to add
tests that push more data concurrently, such that multiple eDMA channels are
used. To me, that is basically what dmatest was designed for...

Yes, we know that dmatest is currently not a great fit for DWC eDMA, because
dmatest uses different dmaengine APIs.

I think Vinod is best qualified to answer this question, but I guess the answer
is either:
A) Extend dmatest so that it can use the dmaengine APIs to fit DWC eDMA.
or
B) Write a copy of dmatest that is tailored to hardware that uses the dmaengine
   APIs in a similar way as DWC eDMA requires.


Kind regards,
Niklas
