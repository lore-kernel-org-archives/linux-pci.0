Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F83451B5
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085494; cv=none; b=R4ckAKy5hTnkCWpXoy8AnzKlmemHt4w2eW8PKCw5xQE54v75Z2YFrrtm8iAHB2sCWMzRBsUvkOB3lQv5lSvhuTzRLggotFGy8PxYtCVNKH1bRxFAO26QjrpgrlYeskuhkNsu18+B5KXkW3dLIsO/6XAd2SBxiDVpAe8/XtUEsMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085494; c=relaxed/simple;
	bh=yIjjEsSzcNVlj5Jerb5VL9COIWs3RWb5zUy94AhWr9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pS/TxtNSB3wdShL4/oV5OHQDYsSY4alSgZt7TFJHTWzy5W0n4Z0StymmTr9LQi3YaW2RQhJl79BFjuvTCGoU8k6wH+eRaH1nNsVCfyT8fgAN7AbmfOXYA04rWF/BdjPullgueZxt+bSs2BJqC4aQNb6NHeeJd5tvEVb8kMzNfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W6mucJMI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W6mucJMI"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914b5f85129so697282485a.3
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780085492; x=1780690292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
        b=W6mucJMILm76P1OvgIkeoQrHk1o7XL8eEki7XJZS1XS2OjCf+Mt31OyMtZjR2qaphh
         JYplHQ+jawZn32wdHnTUZ7/BfzMzKsTBm8Fig6rF907+pur3pR03NcbXI3r1E4jPnjWi
         Pj4l7r9Cd2P7VD6P6PcOKOr4ri/urmF4R+FIVF9YA78pTdvWQQSYvF7Z7feosxpyprw7
         +tFE69MQ32W/Mxl0Hefoqfx48geK4OASrV2q31UfG3eYxFQEg3WoFwURPR8t8K7LU6Z6
         3WzIrlfGGwk+6WgLZUiy5+fga84k7c35MG0crSnEaA2c5absa3at7TeFsmJ2pdiwI3bK
         qt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085492; x=1780690292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x50nMfXuC2+erTFJFRG2pVEkXmZORi5k9T8WBzn0C8s=;
        b=dv/3lqYM3KN6DCB+mwQZulzaidyIvew1CRW+y3hSEwkiAdbpF9w22d2EAfHn71Ak06
         /0q/Ppp3zMANUIkQTgM0H5GkfKriA1JnJil/oDBONRtt43uoQ4rIxLRyMmJHQg4zYOR9
         rHo/rxrPIMccduM3eslXHXZ3QRhXCxfBWdQk/rS01vacvnmc9ngXEd7WXIWfWEJSTiPI
         R86xE31FKpVB9qLeasjSHKcEe7zCf1hxYeVyWTCxfkya3ncXLbVD1urCm21XwS5hPf+z
         LJlbgULp6taCy03fYLt7DHYhc92znK5uGs8iUXhu0cSvE229O4wA41EgUJN6RflmqVRu
         Ad2g==
X-Forwarded-Encrypted: i=1; AFNElJ8oWsV6qgFKrT8TQutgWMr6J8AA8pWIR28nFBNavyP3B79W7M4iA3VLy68aUzRbkf9fhYcYwlhx0tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP31HaRX8MznAOlqFB8leTPooU+hqGSCc9oqQqPL+JFc/eYOI8
	/JP0frzVyTUViIm6PLADWDQehlNyodiKl1TQoQxrC9vYXylrf1da0ZoyGjZukqSIsMU=
X-Gm-Gg: Acq92OHdchYFxEwIF+XOgYmC7ITC8hlkz8YcPH1RUoftOczThEzVQhKbWdxhNAGH7Y9
	tcqQSHaa4uNUlEqCaP+exEv4rjLXwYPT1MsJxkdctwNVGpxOXOP3CI35cUJ0JQCtt0Xn4S0k6an
	etBQHBxtcXihIUQPEIn2V1YLbMr6zuPishpzih+HOyJHjH4Kww5FI5oWCTKvuymUJbXQPo/AEX6
	28TkN2vfoyKizg30lWUew0iLvg4gfeYp4zjZyLVgk/z3jXY1R+atRyQId8WIwaAhIAZi88pmNej
	hgGkeCZ57zRPJkBg0T+ezJi7CfVBHrbavHlYljJKHZeXFiwPDT3DYsw9DY/6r5tqSCo8q1E0VBg
	BhAbaMOx9dEAJFLFcJLY0LLlWtOG3Hssr8VoEnYOF2Gh3Si36XeWGIgV+j/ijjI5tGvNqW5hhmi
	1aa+8rQrwFPY/0myXUTb6MDVs4NyhpV05NQxQgAaiJB5UEP49Zd03hYUq51s4p3N0Ha3A3A8x84
	GY26Zwl8ovIg99K
X-Received: by 2002:a05:620a:649c:b0:912:671b:d090 with SMTP id af79cd13be357-9153d999728mr194543785a.24.1780085492316;
        Fri, 29 May 2026 13:11:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244de53sm312617585a.8.2026.05.29.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:11:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wT3YI-00000000q8h-45Mx;
	Fri, 29 May 2026 17:11:30 -0300
Date: Fri, 29 May 2026 17:11:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260529201130.GU2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com>

On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
> On 5/29/26 08:34, Zhiping Zhang wrote:
> ...
> > There's no in-tree vendor PF driver
> 
> Well I have to admit it's a bit on the edge but this sentence is a
> show stopper.

I think he means the device is not SRIOV. vfio-pci is the in-kernel PF
driver.

> DMA-buf is an in kernel interface for buffer sharing between drivers
> and any change to it needs an in kernel driver as justification for
> the added complexity.

vfio is the in-kernel driver, this series fully shows the in-kernel
API using vfio as the exporter and mlx5 as the importer. It certainly
meets the standard required to show in-tree users.

> When you have a complete open source driver stack which utilizes
> VFIO passthrough as the interface to communicate with the kernel
> drivers then we can eventually talk about that.

That decision is not up to dmabuf - what VFIO subsystem requires to
accept a new UAPI is up to the VFIO maintainers.

DRM and VFIO have very different views on what is required to merge a
new uAPI.

Jason
