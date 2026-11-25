Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795566258;
	b=Ux6FYlxrNkc0O+eVNuE+svl0CF3aK2Oe84DRLnvFdm97e0OCA+I2E4fFsvldJAVSRMAr
	 b0zYRV8CazhJHUMAdICrkZuf0pMmE6z4npPD6JKxsHR1LzCF6lxGJsg8M2h9KOTWR5pmo
	 s3N+dsJweludNAG/iwqfy9LX+2aKe7c2jFXRKImnLmMw/7t9+AXx3zTlLH3BWiAJ6lC9C
	 rPbY7UbpuP+Ynzwa0nRpQJdWvHILQTBZqYKSn6oHiWYGtQnBXxjpjf9IapZQbTl259VGk
	 mTWndLpZPAsHNyywM1CjgpNPE9ejQhg09fCpgtooRciEkcXEVX/7Eb55UjKX5riFdWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795566258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=;
	b=XA5Gv9LrnMOoW4EW3twcWQxoBnJ/mp2mPEVW1dwn0mCjpFuzI0rPS38urpZxdNjVwLD3
	 v9ASH0gGdHZHkj7Ozk/CvWUxvUAXXgDZ8wzjnonLECF1b8QLLWNiKYOVpL4zO0X4SC9Z9
	 34eq1U4X/8Yz3kdxasnCHjXhBKYjQHuLBoCuJaJZ8SVWp0PIpviIAo8hD5MNvhVGWEkdL
	 aq56pauA6oQZL1NeV8qSEQQ4+OvGTMwUIJRSXzLYHIBB0bhI+SPNe1ogTirlwX7qnbW+p
	 19ilz94Ig9L1fx8mm1d1niWHIU7vvTT+xlJuDTZYvfIOEi/ZYWT3ThPueWfe5a3z6Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nvA4xsJY;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49354606A32C
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 00:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49354606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nvA4xsJY
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2f0afdb97abso162725ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 16:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795566258; x=1796171058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=;
        b=nvA4xsJYbyjlVUxR+uk4yXS/M0iXumDNQvEFcjik+fzfX0hxCUG8igTP+aEBUQKhWU
         01rPlsYZxijr1nIFh0HnhmIqvQDte+9GB9vgwkcgoDmEZlgpGqs5n719qFTdxZxpqmHD
         smlvTgzd2MsCxkh4iC3Pj3xgW0A8Vxl/d+etRiBo7TyLfUmGaEDmFSkc1zKYBT1NH1su
         QsnQAeJzEmHi0cQJ30I2MOkUNe8XLlufgoLeZ9DETN2Ob5Y/qQNwZctS+bf7T52hpQPK
         WciL243GxjFlJ67fODnf4z60/dH9j68n9GubZQYbMlxniUpHCzE0u2iUedJtX7wAGNLR
         a8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566258; x=1796171058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YMO/Q4LHoS6IxvSYVAkwFpWA6bWqlpOH+BNCvhBFP1g=;
        b=FZ6beGjfQEox+RlBy33o1jv8EO6llnyinXpvtwqmz+YcH3YXBkAI1Y24MdkPr2IkLq
         lutl7SXTlYhryBeXKVGYa6HocJU44njUIdErPXvNVDtu25WYIwjUvkeYYKrpJBtGCY+n
         soTwi/CSSs+MpcHb27elx1vmJ/Yb80nmiEKNG0auW0mR/tpkROvrH1hVG+2O1h1uWFet
         Cm3ATNFSR9aWihO4qZNx1grIebyJMEf0mF4gfBUqUdIYvWOWYoT2IDgRfC2+f6Nab06X
         8v97BkTroULp1St1KqesSZbpMfa3sdPWTGhUujjAABUyXdEyqVgUVC09YPI3P/nMZi2z
         J2Ug==
X-Forwarded-Encrypted: i=1; AL+hErHu9+QNHRw8FsR3sOalzPINZSWpWNbnMK1J0XaqThabAlY7jvLpHVmWdwMTMpYsqd4fDwTEOvbchYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+J8NPBo39Z5znYGj0kuxvxDIU4JtRCkZYyZ7ligPxCjhaNbQlk
	LeCaCKjbbXwK3JaqhINuaxFFwO/2S7FzAkPGMYIT0gUVzg+L7ld5Iaqmo6y8Esce/w==
X-Gm-Gg: AZFdTZea2b1jB+IdPBKIj1K0gNLCk1nyw/Asg1LXKxjKmAR/0HXBfMVgvtJ9fFopOAr
	qUEX8nfd/8Lim9kzYSeO187G7V0wMt952e6ezvf14YYeNSDEXXaW3fwyIttsWH+WqUNmho9hVBc
	1RwjGYrb3XVvZXl28BB+YTLvnzg7QFpcvw0Y0E2Q/ISNGshdVaG7pbt3AYrOZd7Aqb+YdtK36cD
	RVxfu6adBhwbChb4zy8srszvkJFA2iG/NAV2flQy8RMIvMiRzSoWnNytvPLp+XuG/di5YR46LK4
	2il1WSqhmRXjzOiaNAbbTD5t5huZpIoNII6eFkOMBJQqrQf5JiEsLs5c7J7yrG0ihMH09F/qlzT
	wH0bpvyali1bmk35CBsr8fli+FiaxDqdsdRyvve8CYUTxodSEIwYRCIzux4GYdYAjpPU78q1hC+
	0Fa++I7PnT+SuHCtHclzMYgKbehczs0W8oeQHS34oXu+DLHH08ilKsL+pIQndvFqp451sS/zxaH
	9HR/43zC2dr9aJR7IVD2kM/cR7GoCXHwD6cKMIXHiNkA2yM950lW8auq9uQeute8dWYVZ9lU9gD
	nPFKdJ/dHo9KrV3eEGra7N1/R1x/a/7c6vVnD4QEN/A3WUKjfL860yWHd27jOWVrftaCDJrqFmG
	MCgidY8IhtImp
X-Received: by 2002:a17:902:e950:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2f06242bd42mr16475105ad.2.1795566257244;
        Tue, 24 Nov 2026 16:24:17 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cff4c1asm7632022a12.15.2026.11.24.16.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:24:16 -0800 (PST)
Date: Tue, 24 Nov 2026 16:24:12 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <20261125002302.GC3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-13-vipinsh@google.com>
 <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>
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
In-Reply-To: <DMZLVV5YW6GW.1HMW8L8NIQ1XR@google.com>

On Thu, Nov 19, 2026 at 04:19:34PM -0800, David Matlack wrote:
> On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> > diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> > index 12557d45dfee..e6ca4c3fda06 100644
> > --- a/drivers/vfio/vfio.h
> > +++ b/drivers/vfio/vfio.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/cdev.h>
> >  #include <linux/module.h>
> >  #include <linux/vfio.h>
> > +#include <linux/pci.h>
> >  
> >  struct iommufd_ctx;
> >  struct iommu_group;
> > @@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
> >  static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
> >  #endif /* CONFIG_VFIO_DEBUGFS */
> >  
> > +#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	struct device *d = device->dev;
> > +
> > +	if (dev_is_pci(d))
> > +		return pci_liveupdate_is_incoming(to_pci_dev(d));
> > +
> > +	return false;
> > +}
> > +#else
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	return false;
> > +}
> > +#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
> 
> No need for the ifdef here and 2 definitions here. If
> CONFIG_PCI_LIVEUPDATE is not enabled then the compiler should be able to
> optimize vfio_liveupdate_incoming_is_preserved() to false.

Okay, I will remove it.
