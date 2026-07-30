Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D6383983
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429970; cv=none; b=HrMWBkDreJLyVx7KDQAofX6kno//8sP5KmwC12gCQU8xNqGcuAf4ldqHdyOwTBVOftrZkm5IWiJSfh5PwIdYEAuwzTqd6Gen8kGU/CQq/yayzx1LZTkqETjO1NLbH6/qg5Wkf5MkpDLTCWfD8rUNd0wEWGGGenLqc9Ba1STgc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429970; c=relaxed/simple;
	bh=ZAs3k0ZvOc1D0wh9G3ZY7S0nZrMDuIeSI7fMUiNw0MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEsWpBg6gDs6AzHiI7iRmwvhVmT4KcRrs1UJzLm8QXMUUmHbOFF5GTXPxOL2YaA/lwoxteH5I9Oj001DQHpoETcwEKut6Nh9LqXufjPyrLJ5BrfcPlsMINmVJUV5QtlqC0KlptUg8xaVK+OMFG1pBeHCp1roaXrOitUPWdVDPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHNHpkjU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHNHpkjU"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cab97c86bdso145635ad.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785429969; x=1786034769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NX0JpvyzsEoK6j+vmZOEXvLrdaZX+FAFLPxJGdbTFoM=;
        b=VHNHpkjUYAWJTdMZxJVTie/KgINuJhvjdC9CiaMMyM4tQ0erUo2LcRwxFG0W5cZYSp
         MT6iQOSIeMxPIWY9HPmOHTSoQs9WDqZjUWXXgDk51FdYl4mijDYpTY3fA6sQukPQWPzB
         BhE/HfukIVNUHPCvZTX1qElePKssMtJcwlHIAqVPrcnVBjoQlFL/Pi+WZNYZ+4FyQJVf
         Z1EbKFjNKu3UKhlVrjMTfL/vQyMVswai0c/upzzn1ULt72xG3TnRY/iCFJbcjTIzfM9b
         E3tC9mEioxIrJneX6O3pMmA/9B00v4cvmdmO7cMLamxCrOaWzDHe4UFPrP5qWaujS3nj
         VEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429969; x=1786034769;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NX0JpvyzsEoK6j+vmZOEXvLrdaZX+FAFLPxJGdbTFoM=;
        b=AolLcQFb42tPlzwti57pNP0Rr/hwYuRiEGjVRHqoyi4Mb3oypD+zWVjDbKVNVJZKWD
         Vb8y1r2rQyFUD/yZhpgZvgYReFRpbcduOj4pTz8FE5vnnSZXtUKdm7KnrT4c7qBRxfXI
         uivIx5yPD3nPmZZ0jB0h7QkxMM+DuxqBxiQuFHFxo7AsYCNRLk7CTQu4ipQn88gu/D7L
         H6bXouUtXboNZ8crR6CUNuqY1tQ8fi1vkGJjWItiqkHLNYCjdOus+vdqJVfW1UPYjXnb
         K4hRUAMvf8VteqPQXtRqnhx7nTP9HA7Lxu1hcPWMxvhLRKJEI8U0qS05OJDjlumgCIId
         sGZA==
X-Forwarded-Encrypted: i=1; AHgh+RqrC5D3mrR3rwDaiHhN+Tv/fMmjdeQZI06o1hClR7NPDRNnwLTEd87Z80D74UZ7horzj3nq7Kmaqsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fkRQROrfv/cpYqK2HDYwNk8eq3ZuhALU4Jj9OcrVqdvUU3zU
	nz0YYDQtck0XCg2/ScCxA4Ax0pIrkK+MHOpnHs37k81FFF3jX/L39BWTDCsEiCpDuA==
X-Gm-Gg: AR+sD11GTLguzBuxDqkFeOOP+SWeuC7OHx57McTqawbTV5Bn1l1M6fS9Pkh/WsU1V1Z
	bCBXaQVVd+TPJkSVOhd4DuiMb88oIxWV2IuELnk7ZeRzrqZnqpA+V2NHtOsCV7XlQqN3MySkSiq
	DP5+x9sIAX1/Oj8yV5UvQP23zkCLwOHMdFblJn1PlUfZuJn3wotbCSwVHZIETKZXkRi8/2ph9ln
	6CMq+1PPwrX2a3kbIR4pR5NzIzrY2TDR/Qs2PLGOYVaZuqJ2oCjXZX4+5bIKtwSQUdcoVH57cEN
	ZuXRjIIYaxZQClgq6RK+0uqEf87hjl9i8sCelo8hLGCqTa2+dXMPlhrGfdWR4sxjgQaCX7Ogi1O
	G+OKcrHRJK3Bbzay1Ag2O7j7c2Iie18313IO5qtKxxRtNruUC9ygoIuTkHKbc4wZHKzb3BY3G1v
	GHkpsdTCI57IQsPgak0ggjmUZYFSW2vgdcmrG/DLvo4E0+vJIeHTOCDnJSu2gzsMNT2FM2LVzsT
	Xw5Wrlv6UKnHnf+12tVl+s=
X-Received: by 2002:a17:902:ce90:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2d040c826f8mr102235ad.8.1785429968232;
        Thu, 30 Jul 2026 09:46:08 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02fa474sm3347122b3a.30.2026.07.30.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:46:07 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:45:59 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of
 pci_p2pdma_release()
Message-ID: <amt_x6-9lplDLdHZ@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-2-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-2-matt@ozlabs.org>

On Wed, Jul 15, 2026 at 06:47:24PM +0100, Matt Evans wrote:
> Preparing for a refactor in a subsequent patch, split the pool-related
> release code into a new pci_p2pdma_release_pool() function.
> 
> This allows future compile-time selection of a null implementation for
> pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
> P2P-related files.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
