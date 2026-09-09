Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3355279DB6
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976878; cv=none; b=WmERvy3UHB8MYuuvWFNeshcZwQbqRcLdhcxqFi877HX/fI/DThDbSTRpKd3DYI2Aw6vFZfbDDDHvK2uk0iCpTEj7J0slDRHlAexHoYo/MOnsUfraW96QtH1RVZb60fkuxUYk5dQyXaBW44MQJnbs7hwlacsiacMFlgPRTcZAArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976878; c=relaxed/simple;
	bh=MWAcc0S8T0AMmFdPD+A1IyzlpMsFTMKOibCCpP727Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmEQFERl5Opunk3fLUtZyTLCJTTR3Zo82s+U7VdNEWyLO2GXFikqYewUpqgFZi5X5CzTE5Yi2YFRBynJ++rUH6EqvnrrJIISYKSD8/SAKJ5eT/gNINt5vb56BZi67DkjY3XmL0CmocvbfNeO4xgse4XSltFjJfJy9DlK8BgVqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVXwzG0r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MtX0mciR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVXwzG0r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MtX0mciR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H7Z1i2600030
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 18:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BvCuCj+1hsq0hf2yMIZAP5CM6LznakfZh7U1V3Cg3gU=; b=kVXwzG0rArK5FzXu
	IsAToYikSvB46NCL+MJV9WEUbY+uXtNRkuT1IyYz45OB3NY0IzgjLBAiZhr4UmBw
	FiEwVh+Za3t+/7falVzFeotH5bAiNlJfTBKjOVC6pW3knTU8R9E9jEWefKIzx/SK
	8UYSDgwUx7gSi2RiE0D3n+ZmwqGnPvk8C2pCw0k9GbgCBHYiUz+AugH4ovuOup5t
	uHKzskCJjrIaMO/oERxlm4qPOCDnta23QmGkbl92DRkq2L4Q3rB3QQu2vkG9YSgN
	1cYZjxlJWL8Z5gNcB5kioAFg1JW2xFndXlUX5rw39v3PEQRAo25OItMhmNm19uQf
	/QJ3bQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r1fhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 18:01:16 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6b352d9062fso7671799eaf.3
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788976875; x=1789581675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BvCuCj+1hsq0hf2yMIZAP5CM6LznakfZh7U1V3Cg3gU=;
        b=MtX0mciRNMbmfW5R9jAigS88gJbIwRJsRHQzqShGgfljRSJ5vvOHaWeizvOuLtL15c
         F/xv2dkvLJajGCrDb3ZYiqhwg0+yQup8eGqJe/nHRNC2wU8joWabLWtPgWlFEV2RHihj
         1Zru/X/vs+LIMfUsKK3E0rBoS7jaAXB+5SNZYJzTNMdrhaqC0tNPY0wbfzw6gknD88hd
         IevsFiWyRY5Uk24FCAgn2levm1vogGdNlH1v6vk4pxFDoGAvYutKNP9gEgmHAHLcrl2+
         ecOGlnHVzUwNkPRw590bCXYV+o87Fnczfd79GXtvLMwyY0yvA74L2L/F/cbFlgJ4ttsr
         6eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788976875; x=1789581675;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BvCuCj+1hsq0hf2yMIZAP5CM6LznakfZh7U1V3Cg3gU=;
        b=spSUIJ2oZW+aDKImywfvWcdoaIzxbqz8eqz02RwIdJXb3qCGE0eEbTR/zlyAZAkyX5
         C4AhuGItX3O2Qlg5MbjIMG7iIBiZ4m0PJ61tQCVSQ1uXAojaCZoDMrdWzaQNUNk1oG9S
         yHV2x3nDxfr4o5pC5mi7Q2cx9l6Au/e/IXy0/+El8OOBvgWkMRS0kD8G6QXdGanh5uV4
         0gBdJsBgAYocFBLwIKgb2BMhBZThaY3u5cqbJ4+5N4NLkIuz7WnzIIAJzecRrR1qFY1J
         b/hbImemOtpwFd3YZIgGp8/F2anAWltsT5w8FpRMf4TTJwGl7VpJBH8js8dHI3q0tzqt
         bqAw==
X-Forwarded-Encrypted: i=1; AKwUvBxHBMYcbyRByJ6U++ev6bMo7jHfSkrQR6oi1waXHXjrUQ490dFaBthea/JhHzYP2bwaP1kmnxz+bG4=@vger.kernel.org
X-Gm-Message-State: AFuF++mvhT6XKYobpXRHy5sSj3/0H/TnrDaKMq6n0n90H+0SJWjfa933
	cz0YpzglomHMd5gLK6zPmMbvltrYpLnkG3g0qkONcf8SMQpZMYsfkEbwz+d37riIc5DSeWhVRQ4
	nCZ59hAHUkqqcl2FcD8+gmw1XkGfT0YY9Zedlnmz9gSqVebnqWx8/rweVAFXS88w=
X-Gm-Gg: AYBFou0goxvUvJ/K4xfoijQ5MXjf2EA7Jv2IVF7Bzc4AUtotXd7pTnFMjFtg/MPXSvB
	TVzxbObfePRdK8Jzx0pKW7qINx5WxTR1pqmC+ez7QuZ0UHHJXl0p5Yipo7Q/ZYApzE97Qg1XlTd
	7WMQ/136rBMBfxKi8IHpxi6mQ38flTZ7afvDyiJazXZ7xELus/KKjqPTiaqM7PUh7DzN/U3BM3X
	3kwWegiZ0eW48eQJmhtOAOlOh2moXAQzW3+jYsi7o9PfDjZEvsfSjHrJDrnxS+PqaQOM1QActjn
	lTKmBZuuqYs+vGNto5SuAZBetvdtXPGgh+T8e7Wbgm9/7ooYcqB0LHzfFOkXCsKKxu0u5liGszj
	tM2A+YSfcIPHzIZ00885Ei5RiRb4=
