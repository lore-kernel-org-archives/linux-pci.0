Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BD3D25C2
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785952395; cv=none; b=nCcem74vCd85dhM/7gWJpGYvfpk8YANwjDWOD1pMPEqZNVi8XA5tuMMm2/u4eaqxv9rwZvaIE9vPA+tZpxkryLnOicJ48JP4hVbZRWR6QlN1prYxd9r50urUvJKCYS3jv8x6EK1KRNxyWup30lzcy3FoDcm7ICPsgDqIJJUWNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785952395; c=relaxed/simple;
	bh=Eef5ElAhvjwYsNQZNCKEkPD1dzKCVhwpMG9f/2c0aao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0sowFpg+dnS0ICOfD8NjGDGLrFItt9hJzwdmu3+9K5Ip+oBfBBIHfwofyf4pB/NxX4JmQTWiNX0haHUrRxrLxjqMXjUbmdFn3piHQftijpmtNjwIIQcOUfuCsOCA8AtYw31itfTNQCnIy9b5H4SWMqcxRCOv8k3ry7LOoVfkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KVINy3ab; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KVINy3ab"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-934974844ffso85490285a.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Aug 2026 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785952390; x=1786557190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BYujsHKY9Yi0o12oj2KV+6lI8WRPwZwwfuqCSMDtZ80=;
        b=KVINy3abN7B3DHYfF0uWBQjT8Xh3y5AMhQ/zbQfAPeRZB/bwSPg7hsFI18riuyvPYG
         /CHba7yUp/H9gIBLN75jE3GRk6Bh0Hc8a1dDKYTzR9Yb7gw8Nu+pV8yWYAhjVOsDCH/x
         7Ktroc+p0NSoK3QqtRIUl1mRrZguc1J1oYGIvpNq3UXMXDIGN+uq5Kg/O7zPOjIKfo3U
         NEbMKR2EOPDzZGlJXiUb4hiflxqm3aZaGaSwmKyDiOFrAzW5pLMBNUFHAJvwK6qW+Hc1
         Zbf5/CQL0OFEcGMacEk5SOGcbrVBMaS5C4920coMa7iX57tn6qY527n4Aj1Gwv0x2uuV
         wDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785952390; x=1786557190;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BYujsHKY9Yi0o12oj2KV+6lI8WRPwZwwfuqCSMDtZ80=;
        b=OHEe0jack9oLIpJ8fkulfaaHFWphRmD4PY/ZcQtldWoz1iOsGsmjoqPq/K+0N10obb
         +libFZZNLCqJ/S2QmxWquJEGwhlWMDmB5Sx5JHX76TWdzHvHzeUDb4v0s1i/Y5PeI+Je
         14qbCuzDI4jkQKvxJGZSkvraptfmV1cww/u88wXgxnYZTb9nL4pVgxJt9EnH+p/NcFC8
         JNwRPF47T0wf5v0YtzIYPhk/Dzj7YKil/JRYKEg8Yf4e0ySWh7NMX/maGM5aTrM13nmz
         BqlIGYp/dbyz+X959eVQc+QErAlyY+2gWqUZu1nS3hNuNo8xi/x7zv/nTSXw4xYjsCkL
         T0XA==
X-Forwarded-Encrypted: i=1; AHgh+RqgyS+7QSsO0HYOPe/KBCbH59BdrJMtK/hRYPIYupNPpLCHfJqF+XeXiHLEbq7r9h7Zsl0nLPyAg18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUzN3EUlNEIOMLA8dSxaihTmW3MtOoQpAefR12XJz2ma9g/gH
	zuA8R8g/6u6y3pDQggdo/QGmA9C+JWBfxMmBLLjnI/2QT/VcVcaF3r1Xfvo/YEAtAK0=
X-Gm-Gg: AR+sD13z16iWVUk/ddMUvDrs9dU/iVyx3o7vNKO1R/UfsO3m3cd44tKaU+2pi0pvFXv
	SZgIrEPgsQVxKp86P/PduBnWAueWZNeGwXlq/FMP/XnjOwm7sHtciyxAIV6pDW0Dvx4s6w8djzp
	y7p4CKUg21W48tNvD1z/VV8mWQLf6FFTJKJmJQmiSbCUSrEkzUAJ0q3Thgnw9+fKGUrwTfFGoTw
	Pc8iMv30scjFb4mfJahH/a9MOne3Lt+QQuuEwsaUDi+6CJ5YKSGUXuAMZVCNSeoh0qbYgnlmtr1
	4BzbpfE0cCwHy8hWfs3OnukH/p0SqrSeJW2olEEGbweJIApebUJ+XqRGiy7eL9HEou3DIpdslZY
	5QPPtswYLw6ksEG3Vyvp187x82qKhOTtkLqb6tQX/0/9GZnKtrtGMWVD/pEeSTMFYGWwUpMhVf4
	D0xJr3a+8ZbjRqnuy93XDTuaqefCJNiCvnV7xCzA==
X-Received: by 2002:a05:620a:40c7:b0:930:cb79:ee65 with SMTP id af79cd13be357-936492066fdmr788993985a.30.1785952390204;
        Wed, 05 Aug 2026 10:53:10 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a42a461sm201000685a.12.2026.08.05.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 10:53:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wrfng-00000000ITS-3vYK;
	Wed, 05 Aug 2026 14:53:08 -0300
Date: Wed, 5 Aug 2026 14:53:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260805175308.GD28508@ziepe.ca>
References: <a2f38742-c8a1-4dd5-9fcb-120c1c989203@amd.com>
 <ed296c0d-246f-492b-970b-49c45e25f5f6@amd.com>
 <f4355034-d40a-4d11-ab98-eef0f2991f33@amd.com>
 <838281e9-8ee7-433a-b06c-68675e9b285f@amd.com>
 <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>

On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander wrote:

> IIRC, they supported SME, but it wasn't usable due to other
> limitations (e.g., the requirement for identity mappings due to the
> display hw bug and the latency impact of encryption for displays in
> system memory).  Do you could effectively pick either SME or
> displays.

IMHO the GPU driver should fail if it cannot work because it can't
reach the IOVA space requried for SME ...

I don't think this should be a iommu problem to deal with

Jason
