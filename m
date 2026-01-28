Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E6337BBB
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589909; cv=none; b=W7CTLGirUa0bRoogY+PuraSh/wtYs/Q/XblnSzVfZJ4T/nBg38FIlk5rpfgLP3jfyjgv9mam+34NeVQYjphAOFRDB5p1Z7ojbfopMLIFmQ9UjOF5F3Q4VsgxuGx4Bkacl69ZhN8YoOuLa1MKZTSKLep1mL4+yQbHpc+Fhp7GQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589909; c=relaxed/simple;
	bh=RmjPdOoSLN83hdmAOBaQ60Ic1/65Z53zJZ8NP4f3+Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNmyCVXlsrKxweUql6H9b5y2Z6hQKsxu9dt/K3DXJioyu8Dd41oi4l/v/3TsfdaVnb+LRKCRXPgc667mGP08BEkAcXF6D5qsqso1ZZc13Btyz7VfzswTdFUBTIuIOPrCAruAX0x7tYP/+pfr9hdcjppG4C516FmQRQkTtjRRyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SZIbsb4u; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SZIbsb4u"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so63199155e9.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 00:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769589905; x=1770194705; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yzZ5aaJur2cGbo3tv1Z3AlCZuGpqhSu9RlDH7L/IIPI=;
        b=SZIbsb4uqLo2GtuIKPa3bbLA7N6dH7jjl6viB/R0/10DmYtuzJlEe7d0Lgh3AsecRy
         Jb04vA7E9/uLgkJZj1z+cgSxI3Pw1kEmK8VTCRIPmIz0NhYj96oATGrLZoy7Q77sTuDw
         mGjKnzWQTVqorHggE4D4U6/8Mf1kmcypiioWs0sIzDr+ORIOuLY1V6G4ENM7uvS7yfSs
         ZNvihc9rHZx9imvV17/9Oe01/vYcd1kY83/3Hw76N9KkKngapUjdwLQYcCYYynsVx+y9
         1Jbevjw8z6Hb9P7DLqp8t2bANC8o9Q00TSBYdZxWguV1RtcG2SS3gAKfvOKvJZxcgBXk
         4HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769589905; x=1770194705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzZ5aaJur2cGbo3tv1Z3AlCZuGpqhSu9RlDH7L/IIPI=;
        b=IRR3/tua0EX3MpE3V01Z1JlnbWVTMKga5ewV57RlINx6Wh+XbCxuD86DPJivOQr0gw
         bNFsXHo+VotBHjl2qx9PiE6qlihj2XmaoDPv220BSCkOFEr05k0cAZ3OMD61DScTO1qx
         vH8wK9OnprxGMKJTvf3XALp6hqbvKRNErq/5/Cgt9PSstkgVQNK19b7VVKcnbTW40X2l
         O4TDtuCyhoKSfmLPi5jodNqyLClP2MO3XurtzgvSBNXQBcQjXN/BI9QDS6KR5SWne8/A
         oTsPUitjE55RguHxCrOs+0GgnjHbEjHwIhRXh4tk+KDEDrtpCQH6GZrVH+V2k2n35xrj
         lpug==
X-Forwarded-Encrypted: i=1; AJvYcCVEmELuX56v5M2dgmxWR6OaRKsUMChg7D9o3GEW3UllBNNJU3vJ6rXlGeIoOfgMnOT0Cz1q+N18peY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqM6Ne3b+Qrbdx4WkNvo50AH3/zAJhyIFydokwO4ehH7JQ1ru2
	hwTuvRzCO5TwbVSbPkKvak07IdMeSkztEGPHxtIfgOepHLUBeBU+m/SPitM3feE15OE=
X-Gm-Gg: AZuq6aL0WRAFIsiGZrrlqruC6oNyt017OD3pEcbDK/PMIZqvPwpMbCsy8Tko60I8UFr
	40zsCmrBv2n/qet4gPh4PbpQo3gG72NwnO4RZSJgHmA96EBFD/4PVao5HizR3Rvsa5BMzDAB6gK
	FZdiD31cRhiuKCXgD9S0nWtz3GLP87nceQV/nFgliilkUKWIXIUnbN6T9l3H1FouXDiCDbOzucI
	GY0GBFDc3gRArmQNNhCCt8xAk+QxRxu1kBGisaAj7AUuG08Hskc3XiNuDzylCv8wLxyjJBOi30P
	iKGYTN/u+kP/5jp7WURfi5kJU0EQ4Gx3xdqx40Otm5SdWaaXrkoUz48CaUIXdTuJLiBkCWFBX6j
	RuWHqk4dQqWzQ9X7HciuNJX/bFU0F+pbpPIl5uyA1+G+9pDjhdI6S2NWEof0KYmSUO+8N3qlNQ8
	7BgfpQrJlhfoU1luRDTTVmtk5s
X-Received: by 2002:a05:600c:4e12:b0:480:6873:b2f6 with SMTP id 5b1f17b1804b1-48069c557d0mr54819185e9.20.1769589905328;
        Wed, 28 Jan 2026 00:45:05 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066bee7d0sm121124905e9.4.2026.01.28.00.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 00:45:04 -0800 (PST)
Date: Wed, 28 Jan 2026 09:45:03 +0100
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
Message-ID: <aXnMj1phN3TJZkNz@tiehlicka>
References: <20260125224541.50226-1-frederic@kernel.org>
 <20260125224541.50226-4-frederic@kernel.org>
 <aXeZQoSHJ9QX7B6W@tiehlicka>
 <aXizUsfywjtIIN50@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXizUsfywjtIIN50@localhost.localdomain>

On Tue 27-01-26 13:45:06, Frederic Weisbecker wrote:
> Le Mon, Jan 26, 2026 at 05:41:38PM +0100, Michal Hocko a écrit :
> > On Sun 25-01-26 23:45:10, Frederic Weisbecker wrote:
> > > The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
> > > runtime. In order to synchronize against memcg workqueue to make sure
> > > that no asynchronous draining is pending or executing on a newly made
> > > isolated CPU, target and queue a drain work under the same RCU critical
> > > section.
> > > 
> > > Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
> > > workqueue flush will also be issued in a further change to make sure
> > > that no work remains pending after a CPU has been made isolated.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >  mm/memcontrol.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index be810c1fbfc3..2289a0299331 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2003,6 +2003,19 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
> > >  	return flush;
> > >  }
> > >  
> > > +static void schedule_drain_work(int cpu, struct work_struct *work)
> > > +{
> > > +	/*
> > > +	 * Protect housekeeping cpumask read and work enqueue together
> > > +	 * in the same RCU critical section so that later cpuset isolated
> > > +	 * partition update only need to wait for an RCU GP and flush the
> > > +	 * pending work on newly isolated CPUs.
> > > +	 */
> > > +	guard(rcu)();
> > > +	if (!cpu_is_isolated(cpu))
> > > +		schedule_work_on(cpu, work);
> > 
> > Shouldn't this in the guarded rcu section?
> 
> This is what guard(rcu)() does, right?
> Or am I missing something?

I am probably misreading the patch. But I've had the following in mind

	scoped_guard(rcu) {
		if (!cpu_is_isolated(cpu))
			schedule_work_on(cpu, work);
	}
-- 
Michal Hocko
SUSE Labs
