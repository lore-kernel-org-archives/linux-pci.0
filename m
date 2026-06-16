Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815D33A9FF
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620948; cv=none; b=mFJ9s8QCLR8Lr3N0DovgfwZ/eAJHbf0DH2f40gVA4+29R6a5zOZc/ICiln25D924Hag7LbNPRucMiva93+PY4O5qZhU5UnWNImqGZIUxpmOlh5+EBuAMdMrmM+u0Krg67q0KRmFLj/2lvxCJH4bw/PZgo0Lf3VmTqFheBboAml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620948; c=relaxed/simple;
	bh=YM0ACQYf4Uc569a6YEdVY1akpC7Ocd6dIp30Kywl9D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAdkzOLWuY5kxQ2b1cA5bcO23PxkjHJzsJUsLQIUjrsSROKPEjwaLNxI9oC6RxuHATW0uEfwcM6WmFlcmRrfhHvp2aN2RcXyxdN4Gdjbx9s0Qjtf4j6LEd4BaS7V4O1cJyAZm5mbyj/ycDEzq8YjItcT55WEHjDnWM1p2+yeuZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YuPSKEtG; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YuPSKEtG"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51758478240so25577301cf.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781620946; x=1782225746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/6erokdFXhtewZdSXNIBIfXL9rXfMqxj/dhqBref1OI=;
        b=YuPSKEtGWwAX2dr7GhjKBukR8iIzGNgD+mBzUWYD1gh0/bkKJaeLCEjSKoYBjNFzD8
         8XuMcmimW+pyktaxepXdUM4Lf5TZPdQMl+LPsvjhIDg1WAKhfm9KHCCiN57wXNEMbNyr
         5KagG6TStQhsNp202JIscHibg0Ej9k/epxkedGJviwA5lSEuGAtjQdRs3LDT2qe/D8dJ
         6Yt/MstptTF9GBYJwf+gFj6edEEI9NwXg26jlbYgjKh2Oj1IazhLldKblbaxSIy7XaJN
         fR4UsyOFKrLH8AKYDlBgXTgDQea+CrdsnPOAuwq3HkO2QzUQbu1ps22PSedTiEmNPVWP
         cfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620946; x=1782225746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6erokdFXhtewZdSXNIBIfXL9rXfMqxj/dhqBref1OI=;
        b=CobryAaq36H7kgbGHH9EqfICxzzhPShsc98mHIjh2faoqpwmGVohHg5wNaJht4y7Xi
         eVtiV8g2txdUHfHpobZEmQo5EHQ04QzMp8hG86zpSq0zEt/fJB/FeeoVxF6tdM8XRlZU
         1zIZznqNrOYQND9EhCWCseEVm+eceYUtWO8tWmiVVLIB7mgVwOPVGaiOyqpPzhsC49Ex
         6YYlJlt3C2958rmvZ3ECtt/grCvQVSN8SmAv6EtpyX0mV1VJklhj9PTKeJY8SQt9CdHV
         T+XUC6DtwmA0h/VpBm5zrnXZyTbqCQP+TRp9a7FunqPePPuxEshZtMVij++Y5NlQyBlW
         nkmg==
X-Forwarded-Encrypted: i=1; AFNElJ/1xiv5C5vMQ1k666KtUovakxCSiYnjKfsaOKTPBupGBy8a05BWpFpBbsoQWWYRwkoCMzyRG6UExhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Yqj0y3jN9lopTHANK3cnIyoyFlD6QhHwDDpcd0CPnYCc0JRU
	4DehJkq+QQmtNA69X4XnbM3ThOyBU/dDsxRzFmkAygaLBw6PJ0BOjn7GaxTLFCwNVoI=
X-Gm-Gg: Acq92OHUHUMiVtAlIlRNTXJBilDnCsePhzyeqEQ6IUbVcdxBjX6HQ4vCHSdWRt83rvY
	y7Kkhxs+JGe4dR38t5jtzx8zEB1uxThmeHN/2HTUzO0uhsbO3fyvAFmuLxnkeBeQRCTE384MKy0
	79DXUWJl4i6lLZB1uDXClBykKGmK8ce898OVxbEn6Gb2b7xokl9AJkskgtS4UX62VtaeEEkgObr
	SpidMlPtcGVc5gS03qpa/rdIogMJo35Pmvt3LIStFEX4B82ljIFFaUXbeS+S0ymtK33cXQjVrz9
	8dTqoF0lZQdQu9T2siDRtt1n21BzTThxt3kPtejY1NBGvw3ha/n/y3pJiMA/x2wXcr0M4QasHZB
	v6DBQ5pAm3YQj9EXnmF5HjDhAWgpYLFawq5PHQ+gp+Gr8AVSKuusUz+jAm/9yB3+d2YXgBr5ix3
	4nKEY7gWZkqIju6m+wsrqsosxwE48eKEFqxHYOnEPhGIQdCo9HQtxLsO1JE3PRsIyIJYSxaRUev
	X0alw==
X-Received: by 2002:a05:622a:407:b0:516:e031:932e with SMTP id d75a77b69052e-519916c7ad8mr52017471cf.4.1781620945940;
        Tue, 16 Jun 2026 07:42:25 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb6442d8sm140759751cf.11.2026.06.16.07.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:42:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZUzg-0000000GHIq-3LTv;
	Tue, 16 Jun 2026 11:42:24 -0300
Date: Tue, 16 Jun 2026 11:42:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: alex@shazbot.org, helgaas@kernel.org, wathsala.vithanage@arm.com,
	wei.huang2@amd.com, zhipingz@meta.com, wangzhou1@hisilicon.com,
	wangyushan12@huawei.com, liuyonglong@huawei.com,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260616144224.GB3577091@ziepe.ca>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616104621.41915-9-fengchengwen@huawei.com>

On Tue, Jun 16, 2026 at 06:46:17PM +0800, Chengwen Feng wrote:
> Add per-device sysfs binary attribute tph_cpu_st to expose ACPI DSM CPU
> to steering-tag data to userspace, resolving the concern that VFIO should
> not host CPU-to-ST translation interfaces.
> 
> Follow PCI standard binattr framework: dynamic visible group, fixed-size
> 8-byte packed uapi entry, aligned offset read, root-only 0400 permission.
> Refactor duplicate ACPI DSM logic into shared tph_get_cpu_st_info helper.
> 
> ABI: /sys/bus/pci/devices/<BDF>/tph_cpu_st

I'm sorry, I really dislike this :(

Structured binary sysfs attributes are pretty much against the rules,
I think using sysfs at all for this interface is a bad idea.

IMHO the VFIO version was much better.

Jason
