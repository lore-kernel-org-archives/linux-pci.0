Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337338;
	b=CSbF8wCwL8IUmsjDSkZcQjtlcTuaNRt9PTR3UMxeZW8qw3FxiNlmyj5PvUfCxwQepPiK
	 2Yi6OTSg2ET/4AhvNopoYibV8eUkBo7RNS5NMZMBNdjJ56+eLrmPerqgevLCq/+lObo1V
	 0JSMs7pYsiK1D3hu/lAiwOLfBDOrOnWECC3HL7N2AgBkQw3u5s/qZ3suS07lTbKqgxvAs
	 eg/bwuSNpHOU96l9YFJQEvFhjWD97uHkEIiNSxvycYxy1iO9PVA2qP3kBFwB9BlX84TOV
	 OoL4zqfPRK7g6DfnBlkX+HFuSBL8g3DcgGbks9xaRp/bVN9L1NkOjzDTiJUwPwNNPzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Rc92iNBDR3TpfE1Wb0FPlqB33KW4gheFc7Efbj9D4zA=;
	b=gAQrjGDe2HDDP+TZs3YYq6Ia8Dwqi1sS8wPhPLfYE3TTg0iqF5SSHOccW1dfQf71arjh
	 /fSr2excw+pVpMjcdDxxyALp59kfc96XoN4d81KuTEu2vmy3kjL4rQbzzjbXKYMIh7uwE
	 3QNrWT2GdNGEdqKuh7xrZ4o32NuRt4FUYyZLTWlsR5qHRDwk34h0ianO5dA9pO3Fpi90W
	 G2MLKhe4gclXfV8BNhi8spdXfAajLN+mNBDBtHiLrswnaZOCg2CHI4T+7DeJ3lLagDBCE
	 WQO2xxuQ7KPayrLTSsBDHQ/2Bvmg6wJy1ErNHfNCXWLurSM0tqVhBtvkpYiOGcIEs0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qO+JZOY4;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59583606A330
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 19:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59583606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qO+JZOY4
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9f6a16afcso5675ad.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 11:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794337338; x=1794942138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rc92iNBDR3TpfE1Wb0FPlqB33KW4gheFc7Efbj9D4zA=;
        b=qO+JZOY4XThqw7+Njn/UYcPIm7ZmOo3MiW+t20KLHVibC+4UuvF6oB0AUlTA5C+Kz5
         8bfjmyokmdpWkvtsirhnzw3yZxnpal6DZh4ctcbQuikaRqogrXN0Fg5MkiFa8k3d0ZdV
         6yHbQWhuX6VDHoqmvKkSeQVgoE06RF1Rh46qLj1+0lLUGq1fvXjYSdZ/wzPg2gJdk5mk
         ri70ob/7Sp1bFE8dTCuvgv7LeNHaYdC667uwY7mMMz+afixjYSayD4a69OskUXzmcrNu
         AXpWknVWVYiL/bjDdQg7mYlZxD1abxJRY2WRtUvcVfj93a3zD+lUsfOsoLuWUOnWKoUl
         Z+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337338; x=1794942138;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rc92iNBDR3TpfE1Wb0FPlqB33KW4gheFc7Efbj9D4zA=;
        b=tTmKt95pfSxm24liSGCU9yUD5dW8TkIV7d2eXLFbb5ZUAi7OZ+1JimdsD6j3uLLJkE
         BkB3qaUxnePFa7VSAasjM4nSbROPc5+NzesXXSFfKIxVCoQLQ80Du/lGClzrRci18N0v
         Fx9KiGQKDPuaoO4OdJg5VC/j49ivoFlOB+4sF6sXCvSkTrD2PNp6/eI6tTR2KGXZGDgF
         2Tgu5WEN9QhBCFR92nxvTJAYl1+pndFI6rHF7xqnN9/sTFbV1PtI4fbj1w2xyTdThOIm
         AMS9+/EMYGAf9DQg35z01OqEj/YN+wTJ9tAjCVHTwZzgaICht/wCi7Ul7Zpp9BEHGW/I
         lP4g==
X-Forwarded-Encrypted: i=1; AL+hErEmSfCclZIXDeC22g3j9LgwJEZjtgAJYFUm3ae7ecxEwf0UnaG3VClOABb8JOdAIo0HIzYgosnlkps=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WHZ+snKOGEtXxEH7TLq3Z/To1aosrHwuAgXQPZtI2Qnim6o5w
	p4ThY+biV/3eKRXhCraqCjK9aASXslwOa5oMAUbEJ7JlMZDT4TH29OTDNENZrgxTDw==
