Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C6280338
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570545; cv=none; b=azAdA0oKL5qZjFqLw6m/IoA6dPZoCgM1UIULPfqb+0j3Bpbq0/FmHeaY+G+XbIQkyDDWxlcnT0IoJxU9ESq5+5kzxV93B2Ysj20yc7XpeZIi46GFD7nXBCAo5Rh9hTu7Pq2BnK1CvqeavgvcZVCyx+Hb1lTwdTCwaPg2nSItb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570545; c=relaxed/simple;
	bh=dLd2xq2uaf3rRXOHvRSNS0csxsbcSNNyU4+pJRavd9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYTgPLxl25RYv/2b9ZCNkPhLB3ABnIpYbNRxA7xq/wv6BigeiEuP6OIEI/PcPlSxxypSJ+Wwon/dLuM00jfE6YntgVv7d17SyDC8x6Cj/G0YcOa15VqHpfd7XqwugQxZ3lNcJBCcKRh/oAT6iEjuCxhttelLfvAciCSpTJ46fR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syowSQf8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syowSQf8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c67ea316caso12855ad.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 17:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781570543; x=1782175343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLd2xq2uaf3rRXOHvRSNS0csxsbcSNNyU4+pJRavd9E=;
        b=syowSQf8wLSWGtS1PgGodgassz1O0d3yWQC/H8bw1NwhJXnr2zJeiuj2E9Ro7P8b6l
         0sKRW0UZFDTu+eESKF29TzoeA+btPajRdmHAwn8Fq68xybv5XIGq84mQ5N/mCzA9iv90
         tqL76uIuG5kg5s11jGw7XA/DJp7SuL2b7rLOnd+J61Tp2e9hVRkxujRfT3N8Z4G5V+iT
         JRdBHxN17iGa6R1QsD9eJ30qxHswfPElKqYT+dbJCj9baxjbVpYy0TVxWpgBH9lXGUre
         FFWVCLGYk9RnLU9bmUm53V0robpx5+adag8sZtrLrwcaCjFlJYvIEQjn9orrqr/AMG8f
         TzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570543; x=1782175343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLd2xq2uaf3rRXOHvRSNS0csxsbcSNNyU4+pJRavd9E=;
        b=ChsRbd+n5P7LhgQ65M4zUNW+1Ql01k/He9xXjiBfTh9MN7INFbpv5zoTB4R96sbJzu
         qkB5A7kIFDbrHbL6PnliwN+JFbisdZv+Djd/7cBKKUzahdsl2xm7mTAQaGA8MudFFpig
         7GDPAMhuB8WdXpBHEUVfbCJok69+SSKkw6ahUgS5QBN0A24PZ7OYQ8FT+rztOVDTC0dK
         INdUuQokj2+QPEY3VflKspsl+FwYhPsusM7SNAGi701Y2Lk3zIp+BBgElTOKxcjfTGzs
         4kOqcGX/e5eh7LTgJDXOwxn2ASVIBhjZQMNyGQLwbkg0VKJcfvgUabKAy3iFdTCpZdzS
         OcHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Fg/BsurkXmF047WGsae7tMVZXueqkQMnM3+mK4v1HIzCaOpOtl2WygOppNFwtAfSAMrA1x0jYCNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmpRtHsGN5PDzlpUecOAXYzl4gWSz0gjZdnr0+x6aYc0EmUFM
	P/hv4qOWm3xuxmjeNe6IIbt/SaYC1bcB9tlDNEXmLtBxdoS0g9aWIpgjdeOf6HO3/g==
X-Gm-Gg: Acq92OHE3SafS76iYDYTbSEeRZV001xkDeLpVnnWhQ5nN+1in1vi/K2Ih9sCBsX5Auw
	fdjA2D/4EUOY9ej5vvYoTtgouRrcrNPg4bAAlFmAui7fUwRTMxutAyLx6v6qPE3Zf2Jl5dZHv9T
	pujmwjdF20nhs1Z9sgfq6eJqVdjmbRYrsFcnRFkPrk2sDXfuQQPEgvXSV0Bz2xXwwnzn1hol68S
	XC1/pre1eBh/0DFhM659+Xnqq4lI6HbwpZ+YQLs4WAth4sO+VWctM4/MSBmjD+pncfq6cAz93G0
	k7cbvXcrApU7Q2BPrNqtgkYTYfpBXcAWOCoZicDWccIx3E/46SFmLc0D565aPyF+ihCXHEX4gp0
	SOCETTINKd9ZZh1qvgGiQp6RylTNFO/2owNEsS2N5VgPZktpdIoABt73tOvNNFTb9+38TujH6dh
	YrTU3s1T+aVDH745iew3Dpl6/haW/nnOv4P29nGCEQDKciUXrHYBuVZJQNKbTgSgkmhtzWvPEQ5
	1rYbWz4lPlm82InyNM=
X-Received: by 2002:a17:902:ef02:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2c69c1d4b35mr692755ad.13.1781570542499;
        Mon, 15 Jun 2026 17:42:22 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661b5e509sm10014682a12.3.2026.06.15.17.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:42:22 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:42:19 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Alex Williamson <alex@shazbot.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <ajCaTmrYQvKDoP_I@google.com>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
 <airI0VIb563jHTcy@google.com>
 <20260611221447.GH1066031@ziepe.ca>
 <aiwcquSgAonkh_6L@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiwcquSgAonkh_6L@google.com>

On Fri, Jun 12, 2026 at 02:50:18PM +0000, Pranjal Shrivastava wrote:
>On Thu, Jun 11, 2026 at 07:14:47PM -0300, Jason Gunthorpe wrote:
>> On Thu, Jun 11, 2026 at 02:40:17PM +0000, Pranjal Shrivastava wrote:
>> > On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
>> > > On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
>> > >

[snip]
>
>Yea, that's going to be tricky.. I'm thinking if we can have a zap model
>there somehow? If the device is gone / going through a reset, we can
>handle the refcounts accordingly?

IIUC zapping will only work if userspace is using these, but if you feed
this memory into another device through NFS and the pages are pinned by
gup (or that device) then the dmabuf move_notify/revoke logic on device
reset will be tricky as now the pages for that device BAR are pinned.
>
>>
>> Come to think of it, since the sysfs API cannot do that in the way
>> VFIO wants I actually think you can't use it..
>
>Ack. Baking this into the VFIO DMABUF allows us to enforce the right
>lifecycle.
>
>My plan for RFC v2 is to add a flag like VFIO_DMA_BUF_FLAG_ZONE_DEVICE
>to struct vfio_device_feature_dma_buf which allows the caller to opt-in
>to ZONE_DEVICE backing specifically for that export.
>
>Does this opt-in flag sound like a reasonable uAPI or do you see any
>concerns with this direction?
>
>Otherwise, as you noted, the lifecycle and the mmap path remain the main
>problems to solve.
>
>Thanks,
>Praan

Sami
