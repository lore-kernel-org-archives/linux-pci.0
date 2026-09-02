Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8733358363
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 05:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788326546; cv=none; b=CYtU3vENrv4uPlg5lPWbLFIP1YwGjkNyKQ/lzQbxXo1P7xipf1ZH/6K6Vmgm7oojUKudwwffUPrmC4ux4jfWeFqpkDyiN2B83HQz49uZ2l6L5Fyg4vkOlDbgXDJ5cXRDH7sr+BBre1oPIrdJzSVyem4Cp05bnWdEGDS4yhjZ1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788326546; c=relaxed/simple;
	bh=RX1tqIKGVP0bUorI/5rlQmkq+iT8Q7dOX+hFIanw6B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fA8Y9sLON+fzsin2kDId68tMSyaKs7lGCPqmYWHvpbq/bO84gRp8P/kgwp/psd7hOsIJW9E0H8l0dBWzehcQvPZ9wmJJC5x7yyVndRobJNrMLOriH0jc3St/6gBY80dAJaJNm0u2vQYcDgOPaY5VrqnCXRkC4QfnQAHxsBCEy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m7PaReY9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bqZLLBT3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7PaReY9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bqZLLBT3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6824cSUT3485789
	for <linux-pci@vger.kernel.org>; Wed, 2 Sep 2026 05:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RX1tqIKGVP0bUorI/5rlQmkq+iT8Q7dOX+hFIanw6B4=; b=m7PaReY9pZUxLkDN
	dqh44VsclV1XXF4zYuQ1SDCcxyEF1yYKhrLWFgdXUCgKFj9NP+ITQvGs+aQNz0zz
	Yc26OZM1m8LIQPY2lKNMoPrLGCWaEdM/nR5WuxXAJymwnXaZQGE/5tOq6Z2w/BUm
	k2Sg/UK1POZD4ZOhzUNqjlJsNRFKYP/ZK0naZhLk8K8a19rRz3SD4rJlJ4fVFQxm
	oVrJVAFxEDpHQle1gjlCDH5kVr0O415/CNuBvgmrEmIiQjtjK5lglTDXLeTmLM58
	yTBjBuOtQS4+EKooZK6BtG5FRRj1qBbRDlidekgf8NcAohzmg66sgexDJKAmfF2k
	l6vZwg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge435syx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 05:22:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-396638f9a18so1198621a91.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 22:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788326543; x=1788931343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RX1tqIKGVP0bUorI/5rlQmkq+iT8Q7dOX+hFIanw6B4=;
        b=bqZLLBT30NGMzLyrFxLYUJmHreE9NIBJ6H0VD66HBddlSn4Djg3L/lJDwkA/GePToL
         Gsi/df1l4oeesFxXoVcKnpIQ8d3J93HVOe3xZ0NkK+LrQEZe2ZAunbeYWl/l4Uk0V7e+
         pgGZ5Ks6M4LsrRsiWqYBrNwJu8KUxA2EgrV5GJAwHXbxrHWm2hHZdbRwdt8oUyHoDCey
         socUrMOZeaJ68i2ppqQbmTdjeiA5skanBXPuarrZ4kTsaDMqBfblaP/QtmX4GCgDVYys
         qvfGWpphv1ZYwzEwJaO5iUF/Z2IeEpmP03EQ55DDfaXE/gt7zUZMNhBF116O/MkfttGI
         RF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788326543; x=1788931343;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RX1tqIKGVP0bUorI/5rlQmkq+iT8Q7dOX+hFIanw6B4=;
        b=jA+/839JoxmgP69sUd636r4SumWJG9JhvIoHOTY3rygrpT/QjzSZm7hxu3vhLoQF/E
         0Nblq9Jm2sX28wHtBHcQvOmSCMouDJQodXd/F/sHL04DlxgoM731IKF6UgH31KMftUlg
         sf3W/9yWbDC+UM3JLuL68Q4CiTZ8+itOMrBApBJUCzuu9lwwWcuPc0qUF1cTh5ljzWXc
         +h64/Vt/HhRM6t3qpWkwDYlNijO/LVc3FV9Kg1zx+8lpP2gr5WuOy1DHd9v5js5aFf4B
         xYJQeHwKEZMIqG2jX9NkwmjlAlliuO2HEJOFaPndt0YCNnXpjWO5g7r/hMP7D1vBP3y4
         7UVA==
X-Forwarded-Encrypted: i=1; AKwUvBxIe23yds/7iqElR177+oHXj1UVrbJXdjFtHupEvkkTwYM/b7vz+FDqQ6Xc1E1mZWgtpSbdmG4GXxE=@vger.kernel.org
X-Gm-Message-State: AFuF++n/7FOf/mZ9mGxvGmXrE/Q1GKaFD9E2faQsVRGmcXjxTzy+jUog
	RRPmp6qqJ6L7r6tZLC39SVflpIVzRxAZop/RDUTVIISMDcpdNy9wUCAe5np4zC5Y2ReRo7dT8nG
	HeJYAW/9q0VtLyWi5Wdh1YdSX+5gXaviCmw40V/zQ4xCA0ulL8C4fM6ra9fhr+44=
