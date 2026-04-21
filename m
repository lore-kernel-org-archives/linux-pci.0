Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477B33F8BC;
	Tue, 21 Apr 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795309; cv=none; b=DDjb1ElT/apzflqk5Fi5ORCflSdtA1IyBvR2IMbJa07hW+k0dZGIg8myYHH4c7TZ2EvPvm+vE1czDPXDr2bII2RhcDVF1UA+UpVgMWZq7rjQRh//2s0MS38r0mDK8i1+7W5s1RXXNpRl4B9m9EHHfN3eukTo0csqmxlNQegk96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795309; c=relaxed/simple;
	bh=jUh7Grx6DMmDoLYuoJ2lx+wKFp6/tOdknTR+gvX98G8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=D3BOenZihICD1atpIeRIvKrCbMBqezOXFgk5ZdcadaROQ9pVhPTelzbUg4ekX3eeJSw47nAYMSC/hfu3QEvSEkTqvLeg5iQMHyrf/nFES6mNL9m7Otra6U9JwKNZf7MgagWpLVdYAabB9My7Ae8pKRjwa28IKMBTbtx96FpGy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=UDSWvqt7; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="UDSWvqt7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=B8hFtIuFqE25OFd700xADDBrxfR+UtQr6/9m0uTtlDY=; b=UDSWvqt7qXPCMW0sHl5h2hYCS+
	3sxMQ51aoRE87mEiCrV7LttIHQQf7ueERg9Dv2TRv5RWjwHXaFtc9RRETL9iCbMC4d7Ax/aMjeUQw
	SiCriXSSQ0gB+s6RBUvk9aQsoaDXBouHW1dsN5++++yEsBisEA3WfQ2pD0ULwn8f4pOthlCzxb+Q3
	V2iyZo/3PCLG/28Z7Joq3BhrsR93j0rC6qKeJcj/6DssSww23I88wHyi54RbC/nlETWcogjpwczlz
	W8qQR2YgimemZ3g/1c4Af1Etu+kwY5JkWNTHCVGmdtlBVn3hMLy/SANWLqC0CEroWZtazlXJZtTW6
	+v5dqs2g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wFFch-000000002do-3Vm9;
	Tue, 21 Apr 2026 12:15:00 -0600
Message-ID: <35163ccd-a282-417c-865e-9cc111b70fa5@deltatee.com>
Date: Tue, 21 Apr 2026 12:14:57 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Evans <mattev@meta.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260421174351.3897842-1-mattev@meta.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260421174351.3897842-1-mattev@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mattev@meta.com, bhelgaas@google.com, ankita@nvidia.com, leon@kernel.org, alex@shazbot.org, schnelle@linux.ibm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-04-21 11:43, Matt Evans wrote:
> Extend pcim_p2pdma_provider()'s checks to exclude functions that have
> pdev->non_mappable_bars set.
> 
> Consumers such as VFIO were previously able to map these for access by
> the CPU or P2P.  Update the comment on non_mappable_bars to show it
> refers to any access, not just userspace CPU access.
> 
> Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
> Signed-off-by: Matt Evans <mattev@meta.com>

This makes sense to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

