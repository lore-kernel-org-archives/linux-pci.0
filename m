Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF75497B98
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398520; cv=none; b=tDHsMhqzeGJ1N44iHqrdR8QKtD7qGwSDv0hDtvR+VubRhO+58kpa2KJ5xdrOfDEue/wIy7qJu9A5ZAyZOROHbRdBWYUYfAbJ2uQ2D+nbsXPQy4BYYGayMQZ/Kk6R8i14PPXPYSPA+gX3C54a1TFRtfCjhfDAzSRgto2SBKHAFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398520; c=relaxed/simple;
	bh=7DGY4PHn22mBzSP+68tHwAmdJNJRgkdOyySSFzFXVIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQFOXUl9xoBCRiiRyvZ+pyUUt6aVwrbn7mOl9c/70aR1eYB+NWSAwfe6Me/waOCGu2a0WjOtCVwa2frtYSHK0H2tAe8D/PZXwyLKP7maeRk0Vzh7x/SdyUQppIKmkZJMIFtHzrkiXXc/0vHUhCrsATVvU3pG/1raUO7yy4tRK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4ChioHE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4ChioHE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9f6a16afcso18745ad.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792398518; x=1793003318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QNi/4g2rcbVBYZWdEY3YYi0+ZnogZXZN5660dVgk0m4=;
        b=X4ChioHEkuFWiRKCzceJoKnXlXtSRBMVJgbXapzum+Q7tMu50hO3ObhMyNZlLFqdgy
         6r3CwXpGWOhNTkwxk45nZUpiW1Z/a8PMbTgYad8Lv0K1AnlC/p2s3EcQ2JFkbsD1cbZ9
         ONJXhyPa1VegjNyT7XWcAYWV4K89V1kDha8nOYQwo3KnrkLvmqY5jCztjGD2PPIjkKg5
         jsQ4TXZTjuOV2SemTR2V+M19wPt2Flz/2ZRlgcL2FXgPQYpuQVxkPiO7RUCRPrpzLYhl
         U4hpk4SPfm97oEf8iktn23g12w9nDJlUeU60A8c72+0oeVu7ROE+1+PaYbOpoDjL6QMp
         nAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398518; x=1793003318;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNi/4g2rcbVBYZWdEY3YYi0+ZnogZXZN5660dVgk0m4=;
        b=ciJ+g7zkFm3u9UNcic0FQCUXgGP1XYbHU8wECKBs1fNv6pHztrgJsABPb31l68uKaS
         hEQwhvHsnHbV+kSh/V8jWRfrl/QcojfGVLzCK8JV5UCBb5bd3VL4ffN+kz4fRcVV4hzj
         IIa/AyFRz99jW+2xTT6FrEJ7bqUVaAQUFXb4uRqQiZQJgL1vsZygpLEUilsU2Tx4Mnbe
         hlcoLq1zJDrMyhhbHKLplnw+cpB/3zdt2/Oj3pDCMkOsBos8gV2lqytzsVG1VOL3TDmd
         rY/1y72ZcRNW7Y2IhfFvewSUD6jpxC1QeQmW7Lpoxisaib0SWLJiR3MtE+dvWrOBuu1m
         mCpA==
X-Forwarded-Encrypted: i=1; AKwUvBw39PhHKs+zTDyqh43AHwR9MLvaaUq/IV922f57IGkVr9PjnC8cibcKENeAdvfFavr7OAe2z0PVbtc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLiud3WXAxsUte1gU/HJy0MIU1i4cyHkBEP8LAn57qWAZOj30I
	oxIOBwkjA7VfIDFrRfCsYJwOyBUNHnh80dynrwh283Caz8d+uFi5D4avHKa/x1l6HQ==
X-Gm-Gg: AYBFou3P4sPL/U/Mp7orH7UUFKbzQqHp5uQSExJ8pH2lr3URbooe9y5aQOu3bBx/kA8
	JVSc8n41D/3bgdNi+8qFCNN7j5fJB1BGSM+UgGFqWcUyikdkn22JrjjBXfEZaPX5E88NXV8LfIa
	iBwC1MAUOoOUAVqkFTcMDugOs1SK/x9pbhNMHoQ85IVqFqLQho9IgzMIdrvhMLuqMnR6wgNRpSm
	VUraCCDKJKoOFaQmWT2DkIE5xvEE4GPpNT0s4mpWeJ6t06ozO2jEfQeW9o8qUPjVxqOH5UTRDNR
	PFOf/lh1BOASfazj9IZ/m44S1hsUtuv1wzZ4bmUc5Ad0xb9rHGYGOtE/CLVNMOCut1ZzKZCzhaG
	MnehIucMXv5dYPqCqWi3kd2w0qmHZqmQj3vNX8GJ40KRPpYfro5cQrVj/jmHYHnAPUu1ONSMuxJ
	M4u3qgEJRmEjMVV5uD7enFQW6lfzYSrdPVulJgFxtj44fV01nlQciqobATRL/0H6rtn85tsgy+k
	cMAbvOUuzecV4+731dwfgGvSutweig1PsNW
