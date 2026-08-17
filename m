Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537B463B79
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986976; cv=none; b=RJBGWlwDVX09BRMClbwntfQb5CBN2it8mo2QdGtKHAX7Tf1ViBtg3Ca7dthbSXhf2JYhQcAIRnGejw4VcKcNRCc/Wa+oU4Yn8QJ5rF2skCuvQgcT1tZLm8cmH7tOooPk8p+UpC3hGEMEiLQY6nExxf96ZAF6YDBKtDEGEeQ1gis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986976; c=relaxed/simple;
	bh=dU/hih0hnP3rkicxnLGzGzbvz5NWJvf7JF/NG7uN72w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dX5kKpRFNaqfumduDOWSPQIoV4tz8L70lbxSRWa7tFxAifDIIHnMqAAu7N2ep/X+lqHPiQ5PndIBoX+/7mw+FdxdbKPeXKqBzEH4kLXXQG8ZaLyk/vKOpjdsoxvQm7NFekjRHzp+DwUTTtpHEO9I3clGzTGqFeLbHS8d5VvG/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+YgIFNg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+YgIFNg"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-472326ca506so2573054f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786986973; x=1787591773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7vHVmK2OakVdQp/KOqM3ZoyU6wCsebXeGNivr98rrpc=;
        b=h+YgIFNgmLvUPawGDcpX/VQjV8o3Yt2E2k/+GEbAVjy1f6f+LgDPihx+bHXKs/71+/
         JOFKCGeqW6m+2BqIC9P/r7xS1YsFvY8g7sDQDBEVRev355OvMgFTSP3zLCmGMREcTz9M
         j9TlTTmDojGAdq1KDdexOZnGGM5LBYESzZrqynJI0NROj6Sj34sIpa5TXGvF5WLHdfTI
         DZLdFf1L2dKW4Z1YBjcaWUIcSI/j5ZMeH09kxmYle5QbyLWNX3jK8r70QtETJdNt7L+q
         g2x4BlX6MMf8u7mDRzOOWee8aLMf+NFN5YM1L1Q3kTiqJ4iwdXg/boZ3AaF+0iEkB8T0
         PWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986973; x=1787591773;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7vHVmK2OakVdQp/KOqM3ZoyU6wCsebXeGNivr98rrpc=;
        b=G/aB7apBDptofk8pahiVU3XHhwxxogLLPFeL2iZyE5WGXAmEZ8C6yNRW1Re4IH09YZ
         YK2/1nbfyHtBXLd07Hk/c3WOKhFEq4AMa7p+/P4ZAahWNKy4z9vMPWqamL94PaQbXq3W
         6TdcCQR5BeJ7yCBDguITvprHuS3tvNzbbHnpFmnnePe+5Hk0kMYgmAUXDHtetyXHfs24
         ofBMCwWHASCKR4y8JplxVEWLzuE/TeJrJ14GiN//rR61k0/oXndCyUy1+0cy3l/VSJ/v
         0dzIimI1kVG1fqFQT9gGce7aQ5dC/uSsydBfjjAuwHAoxVxh7vCVdWnbG87ksEBzlqQo
         I+5A==
X-Forwarded-Encrypted: i=1; AHgh+RoxtVBfI2LYdfPQFKXHQ6hS14R5VcqolYewdLq6UMeBGpgJDvd1TJnwAKDeoZ9YZejG9uO/jAjDCCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPBM39A1XNYDfeiQI/i7hKiPzMvqVFDKPEukQcXH000dI9ZMjV
	h46unyVn9XFWyQPKCQ5fzar8vdXUcL8SmwUoif2eMRJ8A1Kfa9yjuPtg
X-Gm-Gg: AR+sD11HEZS0UwbPdvRpnNlnr5ySHMoPqtPLW6z96jgH6WjIi8w7n6Rdx7uG+nspw++
	hvy+J8DUsQHFk1XwlId9sT5LrFn47Qj/CCkIcjXk0TN3N6F+Dl0IQY4ka+rH/jmcA3saQC0ZBzx
	jyFfTvEWbS+QrBtSlilYeXbw9cmmnlkNhFxbxU2t7Jyz8rU9/4JkGtcacmtyMODcevSwbll1dH1
	RXQzg++bYUw5dneyce2uYd4kaaMq63/eMkUYZ1kYeJIIw2tYuQ1TBCM4/MoTsxd8SkB6uJfy3q1
	I7ivrN1Vm9xrcEkfuTsUXzm5ICUOQ7HGAntbLbY65sM29x91665Cnh//2S8e/HQGpfDAEXXQIaB
	KllYt4BAyiFP7KZIqQot7MLxs1D5uixhdTKGofbH8S01+K/GO6/g7DrbzXUWKBL7FIfrANoZ/rX
	wRA6mG/lFJN+Hz8/GT7JzwUp5k4kPtPMIfssfMQ7+itp/7qZpqk6gQTbwYrkJlQKpVyfI=
X-Received: by 2002:a05:6000:46d7:b0:47f:9aef:5515 with SMTP id ffacd0b85a97d-482a9002c0cmr2267004f8f.13.1786986973156;
        Mon, 17 Aug 2026 10:16:13 -0700 (PDT)
Received: from foxbook (bfg7.neoplus.adsl.tpnet.pl. [83.28.44.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b783d1sm5445518f8f.25.2026.08.17.10.16.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Aug 2026 10:16:12 -0700 (PDT)
Date: Mon, 17 Aug 2026 19:17:31 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: frank.li@nxp.com, corbet@lwn.net, dmaengine@vger.kernel.org,
 hch@infradead.org, imx@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lizhijian@fujitsu.com, mst@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH v2 1/1] docs: dma: correct dma_set_mask() sample code
Message-ID: <20260817191731.104171a3.michal.pecio@gmail.com>
In-Reply-To: <aoMty9Dvt2bnWm74@SMW015318>
References: <20240401174159.642998-1-Frank.Li@nxp.com>
	<20260816071044.331a2c51.michal.pecio@gmail.com>
	<aoMty9Dvt2bnWm74@SMW015318>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 10:50:35 -0500, Frank Li wrote:
> On Sun, Aug 16, 2026 at 07:10:44AM +0200, Michal Pecio wrote:
> > No realistic chance of the dev->dma_mask check (below) giving -EIO?  
> 
> dma_mask is pointer, which already initilized by bus driver before
> call to probe.
> 
> For example
> 
> https://elixir.bootlin.com/linux/v7.1.8/source/drivers/base/platform.c#L634
> 
> If you find one, which bus driver have not init it, please high light
> it.
>
> > > dma_supported() will call dma_direct_supported or iommux's
> > > dma_supported call back function.  
> >
> > Aapparently, it may also use some 'dma_map_ops' and there is a bunch
> > of those spread over drivers/ and arch/. But I gather they are
> > expected to behave similarly as the functions named above?  
> 
> I grep it and checked at that time, all return 1 when >= 32. Now more
> powerfull check tools avaible, you can double check it.

Thank you. Sounds like it should work then, though I think that
checking return status won't harm, just to cover unusual cases like
regression in some obscure arch or people with buggy out of tree
patches (which they "forget" to mention they are using).

Regards,
Michal
