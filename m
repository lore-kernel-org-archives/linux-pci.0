Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997541322A
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545806; cv=none; b=TX2G+6cDIogb7sLLtj+LCLsYEIdCOb+jCSgUNzbHICv3DJRHIwJ6UF7HjSjveCpzqvpVSkahg9IyXBuAD2u7O1xf36aFjgntABPfGANC1l/VhH1RxHNyZEljTooWXxveTrSNjNeXEehsHyncUo2xqWY7sMfJ9dqrssXuZY6zDvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545806; c=relaxed/simple;
	bh=HlXkVwcW7Vuxcok8mMHEUGl+Z0epLaQKPHN5G6D8mt4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V2ELeelIZ1dsm6v5afns/1eW9SD3e27MqNqVAeVByj2aNjLuu4SOdjy4wPs84b/+fiCxEE/alX4A18DZe+DuwViEAL5k1Hb1B5ADgyWbx30NBfcLizdA4gk3D4v7GKZ5F0gZ82dIrMcVuKgKD49a1ahbs09UTAcfXV0E4rlLVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YAximLms; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vsev/Y30; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YAximLms";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vsev/Y30"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9ksJ4002947
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYlwYGtF1x6CphxKpvzSBY/+OIr5DoyjXeHy55fCZTA=; b=YAximLmsVIdaVrxZ
	6znZsF1bs90QT393XTmNRk3wDeh/5g4X4mu9o7JMBMsXmnpd3cBUvEgPAPLToOjo
	iIqgJLRpn/LmczNdPamfSAa+vw2F7OKzbKHpjWW0tdl+K5dTtKU+CdHT2KW/0AGI
	H1/YpEs9S/eNUeJSkUJHzKl90cYCnIQsX66ewxiiCo9JfYgZyr+wODJzyQo8pk0c
	Z9c6hlMwc+8JgSCUS99eNJ0HJDg0cv2MmPFNRLQEavoGY/o10S5HJ4ZfqaJgjoRd
	KxQ5iHvK88nXPnseiCi9YteI1T86iJvXgMR8hw3sXvJM3aH/nYeuiVfKkUG6pL/X
	3OXFOg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4tkn386c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:23:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3595485abbbso1791578a91.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774545802; x=1775150602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYlwYGtF1x6CphxKpvzSBY/+OIr5DoyjXeHy55fCZTA=;
        b=Vsev/Y30Fu6HnTcquj+BNxUSWUzI2+dGU8yupuCOV6E3P6euV9neB+FVLIfJOj217A
         lDJa5G4wJwekgERICp16hVuS1+C6voyhQmXp1BC0kHgKd2651I2L0iS3ZGMIKB/EJHxj
         DBHJc2FdmNa1ww/1jYxp+xz2+q3A5YbAKYWBIjVEqSXtZiaeKKCAEaYOsl8IVr5bQA+g
         MWCnCcsaXfmPL4rB9OPlVhRXVAaJkN8Y2I7OdsnJa7WlIrf2qf1pHKLOkwVHwvVgAmzU
         78AJI9ziXQMm0mMN/7Db3jdBoFfB7bQt5UPIgCZzkNWAHeloIrblOlceoi+0WXEb2LPm
         3BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545802; x=1775150602;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bYlwYGtF1x6CphxKpvzSBY/+OIr5DoyjXeHy55fCZTA=;
        b=URTPC27+4OUimWRBBC/Ky5bPvPbHG10zWDlFiWyOBS6EB7wjMfimAwtyudNHo4dimI
         mODGvwMIWNGSSWoYVp+Hhwz8/7f+L4/fWUcKI3EGRKrZKPnpTBoir8AXrvWoCOP+JDZP
         tZFZ7P2PoLs1d8AcMJhPT5wp0XpYMH34V/VOHKHnVb3Gv5vedzP4N9L+BzDFmTnF+GX7
         EE7duYtu2lhDSzyxufFA79EmXzgBOHLyhSH+NOpnbNcl7DeySHptH7Ud0ns/cMGJiU1n
         drci1ExcmyqLfjzEY/VJMKQD2eQL7DqZpZB8YfKNZlf1zb8n9+WRLeJ2NMHhOkMWBSW+
         1N3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6NAOur9QAF7eWR9WCUUeqgFd7VeCclZ3uF/pdOExIcCzRVIZLTIWQjIeYhcDSHKqJeJbDPTiR/Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJvEkeioH+MEjs3cL+mBUyFVl4oPA4lVPLz0J9hEsOQyhwkgW
	F9HLP793n7SvJ7J7caMMXo+TL7GQv/rJL3dNxMZ1UecOylYfcuFsNEfngzHoTxb/pdEHuPU9Vzg
	CFS66xLaw4eDCnJyl3xmznJ2NFfvof1qi8u4HtXyV/9OYwBDjdcyn3hrd0o2tOZ4=
