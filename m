Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDF3D3318
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860243; cv=none; b=k8vvAjmhaiOWzbQqgBqVaJXYlXoh50+lQnbMHgRzIGnvt7zidd9koGxisJpMGxlrgUmoTm0t+CYxw9XmUcBLqVnUm0GvIGwb8/P0/NC36SHIw08/2C/LjUJ7lA7MzlGQt2EpbGEVaCA9yEJ6b8sst/1ZOp6V6UTNdjztuYc/hMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860243; c=relaxed/simple;
	bh=MfKTJ5AFYysRrxk2JQ+v9vd1eySQzwAgo81gCkk4rXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiyT/e09ZD49GTPGy4KLix9h8yyJlVNw9+JBgT2SKrrcuDPMigKrB40U4ppXvORxqP++elwRvdcidRf/ZAVoP0yse+rHEgJfcvs/0ybtCXXKomltQPWxHnF/4Lmpi1CkAvRBhZFYL2ghee1jkpxn52g4kJFBkzyVGWBJp3R11PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tf/vTSHK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZuIWbCf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tf/vTSHK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZuIWbCf"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MBH12Y2209902
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 12:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AWkFrE7fA+FU3yHhtcDWCr9hztUpx1XqyOUuint3UdM=; b=Tf/vTSHKXBQRMrZ3
	u4P8SJS/FnAQL57fs5TcrEM1JyTWgO/Zu2W9JnxUA+VEWxpqLpBAb9XCevAPLU/g
	JvPMpxnlww5ZjEB1n4nHGwzx5UdtAgpkDH4The0qlfw5hGyiXHYEVdF7ipMpGZ3l
	gcp5uFLH5BSI9mvaPR5k31PgRUf8iC5BJQdZjM2ICvMMYdr2S72OCV1r66R8XdPN
	QwHMW4HtMpq3vPN9LojJjfBsJwSyjb8uhgFU4AU0cQrg72/PPsdDlRizo5RFXv+1
	s+7lB6/d4jZw6lwx4C2i+6by5EuzOzLiyV7e5InUfm+Hof8dEFkRzkB7Ome+LdWS
	CVs51Q==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpengb934-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 12:17:19 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56f6e373ba0so504218e0c.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776860239; x=1777465039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWkFrE7fA+FU3yHhtcDWCr9hztUpx1XqyOUuint3UdM=;
        b=DZuIWbCfhi1dA1epXH/l/DVEQh16chX72LV+BbI7OpiL99ps6EMTlWqypPuIX4OKPG
         CHGrP4QfSbAbkHyPRsAbBqnvxy4+ozLUowT2A72YmXwhqeCkYnfvP1b97DpR41nGWWiy
         vJy4//bSVL+gq6MaSaxMhebV0/fFFwgQVqWN8KuC33J1jqHbViy3WY1uEYSPobgh0Poo
         fmE7WCp2R/njry9Kwry8qsanNmfnhPKmrIIdzAd5BdpG/tVESr03OY6Zfe3NArsg3+ij
         xPf6PzCX7EgqxQ1rnHLWP2kCrkoiD5yhl06WGk2hspkh2GvKth9pJ+w5gM7qbj7VB6ST
         tyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860239; x=1777465039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AWkFrE7fA+FU3yHhtcDWCr9hztUpx1XqyOUuint3UdM=;
        b=bX4oFSqrcEog8+v2jMSEoZ1lr/tQQmiDw/rkUZf35+1fZYNlDL7l3LqPldRRt3ETUm
         rDz3G7UvI7vAMRJnBpv3KnbNV+zxc5qEr/C9xYTg5hsA9lDy7NEwzdLOYjJo3l1+Jc3e
         2bnC1bpBRahW367xjnXYr3EuznpqGbNBPRrvk+ZpqtoAVK9c/dAh6P0j8W1xSmQGcdrB
         yZ9+KIa7rOiH3kntpYxw+4CBzK2lNWOf6/MhKHrZJ78KFQS3U7Pj7UaHq1OmxlG6uf8H
         0pO6ZrUEftSf4E6YwPhCTwbS41RGzyTAumLNJwLtOatGdlFjP6/MiCc4axegLZBkyE7m
         g/ww==
