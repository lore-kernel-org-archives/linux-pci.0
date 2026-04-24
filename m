Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303C351C0B
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777011937; cv=none; b=WoluEwEH5hPYpeAVzh4qQY7MMrReIMGc2m2J1VmrO9e1F1O4tr0I1VMp+kTV3lVe3ftR6IGaGGL5J4CnZW/hrDODslT+DtxNp54DIkAqJId+9ebh3BUNAuYFG21RU6XSjmEVf1/RPsoTeWR7+H/8DA6AN/AYH/ZGoIXaUcryo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777011937; c=relaxed/simple;
	bh=OZAmZrRVMLMsOP3ym3ocwwjAr1z1NW//90f4SY0G6oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+2t8CuurgCOUFJwPt8Dr3mw2VYdhSdVycaBJv4xdstMmIR8SlFmlF2MDchEd7maLxHAc0SJAe6CzSqp157M65TZLnku1WtNVQeOuEDVOwpHQpzpDfpBe/gQnIKZNXbPItqvKtwlviWbCbyB/u6fMzB0ZqxKH+fMcyCYYaa9Tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aChjovkQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LJsQJyla; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aChjovkQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJsQJyla"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NNA8HR1888631
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 06:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QE/7SGmm8dVdWu6dNQHkGBrlw+CGR7AbZZlvWxhh7T8=; b=aChjovkQQogDHf47
	1fwCIwT0LsF1a+xtQ/Cl6rUwXZc/AewDlLHLl+eLfsm3bmCTBccGyVg3Y59+M6yL
	jrq+txxaGo8TmbUicjZyZJNX5okUOiYs0aQv9lwQ8aGRwEkN13QN0iKqLCXwoKKF
	67bit+9IlTQmzo5Ui1348siuquoZileWn/CJMDZELquqkE/mIvY9HkNaO9A4wGZD
	7XiFIhTf9v04/TilYl5gwdKGrar6pQ8MtIArDtfWPlndtAbsd8vC6q700j7eZm/E
	Cw+ZKxDFn5zfsTmHdaJhntAIY7nYsNIN63pfP263oA1lc5xeXfcRt+1HlZwPNNiL
	R6Fe9g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqp9du21b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 06:25:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d86f11b9ceso795575eec.2
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777011934; x=1777616734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QE/7SGmm8dVdWu6dNQHkGBrlw+CGR7AbZZlvWxhh7T8=;
        b=LJsQJyla/AGl86VOYl79M5MJXjs+A9lmZNPCyQ1O+ZiB7sRoab52YJUPqQiCTC5Mhk
         m7FilErjGHVKf7pp+MbKuS7tFt2kHfeYRqIrniBfZLuMeSULs3D5BWImFVsxk6+6NjZt
         UCR6qHMD/Ki5j1quLgHVcos6+PYT/S1KZqylN+91jo4NE8ZGJx26geOKgn4BuleulXs8
         SjW8Vj0EPDnyz2jVhRpiWoHa86f3l6KrBU1iLAmPCP4TOJ5BP6tM3Q74XlvgWyMYxTJt
         ySjJTZ69nZesyNMVOJaj+UI63RECQcdqELTwVLv9A0HP4Df9dmvRTjA9HFJip2r7C0EZ
         MRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777011934; x=1777616734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QE/7SGmm8dVdWu6dNQHkGBrlw+CGR7AbZZlvWxhh7T8=;
        b=ZQ+mtIERW3DDtEC/pWxZ2phKD7IAbC8kpHY0rzPMChFzpgienTcExar9ffQqIqEV8D
         Q3sGq2ZmdxXfD8LjQ/gRqMVUDzMarNPC1+XBHccjBxm4XLhhG5hZWHr8QkxyCkqTUKe9
         JWBb+bL5GpfPduQgv4HEx5iblFCB2tjrRonMYbvr6OLt8Pun4JNDaOLgMBuV+UWPX+FJ
         eZIUFyi9xs6IiAfy+zLLGjhMkcFCs/BaWeZWUp5G56DS5h2drm6qBcCBqqoN3AwI8VBT
         sbTyRsWrW9i639tfI1LB6HdtYJ00dEzO8KI2qqpvdGznjxyct/5t2gtFICltw+SLNAe6
         n8Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9fUYXKcyYbrl96hE891VFhum37Bs4xvs78IVZjIXHZ/uNo+c2OJLRNqyrP8216Om4mV8EwHT9XLtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIt9IKv6AaAEqQ4pyTNcET8IOWXnBSV/keU15k3X4j8d/4tQ/o
	Rupknpo2Sr6WoMdyExgMdplxgG8vaJ6QFCe7otVp2MjB/Tj00tDO+ldNfDZW+YpQZkxxOiyWlu4
	C+mow1EGT0NtmHE2IJGSv4lAbcfX+RWWF6z3nSE0ePaABJ2yX0xDZZB8g4P8nUbc=
X-Gm-Gg: AeBDiesdA2tKTpbBF8aNox7rUwk9r2dGq5LARgvgdkvSs3IKWVGBIsck1sQ3tnmBW3N
	ows9gAfw5lMNUo9BfJd/WtrimtLfz+7Khf2l/JazNpeWUeEo/nZezfGWUjtouO1bvwkjOW2ZAoG
	43AB40XfLCgViBcRgQVSnyiBaUuw7XtVimnBS2DBDt7VIsbxRowlO+sGHRhD2PtNJiItJdS5p/g
	wIPw+HQkwEbWH7XZEgbnygVbTDZDdbACcQgO+p/ZKTqbdrpCEeMf/GOT64Ji8nMn6wJkk14Q64M
	XE3Z43j7cJO4tCcwAJgi/iq9J1UDoWAhhh++k5QynIIJeIVRNjYS4w6GhpM/nBafg6VeXtODD8x
	HrNWwMas13YcKC6T1uGLun4av3ZHYPPDUVWyidS6sxu9akEQ1mnHdGA==