X-Gm-Gg: ATEYQzyEVGh47BXZvv8v61mS51WoTTC8K54rbbKg/qBID+cEWzXG19asNWXTmzDANX3
	TeMkWvIxuroVSRARjEo8kTliF5b11QaypkVEPAbC+NpvBPTpEiUkVY+myruT2cCT3RJVpsTx8u5
	FGS17Y1UU/1GS+Di8rDjId0zHcnxu51juVgRGQNI7k2Oa/qXqNaiPYaNJr9VMmsOK5x+qmnyE4F
	9F3MpQtwQ5saOOgr3hKARaml2X+sOKougxjBMXA06Y6W9E2kArbqD+qY4W7StPxyrbM25ucV36I
	0OuDAS8OXhoRKFK1WIcUsKKsY5vpJby2SYrCoubNRqsEiyHsZtpJZEtKmjaCQ3VCiMMT+LMUtz1
	8TnAPb3fyzgZcsZ0S86Hd1ps=
X-Received: by 2002:a17:90b:2e46:b0:35b:a7be:ae62 with SMTP id 98e67ed59e1d1-35c0dde3e2amr7489259a91.30.1774545801814;
        Thu, 26 Mar 2026 10:23:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2e46:b0:35b:a7be:ae62 with SMTP id 98e67ed59e1d1-35c0dde3e2amr7489224a91.30.1774545801297;
        Thu, 26 Mar 2026 10:23:21 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22db19e8sm2166183a91.15.2026.03.26.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:23:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, jingoohan1@gmail.com, kwilczynski@kernel.org,
        bhelgaas@google.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng Xin <chengqin195275@126.com>
In-Reply-To: <20260307020152.1224518-1-18255117159@163.com>
References: <20260307020152.1224518-1-18255117159@163.com>
Subject: Re: [PATCH v3] PCI: dwc: Add PCIe event counters for groups 5 to 7
 in DWC debugfs
Message-Id: <177454579759.462929.17703474488699644276.b4-ty@b4>
Date: Thu, 26 Mar 2026 22:53:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNCBTYWx0ZWRfX7puz2n/aVCb/
 oUt4vF3O8IX9BBR8r3iQkVs8Fc2MDh+x0Gzk7OvQXH3t5SLgYAl/Xj4gb7z7v7NwrSinDbRnTu3
 CumRS90Ax6l/L2RXrkxPg0j7LdSc2PczNp6620tsoLUlDaVfvQ2wFPMCNb5AYN0z2nmfkVoYSJ3
 l5uy5bTRPxaTmOVC58u7AKq3Gc7mAu/tzTeuGOecHna57L7ZCVS8ddIbTcPzcsBnx8/794zct2o
 hNFfhApsSdWxbF7gUhJhamW0O7PMHpGQC2abduIvS0gBhSeiUKteJ4uLh4RpNml+9I/oBVidFUI
 TOXnXhcjJHTOa4JPvZAkua0NpvOH7Bj4HkR7taXAqG82aZmOAq4gooe0RomB5QFZ1pplXN66P6G
 psVYMLGu/yIgqrtAdnHuZAJ+02f9+tY5mvmxnB2CZuEc0rajtl4DmgT7G3iVc4sRLpp2+7l7IoC
 6A8B6hS+BxGwhJmsyDg==
X-Authority-Analysis: v=2.4 cv=It8Tsb/g c=1 sm=1 tr=0 ts=69c56b8a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=DlfnnlzGyPeLzigLBUoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: fMWt95b8YHz6ZkoBFCdK2or5InnwEV6b
X-Proofpoint-ORIG-GUID: fMWt95b8YHz6ZkoBFCdK2or5InnwEV6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260124


On Sat, 07 Mar 2026 10:01:52 +0800, Hans Zhang wrote:
> Extend the DesignWare PCIe controller's debugfs statistical counter
> interface with event definitions from groups 5 through 7 as documented
> in the DWC PCIe Databook (version 6.30a, section 3.8.2.3, Tables 3-59,
> 3-60, 3-61). These counters provide visibility into Layer1 non-error
> events (link state transitions,ASPM, L1 substates), Layer2 DLLP
> exchanges, and Layer3 TLP transactions.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Add PCIe event counters for groups 5 to 7 in DWC debugfs
      commit: 698dab284b9d1c8aace73af8aaf0cfb74fc8ce92

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

