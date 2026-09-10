Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7E36606A;
	Thu, 10 Sep 2026 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006937; cv=pass; b=lIFPz3d3XAnlke/g957Lltoy0dHM4hW5+WVm53kXh3+1f2JpqaNvXqeQ6nMECoBc3zz+CCDYTDPLHSC/mrej6c/UDFuWEAXV1p1xwIBq//b+2fR2TEQXrIwuwDqo+O8saAjAH4RTlYRW9ybazR+YgwdNmcg6d3LnjgvCttlbRXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006937; c=relaxed/simple;
	bh=TOAeMV/K0apEl1/es5iV+qS7CfDx4/BorCu3NHK7IUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYw0Tj3A/0kZk7JG5OSVgqxDBQUANgtduwIUY8qLm52jv1LeQk9IIEt5SK6noE1gxC+aGFA2Tq8KZTlpMsGxZSHc3o3DYB6u3Y6p9WCdKvUvASQv7IATMm2SVlcp3t082b7D9Z2BuP1ryEU7v85rliWB7HEXzvGMVBVuHFBBTeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=eVYmkaBi; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="eVYmkaBi"
ARC-Seal: i=1; a=rsa-sha256; t=1789006925; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bDdGVeMqu1HvXeCQViDHAa/sTcqPFCLc23ptguf2usLSE2o00eWB4jtkSTrpyQjxE56xwRI9U14FEl5j0O/D/Aj6dh5DS0ffoAgN36776CgwEPwllwvNRjVIkvsFYtfqfIed9ClVmTWZCARRah0mnDn0IPH5eR/c5gB6DUoy0Kc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789006925; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6z88WyVcssYNLuvkcn1VUg59x7JxQUtLNeNAFMbyrkU=; 
	b=AimbjRcVEoCfWwgkrlo1Dkz942bshSioqTmbvbNBcKQoD6dGciGpwvoCggCcW4tOUPDgX8dSAJN593JWYMqoI+jSFDsywP7b9kZt7Zrhv05AjFuJPLE4Dott73joXothEgXcFiCkXCodHJwPVzh8lAD4khyY/KtdJez6qVSlcXg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789006925;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=6z88WyVcssYNLuvkcn1VUg59x7JxQUtLNeNAFMbyrkU=;
	b=eVYmkaBiKL2Mf1DU2g5UpTKN6ZjnpJp2RgjmfCy0rchUr2kwdiikdfCWyzJl2re5
	Jkv/RAF4SyDDPfSVKS0YjpzbFWESrU42tqpDMXymtCc3JWGiGOvO8M7OF+SuZs52OmW
	zXMsiuoQQ8JFbv6iKRwgVnB+UPsGKgscky/GUmGs=
Received: by smtp.zohomail.com with SMTPS id 1789006923472367.054041669707;
	Wed, 9 Sep 2026 19:22:03 -0700 (PDT)
Message-ID: <d1eddf2d-43db-449b-976a-d70227210061@zohomail.com>
Date: Thu, 10 Sep 2026 10:21:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-6-smadhavan@nvidia.com>
 <08d97766-d62d-4901-a413-705df0020d22@zohomail.com>
 <58a876a1-7569-49d9-94bb-d090c8acd439@nvidia.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <58a876a1-7569-49d9-94bb-d090c8acd439@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227989a26a49cc39b7891a055c70000cc564f4df5c61bf533b110af89b630673ff8ccb1716b986eb1:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/9/10 08:07, Srirangan Madhavan 写道:
> On 9/2/26 7:03 AM, Li Ming wrote:
>>> +             return true;
>>> +
>>> +     pci_cxl_hdm_init(pdev);
>>
>> I forgot to ask a question in v10, sorry about that.
>>
>> I am wondering why calling pci_cxl_hdm_init() in
>> cxl_pci_hdm_decoder_count_match() is needed. pci_bus_add_device()
>> already does pci_cxl_hdm_init(), so if my understanding is correct,
>> pdev->hdm is not NULL here, so this pci_cxl_hdm_init() here will not do
>> anything except checking if pdev->hdm is NULL. I am not sure if I miss
>> some cases for that.
>
> Hi Li Ming!
> Your question is valid. pci_bus_add_device() is the normal 
> initialization path. The later call is a retry for cases where that 
> attempt did not publish pdev->hdm, for example because allocation or 
> MMIO mapping failed at that point.
> If initialization succeeded earlier, the existing cache is detected 
> and the retry returns without rebuilding it. I clarified this behavior 
> in the v12 commit message.
>
Hi Srirangan,


Thanks for your explaination.

I think removing this retry should be better if it is only used for the 
case that allocation or MMIO mapping failure during 
pci_bus_add_device(). Because these failures are not expected to happen 
often, and removing it can make pci_cxl_hdm_init() implementation 
simpler. If only pci_bus_add_device() calls pci_cxl_hdm_init(), you 
won't have to hold cxl_rwsem.dpa and check whether pdev->hdm is NULL in 
__pci_cxl_hdm_init(). Besides, hold cxl_rwsem.dpa lock in 
pci_cxl_hdm_release() is not needed, because the function is called in 
pci_release_dev() where is at the end of this pci device's lifecycle.


Ming

