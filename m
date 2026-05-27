Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AB3403EAB
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885401; cv=none; b=LJmNAO0XiNwzPK5S/f7+d1Rk4K06Jf3IOZoOUWkJMI22KwU36vVaqwa1VLdjiaQTXlA0K5wQOZbp9k1gtvPOdfqPyzUZOktC+Gv+Wsf0fxrQnVW5lvJuCrZAIi/7RNvHdyGMBiTnporywz2HR7kmUSXPB+rsDmD7LZuF0LFgubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885401; c=relaxed/simple;
	bh=H7p6mpDtDLxmKvgOZ4pgS/ak1T+DvZzVyyf47SslWwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcpMmOQwVvx2Dx0bjo3Ixy4ocz0l9+97xE9Mv432VnCWv0WxPZ8DBRsaLqnNgMb8wDYu7Hp/B2pDNRTPlkzYZCfRSYOFHvOMkPlZbszUIppd1AH/qFSUNKzq0Vw2u8OLt1KfkeRibsP+rzI8LzZEhlpBZLDzHDxVuTl1L/uI/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UVUIw1Pe; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UVUIw1Pe"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-902deb2412fso1323914585a.3
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779885396; x=1780490196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
        b=UVUIw1Pe+iVgP2MaWntCCcmTVdFtxJ43P4b9vkG6V1hz2oZ71ktASAYU+aXvwRtFzI
         4rmquspQgOIxfrJO7NE5Dfk+n3R9xiugHdCOzkWe7AYTGau3DVbRW89DDJrhC81sLaE+
         o6a6B18gLyrs7UQieFJwpEBol3hnlgs0gxkWfow1CvLpCIRXlNPoMJCkG96es13xPOin
         4d0BYlETpf3nX4upGpx0q00LdG5X8YdDbvKEf+fu3iB+XUkiBHhr4sI76mCB3WkEdpEj
         PTk67x4NA2ZHuWq9h9KCgW/rVZvP8Ncl51og1pGtrBnuYvzZHf6c6yfaTHPsQzPzcR1n
         17pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885396; x=1780490196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAXF5UZCW6iJvbxUWxjJToe/IDClMd9U7HBLuJfAyw0=;
        b=iH3tXPXCQ9qVjd8MVFV4+NxzSzOuVhpFYf6DEAoXOyNiGKMVqtSWuGj4/qLF/8Zrqx
         QpVvsLuhvu/Eer3entNqH3QNfutAPJ4J08aNecjxEpLfG0cUWnZccL3EJv0SuBDXa6gP
         wo2jnnUlM6FuEfbWCgHPWEzRZI1b3v5E8QUvg7lxfSHGXGVjZuZZZvTI1cxOcMTQUziM
         EKkSNMKpYPQI8V6nA40ApI+S7TPs5Wz2STRT0XRo0YaNyt4ZLX+h52hGz4fYRhSEg8dr
         nhBuGcgIGPIqksi3+isBohHh0jTHfDf5HWlu7kTo+YIywGHjMSY0YsKaUSiSyGJ5Q61Q
         4KpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KwI1aKo5NXWKYhXebDngYdeVEx0QnZobjYp793Bzko5bTYQg8B7u47Zazv3bPI2IqWMmjwzDghQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhiILR/IhyOFlEHNkANqHdXSrfO45N/fpweQJ8LFg7+wfcl9u
	ZsVkp1seS4SDK4icCI2+npjp8k2xUOHxytETh92moQ4k5/X7y679ahLLvUYQ9UIaHbU=
X-Gm-Gg: Acq92OFBLTC+yWV44TgLmIdeXTJE4f6HvoKLp9Vo6fKQcWnrK2jm5K8ZqnM55IjFybm
	I0j+RQltMT5ev6Hltz+Xheg2TFfp5eaJ+Ya/0P55ikPpXAjTWd4bPjdJzYF00/CwmHlmA7GDqjS
	4cu4IKKvpan4ED1OiNVPNdiUhs5SGZmSix+m09dEzzEkiVHjjV4PtmHm2xvJ0pVT1vP3m7AyT9Q
	o/7EVAlz9SvmQkvXTw4V9Vwj4w9X70e1PBTVkBwhjv9MQOkWAwkCAPdULrjseX2G8PnOX3Cm2jL
	0aN3xcahgIjCe1rGGdbrkIUoSvfVHVe+djUdl4Sjhl67KU2G5xf7cr+qcVtFITgxo2ohq7GsJKG
	mqJsqNWW4I3glVMe9fX2/vz9lv5VFdOLDdnoMsFj6kPAQN6jJOFanUNnv49UyiGehVzt4nCqkBB
	/ErcJZ8e2j/+kBa+Z8Ov0Ml+mUj2tEzRXtpc3K/oEdkRErd9D9Y0+MMzdMPhNU7lZvezIXf0xQh
	3lpTw==
X-Received: by 2002:a05:620a:438a:b0:914:aaba:8d2e with SMTP id af79cd13be357-914b49336ddmr3211226285a.14.1779885395945;
        Wed, 27 May 2026 05:36:35 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8800e1dsm455621385a.34.2026.05.27.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:36:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSDUw-0000000EOYw-0lyZ;
	Wed, 27 May 2026 09:36:34 -0300
Date: Wed, 27 May 2026 09:36:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527123634.GK2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>

On Wed, May 27, 2026 at 02:23:46PM +0200, Christian König wrote:

> Yeah that's a good point, I should probably rephrase the question.
> 
> I'm aware of how TPH works by adding the extra ST to the TLP.
> 
> But my question is how is that useful to a PCIe endpoint? What is the effect of the ST here?

TBH I've never heard Meta explain what their device is doing with
it. At least it seems to be super important to their device..

Jason
