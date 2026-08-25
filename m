Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD713CB56A;
	Tue, 25 Aug 2026 19:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687588; cv=none; b=BKLTjwII0jT9F11ynJzlHig3LebLTwvIYDnD/XkIuQS37O7KlSTEgCZvAS4RHmyDcoMy/wGH80/Y+0yeFVi8V9HoplSz9nK+1+kgCsO5kdj+htO4rGiW1iou7S6ir+mIo6/FMdJ97njyfMFg1IDEskYr7tH7RxMqAb7DceLgtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687588; c=relaxed/simple;
	bh=cuTNSDCtwr6eFG7AqL4gPQufeRusNdxpcAvqaGKKFQU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=J79PRztP7Y0eBs3/IufRueXyq0WxtXqby/YyXSsUKG/rU1t8iaAI1Y1ZrdN3y9WJS3+Ff2OCrvYKEIbXVoQtJRV15mn5NYEB4RN8Fj4CaaOqWDAxtxPF293clDNo4PlbgJnrrcl+BriIRUpgmtXFd9ZyczVqbOZAcV0wb1QJ58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=fnt2tuM9; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="fnt2tuM9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=BdDiNFFs94G68xq8h+xPHL5rv2aSXqjTcI0GlQMQexQ=; b=fnt2tuM9stc2LMRDoD8CkTCL//
	+oqslSmBK2kWzYPuyG9RZhU9T28UY+/zUkLlAtNnmB3g1xQfu5P7Ct449HejAjfPSisq5RLn8HuKD
	5PDTqrVmeIVm1VeGliQF77JRG1rSHkgCTeLFi0iPSc6hD81hd/FHQBxsUeX3O9DAT9GOd7JbbqrFh
	1X22lRClRQQwvEOS9At1dZ7EBqrCLXhCy8GTR/2w7looIwP+1jnL9dFgp13Hb0yfdHY0Mme5YC1S5
	X4Bpe7KZTO5FV9eaQRNXOjzLcBnoA2pI+TaZUwqPXQ0NkZpA3Ou9laoxXMkBzvE8pSbNHFbgKXyQd
	byockWnw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wyxCh-00000006MJV-1vbL;
	Tue, 25 Aug 2026 13:53:04 -0600
Message-ID: <d515ba07-a568-4cb5-93f8-cca1df233695@deltatee.com>
Date: Tue, 25 Aug 2026 13:52:58 -0600
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
 <20260821-fix-p2p-acs-v4-0-v4-13-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-13-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 13/18] PCI/P2PDMA: Document ACS egress control handling
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> ACS controls are directional and affect only a peer-versus-upstream routing
> decision, but the P2PDMA documentation describes them as path-wide. This
> can make valid asymmetric or nested configurations appear unsupported.
> 
> Document the fixed transaction roles and the two ports at the path
> divergence. Request Redirect and Egress Control apply on the client-side
> port, while Completion Redirect applies on the provider-side port. Controls
> below the divergence cannot change traffic whose only route is upstream.
> 
> Distinguish redirects, which establish a host route, from ACS Violations
> and unreadable routing state, which must be rejected.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
