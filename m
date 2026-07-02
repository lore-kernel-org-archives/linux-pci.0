Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77052304BA3;
	Thu,  2 Jul 2026 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783024552; cv=none; b=q+rs02vNoncvh9l22HEGJ40QLkWJnhHoysZBzfZCgBQaWywdN4/1tZp1qL+Dck9VdUHTkbwz7Eny7Olqow+SJssss+cAe0s3702Ve7/Xjd4PHkNsoyPXY/jHsubsjuzSuyQ2C/LXBfdG2qGijbnA7+xgaXH6JuxejPMu1gW1oBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783024552; c=relaxed/simple;
	bh=Zm7m3tTldkvWq7EZaaaCIvCle11wRvS3oBxXy9ODNcc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=JMB6JvltdJTWkj6uzTk+/dsRE7pYFISWmiaTM1fbR5gA6JuV1jYoeY/jodibTOJkn2nb1vuEB6Lz6SRYNOXlKsxwCVdwY1rH80rPvvsGJRQrEyrfPDr0WAprVmneC8fDSqdutiy4pkotH8bmhFAMuAUyEBBl9aasLM92YOGpiNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=cU4+yxkJ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="cU4+yxkJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=JzUSZhPWqNWNKTHl/0jMtxGhpz8F8LscUgrhOQUpk4Y=; b=cU4+yxkJdxAeS4yui7R8BmYTUJ
	DRYWdLNFmn4IzYyA8GI4JMvn5I+ao4YCJoKHqHlZBXELhVQOR7+rbnR5az5v/BkfQgJToWwrgHqdK
	bkyzMrds8fKOwiAy9eQt43KyjnGykPEVoAe3We6O105RJ3FqGfgbPe2c3N//eYM+RF2KlpkmplnRX
	ZyFUAT2Yl+gEox2QjrPI7AH2qNf8wELNWJcyEDHIcdGl009phubiaMKzFVqgmjyy33HlREsTWdv3X
	6RaWLz4M8MAKVnPl1dKbctoJ3kYc+JvbGJAMeQtwUQhSvSUPSEtpYv4AZtpLxXiHnJMSl2eirkvTa
	pSPZ8pZQ==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wfO8O-000000071tG-1qho;
	Thu, 02 Jul 2026 14:35:45 -0600
Message-ID: <1cd1b832-082c-4f9c-ab68-706110ddcb25@deltatee.com>
Date: Thu, 2 Jul 2026 14:34:25 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260701171245.90111-1-matt@ozlabs.org>
 <20260701171245.90111-3-matt@ozlabs.org>
 <26f74cf0-8892-4672-b0e1-1f1a385c42bb@deltatee.com>
 <aecbbc66-c154-4439-a6ae-84dc012b0f8d@ozlabs.org>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aecbbc66-c154-4439-a6ae-84dc012b0f8d@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: matt@ozlabs.org, alex@shazbot.org, leon@kernel.org, jgg@nvidia.com, amastro@fb.com, christian.koenig@amd.com, bhelgaas@google.com, kevin.tian@intel.com, praan@google.com, mngyadam@amazon.de, dmatlack@google.com, bjorn@kernel.org, sumit.semwal@linaro.org, ankita@nvidia.com, apopple@nvidia.com, vivek.kasireddy@intel.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 02/10] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-07-02 10:44 a.m., Matt Evans wrote:
>> So maybe at this point it's fine to enable this on 32bit systems and we
>> can remove this requirement. However, I think we should do that
>> explicitly in its own patch, not hide it in this refactoring patch.
> 
> Your question does prove it's too stealthy as-is. :)  PCI_P2PDMA still
> can't be enabled on 32-bit systems because of its ZONE_DEVICE -> 
> MEMORY_HOTPLUG -> 64BIT dependency.  So we're not enabling 32-bit 
> support for PCI_P2PDMA here, but it's not obvious and so I'll re-add the 
> `depends on 64BIT`.  At least then it won't be enabled without intention 
> if someone enables ZONE_DEVICE on 32-bit systems...

Ok, that all makes sense to me. I would be good with removing the 64BIT
dependency (as it is is a bit confusing as is) but I think adding
another patch would be appropriate with some of the commit message notes
you mentioned in your emails.

Besides that, I think you can add to this patch:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
