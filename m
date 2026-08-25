Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5933B2FD6;
	Tue, 25 Aug 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787685936; cv=none; b=fKxyP/08ODjnwvNMWhwjo8cFqP1QxnAWuaEwcYwS1uq+3yHlHZcF8g4EbHEd3ukWbLd4TbfeSqIpH9Blgwd0dA8yR5ZkEul/t3wePG9PCncVeN36uaXTinazGvTPzYT66xNAzfKcFA1z4GtAY34qFIcbzIfA1BjyLKceRZOebu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787685936; c=relaxed/simple;
	bh=jBaQUif0Ewp4an9CqdqeNHizA7YNt1Shln5HYKUjkg4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=TQRh7X6PlHM/z1rdMlJCV+xA5qA0RDR1KK7PP+ag4lZ1IHS1JBGV2biSURjdZRbfxrxxLBsRsuwNPApvkS398NbhtIpVEHj9pviPQlWQS73RC1m7Z7HARdZVGY48/ClUhPPeHkWV6z9YdqQh/oTrOYyOCup5GHtDk1bk819ddEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=E2ZPlVZ/; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="E2ZPlVZ/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=VRRvVyKQR+ieTJiDz+GlieKpZuVYM1cd13S3G9JWIJ4=; b=E2ZPlVZ/vdjT8QgYmMdM0BP+NP
	Jxwo3ZWHYWab21DoLBvQAFJP1MVr6+nzwj9Os99RJCpuss7Rkx7q9xhOv2eQUh0wV1wH5lIgdGvav
	IyMzlmyJoDYgXgAZtSe21T4nAj/zus4XXL5N5GWMVNB3bT9WHRHxzp8c3iSzigHKX1OPxgpl/IXrl
	n5U51qxHllFKEVFDTb7LDQNVeF9mpiHFtO/soWVRz+SUWGr3YyWVUI/3JNe02SXa0gNDlvzQtya1/
	lBltrbpd4yC5A/nKUvci9nnTF1r9fVDfbcqj8CMX/2j1a9GYSmkQhfT4cR1dfRAPkYx0ktZRMz6tx
	AH+ONEvg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wywm3-00000006M4l-40o0;
	Tue, 25 Aug 2026 13:25:33 -0600
Message-ID: <3a38b762-886d-41fd-a372-601966e4b346@deltatee.com>
Date: Tue, 25 Aug 2026 13:25:30 -0600
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
 <20260821-fix-p2p-acs-v4-0-v4-12-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-12-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 12/18] PCI/P2PDMA: Honor ACS egress control vectors
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> An enabled Egress Control bit does not by itself redirect a peer Request.
> The result depends on the vector bit for the target port; a set bit without
> Request Redirect is an ACS Violation, while a clear bit permits direct
> routing.
> 
> Evaluate controls only at the path divergence: Request Redirect and Egress
> Control on the client-side port, and Completion Redirect on the
> provider-side port. Below it, traffic toward the other branch already
> routes upstream.
> 
> Reject unreadable vectors and ACS Violations. Neither condition redirects
> the transaction upstream, so a host-bridge mapping cannot make the path
> usable.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Not the easiest patch to follow, but I think it makes sense. It does fix
the nit I posted in my review of the previous patch during the code move.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
