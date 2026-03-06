Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4B36F407
	for <linux-pci@vger.kernel.org>; Fri,  6 Mar 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825727; cv=none; b=ix7wHfDwqFvEuXL+X4N6mJZCzuNkhp1JUg2mybJHdKycwpF/7OJ9nX5jWDeXZ9ZiaOFtYS3oexDpJ9X4KzNKAt8WY3WhSLL1Y2O7ROTTZQ1zlAl+hgBRlOLPtAm54ooAjyL8chQgS+FJmXkOzlALZDLLANmAFRyke1g53YK+jEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825727; c=relaxed/simple;
	bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F65mIauppZZDGWM0WU43WDknPKWbD8PEeUs27Kdf8Rcxmn3J0ktnR7MhQ6HiIE6AbnGwmXy0/jd29C5Xaq9LQDHrdcgN+Cu6seyKhVKVbCc6NNsYBGIjR8wf/De7Bc/9loz0pBdwYmjZr6eJ8471XO/wg/7/n0IaHoc6Zh5y7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFK07eG0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFK07eG0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae4b40999bso9975ad.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2026 11:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772825725; x=1773430525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
        b=CFK07eG0WF2ukRdWMfJ1bk+tVIMO6aCAGhmXdH2I+69FHElggzTK+pbdoc2ywyYDmO
         mRxNy8Ys+y38L+hw5MKQvwfISeiXrHj4LThbbkKNvuP7YQcPhA/lqlL7V363JnSTE3yj
         mgbw0k9HEYC+3wnZ0z71WGNGjp/ic89HWYkqYRStsbIr6g5KrsmWPnhVIVm3uweK/v0H
         IwbqZ307Fj0qZvF10foTeeMt1xs6dQO6AyYVEtoYiQ1jABSn13edG9auy5wK6lfDRulh
         lGwAZ5wofgJD/mYjFiK8YkfqbrGj3nh79Jzd5MMuKqRg06mtaKgw8FkHudYVKycpHF5C
         Ibhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825725; x=1773430525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh5Z913UZEh7i6f061EXZd6SLJhL4kwsCncFeqW4SCA=;
        b=Q8nwoqsnZx3UMCQz14jKImCOZ8FjuAKfqvBEg3uYJRbdZvRNwIn0CNMJlmAeDZURNJ
         hXIWfZqb2u9WdrqvDIhsEvAKo5jnd37H888BByyk+GGETYWcoKTg5zIV3pSnwYaxziFn
         r0l0e1ncNdxBL2aajBoKjKkFuXL7xU+AIUJenFytsgWQOt3kLYiXtNZKBL9Wcj/6h4ez
         gRYZdUSvD8zIW7QcuWPfICE3NzafEiJMi4Oz+BCBxZPZ94552O75IXb5Y7hDkWTZpPyn
         8Pr6YvHMHM8NlBPr9WbJRtHfEbDbInlpGtxMcCPMJhDnNJOnytuNyxvclcuqoY0+UdcA
         SSkg==
X-Forwarded-Encrypted: i=1; AJvYcCWnYm/hE2HGJrN5tjQzyCpxEynwj9HNxhobE8XS5Eju4XEMl5l/WWYlPHIxlYy6vxIZfI2hKQyZwQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfznf5GGuz00e4zIj4YhNqu5OKr9Fxzf86VvG5rGlT2fS3AI5U
	8Kyfoa/aTyRwg7rTJa197CqNSXleesPgy1dARNKGEg5bXqogwHl99KbESklnmTAjxg==
X-Gm-Gg: ATEYQzzi2fWOh6rnuy0kzFQsRIRyzA5Bx93zTHm30mZ5DbG3QaTXMphN+o+7DNnFhAG
	LEEyhB2IPtylyzPhD4L+GHiAs+CdH6U7dkKMaECK2y3n92PXJSv9+P4C8v16666WrxKFJmVsJ2X
	om84Mi4E6UZQ9lGG43U6j0vYBG4ymkktC65jZ63BHF5thCi/LJsM2Q+5zkLg4tJcrkm/Gb2tm8o
	tWDoTyyu9Ed9mhVtjyNKu3muET7zLSBWLH1VwPexKXlqsFgDrlBSA7tik/ZFL7VSi53zCDWIKq7
	LWizZaA7pUxaFelF7iFpKBhV0c7AS3SqZ7DtJcKOd/4/tqR/cfMEPjs5IjGYS5v0mxajDjYszup
	8zduphhqDIkD063sWQ+fp9HDCuWwKogVOswhZj6fqZOEg1mC0ShoKgxBFAK4zjmowY+qhjfBDCB
	a8wM1NocOhV5MwnX0jBMA0jkXDmrJRSyezPOXSDocuFRw7PanUfLybZhnlVA0Yiw==
X-Received: by 2002:a17:902:f545:b0:2a7:d266:d84a with SMTP id d9443c01a7336-2ae8ae4e111mr191585ad.17.1772825724928;
        Fri, 06 Mar 2026 11:35:24 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fb3cc3sm27116245ad.73.2026.03.06.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:35:24 -0800 (PST)
Date: Fri, 6 Mar 2026 19:35:19 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, rafael@kernel.org, lenb@kernel.org, praan@google.com, 
	kees@kernel.org, smostafa@google.com, Alexander.Grest@microsoft.com, 
	kevin.tian@intel.com, miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <aasmWvA-sqi0KJwO@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306130006.GF1651202@nvidia.com>

On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> invalidation timeout is a generic challenge across all IOMMU
>> architectures that support PCI ATS. Would it be feasible to implement a
>> common 'fencing and recovery' mechanism in the IOMMU core so that all
>> IOMMU drivers could benefit?
>
>I think yes, for parts, but the driver itself has to do something deep
>inside it's invalidation to allow the flush to complete without
>exposing the system to memory corruption - meaning it has to block
>translated requests before completing the flush

Yes and currently the underlying drivers have software timeouts
(AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
before the actual ATC invalidation timeout occurs. Do you think maybe
the timeout needs to be propagated to the caller (flush callback) so the
memory/IOVA is not allocated to something else? Or blocking translated
requests for such devices should be enough?
>
>I don't see how that can be made too generalized since we are running
>this flush stuff in irq and reclaim contexts, it has to be very small
>and targtted without memory allocation or sleeping locks.
>

>Jason
>
