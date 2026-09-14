Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521E4A0EE2
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420258; cv=none; b=TCYWe2s2RPSBvR86pry0Py4KH3kyxzmksidNzGpZm8XhG90Gj3TUOORBiyQ7ZFCT2IKuwaTIkMXz/gIPqWZMxjG8IdOjPZuBADu7Duuexj7FUjJVsQfKv6c0nukAO+N4W+e2GBLdbDW8c9RlqOvfhKyngfinhmMmM5BLx4Ha54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420258; c=relaxed/simple;
	bh=Wq4dzX7G0MYHQpVoOYjnieG6feoqecTnIZTO7wV2B34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMQQv2V8a2GDAEFp2wqu46+CracLuc0mMSHAzNfYPcmU4R8aAYv4AFVrgm9BTpwn9jToZDygOhj9c78kV2fhBhuj2zd2AEX7ou5ms4dRCm9AZW4p3JjkVVuyevhuL99Ct60D3O6O0jJUUaNGgDlmuht1G/YvkHAlTljhg/Td3NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jp5eldK1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ITYVEI6D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jp5eldK1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITYVEI6D"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EJYato1485428
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 21:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p6Z+iVYBfNSCWeowkj5JZHLt7Ogk7p4zAvjEwB8LuWA=; b=Jp5eldK1rwlCLxUp
	UueWoBWXJgmhAxxZJbDltJvMEbBuiTjtK+F/MeWcjuF4gubumkmh57uSxH+MX7tl
	vZz6R+KGE8WbZmx+q3oRl+rQj4GSWwpIeULX1PFCku1MK3ZPZN5d8irum5GMz1dy
	OoFPCwDT2JNDfaUy395rlFi6j3RpYpHyYRdrJdOgpy3JiuD2dmOCdBP9vk85cPzc
	RIqY0WvNdBK2xRW+2VAxM9ebWX2Z97SDc3x1/+prTV6v3JbpWM4j/7UF8NkcrRlr
	XLYHEMURqdiCPlZR5n5IKrFFaB5sNZGm1LFBo0El16giNTPDBmQowztDnvJkJsrI
	fWMccQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2ktbeu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 21:10:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4c1fc9ceaso3059690a12.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789420253; x=1790025053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p6Z+iVYBfNSCWeowkj5JZHLt7Ogk7p4zAvjEwB8LuWA=;
        b=ITYVEI6D7eMZYMukZDwQfKWMD6iIECYQj7e8CgNRmZj4711JIC64gM2IPHOt/r6+W3
         hsb/6NDdff+771jEKBWJq3YUIW7JiRg3R136UX9H8LcX89ZKpQFmYvrOCoUyvUaGYYTX
         i2D8lWx30YUeriBZYGsDOK7Yxs6jwIiQFHhoYXHR2kv3ivQpXwmwxSy3aHJyZgV0dZfF
         kgpawJkOAeKEvbiz6g/n0enaN2EhtpxbQ1bhL/i+yeQ0dxIFsiAqaMJFVga/rK4PX/fG
         ncoGb6ON3x26Uewt63TAppQodq9bt32zVFQnVHdrsh9iAHkK2P2UsWinLc8Y0OPq8KBy
         whwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420253; x=1790025053;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p6Z+iVYBfNSCWeowkj5JZHLt7Ogk7p4zAvjEwB8LuWA=;
        b=aLkZwpef5yLk0U9ZrT46w1eBGCd7286ZUQiezI3hPLosv08b9O9KwGUWlSWpIbL1Rc
         XNhvadGdLhk15xWJ1jk8NzhGqbEo6IPAoJPrYPyJT/coO4pEmhIspiIml5/ZwmSauQ7f
         1II/o5CIxyhzMCvm2xVGayWGkGsU1a6OvuLSQe4AcoU7AYVXC5oS/wExr5wYbKNih6Ps
         NxwAs+4qMYXu2TUJCQ6BCOgoE4zmQUUweWYSHj149gUCh1w1kTmyNTo6OrBUOUYXF72s
         8tyakgWyyECswzM3O7nZ6M32c0t5qJxnvhabF8SQdQzrXygSuvqyFB+9TMjRNRo2++DN
         v/Tw==
X-Forwarded-Encrypted: i=1; AKwUvBwkuAdfp88DS/eceE+6itF76IkFWhMC0gzE38FaRdbF0AVPnRSZ6lZjfP+Fey8zw1aNX+VNuuBDRQQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mYwK/cF3IJfbqMPUqbWRgGjQ5TPVELkzNc0i/hooAQoTCB/Cgy
	FcpkiVCwb4R7KZIZ1wYzOIDe0quA0/SebngnNX6/VCIiV38DNgCk3My1v/AHOUujdUmOlErR6ed
	WbZDQPypKVDzauuwBFoi9bIHDeMft/T/ma1muPi4gyA/ELS0XkOBftDTI/XvAhjE=
X-Gm-Gg: AYBFou0nXQB8bddP/3Fj9LHgjP59hseyiHdcCyoxLKSO0tHNKxEv8rGPTIren0LtJX+
	yeeQKDUxwxbo68pEAeb6BvVunvbSL4gxxmtvjYR4v8MKKuQ2wyu3nW7/43BX7aik2GvIZsg3PAb
	dK7Awlya4PL0MW59Al0U9Pz4O+nMvoBZsI9RpVk0zifCfhCVmsP+urPyGkyyYLrJThthktXCGGK
	pDaHN0RHQ4HzN6LzoUXwutbcVVJn4WYpUzacfVV9kkupLkwr/9PUBx3I9YYN5kzdinyszWpOC7A
	Gg7Qaxc2AArE/RWu6dbfvbie5u04ep4sP3nkDk6Xul7/lpF9WiJH5BV1S5J4jcRAMU6mVMs0jvl
	MaBGqAsMYVbYog/BoPgsIvehB52M=
