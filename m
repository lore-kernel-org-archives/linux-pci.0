Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706096;
	b=EJNql6Oac2X3Be+ZhFqOnZf4CDuDPAd33emlCGV86gVxHCRnpVcHNjzEgjJqGmafSuqh
	 ep2F1kPZjHoobkd3pnw+egRnhMCdj6+ZY//xCSxlcSeCJlO4Tgd46/LzQdQS5KCQixvW6
	 yJMsGFJuM4pYj70ES81TcYo0Na5iAH3xtZerGQdK/VEIRraZTV95gWuXYgyWfwKw06y+5
	 6VIHaYOS33oTKXJZSgSPEydAGwHWOoACwCIaadXI/vtIkrf19BF8TsN/u2TqnJdTDSDhB
	 YyEy2GMzJmoYM4rBhZLmDRLbYTyS5R8s8lvPHfTqr8qB9Ck2Ow9tcHGQAPi7Fl+5DPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Fmk7KvplZu8IqXCFaSm0h6pjbCmnVJRD63HoP6Br6hc=;
	b=Zyz4TCcbnuMBzZOYC1ngTH/tFq97xOrT2STiPfEZ/WHOTOLqWYqBFSLuE9Z4bgufPw0t
	 5h//byod9uXm6zelWgBAfffQEPsiB8CZ4O4yT8vbqbY2eDRVJAOHS/5iWMkmHQv4nyBRu
	 TcOCXVZ0zvOKHablv4ad41e7PYyAoNTsdPdV5pAhZwqBwMsOobmhrlUENHsEzDQBoygLd
	 ONhJBHPZ9hCDLC1VsF/k3nSrng0Pfu4f/X7zoPU7zVaqcAxIEZ9aU/0aInpUtCF/tRrkd
	 VDVIubvH1W2ZCCQpIjMwPCAIZgx8VpDEwr8ygxzIhHYt1ORnj5i62ULOGsCxhnRvNHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D81606A323
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 15:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6D81606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so3766625241.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795706090; x=1796310890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fmk7KvplZu8IqXCFaSm0h6pjbCmnVJRD63HoP6Br6hc=;
        b=at0tl1DT2mSnZt3nOLv37aifBxhKmP5gZR6l3IcV6A0l4PNDh1smzHC9LCyznNI0xy
         0790xp6rnZ5zk9V9cyzVx2d/FiSPTTVDaIIPdQL2rooFjqMCzmjpZ/i1ORZu5558c9bl
         vh/VpnMyCZ31i+zeKTRTcR1BG6HzEIngJxPY7adqL+BVSJbErHzd+cKh94xjTC8XMCkw
         Jkxvk3KYom48V/7Dw4RTi5/jCmYmQs7D+pcov3weNXk1MGV/PpD+BIurNiJ55Gencezo
         cbUYkldLl52PD8TwtiRrWWLsxqW3+fFC/BbMUuEtJiXgF/YnAAkH+oEXGnNgTG00E70x
         EdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706090; x=1796310890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fmk7KvplZu8IqXCFaSm0h6pjbCmnVJRD63HoP6Br6hc=;
        b=cCkrviibXDJdtXpIadX0ntHE9YKk4bQfMEIceMz+zdbUzfL/MUX7IVJ0IljTRwFDrO
         0icfT7AWrHwhJhdbm26TS8qsHDeVEHPk+ErAksAquQ0G6I7wiK7RHWepPkppSdFQG+mS
         B7/Cp2Zi8GimizzcGPEYP+i2zj2+OHABF4ghIvIE8jv5wqU5Z+HUH2EQm4hzpy0z0IMi
         DFj8xYIHe0KxlJlp+nIcAaCXbuNPu8kmi8XYDth2SOOI/AtsjzyOqoKVU2oAMrJLbQFX
         YAN/jNf6W4rfKwEW0TDL+S6oqWovikqVwRgacJrhDzOzURo5E6ERr0ltGo4I0fnaotfl
         Fwjg==
