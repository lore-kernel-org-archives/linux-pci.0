Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648FA494837;
	Thu,  3 Sep 2026 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435858; cv=none; b=qC4ZKnfxNi+pfn7c7MRYNAK5kv1tnp8kLILFtSyXWxcb3Vp1r20AnyeYIUNO5bA+BKJI3uaTo481o6U0DnzLJxx7BGgEjtk6bCzPc7DI+xhk0afZyYW9sQbFs4o/HARcaIUA2XsqOXZB/7So5viOwZJvrWm2QvE+xF7ElaCYMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435858; c=relaxed/simple;
	bh=LRisX9749KEe+T862sebyxGNqP2gIRWhDkwDZe+zK0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhikAYk3dYpf7Il71h7kMlF6in9G1Ejz11fZ2NnD+i4JmB9mJDIiWM4BQ//c9HcwDyAVE/XOiqJoKUB6TZRy8K+vQbPkRTS5Gdtt1wyJLoo6nXa0gDJWPAHIkLa6Uxv271MM0WT//JpNrjm68V8PkXzjqwWHJw2baCT1ivo1D6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbvjJPeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbvjJPeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F0A1F000E9;
	Thu,  3 Sep 2026 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788435845;
	bh=g4XqGFwj50jJWj8AMgHJo4hZekacOP7V5XKmmlInz1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EbvjJPeJl/yZ8EUmVA3kz/lUoFH9rfuVYIl4VgvBd5ihsvGIoar2oHu0XG6OCnPcm
	 Jg16u+Qzj3bnbOcjRugYlbWudWdQd1c5d3xyJygtP3pih6rjri/9MjGlJ45BIuyFNc
	 6ryC2R7QDyXlOdXNvGccui6NUBFbxi6HroAaMA0TX+MM316n/OSd6MckE67BPv3hrg
	 rir//Vu8NiHNJEC8nUBjHXqbVN5nOmQsDs0eiPvJ2nZERrBO16JRB8ZEFuOqAgJqBd
	 vz0o37PihhojddHf7rXMaLAFzyCRak/32u+c6eR7HHBvhzTuafLIGVi6cgWDbG8cCQ
	 THWWkZU8Ypmhw==
Date: Thu, 3 Sep 2026 13:43:45 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v3 0/7] PCI: endpoint: Remote DMA support via vNTB
Message-ID: <4k22ipcaw6hy3va2z6nd56zb35kbcx63tfgk4tyuz5jifd6a3v@absanor6e2vp>
References: <20260831182657.329614-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831182657.329614-1-den@valinux.co.jp>

On Tue, Sep 01, 2026 at 03:26:50AM +0900, Koichiro Den wrote:
> Hi,
> 
> This series lets an RC use endpoint-local DesignWare eDMA read channels
> through vNTB. It keeps the export within pci-epf-vntb and ntb_hw_epf
> rather than defining a generic remote-DMA ABI or using a separate PCI
> DMA function.
> 
> On the endpoint, pci-epf-vntb reserves the complete eDMA read direction
> and exposes those channels as a group. HDMA is not yet supported,
> keeping the series minimal.
> 
> The DMA feature is opt-in through the pci-epf-vntb configfs attribute
> 'dma_bar', which is -1 by default. Without it, no DMA extension is
> exported. pci-epf-ntb is unchanged.
> 
> Base and dependency
> ===================
> 
> This series is based on next-20260827 (3d83758432b5) plus:
> 
>   [PATCH v2 0/3] dmaengine: dw-edma: Prepare channels for remote use
>   https://lore.kernel.org/r/20260828163611.2691264-1-den@valinux.co.jp/
> 
> The prerequisite is for the dmaengine tree and is not part of
> pci/endpoint. linux-next provides a common buildable base for both
> series. Once the prerequisite lands, this series can be rebased onto
> pci/endpoint.
> 

Just to make it clear. This series has to build time dependency with the above
mentioned dmaengine series, right? The above statement is not very clear.

EPF patches LGTM! I'm waiting for an Ack from NTB maintainer for patch 6.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