X-Gm-Gg: AYBFou0pXq1dTua3qZ+fOfQcu82kwAWK8/EnXjJslm2n4c9ez85Nmy9Gen2QY0R01Ei
	FjcJy6aibw1VXxTmwp5BZSNJt/bL2vwbRc2Us23vyxuc9BjBrrBozPizqar/BNCOOekqOTePEjK
	mTjM+eQ0ZWGOS5g32v/LP/A8K7sTzSHLSoXz2A3iAvAI4mcXOQ1YEdOnCKR0TigNTkGD8uscD47
	OHWtCG4dboiTQm9iEsepIq1ZEJVzn2mUxtpDeoYXIaDoFhzthC2SseXyUvaC5tcFw96YCH90hDH
	3BR/osE46jbiV19YiNPJlfYiVHi06DDyREQbGjS4gt5rzfaXjmx9kzpsg0x5yBPUWmc7znRc0O4
	ydeVoOyxxiZdglsNqGKUBtKIHzBCETosODRno4nmJXq2IhvUxjpy9pfDMgGTynsCN/NgRCyg+6I
	wvT321EflhPR2ULswMAc4RgiWlbYKqnFyQg//JastGQMUrHjMZrOdnYEE8TrdYn7wC6QP1EdLnI
	Gc7qkA1Mr7aJbceUJcdjvXGMf0X5nwrftJTiC1hxjOsqoBfnbhimoSqtYF0L+70rvfD+gPlx3yU
	39816Q2/ybRntoPA9q9hj2Ss5Gnqr/mn/P7jMb7tzVN/0drOI3KPPiIdIMlF75LD
X-Received: by 2002:a17:903:1b44:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2edba3e2a10mr5113665ad.15.1794337336971;
        Tue, 10 Nov 2026 11:02:16 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db31cafsm914394a91.3.2026.11.10.11.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:02:15 -0800 (PST)
Date: Tue, 10 Nov 2026 11:02:11 -0800
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
Message-ID: <20261110185305.GC519525.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-5-vipinsh@google.com>
 <au5T7qouVfxJSDmr@google.com>
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
In-Reply-To: <au5T7qouVfxJSDmr@google.com>

On Fri, Nov 06, 2026 at 10:29:06PM +0000, Samiullah Khawaja wrote:
> On Mon, Nov 02, 2026 at 07:36:33AM -0800, Vipin Sharma wrote:
> > Register a live update file handler for vfio-pci device files. Add stub
> > implementations of all required callbacks so that registration does not
> > fail. Register it with both live update framework and PCI subsystem.
> > 
> > This file handler will be extended in subsequent commits to enable a
> > device bound to vfio-pci to run without interruption while the host is
> > going through a kexec Live Update.
> > 
> > Put this support behind a new Kconfig VFIO_PCI_LIVEUPDATE. Initial
> > support is added for no-iommu model vfio-pci devices.
> > 
> > Co-developed-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> > MAINTAINERS                            |  1 +
> > drivers/vfio/pci/Kconfig               | 11 ++++
> > drivers/vfio/pci/Makefile              |  1 +
> > drivers/vfio/pci/vfio_pci.c            | 11 +++-
> > drivers/vfio/pci/vfio_pci_liveupdate.c | 75 ++++++++++++++++++++++++++
> > drivers/vfio/pci/vfio_pci_priv.h       | 14 +++++
> > include/linux/kho/abi/vfio_pci.h       | 28 ++++++++++
> > 7 files changed, 140 insertions(+), 1 deletion(-)
> > create mode 100644 drivers/vfio/pci/vfio_pci_liveupdate.c
> > create mode 100644 include/linux/kho/abi/vfio_pci.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5d1b58271989..167aa9d66ce8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -28662,6 +28662,7 @@ F:	Documentation/ABI/testing/debugfs-vfio
> > F:	Documentation/ABI/testing/sysfs-devices-vfio-dev
> > F:	Documentation/driver-api/vfio.rst
> > F:	drivers/vfio/
> > +F:	include/linux/kho/abi/vfio_pci.h
> > F:	include/linux/vfio.h
> > F:	include/linux/vfio_pci_core.h
> > F:	include/uapi/linux/vfio.h
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index 296bf01e185e..e8285ad93a69 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -42,6 +42,17 @@ config VFIO_PCI_IGD
> > 	  and LPC bridge config space.
> > 
> > 	  To enable Intel IGD assignment through vfio-pci, say Y.
> > +
> > +config VFIO_PCI_LIVEUPDATE
> > +	bool "VFIO PCI support for Live Update in no-iommu mode"
> > +	depends on PCI_LIVEUPDATE && VFIO_NOIOMMU
> 
> Can we handle this dependency in code instead of doing through
> configs? Are there any build dependencies on noiommu?

I can remove it but then by itself VFIO series will enable LIVEUPDATE
irrespective of VFIO_NOIOMMU and it will just fail when someone tries to
enable it. So, kconfig looks cleaner to me.

Can your series modify this kconfig and add (VFIO_NOIOMMU ||
IOMMU_LIVEUPDATE)? Will that work for you?
