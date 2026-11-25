Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616245;
	b=c662WmWdouDiCeRozOB6nBxOHAs6TmoNJebZisnLRYtkv+TsyIK1BzVtNHsAR0yzRtvt
	 0inU/5AAgrIdOVmvYwf7+jHLS/xPsl88FJhxqKqB2ouG8lhCMbzZgnf+QBbnfp+iLSQR2
	 uOoE/26Wmqp47N6R+dt6S5Vqww2THyigSE5W7YFZxXdoGVi/G41cPvA2nOyMoaJnCJFXf
	 CrjxrxhIvhmtZRy881du9xWa/Npi4hhgAxWiBn/aavqOc5wgAXrnIRQrn28LwMCm5V+H/
	 DwoIbAy7itZUmbP987Srcqk9yl2OofN48SM7fUd/yhG3epa5rbTh9fl5YWJHttNO7uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=82OlthbTcf764s1+nsFlIqp1XEt+X8IqMsOwsuhDROg=;
	b=Y9qDpSh2A0j1fUsRU/8zKG2qsj6AiX0DUDkxUufihmVwQwQD+J63ugiCGFpWKnK6rz6j
	 T03IazG8HAtJmEKSeTq5zVe0JYP1Lx7epZg4osFCkkC6dNmdUy/qu5t9A4QgmWmi9qoGK
	 xw2BIsA9yvutOJDzTFcx/xBj5uGzOa4IhjcnZyVXX2Z2ZkS+fSOHndnMBiW7WVYodw2np
	 evecmrRwJmS+TzXFxb15pKNalU9nb0jEFUtCpp+bgnD1gZyQKiDjwuzYRqdA8hs4Ld5kZ
	 oGmoxkllXHLhbRHUQzENL88lem6rAj7RCiUWtmhYeYA9kBAjUcS88PXHbny5v47r5hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KddeLS9u;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DA606A332
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 14:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 980DA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=KddeLS9u
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso2144841137.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795616243; x=1796221043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=82OlthbTcf764s1+nsFlIqp1XEt+X8IqMsOwsuhDROg=;
        b=KddeLS9up5mvCSfJdm5fK0ipO+yq095aye9y0p15L5JlAkHX9DbgwuDUdNKrNobXeB
         nqywtiZOYZsmjds/xQ4YRmxPnBA6MGWE4xP/x1WhKA0FewNf9h46pShomX2MqJEHuRtx
         sDx/VduWtpKHevJG9BFB7vgzn32UYgg6eiQx+tH8x8enfIcrvbbbAmCxCqB+39SEMmUC
         eoaSSQTrh+qgfxGrkl+Nwrzq77nIJbhYmqENWe0H4pKcRbobW4NpCvi7EYIdlPbIGPq2
         9vhJx8Bk3mUMIfBjdgNn8cXW4vdOBRiSKwhHAo/pBNkTzu8RfbN0fKu22t7cZ+jFV0nA
         mVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616243; x=1796221043;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=82OlthbTcf764s1+nsFlIqp1XEt+X8IqMsOwsuhDROg=;
        b=V5XpCwdAOV4oPkLSxonwJuUSUnI6ktTKbS0WUHeuDnS5Da0fYioYWYuUqYq7LOt/0d
         PwagkBRyKJYQcHt8WJ9gVYQrNRiJv9FOJ9KV30kGLuu+EKIvpvX6/sUXZaIdF/aTNsb3
         UgmrUiJoWqucQFsKT9FcpSc4sTXGSOcTzGI/dxDvHKwDIRJffSob84xKpZMyTk3p4pM1
         BuV1IHKh4mW1W6PfWCR9C/aWlHHhjBvEuwaMK3M9pxs/N3cht3MwpuVlsYcMbjGpEH/L
         E6QQdqBVbpjbiXZl2rFaqIMfgviGrBC3SMDzr727R2HTjzH/St9O8yjc2fayJLenB29t
         JQ4Q==
X-Forwarded-Encrypted: i=1; AL+hErH5R8V6//cBvd4msUFOy2SdDeRAFuXmJEQ8s4oM36y7111op38s51QKyLENBi9vrhMhTbwrCdyWnHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lFDodNx9uAygnH2SmCpP0+86hS2kDsKxDdaVknCb9cLIZVy1m
	LnAFittLAJz5VbC8fLnniP1lq0LGSuEUzCxxMlXosNqfpEbmz4A9MPDfjlROZcm0cxw=
