Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E32B47CA82;
	Thu, 13 Aug 2026 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625482; cv=none; b=dz1VmQYkhmBVAGJA3gLbSEcNTxAPFpdzwGyXrlAtY76ODBoF9ZPLmodQXExdjcTjvJtNO8sGsnp5ftrZZzgiFpDGXmauCRHCQ1eJhj0kkmVgjGulfAVeO+RGVhSTzEFDATO7tuVy62aVXPALEnK0/a0noMQZ9Hm0hmXd7ksAYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625482; c=relaxed/simple;
	bh=COYw+m4edrtvnTr47kSjz/5KjVYwr6GZaP9Wh8wq+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpriHP/TpTZRiJWVui0FsQ/CtsrEm0VpC3HjnmZgrGMmw/zwcP8gEE2lAaUMqKSCHt4jujiALRbuz5SJA19VxmgDC7z/b1/NkESCOjglX6nK80zKblH8ciEL6kJF1XRLmpCCVISVKSq6wgsScwIV0ce6QK8CnUt4x27zlB5UU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfMA+qDx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfMA+qDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC51A1F000E9;
	Thu, 13 Aug 2026 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786625471;
	bh=3O+x1tQC4io2ZPnXiOKe372dKcdRSTco449QzH4pctE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IfMA+qDxwJIjxNDooNSAbWLXIu6+pzV2RL5cvh7SCcaMIMT8s8IQwtAv0bD5Z1FUi
	 NRYNCyWgjFUWI7giKh3zg45izpsm6ZSuR4VlH/oV8Ibo5w99RFw3HfLfprhbR44llJ
	 AEtGU2NFuETMOU1TUt/orCQrEWGUlB0YW7fVff8u4BknzFqBCiHbIJVLKRwdsj1BVF
	 aAd9kWXUxauNEIZKUlcZGmanqYlvlXrjobRHSCw7+I8oItWWuu55wPbwMtL5kYXHiU
	 4KC+lP7jkSk6TDNVLl1LxJXC78JAlgyqlip8cHd9IvFwkZdAR/s2cOq6b6vr6UUwoP
	 65C+lu/cj88Ig==
Date: Thu, 13 Aug 2026 14:50:59 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 00/10] PCI: endpoint: Add PCI DMA endpoint function
Message-ID: <zoed4wtc4oxiyni4o5qpj3li3cmlyy5kfutp4r5g4d63u52625@j6rvbbehjgov>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <an2uf5mXzGq1Q7cj@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an2uf5mXzGq1Q7cj@ryzen>

On Thu, Aug 13, 2026 at 01:46:07PM +0200, Niklas Cassel wrote:
> Hello Koichiro,
> 
> On Thu, Aug 13, 2026 at 03:37:47PM +0900, Koichiro Den wrote:
> > This is v7, the remaining patch set for PCI endpoint DMA.
> > Parts 2 and 3 were merged per Frank's suggestion.
> 
> (snip)
> 
> > One open question is how to support endpoint controllers with only one
> > PF. Keeping DMA in a separate EPF requires multi-function endpoint
> > support. Folding it into vNTB would work on single-function
> > controllers, but would also couple the two implementations. This series
> > keeps the separate EPF model.
> 
> I see all the work you are putting in and I admire the effort.
> 
> This is now v7. I think it is time that we close the open question by
> waiting for a reply from the PCI endpoint maintainers' opinion on the
> design before continuing. (I am not a PCI endpoint maintainer.)
> 
> I understand that you want a common DMA abstraction, that can represent
> different (embedded) DMA controllers on the endpoint side.
> 
> But if vNTB is the only consumer of this, then why not simply embed this
> DMA abstraction in some BAR exposed by the vNTB EPF?
> 
> Looking at the host side driver that goes with the (v)NTB driver:
> drivers/ntb/hw/epf/ntb_hw_epf.c
> 
> The BAR layouts are hard coded, and it only supports three different
> layouts. Would it not be possible to add a fourth layout that has the
> DMA abstraction somewhere in one of the BARs? ('BAR_DMA' ?)
> 
> 
> Right now, I wonder if it is not a bit premature optimization to create a
> DMA EPF, if vNTB will be the only (ever?) user.
> 

Yeah, I feel the same. I haven't seen an usecase to program the DMA controller
from the host outside of vNTB. This feature is supported mostly because it
exists in hardware and someone wants to tick the checkbox.

Though, I'm not against doing it within vNTB as Niklas suggested, but
generalising it in the form of a new EPF driver just for the sake of a single
driver sounds like an overkill and maintenance burden.

Sorry for saying this in v7. I've been meaning to say it, but somehow ended up
procrastinating too much.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
