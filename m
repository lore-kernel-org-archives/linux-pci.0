Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB943254AE
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677037; cv=none; b=ZCqy41TyXOswgSLF166sQZn0G3iAnKctCd5uUZF6OvtcmFg7gJgntwVpQvw3aXxTUw8o/Q1gw2DZdIJtRBhvy+vf4yMwp8JHpedbIIbeop4St3R8Ey8m2AFN4ekhLZ9gZlrSxG/kCeVoNeaVoqpO7FNnxoHTNFBDS/LhxhnO3u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677037; c=relaxed/simple;
	bh=VInkhQ5cN1UgrkyCqVsf7W0yAPyJU1+jBM2qlhzBzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPZ8xpWmnW0etSp9Vw2VdRUrDguzbklor0J4g814MqNLjs3RGT4/3nOYTOmW9y3qpvtIXSAEjfUo9uxen8sYQKT2gZvehcgsQHcbksFLUNWX6jKFFrLYZDwKNpRfCRJPqEpsrABVvl16RD9CCOs5JskjpLw6/B1MScBMo+tllK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/weheCp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/weheCp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aeab6ff148so160525ad.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773677036; x=1774281836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f55pgibkB6ee+8s3SeqViClU/kNvQ9qZ/ylLM13UAeM=;
        b=Y/weheCpwOKFypb5JRCCbqkQbARpJ0gg5UKZ3L20u70gNb31B+A98JTQDJxRPNpyrT
         1BT47ZquWv8Q8WpBrU+rXXE2eS/BjJjMtpZxJTxogZi0tSuV9gf4pFsk6/VXaWt7FFI6
         Lzjfw2KIZCwYttcgCjqzPcSDy81mX7r6wCQzsW7gvkpjHmMtpl/BmBImlzN08xL8EXor
         LkF8ntWJ8kWAb5jMytzFmsghAXeIXxBD63U/4SSIB25iRWPsWuzkJuIfQ3eh5LQ3RvnV
         DU6U4xo06jf6Ycp2DblajTywRg5TEcSHnfG9Lu/PcfjfYw9VvATNDry+JRT6gOh7NXwp
         acMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677036; x=1774281836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f55pgibkB6ee+8s3SeqViClU/kNvQ9qZ/ylLM13UAeM=;
        b=Aa5721yDo2sUAgWgbM/OmSvCOkYbFRh8mP4zgFp9cxcTl/F24RTMTaBgo61TrbZHG7
         4jHDVHT+V19SdiUWGTzKfAiVurLlX90Sy8V1bBGyiWgn6z660WIpc5cpWE21UlxDIEHP
         6g1Bn29QE40/3zKFLncuodabBCRm+iL1upRKDVLJQ6wX9+ricBrcGzV84DG2ir72RPMV
         48hrVmlxib2o6Cx6v1NCJfTgmfe37p5Qtf42nqTXUgtFO870Gxa97PwrlmR/wcVLruKa
         SycQVw2idcYZ5/mthbWYCFYvZ9pmDYyH3QddQOPVLswFGBX/MHXADmV0YOjm4gButzbA
         BNRw==
X-Forwarded-Encrypted: i=1; AJvYcCVldHZZkhiCDEp9CXybaQQZwRl97uOSeffHa4Ry2KAz083y7wXMfM6wfLTT3BNBFHcJkvhBz1L2tzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw413r5Ruhvr7ycwVE03l/EtMsCmxO/Koykn0dmk/exMVGMLNUj
	OvrqxLWSnD+TF7UXdo6PXIdwhrsBLcJMdjBXjkGCUFZB3cQFejGHQSVvC5Ck83OM6A==
X-Gm-Gg: ATEYQzz7g/cfa+2XAKlEY1iWKtDnF5rmBrhijv5CUHjGfsEFJFjmluaXPXN5qqzWKLV
	u6w6xynA2aLYNqEvPr95zB2gYtu83NJQcDQRczJ1k6Yg/hbrtlp6D2NhOxvuvzbNTB2EjiOkRwK
	00mzy0dKMWfBieCncPAyHKVQkUUY5HmHKyLO5fjZyr8p68GBh8fmlT/2kadVNtQ8ofUPkiGyT2U
	Gk5bYDDv14SJnJHZf/haV88l1rMqlyu9HHgnZRmfZolILl0uOmJPXqSYzL77ntyjxAWNsieSVKM
	g8ePXD6hhlLSa/zVgMKfv4KmW87gJaF9CdsE0bfyHeuUWUVMZCfUqeHWWKHLnFFq19wqEjz8IoU
	Lhjty73Qz9ufduCapjvKOaPmzSGu9pepER/NUhY2u9LNjBxDVgeLXDb4niD7rUo1dg5gOBfkq0R
	Iuq+GWvuJrN8i7kSaUmD0j8dYEvtpeWc9almxo4s1B9MQ9hZeWsE7obioaEA==
X-Received: by 2002:a17:902:f54f:b0:2ae:d10c:6382 with SMTP id d9443c01a7336-2b042102968mr4463575ad.20.1773677035489;
        Mon, 16 Mar 2026 09:03:55 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb9966cesm9261411a12.10.2026.03.16.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:03:54 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:03:50 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
Message-ID: <20260314061747.GD4177610.vipinsh@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-8-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-8-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:54PM +0000, David Matlack wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
> @@ -192,10 +200,24 @@ static struct liveupdate_file_handler vfio_pci_liveupdate_fh = {
>  
>  int __init vfio_pci_liveupdate_init(void)
>  {
> +	int ret;
> +
>  	if (!liveupdate_enabled())
>  		return 0;
>  
> -	return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	ret = liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_liveupdate_register_fh(&vfio_pci_liveupdate_fh);

May be we should rename pci_liveupdate_register_fh() to something like
pci_register_to_liveupdate_flb(). In the current way, it is confusing to
why same handler is getting registered at two places.

Above name will also make it similar to IOMMU series as well
  https://lore.kernel.org/kvm/20260203220948.2176157-2-skhawaja@google.com/
