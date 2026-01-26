Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662723375A6
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445704; cv=none; b=ab4LpOzjITDOnYCd3Fgw3+/HjWmtvys3Q/jktSJGCDHYjBG6mEDkEI4qjDv2ymmuCvY6P00W3+U3l1Xsv5JbdqO6UuAVgHHpSZ3ZnhcbNfOFRCwVim7yppOyF0OUBxh/krJgFE33f/Mhh3iIju6prdYXCAT4YPMjeGP1RU0odtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445704; c=relaxed/simple;
	bh=8yoM3+JoKX/J9QDS4HwajBIfb+G9TUqyNd63YSi5fTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOzXyw9PQyzQ4Oi8v/SsG21JbGYPSLfukx/qqeQR9rfWglR6rXYZZ2sWmL0xsBCgyUcaA26qMirNN31iREIDPPc1GtGEKAmZeyqvY7+b7t4uGRjWGjS6oWm4nAd9goEU7Gc3+YwLzdadGQom4L5/E1qG39xOeq2KCgATX21iJp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WW/xyn0r; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WW/xyn0r"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2796049f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769445700; x=1770050500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEUrHNK8dWefUqOs00hvfwKIFD0uk17xYeaKpauo658=;
        b=WW/xyn0r2OskO1/gzWNoULgDe2kdC0eHk8bhHWXchpqj6zBf/26ldY8HjHl/v+zfKq
         0qzUPWlXUqmkd09XTetXlHKx+7HC6pXXogPKuOmnKvpxpo8uT1gS2ldSwn0+aY6O3zXv
         h4u28Zn2G+3wOJKfpnm0NJLdQ9RlpUGvGRv+J9GzTaSPIcAl7PT+NbuvAF13p7AvUCps
         HQUsFJA9gGnmG+46x+XVjR+e/k9QQB5OdIVD1VfeWImnSfxGSdfEeYyD+7A84RHrUs6Y
         +XsYMZpdegAEXSTsvZ0x4GU1LO33SWaRjXInzhh+Aa6FFN1CV/9RrMu25lmu96Z4WiHq
         WHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769445700; x=1770050500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEUrHNK8dWefUqOs00hvfwKIFD0uk17xYeaKpauo658=;
        b=hBxZ8m0rqbB+AiVvcXLlZXj6Ju/sdHPWSC1kJCalfrwPlSI1JfMZs7UPq7h892LUkX
         6uO9Oow6OVM2co95DHKXr2j82If3qiVHFcTieyc/Q2NdpGife2MOvlKEmpSnbDUWBmyX
         ok/q/eU2fhK8T1Ofx79KVFePbAeicqRG4bUVi4RDy0IJfjp9FMhrm1gmmPhN2sa+h8BG
         pCXl1FYis6m74skM/RpGktNHkqJiF0bd8HDEXssspn8j4f/6NM1pTOAbG3GDeGhtkn4C
         uNKW9vN/KS9tHNH1EJspqgMieFuikFgUYdgWwW8USDqpKjQBo+k/mTbE5l+UUZcLjKkJ
         Jhgw==
X-Forwarded-Encrypted: i=1; AJvYcCUFR335/XPlzm3ppJQAxQF7BJnnKAHx6kzOfnZEeHywYdU8fAdvhdzGz43gHo8TrcVPsHiB8stvJ2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgkvH1PF411018E04AWJjYudBYpnNJP4ZKnRSM4AJaigNL1Mve
	mHRbVbb1oBKBv4zmKzF9tYCj17ofT9sWCKH8HWStN3GdG+orW74aaU7UDFgsFgu4LXM=
X-Gm-Gg: AZuq6aJlZ506cxIiAnn1haKlkpIwXTct9H5EkZI5EGzG6LvpbAsfK4XW0NyHkWPuIlc
	AOiBJUNmicwpimI2xBzCqNDWODvcEhWXtq6r67xesQMIigV6R+oZxUAp7FEAV0VRBJ9JhLafmB9
	mUXXzK9QsusvconUDtG2IhUR3HcUXZioPkZTfPUFsQf0ZEsyPIKdSVqjNR+06j+GuDrnSxpOyTU
	SbqXJX5zHruvzNGJbwhEsIKEVzIaReB7hbO/m+DefqGwOHQQ0B1bjgLu5nAbFqH3d0ZGeltpsPh
	PrMqvd81jhcuZwM8rTvK+u3s2P80uQyBfuSYTSDs55PMgWYqzmGOAXuqziJn34wXLiq315VDg02
	i7Q7dxPbFcFBmNPZ7Cs74STHMVyz384tSZeKHgLirctAl5keYnKpci5j9JMZWshBw0UkYX8TBgd
	XpwHGrsaFWwTTSNfDgc4PqBmFs
X-Received: by 2002:a05:6000:4212:b0:435:95ce:84cd with SMTP id ffacd0b85a97d-435ca39bd3emr10384617f8f.54.1769445699664;
        Mon, 26 Jan 2026 08:41:39 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f74b15sm31194587f8f.35.2026.01.26.08.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:41:39 -0800 (PST)
Date: Mon, 26 Jan 2026 17:41:38 +0100
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/33] memcg: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXeZQoSHJ9QX7B6W@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125224541.50226-4-frederic@kernel.org>

On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> runtime. In order to synchronize against memcg workqueue to make sure
> that no asynchronous draining is pending or executing on a newly made
> isolated CPU, target and queue a drain work under the same RCU critical
> section.
> 
> Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> workqueue flush will also be issued in a further change to make sure
> that no work remains pending after a CPU has been made isolated.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  mm/memcontrol.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be810c1fbfc3..2289a0299331 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
>  	return flush;
>  }
>  
> +static void schedule_drain_work(int cpu, struct work_struct *work)
> +{
> +	/*
> +	 * Protect housekeeping cpumask read and work enqueue together
> +	 * in the same RCU critical section so that later cpuset isolated
> +	 * partition update only need to wait for an RCU GP and flush the
> +	 * pending work on newly isolated CPUs.
> +	 */
> +	guard(rcu)();
> +	if (!cpu_is_isolated(cpu))
> +		schedule_work_on(cpu, work);

Shouldn't this in the guarded rcu section?
-- 
Michal Hocko
SUSE Labs
