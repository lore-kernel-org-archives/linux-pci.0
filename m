Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D226E71E
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780447529; cv=none; b=LLh/DjNg3ljIEderDYOqJwXBjoDz7XyrjzSg4cttOkiI/wx4pY61ajRJAn+fLT/ujK/d4ihMSxRUYiY3vqocbRb9BTaCngkgByAUEUlPqp4ipNoAcVMuz1h15bgysogFfuUnpetpjCrO+sRq46WCg3D9ojWTKrVPcner3/eK7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780447529; c=relaxed/simple;
	bh=fYeJX8joKmObdhrh8tQtfCeBM4ISEnrgCnjg5ucGFT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwgI1SSvCcTlJX4b9elnH5Vl0P52RG/BPcBxNKjUQ6MSrtD5K2jTGLFA5HI5GSEJTNeeFhu7K2V54+VyhXrsj5JOKD7oKkmNdv4CoGBT/Wiu6tBUVTfEQWpGhIILNh21Tb9yMpglx2YkDjvgTgonFgE3Wpacwf65EO2xXrQtok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DBp2IZn6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DBp2IZn6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9157f7c1c0eso123593785a.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 17:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780447526; x=1781052326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3KDvAGi+1n2YXetnWM+OO8ay/rFVkZZd+3BY7j695Gc=;
        b=DBp2IZn6OJXydpul5Shl7SAnVhkJ7EaDXGakzzRWZlhjWPbvDQqjUO8oDqRFRH6qrI
         Ku7bKh1s9J78XTIu9iujQC0nE4qID9UejKWz31vPhpI39Xz/xnjeTdbUvZsi4m7RtYLc
         qRzQ5sxmrEunz3BptU8jN91XuNFv6E3SxPZwT9J49+NC+gbrwzfpHKheg4NM5TA/mKkr
         8Qyf1EQ0yCaC4y5dV8omoclZZvf+FJBVr9u6Or24tkpO3moazrvIKF7jsBCd5yxxux5l
         zPZPQH6v/oSnpyLJZGws2HaRy6Je5IWOn4A9wi5O+gQWIETPJpItAyg0S+IcNEU9HfBp
         tmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780447526; x=1781052326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KDvAGi+1n2YXetnWM+OO8ay/rFVkZZd+3BY7j695Gc=;
        b=hQSWy0w6jaGDrlEFsivLK6mG4RtR41NTazqJVUwnA3GhVBWDQRpZcWr2vQb9Til5yv
         2lLUKqqv4g82nolV/RfAn2wEx0NQuXzY9YGHv0BKINFewk0QO1hYgytMKP0BK1PPufuH
         OD3D53Q0yEcALj5VD1B+EA4qSTomLYc9Vcvt3063uEUk84ZEuOJ9FdBjM0Qw9Z3t4dPg
         R9PCkg0KtKDykwb7hszAlnf2SGoMi5VZlmbTYP0uZNJnepj0DafH2h8Nv3ZoDyVmalFj
         C2728imtlOcIdER7Yz/nmd7yY6LAxgmGd8bGzZQ8L0lrzL95Fi78EDA2s5PkSr33ljuh
         aIrw==
X-Forwarded-Encrypted: i=1; AFNElJ8TrTM5wkZvFTpiN/SJ0wU66zwYcuL+Inkhyl3henc5lcbEdy9wXVKWJ5L6ooF++/SQEmfxn2rTxCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHhZ1qdvXqdDA3ppW7V6eBfuxtEvAA20Js9BLufj7vnW1AoUxT
	dh/hi3njZ21fiXz33oGVnMZNR+jHpAOHPJugmtdNO0xkNrzgHe9A7YZ+70+/ToLpha8=
X-Gm-Gg: Acq92OHn6VIKmdJ+BTxtNkuPQYi8rp6fqB1lyUYwYKtMDwrIV9MYBiKJS+R0MYUYr5v
	pjKEddsQwgaHlJV31DceVsTfuRM1PJyQfxkf6atDp+YAkTG8/1PXpxJH7R7P9LADVd61ohZ9j2a
	y3tjuQNiO6KhoRf4D0+HrX7TLrMHORSgme2ddpKk+szQzqGrrTsz8YpuTAntFkWYw1oqwVPEJe3
	ZvhmEl78uw44+UlMb1gYr2YZOmsqgUey4KdEuasBz7eFL45oGFqzIiIqa9WPKE9g25hRjMqg5nB
	5stWULEJn1c6W/kgRDXCRJAWSdpPGO5rqL4q5cSStPxRe803fz0z9ssQw0WZXU+os2+xGWhJJGo
	VYIfii47kPMuIV5IO9mrf9biwzWhRoMVuU3+0KgzM1yTIbY3lMJ4e4L531DzPsa3jobhg5i+Q53
	gTj93gIUKu0rkPwFNpNunc6aGV+om/DFcP+CLhAFG0RUSsG7bCTYVzUgKZe/Fsu5ZlbE2V1SYjZ
	VmGvSI1rJ0LA57P
X-Received: by 2002:a05:620a:488c:b0:915:8010:c2a9 with SMTP id af79cd13be357-9158a82bcb7mr247072785a.52.1780447525938;
        Tue, 02 Jun 2026 17:45:25 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00b104sm102180185a.4.2026.06.02.17.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:45:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUZjY-00000004wLd-2FXa;
	Tue, 02 Jun 2026 21:45:24 -0300
Date: Tue, 2 Jun 2026 21:45:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, wathsala.vithanage@arm.com,
	helgaas@kernel.org, wei.huang2@amd.com, zhipingz@meta.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Message-ID: <20260603004524.GL2487554@ziepe.ca>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
 <20260601095840.3aaaa508@shazbot.org>
 <59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
 <20260602170847.75bd159d@shazbot.org>
 <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>

On Wed, Jun 03, 2026 at 08:34:53AM +0800, fengchengwen wrote:

> This translation helper is required to handle varied TPH configurations,
> including cases where ST entries live inside device private registers
> instead of MSI-X or TPH capability space.

I thought we agreed vfio had to block that feature in config space due
to security concerns? That's what enable_unsafe_tph is about, right?

> Prior discussion with Jason (
> ref: https://lore.kernel.org/all/20260414151125.GF2577880@ziepe.ca/)
> indicated VFIO-PCI is the correct component for per-device TPH
> implementation.

> > The host-only opt-in issue above also doesn't appear to be addressed or
> > rebutted.
> 
> enable_unsafe_tph host opt-in already fully gates all new TPH ABI:
> TPH cap + feature ioctl are completely hidden from userspace when off,
> no userspace opt-in needed.

I agree in general that the presence of enable_unsafe_tph VFIO has to
report the per-device steering tags to userspace so it can program the
device specific registers, nothing else can do this.

But I don't really get what is going on with all the new uAPI
proposed.

I don't understand what VFIO_DEVICE_FEATURE_TPH_ST_CONFIG is supposed
to be for, userspace should not be able to directly program registers
that are kernel controled. In this case it is 'safe' and it should be
only programmed by specifying abstract information like TPH_CPU_ST
does.

I'm also wondering why it needs a shadow entry, that doesn't seem
normal for config space tables..

Jason
