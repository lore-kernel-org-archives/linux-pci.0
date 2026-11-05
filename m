Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914486;
	b=N0cQJFx1h1AM8FoHbvOrMQ1/CwI7BjbtN7VPJdjZI2Pog0D1qqLNOSWuLKItVHsu33EJ
	 ZF36eAeSXL3KNOfWUeuO8Q9CLrl9D/ed2pGacxiQ/K7B41jvJ4srnqSZZ42K0AgUjVSYM
	 DlIzMwXkYNZQCcxggE77Ivn0GLsVRxd8xuatqBJI0zH63HDsI5sd1AublkkLLL2BHP9rs
	 Y/LGM+7WkwAO0SPPg0b3RaAXUHgT9mGqJNXc6n2UGnDMaFpBfQ6a53lmoBR6J0h1UehBa
	 lDkDffz92MpUXD6rcmXFQk5XLRGoJXTwFMUFbFDriJfLog5mZ7WHlviQ8ZMxxr1ffhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914486;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xfM3oTZbA9GZfIiLkeTZfWkJk5oDQ4tBo9T8XwJOZPU=;
	b=AEJqMKAX584+/hVwmtj9rgWALO+xTZFE/IwAN+RiY4+BckBCibfDXS4WJMraxpMpupW2
	 PdYDTVqOm6d3B3A6Mp/Cr31QZq55AKRWh+ENX5Tw3QeS9szX5DdUa60fLhrTiIhLIpDIa
	 qGHrVckNNPnMVkl8bu46d/tRTFn3nqmgsSLXX45aLet+dMK4BPnLILspdAkMEQhN0X3Qq
	 3MyevnqopZBXKFKmap0YtBfJJf8dB/FzRTqY9pr6BfksrY1CPADR0CAQzuInDctqL/6so
	 +YgvEXNuRfFlurTKIrze9BfcawvLHvDHoTIWv3hW5IUvfFO2pCFSJG5s0ZzliPNgoGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EL3/zERs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C8606D807;
	Thu,  5 Nov 2026 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL3/zERs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896461F008A3;
	Thu,  5 Nov 2026 21:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914486;
	bh=xfM3oTZbA9GZfIiLkeTZfWkJk5oDQ4tBo9T8XwJOZPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EL3/zERsH+cbk7IV/pDuFDuqpTebsPKLJGaF5sFwfHJ2pqeVL98PBgNHgWNyA84u/
	 ECLQx00rP21PC3k2HGylRrt7lO0S6DluhRxAS+z9wYF0qMl4mGLKyAf/WMRv7VcLUS
	 n9RUd/Qv92d924lZUTbrtjeRSw1vlasbgnYveeTzeDEFcFyEJhg+X+m96p9sFJYq77
	 y5Tbn7sPUBKGk2eB1KMVHCZ9phZtsQwN9V9xOLTNRM7a3ApQyE4G+6jQcBgQcJkB4n
	 T/5LUXvkwtzW0808JaKfNJ/uukppKrBy+VksxTsQCYbyOFSTIpsg+FkPpoUgoxMRTV
	 oCAYZbG9eqZ4w==
Date: Thu, 5 Nov 2026 14:34:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, tglx@kernel.org, bhelgaas@google.com,
	maz@kernel.org, lrizzo@google.com, hch@lst.de,
	changfengnan@bytedance.com, namjain@linux.microsoft.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Message-ID: <auz2dGjVIBgiMNBS@kbusch-mbp>
References: <20261105182706.3700908-3-kbusch@meta.com>
 <20261105194116.GA1553387@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105194116.GA1553387@bhelgaas>

On Thu, Nov 05, 2026 at 01:41:16PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 05, 2026 at 10:27:06AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Skip the read-back that flushes the MSI-x mask write. Parent domains
> > that mask on behalf of PCI/MSI keep using their own irq_mask().
> 
> When you respin it,
> 
> s/MSI-x/MSI-X/ to match spec usage

Oh, sorry, the messages crosses on the wire so the v2 retains the MSI-x
syntax. I can respin it, but don't want to rapid fire another version.
