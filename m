Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D149504C
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320006; cv=none; b=BHC2e2cPl1Szfmka4DwKutbRngivv6cCI3WsGJVvi1xFlSp/zw7T2Z8X9T87xh1nupib3XBOUsOHK//2nDM1Wg2H7KJgXwBz+px/5QHDV/9VGF/f5qXCZirQjkYIcmv9j15lFxGDrtfJgMb6/m/bX3jgMh30tBUDd07UJixTxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320006; c=relaxed/simple;
	bh=UwB+F0FHcNSBGG6swZnEH5GGuemVym5TTzxuQgEmrAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZDjrPh8yWfBzi+g/UJTjTTZ6PA05/kA0QIxeOQStFNxUvbGjpczuNeetlT9yLlThhCtw16gyOqpifdY7tiYmxwYO9xnzvKeIu78ucPQPrqZV/7FF/dE/jJdWiR0AdrL+Ta9pJT2/4nfWVj86KOPT5KErr300w0WJWOxZrYiuN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CX1s8gVb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CX1s8gVb"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a378f90555so1895488a12.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 06:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787320001; x=1787924801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eFr5Fl7tzSWyavCPXm9cL7Za53Ty5o305M5CicClyUw=;
        b=CX1s8gVbwGBoAZ5MITyN3iU/MniHe6hzxW6PkBgVAWBb7KzfhscKrHkOo7Zj6eZGu1
         y6gNFNyyIguKjtvxNtwrh/FQHRwlk2gqcjzk9jFH17QgntgGJlWVK91AxwK/TWtJ/Ljz
         9Hh7kz9KnOb/hA6VSsTeIuUNxSxiPKGp2HwdPMYl1cm9ThuRY8uSGEee9nShl2Y6Vg+9
         1MSUKWITvoMZMX6OZ1cNEcDAmPRdBaxCyK55ClJNaPQPJgdop8FrujOHHGnxNlVl4x2R
         B+Kwd1DrE8NOHnrv8rfViIRAjzpfMMKS75SGtJYONNjUDwvrGJ7rGuRmchkoBg+8r3F1
         c4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320001; x=1787924801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eFr5Fl7tzSWyavCPXm9cL7Za53Ty5o305M5CicClyUw=;
        b=gxxEEBvszTWTJUA8FOBIionKKdbqw53FE8tVarSQXZgGZ1xknQvLJaYV7INQCFmj9m
         gc+cZ7+ovZdoFqtkC8QgNV5m1yugJhLB0GFThgNS9HsD6cth3ZpsHmMl7+GFkkG8Y+eQ
         YQ659EF/AeM5FPM1NP7xnxd3E4jZkyY5TYzYMy2+ki9XQl4vXSunr7nwWD3wJzC7WimR
         6yzrSaa/3o7FFVstmL9FUG+S3B21gUqBU8QQPL6kxaZ7MTcvRjrnRlpce+9NlZDv31D/
         Iw349cHVwFvpJPlbxf6/YwIIwGifTaLyGJXyIhlXazD8JN5MvXCgwT8ZFXTR2Je93tlY
         GJ5g==
X-Forwarded-Encrypted: i=1; AHgh+Rqq8c1+DW+GINmxwFHcdrXSv8hsDiGe8VTVd3frTreiu4Af3BwqDActGDXpTAQ0fWBFv2YJkomLuzE=@vger.kernel.org
X-Gm-Message-State: AFuF++m1BJXIQuM/tHZQdn9/RAf6malf2VXDUu7vD2MuGSY2DGjx02r/
	3ulOve7cIZ+Swb14c+2M5q3GohocI4CU3HInrSTVHlYK5J1jy/FHontperiebZLQNg8=
X-Gm-Gg: AR+sD13hM3+rH1mYmNZVDggaOIaHlAVfu5QnvRqHv0wr/S6OVYJat0w0UK3wgKDTLzx
	E6x3qk0DupiUJ/Hsn275Hdvt8RxyTc6sVpq4DvpYqFv6EnKEmZ/1DegPRAXRoUrxKZHJOOUJWjM
	Jnov212fv8THv81avriiQQl1C4PdVXt2cBcPrNlQ0dDs3MA3gisKgDlA/M4UzI/8QhHMge2V7VL
	JVQj1jXNExSUN/R7Mh8upXrUqJSkFiC6XWbMRhQI5aZk3B/a8XwhdofGHlMk+QZXdP/QeB7y13b
	Cng6ZYy1VyP3I9S3n00wTy38TIrCeQiTDKiEUxz5xqOWkgGYrWfm79W8u9b+MVlKExd19TOy82t
	Q+315klQHWaFrhAIZuQmOdGE5EQu3hyyi5noJL1EdC0jn0qbNnen211bQt3MnSlO2IkAdWDgqYM
	y/GSVdqBrlcAiA3qTf7QJVX9DvzSaGcb8zCZ+zVLfVzxnnrOUoGFiZbieXhLHsYA==
X-Received: by 2002:a17:907:ea8f:b0:c20:ff26:336e with SMTP id a640c23a62f3a-c246a605cb7mr617167766b.14.1787320001208;
        Fri, 21 Aug 2026 06:46:41 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e224dsm490000166b.2.2026.08.21.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:46:40 -0700 (PDT)
Date: Fri, 21 Aug 2026 15:46:38 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 2/2] PCI: Include human-readable sizes in resource
 assignment messages
Message-ID: <aohWvp0bSeK-Xk9r@pathway.suse.cz>
References: <20260808172308.282591-1-bhelgaas@google.com>
 <20260808172308.282591-3-bhelgaas@google.com>
 <andr0LDPlgD5kEzT@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <andr0LDPlgD5kEzT@ashevche-desk.local>

On Sat 2026-08-08 20:48:00, Andy Shevchenko wrote:
> On Sat, Aug 08, 2026 at 12:23:08PM -0500, Bjorn Helgaas wrote:
> > Include human-readable sizes, e.g., "16.0 MiB", in addition to the hex
> > "0x1000000" size, in resource-related messages.  Also consistently include
> > the "0x" prefix.
> 
> Instead of repeating many times the %#llx (%s) and accompanying
> string_get_size() calls can we rather introduce a (sub-)extension
> to %p[R] (perhaps against 'R' to print only size) and use it?

I am not sure if I understand it correctly. It looks to me that
this patch uses string_get_size() for printing some "arbitrary" size
values. Some are not part of struct resources, so using %pRR
might be confusing.

Unfortunately, implementing a generic printf modifier for printing
human readable size is complicated. It should keep the type-size
checks. Also it should allow to distinguish binary vs decimal
size calculation, for example 1kB vs 1kHz for 1024B vs 1000Hz.
See https://lore.kernel.org/all/ZbFd5TZ_pi7q3hso@casper.infradead.org/

Best Regards,
Petr
