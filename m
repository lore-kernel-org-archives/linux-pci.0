Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795297914;
	b=z9bACnFQwz7mfLpW/zIKnf52r+mgVC+0GCSz7yBJdrxs9uXHz1hqXjWCKs3e6qsWzsaR
	 6IFD7oFvfwxt6WpkJvsjd1TvI0mxV9Dl4YPY/Psi5FlmbRDhePmzyIXhtI4iHC8f3oXtm
	 /9B3/rac84+M3dgpKJXP/fAwKdMt5UdKTzriSgEOOnL9z4yTLYs7D9TUy8WpLTRY/cNaP
	 XRTwkBcP/N8pjQJ+ku+O9w32iGrHZLU87Hs0yIOZ0TLJy0gcLQjbwOHUTpyUFoiy4phoq
	 lgA64NKty67m7sHCSqWnoybwk09yYINqbUGXAM6xhJZYNrgQITpFgZAO+UYd7BVgx6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795297914;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dx3iVKfOneAEsbu4rNol2f+GIC5slUE4ng1KtMYBoXo=;
	b=WeWSmiA/dJBrahMqg1o7asGvPGb+DjHLHGRrl+RTuTY014AKwjLmHcIoY4f4JsiKqM0k
	 IkCjQ8jLezJ5h3TAXhH2thwBpTxpGWRWhWwckS0L1M5AX694J/K2ShfIC6C8pZo2EEenI
	 hFN4oVHbD05yardMY+93VZBhRGxkOXqAfFfc0BG94Bhh/4TndBcYPPcentlfAzW+WKLtf
	 +1mof8Ort5wXI5BOzQqwYQ2jpG4/+gG0/5JCyJTqdKf13+ebrKgb19ONvh1k7d+eTlS9w
	 +qR9H2v0LCNEUqqmvyUin6MXBSu50a0hNNrdbEBFvnET/qvBuGHK3fc3j/4NqI5mSMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D77606A320;
	Sat, 21 Nov 2026 21:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90D77606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 40D743B0;
	Sat, 21 Nov 2026 22:51:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 238CB60A568C; Sat, 21 Nov 2026 22:51:44 +0100 (CET)
Date: Sat, 21 Nov 2026 22:51:44 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hongtao Zhang <zhanghongtao35@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, mani@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	liuyongqiang13@huawei.com
Subject: Re: [PATCH v1] PCI: Make PCIe link wait timeout configurable via
 pcie_link_timeout=
Message-ID: <awIScN3rXFv6v9x2@wunner.de>
References: <20261121110806.1158344-1-zhanghongtao35@huawei.com>
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
In-Reply-To: <20261121110806.1158344-1-zhanghongtao35@huawei.com>

On Sat, Nov 21, 2026 at 07:08:06PM +0800, Hongtao Zhang wrote:
> PCIE_LINK_RETRAIN_TIMEOUT_MS fixes the timeout for waiting on PCIe
> link training and link state transitions at 1000 ms, matching the
> PCIe spec's minimum recommendation for declaring a non-responsive
> device broken.
> 
> As hardware evolves, some combinations of newer devices and newer
> boards may need more than 1 sec to bring the link up.

The code adheres to the spec.  If certain hardware doesn't adhere
to the spec, that is generally handled by adding a quirk that sets
a higher timeout for the specific device.  If we'd provide a way
for a blanket increase of the timeout, it would disincentivize
reporting broken devices and submitting patches with quirks for them.

Thanks,

Lukas
