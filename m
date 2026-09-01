Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7CD2C0F8C;
	Tue,  1 Sep 2026 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788235804; cv=none; b=eiDifMpqScvufAqa20kbDExNZjpqgpoA5iKJYYD/mKsu3YzZmLsHKog47YzBTv3ywRcXIE8Pe9pFnk2U4A1pwspyz/Q9jzLLidQB25W61gg5XHkSp+d8KlxcQqA/tYDbtLv+tQ9s1J3KISOmeUKHtclVCzmuy61Jd22BLa5wd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788235804; c=relaxed/simple;
	bh=oHExMArJB/aHRRB6iviCNUALLap6xPBCO4K64DUr7SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/Im142uzyFwiQPpoWIGyQ3+n7eQKM2HJASg9WJxLjU9CASWjLbgXQvqGlavChNZcMyK3ZwwAMfoX1VvRxn58FEBdcTMcZCzu/7I1lnb97CGMkodIvp/baMDOvq5CLlf31Fysp8TVwRR1gaBU4lhmiNqWzHQMG1XceBjinWz+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HHLN08ua; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HHLN08ua"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68111dcR2808359;
	Tue, 1 Sep 2026 04:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=b+QoMd2LM7bd3IRUmht+q
	nalOUqnOhQ9+3KGiQOKNCQ=; b=HHLN08uasAOT9h86KfSuw9sZB8ny/Qg9Keals
	5t09iDQCxSZQ/cqle6zUvBIA1jlMMfnmurKt2dA2hiU7NtsVrRd+KsWLKIy6vDzH
	X5Y2KrQYoeVdUiHkZSnyHUDTFSGcAF9pxM1bhHX08wh8snV7UocuDNh/ZiOvJ+3K
	K9z83ErQH40b6H1+VB4ZJCVg3AkcM2ojvdAhjLtqDIfs8FCxuKFgD32xY2CyVYZS
	Fb85mFNYMJjAipiALW2XJpjBcT81BYC5oGyNInhRz3qXr21ZhqmfQkOBQkjLkY9j
	vb/jj+hbTjw2/Rp+exnIeaAUexPw/hOkW3SlUfAO4q61ukohg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudngjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 04:09:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6813uNeT028895;
	Tue, 1 Sep 2026 04:09:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccey1ha8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 04:09:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68149gvq45351178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 04:09:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00C4620043;
	Tue,  1 Sep 2026 04:09:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 751DA20040;
	Tue,  1 Sep 2026 04:09:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.123.6.78])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Sep 2026 04:09:39 +0000 (GMT)
Date: Tue, 1 Sep 2026 09:39:36 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Avinash Roy <avinash@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, bhelgaas@google.com,
        npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avinash Roy <avinash.roy1@linux.ibm.com>
Subject: Re: [PATCH v2] PCI: quirks: Add warm reset quirk for IBM Spyre
 accelerator
Message-ID: <apZOqDGq16sTPZYP@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260821123401.1375297-1-avinash@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821123401.1375297-1-avinash@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: YzWiVq3InLbhscNU3rylpUjsgQOeQPUU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAyOCBTYWx0ZWRfX1jNZ5AsARJD+
 pn0dJBUqncqgcqO5EiWPtdAJJFVi7yBwMOIMxZB2k9tz4jAlAP4o9ZeYTFnypcba2h840Ys6ipz
 nWp8XS1YFCn9VKTtk+KpvpP5Otc3I/fHblsd1W4H24AP2ET77t0AbEM2tuzEkOemKgMrSzSOSpn
 jQ1Oo6rQRBZsIYm2mXDsXBJ8JwUdnL32dEuWeDtyYrWIOEGLjbfoPMmEnZg8sZt8WGT51RBRsdm
 qWTdBaaFloIuMsF580xnk3f4QUcTwhb43x0XUPWfwFi5TqoKdkGe8XdGapDEaobJOKhwTbeM/69
 TL5n+Nxd1Dkk3X5SjPrnKBc4Y0uUgSglwGik18HEoL3j7r8UOEZITeUTwz11sZYoMjCcpNoIA0g
 Dt1MXrX/nj3/LM7dpsnHFdG6uA3OSgB2IdL5ZFnlNnZ6rAP4XtXuFd7VnNDmlz345DW26TagKDa
 vIrtXWlSHVJEaTnps9w==
X-Proofpoint-ORIG-GUID: OeKiYojqnv-J0a_9aIFXssVMB1267445
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAyOCBTYWx0ZWRfX1adZOgvL/aV/
 y8azwQA/qm9yYypC2sT3L1C5gQS5goHZaDZTPZ0Z1wqXiAgxMHj71/Pd2CKpnCqBKLTvMgzM8tn
 pcjpPnmk9fTk5Mz9xbyZ79SXe7Vouw4=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a96500c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=oQsFNTG6mdKaDiMbqvMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010028

On 2026-08-21 18:04:01 Fri, Avinash Roy wrote:
> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> The IBM Spyre accelerator (PCI ID 1014:06a7) requires a dedicated warm
> reset method for reliable EEH recovery on pSeries/ppc64 platforms.
> 
> FLR alone is insufficient because it does not re-initialize firmware
> state machine for the current version of the card. The existing API
> pci_set_pcie_reset_state() is used to drive the platform-level
> PERST# using the EEH interfaces by adding a device specific quirk.
> 
> The reset function is placed in arch/powerpc/platforms/pseries/pci.c
> where the EEH infrastructure is already present, declared in
> pseries.h, and registered in the generic pci_dev_reset_methods[] table
> in drivers/pci/quirks.c under a CONFIG_PPC_PSERIES guard.
> 
> This reset method is only registered when CONFIG_PPC_PSERIES is enabled,
> so it is not available on other platforms.
> 
> Reset sequence:
>   - Assert PERST# via pcie_warm_reset, hold 250 ms
>   - Deassert PERST# via pcie_deassert_reset
>   - Wait 250 ms for PCIe link retrain 	
> 
> Signed-off-by: Avinash Roy <avinash.roy1@linux.ibm.com>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> 
> ---
> Changelog
> v1: https://lore.kernel.org/linux-pci/20260805125100.1-1-avinash.roy1@linux.ibm.com/
> 
>    Reworded the commit message to highlight the warm reset requirement being
>    a need of the current card and not a platform deficiency.
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 84e4ffe957a8..7aa58d57208f 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/string.h>
> +#include <linux/delay.h>
>  
>  #include <asm/eeh.h>
>  #include <asm/pci-bridge.h>
> @@ -236,6 +237,41 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
>  			 fixup_winbond_82c105);
>  
> +/*
> + * Reset Spyre adapter using pci_set_pcie_reset_state()
> + * This is specifically for PPC platforms where EEH (Enhanced Error Handling)
> + * requires this reset method for proper device recovery.
> + */
> +int reset_spyre(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (probe)
> +		return 0;
> +
> +	/* Assert warm reset */
> +	ret = pci_set_pcie_reset_state(dev, pcie_warm_reset);
> +	if (ret) {
> +		pci_err(dev, "Failed to assert reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for reset to take effect */
> +	msleep(250);

How did you arriver on this number ? Is this time defined by
hardware/firmware specs for reset ?  Also, Can you #define the value 250
and use macro instead of constant numbmer.

> +
> +	/* Deassert reset */
> +	ret = pci_set_pcie_reset_state(dev, pcie_deassert_reset);
> +	if (ret) {
> +		pci_err(dev, "Failed to deassert reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Wait for device to recover */
> +	msleep(250);

same here.

> +
> +	return 0;
> +}
> +

Thanks,
-Mahesh.