X-Gm-Gg: AYBFou1u2Y9vmIibwzmsgPID5S58FNWBJZnUlihvaw5AwAITWZlnwuiK6LGk0snIhxQ
	r5sBJkdiBOhnWVuJ6C72fXDpH/vPDz64+yGiLC4JLd25MT577qS6pHHIjp1Yy7w6WLAqiffyRAa
	zmR5LO6BtYSdD77zOtIEGeHy79CAtHU+fpioDkNJdmITuzxO2N2idwx47FmVNbyprx7IVspmSZM
	rzc2Xa4AbjrMfbLgiaOZRxPLnUC4IrvLm1CNZySBGiT93NRaOT19YSbYNfRAnOan3GvwaQEvzL0
	8CZzzWSokbpPyDAXj+7GqYw7jwyv6quoLXOiHI7Gvu8Yl31Z47xEHZxQISY7oRc64Y4gJ1zlWTl
	8QceC1QF6IJUM74H+PTEq9yUZKRbE2LJZ
X-Received: by 2002:a17:90b:2f0b:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-39aee1f5fc2mr3694907a91.21.1788326542665;
        Tue, 01 Sep 2026 22:22:22 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0b:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-39aee1f5fc2mr3694846a91.21.1788326542204;
        Tue, 01 Sep 2026 22:22:22 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430eafc907sm3003702c88.9.2026.09.01.22.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 22:22:21 -0700 (PDT)
Message-ID: <cf33b23b-9068-42e5-ab90-ad7f42d72b74@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 10:52:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] PCI: qcom: Enable ASPM disabling during link
 retraining
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishnac@codeaurora.org>
References: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
 <20260819-bwscale-v5-6-6dea79786b37@oss.qualcomm.com>
 <jdch2j3vcjsr2f4u7jhiazuotwqu6pon4xlvhzuhrzpzjhmkkb@7zzy2autzbmo>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <jdch2j3vcjsr2f4u7jhiazuotwqu6pon4xlvhzuhrzpzjhmkkb@7zzy2autzbmo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0NiBTYWx0ZWRfX/gL/HoAWkdCw
 YzDkAxWfaMnhq7n1b8WihMwD0UHSwOBf+4S9BrQjOHuNEPDzvBIORt499e9s1rJKb53qJeePyhw
 ZbdVnS06+K47R2ig48/3myf6triW7Lrq1m+WNtzFISsYXt0f9q83vX1SpGf4uZUZxHEwt6P+25u
 Skrf8eeHZkmvZrT1t5lf9XUANJIGNOVBFlzICxFWXeMHjUtppoRuhgmPmXj6p5mCRauJwzA6hNq
 9K+kBZVxYAJ+wvPceb7SrSUZ6BbcOlAtP+iuhjxhVc/YYTO8ylCaie589NptAULOx9aYBvenHL8
 CdICjeqzxa94Q6mAQVHoCqhBjH7Kqf0LlrGErRV1h5eC8QCutnL4aOLpD+rlGHTa8vQJrcJsdsC
 EykfAM4SAhD7PBS8EQKVZVHKHkVFNwpG6+WWQmgRzLdGNkzX5HJnC5AjdFYeU3uBdG3iOOrm8c6
 tFrZ49fbS2VQ+F6ERZw==
X-Proofpoint-GUID: SFbzwD96xZPohpIVp5_g_Q7U11_aV2NT
X-Proofpoint-ORIG-GUID: SFbzwD96xZPohpIVp5_g_Q7U11_aV2NT
X-Authority-Analysis: v=2.4 cv=JpnBas4C c=1 sm=1 tr=0 ts=6a97b28f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=LpQP-O61AAAA:8 a=B3be4mm0s3FIsxF7KqEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0NiBTYWx0ZWRfX3t17/gJXnK9c
 n5KurQI7+9NJP1r4lJpJ006OB1SKdE8ir8LBir7WCECboM5PAIRY20h/Ka/qwoGBQgDjHSUOofK
 P6k5dNkidyqxwzC0AsZXasxzP4wGt8E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020046



On 9/1/2026 1:38 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 19, 2026 at 06:55:57PM +0530, Krishna Chaitanya Chundru wrote:
>> Set the disable_aspm_for_retrain flag in qcom_pcie_host_init() to ensure
>> ASPM is disabled during link retraining operations. This prevents potential
>> issues with link state transitions during bandwidth scaling on Qualcomm
>> PCIe controllers.
>>
> Is it really a controller requirement or a device quirk?
yes, it is controller requirement, for the future targets there is a fix, we
will not set this for those targets.

- Krishna Chaitanya.
>
>> Signed-off-by: Krishna Chaitanya Chundru <krishnac@codeaurora.org>
> You need to use OSS email.
>
> - Mani
>

