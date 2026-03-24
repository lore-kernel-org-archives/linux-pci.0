Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B1313E2C
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375208; cv=none; b=IakYd8vbu6JqN5KRSQ52XGrNF9Ie2/kHhiw22jPgBT7KCE1OgXlp+bmUMebJm94UgMKX3iP1B7XCfVKT/s9vqdbBE9/N+1E19SgmdYwvG572VUlmBDSHE1wHD2ZZX4pm20exOEERV/+PpqIoM/6rIo5Nlj2fLGT7f2BSBJQJ900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375208; c=relaxed/simple;
	bh=CNHXMSmAUOWH+d0jWI2bXIfdmawcgqh7aZ6RTG+xo5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAdjq/lVsKLjN5O67WkQJnx3skV05DJwjjc5ZsYUkFb3QQVlZf7GHsof26q8z6CfBR5uJ8DbfAWvw5ML20ljxaPYHk8DKK9iIfm0e+wTCVhCKhx8VIhuFxa4wyiD6d4mkgCEF6T6onranucbFlXhyYqnNN1N8YRzCTbR+2va7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r7wVIEoC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r7wVIEoC"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82c20b9f989so1935878b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774375206; x=1774980006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oR1oDysYc7m3zFicPQmc7IfOCoKYgQXwHXDPwXVzCPk=;
        b=r7wVIEoCOuRMjg1YrOzsLz4l2c5jl76GG92F5jwCa8nLslFfASSUz+Zp+tQORELJnb
         +JKEqTMgU6RIZc2ixU4SqFBjyf6+NC353uFIuey58jHxgZbEf4n2ycQXYkNnJntauxdT
         GSLXNuKaPV6l3lxJBc3oEHl+1hiXvt3LiAwT4RU/GBDZ6r9qJ/ZG+A0mWUZXfi6Bce+4
         1Yns8tDTQ1DQerp1zMZ/Tovj64NHaipROFcTrB/PfG3XD98BcK/AsSPR7k7eFamZhIs3
         Eq52zG9yGOt8bcUobEwBIYZkH3+elTz+R0uwRqcpgrtVonqfQ8xmnV04mXasMFPM4r9t
         d0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774375206; x=1774980006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR1oDysYc7m3zFicPQmc7IfOCoKYgQXwHXDPwXVzCPk=;
        b=eCHibj4wKvdr8Ko+EDK5ttP9pNhToR8MlNCrCgyMDNppCURPDancP0BLUPiRXgV2b6
         sVMYj4OBv8S7nzetUYlTdsGVQYjcHb/IvrbFFuZd8KdpHwlhZD8v/HFiab6DH07aR2yo
         C+XeEa2dag/qlCo6aSuuNmuSPv3JcQh1//JkwWXrm3qiUZPZaTBzAE5+lCV+NsdBeePy
         /wChtXDH3JeQkNr3Di6Itk0DoZpdIV81PK56yJFMxwLww3qN1cj/hwhCsDmDnV2QdvO6
         bbbLFQ8w66gH2fUtUiQCsSh+Je2us4QRhKbw/Rfgr6zpBfjfFKA2sRSZiode+wE8MMVc
         9KTw==
X-Forwarded-Encrypted: i=1; AJvYcCW+wFByi+MBpUUfgDGIXhfH1lrbFO+vler/Mw2SoEWkmD1DwVCA15ZLoU4doqE0PEOKeX1MYw4FcDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDetyxW2udOiwoCS+mbVePXEy64iAyv9euShqNiy0ObM672knR
	cICLdN8qC6xm8liP5Iol0G+65+ET9yNoNXwNK4f1Ac9RJEj/vNjA2vp8ji7AAybkYw==
