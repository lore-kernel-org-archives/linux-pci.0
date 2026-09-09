Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204237F313
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976706; cv=none; b=K3BJFvaw7bl7mjZzFrIgczu5Tg+ePrUloIq6cNsiGZKfVCkpL/4XtdsPsH90OtvHSipnXhqShF+1c2CG3IaSINmCW3B+CqTU26XZgkwExSCa0OqVERn7vgnCgr0Q/TRoBuGfFClMXiw6wdWmgVlAl8O6NSFgCEQ6BiG0ttfEG88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976706; c=relaxed/simple;
	bh=Fe6nVRkXFn8YOQFqrHXehrUUPgaHC++2tndyandA/E4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzaFSseUN003oCi4gLqs3cyfvGL/u7AJimJTC1m+86R1Ah6dSc17dIFdZjOCIerHqUfpvkP057OzRkzNyBncU5k6vBpCrSgJKytpGbikkB/CIcJlFObtHE8BxySz5pO2OsUYi1xS7569ybAd7qtipYYWQoqVqgCeX9XFZWUfLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJqS/YCD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G8b4av8P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJqS/YCD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G8b4av8P"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7dCH2600152
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 17:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A3G5n1JEubzvFQoHqpYm6GVn4ifURnR0UinvnQLMEbo=; b=gJqS/YCDncjuUTiC
	uQBCyhOKBKswcxjl6dcirxA+/EYMfhJpbDaYZ8t2Qb+j0kIcGJr94D02bT4oTxRc
	ucBScFxNoUMrzNYGQH5TbZKwBs/LPzgm96WWjRzoQwP/V70T865RcJ9k0NV4QCIY
	M9CnABckcXx56rPcHxSN2osYwc5n+PQQEaKdLiMBnMXKcuEaiHatLfnuUMhedEPV
	kshbzVTQnObDG7B5K8+vJifmzUyRTlsLIFDYN9QgqPsTR9Nr/Ak7UpfP0tk5dou9
	qFsGCtsbH9p6K0eymdvsAX/1hKw9oxHwvpMjKZ8UWwJaedIjvMbEQGRynfcKIC2t
	nBknwg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r1eys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 17:58:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b6416441eso7108659a91.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 10:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788976703; x=1789581503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A3G5n1JEubzvFQoHqpYm6GVn4ifURnR0UinvnQLMEbo=;
        b=G8b4av8Pr4SmWx/pQoOmSFjy6Az/D5Wo/ZCrUf9YXyAAMFQlgCQsJ6SwRpDI2tuAla
         tA9znma/zavzAsRpmZOL5anJe0fL6ychUgS+laZjHMJnWWaz3wwGiAQjyHWOK8pikHim
         h5SGYKVNPLOLdvtf48ELto7EoID6Qb1F0WLnMAcnQkhbkhtfjrJIxJn9+SJfucJj8Ckv
         IrAkcClP30VxT18nmrriGe+KDcqwtLG9QhD9orIceUdH1/4DPioePvicXsHmHD0hWHy0
         AHBtqRRMZDFGggtwnB5h3n+kzLHDcVSE+eOjtsJL3/zGbg7uCP6eWFjTWGfQhOCosDy3
         nXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976703; x=1789581503;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A3G5n1JEubzvFQoHqpYm6GVn4ifURnR0UinvnQLMEbo=;
        b=IF7APPW1+G17D/nrYNwkomFfX2fWMAuKvBI3qRXX8QEQkJQ15di98OBfw1XeTkxhXc
         dvLmcLngDBAVt2Wu41nmYLHNCXUGFAx6m6OE00HqxcVzuOWr2k7qwXPGcPBmj7f47u5E
         TlXeLLSHFoy8k54VnGkce7t2ZYm51G2AIj40MLaJWY3pT6QKEvmF8zHhFNaT4DWW5k0t
         gYo2lyEPGm3Aj+2PUg6sPsFJuFw+cTYUATfYAJGWGXVNPvqsM/QxU0d1YOP8LDpxpu3W
         lstq2VdZKPsN3us8W7eN4Kcy6t9A0UDvU3sgHvjiy+z8CRwxX5igFaPCqc5luKRuSyB7
         iVjA==
X-Forwarded-Encrypted: i=1; AKwUvBwQhwFsAfy7I/nybdMBJz/cZzgatytNKrFET3ogsEVDf0delRBc9oPcPmOzaDtiNEfx9L4dHgipD+c=@vger.kernel.org
X-Gm-Message-State: AFuF++mlaEwUq/APlxaKEHlNwQJ6EOOfdywB8S2DJnzjFSaZTGMBx/O0
	JhzeoVkdcz/AK3cJrDpSdscdIc10ajqmWSssXG1DYFekugXcsuMqkI4fhiSjmTqmDAXOIilyCa4
	Cq6f+nzFO3qWC0nbCkBqMdLwh44DsA2c0JSkS5Ua348UX+5WtuJvoYFZDPyltkf8=
