Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970031E107
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069814; cv=none; b=T5GPP8ukPcQgeZO/bpIV6Hb6dLeIEKLgtYvZBEtfYfwtni+kaP0rgaNYV4JQT24aejWHuEsqFGqP96F69/QE4S4Xg89NQqmhrtBNZRBaJPEEluagStqwrcyDxE8zg3pBoUT44ujo05HZghqR0o/XwPqWVNojAp0FPxK9zaJRwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069814; c=relaxed/simple;
	bh=eL5PFbCsfKV8bsqpSaJH5QLJQHcATd2jC+a8M9FhqI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiNR8j9UYbW63bCOlnhf0qAhykKIYxdUvs7pIf2jL7ZHW9C2A2unh18Y8FcNAScEiqYFlMROoJ9NNYQMMwz1QDni0SgxU44UkYsxvi4txwfCAuhPY7O9eTEZTRTQhDhsgnjgrLFLEePn6s15tVwG7UExROJWN0FPc7zJGYUi6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Jx+MA+Lz; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Jx+MA+Lz"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89f87257904so68785016d6.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777069812; x=1777674612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcU2RSfhC3nYqQJBYqc7fU7L29k4M7iAEBMdP6aAbW8=;
        b=Jx+MA+Lzrifxk+t1xLmc2hjDPfafCy7GNwLrGTIXmDEq3Sobw7xPdxwn+80QPYtnQc
         GVl1vGmtn/p/hhlrgDioAbHUrdZc9OoHNCrLtcGH68AGLgvfKhghIQvSDw/LYWC3Ff6a
         BEZc06z2VIESfBh1+5JVdde6qzWoFxnloMw4W0j39hsde0INN48Kpvv0HFLVqq8/v5s3
         aU27oXcQr6cfwTEKA+L7mHN2Z1QPBlA+l2I+oHCG2slOPQX5V5yMl8OdXw6C8aUM7Vmv
         2KIvQ+njUcUZsVM7Y2madKMtA2thJqQKXPWGtXbjuKot2mO5CxrjFqeaFZ2YRbYnMc0q
         Krcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777069812; x=1777674612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcU2RSfhC3nYqQJBYqc7fU7L29k4M7iAEBMdP6aAbW8=;
        b=nMBJ+VnlgBqBqdxxu7gion12/9thbHB3MnKfAyzgVLvXCF+bkDit7KkOKZh2F3Gz29
         tMKA4qTla6jQy7/hQfX6Lw3qhXLGkY5V6zH8KBzIsoYPGiuF+E1bKt0CxRyZTVDucScd
         PtC/AcEf7JFeuSf1Eaa255UvneeEp7kuVDmgyBjz2Dnx4H5wvPKvBo0mQeM/Nj/4CMKx
         H+2fBl9yBzYUGfaZDStkdtrl8vI+J/o0Xmr1FzN5vSxhTunPn8JoXK/r+s1IczGnWNte
         NRFkIsmMd/BZX3kUssUgd7gUgMLqbBAC1CpixMwPyF83bpqYaXufuwYlS0osDJf5rAmV
         QCSA==
X-Forwarded-Encrypted: i=1; AFNElJ9CV67mjwoR9ofgPwqvMrgKu/qBvnkEqE4KRpnkQb/067VTapqKiexxiAGK+BR+ABWn92KnzMJxT6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzON2cYAfoIzK8TismKDdEuKH1H1kzLdAg+Wtj/9ui5sxKRQxJq
	lgOLfrMiHnszBHQ329a4Tgzz8vbcJa94t182fHVtcE8OxnC9f9qhZPT8gd0kR49rQWM=
X-Gm-Gg: AeBDiesFWN7WeFed/2pN8GjL3SzMPjIMA7u/Ik95l2rwA5Cy3LQ6lSTm4dKkKyuq1yh
	sUENTOScDRaWM/a8qkGE0yYyrr4fBTtsaCyFofzoYd5NlKjjtty8lFsWtSvUXBQrvmaWEVA8oa1
	Zj8WX5EzlXVl1BmYW6Jpfiq6ZIqdTezmEhUlttlwXVHmSqImLrfIlVk1XssVj3JE/D/5XqHPGcD
	E5CmhWrIFPneJYcy3Xf201Zwq+6KKRvrzGHQzDnEBDVSCoyMcwnLi4+dKVxJt/CRudObJ620yf5
	QEUaCZ5xL3pAwKgTFc1c/QmH3QCf93mu45t/OsqmCYtQdcC22QkVHVasHg/9H4Jn506CcPRq/mu
	6bwBOW5RzLxJbvEVXxT8I+TqtXAu9LufOg0LD1RHjjjUHlVyVehMHV/Z0VFC388iJqoimYme4rP
	w7+dJBqq0MnDTOteQ2HRzbZXTgKyZCa7DllkwYVPNVmC4F75lTpM79DC03kgwT5Axb9NKltmDbU
	y0/PWZvZI+1sRB6
X-Received: by 2002:a05:6214:5294:b0:8b0:2b9e:9636 with SMTP id 6a1803df08f44-8b02b9e9cd4mr493356496d6.18.1777069811988;
        Fri, 24 Apr 2026 15:30:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm196779946d6.49.2026.04.24.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:30:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGP2I-00000004pmY-1uT3;
	Fri, 24 Apr 2026 19:30:10 -0300
Date: Fri, 24 Apr 2026 19:30:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, alex@shazbot.org,
	wathsala.vithanage@arm.com, helgaas@kernel.org,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/5] vfio/pci: Add PCIe TPH support
Message-ID: <20260424223010.GB804026@ziepe.ca>
References: <20260423010851.46737-1-fengchengwen@huawei.com>
 <20260423145915.GG172828@unreal>
 <486a8633-437d-42d1-85f9-690a9df311eb@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486a8633-437d-42d1-85f9-690a9df311eb@huawei.com>

On Fri, Apr 24, 2026 at 09:25:54AM +0800, fengchengwen wrote:
> 1. Why userspace needs the capability to control steering tags:
>    When PCIe devices are fully taken over by userspace workloads like DPDK
>    and SPDK, only userspace understands core binding policies and traffic
>    distribution. Without this series, userspace cannot enable TPH or
>    configure steering tags, leaving built-in PCIe performance optimizations
>    unused for high-throughput polling I/O scenarios.

So far we have generally had the position that vfio should not enable
device specific steering tags because it is impossible to provide the
expected level of isolation.

I think it is OK to have a unsafe module option to allow use of
device-specific steering tags, and it is reasonable to have an ioctl
to query what the tags are for various CPU scenarios.

It is not OK to allow direct userspace control over the safe TPH in
MSI-X mode. The kernel should continue to exclusively control these
and the userspace should request to load differnt things into them,
presenting some kind of security context to prove it can use the
things it requests. It should not require an unsafe parameter.

Jason
