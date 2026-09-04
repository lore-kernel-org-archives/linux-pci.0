Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324751D500
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560675; cv=none; b=lu6rmrvIEYTZUMzkDE3m+yyxEvufguCPEoY5jE8ws+FALUSarNcBHqiMyXjQKhMHg48B8AebOa0uXbOUWae468vbPaEt5+kopqCcdBaEBExqkDdX3lrPKtOa5878m71lgBoD0yRwap4W9wpHgY6FXM/HnnPDvieljisTu85U7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560675; c=relaxed/simple;
	bh=3yfBn1WOKGcBed81Nlc6oSVXKJPNrdGjHRd+VzAbRwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu6uJlIENe7ogRC6frQB8/FoESgE6YeHylHbicFJO2GMSb8w3ximZiN/DeOEDC8O9dLIxdNlIESYmWtEJgm+WQcLLrkhhg8jWgUR8HdbjwE24+oBovoKksyEd/Zccsze7plLNO3C3NS0hc03VOEgD4AMIDAdumlK5WnXX+j+eNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtirbCBi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtirbCBi"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1165719a12.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788560667; x=1789165467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=;
        b=GtirbCBix0Ds6pelGWNduaI5DqrO9m0/xSFbJNyrN9QCtgIsiNPefSN4X2cSwdrfZu
         2BLpbI46XUeKsayPIK7n4lChRbGMeJQwXY7K71IaltGDBYjOwouT6oz1oMM3123GBoki
         3R3wWbaLE5odTJnRTi2nGlvWqriMZlUy0U1BE72i11I3nAZ8tkTo2yDbX+r8Rlivj+P7
         jyV7nAwI2X2Phziysdoo9Zz5kLaGhdugR4qmvUECBNqTjwfzTJo5M4vWjvNAEnKad78a
         NKbm0+SgHQ666xirrfRITglTHd4nZTRHMUMrdJqgF1QhNdpeZ2aksEJV/Y9FI0Y35Xax
         X22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560667; x=1789165467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eSoy4tzP5/vZd/n79Ub53Qw/sODynJmx2A4LOY3bVO0=;
        b=NCGVdQHlcE9ITvsfdyWs6Of8lTQgj83tJ/ifq5Z/a1xOcmhnbETetcg1VFDD51JjjH
         nwsa2Bj3nYGt6k20q5OgqGs4ChxLkKt1BV6g7gh3pLzNfvqwTeZXSA4WMR3PZxhFu10b
         nJciXHzj05UP5e7Iy+qh1EU5s4si7Rt5hbVCfJ1aN1kWUyIwzVpjoIgSu9tTeI4vKsD/
         IwnvGxSlQjzhzM/W97OjYROQZqO7ohIBJ9DH/leii89paIyAiEjthDUnW8uY0Pvm+uVj
         DO9rVUWhAJpJN2Zm2aLLPfIIOjUBDCWNmA8sKmCYtxJAnsXAgXn8q1oD7isoQVtU4Tvf
         c9Uw==
X-Forwarded-Encrypted: i=1; AKwUvBy/8TxA9Ko2CWOFHJQCfFe1vNLJFpfHzjXnTVrSJj5gMxVx25M+pdS2YCpBygJmMXSh032RVuIDWDU=@vger.kernel.org
X-Gm-Message-State: AFuF++mqEGFsdS/+Gmi+XAhF5FB3M9S12byWdNGazweuvv0pBA0wOjOD
	x04lcxeQu7V1UUQ1Msg+973aoP+nLSKMU9XsAA3lqjAun4K8mA3ygFIBnznufipWgQ==