X-Gm-Gg: AZFdTZc8VkZ3a3C26eh37C/XzQDYY6rqKhwrlN0VRDPQZWPdsqqwkfulUEonQM3CcIR
	jMR/g35JLuSlTxZBNag06OhO43FGXd6n5t0ppRiiBpScvS6yuRaly5g+NEksBcf7k+1Fxgzy3iF
	HIH6/LSKikhbd9n5iT2ZqSuU1Wrn97zlquQ3JN8c2cj4GGsVnGPJ46VLd1gi1jvSDtMSLyaAH9T
	5ht4vDcyZgyUCKc9Bhxmj5lS6/N+WBy8ZRDN4AjDn418XR4BExdPlyI2E53CqI+zJPwZOTrAGgL
	4B/KkyublhNZUpRD1aG8BShm1ciykf+m4PTs7JermQm03D4z0RhuZa8K5SOveW6PhbJwc90onoS
	wccPNRpEXmm70Xxr7z1W/f5T4x9PBDQn3VhATvdpL3iGDFxiYC1gl3ZP+ARt1Ak/ps/G/Qyljtu
	qwznX//BqzR+YsI4vk/uexJ8gBZpQnNEuho9QbcOr1ufFq6WyoWkqEqc4jI5qwuYLFbTtRrmwJf
	bcY0qBRynTxeqLLPVjN1dI6xeS7CSuTa4VoOyrcNoo4xQyMMWttd/PB5gb6PGT4OwzVsOvu0g2L
	DqbfVg==
X-Received: by 2002:a05:6102:374c:b0:7c1:75c5:c4c with SMTP id ada2fe7eead31-7d739570939mr8150077137.25.1795616243315;
        Wed, 25 Nov 2026 06:17:23 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921645f50f3sm60805116d6.24.2026.11.25.06.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:17:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWDoI-00000001jMI-14hV;
	Wed, 25 Nov 2026 10:17:22 -0400
Date: Wed, 25 Nov 2026 10:17:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 02/10] coco: tsm: Register the TSM class before device
 drivers
Message-ID: <20261125141722.GB246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-3-aneesh.kumar@kernel.org>
 <20261123152903.GG179082@ziepe.ca>
 <9f92f7ed-5198-45aa-9cef-515ccbf98398@amd.com>
 <20261124170754.GB114530@ziepe.ca>
 <17ee3598-9cc3-45d8-b068-31fafa06268a@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ee3598-9cc3-45d8-b068-31fafa06268a@amd.com>

On Wed, Nov 25, 2026 at 02:34:38PM +1100, Alexey Kardashevskiy wrote:
> On 25/11/26 04:07, Jason Gunthorpe wrote:
> > On Tue, Nov 24, 2026 at 11:40:16AM +1100, Alexey Kardashevskiy wrote:
> > > On 24/11/26 02:29, Jason Gunthorpe wrote:
> > > > On Mon, Nov 23, 2026 at 02:03:29PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > > > Register the built-in TSM class with subsys_initcall() so it exists
> > > > > before a platform TSM driver probes, independently of object link order.
> > > > > CONFIG_TSM is boolean; remove the unused module exit path.
> > > > 
> > > > Why isn't it modular? This is going to force alot of stuff to be
> > > > non-modular.
> > > 
> > > The TSM core registers a class. The platform TSM drivers register
> > > TSM devices of that class. If a platform module loads before the TSM
> > > code - the class is not registered yet so it fails. We could either
> > > teach modprobe or have dependencies in the module or do this:
> > 
> > I understand that and Aneesh's patch is fine to solve that problem.
> > 
> > I'm asking why it isn't modular. They don't conflict, using
> > subsys_initcall works just fine as a module.
> 
> it "works" because it is module_init() in include/linux/module.h:
> 
> #ifndef MODULE
> #else /* MODULE */
> [...]
> #define subsys_initcall(fn)             module_init(fn)
> 
> and then the dependency problem again. Do I miss something?

What have you done to make that a "dependency problem"

The module loader chases the symbol graph and orders the module_init
calls based on a depth first ordering of the graph.

How do you get things out of order in that world?

Jason
