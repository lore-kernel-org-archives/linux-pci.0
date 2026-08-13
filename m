Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80CD13B5B3;
	Thu, 13 Aug 2026 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621575; cv=none; b=ARLu1e/lrwXRCJvFRRkqVrRw6Hvh1ogQ6S2PrJpEfUvjF+gG/9MAsUKrr5vP0uvzuH7vYXNpPgvF4fLfZa9/GQnxbrX2HDLAgIB5er1/TwJTcNG41i0cEcognSDrRyGTVHXg9vpF5GhF2O3dHg3YNJcYKhA3yKLw6vMQ8flHIew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621575; c=relaxed/simple;
	bh=ejCu1aTC2wcFIfrCGz4OYhU+SLf8uyUQhr3ScQ5NJKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi5AEq4s8Z8MHtsKA4YUe94OwNUNTcJCBVEIXAX52Ynj2YTssHoyX7OABlgphgKTCnzBTHNdgb1F5UJ+kJbcbkGBLuOk8ZoMMjoQjMKDdF2GAheBuzjeDtRf2xBIrzx6+Y9zsU9dw3rPLlad7GkMrF4KwpDU67vDYYBrr6rKLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8z91kM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8z91kM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1C11F000E9;
	Thu, 13 Aug 2026 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786621574;
	bh=ejCu1aTC2wcFIfrCGz4OYhU+SLf8uyUQhr3ScQ5NJKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T8z91kM8Vi62PkPE28D7Fyo9z16LHW1xkoX0JNwyTnDH/4JVRIIwJQAtwqCjK8T8l
	 z0kmLaxf1UifYq4mognRvz49YYceHW2U/UQC1qEfKaPLXsunemvzX20HwWRVobNv4n
	 9ieV1kCbxWun8wTU3BbmLleeV91VnMWmUVUmnPaykcMydMoSwcjYmzTj0CJGD8qFUv
	 TvQKEhJrGxcO0/l6JzfW3+3BdPGcUh5S/wnJga1jL2lgOzkoKBlAgDQMjTjP47Tpxv
	 rdled9kLROdBtfv5OCprIoZmqRdOHXUz7XcMg1oS/50N8+Zhz5/J2P+Q7aRukLZtok
	 uioX7qFrZh6/g==
Date: Thu, 13 Aug 2026 13:46:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
Message-ID: <an2uf5mXzGq1Q7cj@ryzen>
References: <20260813063757.3131865-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813063757.3131865-1-den@valinux.co.jp>

Hello Koichiro,

On Thu, Aug 13, 2026 at 03:37:47PM +0900, Koichiro Den wrote:
> This is v7, the remaining patch set for PCI endpoint DMA.
> Parts 2 and 3 were merged per Frank's suggestion.

(snip)

> One open question is how to support endpoint controllers with only one
> PF. Keeping DMA in a separate EPF requires multi-function endpoint
> support. Folding it into vNTB would work on single-function
> controllers, but would also couple the two implementations. This series
> keeps the separate EPF model.

I see all the work you are putting in and I admire the effort.

This is now v7. I think it is time that we close the open question by
waiting for a reply from the PCI endpoint maintainers' opinion on the
design before continuing. (I am not a PCI endpoint maintainer.)

I understand that you want a common DMA abstraction, that can represent
different (embedded) DMA controllers on the endpoint side.

But if vNTB is the only consumer of this, then why not simply embed this
DMA abstraction in some BAR exposed by the vNTB EPF?

Looking at the host side driver that goes with the (v)NTB driver:
drivers/ntb/hw/epf/ntb_hw_epf.c

The BAR layouts are hard coded, and it only supports three different
layouts. Would it not be possible to add a fourth layout that has the
DMA abstraction somewhere in one of the BARs? ('BAR_DMA' ?)


Right now, I wonder if it is not a bit premature optimization to create a
DMA EPF, if vNTB will be the only (ever?) user.

I didn't follow all the details, but I know that you want to control the
DMA controller on the endpoint from the host side. Is this really a
normal use case outside of vNTB? I would imagine that most endpoints
will read some ring buffer of descriptors, perform some validation on
those descriptors, and then decide if it will do DMA to/from the host.


If the host side driver want to make use of your "generic DMA registers",
then you are basically creating another DMA controller? Shouldn't you
then create a new host side driver specifically for this "generic DMA
controller"? It would be nice if you could explain a bit better why you are
bothering to create a "generic DMA layout", but then you are reusing the
dw-edma-pcie driver. This seems a bit weird to me.

Right now you seem to "unpack" the "generic DMA layout" in a dw-edma specific
function: dw_edma_pcie_validate_ep_dma_metadata().

If you want this encapsulation, shouldn't the de-encapsulation be done by a
host side "DMA EPF" driver, and then this generic driver will then call
e.g. dw_edma_probe(). (Seems wrong to add de-encapsulation code in dw-edma
for your own made up format. And then all DMA drivers would need to do this
same de-encapsulation.)


Currently, I know R-Car 4 has an EPC controller that supports multi-function,
but I personally don't know any other. If you could embed your DMA abstraction
somewhere in one of the vNTB BARs, that would avoid the multi-function problem,
so your solution would not be limited to EPC controllers that only supports
multi-function.


Kind regards,
Niklas