X-Gm-Gg: AYBFou3R9FYdtnW6AtVG6+UYCa7URIFs+f22k76JMOgyyxfycRgH9vpXMmMw7jwSNDh
	WoDGzYcZkBLP63LPvgGY2IWNuunNSOLf+JlhwwMPcJx80+HEd96VZcAI2J5CoQyu8OI2gXpbkin
	1B3MiRAqf5pwFHLvMrYfXIiUXENMHaZokx++udPVvZfKjYvzUbf+3P3CRK2R4/OQcVUEIDf7tO6
	Z0BQrHTN+gTs9AeiYB/n9685raaLlew5yS//FTklBMHXfaoDS25rfO9haG+yWX3WgoK13U8/KUo
	31gViNLexvoy6EpoRuHn1c9+R1pvzhIsnExYNAz7R763K8g7Uztb0h/ZIhjpsPiC2W7J4lYjpxa
	rRt2+NDmF2N32jpxU2qFI/7NGMFW8+dpv35LyW0bDcm/YUYtwZK4lJoqJHFcxB+bnojbHkoW0aU
	x0OP56wZa0e3V3wLoPoI60X/oSmOVM7IEDbX0lPxQ8UvO1mDtjOf3t51Wz4JPCoKb8ViZOvx2+G
	Q7sNHXui604tD2Qidzlt3Yx22XENQ==
X-Received: by 2002:a05:6a00:2e99:b0:84c:4b58:2cec with SMTP id d2e1a72fcca58-8616b26f6bfmr12056954b3a.15.1788560666130;
        Fri, 04 Sep 2026 15:24:26 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86153a1c1basm1621740b3a.52.2026.09.04.15.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 15:24:25 -0700 (PDT)
Date: Fri, 4 Sep 2026 22:24:21 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Odell <loganodell@google.com>, arnd@arndb.de,
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com,
	maz@kernel.org, oupton@kernel.org, seanjc@google.com,
	bhelgaas@google.com, alex@shazbot.org, kevin.tian@intel.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
Message-ID: <aptFFYqcSiBdMLE8@google.com>
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904160009.GV4157646@nvidia.com>

On 2026-09-04 01:00 PM, Jason Gunthorpe wrote:
> On Wed, Sep 02, 2026 at 07:34:49PM -0700, Logan Odell wrote:
> > We're including maintainers from all subsystems that currently is or
> > will be expected to participate in live update to ensure alignment on
> > the path forward for compatibility.
> > 
> > Currently, Live Update Orchestrator (LUO) and its file handlers rely on
> > monolithic compatibility strings (such as "luo-v5" and "memfd-v1") to
> > validate ABI compatibility across kexec live updates. Any modification
> > to serialized structures requires bumping the version string, which
> > strictly breaks compatibility between adjacent kernels even when changes
> > are additive, backwards-compatible, or optional.
> 
> That was the intention, I aruged strongly that upstream does not want
> to maintain a CSP matrix of endless kernel version combinations. That
> is far too much work to push on maintainers. Upstream would do much
> less, maybe only same-version, depending.

We received basically the opposite stance from Sean regarding the KVM
LUO ABI:

  https://lore.kernel.org/kvm/aoSCCTTBn9D5hqzk@google.com/

So we're trying to use this series to get some alignment across LUO
ABIs.

> > This RFC series transitions LUO and subsystem file handlers to use
> > granular feature bitmasks instead of compatibility strings. We replace
> > the compatibility string with a header structure that includes some
> > reserved space to define the features that are included after the
> > feature.
> 
> The compatability string is only a small part of it, you also need a
> serializing ABI that can handle some random mixmash of these
> features. Ie the various TLV schemes that were all proposed. What is
> the plan here?

The proposal here (which is inspired by the KVM UAPI) is to ensure every
LUO ABI struct has 2 properties:

 1. A field to encode options/features (e.g. u64 flags).
 2. A way way to grow without breaking backward compatibility (e.g. so
    we can add new fields).

Each flag can mean whatever it needs to. e.g. It can indicate the
precence of one or more fields (i.e. new fields in the struct), or it
can mean a field now has a different meaning (i.e. union in the struct).

This would enable adding support for new features without breaking
backward compatibility. Downstream users would have to ensure their
kernel does not start using a new feature while it can still rollback to
a version that does not support the new feature.
