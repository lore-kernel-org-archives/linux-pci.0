Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E142F709
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993932; cv=none; b=YItavnAnf3aJ7RE/lUTPCD4SC7C9zhMXPXPoyTfr5XqnkvV5hwCaG9BY30XFydr/vzEoVqYETKM8z29FsBsC8jd+dtkJ0NCKHPIonxKfHbeTcrcA+R/XomPVElezu4xu0nilOkCw95fBd5l64t6eQqqfcB1FK4NJaoY9HZhvdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993932; c=relaxed/simple;
	bh=ocVsv4oVD4EaEoTXMaXIXLhfptEhJpE5Y9sC0bllC3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5B5sNIvzstg38nxMYbwPvpuftxyOzgA6CO8AOjLiGfPAr+liiM5d1Rj25x6rlNK3uMfF5ae9L1hUrKYTNXnWNd2uUaD8lbqmi/SkoxYLB7ywO3p4MykcrS7e/IpX7PAgg7+7WlShK27oondMfneMcpTTkq0muRbcWaIA/G4RkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AeFHsdWm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SuSXMPOn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AeFHsdWm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SuSXMPOn"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB4s3q1130250
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 12:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A9EmN7Jpn4onA1CVJxcI4dYK
	dOmL7N0L1nlQPagxebs=; b=AeFHsdWmqBxM5iWrVNUCjj8QsJvYjk9SNeNDWr1y
	RHXoZqzJWguURxd03TKuxoHn2PILNCckqPU7UDP3HGH9y5/RgqrhOwY/+zzpxZix
	ZQ/qpzc9ZefAlvOhNQWKtYEGl5HdjlI/S/UF7IBSkBANNuy0AWf3s0sGDGA94EAH
	c5AKnJrgV976BQ2Qk7QtIZZmFq7r7hUMnAoI6Cu4nRYpwk6YqMSECDTRZsTgrXO/
	GgZTMu3bpUYN8S4C3sWiG+Ta+WtA+JxO4chpYGo+2VXbEqkVvmsMjt0OX5qZteNP
	xTePnoADBg+fkFxkQZ+uFYRo5OnWKZdiD/T9wDUS7vQzaA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csga8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 12:32:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so6797174a91.3
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789993929; x=1790598729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A9EmN7Jpn4onA1CVJxcI4dYKdOmL7N0L1nlQPagxebs=;
        b=SuSXMPOnkMRrFGpq9V9DORSPMc52fh499jIfhAjn6F+skD0XPNLZvHgQzNhR76egDG
         JLH/ESS7JJoybR112MbS8YBJ3idFPwstNHAdbqUEkyTIgsgysc/xL6aM4NNztE3BD0rY
         jYNOmAeqkDIxmslBapQuKztlOk1NEXVUMascP5jadglxdrqpykzT6g0s5BoDTbJoJF9b
         zCe86/rmMm+mpu3hPQVLU0ysFEpKqfpKB1AZE2t0ps80scTEu6n26DX+VsjeHlZ6dSDh
         9mjvhQOYm+mwa9NYmj4Sw/G5+607NOVGEbG2cSCEvJnyJEhdHjb1NeqB5XNiuEX9u0yE
         O39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993929; x=1790598729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A9EmN7Jpn4onA1CVJxcI4dYKdOmL7N0L1nlQPagxebs=;
        b=P684H/HIgYEpIJyaoaaNt3m4u3ulSDA368GBd2wuXZohWb+kl/lgPsfBhLQ2xSPRXA
         8T+0ieI+22vkYaXKQg1825DvQnBljILPTSwfFhJPgXeaMAyJGRH8WJieGnhRzc7gxAt1
         UPgAlxrz7NpbuR11Xpp7vffqZlItS+0NJJwWTKUtIiLMSU2Z8XKOfECn/fLlbNDIjGDA
         dEoG8CLqL0aKqj684+uKyZCqvXr4W6XOpiiIixqP7jkF8RDuLR6tLbmRDvKavvOeg7Xp
         kxQIn0ioxO29uEOxd25c9MZ9SyBozhVf3xW/r8aDehTSFZm3a22Hr+OozTfilyzjosVi
         AW6A==
X-Forwarded-Encrypted: i=1; AKwUvBwIzzImQ/hzi9t9mC1LWYm6QH9g5Zu+Jg4zwDHrGP0xcuFQEjdm7mKCGuaoD7tO74gzNKm5zGqBob4=@vger.kernel.org
X-Gm-Message-State: AFuF++lWJ4UM2T6vsMGVF4N0UdRXJMOBloipiRgQi0+Q0E9OJVOWjYnS
	HfEweJsQJFrjBqyBstSl2QI4P6CwVN//UO249KyqPSRaPgR9Yae8Y0pRNzj9l5z7vQkO1avig5v
	nBJZ9/rH7PO8Iy07umiFKCNbuHoe939xJM8zmwV/dkdOpB10q00kDSlzMs8M0QR8=
X-Gm-Gg: AYBFou0uk8n5W8KdcQ0gIiU3W8p2xZiiihiFuxiqxETRyAZV46jv02BbT/zS6JYI0Y1
	pv+NvnRalSKLHO2Nt5Htq9wIKk+yI7g93PtcSK98wcH+y55IVAe8dkZSNKGdmsEDMdBPoWTV3lp
	Fwd1x0Qw5UGX2KQuKkHflzEjEW9DYJ74hEezyFheq5PkUSgJ5mQG/Wp4BPMLcvdZLxOthX3sFjR
	dvHp3XHeF8l1CGNyLuevmN+BE2GtonSCGiAyyeW/+DwUzk8W7luKx4z5evJL9oOjAEYqJbV4Z5v
	5G5+K93opQBK4TkK+CjqA4xMW96zy6jIU9AQwVGv8Sm97yweILZlZD7lCx8RU0qjp4uOCGHWZNt
	7oqkduh/pFSIFcIFvEe/DdMMYQX6dBmGEi1g4IxCO3KKfRw==
