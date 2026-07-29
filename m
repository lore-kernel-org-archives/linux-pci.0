Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44123A5448
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303993; cv=none; b=AmvA9LNcLMHRcO656tSV0xIJ2Gf/dZP2puRFNPp1NFl0vuvoKOIR9TzIQvXiqJKgGhUWpl9LTwzf0ixtu1V6csCAFX8eFDOJIU9lt1XAtpQdaQY+ooazuEFQFVmv3S8npLVfBrex+pk6foVbIwiVYSbZmceRZbVnKwjE53qIOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303993; c=relaxed/simple;
	bh=ydP+87D/K348FSpdC9NbnctdfuYDb3MlvkZ+qPWf4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB/kWlcWdPLl1aISI2tJ/Upaz6y3kyzYqijnpvOq/iSpgSNvZPfqK8UR3oEekV/JMYAgwxasWXsr/sc67r5hm5uGik0IKoFJFh4XA3pbWwPxN7qz9tkbJzTYs0l/9at326FnJyzl5kZEafmg/5JfJJEdv4dRvgKQH07MtyFZF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDlzlwJz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDlzlwJz"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdf36f63dso73125ad.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785303992; x=1785908792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KUrSKghuESWPVo/dW96oFPOfRQeq5DnIatYi5FWLDOg=;
        b=YDlzlwJzSwUaxfX2pp0QjT3ySEOEwq0XhS+axxtAfoDZdN7ZgvMJ+4y7KHme1MD2OG
         6FHvLkkCLXcb3LwKzgb9ReptEuHBD9Fgrzzc9cPPCeZsyB4L4Eca0h+StNOBCseGtW0n
         hF3vP3/mM4Py9gK0MsGM5WjRrqZGpEP+G9XpuMzLaNsK6ckNgvqTraHl6ZDZQpu0f3MG
         C7N2W9X0Yfz6Ov796JdGw7FgIj9rdS6mNr8fv8PZvz41aLe+XhGEq+FZOmWcZnlUrcai
         Y6LuUNPokGWpA/LzzvJ5DhzjzJqG8F23Hv0EmcrhQVPlZe7kwNHvOtS/6zm7KJzQ/KJu
         3JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785303992; x=1785908792;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUrSKghuESWPVo/dW96oFPOfRQeq5DnIatYi5FWLDOg=;
        b=bQpIH0FKYiWjfBsO0GXmdjquVM16mBxZihQNA+sOLhE9497FoL19DOkoqWn63FXf1Q
         k04GxPOrRvi7xxk0QJW1aCdUtmslekyfnO3VgG636nrJvydIUQtHdB0JKKRAPRaSpjH3
         6hngv+oIVXIeKY7+vzFl+pLTwSKdmF5TmE0MTfOnmu/Fl/WuSRPo7n5lxTi78aVzT6Fq
         uprHJcHzIu5Ac4xyefiFw7mRTDMTlOsE8lfD156LcQBWzzD+pFjNnsGS2PclcSksIMy5
         LzWLeILNK+BXb2ZJlWV1XVzpPxcw8k5V0F8pgdzsl4H2Y1jJpTMHg/+dmNUDPVcDCkvv
         yAAw==
X-Forwarded-Encrypted: i=1; AHgh+RpXc+6nBTh0vwUNnywq8z0B64+5797HpRougyec6rbj6FyO0RVo25DpIJqDh2IdADvvQI7Gzm/Ozyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVTjSoTiTHKAMI517L0brv940rNooYHQn+wYY9hVwAczHVyy1g
	0qBDjyOmtYiB+khydMTW9WOEyBEmQbdVnM1aTYXkBb71sn0mfw4b8tnFB9V//ydtBg==
X-Gm-Gg: AR+sD10JUGSwKCreAYX1CHODKB9/3NLny8mFmpKojA725zD964JIyqZWf7NfaaZXyUx
	6iqJuhdlEs0pb4zB3z09EhhiMxFcmB7paCatH8YDz/fbZUFLVUaoh+EK1R08ec8l8SGlFny0fIU
	hQTU8iSVP9iJWnyXFyQ4jP4dGjsggjFZs6RVg/0PB+nssJMGZ98MfZVB8aAJ2zxXfgbvhMKmKx4
	xphFJfu6OkN0pN31oDrDTXjpIduJ/asmE4Ly8SGqIaoR+beDkJ0A00dNHco1llCySWxPgP/1clq
	hcwOEbWrahPL1CKE+ZyO70ItW5XDXZGxjVRoQN92FTOicCruslY/sxvvV5gJ6IEvbmRWjAkBQOp
	VQwpEg9Ep9K8kBb1QlHXu03eRHl9oq2/v+Wlu4+nnINcof2cVo7IWKOvDT162Pe1VIiInwugnti
	Igu3NspbTXp5zaeYFY7F2DEyZ43uyS65Im7FlHPd9k8ONAwScZAI6vegFIu7uhuEZuMSRnPV/Hc
	xg4In/M9Fvi8lvHaYJrjAQ=
X-Received: by 2002:a17:903:4091:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2d026c4dcc4mr1313315ad.0.1785303991374;
        Tue, 28 Jul 2026 22:46:31 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f642fbf74sm2219437a91.17.2026.07.28.22.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:46:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 05:46:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	bhelgaas@google.com, kevin.tian@intel.com, kees@kernel.org,
	smostafa@google.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com
Subject: Re: [PATCH v2 03/11] iommu/arm-smmu-v3: Add
 arm_smmu_drain_queue_for_iopf() helper
Message-ID: <ammTr2kvjpiOHkbT@google.com>
References: <cover.1779944354.git.nicolinc@nvidia.com>
 <a62db13ab63916e9a62cddeec41a74a98cdf6a8f.1779944354.git.nicolinc@nvidia.com>
 <amkcQRVylEe_t-yP@google.com>
 <amkqZbPJs9qly4pH@nvidia.com>
 <ammMf5z-Gl-Wygk6@google.com>
 <ammO+4W/dGC8kTCr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ammO+4W/dGC8kTCr@nvidia.com>

On Tue, Jul 28, 2026 at 10:26:19PM -0700, Nicolin Chen wrote:
> On Wed, Jul 29, 2026 at 05:15:43AM +0000, Pranjal Shrivastava wrote:
> > For PRIQ/EVTQ, my only worry was the HW producing more events,
> > say Device A is detached (we call drain from attach_release) but Device B
> > (still attached) starts an agressive DMA with multiple PRI requests/evts.
> > 
> > Maybe we should go back to snapshot based polling for that?
> 
> If you look closely, "pending" is the snapshot, regardless of the
> growing prod.
> 
>  * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
>  * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
>  *
>  *   cons0                cons                 prod0         (prod)
>  *     |<---- drained ---->|                     |             |
>  *  ---+###################+=====================+=============+--->
>  *     |<--------------- pending --------------->|
> 

Right, but we write back cons to cons_reg only after we see queue_empty()
We have a do { .. } while (!queue_empty(llq)); and then we call
queue_sync_cons_ovf(q). Same  for PRIQ handler.

IIUC the helper relies on cons_reg being updated:

cons = readl_relaxed(q->cons_reg);
drained += Q_POS(&q->llq, cons - prev);

Thus, if we get a storm of pri reqs / evts, we may never leave that loop
and queue_sync_cons_ovf(q).

Let me know if I m missing anything?

Praan