X-Forwarded-Encrypted: i=1; AFNElJ+V+z/YZcbzHX4MZx0Zp789gHHCMRZKtR8KnZRn5pwwJYzCeqxgi407UAv76VRu5QpHOMgEBtiOhk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3v37WX/9uyADwCQBab7N0JK1+F4txGbe7qGWn2Lgc4IUq0Xq
	uB1gbeb5mc+zPbLfR6iySmsNMWSJv2EYLuLxtAQObNCNNITVYF4q368yx7QxL6k97k2Fe/LmE1G
	O93LlPHWxJXc70JMO3RAlKgw7rWDYUp508UMz9EZMtFxVYdVpxpMDoZd0NtNyGcc=
X-Gm-Gg: AeBDietlx/EMLVWdUV2hTakVlFVGWEsbKWupWKtgXRsGU24d1cbS2439aPf0cFB4Ago
	AM3sUgw3P1vrcyls0pyZvCbNclk8nOXDWS/Wktcfaf75r0l5PD4Y/tTMZdRZp/hpr4BwlkqpR9S
	ICem5xedS9BPbvRuxLUtTn6KVWC3Iol1GbRd9LtITVKkw7PCKtCdlAy1hhOz7vRktvmKTyEcb7j
	2jE1czsNlbRGXFmpe4bDnzTKOOEPycvveTCfEOVZPdgXnwClNhZnHTc4rfPSM0/l9zLLWDUSeoq
	1PInxy3yt5oDu5i1kGcP0ZMwcrAk21ycHPRGxXv5pio1mdCia2X6EAjQ+GUnDJLYrz8lzr/lWPB
	DapQgHh8FybPrlERmpDtQm2IenNDIs1NEmf+xIsiPP/U+d255k6WSLe7IDP0K2V9QPYGeK4KkwT
	wE4Sw6aDa8qh6v1g==
X-Received: by 2002:a05:6122:6001:b0:56d:a70d:7f06 with SMTP id 71dfb90a1353d-56fa55afa30mr3725081e0c.0.1776860239325;
        Wed, 22 Apr 2026 05:17:19 -0700 (PDT)
X-Received: by 2002:a05:6122:6001:b0:56d:a70d:7f06 with SMTP id 71dfb90a1353d-56fa55afa30mr3725053e0c.0.1776860238852;
        Wed, 22 Apr 2026 05:17:18 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c480e2d2sm3095513a12.12.2026.04.22.05.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 05:17:17 -0700 (PDT)
Message-ID: <fa725454-2de7-4e96-a828-ecc229a57371@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 14:17:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] power: sequencing: pcie-m2: Improve PCI device ID
 check
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-6-720d02545a64@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260422-pwrseq-m2-bt-v1-6-720d02545a64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExOCBTYWx0ZWRfXxvyePwxtfWHd
 /Tk2HkSacF61zO6ytuIoTS3eqyvmr3+mCyW0Klwj6M9LB0ZUbb6bxrdXxV3AyizwL9lRTu7P/iD
 w5U3wAeBMx8HSFFjUWs4RjBeq7weNZy3U+saOG2s1ahjEv1dhM+FNKtQHUPf4WRuXAD+lvF31x0
 1NfNyNGHgxim7P+qpM202sNS51kiTAjZSA7/+v5YgZrK1ST8leYf2usG+ns3amxqmsPGjnIHE2L
 6tlAi/8nJoH4wMdJUnb89MbsHv1Ak22EmLBy6+1xqzPfSeMFkDQT/Cgwozti+Lb4z9nUpdiLi4l
 3HDrGOmderXjyd43NrA4kkyTHLddnN3IK8HA6EuVQFLF4YGHtyaYGGfoY3fZBiyl/YuUtw+VxAf
 J3SDyyz13Gb+0n0GCo0dTs5asyUWo5LAT2LfFcKAPRzMpcQ/MyLuSq7aZj6VoPXggaAUNl5su8u
 zKnbmgF495YNqPvQANg==
X-Proofpoint-ORIG-GUID: EsikkjC44g8wbcgvZ7LSoWHqc5fHmLJY
X-Authority-Analysis: v=2.4 cv=RYygzVtv c=1 sm=1 tr=0 ts=69e8bc4f cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=q668qMPRPbE92s5sCn8A:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: EsikkjC44g8wbcgvZ7LSoWHqc5fHmLJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220118

On 4/22/26 1:24 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Instead of hardcoding the PCI device check, use pci_match_id() to check for
> the known IDs using the pwrseq_m2_pci_ids[] array.
> 
> This makes adding support for new devices easier.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
