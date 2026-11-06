Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794004152;
	b=4wCpBOIMTJxejL0dhPnrxUn84dxBC7nVkl2Zv+7nvXIYnKk9ZHPf4Su2MXmbjVKb8msV
	 NjgWMDPYBRQWTX4Iuw4FvtmrkX1Dv6eYEwCO2n05unM6svTtFsYL63WBkpjdRLSDMSG0I
	 97+Ir/RvK0zjy76oxVX3My1nIqo/xKUCmhiZqcfvyQg5dt5uHN6NMTV7Jb8GLfTvvkm5L
	 mHlZWMjH6PyECCNakeLa9GRtRQFHvA5FblObkFGaFsohxfpit/U+YaJGSokAW2zScRZND
	 DQQA/3hUYnC9U61cn9LTVXxyN/EsG7xdKfJIFxKBZr/oRey0avO4S2PuTzvjhqgbW6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794004152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=;
	b=cUVpPlNo5vwCheQw+c8u7q8/BhW1eTfNHKTsftHHw+DQibJNLG1aMGLfK0Jm5DQDgG+Y
	 IVntCLYVR0cTFi9BBD+BuYzqN2pT1KDZF3z2TL58go13yk5ElA5gL89az8Hpy+NM25E2G
	 aDnnBz4qObl1RApZgvoF88cX++Mvv/ewr6IZ1MqGZN04vh0my+ngx7PHsDR1ag6b2T2q8
	 wB21b9S6bF32Y0KJphJHs7F6S3o0xqHlkYFdX50M+GHrXBmdQtsRZdUxQLdPQFW3sUVWM
	 3wLv6sT7pSp9EwZPibJcCOiWYQ6dQgSJ+kfQxXFQ8bGd/HluJR/xXu0SHFsG3s3kXbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gkl+CmfF;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C1606A32F
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 22:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 006C1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gkl+CmfF
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ed3f563739so11655ad.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794004151; x=1794608951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=;
        b=gkl+CmfFQ+Co71nT6Egy2HcSuWbxjmTrMcP4xLom+yPt7cEbNxsDoECW+9ukC5saGE
         +AySoNHT/voHJzM5UxjovhfbBA4XVMmOzenTYYDHMTsRbS8yBDI6QJCC/DhqETSb9rfi
         DOMe5p5m8Jf6QID1xENOM2zAR1ZJEac4eAVE38l+dObMh2ofbhr/jGqeJ6w/wQziIRyG
         7e0XENuBRYE2xUyk1zPMSoXhVrt2mPi/FAktijRb4aYgmhwzysr64/2u5MQmgud0WLGQ
         edRQIb+VHahReTzYz8nVaVx/ZTWIZiGWFzXVnUzS8RaVeSJDFuxuhL+tw/ESiAOBb6g1
         rz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794004151; x=1794608951;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6wtLwteYwyUZUWdoRocIhX8iiQGzMdlm5waC4g0QLs=;
        b=GDOcq/NYRZsV1fMe8lBa4y3q/jqrPIyRSuEZzCr3Ggq0tqFc3XOOkwGckv50wD4Bc7
         BFp8jj3+PjsVoK9p6fCu0RZIml9m/b5mnGsKUgV0d1kS0C6/2VW5Vdx+/FvNKe07c7cf
         Pb4oJ2rXyEoRR77n+9mtmwtRm7MtXKg8y9EW0jHefI79FeCumqlRjrsBY1+ONsFgP6d8
         BkJM4xRYD4l5ZKmXKCvrQpyWayieckQtZw4xoA7RwUYtAZMpt3zWR6uaCsTOMCv4Vuuu
         lbcFpMX0eHO9x3CKYOcKuMXKdc32Suof9oA16TBc/73+VQxWqyzsqpFx6Uy1aJKZt4h8
         psVw==
X-Forwarded-Encrypted: i=1; AL+hErG6yAxkkYSWJ/h2zvPbFozN/dcHxt9uZuBCq795HLOBR4VxD6UeXgCblbU5AGx9z48rDloMG+vF9Mo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+27aT/SGaSqKwWO2LHiOJwJEuziW3Vnb0JHd5E1wHxZ3s38VCD
	Iat0oiNrOo/U/TVS/1vKMdaf90LJtvH5xpZ7q7J0JcAYqTW+ldfwzuI9cMaOqlvSuQ==
