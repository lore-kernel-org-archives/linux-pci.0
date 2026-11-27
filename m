Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791593;
	b=Dgz07O0oE8hchY60400GUEssk3nAssnCYJGBsrI/7X4jGxS0opmM8VxbqhjscLY/lz9s
	 O4/757CjPMbAm2dFkPiPfjlt1gg+UTIN+rOjqZO1oD/Hdi818BMoIe8k1w4vikEFFSIIJ
	 DOW38B6ts8G9yk1H6FMKMy/K23yz88NBAJKISAx9TJjlAFTdb/fLZ7zLDw+MuxuTY5ucd
	 SmZllPn1dJEq0NJgGEnakN18jD8vxvRg1JjuD/xGJG+X0JzWLcCqer/W+sbzpvknKppvS
	 +iQR2kgup5gvvrfzpiuDpdf+vUo6wVoKfiwuipsYXu/+7D7Xd/0oiDAN3oUQ/v0cA2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791593;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=A5fV593E0Mw/SjQHnQBwvOm5vTj3BFromH+oXEc/3Zs=;
	b=yJcKi+LOtHVzD2m3EJd/QFTH3/t8jHDvkdMQVL00tK5K78g9uuSW6eAgX2Xr85Ng1M21
	 eJZxTjpnJQ1s+1DGMpuHJ4sXV3ZKmdjbbxbDe1eHI10mRRMhXgOOxO+gwAqW+YYxF3A7p
	 epioQ/lIFM0YhlLCfcHCz7PNLQvBf/5W3vtabPOQn79Y4DGGWOPK3ysBMn/0DfN57/LLS
	 ISDAIjcLtVnI+7kqjYxt7l0YRjBqrclJ1XJSEbPs34yLI9bkyAQXfXUXWwM1DdLaG1QYR
	 81Xnz/5qdt8Ou6ZOW4bh8gKzUNvVqvBGHBdVxbJ3PwURBE/55CiMHr11XSpzSF7JFjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="5Ghgn/W+";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F24606A321;
	Fri, 27 Nov 2026 14:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48F24606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5Ghgn/W+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=A5fV593E0Mw/SjQHnQBwvOm5vTj3BFromH+oXEc/3Zs=; b=5G
	hgn/W+la7fRBDv8ah1WAPaVzWPrMK6tztJqzgvvHtqyr7cfS8ZkKAcNbloTrVss4xSHRDeuxRBPRE
	7C0HqWw4RKPhf1RKIKnbSC+2DcYIC66xzIwaPchuHL8lFBP1jRSI+nXOkCK1gSVLNy/dljEFBhrK6
	P+ib87vhHugIDEA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xWxQG-001ocO-NO; Fri, 27 Nov 2026 15:59:36 +0100
Date: Fri, 27 Nov 2026 15:59:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hans Zhang <18255117159@163.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, bhelgaas@google.com,
	mani@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCIe host controller async probe vs PHY request_module
 deadlock
Message-ID: <582bbeb8-13ec-4533-92d4-7216c20fb78f@lunn.ch>
References: <20261127074329.747914-1-18255117159@163.com>
 <00ca72a9-ff50-4842-8aa9-d68416212e8b@163.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00ca72a9-ff50-4842-8aa9-d68416212e8b@163.com>

> Andrew suggested：
> 
> drivers/pci/controller/cadence/pci-sky1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-sky1.c
> b/drivers/pci/controller/cadence/pci-sky1.c
> index 82f4ae5c04a8..4448ee3d5e73 100644
> --- a/drivers/pci/controller/cadence/pci-sky1.c
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -235,7 +235,7 @@ static struct platform_driver sky1_pcie_driver = {
>  	.driver = {
>  		.name = "sky1-pcie",
>  		.of_match_table = of_sky1_pcie_match,
> -		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,

Sorry, i was ambiguous. I meant the MAC driver should probe
synchronous, not the PCIe bus driver.

I don't know the details, but i assume this is some sort of tree, and
a list. The root node enumerates, and adds to the list of things to be
probed. The device core then has a bunch of workers which take stuff
off the list and does the probe. Those probes can add more things to
the list, and it works its way down the tree. The first iteration will
only pull jobs of the list which have PROBE_PREFER_ASYNCHRONOUS, so
you can prevent branches of the tree from enumerating by setting
PROBE_FORCE_SYNCHRONOUS on the driver at that level in the tree.

So i assume you can mark the MAC driver hanging of the PCIe bus probe
to happen later, while other sorts of PCIe devices probe async?

   Andrew
