Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795382390;
	b=nLN1Y6Y9CapvZ4s2zjRJKSx6DCyIPjhOpHYFU3p/BprpkIYYODwqbz9r7+HSrVD3/F4z
	 +PdfFQm3SlwyaXC+Flk7fdlylGeGJuxv+a5S6M3w1xZEZZmduZIpFnVPPj6+fIY+cGpKf
	 QgeUkTMBMS4yxGab81hyE2M/ry5nuTwMwwe1EQbu2wbrjbJbwG9YzSNx41oLXdXT8PitZ
	 dY49JVs8k8jAsVz33VwexKpGRBQWitrt/wcpv/tAVQSiHbX9p3WXwhGDdYUw1eA9Q55VY
	 F6wlxrjkhgqQ/2Z1tykUDQjKdg7osN1ypkmznPiIV3CFg6e3gXtHViNHT97r9nsfeNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795382390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=;
	b=j5vrFpiuTi1tfcTa6Ev7Yaa4mPC6iYl9LdT4gRzGPj2p9O5xoyKkezaF8lPogEsmtZjp
	 cCgi8Dc2YljJGlyIJavj8hQLJHGS+aB4Bl04l1KQjydtu7WlpliTSZl/N7E+zKKh40Otc
	 VVoKTy8VWovqt7j4KCXlzv3ZOZccga3VUC60JcKKCH83oWYcMvjcuA3wSYH1NeIom+DMi
	 SMcCOcbLSZii5GdOU9vRCSWyejK1gKuWEjM9/3Fy/YyIadWUCC/G2zCLxJWmuH2kYg39n
	 4yaXF4a8fBrcPPlQ7sMjX4lbzLuuzMGX8ux5Gf5FBEwb/9H7InxN5YAgfAgOCJIIuJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q6YuWc3T;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC4606A31D
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 21:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EC4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q6YuWc3T
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9f6a16afcso44065ad.1
        for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795382389; x=1795987189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=;
        b=Q6YuWc3T3SalsZoSZ7nZACQHkeGNao4ybVKhTt0wRTBMWq/STNikHYxymoVlbxJKwt
         ObO7f6LqOfkLa0ZWQsDUJxcoIFT1R7RX+ch+NcX9HjC1fUkz2lVXWap2Fhk6d1BNQ0/q
         ou34OmAd2JjIq4liY6+XTlyVs7lAo8j7mMJNCn4UbXdO1PySd7WVB7CcG5aY5NFk6zeK
         MTPQ2mPRuN0yBX2byMj04WfBHffJTGoEmJVbEpdFlNNAdwmn3w7R5fnIWHJ14+7KZJBj
         9JP319l80gUmvzuJ9ttWm+kYAoDSsisjSAMPzJOAjU3H2qQMyoaLkA8b4AIwL0EJiVEx
         8BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795382389; x=1795987189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=;
        b=z/sNk0itpra19Ssz0CAPdSlLEVFhsqNGxMEPQ4feE0GpKFEFBPKUcEUhHiEOLGBGGS
         lrCjXzD5o9+/dAN84ORgSZtJuBorHU5/puFsU84VDQyReqYlddCGqtOux+RCPyWse/Rj
         d2mbhSi2MyTY6o/WcEPvesOL4G6od4vkHsD+3xuYce3iRqIyUr67SyrTzEGCxZsZ//sO
         PtTmqRGKvv17juVZ2btwpIN5Jlo1xDib0cXVHVRWES3MuHCCxMOMj/qNJS4L0zkRgBgz
         zjo5g2AJwr8YtyZVxuwkU5wKcXw6hpEO+Xct1k5nLdEM/T3R4NCfEgMriGSe/fqT5kyq
         a4Mg==
X-Forwarded-Encrypted: i=1; AL+hErEeeMb4c6IL4W2cKAxWEqm/k3jiy8QDYUfDf2bTgyKxWTS8KooOyGjFlrVhYTH/wtof+5h+HVQFBks=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YXmNJ72NR05wyO7PpzoJr+aN32X6oOSgKCH0jKdFZKNW+NusB
	T3/GLjprcSV8yn1n4YUg0CcxvoKLGFAxhFlz0OEFulyt9s2p64pqC7g8wRqCQ7PH1g==
X-Gm-Gg: AZFdTZcEKTryO0jlvY4raY5iUJJTkCX55f72skatN5/1tMrhXmoJ2Op8UAyHB7OM/w9
	ZYYwo8ChIpfbUY//73l3s3RfMI0see2jm752dVHrD3YSeRcTTiGpr9poEq/jjRS1vEzzDHJNkfE
	RCjhcX6Y33+ub7AYj3WhgsSrNNnXJjVCngOc1zPw1G/+p+BZtnvdKZm8Nuu30JVyONS51xWU2tJ
	/OEq503BZ5DSSxYrpmZwY/Th5zLlTGzg0QtDkyf0FLF6REeAmImuksbIeGHpsFgLlRHWzk24eCD
	c7KgvXbzKpIWgzasHiLImlGhZ4OyjEfplhO/IyCaocCAcbnlMxOqmNsrdz4viHprTvfgrg5ZFfb
	WZUyrKZoOKEqy8GsZm5wLKbPuG6x91RAR4ElwWPBx8+Oyn3EuUIp8LxI6FbOTccLuNgTzxeE8Di
	uex2qAlVtCJXh8rWhV+dlMUxUhfZFtxHmS4cqzYovtNa/WZkECi2QWzhM1gT/f7+/1uNvetp6OU
	0foljdj6ITNYhFz9A2veIkui9ignTl04iUAQuzq+hCyHDBa5u4cs1lRTXYA/LFl+Bpleqp2BHr5
	p0w830S6P2C4yHVN+ghHWNr3KhrnwzfHh2AgSogpWFIlMZYqMOH0zJ9+pUcFcEX1deFsTCjcCB6
	O1VSMTBYgF7sPwzIM4honYA==
X-Received: by 2002:a17:903:19e3:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2f066708a17mr4257845ad.15.1795382388397;
        Sun, 22 Nov 2026 13:19:48 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm18461423a91.8.2026.11.22.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 13:19:47 -0800 (PST)
Date: Sun, 22 Nov 2026 21:19:42 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 03/27] liveupdate: Export symbols needed by modules
Message-ID: <awNVk3q6Q6sAHn6U@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-4-vipinsh@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-4-vipinsh@google.com>

On Mon, Nov 02, 2026 at 07:36:32AM -0800, Vipin Sharma wrote:
>Export liveupdate_register_file_handler() and
>liveupdate_unregister_file_handler(). All of these will be used by
>vfio-pci in a subsequent commit, which can be built as a module.
>
>Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>---
> kernel/liveupdate/luo_file.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>index dbae0715220b..6aaa9a531428 100644
>--- a/kernel/liveupdate/luo_file.c
>+++ b/kernel/liveupdate/luo_file.c
>@@ -916,6 +916,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> 	up_write(&luo_register_rwlock);
> 	return err;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>
> /**
>  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
>@@ -933,6 +934,7 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
> 	luo_flb_unregister_all(fh);
> 	list_del(&ACCESS_PRIVATE(fh, list));
> }
>+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>
> /**
>  * liveupdate_get_token_outgoing - Get the token for a preserved file.
>-- 
>2.56.0.317.g454f8302e1-goog
>

Can you please send this separately, it can probably go in without rest
of the vfio changes? This is required by iommufd and guest_memfd also I
think.

Thanks,
Sami
