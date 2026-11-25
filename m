Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614139;
	b=qOPQqkxlAGDpCT+xJHtyyI9Zcz66T5EkFOIHrEP5hEX5IQ2Vfpxyuo8ItHf0gO2kVQ0m
	 Xwroj1AehGaEZQVkCcuvy86zUk+c31YxdJoc1XfuzMC3XBJnB5TkYoGqsXmL0svx2FqqT
	 WlFHOOb4xeXQ6x2SHBchfUjv3KvSOE1siYi66mEhOx8QfBW1I1PpVuOdajEPh1pIoMRLm
	 Bxgbqb9oJbq6YsHOfQGG3ZBuaAcvLS1OvToWdsPgoEfy6g22It/ePtGnlgjEtz+J78JJi
	 1P/DL31OuGrdVc9uFiydTf3/8S7eisVPrABn5rjc+3O5+jbjy1/8GlLqplGKFsdIeVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614139;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RgRBi4Exuv8nq+VhlE2oQhamCxOtxwj2AD7UWFn0Grw=;
	b=1B5IfgM7ErCpMurnzgb7hNmJinqFMEqLKeLCfzGwgzQSwew16PzPdeu5huyzlc9bVed6
	 Epv4EF4KeTDqEQL9BcoQ5SrdNqAqsNgQLo30AXsgZDFf8m8FfEmfHs1c579GLxvoEYPVx
	 h2sCriBIOjMIcWCENW51fe38aZvs2FVYg6j5PYrwwtQeIHjmOFLOGr6WGldZPxzWIo9UV
	 p2IaJdQRnO5WwXmyINMrHLgozejcGUydMqfgL9VU4QeMr/QK/A4HLP0dtUvQl5SX/+0nf
	 gyX6grRwKCGzTFl7QjdRQXzuRTBYKmAyG8mvE3gMyGyA9r0VS8tVFZsvNkhbukj7E1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IplUWbgb;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17A606A326
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 13:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF17A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IplUWbgb
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-150ef97e790so35154c88.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 05:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795614138; x=1796218938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RgRBi4Exuv8nq+VhlE2oQhamCxOtxwj2AD7UWFn0Grw=;
        b=IplUWbgbS9FL4a3Nig7c3FEuaowPX3ddyUlH5/bSWhAv0RbvH27O/DEOtT4NhBiLt3
         Gmeyv6UjCcTcNKK+uGWXxJO4PhmrOqV4NRNYrtevLixqxKUuZLTc0vwPNwMInE7crkis
         9qX5M9JC7CxsBf2Dilqip1nNJJtTBAKcQnqlx4opSywJ0ropWbsnrRhX0b+wpDbUHAhj
         ExcGN8E76+RmgC2k5mj8i9rY/HA/jvcexVTtAstYEizUmboiRPeIunb8dxJlCUfgQYdM
         BoX/4lVbEXCv8pZJmpMY5waHkFZZzcyVI4iM97bKuIl1Xqr4oi0DHoOvxT2/XoByTap0
         eylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614138; x=1796218938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RgRBi4Exuv8nq+VhlE2oQhamCxOtxwj2AD7UWFn0Grw=;
        b=gNT5mvtawwpbfJFcjZxgxgUswg/LiQWjuzxsICqPzxoUgfrJv+v1ydBCxdPngQ/gr+
         RfrZDPrzdjRvdosVIpeGuKYpAWwxia4f9R5+0N0daK6X2damjCUyJrJO5VP1UVvGe+6l
         vicyj1uF+1c/nrJhknZdybT+X0A2OP1HPvMHWjZDXpliZm86tWtrFUG+ORIeJl7879dg
         FctI7IoZsjwbWEAuGa39ZdwKU/vb3KAapZNresLc+uSkcvEjEbBaou30aKzYMV7G5+si
         /D4OuTLiPxKgjuK5txMqLFpvgRgc6E1WOgbrhQZtt3Sz+OqeVpG1blrrL9ae6V3uUF9m
         qmGg==
X-Forwarded-Encrypted: i=1; AL+hErEE0YLcACf1v08fzwyxM4kLY4En7o3dugNeGuxCh9dyGFhCykxoczOab0SNBg25aoAzdfGgs+cSO7Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SGALORvNLh+FNTilf3eOlzODqnV9MBKDP5cxt96dCbmphRPEK
	PLFJ2IbHQrFhJIzliiBzUxzvIryrrdotjHvrvMtURp1nnR47Gi4xvfNDkZT6fPUnXA==
