Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAE3CC7CE;
	Tue, 25 Aug 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688330; cv=none; b=dFiwtiRMd0rSoefmXZpbJzWbeQhwG7y3eFYWNbWOG1h01cdbYw0DObbSzrDSm9H2hKx3eVN0YIWAtYgy7RBxkh8TSWuso3dgj0n0TkNSwDtrNpp5RJIp+wu9iTYbB4dmiqDInu1IKZUd7LZ6yeFBOTxs9qtOzIevY+gsFfelXXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688330; c=relaxed/simple;
	bh=i5QmLyr9y1GFbPUce3UMIWas+1K1LVzX+MS1VkuCFhY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=XjjmjJCxg2Jp91hhsU71+3PFLxXHthVHDNKoCPFxUAKFoelZ1S2gI89RdtVToPJB0wSVr84vRyb9FScOF58UnItPT4U6QdgF2seeLjM+BRuPRgpQXvZTdNd2ou1D+d+mq1nCLUh9caeKtLdIdL6ZSEUEvZcTCqiIrk5zWB3J8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=KmUw93Qi; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="KmUw93Qi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=iegiTVChsTubBoauxaUiIv53UrAdzumP4GLHq70u8/E=; b=KmUw93Qi4EK4PCsI+Cf9iO+Arr
	IeuyZ8J8sGF1u8kJroNzDYpfc3+4SA83vLG5jx9NrrZ7MFbeTB9fU7dAZEEplF9u/f6eIZs3tq353
	ZFzTjnOacR7Say4PM4LLDcgTJD88UBdGJ0ioIxt9qbzXuv8Vu1/KsJVNqWohig7I00ORmiRzJmIZR
	e/MUJXx1VYByD07Z/gn13XMCWmWzurH4r47RCEa5dUZBvlqYZ+Zy7T2CQAO5LWorNOSBdnz1tNZMA
	hmZxC3bLnaem4UYSJ5tf2nsLR77mS59euUlZPJwXPc2ZEuZ+HNHmXMHRv0BddBQvX66G0VXpoIf45
	pEI42wBA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wyxOg-00000006MiZ-3aPa;
	Tue, 25 Aug 2026 14:05:27 -0600
Message-ID: <6aeec523-3088-4f37-accc-c900953393f6@deltatee.com>
Date: Tue, 25 Aug 2026 14:05:24 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, christian.koenig@amd.com, sumit.semwal@linaro.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-25 00:28, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> documentation pointing at move_notify(), a symbol that no longer
> exists. Readers grepping for it find nothing, and this is the only
> place in Documentation/ describing the revocation requirement.
> 
> Name the current function and record that importers which cannot unmap
> within bounded time have to be rejected at attach time, which is what
> makes the synchronous unmap on remove() achievable.
> 
> Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

