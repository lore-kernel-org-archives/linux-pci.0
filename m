Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE5D2D94A4
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635140; cv=none; b=MBBhpt2xpLOvPVPQ9L7bSZnGJ5vQYEQr5RSBKnb1gGPkYvalEHgT3M+CyGqb7JG5sDY8avHIWlYhdU7rF4h0Nt6saM8K+a/HYooBCP0rRb8FLy7rDQEQGiRT8VdkQn1Vaf/Fd5Y00tzOHMJiv7PgQm5flBWMO37DSjMJ/3S2oWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635140; c=relaxed/simple;
	bh=R26B82zxPcid0PkRJfA5J9VLBvvgfckzt4BZtC2Buu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8mhpO8z7RGO2w3CE4MtTMkLgMlmEx/8y1C+4URgiqew7RhQ2ojh4qo+OHJ6SB52b4L8X8gaD5uCOXTqR7NzXXvJSrYXWNxRzrNqT8eE/d4aHaBf693I9hUyN21NCX+S4hs/eYNPAbD2yu51K/OG5jM3s+6jBNgJgDYFXh2a8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H6/Pt2QS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H6/Pt2QS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so2550895e9.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 13:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769635136; x=1770239936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KW1Mn8hE3xrcR5j18KDZNCCnIS+/tf2Xt9JxG670/6k=;
        b=H6/Pt2QSJL40tHRjCnqTJlyeIJBSCnr6XIoN79q068X0MJU9XhocPvQi3HFIkZymOP
         p8kxmgBVkKuyGCdOTB6i9edsgCbEngNrTzpB+fJmWfV0QD5weM0n/jRnTPjP7dR8i0fd
         XPcJli/57tpaiplIsRRfu/P7GpWnWHZ7UOuoOtvXdjd8lOWeFXblOPmGyTJgQGpUDdVX
         TjBp17TAhFz4dhaYtX7FHH3TO+d7uWcui8ah2wAxjnHEdJf2DAaU243XGNDazfe4iT80
         ZPl523HaMWYMdHiUL4T38lxBoNV59O7P5kaPK3MmoGwSuq7gWlGhXbmGHaRcqptdF3co
         lYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769635136; x=1770239936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KW1Mn8hE3xrcR5j18KDZNCCnIS+/tf2Xt9JxG670/6k=;
        b=uwWjLPg5Ld5eZlli6He0dAtaX87+ksq+pfkdBVHEZWjDLTNmX3YW7nIPb0uPt6VUHE
         Qi3ytwvYXenruEO20+uJtnXSOW/Rkh/PZI4TRc1ODk/XCQ0lNMinnEYbiE/Wr+zeSkZA
         6mg/9KMDnZUfr2tb6X558tPP6RJN09G6LLdxGIopn/fNb5KbNaDdujbuXJMrNN3hUI6Z
         W9vabr9anKVvSzmfhI2R7s7TnpY57ru/9pVlR/8htOysKEq1kXQJw+4sKOs+cE99hgZz
         EnkEguIJZHa6DRBgyE1daI7wkEp9joPVhOv+KXh40nTpDPHKl6S8PRl2I3BIAnQaao+m
         7pQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8e0A7VpkPdGuStrJDdsW1QvW8P4nDbUQfcdW7cR2QKBtf/3q6QXhkB+Dk85Hs0sKg6wa9oQK9w1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVu+jcILF1FSDn1ZdfNqmtoEAW12i4k5w51KqUgY+TsvwdpAJQ
	kH6/TzjBtX5jicjEHN93jxDvFtqb/Iaf5GXbpVzA9di5H1Z5ZdWY40pSd5tj8izdq5U=
X-Gm-Gg: AZuq6aKh5I2rHDnO0flteLYr8vLpwFTNx/Fwzxl7WZAuF8vLbp1ejQJBZsEnKYRNEda
	KX2P1NOvdn/VVLDfFQ5HG+7YW8uI9i1uatPVkDp02WGvfTUrWY+86sYNdjpRChxZqWENX8wSmuu
	gGzzcNpQRnFRpyPy84QecyONWHBeASYF4jIEHjLKIk8AbD8Q7Eas8DAsPEZKdxA35Xz/lAxjXZi
	kVlG9tLVOmQPWMAKWAdtQi6/XinGPVd4+BzPWweU0qSFpJHFN9D4s85dUAtrE7hcoBm39LAeScd
	RN7s7I+5RmHu3lWdZqVkYAdCe7C4r/z5GkPOg7TZPdwqnelpfBt3FCA+77rDwo8pH4kD6ntrHH1
	7Pmry4mWe7asUGBie+jmLbadT3CH3Y4FMQngPakQT01NuzX45wFl3xsxBW6sym/ye8mfIO8d+/o
	/wmKzrvRtAzgXQV3ArcXztnh3H
X-Received: by 2002:a05:600c:3e16:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-48069c10f78mr74663935e9.8.1769635136165;
        Wed, 28 Jan 2026 13:18:56 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d78cb6csm3510525e9.2.2026.01.28.13.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:18:55 -0800 (PST)
Date: Wed, 28 Jan 2026 22:18:54 +0100
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
Subject: Re: [PATCH 04/33] mm: vmstat: Prepare to protect against concurrent
 isolated cpuset change
Message-ID: <aXp9Pp4YvlbJumeY@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125224541.50226-5-frederic@kernel.org>

On Sun 25-01-26 23:45:11, Frederic Weisbecker wrote:
> The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> runtime. In order to synchronize against vmstat workqueue to make sure
> that no asynchronous vmstat work is pending or executing on a newly made
> isolated CPU, target and queue a vmstat work under the same RCU read
> side critical section.
> 
> Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a vmstat
> workqueue flush will also be issued in a further change to make sure
> that no work remains pending after a CPU has been made isolated.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/vmstat.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 65de88cdf40e..ed19c0d42de6 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -2144,11 +2144,13 @@ static void vmstat_shepherd(struct work_struct *w)
>  		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
>  		 * for all isolated CPUs to avoid interference with the isolated workload.
>  		 */
> -		if (cpu_is_isolated(cpu))
> -			continue;
> +		scoped_guard(rcu) {
> +			if (cpu_is_isolated(cpu))
> +				continue;
>  
> -		if (!delayed_work_pending(dw) && need_update(cpu))
> -			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +			if (!delayed_work_pending(dw) && need_update(cpu))
> +				queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +		}
>  
>  		cond_resched();
>  	}
> -- 
> 2.51.1
> 

-- 
Michal Hocko
SUSE Labs