X-Received: by 2002:a17:90b:37cb:b0:39e:6c69:9b9a with SMTP id 98e67ed59e1d1-39e6c69b2eamr10859758a91.63.1789993929574;
        Mon, 21 Sep 2026 05:32:09 -0700 (PDT)
X-Received: by 2002:a17:90b:37cb:b0:39e:6c69:9b9a with SMTP id 98e67ed59e1d1-39e6c69b2eamr10859725a91.63.1789993929074;
        Mon, 21 Sep 2026 05:32:09 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c342b3c67sm20440546eec.10.2026.09.21.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:32:08 -0700 (PDT)
Date: Mon, 21 Sep 2026 05:32:06 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Birk Skyum <birk.skyum@pm.me>
Cc: "mani@kernel.org" <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
Message-ID: <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com>
References: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MSBTYWx0ZWRfX37zZxQMxYL+a
 kwnsL1QtQo6j5rIQHz2QmbSZwoJ5XQaxUzCwFIT3fYjpDEpRwoSa7JiAfjUjHLI4pB2GapyK6Lf
 +3yFrOLOMnTsYmR6wrsJG9SKNzg1p08=
X-Proofpoint-GUID: vsSLZuRCPdvopyteQLzwAoKsHduE38jk
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab123ca cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=c0qIyCC_QqcG9ToN-sIA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MSBTYWx0ZWRfX/zfDvDuSkK/Y
 9/z/U61VNBgLKOvKTpYI3a76kkqW0qG7cIQ2QhGsFcP60Pvj9eN5kajNNtmWAQl/u7V9eR40PC2
 LJwtOeabcK3KJSLPTKwfDiHtvuJqyuali+YmvdEr4i8a62q+q2kh+ET94ECbiMIqbOXjvy0VTgP
 LYfuOVhsOee6bjLFrjoV8vyxfOL3aUBQSkvD31ro4lO4b8cMiAKxfXEhXMJIH1CB6vOtM01POrN
 cZvO8fVFf2khGqKpjnI90cWOZlH1GZZy4P+EFZYGUYbVdnUL764EIuzmwCJzFE+7VJQtgme87dz
 Zc/OoNwlgQKoJbCr4i2uv4WExhYM0xfCEZzv/tFaks5/7C+8+jmlqeb4JFdmiqgkfmpCorCDfT+
 B7a3LrMo/dRWRy9ZBM6dza/mJ6owVRWogGREHXaOyleg23hqApga5iHRBy18yxiFS3weKa0tDg5
 Z1IoQR8t4Sril4PpkWQ==
X-Proofpoint-ORIG-GUID: vsSLZuRCPdvopyteQLzwAoKsHduE38jk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210181

On Sat, Sep 19, 2026 at 08:33:20PM +0000, Birk Skyum wrote:
> Hi Mani,
> 
> I'm working on experimental USB4 support for the Lenovo Yoga Slim 7x
> (83ED, X1E80100), building on Jim Martin's published Glymur stack. This is
> an out-of-tree bring-up, not a regression report against mainline.
> 
> A directly connected LaCie Rugged SSD4 negotiates USB4, enumerates through
> a PCIe tunnel and completes a 4096-byte read into RAM. However, NVMe
> completions are recovered through timeout polling, with zero
> device-generated interrupts recorded.
> 
> MSI-X is enabled and unmasked, and the table matches Linux's programmed
> messages. Software ITS INT commands reach the NVMe handlers. In a
> separate test, redirecting one MSI-X vector to owned coherent RAM
> captured the expected endpoint payload, but that does not prove delivery
> to the ITS.
> 
> The endpoint RID is 0x0100. The captured firmware IORT and our DT agree
> on DeviceID 0x80100, with MSI address 0x17050040 and event data 0/1. The
> PCIe SMMU remains firmware-owned.
> 
> Source and test results are published here:
> https://github.com/birkskyum/yoga-slim7x-usb4
> 
> Is direct ITS delivery the intended route for USB4 PCI0 under EL1/Gunyah?
> Is additional controller forwarding or DeviceID setup required?
> 
> I also found the QCS8550 change using the internal DWC MSI receiver to
> avoid a Gunyah limitation:
> https://github.com/torvalds/linux/commit/33cae252054a694269f9dcd41b354063193c8f59
> 
> I realise that involves different hardware and symptoms. If an internal
> receiver is appropriate for X1 PCI0, where can I find its parent IRQ and
> required initialization?
>

Hi Birk,

Please add below dts change in pcie0 dts node and also remove msi-map if you added,

interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH>,
             <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
interrupt-names = "msi0",
                  "msi1",
                  "msi2",
                  "msi3",
                  "msi4",
                  "msi5",
                  "msi6",
                  "msi7",
                  "global";

#interrupt-cells = <1>;
interrupt-map-mask = <0 0 0 0x7>;
interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 703 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 2 &intc 0 0 GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 3 &intc 0 0 GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>,
                <0 0 0 4 &intc 0 0 GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH>;

- Qiang Yu