X-Gm-Gg: AZFdTZcaDcXTrlaKu1Uh/oIG+Eb1pAwSEsSJNTc6WL4ELBgM7oDTcTrSI/IBFxDQxNh
	fSkrsvnQT51n75IHI4oTTUPMCyC5OLECXTeZucfNh06nw+nyFz5WtDJ6XvvLuK9qESJapZNlpco
	Ee+4NLYlFyik3mCmROB75QZu7TK9P8n0DbsCiVKe5YoitxGQJicjamqPElF1yGb4pOmWAMGQCbA
	4QtHyolJS69h6uWN/9XG7zv4voT2lF/W0pGRkEpP/kOjpuLWY34c5NMXBnPXh+raLFzK5VqykT+
	KtRggIeOgX+lRixlCBMbuvcNJ34AZ2ks9lH0fwtTEvBVjfxHKWYWEFU1jmv7+/foqZo4Zujaohz
	+7wlcXln/HK8GJJ6Rh0rBmDKTUIe7+uQjLSNQAOypTOIPADvT7efC2/XCEpPDkcHokKwVmsc040
	uyxGK95bDFhSpiXfFSRr649u+cboRJ+5Oy4m86ypm5UHnE6MatWsnsPHOTbs7/orHe1CW9TVH8w
	PThErjQ7R7txb9TbDcYu8+AXRq1dbSC6O/q5hROaqZ/FJgF0trffc4D9ES1xsGePNVCa3kG6mK/
	aQFCwzmtIQJr/jQUlPzk5SH4AgBzMQVYhh9EvMgStA/x41qSRqJWk2QdOR9sF3jolwY=
X-Received: by 2002:a05:701a:cca2:20b0:1b3:c4ba:8e0b with SMTP id a92af1059eb24-1b56338d12dmr4008785c88.2.1795614137046;
        Wed, 25 Nov 2026 05:42:17 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm61787393eec.26.2026.11.25.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:42:16 -0800 (PST)
Date: Wed, 25 Nov 2026 13:42:08 +0000
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
Message-ID: <awblsA9PMu4jwd3P@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <0fe0d909-a01b-4f4f-9faa-c533b8925f25@arm.com>
 <awRDwxkrZjouy9b9@google.com>
 <f0cc8236-d06a-4f2d-a9fd-e60977017979@arm.com>
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
In-Reply-To: <f0cc8236-d06a-4f2d-a9fd-e60977017979@arm.com>

On Wed, Nov 25, 2026 at 09:37:02AM +0000, John Garry wrote:
> > 
> > > And it would be nice to not add extra logic in this loop. It is very timing
> > > sensitive, and adding extra checks can increase the chance that the cmpxchg
> > > fails (bad for performance).
> > > 
> > That's a fair concern. A couple of things here:
> > 
> >       - The check is on our local llq copy, which we've already loaded, so
> >         it's a bit test + a (not-taken) branch, with no extra memory access
> >         before the cmpxchg.
> > 
> >       - Per Will's suggestion, I'm making arm_smmu_cmdq_poll_until_not_full()
> >         bail out on the STOP flag, which lets me drop the check at the top of
> >         the loop and the extra READ_ONCE(), leaving a single unlikely() check
> >         right before the cmpxchg.
> > 
> > It does need to stay in the loop though, since the cmpxchg is the only
> > point where checking the flag and reserving the slots is atomic.. a
> > check any earlier (e.g. in arm_smmu_get_cmdq()) could race with the
> > suspend path setting it.
> 
> I just find it odd that we try to elide commands here (at the point of
> command submission). I would assume that any commands would not get this far
> - or even be submitted to the queue - if at the point of entering sleep.
> 

They never actually reach the queue: the check is right before we
reserve any slots, so nothing gets submitted.

As for why the check sits here and not further up, we did try that in
the earlier versions and have converged on the current design:

 - v1/v2 [1] elided at the call sites (TLBI/CFGI) using
   pm_runtime_get_if_active(). That raced with the RPM state bouncing,
   i.e. a caller could see the SMMU active and the suspend could kick in
   before it actually submitted (as Daniel pointed out).
 - v3 [2] tried to fix that with a new pm_runtime_get_if_not_suspended()
   API, and v4/v5 [3] replaced it with a driver-side biased counter
   (nr_cmdq_users). That worked, but it meant an extra atomic on a shared
   cache line in every command submission, which isn't great on high
   core count.
 - v6 [4] replaced the counter with the STOP flag in prod, and v7-v9
   [5] dropped the call-site checks entirely, leaving the CMDQ as the
   single place that decides.

The callers themselves legitimately run while the SMMU is suspended,
e.g. a client unmapping (or a deferred unmap) while it's off, and we
don't want to wake the SMMU up just to invalidate TLBs that'll be fully
invalidated on resume anyway. So these commands do get this far, and the
only point where "is the SMMU on?" can be answered atomically with "I'm
committing commands" is the slot reservation itself.. any earlier check
is racy against the suspend path.

[1] https://lore.kernel.org/all/20250418233409.3926715-1-praan@google.com/
[2] https://lore.kernel.org/all/20250616203149.2649118-1-praan@google.com/
[3] https://lore.kernel.org/all/20251117191433.3360130-1-praan@google.com/
[4] https://lore.kernel.org/all/20260414194702.1229094-1-praan@google.com/
[5] https://lore.kernel.org/all/20260527221407.1756491-1-praan@google.com/

Thanks,
Praan
