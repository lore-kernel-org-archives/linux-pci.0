Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795441613;
	b=I85uq7xPS8kUVX2ZjXiMMJvZ8gaW3dZ1pMekMmMXgfDLxbjMx474jx05lghsUtWDRiGe
	 FQsphsiEFwswWhvum7Ud2LWiaAnRvwYgwIr+6zXw6HjH+EQ34cYiRLPcb9Q774J9xcFZ2
	 za8OI0nBD9H1vzrp8jHSd1pQsWpW5WxwK2ZIYF5dDDaeStqAvaPia6ypBAoIkJSfdPkLe
	 +cu4airrBPKai7CwwMR+CTFSl7VbhIyX/m6x2B6UomZGyViHML82mii6s3j9dC2y4Wqhz
	 rAn60vgLqGj7WHpBD0YYAM+RJVmiq4mfzLZ2EmN88sEfRuw2XKhfpE+xsseZfBCo6sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795441613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oM3xVs7K0+cGhkDXcxAVD5yhKjuUtv/5wSCqKlsYXus=;
	b=g+mapA6fK/NoBouDjB2O4kOD7UtMvYZFHPwf24QQYJyrAGQYw47M9Da9y0UBJ3f/CLv2
	 gbjmFAThlVdaZdkCIxr5ZCv0dvESgXhO9XnEGMX3RAR0ud8RPdi2VPnwBV8cXNyG8Yna/
	 yydjBS5VbkAWu/htbIE8rR4JHCUVsiyPGwMn32s30Fj51rZRlQhSQV/r0DeiWkoD6lu9N
	 +NJFzMnDv1o7h6PyntPox2Cw1E0grJPCHtURAiXYmteRJrYgY9gME2M3w+Vwpptto14XM
	 JU3bzV6hkxFexUyXIRkCVuRJoznLyoyTX28msl0Di7w+fqUSamW/i9aBe2ZAL1iG6vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bGqJ0gmE;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5E606A31F
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C5E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bGqJ0gmE
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-533202fe429so444651cf.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795441612; x=1796046412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oM3xVs7K0+cGhkDXcxAVD5yhKjuUtv/5wSCqKlsYXus=;
        b=bGqJ0gmEg54TrvyHR7you/cTamDxRPvKfx6+lknn3hsXarJNJrkiS7SiQxWam9DUYq
         CQ2rWNFXlM/coUJik2rUOZq6qNvPQZPxoDxV/R77sbVceNXUlaGc6Ob85W7itJ3c6czQ
         YsXpk5SJ5zT/eeZ/G4mww9cEhjCD9i6VRou/QNixxVXVrak91CtQKEUYJNZx0wQmRTrE
         lkhYbRb69PyfscOaNH4yaQ94YmWj2x0qJ363BmOWNroNe9uzZhVUi4xWAgqIsEqxV0Le
         +z6bj1sGWfweRaFzyrqn8W2HOj0g6uWfFhiQ5PDv8IVB9Rn0ryFDnyN1pys5MPRln21M
         GOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441612; x=1796046412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oM3xVs7K0+cGhkDXcxAVD5yhKjuUtv/5wSCqKlsYXus=;
        b=jNcmfzOQIjtz7MC8Dv/4eP91yx5IzjKVelkAhGhCyGxWe1mDPEAVvyFBbpVVXrUGNy
         ZB4teE5I6ew9uuncn/TR/107x0aLGh+hu+/xKtS8HPHNZidgSt4JTfqChMQNxJ58DJUK
         xnrlPZnUNai0r/VnzGvtlHwtGboq5PztJD2JTGfMpebzmDk+58wL3P+FbWYDV0eS7GM8
         QWwc6Mmvmyg+S+0iCy+0n3YqpkczOqrrmH537IyU5f93CHMTCH1ui+/yLZEcaaROG+bT
         eWLcXoNO161XEEXFnMrmK1u128idI+lMKm2uodSzTQjUEIBRDwQIKnuwr9uI64PZC3d0
         zNTw==
X-Forwarded-Encrypted: i=1; AL+hErE1vTZcKUw0BngOtBmYb4kSwE6sdHigSsIYKnn7DnUnKEi+i/CZGn9e2/z/RlM0fgnr/lfmyBrkwOY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sXZerAqCFCq4ZNibNBbSmF5vwapAp5+lMWY+dZR2Uje6RmFbW
	jY5wJxoBVJZagAA4Cl/ekze8q/8V3h3Lh9MAaawfBe4o2RJ/2DX9L7OKSg2IpoOUYG/FyVD4C7h
	kaX2UYA==
