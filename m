Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE787383993
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381999; cv=none; b=AQY1yvSHtpKOA4AXsvLg0LucMRfdHWfeLuclVi+qCqCLe+DAGPR20a9JenbGjdXIYLKWog9JjSVE6HUVcF+qyjOCiw77qPSg7mf3afbft+sJLhiIV27SMKmI2b4fSJmh+zkDFBjmBX5peRwfZ48HbFMVDFqd3zuD9wJM27Wsoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381999; c=relaxed/simple;
	bh=55HpdrZ1XWqM3uwC+a47+vakAvshOA/Toys7NpGVJzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Num88/U3hTEavpzEraO4amto78Q9+7OgCwDNon4YQS3dP0dAYGbwYmHapJlq6YxUdkUhrFZEczzgLT00TOiR67zaLApKFFnPDaIdRZNZW19q2IIQPnjvRjnvci2I7FUKtH74P+QBOxJHpKp1DYoHHdBd1w8LhVyxrgJTwGcjIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAiFXflX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAiFXflX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso8750465e9.0
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779381995; x=1779986795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NA/nM16UoxaTsk3A7SWQL7q3HkgK647mNtY2rDcRyyc=;
        b=hAiFXflXTEbRl6U5Air/vBGryJ1P7DUwv5y5hFcBfrvyOOjvwLAPWk6boHEMfrP+03
         djrSF/MmhRRc4oKAARffcHojm9lrMfH/yxDwEmaCsT4BFCL3flmfjoZXGq6TFSC3TeHl
         JsiTufiR6et1mz+pI8XV2U+9x+ymMfxMCAW0bX+y+95+67AVxLZvt8B0iLXkU9d/aiqe
         9TLZTYgekPiyf54s88p+J1C3j1Lc4MyofWrYIv5jQC1MQsWTxKDTJulTH9sW3bkKM6Er
         8ENfEnS8Rye+RBlr7U5dk7H7qISkWK2Sz6IRcVfJFcdljcS2gaAHhL/dDTECxI2slWnI
         yang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779381995; x=1779986795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NA/nM16UoxaTsk3A7SWQL7q3HkgK647mNtY2rDcRyyc=;
        b=U3AmzqzL6QHyrGzuBT7w2rwPtUH2SPngcRdo4IN/cHVll3MYT5DfP6Q4X+LR7LcsVj
         gyTwtnKEx+D38ud3A7i0/HMMxtUhwJI5tWLmqB0OTCTJE4Gn8MnUnM+TVmiOONJxsFw+
         9GnOajZusIRL8EbLlxcpmsgaHGXgYha8EmafHK8CxdOvgM6ntMNvQ2eHzqVf1ASGEpY6
         +DQepAiA2H2Iy0LMK0V35GdEFQqyw28K9RBm31J8YjRPcFahw9EZzS5XgL6Ht6gNxciN
         ef9TV/417h5BgLDJ2Q+4Utl/dAIF9Kdw1+gEIQWyoNt8gjAgq+WTkWA3Qcsk3Y5FX+xU
         4xfA==
X-Forwarded-Encrypted: i=1; AFNElJ956J9IckZ5Tgf1H9sXKN2slILYSy+ITwtkhFIAv+MxK5s4Ns5S6tTVuBRXgZFEV1xL+0zQbdMeKW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcpGcPPT0budUlcxTyytdqEFucojmNComJfZkTqbEvBlsu3kC
	fVbd/93h5vPw84qHiTwIDEaT52AgcDMo/abr13K5cUNGZGMP306bphR5