X-Gm-Gg: ATEYQzxgLFi27JAhNBeYxPcDefdlUEmVqa1WQUFzlzeldPHYJchs2y/vjOVUAYvgyLd
	R0xOtuq1o8TUhdKyRLkcSZ57W+pTWzO5VoDeap56y1884183KvcR8up4MBQQesOPdk4qK3QL/94
	IOBQSxFsy9zQbphgVRsk4pvBw9m6T0x6zWoCnaypgZfCGs8cChicNi0VHyDxApkKepu/IWdz7B6
	8ycU5JfsIGBasUe3E++EkgzHzIAaMagBXrQ4PEZPEjHLqjtSxAMwT/8SVjmEbR7UF7Y5XNlAg+j
	GRNKNY7xkhPC5ej9WUulX+PDE2Z9GBF7qvY4cJNXXh9uJfa/U2C2aA/udjS/oio+9s4thWWmPnt
	JjMfsRQIUHh9ILtIRKc/2qKHFUpLglvq5+p2wWuD9KtLFfmrH00Ckq2l2RsRipRf5ANkUkaCWvg
	ycwZxGLuZJE6idHLrJ9Lc/1v2Dk7q6nmQl7D6Bb+K0791fy3jLqWpRrK+XGwXa1g==
X-Received: by 2002:a05:6a00:2da7:b0:827:3e19:574b with SMTP id d2e1a72fcca58-82c6e0bf7bamr488776b3a.43.1774375205765;
        Tue, 24 Mar 2026 11:00:05 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0421df0esm15901970b3a.58.2026.03.24.11.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 11:00:04 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:00:00 +0000
From: David Matlack <dmatlack@google.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 03/24] PCI: Require Live Update preserved devices are
 in singleton iommu_groups
Message-ID: <acLRICLAP5Ccqt9I@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-4-dmatlack@google.com>
 <376910fa-4232-4e58-bf87-0504202866a5@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376910fa-4232-4e58-bf87-0504202866a5@intel.com>

On 2026-03-24 09:07 PM, Yi Liu wrote:
> On 3/24/26 07:57, David Matlack wrote:
> > Require that Live Update preserved devices are in singleton iommu_groups
> > during preservation (outgoing kernel) and retrieval (incoming kernel).
> > 
> > PCI devices preserved across Live Update will be allowed to perform
> > memory transactions throughout the Live Update. Thus IOMMU groups for
> > preserved devices must remain fixed. Since all current use cases for
> > Live Update are for PCI devices in singleton iommu_groups, require that
> > as a starting point. This avoids the complexity of needing to enforce
> > arbitrary iommu_group topologies while still allowing all current use
> > cases.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >   drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
> >   1 file changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index bec7b3500057..a3dbe06650ff 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -75,6 +75,8 @@
> >    *
> >    *  * The device must not be a Physical Function (PF).
> >    *
> > + *  * The device must be the only device in its IOMMU group.
> > + *
> >    * Preservation Behavior
> >    * =====================
> >    *
> > @@ -105,6 +107,7 @@
> >   #include <linux/bsearch.h>
> >   #include <linux/io.h>
> > +#include <linux/iommu.h>
> >   #include <linux/kexec_handover.h>
> >   #include <linux/kho/abi/pci.h>
> >   #include <linux/liveupdate.h>
> > @@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
> >   	ser->nr_devices--;
> >   }
> > +static int count_devices(struct device *dev, void *__nr_devices)
> > +{
> > +	(*(int *)__nr_devices)++;
> > +	return 0;
> > +}
> > +
> 
> there was a related discussion on the singleton group check. have you
> considered the device_group_immutable_singleton() in below link?
> 
> https://lore.kernel.org/linux-iommu/20220421052121.3464100-4-baolu.lu@linux.intel.com/

Thanks for the link.

Based on the discussion in the follow-up threads, I think the only check
in that function that is needed on top of what is in this patch to
ensure group immutability is this one:

	/*
	 * The device could be considered to be fully isolated if
	 * all devices on the path from the device to the host-PCI
	 * bridge are protected from peer-to-peer DMA by ACS.
	 */
	if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
		return false;

However, this would restrict Live Update support to only device
topologies that have these flags enabled. I am not yet sure if this
would be overly restrictive for the scenarios we care about supporting.

An alternative way to ensure immutability would be to block adding
devices at probe time. i.e. Fail pci_device_group() if the device being
added has liveupdate_incoming=True, or if the group already contains a
device with liveupdate_{incoming,outgoing}=True. We would still need the
check in pci_liveupdate_preserve() to pretect against setting
liveupdate_outgoing=True on a device in a multi-device group.
