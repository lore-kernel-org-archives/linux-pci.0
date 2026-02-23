Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F21A9FA8
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862470; cv=none; b=IuMAsYwQMvNJbMNFt7hygYkryJ7LAPQ2/kSjKNJ1DIpmaCk8eZvrn+/qjL8UW/oPYUhZsLdhKMhiAhO+o/RePlWHLK2eFHZzpSYKJJt2Ss2sSrIR3vFr9lMqoEOr+zLLf30x82m4WANgvs8egN8mEhzVKOoNtSJhMsIjUjy2tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862470; c=relaxed/simple;
	bh=RBDa0jIO4VbsfMCQSIREc9cffsT7gvfxFla9G/UD7gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLbhgiavU4skY4zw6a9nBqZdu5PXiKRlRTvpK2sa3D4xFwU46RTeEAZX+brFI4jx7EuAUcRWxGKsR7ewAtVbkYpaDKkc9M9vcALdIdiak6wCSpouR3+7D8D10ToJrpt65voFhTPHBculh00MNX1bCKqSzd53ZRhwAjcNIXy2CgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PqHtQ0ke; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PqHtQ0ke"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4ba9abbecso4423690a34.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 08:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771862466; x=1772467266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HX29uEwlmShEjfFqkdwl8Eb5l/ZDj+DL2kVuvz05S4k=;
        b=PqHtQ0kegO9Jus8W4cxNJI34/48vONyAjPHsLA84w3xhcTH+ehRGLWMutcJXZ2RAc/
         sIIW38BVXjib20Hzzie5/NskGtknX8AWizrrYqFC+cHd9PikB2egS7JaNbi54oMe6P/4
         ddf9EB7qZxkwqk3fcPIUygOni6aWtkYOvu4jDSCBwwynMsMsONTgNsrQ6SoIaPGchix5
         apan0c7Jll92fM9SkRm6Fx8tqeLhj2uls5bV+0bT0tWyuhs39yMoF4q2AatkXEkfO9jQ
         WZmQcIv6TmU8UxJu44cTa6JGtGGdPs47Tmw+CdciuwJYkd046huqr3OenbIXyacOEqFB
         SY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862466; x=1772467266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HX29uEwlmShEjfFqkdwl8Eb5l/ZDj+DL2kVuvz05S4k=;
        b=d1gRhtKohk967EpgectgBpDeJoKpzTef9NTWE1fIE921Oh+dkoDv/bdwFCVn8jg2gV
         o5HtrTADTxbX9A35xEkMf5R7AvrjvZ79ou+jRZSqFJFoXTLz2VXB7g0hA9V/TcbNZaDG
         dqLj7Yp+9/xGtAlQUzrKa/nhLJgcJqSSGjGfBUmUhFw15bQdE2H33fIn5w+Dwhx9Kh7Q
         mX6vVdyyn5IX8JEhVUIH/oERrd5WvJJDuu9SHUSpI30y9R2CsGL5y37GjiOAH9RaTRrD
         W+ZIkIlV9FBVnaSnwqHFGwYT8kt/bST3EoK9IDQO0Ft1odmnu+icmui2rLe7LMhBnsIz
         85qA==
X-Forwarded-Encrypted: i=1; AJvYcCX3pwLlB0xh/HETHVm51H265z9bYqEkhzzNLYyfK+rcc/tKzIhCFKMIzbkqu91zRIazulDyA8PHkL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv65D2Z6cJvl5zFuluPtl0DE+E8jJaTcq8aMeejGZCd+KxbFqG
	O6W+MNMgGdLdenaZ0pQpVdwOdSxAbeT3TqKkBqGcDrwMvkJEuGmEMUKrs72uPXu6u3U=
X-Gm-Gg: AZuq6aI3tW0w8Tqh+AWw1gsBzpZ+JwbwsIzsl7h3T84LPCbYbksgP06/mSf6P6RpJ7q
	yKFN7p2JuLc63ctx2oRhJkJvsK09hbdXJIGIi8f2PzSUZ7ePC4cqY8TGxrjh2xkXfehg5MqtHSx
	vcg6xzsVyh3ANcw4oQpcd6B3+C9f4oIg7W9HJaYGfJ/IK4OT3wpNiHgTjNLM68vgFOnmVnTdljh
	dw6oEutyP+u8+Us60nCpFRnxfG+e4Z6LtqLsXg4uUSiJGl7MvRIlyRCvx9Z3898X6s4H5pCqfv4
	1xC2C0B/qioDcMJv5Li+r/f3OpvqZMT2gkf3dpTH5Je+Nf+wo0mNUXQS95RLCtMqH/V1oA/nTz9
	77KQQfdPaVEH8n+0xEnVmYumpTNV3INC3CdJrnhzj6MfT6UaucL69rGw3giLVzrghSZ1H82tloG
	mrhEjOK0Lc+08AtujXOfFl8K1t7P74SHtT3k6NuNS7Aim85rHE7xEfBK0LwXGtzH1p5PqXlW1XP
	ksrRpbN7A==
X-Received: by 2002:a05:6830:3153:b0:7d1:853c:83e3 with SMTP id 46e09a7af769-7d52bdf416bmr6177467a34.2.1771862465520;
        Mon, 23 Feb 2026 08:01:05 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e37:2309:3937:4469? ([2600:8803:e7e4:500:e37:2309:3937:4469])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d55b9a8498sm1062950a34.28.2026.02.23.08.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:01:05 -0800 (PST)
Message-ID: <47be2ff3-c25a-4aab-89fc-53921af8b0a9@baylibre.com>
Date: Mon, 23 Feb 2026 10:01:03 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] mm: vmstat: Prepare to protect against concurrent
 isolated cpuset change
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-5-frederic@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260101221359.22298-5-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/26 4:13 PM, Frederic Weisbecker wrote:
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

I think this might have introduced a bug - or at least an unintentional change
in the program flow.

scoped_guard() is implemented using a for loop. Now this continue statement will
only exit the scoped_guard() scope rather than continuing the outer for loop. This
means that cond_resched() will be called when it previously was not.

>  
> -		if (!delayed_work_pending(dw) && need_update(cpu))
> -			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +			if (!delayed_work_pending(dw) && need_update(cpu))
> +				queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> +		}
>  
>  		cond_resched();
>  	}

