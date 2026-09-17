Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB84A4836
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655293; cv=none; b=E8DySKytb1bx68+6TNyAh1qEjtkNLg4oaVv0kh6sEHX6aIMu91kLiAIQPUlTZouutZe7nKIdiEGQ8NwsgFJedqaUfwf20GAOx+PzYIx7oyW/JjW/gVN9dhcZ9gRv72gytrGA3HDskgdZFRANLaw3dSK9K84EKqpdhwmxEgLEv04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655293; c=relaxed/simple;
	bh=zD+yqYOk9BEwYrlkE41XIJFd2WjARDFI5ce4WJxm+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzWOjJcFqFqvLIlmyyXKo+j00pZZ3a9ywWna7CdEN3d0ACqARCaDhfcY2+ZFf7r82fs8YswjC39hfEPKmRZYHNT0bEJGVhln5KQYjIXodgkHxnpqeukwshzYdpUgKKsJbUSFLtEoAOgOtKY00aUZmeAJ5/laDIQVbeT1cHg4KEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jOZBXJLw; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jOZBXJLw"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91058dd77a2so9285526d6.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 07:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789655290; x=1790260090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jw1k2NAja1Um952Tl85LJupIp0nZbLj8NYpKbR9I6hU=;
        b=jOZBXJLwf6JP3b19azmsQ5fLkQfodPWKCQ4sDgsm74opbQurokqxNrasGuNyOPVzvE
         CTVWAdgBhof6iu0XiS8kaZ358Ree3L9tOC68tPaGgk6QmS7dj/CAh2cDH6Ri94YsKWYE
         zFgjnox0YrTKuN8CziN0SVinO8YFZz6H8x2igaWxvbrgFrudFRNrFyWtefERJIZGn9WM
         /YRBE5l7nBeTmhMKMbx56N0o1l466lNeHVloV8m2iSh8w9+kxpuV28bJDRjIUAx2mv9y
         5MOsangOpHqTW06zyEsy1fwdV0ITN+uat3lRUftLj9jAXlHsH37VEcNIWu8qGi0F66Q2
         koBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789655290; x=1790260090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Jw1k2NAja1Um952Tl85LJupIp0nZbLj8NYpKbR9I6hU=;
        b=iylMNPqHlunEhti433mmgv8IbGP+WYpPxSHk3c0WnUeiZNGVtCAE5zCes3wQiZJr+/
         X2SGBTTleABiey1rt39hY7Wvvsz4bDw3Wgk1iATEPV4sRcz9WL+piBh13EfM3wqrA16c
         ebt/QdL3ztDuXS0zvG1PNs9qaDpDSa5GQ8PtZ1mt7ySNz9d/rnDc6KSoenPrMD4utqKL
         vwJcuHsSP0kzkTy9Nq1cr3qCox50lGDxM+j1yNcYHmZbNnvtvOVvLj0umZwsoCiMS+gh
         tu3vo1nUYaKaKfzSyyQoeEttQBAa/Z7wA5LB1BaNv3j0HbY0F1dNCW+dQyX1jDLMTDo+
         p9vA==
X-Forwarded-Encrypted: i=1; AKwUvBzHey9fHnMoJoeJZJzno2tf7bpphh9pG3g8DlgmMRL94OX/a0vJsGadQWtKDpmSrzvXbgcDJwGQ0YE=@vger.kernel.org
X-Gm-Message-State: AFuF++l/fqXASm3BMYyiQYjhvKdEtwipzzmcfNvN5rs6jQizS8imXmFR
	wLm4nZZMKefBq5t3hojvW3Gc3pXWczxaFZOaSQkt7Jh8ASmFjYKuyWWWs/p2JsaSeiE=
X-Gm-Gg: AYBFou3u/TfAA09ei7oO/GM0y+iPA5MyjVySVRHZ5fgRGfTg3T0ANjX8Xx9mK+g0U3O
	4ZOQuMdxu3fKx+Pq4PAffkG6+JkOL2Qi5I9J7Wyxd+Mgxd8aPiCTcsFfiJMBakGquoFgGpusO1U
	qSWCoVyhWKLQavOwVqr/KMWDPgOETjZjEST2MGltpgwM7SACxSC5gQ8MYm0CTvbwk7Wx8gd6Hy9
	D+LT9tk7itsCs4EZKlXEXV9uOVmZUOdcYRHYzD7O/Nd/JAoHKDdYzzwpeZ7/uNryRwWqwAN9xZ7
	/zXJbTOz1abAxxkxKoZJq4JJK5yUCzvZZdqxAdrs/ThubiuQ9HrqwA1c+DTGxPrxF5cqdmkGkSs
	J0tUaEZUkhHHLDJihO2fkhj9Ex91u+20cHkA+5xijNe/tGu5bTHHcytEaFt6yj0IOo9O0BaMq0F
	AwOXGnVx+hpuOnjs6HJam3JnEVdLc7DykBsXLb7TrhrXaHpH5iKxS5lS21fEZIwUAw/C8WqGzP8
	ZGGVKBYGGoXe3G6HUZ4oKvRAJjrrdgPI7cNsB+paN7d4pct+BLjFbtz
X-Received: by 2002:a05:6214:1316:b0:912:517b:911 with SMTP id 6a1803df08f44-912517b0beamr9926716d6.48.1789655289706;
        Thu, 17 Sep 2026 07:28:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be9ca82sm51192626d6.32.2026.09.17.07.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:28:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7D5s-0000000CrE5-25RS;
	Thu, 17 Sep 2026 11:28:08 -0300
Date: Thu, 17 Sep 2026 11:28:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, Tushar Dave <tdave@nvidia.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260917142808.GH3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <f3708893-4760-4157-83a3-313867a94e78@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3708893-4760-4157-83a3-313867a94e78@amd.com>

On Thu, Sep 17, 2026 at 04:00:33PM +0200, Christian König wrote:
> > However, at least for the Intel GPUs, ATS enablement is based on the
> > PCIe-side enable bit.
> 
> Yeah, I can confirm as well that this is something really exotic.

In most datacenter systems it is only the NIC that initiates the P2P
transfers, so it should not be surprising that NIC HW has more
optimizations for this. In real systems ATS carries such a perf cost
that you do need to be selective about it. I would expect every
serious NIC to have this capability or it will not be perf
competitive.

NIC and GPU are using ATS for completely different reasons.

> Additional to that the setup that ACS seems to be disabled for some
> bridges bit not all also sounds extremely uncommon.

I'm not sure where you saw ACS disabled, you can look rdma-core now
has a tool to help people get their RDMA NICs working in GPU systems:

https://github.com/linux-rdma/rdma-core/blob/master/kernel-boot/rdma_topo

I would view most of that stuff as completely normal at this point,
people have been doing versions of this by hand for almost 10 years
now. Especially the asymmetric translated/untranslated routing.

Jason
