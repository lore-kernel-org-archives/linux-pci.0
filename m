Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09A49CF42;
	Wed,  7 Oct 2026 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791374907; cv=pass; b=GeaBMEVyDwKwr/82ZPG94XsOy4cqdWMElNvax6fRitpBEwfg5Qc77+qqEAkSSjWBAtSd5q5ZR1C7CEyFz4xmF2dqjf2MuQ7QSZfDInYlkgPca3sdeDTBxI6QVL9eYvpRVhMBu34S4BiXPiqfw9FnU7auc/CT4N6Kpb0eNk9GEU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791374907; c=relaxed/simple;
	bh=KRN5aUoBT6yvcY7O4JyYd5G1G6gDhqkgVMCgSeJbvNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwvM/wSG3u8snmqaLTOktRqD9FfxyvdFXlmR/EvcInLkwrGZnTv3Gird4UsiXvSgtT30HK6oBO+DIGf4nfNiugDaygO+E1PiZgELOkj+S/z2etEn8pXjArycTsFYwOju6+0SS1aE93Vm+EQ1hQcmhMylg829ZiK/4M3dNdNTfKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=ZY3ITvKg; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="ZY3ITvKg"
ARC-Seal: i=1; a=rsa-sha256; t=1791374876; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HQtt+hGOtkINnmmSqfuJv66DQNPtui0WTpXLacyuGkwaxKoVoDzC+2664uOhmmfshqG0/LGB94vBSHg5hv2oF/us6E+nmSm/DlZyy0YyGHbsGSD/O/UfbY/uIyje5bvvjxsrjDzE0KoouPgL3pvrGZCtuVFkR22s5X20S0XNW1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791374876; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YDK+eVt9z7jRcDCuoLKKEPAz6CTTIjzqCw6nYaxWFUo=; 
	b=DyD7RTtmF5YMYtuRiolLCpZDT2xv2BQ8hFeOHWU5Dsr/nVoNPoexdJyo4f40d35VYyG8534opljdjS3WNeBEbtAliG2CM1oZSDNejzdXneuEKilQOd/SMCElrOh4OPRaDi8oKE93hcYah9igUjf4mfZc49WjGoLdhIF/awkxygc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791374876;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=YDK+eVt9z7jRcDCuoLKKEPAz6CTTIjzqCw6nYaxWFUo=;
	b=ZY3ITvKgdmfAjd2WVOLOK6GSg2cSyewIJRVmd2ft1tdpPuqmbonRZR0+GxhAkgiE
	AmCECSovVs9IMOKcDBgJbFDkSw80ibnoH+XEaJ08DYHqEYqiO0FDB/aidyYUfHI4cJu
	KFmP2LpSdDTTy3FVHOXpCGiANaKmeRqLaCxti3MI=
Received: by smtp.zohomail.com with SMTPS id 1791374874789244.05969337523243;
	Wed, 7 Oct 2026 05:07:54 -0700 (PDT)
Message-ID: <fb3dd8b9-438c-4cca-9811-6bc47efee873@zohomail.com>
Date: Wed, 7 Oct 2026 20:07:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/16] cxl: Drop stale decoder interleave limit
 comment
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-2-smadhavan@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261001092227.3004747-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112270568025c6b11d8de7c4fec200000de64e2ac7ec75c8a0427ea90bee38664b83f6ba0a7c3c9653f:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/1 17:22, Srirangan Madhavan 写道:
> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Remove the comment
> without changing CXL_DECODER_MAX_INTERLEAVE.
>
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/cxl.h | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3ef0810ab86b..9e0500d56866 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -269,10 +269,6 @@ enum cxl_decoder_type {
>   	CXL_DECODER_HOSTONLYMEM = 3,
>   };
>   
> -/*
> - * Current specification goes up to 8, double that seems a reasonable
> - * software max for the foreseeable future
> - */
>   #define CXL_DECODER_MAX_INTERLEAVE 16
>   
>   #define CXL_QOS_CLASS_INVALID -1
>
> base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