X-Gm-Gg: AZFdTZfyJybvnSKniTrOmP/yqCGIDbRBRtKPBa27qDh8jROFE750+tNYTjmGwtx7PkK
	RY3utq7QSS7iKJ6mYP1Prh1G5yo1PjwmPiHNgEs3ArT15U/19UUR1hMjmRsYy8ajclbeasTuQ8J
	1Mjr2uOMypHZa01vNYhTc4rp2excd8QFSRbCu+q5iaBmOsTDjCxX3Pc8ZtOWAk3HOBS0ii5ZMfl
	JBGVRAM+jzzsJuA4tb5LAT0EcoYHzzsJhKu8dlnTPQVqcqMBZi4qtKmI5K8NJYob0uY4EXqUnYH
	5GirrXuF1CWfO2EG48MW9f6IjWAPg7gNmkIGcOVwJw8NP3VZaSUGwsJt/xzOmlDadIQJshxB0Ge
	Dd3yX2GQiMgU3N8+e+unFhYG6pZElzUnUIYjJnpgbI1F/Cow+HX+IYlDdzvaclxaiB+/DwufW0n
	Jlh09tgSmhyQrr0FClD/BjgxSdc9YcyMoW/susg2J/xBISgbfz63AAUwn7B9e8DBE8Q/duFtb8d
	GrvzM7Tbms83NsULEMbVyc4CUpgJEMCCRauT8j+Whg5vA9DAk1fLAlgaUN8l8LdnTfKjYZQWyJy
	UFXeJG8g9y3yrtwPhzsFWWjTk2umDUaUmbqTj9EdBLy61qDukrYxaQpoFgarhfz3FNmo
X-Received: by 2002:a05:622a:5817:b0:536:78de:775f with SMTP id d75a77b69052e-55d8909c85amr32019921cf.15.1795441611495;
        Mon, 23 Nov 2026 05:46:51 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35055486sm8586840b6e.12.2026.11.23.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:46:50 -0800 (PST)
Date: Mon, 23 Nov 2026 13:46:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: John Garry <john.garry@arm.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
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
Message-ID: <awRDwxkrZjouy9b9@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <0fe0d909-a01b-4f4f-9faa-c533b8925f25@arm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe0d909-a01b-4f4f-9faa-c533b8925f25@arm.com>

On Fri, Oct 23, 2026 at 09:17:26AM +0100, John Garry wrote:

Hi John!

> On 9/29/26 04:45, Pranjal Shrivastava wrote:
> > Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> > queue's producer index to safely gate command submissions during device
> > suspension.
> > 
> > The flag embeds the suspend state directly into the existing global state
> > The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> > which acts as a Point of Commitment, ensuring that no indices are
> > reserved or committed once the SMMU begins suspending.
> > 
> > This prevents a situation of "abandoned batches" where indices are
> > incremented but commands are never written, which would otherwise
> > lead to timeout during the drain poll.
> > 
> > Update queue_inc_prod_n() to preserve this flag during index
> > calculations, ensuring that any in-flight commands that successfully
> > passed the point of commitment can proceed to completion while the
> > flag remains set.
> > 
> > Suggested-by: Daniel Mentz <danielmentz@google.com>
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
> >   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
> >   2 files changed, 38 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index a123810fac57..7f89e2306942 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
> >   static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
> >   {
> >   	u32 prod = Q_POS(q, q->prod) + n;
> > -	return Q_OVF(q->prod) | Q_POS(q, prod);
> > +
> > +	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
> >   }
> >   static void queue_poll_init(struct arm_smmu_device *smmu,
> > @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> >   	do {
> >   		u64 old;
> > +		/*
> > +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> > +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> > +		 * our new indices yet, we can safely bail. Once the indices are
> > +		 * committed, we MUST write valid commands to those slots to
> > +		 * avoid indefinite polling in the drain function.
> > +		 */
> > +		if (Q_STOP(llq.prod)) {
> 
> I know that there has already been other comments on this "stop" flag and
> whether to use it in this way... but, if CONFIG_PM is unset, could Q_STOP()
> ever return true?
> 

No, the flag is only ever set from the suspend path. Since I'm moving
the PM bits under CONFIG_PM in v12 anyway (per Will's comment), I'll
make Q_STOP() evaluate to false at compile time when CONFIG_PM is unset,
i.e. IS_ENABLED(CONFIG_PM) && (p & CMDQ_PROD_STOP_FLAG), so all of these
checks (including the one in queue_inc_prod_n()) just compile away. Does
that sound good?

> And it would be nice to not add extra logic in this loop. It is very timing
> sensitive, and adding extra checks can increase the chance that the cmpxchg
> fails (bad for performance).
> 

That's a fair concern. A couple of things here:

     - The check is on our local llq copy, which we've already loaded, so
       it's a bit test + a (not-taken) branch, with no extra memory access
       before the cmpxchg.

     - Per Will's suggestion, I'm making arm_smmu_cmdq_poll_until_not_full()
       bail out on the STOP flag, which lets me drop the check at the top of
       the loop and the extra READ_ONCE(), leaving a single unlikely() check
       right before the cmpxchg.

It does need to stay in the loop though, since the cmpxchg is the only
point where checking the flag and reserving the slots is atomic.. a
check any earlier (e.g. in arm_smmu_get_cmdq()) could race with the
suspend path setting it.

Thanks,
Praan