X-Received: by 2002:a05:6a20:7344:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3db40480717mr8952840637.12.1789420252905;
        Mon, 14 Sep 2026 14:10:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:7344:b0:3bf:6d96:ac40 with SMTP id adf61e73a8af0-3db40480717mr8952794637.12.1789420252504;
        Mon, 14 Sep 2026 14:10:52 -0700 (PDT)
Received: from localhost ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b347e6sm25355458c88.4.2026.09.14.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:52 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:10:49 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <bhelgaas@google.com>, <praan@google.com>,
        <kevin.tian@intel.com>, <kees@kernel.org>, <smostafa@google.com>,
        <baolu.lu@linux.intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
        "Eric
 Auger" <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <skaestle@nvidia.com>, <mmarrid@nvidia.com>, <skolothumtho@nvidia.com>,
        <bbiber@nvidia.com>, <harsha.v@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/15] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Message-ID: <20260914141049.000077cf@oss.qualcomm.com>
In-Reply-To: <aqSLsg7AVgqusKob@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
	<cbe6e6f578af848f4efdd8d1050181032effae37.1789081084.git.nicolinc@nvidia.com>
	<178908564507.2841562.6430226716089872094.b4-review@b4>
	<aqSLsg7AVgqusKob@nvidia.com>
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
X-Proofpoint-ORIG-GUID: 5h2nz8b-NtC6cOIXylDWrEB0nBAHfh6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwMyBTYWx0ZWRfX9WgXozySfqUi
 w4crXJQldNzVAYQoHGzbt6KrWEmqp94B1VFobYg/J3BiIFogXzP8E6GSFu5iFoibGT2w5Xc9oEn
 5tC1a7QMhu6av7iahITGwG81k8/0YlC31KqwVH9pN5czr7iRJn2ddIZFciyXZbn4mlmkrw2rj+A
 WpmEHSKafzWEKOvUWMwbWUKG1WwRxz5tF1uZsZe6vIYn+3Dk/JIRiZEVTq3o5elz4NVXtnKxqR1
 WPPDTU57E5fmkUjx5NCvcelr3LcsoTJXVBLJESg9JAlmjz95ZKNMhDPeV7moMHkc8w9dDEckZgp
 StRGXjtC/kY5hPQD8R3IZ97cYZwGbHu67MuBb/1lxl7qmzhY0ZkvO0XXveNP+KXsTm0Zh4yODZK
 YpWkdANOl/TA5iP4xQ/ffmCSVWvIyCMuvcSXqh5xr+KDwM/KfiJxUZbroqlFGriFbbeO81w0rLT
 DbgBwQXVTfpdxjDqksA==
X-Proofpoint-GUID: 5h2nz8b-NtC6cOIXylDWrEB0nBAHfh6r
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa862dd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Ikd4Dj_1AAAA:8 a=HAQNk-a_8tHaYfDPudEA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwMyBTYWx0ZWRfX2d4oSX5zQO2j
 D+Fc6CVXJYraHSAGRNl6AJbBfil82RqQZct2PgDJQvQ+vjw0tju3ZhMrrvZb6qjVX0LMmlxVVW5
 jwr7sDbUIsyVdn+kMJL8pOlRt48oGiI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140303

On Fri, 11 Sep 2026 16:16:02 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Thu, Sep 10, 2026 at 05:14:05PM -0700, Jonathan Cameron wrote:
> > > @@ -2380,9 +2381,47 @@ static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
> > >  	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
> > >  	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
> > >  
> > > -	dev_info(smmu->dev, "unexpected PRI request received:\n");
> > > -	dev_info(smmu->dev,
> > > -		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
> > > +	/*
> > > +	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
> > > +	 * must be discarded before fault reporting: see the documentation
> > > +	 * at iommu_report_device_fault().
> > > +	 */
> > > +	if (last && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))  
> > 
> > There is a bit of spec language about case where there is no PASID
> > LWR=0xb100 not being a stop marker, SSV == 0 and should be treated as
> > a PRI request. I'm not sure what that means in practice but maybe
> > a comment on why that case doesn't matter. Feels like breadcrumbs we
> > might need in future.  
> 
> That's a sharp one! I didn't find any the practical action was
> suggested either.
> 
> I wonder if we should let it fall through instead of a return:
> 
> 	/*
> 	 * A PASID Stop Marker (LRW = 0b100) does not expect a response and
> 	 * must be discarded before fault reporting: see the documentation
> 	 * at iommu_report_device_fault().
> 	 *
> 	 * Gate it on SSV, as without a PASID that same encoding is a PRI Page
> 	 * Request and it does expect a response. So let it fall through and be
> 	 * answered with a PRI_RESP_FAIL, since iommu_sva_handle_mm() rejects a
> 	 * PASID-less fault, or by the PRI_RESP_DENY issued below.
> 	 */
> 	if (last && ssv && !(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)))
> 		return;
> 
> Thanks
> Nicolin
Works for me.

J