X-Received: by 2002:a17:903:1a10:b0:2df:8e89:3bff with SMTP id d9443c01a7336-2e9b334381emr6523115ad.17.1792398517740;
        Mon, 19 Oct 2026 01:28:37 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4872861sm16015390a91.7.2026.10.19.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:28:37 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:28:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <atXUrdEeHHAnKhBk@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <asZSQRSYBjbUaaH0@willie-the-truck>
 <370a947c-601b-434c-befd-4896ed523ced@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <370a947c-601b-434c-befd-4896ed523ced@arm.com>

On Tue, Oct 13, 2026 at 12:35:40PM +0100, Robin Murphy wrote:
> On 07/10/2026 3:08 pm, Will Deacon wrote:
> > On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> > > Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> > > queue's producer index to safely gate command submissions during device
> > > suspension.
> > > 
> > > The flag embeds the suspend state directly into the existing global state
> > > The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> > > which acts as a Point of Commitment, ensuring that no indices are
> > > reserved or committed once the SMMU begins suspending.
> > 
> > I'm not familiar with the term "Point of Commitment". Is that something
> > you came up with? Without a general definition, I think I'd prefer to
> > avoid using it, especially as it sounds like something to do with the
> > Arm memory system (where we already have architectural terms such as
> > "Point of Coherency".
> > > This prevents a situation of "abandoned batches" where indices are
> > > incremented but commands are never written, which would otherwise
> > > lead to timeout during the drain poll.
> > > 
> > > Update queue_inc_prod_n() to preserve this flag during index
> > > calculations, ensuring that any in-flight commands that successfully
> > > passed the point of commitment can proceed to completion while the
> > > flag remains set.
> > > 
> > > Suggested-by: Daniel Mentz <danielmentz@google.com>
> > > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
> > >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
> > >   2 files changed, 38 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index a123810fac57..7f89e2306942 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
> > >   static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
> > >   {
> > >   	u32 prod = Q_POS(q, q->prod) + n;
> > > -	return Q_OVF(q->prod) | Q_POS(q, prod);
> > > +
> > > +	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
> > >   }
> > >   static void queue_poll_init(struct arm_smmu_device *smmu,
> > > @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> > >   	do {
> > >   		u64 old;
> > > +		/*
> > > +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> > > +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> > > +		 * our new indices yet, we can safely bail. Once the indices are
> > > +		 * committed, we MUST write valid commands to those slots to
> > > +		 * avoid indefinite polling in the drain function.
> > > +		 */
> > > +		if (Q_STOP(llq.prod)) {
> > > +			local_irq_restore(flags);
> > > +			return 0;
> > > +		}
> > > +
> > >   		while (!queue_has_space(&llq, n + sync)) {
> > >   			local_irq_restore(flags);
> > > +
> > > +			/* Avoid waiting for space if the SMMU is suspending */
> > > +			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
> > > +				return 0;
> > > +
> > >   			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
> > >   				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
> > 
> > It's a bit grotty to have the extra READ_ONCE() here. Why not make
> > arm_smmu_cmdq_poll_until_not_full() return if the stop bit is set?
> > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > index deefb17e31eb..794b258550dd 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > > @@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
> > >   #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
> > >   #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
> > > +#define CMDQ_PROD_STOP_FLAG		(1U << 30)
> > 
> > I'm unsure about this. Bit 30 of the cmdq prod register is RES0, so it's
> > plausible that the architecture allocates that bit for something in future.
> > For example, if the index field was extended, then I think that would
> > cause problems for the driver.
> > 
> > Do we have to put the stop flag in the producer value, or can it just be
> > a flag elsewhere in memory?
> 
> Logically, it feels like this should happen earlier in the process anyway -
> if we're entering a state where we don't want to accept _any_ new command
> submissions, then surely arm_smmu_get_cmdq() should just start saying "No,
> there is no valid queue to submit this command." to everything?
> 

We can do that as well, but it can only be an early-out.. the STOP_FLAG
may not be set when arm_smmu_get_cmdq() looks at it, but get set right
after, before we reserve our slots in arm_smmu_cmdq_issue_cmdlist(). So
we'd still need the check at the point where we actually commit, i.e.
the cmpxchg on llq.prod.

Thanks,
Praan
