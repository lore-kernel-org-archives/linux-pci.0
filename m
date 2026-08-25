Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85503AC0EF;
	Tue, 25 Aug 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687732; cv=none; b=maqLzw1Vmv18Hl3Ms2PQslTzFxLQ+0v40PjEMnBxWn1WICqwQUST2x8z9aOChDXN+0eW8C4uRXWSlcNQoUypCotECnwevVdtVhK41dvy/Z9EOIBDxlj1TJeXO4rTdjGqixh1OGki2P3FlcrDKsscx7jPLLIMU80V1U4EsQx3RKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687732; c=relaxed/simple;
	bh=xCFM8t9Wx7fm5UENoknC4Tm3F8jcuEXVwGCp7pg1I4A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=eQIQMnHW6b3JnaC6J7ay8lNgEAv/Ttfgwjih5fFSCXyTxoM3G1hrQEj82kmEEqjY+HcUWl7X1HbXdH1K0Edlif3XQi2AcNbbx7pf3pp/Bx6HCEfUzoSYNM2As07A+Kae4vHQV5BnXPEi5GdCzADSUI5HzOzjsBYWS3GxaYpmP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Nygw/aga; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Nygw/aga"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=MU+PBovOH/7GGtWqRPVwA2hNNxOpR+EFWhL4SjQ9tK0=; b=Nygw/aga00ZckIOBSbg1FIZbVI
	+RCqEu0cxJcjWsdt6Ei3GpOOyv7rNH4QSDoKNfL++iQeSOjJMtsEUmP+zwBb7l4vFA0Cf+qvkstGH
	AUSVzzajQHNMFXp253PG5h+2pkKsTbTHFieGAjlro5lOee9Kn6LOxO24OkJ488jT/a4wgylI64nAK
	0ZyRjl8b60B1uaQdUeCxLLd4LcWgNneMFdIDt0Ex2MjcEEmCM9ldwKTDG/VnpJkkDiGm7QIdLRE0m
	GSYUSiXx7pBNraXyeZDCqMhi66PR48Sy7tOXEMRD4UePzEPNKK/GdQI645BJBk9G9ysZ8N7XyF+FS
	0udZZa8Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wyxF0-00000006MKs-0ZIf;
	Tue, 25 Aug 2026 13:55:27 -0600
Message-ID: <50555989-407b-4353-8641-3beb2c1a1ae3@deltatee.com>
Date: Tue, 25 Aug 2026 13:55:25 -0600
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
 <20260821-fix-p2p-acs-v4-0-v4-14-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-14-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 14/18] PCI/P2PDMA: Extract pure ACS routing decision
 helpers
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The ACS routing decision and Egress Control Vector size calculation are
> mixed with config-space I/O, which makes their branch-heavy behavior
> difficult to exercise independently.
> 
> Extract pci_acs_p2pdma_decision() with explicit Request or Completion type,
> target availability, and vector state inputs. Extract
> pci_acs_egress_port_valid() for the encoded vector-size boundary. Keep
> config access in their callers and expose only the pure helpers under
> CONFIG_KUNIT.
> 
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Makes sense:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