X-Received: by 2002:a05:6820:4df3:b0:6be:46f4:2908 with SMTP id 006d021491bc7-6be46f43c91mr2959534eaf.55.1788976874249;
        Wed, 09 Sep 2026 11:01:14 -0700 (PDT)
X-Received: by 2002:a05:6820:4df3:b0:6be:46f4:2908 with SMTP id 006d021491bc7-6be46f43c91mr2959494eaf.55.1788976873782;
        Wed, 09 Sep 2026 11:01:13 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm280583c88.1.2026.09.09.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:01:12 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:59:54 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bhelgaas@google.com, praan@google.com,
        kevin.tian@intel.com, kees@kernel.org, smostafa@google.com,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, skaestle@nvidia.com, mmarrid@nvidia.com,
        skolothumtho@nvidia.com, bbiber@nvidia.com, harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v3 08/13] iommu/arm-smmu-v3: Disable PRI when no IRQ
 handler is registered
Message-ID: <20260909105954.00002181@oss.qualcomm.com>
In-Reply-To: <20260904141525.GT4157646@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
	<0b5282c7e850f1a1c650e43670899b4ef5335efd.1788222486.git.nicolinc@nvidia.com>
	<178846311318.1308030.4956293524348641228.b4-review@b4>
	<20260904141525.GT4157646@nvidia.com>
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
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa19eec cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ikd4Dj_1AAAA:8 a=nKlBY_KgISjqlfJ5XcQA:9 a=CjuIK1q_8ugA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIwMCBTYWx0ZWRfX9Jh0Mxo0Jb5/
 a3bkVDovK5D+HeKfuqYmuXKCLiR9kPdjExR2OhYpZTUjvDiOcshXGfxenKJNtKRJIiqVLn75Lc8
 crkU+suJ50KkxAhC+ZkfCwixhLcUL9PxklJUVd62bIReGEnY1cZsFppf+w4BLU2GG5J07f25aAq
 DpqcQQAIWabhRH4kzqIuVkxXHX7017GurzHcpmE/z8sXYP5rJ8Bru4yZqydX/hC8dqQ+BfdCAqA
 Ek9E22GH8Ca9vM7bgHhkJ3JgaOngD0wyvPWKyPNemq71V7B2zK92N2sRN9E5PAwvERo1cWK886t
 yScwoPV5+clCTWXZ/7P3KbOc/7WU6f/cSb+S1LFpvgUSYW8HRRi6KAl0jZ6N/6Z0lb+Ek8hW+Uj
 CN8tu8yLAtPccwETZaMyaK5MxgAScedSJPwlMv0WB0hCBR0cmftEZ4H92DAVyYTdur1mQYBkI0f
 aFXYYhtPOa7ylagTIOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIwMCBTYWx0ZWRfX8qzD+rLTFuH5
 mzbBvAjEQe6mHngO0hHQX1ZfByLRJDLWdPmM/QZBU32lGe/9YNFY2nBV46qwAl4ReVBPsLLzO5+
 zqrfHVu+5rblAveuQcZysuk4fl3a73k=
X-Proofpoint-ORIG-GUID: ZM_jmWhAKjYzrbCIlK8m0QlU66Y9rQ3r
X-Proofpoint-GUID: ZM_jmWhAKjYzrbCIlK8m0QlU66Y9rQ3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090200

On Fri, 4 Sep 2026 11:15:25 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Sep 03, 2026 at 12:18:33PM -0700, Jonathan Cameron wrote:
> > > arm_smmu_setup_irqs() has three failure paths that leave the priq without
> > > a handler: a missing priq IRQ line, devm_request_threaded_irq() failure on
> > > the priq IRQ, and devm_request_threaded_irq() failure on the combined IRQ.
> > > Each path warned but kept ARM_SMMU_FEAT_PRI set in smmu->features.
> > > 
> > > With FEAT_PRI still set, arm_smmu_setup_irqs() enables IRQ_CTRL_PRIQ_IRQEN
> > > against a handler that does not exist, and a later change would then have
> > > arm_smmu_probe_device() call pci_enable_pri() on PCIe endpoints, allowing
> > > them to issue PRI Page Requests that pile up in the priq with no drainer.
> > > Separately, arm_smmu_device_reset() has already enabled CR0_PRIQEN before
> > > it invoked arm_smmu_setup_irqs(), so the hardware queue would stay enabled
> > > regardless of what setup_irqs decides.
> > > 
> > > Clear ARM_SMMU_FEAT_PRI in all three failure paths, so that subsequent code
> > > treats PRI as unavailable. And disable CR0_PRIQEN after the setup function
> > > returns.
> > > 
> > > A kdump kernel cannot service page requests: strip FEAT_PRI when detecting
> > > features, so downstream PRI setup is skipped.  
> > 
> > Dumb question - why can't a kdump kernel service page requests?
> > I'm nowhere near familiar enough with that stuff and I suspect I'm not
> > the only one who might be in that state and reading this series.
> > Configuration choice, or a fundamental thing?  
> 
> The initial issue is the streams are left in whatever state the crash
> kernel had them in, so it can be generating a bunch of PRIs with no
> place to put them.
> 
> Though eventually we may find a device where dropping them is not good
> and they need to be NAK'd promptly..
> 
> But I think the real motivation here is to save memory in the kdump
> kernel..

Got it, so design decision rather than fundamental.  Maybe tweak that text
to say 
"A kdump kernel doesn't service page request" ?
> 
> Jason
> 

