Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96A2737FC;
	Thu, 10 Sep 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053919; cv=none; b=T7fB0TmBK8sqc82T+2cRsSfKM9C5TsK0JTfY7OLm8ZVq9t184TAFdsLlD7Pa20fWArfp4bMKiwTjvG5D0cZcEPr+78jEyaF1NxcIp1v9WDeU9ZSTuPhoXz1q4Zm1qcT/LECTmi+OXoIx2C+s03ncLP5haseKSdH+VE7GzLRGBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053919; c=relaxed/simple;
	bh=vktYA/pLE/Uk7TLDrUFPnAYTCTQTQwc8vglCQBHe+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnY+4Ju33kk17faZ36hre5mpSurqzQId9hQWkL1Cq7eLxMmTHL+cTg99SvIFpWMRI4FR2C4PAv4vbR2gsmtYIFmJJNm9UAkKXY17dfX2aGXkUbMJgggOdujx8fjVulYGTYH+1aTCiHmxwl1czbDwxqlYV4DMq6/51Cyj/us3Mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQd4j3Ks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQd4j3Ks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9241F00893;
	Thu, 10 Sep 2026 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053917;
	bh=w3RRJuuctzX6sMBHJVymNiLfogH0RAWrORKD7W2Ej8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nQd4j3KsNTu/88H/Lf6B541sDwj4aPK6ECgkoSl/ZHcXZrgiMPgRN3xMl8ujdGC9/
	 Hqcw5t8IxyFTmczNRlaWVPUXChSh5YUm1al2phPAKXd2iqbd1vwnlZEB9BveDxYJUr
	 +4t2W4jlYHPuQT0FSHyibiyrn71UXeDXsUT3IXjUS89ADEzsE2dsruJznFOzsXv6ba
	 P+GdMp10HyhemGcwJllwBQTkBBuEx39dfaI+lJTLfTWcqbsOlamTplr/BIDoakFs2P
	 wTJbME577uQ6xyxWIFMutbhHFTgrMh9GuCES4CaiBekj03KytMQBAPiSi1zl+onK6M
	 XdrOvG5ZmZLIw==
Date: Thu, 10 Sep 2026 18:25:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tushar Dave <tdave@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 5/5] PCI/P2PDMA: Gate the host bridge whitelist warning
 on verbose
Message-ID: <20260910152514.GT13683@unreal>
References: <20260830-batch-p2p-fixes-v1-5-5044e8dfbe2e@nvidia.com>
 <20260909021859.GA159841@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909021859.GA159841@bhelgaas>

On Tue, Sep 08, 2026 at 09:18:59PM -0500, Bjorn Helgaas wrote:
> On Sun, Aug 30, 2026 at 02:16:23PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > calc_map_type_and_dist() prints every other diagnostic under its verbose
> > argument, but reaches the "Host bridge not in P2PDMA whitelist" warning
> > through host_bridge_whitelist(), which it hands acs_redirects instead.
> > A caller that asked for a silent answer still gets the warning whenever
> > any port on the path has an ACS redirect bit set, the CPU is not
> > whitelisted by cpu_supports_p2pdma(), and the host bridge is not in
> > pci_p2pdma_whitelist[].
> 
> Not in this series, but I would like to see the "whitelist" term
> removed from drivers/pci.  p2pdma.c and pci-pf-stub.c are the only
> current uses, and I don't think a change would cause any API issue.

Let's do it after the "Fix ACS ..." series, please, just to reduce the
number of rebases on my side.

Thanks

> 
> There are similar "blacklist" uses in pci.c, aspm.c, and vpd.c.
> 
