Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765C1F94F;
	Fri, 21 Aug 2026 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353834; cv=none; b=F5XXbade+f4YZZ9bAlPhGqoJeCVA6oBY36LruyS3sU60+vjI2j9oeF2uSWxEhPAnsN5bznYlG5dwlY2s88OUoTUHQgsZfaxgvZZKbNvNSzP8DKMTj2W2Eg/W6CpOmjtMTeYFSO3IIiq99fcJb6KAXLUchA2eRmhPYR85D6+twlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353834; c=relaxed/simple;
	bh=JHxY+9D2jYaCNnyUDsrdzd2I0UOcGayagb+veHZMrLA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=cbZEmxgf+99ddK3enWJ0+b0p2ZrkXX1mMO0xFjGI4i6eXicwPXyWdv7mLSuqh+3dxSToIt752EDqSg0sgHcUAv8vTRzzyVNtR1TWGWIzyvfi67jqE9/pzgA3Ojom34rxoovL9a2NyQYaeicl60fHwum85NhLRjbeYONXJef8pM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=iXP3brMK; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="iXP3brMK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=dFghjUN81u9O22HJDcUJRE8I5XrUxUr7git8+py+xtY=; b=iXP3brMKILNZihvxe/pHZ35Bq8
	UBMOwZxKdCT2iQfaAUISySvONVQHloCEmsGoM/UM4cjB33JyRFVC/gI/2rNZgfFFhHmbuK984BmUg
	8y/SCfBSLQcwgbJxm7YrADgYEXEcoNcAtdV9x1WLSPnSmsHsrkwo8dbURCjGLzkr3RwAfVgLN/k+k
	QOiiMDTf+u3SU2cvBEAmmBmHtTm52zZWZjSBMuUL3lpUrHjKs3JtHfhM7g86uYabRJippBqy/bszw
	rCjXQwUI4nsmlptCrv6LWJWGoendQmNyzHKZnMse84Fz4E31q+hQQQvaCPSnLixVIfFHSp4MmUSx0
	LB8/7GDA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wxYNZ-00000003ET1-1IJl;
	Fri, 21 Aug 2026 17:10:30 -0600
Message-ID: <de397acb-c5c0-491e-9361-e39c4b385584@deltatee.com>
Date: Fri, 21 Aug 2026 17:10:24 -0600
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
 Tushar Dave <tdave@nvidia.com>, Matt Evans <matt@ozlabs.org>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-2-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-2-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com, matt@ozlabs.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 02/18] PCI/P2PDMA: Wait for RCU readers before freeing
 state
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> pci_p2pmem_find_many() scans all PCI devices without locking or
> protection against driver unbind, including devices with poolless
> P2PDMA state. pci_has_p2pmem() may observe pdev->p2pdma just before
> driver unbind clears it, while pci_p2pdma_release() skips the grace
> period when no pool is present. This allows devres to free the object
> while it is still in use.
> 
> Clear the pointer with RCU_INIT_POINTER() and always wait for pre-existing
> RCU readers before returning. The same grace period continues to protect
> gen_pool users for pool-backed providers.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Matt Evans <matt@ozlabs.org>
> Fixes: 372d6d1b8ae3 ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sounds fine:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
