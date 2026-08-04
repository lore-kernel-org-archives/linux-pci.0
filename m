Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2123F6C3A;
	Tue,  4 Aug 2026 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880526; cv=none; b=JUYUqUga7zojtS+OVe/3kUuVPmG6y2boYB7MiJG4O5JfseGFUYpD0WrbRaDyx2a5GFtIdkVZgDjx2FXGSKTtRrEiyLrNNQccTLMGwgpPbGOQJ7qc6Qn9hr8bVOkhUY6m88Z/Tz9bmCGsQV+f9EL3LR0BF+DCJjFs4hjJrlY2puE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880526; c=relaxed/simple;
	bh=ArWBbRaQ7/lZELj8RsDbuShNnwKAqELRhIxTahqf1GU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=d0DsWkGGRM+FjBUpMc53yKzRk/vXgJsQHZqPxHqVIoRc+ghR2aukt1XFKxS5KxOrigept1kMC68CL064ikddtPehAy/SQw+547Ex2HAOGQBsWI/N2j4yMoAd9Ui1ni7OkGLvfIO5kRvF29llid8UMKlCRwdaH4Xl/Wt0tjZhuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=TLSB8sCh; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="TLSB8sCh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=YUUxkPTjKQu8APCYf6CHRMXTQxH1yyy9nZ/MELNNWvY=; b=TLSB8sCh/xs4nPSr/I4ebiIr9+
	D20BxQZyhKj5avmWSVXCp6SH/2fiek0L2HjnAwB4SrUB6cZsI8tybrlsMbuYuqEnGyrrhiVGeIa1n
	/n50vmg8YF2Qrigtt9sHKW9dkR6mdhj5B8DWWdhzXG6VxX8h/Z+UY0F5fcCV1IZg0YcdLavxroy48
	F9Swc0pJEAxs3ioYk3viajg4SUIL6VUsJMnABDxNF1pA/1HYhAGkBmS6/Czv78RMoTv8D7ImAUmUy
	4O1SNTKeA4bzkvSbA/3Uku7liLgAUp7zE0IaBBgThTGhzmUjLJavQImN+wcxREoSCU3P1gT2NmS+8
	pk2ROTEw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrN6Y-000000002Ry-48b2;
	Tue, 04 Aug 2026 15:55:23 -0600
Message-ID: <abc3e33c-b9f9-40fd-8b9c-a185f430f0bf@deltatee.com>
Date: Tue, 4 Aug 2026 15:55:22 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-6-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-6-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 06/13] PCI: Account for ACS egress control in isolation
 checks
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> pci_acs_enabled() treats P2P Request Redirect as effective whenever its
> control bit is set. PCIe r7.0, sec 6.12.3, table 6-11 lets an enabled
> Egress Control Vector override it: a clear vector bit routes the request
> directly.
> 
> IOMMU grouping uses this check to prove peer requests cannot bypass the
> IOMMU, but cannot know every applicable vector bit, so Request Redirect
> gives no such guarantee while Egress Control is enabled.
> 
> Report Request Redirect as ineffective there, merging the devices into
> one IOMMU group, and report no isolation when the register cannot be
> read. Apply the same rule to the Intel SPT PCH quirk.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