X-Received: by 2002:a05:7301:4185:b0:2c4:ec89:bdb with SMTP id 5a478bee46e88-2e464eaab00mr6832432eec.2.1777011934022;
        Thu, 23 Apr 2026 23:25:34 -0700 (PDT)
X-Received: by 2002:a05:7301:4185:b0:2c4:ec89:bdb with SMTP id 5a478bee46e88-2e464eaab00mr6832422eec.2.1777011933405;
        Thu, 23 Apr 2026 23:25:33 -0700 (PDT)
Received: from [10.239.97.27] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm30814307eec.28.2026.04.23.23.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 23:25:33 -0700 (PDT)
Message-ID: <f782bd4e-817d-44b8-9c04-6f05c00fc36e@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 14:25:27 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Fixes/improvements for the PCI M.2 power sequencing
 driver
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable+noautosel@kernel.org
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
Content-Language: en-US
From: Wei Deng <wei.deng@oss.qualcomm.com>
In-Reply-To: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k_Bwp97xKVTw1RZJGSGrhw3h75nNG3hF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA1NyBTYWx0ZWRfXwhVYxSezSidQ
 eqAIMRRNFLqmlbrwknU2X6h4zkNBP3hd9zxQBi2jG+uE4Mj5EwljKdJPe9o9bl5yh86xSTNersh
 Dwbn1Cj1ZgBInK08qa03PfFKhLTjskJfwk9N7rjDDiFFHWHtladsKem+E5TYhO+jWw6k8TMeFt8
 wIYKAwZGRnENb+i2jka8j2uSf0xQfTB4XweXdYDAWjsYooJqYEN2aX4NWLjMfQ6AKuK6CkkivYr
 w0Ptwr5xk+dWGJ9Ib4aNPVMNb8z23LBlitntSOlW7NZZ0feNhOjvSNlJDhoMPTsWBXBhPBhxOtU
 yr7JN0vQDucfbIpjxO5p9iRqKr3u27SOncWgQKWrKXhgEsfore4BQQ0s0h+O+vFk6QSd9QK/GLB
 C4q+1BbbdDH1X0Gqh3Z6vxLdcDUQNmCVqUk9R8LMoalnqmyigy/Nlsh7UKacI7U5QP3wgcPCpQv
 82PO3H7CKqVKada1exg==
X-Authority-Analysis: v=2.4 cv=fP4JG5ae c=1 sm=1 tr=0 ts=69eb0cdf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=qRrKk6tSi6DhAyMAVQEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: k_Bwp97xKVTw1RZJGSGrhw3h75nNG3hF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240057

Hi Mani,

Tested with WCN685x on both M.2 card (pwrseq-pcie-m2) and direct attach
(pwrseq-qcom-wcn). BT works correctly in both cases.

Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>

On 4/22/2026 7:24 PM, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series has several key improvements and fixes to the M.2 power sequencing
> driver and also the BT HCI_QCA driver. Notably, this series allows the M.2 power
> sequencing driver to work with more M.2 cards, not just WCN7850. It also allows
> the BT HCI_QCA driver to detect whether it can control BT_EN (or W_DISABLE2#)
> signal on the connector and set the HCI_QUIRK_NON_PERSISTENT_SETUP quirk.
> 
> Testing
> =======
> 
> This series was tested on Lenovo Thinkpad T14s together with the below DTS
> patches:
> https://github.com/Mani-Sadhasivam/linux/commit/29534d15307551b2355eb254601dec511169f0aa
> https://github.com/Mani-Sadhasivam/linux/commit/f4eaacfe647674be200847092b43cdef2194fc55
> 
> Merge Strategy
> ==============
> 
> Since the BT HCI_QCA changes depend on the pwrseq changes, it would be good to
> merge the whole series through pwrseq tree or through an immutable branch.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (12):
>       power: sequencing: Introduce an API to check whether the pwrseq is fixed or controllable
>       power: sequencing: pcie-m2: Add support for 'is_fixed()' callback to 'uart' target
>       power: sequencing: qcom-wcn: Add support for 'is_fixed()' callback to 'bluetooth' target
>       power: sequencing: pcie-m2: Fix inconsistent function prefixes
>       power: sequencing: pcie-m2: Allow creating serdev for multiple PCI devices
>       power: sequencing: pcie-m2: Improve PCI device ID check
>       power: sequencing: pcie-m2: Create serdev for PCI devices present before probe
>       power: sequencing: pcie-m2: Create BT node based on the pci_device_id[] table
>       Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
>       Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'
>       Bluetooth: hci_qca: Check whether the M.2 UART interface is fixed or not
>       Bluetooth: hci_qca: Fix the broken BT_EN GPIO detection for Qcom WCN devices
> 
>  drivers/bluetooth/hci_qca.c                |  40 +++--
>  drivers/power/sequencing/core.c            |  33 ++++
>  drivers/power/sequencing/pwrseq-pcie-m2.c  | 242 ++++++++++++++++++++++-------
>  drivers/power/sequencing/pwrseq-qcom-wcn.c |   9 ++
>  include/linux/pwrseq/consumer.h            |   6 +
>  include/linux/pwrseq/provider.h            |   2 +
>  6 files changed, 262 insertions(+), 70 deletions(-)
> ---
> base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
> change-id: 20260422-pwrseq-m2-bt-abdaa71094eb
> 
> Best regards,
> --  
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

-- 
Best Regards,
Wei Deng