X-Gm-Gg: Acq92OGfLOtqGkQbZOu6T/fc5gbqIZq8ZYlnh/v6d3GwanKwi1n85348S2vtUoHylat
	GHoKvK16LxjEJe/OHTL+OsNAShvfMt8gjEsPhGhg9767ziDX4Ko53Amk3uSV3L09Tp99tAX1Vh5
	znCIfLjRAQh6SSOW8c1uogjVUeYFZfLPsJvO9QqqgvVs614lgWUFejSG6tbhRb9kUfcD74yteSd
	1H8j2hWGtDdsd6Ud8SHOChlGm8MK+l6+HPt5Gh4/IfIf1AzAFv2NjFm5XEcCfocmMDAvryLgFy2
	epBxtDagXyZsdBFjLSGnccpVdnJTQWiXn/D+T33T50vwZhE4183aTccaXCymRxPP/FFVvWioa+e
	7Kl9oKOfK/1gqmFBTzv8kHPvJmKQYiLtyPOpDhBMK+iIZStEA188FmKSRekf2nvil8XnFvle5CK
	vPD/zjAGNpkKx55br0Fjk1U7fLdLliyeZGoL7twBwaf5SK3sQ5PrlJn9g2Ocz73qci
X-Received: by 2002:a05:600c:45c6:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-49036033502mr53623425e9.5.1779381994891;
        Thu, 21 May 2026 09:46:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035ecac15sm31613075e9.6.2026.05.21.09.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 09:46:34 -0700 (PDT)
Date: Thu, 21 May 2026 17:46:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, stable@vger.kernel.org, Petr Pavlu
 <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, Gabriel Somlo
 <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede
 <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Baron
 <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, Tiwei Bie
 <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, "David E. Box"
 <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Alexander
 Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry
 Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 01/11] params: bound array element output to the
 caller's page buffer
Message-ID: <20260521174631.71a06440@pumpkin>
In-Reply-To: <20260521133326.2465264-1-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
	<20260521133326.2465264-1-kees@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 06:33:14 -0700
Kees Cook <kees@kernel.org> wrote:

> From: Pengpeng Hou <pengpeng@iscas.ac.cn>
> 
> param_array_get() appends each element's string representation into the
> shared sysfs page buffer by passing buffer + off to the element getter.
> 
> That works for getters that only write a small bounded string, but
> param_get_charp() and similar helpers format against PAGE_SIZE from the
> pointer they receive. Once off is non-zero, an element getter can
> therefore write past the end of the original sysfs page buffer.
> 
> Collect each element into a temporary PAGE_SIZE buffer first and then
> copy only the remaining space into the caller's page buffer.

Should this be using a 4k buffer on all architectures?
Initially perhaps just using a different name for the constant until
all the associated PAGE_SIZE limits have been removed.

-- David

> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  kernel/params.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 74d620bc2521..752721922a15 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -475,22 +475,36 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
>  static int param_array_get(char *buffer, const struct kernel_param *kp)
>  {
>  	int i, off, ret;
> +	char *elem_buf;
>  	const struct kparam_array *arr = kp->arr;
>  	struct kernel_param p = *kp;
>  
> +	elem_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!elem_buf)
> +		return -ENOMEM;
> +
>  	for (i = off = 0; i < (arr->num ? *arr->num : arr->max); i++) {
> -		/* Replace \n with comma */
> -		if (i)
> -			buffer[off - 1] = ',';
>  		p.arg = arr->elem + arr->elemsize * i;
>  		check_kparam_locked(p.mod);
> -		ret = arr->ops->get(buffer + off, &p);
> +		ret = arr->ops->get(elem_buf, &p);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
> +		ret = min(ret, (int)(PAGE_SIZE - 1 - off));
> +		if (!ret)
> +			break;
> +		/* Replace the previous element's trailing newline with a comma. */
> +		if (i)
> +			buffer[off - 1] = ',';
> +		memcpy(buffer + off, elem_buf, ret);
>  		off += ret;
> +		if (off == PAGE_SIZE - 1)
> +			break;
>  	}
>  	buffer[off] = '\0';
> -	return off;
> +	ret = off;
> +out:
> +	kfree(elem_buf);
> +	return ret;
>  }
>  
>  static void param_array_free(void *arg)