X-Forwarded-Encrypted: i=1; AL+hErGq7yrR2BjDE0ICrPVpJA7W2mTacyvRipGNmWIb5PQynIwnVf0yvKTmU8quaAoRat3nUlkDl8/R6Ew=@vger.kernel.org
X-Gm-Message-State: APuU4Z9o8OsNoFE9gpN8R/cdlN64Q1iu0Fdwx0nptVkESkUiOVviKMdi
	o0yyHPSaj548IfvrzBNOtBFqo9VpvL8UHjIGIUOIjUs1PzgQzw7b8qAW8slnSBL5RGw=
X-Gm-Gg: AZFdTZeRe95JPFXW+YMziW157hPyU7Xb57d54Ull0rm9BAG6AmG5N5SzDm4pu4O4I+F
	eCBbTiwreHqsJ9lCxSizCBYUTUguVCdtGsYtEEOvUhnvtd8jtYNoy3VTcZ55fiLqN37jFvZD5nk
	B8pp2YASjofVKfW8xJd4dY8lCDpMozHJf+YeRdKFbzt32RM70wUYhOQrKOHWxhahJj1kAk3u+r5
	UQX/MbTPkePDSaJCsn0QdhQM5qhbrihXOnTCXf6m+1m76iETlzzbj3+glkFbYtI/SJMH5Opw+iP
	E3I6G893jPNLXUwvjt3uDPwCAlye56frSFb1q/LH7ryoX1aisIM8bhRZ0xlw7VF7e+GHZigTDbw
	bmnS3B6K4wJpCqf4BP2gh/JGM9Ikz+hVMbcHDbyaTLE2qbLv/dJV+nrGSQ6Lu3dzpDNJdLwgpsJ
	z7Cx28tIbkhHguHYy09uA0kaWwJptQM1FNSTVC6Xwmju6TXPpgcPCwjvFg8ZsoIhYPs4V6c+KHp
	KtdRiB/UOCAT2eoJSIuttSTFkolnU7m44OIv0uLYpLL4cZAIfgGb3hUU+Wg1bZskusXqDKWRw9J
	DTYxycQ=
X-Received: by 2002:a05:6102:84c8:b0:7c3:2168:d603 with SMTP id ada2fe7eead31-7d71e329ce9mr10299312137.0.1795706089640;
        Thu, 26 Nov 2026 07:14:49 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349cdfbasm193141456d6.17.2026.11.26.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 07:14:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWbBQ-00000004NdO-2PDc;
	Thu, 26 Nov 2026 11:14:48 -0400
Date: Thu, 26 Nov 2026 11:14:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH v1 04/10] PCI/TSM: Defer TSM vDEVICE allocation until
 device setup completes
Message-ID: <20261126151448.GO246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-5-aneesh.kumar@kernel.org>
 <5e04323f-dfdc-4956-acee-bcc09926726d@amd.com>
 <yq5aqzg99uio.fsf@kernel.org>
 <20261125141947.GD246011@ziepe.ca>
 <yq5ald6gul7q.fsf@kernel.org>
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
In-Reply-To: <yq5ald6gul7q.fsf@kernel.org>

On Thu, Nov 26, 2026 at 12:34:57PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Nov 25, 2026 at 02:07:19PM +0530, Aneesh Kumar K.V wrote:
> >
> >> That is what this patch does. If IDE setup is not complete but the
> >> device already has tsm0 attached and connected, pci_tsm_context_get()
> >> returns an error from cca_vdevice_init(), preventing the device from
> >> being assigned to the VM.
> >
> > If the device has not been fully accepted on the SPDM side then you
> > should not be able to create an iommufd vdevice for it, nothing else.
> 
> That is what this patch does.

Well, it doesn't exactly. It adds some code without any users and
doesn't explain why we need to export a lock or add more core code for
this activity.

Nor does any of the naming imply it is only to be used for iommufd
vdevices.

It is problematic to be hacking the core code without any drivers, I
know we are kind of stuck with this, but lets try to limit changes to
supporting stuff that is potentially about to be merged. viommu is
fairly down the road still due to all the dependencies.

Jason
