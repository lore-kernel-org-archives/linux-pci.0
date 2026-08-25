Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9D486E7D;
	Tue, 25 Aug 2026 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673569; cv=none; b=jKr0BGZzrTI92DAGm7p6iPBgdRjgd/AsRV95Y4fnd0PK/RikwQQsYSO6M+R+LQ98dJF3tBeu8zOdpYJWMuJX171ctAOCvf66/05Cny2Qs6cUym4aIjPChbSJzBuYJKcjzktQ7ihaao6xWpMjdu3iU9QvNbmewPDsq8MVnua7MFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673569; c=relaxed/simple;
	bh=CKZJVEvOfHrhfPurI2w+IG1YJBJ3q8T8FzLOx8nwr2E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=gLGBnVIGg0vsMaGzZSCSc++e7M/aIPCSPR8mnEpqSuVLU1jAUO0qzFWtyoZ/AVVeAjBpSQdCDrYB2aYTOCuYGwPTwK48NdA5Y6YwENyTFHnV3b0HRLVm6W+iJFuxLonKfmvVe5UrIMob3NSSzcA34/qbinwRZVJheNlzDvmTHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=HMzeDONq; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="HMzeDONq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=m4s0q9nPbaGk/Ba/rvA4B6Wb+VNMwA7KLMFLwYwvHtw=; b=HMzeDONqq+d2gtmpjYK1BQx5QQ
	A7Wlusd+jvZ2ftZKHJzXrffaX/FG5R25YZFYMJfWrXvuwASnflkVm6lm5UCOK2Gps9nwsyQOCMsDA
	ZipmXpL70IyIpoM5Cmg398PmGhpl4TZT/qxpPx5f9y1NA/xzbePNY8l4drPxkYsm5VcsGkN4A5wEB
	VSHihLme2RIGsVxX9rHl/Q2DZK7Jc5YNvBo2GJlMCaiMwtvttYOjKmiWZ2fl4KwU1GWT3hdNXekql
	k0WF/bMcfw3Ap+yUhrx0azWVU5KyXFcI6N6YrO0oWrH2fLwj801YpDUGhaFO9aTXsgoT1mN1GeMgs
	b33sMxig==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wytYX-00000006Ixn-31eH;
	Tue, 25 Aug 2026 09:59:22 -0600
Message-ID: <fe568a9e-4ce7-4de3-bf26-c42c38e17a79@deltatee.com>
Date: Tue, 25 Aug 2026 09:59:13 -0600
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
 <20260821-fix-p2p-acs-v4-0-v4-8-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-8-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 08/18] PCI: Account for Direct Translated P2P in ACS
 isolation checks
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> PCIe r7.0, sec 6.12.3:
> 
>   peer-to-peer Memory Requests whose Address Type (AT) field indicates a
>   Translated address must be routed to the peer Port/Function without
>   redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
>   Control settings.
> 
> Request Redirect therefore does not isolate devices below a Port with
> ACS Direct Translated P2P enabled.
> 
> Sec 6.12.1.1 makes such a Request an ACS Violation once Translation
> Blocking is enabled, and that error "must take precedence over ... ACS
> P2P control mechanisms". Report isolation only in that case. Without
> Translation Blocking, devices below such a Port now share an IOMMU
> group.
> 
> This only holds for a caller that needs Request Redirect to isolate
> peers. pci_enable_pasid() asks for Request Redirect for a different
> reason: a Request carrying a PASID is routed by address alone (sec
> 2.2.10.4), so it has to be redirected Upstream to reach the translation
> agent. Direct Translated P2P says nothing about that, because a
> Translated Request already carries an address the agent produced for
> that PASID (sec 10.1.3).
> 
> Give pci_acs_enabled() and pci_acs_path_enabled() a scope so each caller
> states which Requests its answer has to cover, and apply the rule above
> only for PCI_ACS_SCOPE_ALL.
> 
> pci_acs_flags_enabled() and the Intel SPT PCH quirk both need the rule,
> so it lives in pci_acs_rr_ineffective().
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: ad805758c0eb ("PCI: add ACS validation utility")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Looks, ok to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
