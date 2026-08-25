Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752D395ADE;
	Tue, 25 Aug 2026 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787685453; cv=none; b=UodVtGt9vd9iK0F+Fx3Vv17Gn70RxOfYEPAKVNgcX0MUrHCLIofpaAxrroYE27FL5uWKYTtzZIyITVD9TEmHaKUOTMmhskX9daIhcG4o64c0kkkT5EZqqevvFyTPVAy91+vwHJ0m0DihGRwTdSmjCrmKbIg5ReEM7l1xH/8Z/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787685453; c=relaxed/simple;
	bh=9mrZkHcp5YcsJpXkaX/J/P36KEo4l/auSEl0AGUzok0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=sU9N5+zNpt+UwRTUxeY/UkSRFayQkaa4NCN+rW2IQYvVlPAJsziqbAR9WhKvIFnVygEfuIuYApK94OLwvXj/56BX1gJxdT1dCvZvr6Nm2wMt8KbbwAOnUrU5bQhMIWMf8A5ziy36G5IBd1dWJ/9JufuLkasbAGvJnjd343OWbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=q1nlYfVd; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="q1nlYfVd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=qb5J0BwY7LrPVFBqEgYm7M+k2cbcTb4vaufiH/xxUjo=; b=q1nlYfVdhNXV0jx9LsFm+kk624
	ZH2Ogy+lLb3AY+BmDRRVOFqEdYJZ6V5EZSuCIZye3DrVbUJSu8b9KAWDWHVtqBmlHr2InUr5CMLSK
	LJeUd35pYjQnX948r/3GhGIs73uCjkaOtHQ7qhp3rGL5iQnSTa6nnsK6HQfyHwUL8evNHF52xHZpm
	4x/YtXtbg9/KI024Txejj57VaoGERkRYhAfIso6f9j2mlMlJ80q8uDchqHx8gnjm7KSSY/LwsbDhQ
	aPXlKAu6A6xJFIbqQS1PY6I+IydntuPiRZiY9DBOn88GeRekyHiEPi+bpDwZRtxoquhtg0sz+FGte
	lU2o0wHw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wyweG-00000006M0m-1HeR;
	Tue, 25 Aug 2026 13:17:29 -0600
Message-ID: <dfe6bdcc-af9e-422b-b4e0-570bafd868a2@deltatee.com>
Date: Tue, 25 Aug 2026 13:17:23 -0600
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
 <20260821-fix-p2p-acs-v4-0-v4-11-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-11-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 11/18] PCI/P2PDMA: Derive peer-to-peer routing from ACS
 control bits
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> @@ -767,7 +782,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  	while (a) {
>  		dist_b = 0;
>  
> -		if (pci_bridge_has_acs_redir(a)) {
> +		if (pci_acs_p2pdma_state(a,
> +					 PCI_ACS_P2PDMA_TLP_COMPLETION) ==
> +		    PCI_ACS_P2PDMA_REDIRECT) {
>  			seq_buf_print_bus_devfn(&acs_list, a);
>  			acs_cnt++;
>  		}

One nit: the line breaking here is a bit nasty and hard to read. Maybe
it would be better to use a variable?

state = pci_acs_p2pdma_state(a, PCI_ACS_P2PDMA_TLP_COMPLETION);
if (state == PCI_ACS_P2PDMA_REDIRECT) {
    ...

This in two places.

Other than that:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

