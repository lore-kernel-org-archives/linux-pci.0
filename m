Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894C33A9FE;
	Mon, 24 Aug 2026 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605700; cv=none; b=RX4zm3oAm5gHYdYRAN7Z6Iw7f+47GnXx0UUiCTLUCZJletuL34o5lgytiYIQ7STlyY/M1PAQN/Bbj8uTxZ9Dyf1rlwyf8Cx7pm3SicpdeNPYazWngJxcEWjqzXbLk7t/Ef4aEphutd/esDBFwgVqoIYtO53+n0yK12WAKOfG3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605700; c=relaxed/simple;
	bh=l8I+S9y4BKMpZ/Y9Pvym3mb+rgUfggvWVJJBECIvn58=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=WBsSXS9xjdjIc+HoQ3WsyVXApwwUqm7xh5qOd+pL4Z3gXkQ5sYnCZxkOCfzyBkZOt/f//8ZIrw/6naAfcZMIfHwchVrF3gH27JbLg8fgR8iQOlhFNp+2egcwvsdwNnvjbP8RC+QodGxUgfW4J2e+TQCMxhLK075rX8xT+FDSHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Ew9/QkpD; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Ew9/QkpD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=WF8EC2mFbNXoLTZj2YF3+N5Uv2mpjuhJFHeVK5S2Wgg=; b=Ew9/QkpDEziZ9MGMsFjj0oWU6t
	M/0Pfw4x509w2ymBfz8xFzNbu5WiSd6El2HYsvaFG99GCCD99kBfa7BwG47fB5VRmJj4ONS/A/ua0
	INg7R7MDXlOTyxRa+3x9JepG6g6XWaQwZO49vDztuswNnL+1RCVTpOTqkJhA7bTnnq2gqJjIPC2H1
	0ew4MYFM4UxA85DFa/rT3gJjE2kO+swcvx7U0d6ed4e1jGTh0dc0h3+noqZZ+x2eCb26u64PRPvEE
	mp0arshtYPutFCqf0Tfu7yc0NJUxq/WN4hwUoSvvrp2XRrHZ2xSHdMnfCR1GXq1nNxJALzkDtnnFQ
	GJnUmbuQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wybtu-00000005a3P-20sR;
	Mon, 24 Aug 2026 15:08:15 -0600
Message-ID: <87700873-1e4b-43a3-948b-c6e84ed11f5a@deltatee.com>
Date: Mon, 24 Aug 2026 15:08:09 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-6-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-6-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 06/18] PCI/P2PDMA: Gate the host bridge whitelist
 warning on verbose
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> calc_map_type_and_dist() prints every other diagnostic under its verbose
> argument, but reaches the "Host bridge not in P2PDMA whitelist" warning
> through host_bridge_whitelist(), which it hands acs_redirects instead.
> A caller that asked for a silent answer still gets the warning whenever
> any port on the path has an ACS redirect bit set, the CPU is not
> whitelisted by cpu_supports_p2pdma(), and the host bridge is not in
> pci_p2pdma_whitelist[].
> 
> pci_p2pmem_find_many() is such a caller. It sweeps every device with
> published p2pmem and asks for the distance to each client with
> verbose=false, and pci_p2pdma_distance_many() recomputes rather than
> consulting the map_types cache, so the warning repeats on every sweep.
> 
> The argument was never meant to say "ACS redirects were found". When
> commit cf201bfe8cdc ("PCI/P2PDMA: Warn if host bridge not in whitelist")
> added it, acs_redirects was a bool pointer that the quiet entry point
> passed as NULL:
> 
> 	if (verbose)
> 		map = calc_map_type_and_dist_warn(provider, pci_client,
> 						  &distance);
> 	else
> 		map = calc_map_type_and_dist(provider, pci_client,
> 					     &distance, NULL, NULL);
> 
> so the argument was true on exactly the path that commit describes.
> Folding the two entry points into one verbose flag turned the pointer
> into a value and left the call site alone, silently narrowing the
> warning to paths that carry an ACS redirect.
> 
> Pass verbose. This also restores the warning for a verbose caller that
> takes the host bridge route with no ACS redirect on the path, which
> until now was told it could not use peer-to-peer DMA without being told
> which vendor and device would have to be added to the whitelist.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: d1b8dc09dd71 ("PCI/P2PDMA: Simplify distance calculation")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Took me a bit of effort to understand this history, but I think the end
result makes more sense than what is currently there.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