X-Gm-Gg: AYBFou2RmRFbMj7rl7xMCi3JNKJ/0h/ftZX7U/Nyerm5Fs89RjOUrvKOnM5bLiJ+4QE
	X05nWwxV6yeVwPaSRiwaaQHKrAfSy/sqwBNcvUCy8lVY5QkQUVKPHai5BOoqna0Lj+0aq8Vu0Gs
	OTV0Fw06n3oIeazNt4gKdhLN0tXN7WJunjhzvbSvO+kac2Hx5LLIDTvwgD114Rdsh9ZgF9I0Nle
	Xy+drJ4Z2WHUJTM6ZkCHvyXwyTpfoLLJd/HhBLfpxRq7t73k7XKr/zT2acMx2XC415njvfEzUlo
	INym/XjulEqUHiewkap0FQUthEHX1oUpMUOidJKXTDi72c62h/syWe7SKZAmUs/qEWKLNEdUx9T
	SjjY6kAjWgAQ65pw4ZofJAhHObCNq/uR1YROhiA42SbaCNchoIu3UvIJjZcttnigIGOd/xdmoHu
	toKSM5R5AzHn3FD2u3jM3EiGaf/tUIV/XwUma2zMxUQwyfFu+fqkVcdH629V4A1v4JPcqExReXj
	vVoseY7V8fbLJSg4WvQvTVbztOfopXdhPCzhnakC8deOk12md9167y6Y995ZcL8PDZSJooyTZBc
	oD0Q/Dr4HWbIdyeOQqgBgB85zZTXxWxEeMdZwt8Tk5+Hp6x2MzMbJ6VAPfE4bSqGZtkwm5ESax2
	udLS3velyd/5SmY9SWpI6ENDg9Vd3K5YgtCiyQD8J1pU=
X-Received: by 2002:a17:902:ef11:b0:2eb:188a:1c06 with SMTP id d9443c01a7336-2ed6a865b76mr263955ad.9.1794004150728;
        Fri, 06 Nov 2026 14:29:10 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc27e829sm775868a91.0.2026.11.06.14.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:29:09 -0800 (PST)
Date: Fri, 6 Nov 2026 22:29:06 +0000
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
Subject: Re: [PATCH v6 04/27] vfio/pci: Register a file handler with Live
 Update Orchestrator
Message-ID: <au5T7qouVfxJSDmr@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-5-vipinsh@google.com>
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
In-Reply-To: <20261102153656.1431701-5-vipinsh@google.com>

On Mon, Nov 02, 2026 at 07:36:33AM -0800, Vipin Sharma wrote:
>Register a live update file handler for vfio-pci device files. Add stub
>implementations of all required callbacks so that registration does not
>fail. Register it with both live update framework and PCI subsystem.
>
>This file handler will be extended in subsequent commits to enable a
>device bound to vfio-pci to run without interruption while the host is
>going through a kexec Live Update.
>
>Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE. Initial
>support is added for no-iommu model vfio-pci devices.
>
>Co-developed-by: David Matlack <dmatlack@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>---
> MAINTAINERS                            |  1 +
> drivers/vfio/pci/Kconfig               | 11 ++++
> drivers/vfio/pci/Makefile              |  1 +
> drivers/vfio/pci/vfio_pci.c            | 11 +++-
> drivers/vfio/pci/vfio_pci_liveupdate.c | 75 ++++++++++++++++++++++++++
> drivers/vfio/pci/vfio_pci_priv.h       | 14 +++++
> include/linux/kho/abi/vfio_pci.h       | 28 ++++++++++
> 7 files changed, 140 insertions(+), 1 deletion(-)
> create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
> create mode 100644 include/linux/kho/abi/vfio_pci.h
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 5d1b58271989..167aa9d66ce8 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -28662,6 +28662,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
> F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
> F:	Documentation/driver-api/vfio.rst
> F:	drivers/vfio/
>+F:	include/linux/kho/abi/vfio_pci.h
> F:	include/linux/vfio.h
> F:	include/linux/vfio_pci_core.h
> F:	include/uapi/linux/vfio.h
>diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
>index 296bf01e185e..e8285ad93a69 100644
>--- a/drivers/vfio/pci/Kconfig
>+++ b/drivers/vfio/pci/Kconfig
>@@ -42,6 +42,17 @@ config VFIO_PCI_IGD
> 	  and LPC bridge config space.
>
> 	  To enable Intel IGD assignment through vfio-pci, say Y.
>+
>+config VFIO_PCI_LIVEUPDATE
>+	bool "VFIO PCI support for Live Update in no-iommu mode"
>+	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU

Can we handle this dependency in code instead of doing through
configs? Are there any build dependencies on noiommu?
>+	help
>+	  Support for preserving devices bound to vfio-pci in no-iommu mode
>+	  across a Live Update. It enables a device to continue working (DMA)
>+	  while host kernel is going through a kexec live update.
>+
>+	  If you don't know what to do here, say N.
>+
> endif
>

Thanks,
Sami
