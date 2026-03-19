Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843D18AE3
	for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2026 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878893; cv=none; b=gF6LqTuVLhGWn3017BttIQpmHYKrTjn8eEK3Je+q5Liyjrb+Ic98DtCg3DHcMaTN9uvzrwwUiTuFakZgnlWQBHdpH7RWsU69pCzaFtepv78G6Itt4trLQa2IzfPMi6pdo1hNrz+f7YRaGx8PYizfap8dfN5eoQLEKpTK2JJ7uBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878893; c=relaxed/simple;
	bh=9Lna6RLq1PceWhp4JFSVoi2qGNT1NzgxgPC7c15ur54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QY/9xMWAngbKRSMaoku+mDw/BCsGnCG8UbraxrguAWhmWq1ncBTCxRAdXtmCKYVDysiF4c1Z+yZm1CKKW8+mAkuL4uu16PIYje7vQ8/L4bcosxdeTr5dhU8HMl37A3Y6rYPRnYEnqXrlYaAj9A6hrdBYQAMF5qIoQsoDU3ThL+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYMEnsf+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYMEnsf+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b052562254so37275ad.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 17:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773878890; x=1774483690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AY/dmLi/z8SUAAMZ2gqdSfQxfr35ot2Vi6eYrVHNvEQ=;
        b=AYMEnsf+Le994ULy2rEq51eWGliyhrW/hHuHIaV2LvIKJEGj6YPhgmYSac0BiULaw1
         etUMK+ydOHcKd3zbtDOqrwjLmzdvFAIuc/gfnoqPE8nhvUWUwvPQg2EjMswxMq8Kgxct
         Wx7ZFNdgGrPFtBeN3V8WgBfSlEfvBJimI9mzNMDEi6CGvNEf/oL3uhWl2m8nFENnRlll
         ucGx1rE6BEgwYvrM46iLF34TKbnS8QFZSTHiUFVnovfhxFw7CAksGNysfUA60n+l4Dvu
         KQaMm64isVNa3VZbG0+prjOyXl5sw0Y6yHNbslSS5iARctXoQRA8FMLea0+g+YUPg/ae
         gCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773878890; x=1774483690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY/dmLi/z8SUAAMZ2gqdSfQxfr35ot2Vi6eYrVHNvEQ=;
        b=Abku7n3hcR9H6/yCB1AScYHUbe+mowNeGuFAErDs8/+SMcvrtoylA/QDIYG0ILPhyD
         mfOOHIgJ5psDrsCz9lD+4kGVv4JFVJ/w1IvUpfdpQLgBPiHdsPd2EP7MX6PXQtl2C1sH
         3bBzFwm3rcRjridX0uNJMru6RDgszd3VJHytYMg8Miv4NqaDox+QOodTeq9dHc6v9oTL
         HNQdcPYY5/YZDiCJQhZdfspqhExAJU0ToeVk+rtGBIV9Dt/WlmPVpdMNFW1s5lMxJMYQ
         6ivDS/ziW/tfnyXlbZWxlaz2NuAa0iKlUgPmAQ9Az9RKe+p06zJR2DvxxFyHjq8MV3fp
         gMnA==
X-Forwarded-Encrypted: i=1; AJvYcCWRda+fQbczx2Z/KE9A2dTgeWbQycIZTyvFvFcXZf8ko6nslmE1KHIkb5CC0TGUEgvMOUswR0gzV8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMPFGAsHASaCai9osSNC8EdmL8LDHrVNLLqF/GQaGO3qipDDp6
	Lm3AIw637COSCrssJ3S0Yx607yirWMSNBwANPXhrFG8rhlIjQAFhd3IaGJ/hCd//z2bEl8WHFse
	kdGYmUqQC
