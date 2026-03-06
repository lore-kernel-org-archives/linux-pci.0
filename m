Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B643C040
	for <linux-pci@vger.kernel.org>; Fri,  6 Mar 2026 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827180; cv=none; b=oKv4OBsWYn+aGEA2aNUQ1hbQXvlQIPs3FnOg/CHTV+gRqtuJlfuGiq3WBow/CywUt3ZVhvUkcqxI2bl7JZwk63sZj7W+f3uKvdOzIpyS3lSJX60jH0GzZVMmecepYkGjzY61JEXn6wtpSzIjvLi9q9+ux35uPUFsU+a4v2PbDRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827180; c=relaxed/simple;
	bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCYUra13bJsekYxkdGQHOVzWvXLUCz19VDNxHHBd6QPao+t/jb6bpcTZICYBDEO7VZNBCPDJR9brzdofsNRKNL997M1hls5Y7UAIuI+dBvuWu6FdByiFDRM3bETZ4Ospgb2sagKORt8gEOrpehXZYByWB26lq6awCZ8t0Aj1B8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrWt7DWb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrWt7DWb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae523d54d2so11475ad.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2026 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772827178; x=1773431978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
        b=OrWt7DWbIRNvwgpJ1SXQfaUPeSPg/CMtLN4LLK77HtDC7TsRliYyagu2uKAMxouZEN
         D6ijFaq8M8csmb2299380mt4vwVXkFM1QNmVA8oIfKP+ogJClfFSKui1qKjMLELs674l
         HEPrEJ9web5tXJu+qIG1yFeI94nhABZBkCNCdAwLF8UZxvZu+050hH4+hEXjgNd/KpP/
         JKV2BwLymXLwasbv76dSsHU2wlNncZg6YBZkO/aWTeS80BYmD/m73wZPEzwYYQY+SMJE
         Df+3ndbkdNhXqHUImdG1zNXq2Na8Y+dYst5ALI3t6iAVKmvdEHHVKrmNkhPR9tB78HGd
         V2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827178; x=1773431978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=945rH/e5rNYp7DXMDC1/KmZIttMnGVuMabmAVl9nIC0=;
        b=Sn0OI4sEpD9hYmP8oKB+XjxpW1k1o3uZk4eHSrcSzbnVhzXVTqCsFbTTzyiSBLIDHE
         q90YbDNlZyxfabu17VMlTwI4L98Y2ZdTfEu7nH9V3F/Kf2vAoNUQgv6uPjSBeGR0uYpd
         LDIqf5vP8+Ku+Ubw/9JefPDk04GcsSnxU0F3ErOe50hye4lOYVIHXy57K5WRxSeF1+gv
         smjBp0vuE4kBMjNAt3sHjtJzxIyUMf6EKc7g903A6ObQEBOjoIQIVhAoiXTZmRlqnr7s
         JoUJRR9RZVkC85c22ZRFecJUWSKiAtzF4ZyUcAbYh/XX8Ih4wzvuuD5KWtetyB9X9rCr
         SZiA==
X-Forwarded-Encrypted: i=1; AJvYcCUCcft54RYsndy+NeS69qijNthy95/NRVUEQ6vC+6ZTzX+9tW5VsZ0V+18Qv/yMLBXbS2eD+X87aMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRdE18WBVDN458ig2JHBDrrGleFHtyKgM/ofeAaTlvzmx62cz
	qVM8zrAyd0pvI10tjFJ54EdC7GsS6zwIwJr+xkJzORJLDbfnrdB1pTCgO3WO3I7tIA==
X-Gm-Gg: ATEYQzyKXLcb1Agg7iXiRzUzUyQ3Xe6BhLd5wRfT7e4qXkO0xwKTNaesr/l9BRUmzo8
	dwl1XQpkoIaYCqtdYy1IgBbWA0E683hlMA2+20rSJbQgDwOL8xoBQ6sCR8v0een7LEV76CsSAU2
	5HYpZ/Lx5yBDw+RTL/DsVy2miq1DsvfJ1eSZ8wSmxdN5u1OgmfO6wNcE9zQesQtaxzF1A/7Khmv
	h/I/Mps58IFLC+cb2Mm/TimcrNFVH3BZ0ISwG4al0fc1cm4S3lruxTGAqHI+Gtr/VP2DE1JdCZb
	J0Xj6V4zxVRlOKhp/pahY9y9CcHoZm8HD64EH057/gNuwyt4jSYDVCTmkR+cU5cREceNc84q5Qx
	wGD9hKUASg4U0LN1pPnq8eXSKt3bQLdGDchC/RAXvHL1YW6hBy2VahJH2Y5VzGpMs1FMsSRh4fd
	l6kAAQbVCCSXOLaVSrWXvSZPKIyg5Rj5XF4zdwoZMNGD3wq+8Kpk4V1aUawxUUkw==
X-Received: by 2002:a17:903:2f8a:b0:2ae:575f:3755 with SMTP id d9443c01a7336-2ae8ad8939bmr404865ad.20.1772827178041;
        Fri, 06 Mar 2026 11:59:38 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b2130sm30703795ad.83.2026.03.06.11.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:59:37 -0800 (PST)
Date: Fri, 6 Mar 2026 19:59:33 +0000
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
Message-ID: <aasv1HYOKuuJyi1k@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <20260305153911.GT972761@nvidia.com>
 <6416b7fe-0190-4c7b-9a62-5da7d5eea794@linux.intel.com>
 <20260306130006.GF1651202@nvidia.com>
 <aasmWvA-sqi0KJwO@google.com>
 <20260306194312.GL1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306194312.GL1651202@nvidia.com>

On Fri, Mar 06, 2026 at 03:43:12PM -0400, Jason Gunthorpe wrote:
>On Fri, Mar 06, 2026 at 07:35:19PM +0000, Samiullah Khawaja wrote:
>> On Fri, Mar 06, 2026 at 09:00:06AM -0400, Jason Gunthorpe wrote:
>> > On Fri, Mar 06, 2026 at 11:22:52AM +0800, Baolu Lu wrote:
>> > > I believe this issue is not unique to the arm-smmu-v3 driver. Device ATC
>> > > invalidation timeout is a generic challenge across all IOMMU
>> > > architectures that support PCI ATS. Would it be feasible to implement a
>> > > common 'fencing and recovery' mechanism in the IOMMU core so that all
>> > > IOMMU drivers could benefit?
>> >
>> > I think yes, for parts, but the driver itself has to do something deep
>> > inside it's invalidation to allow the flush to complete without
>> > exposing the system to memory corruption - meaning it has to block
>> > translated requests before completing the flush
>>
>> Yes and currently the underlying drivers have software timeouts
>> (AMD=100millisecond, arm-smmu-v3=1second) defined which could timeout
>> before the actual ATC invalidation timeout occurs. Do you think maybe
>> the timeout needs to be propagated to the caller (flush callback) so the
>> memory/IOVA is not allocated to something else?
>
>No, definitely not, that's basically impossible, so many callers just
>can't handle such an idea, and you can't ever fully recover from such
>a thing.
>

Agreed.
>> Or blocking translated requests for such devices should be enough?
>
>Yes, we have to fence the hardware and then allow the existing SW
>stack to continue without any fear of UAF from the broken HW.

And this applies to software timeout also I think, since both have same
end result.

I am working on a series to solve this for VT-d and testing it
internally.
>
>Fencing the HW means using the IOMMU to block translated requests.
>
>Jason