X-Gm-Gg: AYBFou1X2480hzRLeEy0xb7eapuHmbBO6QNJsGuoY1U0VZewGPWSfUEaHa4SvnkaiUO
	t8gm29K2TZIvBZjBCdgssDC/6W/WoLUVaXaVM83s/Nv89TbRvNqbHL9UjRKkm1A2EURjF8LkSbR
	Rf74etvbKW2gKmGujEr0zb6VFB04wTUPMw0Tj90aOrMhyC/1uNieM12oGl8+//uO0/OhJy249IM
	ZIU/r+EazqMyvyNkWwqMTKK0+uty6RAy/LhOulM1pKUKZ1NIsoX6e+wsa//54iOdQQfIo/gDhTt
	Q7UvVI68fJpDBiYGmVyeWqMQFnr9ur6VtgO0Jy841Ahr7h7fOZ74CaRG08xm2+s5+rg1SQ111Dc
	3aAp63s+lBbB8Lc6PJuFtMKcJkLw=
X-Received: by 2002:a17:90b:4d86:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39d70980956mr2813331a91.5.1788976703360;
        Wed, 09 Sep 2026 10:58:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4d86:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-39d70980956mr2813204a91.5.1788976702119;
        Wed, 09 Sep 2026 10:58:22 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm40569970c88.3.2026.09.09.10.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:58:20 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:58:16 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <skaestle@nvidia.com>,
        <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>, <bbiber@nvidia.com>,
        <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v3 07/13] iommu/arm-smmu-v3: Disable the queue IRQs
 before disabling the SMMU
Message-ID: <20260909105816.00002e4d@oss.qualcomm.com>
In-Reply-To: <apuLhri9BpqncLRT@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
	<a6fba7f7a01f5955dfb44d34adc6262c8534e829.1788222486.git.nicolinc@nvidia.com>
	<178846311318.1308030.6301643510859406126.b4-review@b4>
	<apuLhri9BpqncLRT@nvidia.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa19e40 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ikd4Dj_1AAAA:8 a=YF44DY9b4ahQXEfF3N0A:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwMCBTYWx0ZWRfX71xESez5uzfs
 UEgqZ7R2DFvGqs4b3bimqUW+6yr9JphTIe335JsRp7hZEBBwy+9ArjRKwnFBg7eP59ClhjRQBpi
 OZu69btdp8N/ue/096h+zNdtW01kbLkRWiqyU9xhNfABBFfE1ouSGuXuMhOs5wDMqZj0xYpncBv
 xL+bwBW29isprDEUaOnXcS3zekq12aCRk28ikThmV4HbkAfZVv40XzD065osKpXg1sdQiEDWIYF
 hiEJt5ulb8O137lfhn5kAmli8rIqaDLFVcyqIrS4aK6dILeIpU6GW7sTMCNay9zSOrAwhF5B4ha
 25bLvZp3y55CjTxKs0w2r2NzLWwIr8k7jpMGDOnaqGCXCQTH8zzOOFyOn3/71IOwIWHQeVq2Cqm
 D3KEwRxtVHOCjsnZfPCZSqz4Ue+xyffDjkfFz9vcR8GTYo+LkG5AtIVCDemthUfStVdOcYIP7pL
 wop+9Xqk+24VWtwk9xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwMCBTYWx0ZWRfX3Q962qk2VXWO
 tteNuFmcRlsWF27WCGtqYdge80+HR8USpfDk2V+xrupTa3y/vrqGLHLJBylCkwFqAzKmnRwhr35
 PZGGDNI3VzaliArhnP+4qX8/r6VfsqE=
X-Proofpoint-ORIG-GUID: 4l6RLuLmMCxuiGdNZwWCEXTvyxV8ivEo
X-Proofpoint-GUID: 4l6RLuLmMCxuiGdNZwWCEXTvyxV8ivEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090200

On Fri, 4 Sep 2026 20:24:54 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > The EVTQ, PRIQ and combined IRQ handlers are threaded and issue commands of
> > > their own, e.g. a CMDQ_OP_PRI_RESP for a page request. Disabling the SMMU
> > > while one is in flight hands that command to a queue consuming nothing, so
> > > its poll waits out a full timeout.
> > > 
> > > Two paths disable the SMMU while those IRQs are still requested: a failing
> > > arm_smmu_device_reset() returns to a probe that disables the device itself,
> > > and arm_smmu_disable_action() covers an unbind or any later probe failure.
> > > Both can run after arm_smmu_setup_irqs() requested the IRQs.
> > > 
> > > Disable those IRQs first in both paths, so that no handler is left running
> > > once the SMMU goes down.  
> > 
> > Why this soluton rather than a flag to stop them queuing new work + a
> > synchronize_irq() to deal with threads in flight.
> > 
> > irq disables always worry me a little as they tend to be patching over
> > something nastier.  I think this works though so I'm not going to
> > strongly object.  
> 
> Well, I don't see a reason to add extra flags: each irq here only
> has one single source, so disable_irq() is fundamentally similar
> to a flag + synchronize_irq(), but also masks the irq line, which
> makes sense in the probe-revert and shutdown paths. Above all, it
> is cleaner.
> 
> If there is a solid reason for not using disable_irq() here, I'd
> not mind changing that though.

It is probably just my mental model that disable_irq() is normally
papering over devices that can't behave well and stop sending irqs
at the source end.  The main difference is whether there is any
potential of the unhandled irq logic kicking in.  I kind of dislike
relying on exactly how that works under the hood (needs a lot of
irqs to trigger) for any path that we expect to actually hit.

Anyhow, I don't feel that strongly about this one.

Jonathan


> 
> Thanks
> Nicolin