X-Gm-Gg: ATEYQzwnkcXVm1oOyVQiigB6jsLiGss+T7+VeT//E1RkmyKRwwbk7D+VAC2m5kSckOf
	13itIGv+zjM4ZczHGIN6u5StyDtwDgc0GtIvkKm5mV2k03SZKsOvzvH0+kKEFIg3DMhEBGf0Qga
	Qp1o6yyYrLT95I/sqPZ4hs/82LCCjgYYqDq/CXXAy49nUjNXaCEcsBUCTphmodQl+U03ABbs1xd
	d+hYdTHSW4l8W2smh/xyrATOAzMMvKWdNYhAtZ2eUVoGFKxIf7FHtafTPs4MCzVMmO+VNxT6XEp
	cX/CeKZy4RHh+PLdqse7RF9jUs1hs7khQNhaOHjXO7xnrDzrRrGPA2+t64X+Mkk94E3ePzbzIgA
	S+GJAIWO9WoaYvJlSpf3I5KP73VKEKCYcM3wENgJk8JVFwCPJNT9ohd2kDJqDYDXSfS7R8UebWb
	Px0ou/gxEVmKgrJZGip9ClQEr97aEPGYWWc94hmZpRdeuOYExQWzmL1rKVwlK3Pg==
X-Received: by 2002:a17:903:2ac7:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2b077b4ca86mr1596195ad.6.1773878889199;
        Wed, 18 Mar 2026 17:08:09 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe6162sm3741880b3a.42.2026.03.18.17.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:08:08 -0700 (PDT)
Date: Thu, 19 Mar 2026 00:08:04 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, jgg@nvidia.com, rafael@kernel.org, lenb@kernel.org, 
	praan@google.com, baolu.lu@linux.intel.com, xueshuai@linux.alibaba.com, 
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	vsethi@nvidia.com
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <abs6PudCAh-eVRPA@google.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <absfAT4jgL2f3UfR@google.com>
 <abs0CQCrFlCsV6Ls@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abs0CQCrFlCsV6Ls@Asurada-Nvidia>

On Wed, Mar 18, 2026 at 04:23:53PM -0700, Nicolin Chen wrote:
>Hi Sami,
>
>On Wed, Mar 18, 2026 at 10:02:32PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 17, 2026 at 12:15:37PM -0700, Nicolin Chen wrote:
>> > @@ -895,9 +898,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>> >
>> > 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
>> > 	if (sync) {
>> > +		u32 sync_prod;
>> > +
>> > 		llq.prod = queue_inc_prod_n(&llq, n);
>> > +		sync_prod = llq.prod;
>> > +
>> > 		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
>> > -		if (ret) {
>> > +		if (test_and_clear_bit(Q_IDX(&llq, sync_prod),
>> > +				       cmdq->atc_sync_timeouts)) {
>>
>> This will not be set if a software timeout (1 second) occurs. Do you
>> know if the ATC timeout of Arm sMMUv3 is less than the software timeout
>> in the driver?
>
>You brought up a good point!
>
>I think ATC timeout follows the PCI Completion Timeout Value in
>"Device Control 2 Register", which is typically set [50us, 50ms]
>but can be set up to [17s, 64s] according to PCI Base spec.

Agreed.
>
>> If not maybe we can handle the software timeout here also as the cmdlist
>> is already known?
>
>I think it's trickier.
>
>If the software times out first at 1s, it means the CMDQ is still
>pending on wait for the completion of ATC invalidation. Then, the
>caller sees -ETIMEOUT and tries to bisect the ATC batch or update
>the STE directly, either of which involves CMDQ. But CMDQ has not
>recovered yet.
>
>Then, in case of a batch, all the reties could timeout again. So,
>it will fail to identify which device is truly broken. This would
>end badly by blindly disabling all the devices in the batch. Also
>the disabling calls require CMDQ too, so they might fail as well.

Yes, looking at VT-d currently and the queue length is 256 and this
spirals out of control quickly.
>
>Thus, partially to answer the question, in case software timeout,
>I am afraid that we can hardly do anything.. :-/

Agreed.

Do you think we can maybe document this somewhere? Maybe add to the
cover letter?
>
>This means I need to set a different return code for ATC timeouts
>v.s. software timeouts.
>
>Also, there is another problem: when PCI CTO finally reaches, the
>GERROR ISR will set atc_sync_timeouts but nobody will clear it..
>So, before calling arm_smmu_cmdq_issue_cmdlist(), we need to make
>sure there is no dirty bit on the bitmap too.

Yes, Just to confirm, do you think this needs to be handled regardless
whether we handle the software timeout for the ATC invalidation?
Basically to cleanup the bit on bitmap.
>
>Thanks!
>Nicolin
