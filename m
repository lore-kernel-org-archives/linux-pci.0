Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366245D5C0
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988157; cv=none; b=msC19811M3k/ZoH54M5sppCcWuc3GgC9plE5jest4BTue9VtFB7zpE4mPj6UEkUIVMh4rNsqpg2YedIST3N2t824V1H1r47SxF+E6Y/NslJMre0vziQTewU5BD7WAhee7AsZbrXopQIriKRbDf7AapvJ2oXpZwNIipJcBj3OMhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988157; c=relaxed/simple;
	bh=+e98k4168mAh10/uMiEYObv7JgiKCyhKONJNJqBtoX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsHJ5IIdDwfrXL4w7hCSl71yDG0v4XfG5hPbOIlbM8vwccyLwGbXrn2xIuji+CMKmQi4FBeU2AIxJ18/l6uBODC/CmlcZ/gw8XHhHWCRwUI+DfQoS5K4fmt3Od4BnebzfAfFMSyegZXjvB02lyf5LrnnpSKKRpuXPKZ6Mgp85qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gw7r+pwV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gw7r+pwV"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f256eaedf8so36726746d6.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786988154; x=1787592954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7xTL49KfLwAq5Qv044eqsaTTNVVybZ9ovZEhY6mKMv0=;
        b=gw7r+pwV6rzaKBcmZKbwEorQMsOdlVWe4SFpxiD/v+PRtMIy4J6HyT5Oi7RHiQrWWs
         S7sgNNTz0bKsFxxJi4ZjqFSvTstHa3USTWT2Eipq3w3i5siHj0sMdeJ9G9HfzAN9AFGw
         AS/9rqZoB4O5CVatSRFs+PHzWOL8pLryM/kM8YG5pChw0pWNRZTJ/m0Bvs3BjAwXOAOY
         SlFoeDIVLBpfLDfq6xuZMB+RAtAaXbsiayBy7+lC48SmZo3iRK62RcUwpJOrqErVGTVF
         VDrG6vkwao1Nu9bVUxqDAOulVQVW88mTNz2SToj8FaeXahz2c02MFx4esKc7GrCtQmo1
         4yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988154; x=1787592954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xTL49KfLwAq5Qv044eqsaTTNVVybZ9ovZEhY6mKMv0=;
        b=KK29CqUCzhz/pT+7u4h6Eoq3r2X1Gq6xXtkn9c8knLmsJm6ISocbyYiRbHUf93a+sq
         dKC3jngpanbgV2o4KB86acdqlelOFyS/FfENglqkiiHRrZ2oW2wddCtVlb2C0yD5El4i
         RlmApWa9p88wjSsnp9KnauI4EVzZqdBG1LofU0GmvQocRGyYk6KmZA1GbEloeYoDbQXR
         EVnXbe5/sR/bfGxeyxuK9H/DSpLDlcGujK7/RKYUuSEmOMNYq8vQo2NXu41oeNxGwMHj
         CJFKxw35cEtdV6yCk/YgH63lo6XtmxINApbRECEq6rRWAvJNXxMOqPWE3y3hPGFw7NFx
         gWYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+CmWfGLct25Ip9jrHBa1yXcoumvimBXXGX2v2oAzMUqxD4+uSyIbZUEkdZ3K6C6Cme0OAEIMsQ/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM9gHGTkY/BBCWnDB4T2Ugqu4pq+cqlJ3pIIDxBofAgymEUvVV
	CtPRrHIv2owGSIntQDuCoT24NShNKUy4oBrsxkg5NViRCiQnwJn+HExrWTT89e/P6Yc=
X-Gm-Gg: AR+sD12lxDV0dPPw2ecm53QN0vYz6Qgl4OQKX9xVBS6nOLT+P4+lUcKJADB1EobBrmL
	Fmy441QjxAhR/zjYBU+m88vEhO1QUNl/R7+y8oYSZi8E8kZWHqDvbYyUZKzkudjoaB8wjGFY/4G
	2uBhqz2djE2xhubofuIKplwbKCbQFSi53mZk6CouWn38uy0whdb+4JcxHQ+AcJ51tkUXq5Yag+t
	HyVYDKAR0iw20zJ+WF5lFKKfTQQp5BW4N5uMOjPEujk+Sgiq443oBfRHV5VOqZVJmBG7Sc524RK
	xp3wAeDn9Yd844LVE5zwqVQV/muK56nXuvZnbS6SY81wKbUkKRTCAT1Tc/d8u5gYUAiJEN9Vy6t
	oIWfixDsBnJSSD0WrDMlLAgyE7iybO5C3Pl/8PJVcHT7VcRQ05KAvJ+opPP5WJbJCIdYy4TbYbD
	Y9/G38noKHz2LR6ThpiSsjLHAdhIcLpavzBWbKtg==
X-Received: by 2002:a05:6214:e6e:b0:907:bf7a:9771 with SMTP id 6a1803df08f44-90a91def3cdmr277120766d6.21.1786988154391;
        Mon, 17 Aug 2026 10:35:54 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580f90csm13765356d6.9.2026.08.17.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:35:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ww1FY-00000006A9C-3bVH;
	Mon, 17 Aug 2026 14:35:52 -0300
Date: Mon, 17 Aug 2026 14:35:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260817173552.GA1418894@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
 <20260817122216.GD933791@ziepe.ca>
 <gk7lcfk73uzntmnmf7eb5clp2h7q7oqb7lykj2qlrrkilotfvx@mf6wima2kibk>
 <aiioa6ospojivued3djhwadyfpit5temyvrgm3xxzhzt6aqbiv@hqz6q5bqnl6w>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiioa6ospojivued3djhwadyfpit5temyvrgm3xxzhzt6aqbiv@hqz6q5bqnl6w>

On Tue, Aug 18, 2026 at 01:22:03AM +0800, Yu Zhang wrote:

> So we could
> - either keep the duplicate check in hv_iommu_blocking_attach_dev();
> - or add code in our common helper, hv_iommu_attach_dev(), to treat
>   HV_STATUS_DEVICE_ALREADY_IN_DOMAIN also as successful explicitly. 
> 
> And since normal paging-domain attaches do not have this duplicate
> case, I'd prefer the first choice, to keep current check in
> hv_iommu_blocking_attach_dev().

I think everything can technically be re-attached and must not fail,
you have to handle that possibility everywhere.

So accepting that code as success seems like it might be needed anyhow?

Jason
