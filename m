Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33B3CB578
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042996; cv=none; b=jmnKzcIVY/izTqB6765Qp7xT4jQUrl/IkenlUNNPKmYaIMbJnH1ImMid0/iUnU3I0puKzmC61wVMBzwPE7yMaXHPC9f8rFLciBP7HqnD1775j7F39DU/ZQ4FFjq2Hr4ulWTGGcTjeohaHXLo851hMv2Zm6J8+Ra3UnpSFdGDXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042996; c=relaxed/simple;
	bh=xB8N6cUDJDuyXxiLPqDkOEBEypAeNb//J3zNTvLIe3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMjNT6Vlbqz2T6BaK0OtknrDWaSJexuLvyCS5j7zavcAgHITRsmh3YsBcd9FuGDbwQmhSu7jpwVoLy1l1ah0Y4OOft99Ljzf0PO8Mc8iinTg/ieq2l3iPKhOvoZ7KammSdgzjmxzOFby7e3bpzxThK39H3Kwk7aXifCwffBQRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y3zxAs9v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DIFL7N9M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y3zxAs9v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DIFL7N9M"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHf6u2757755
	for <linux-pci@vger.kernel.org>; Thu, 6 Aug 2026 19:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQkVjA9pmubbxZYV7B9I/KJHuyXRTQBwNfT5h9lHEBI=; b=Y3zxAs9vLnWKtiP5
	sZDxc94coZH9/v6VsPJmHViUv9PdcFAyMBVsCttQKUnyP9IzSmpFr2NPG6s79vul
	fr31d2hZjFof3B838lt1jcaEXiDgBvT+6oeE6eoC+v5h1+5MEGlF9dJ3mdMdc4cW
	3AWAGkuaz1ZCmWpjqfUC4jN/ZGrjuLE/PAs0Y9VolSdVn1o2FnxldO1oHKVoRF9q
	ExVzZxrTODBNPPDs9i3/GL5yo8K43VRtaU1Pw73Wkoam7AEs0ZDf1Ai1J5IyA+kz
	0BfKmB7C/pKfYMUSWtANtSsMVfddGdrzCA8QlCREHZbjo/X8jYfOvqlT8WIuqUEE
	MFM2QA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6frah8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 19:03:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e3d575d6eso4266020b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786042993; x=1786647793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQkVjA9pmubbxZYV7B9I/KJHuyXRTQBwNfT5h9lHEBI=;
        b=DIFL7N9M9L4DqXAo3jvxo/1EoKCZJge3bviT7ldzwz4vsuoajdwc4lmo4E3TRlHayf
         4r7OeWP8uNZPGj/8o+hNGQqRHJpXPLIwr/hWP6mt/4KSukPnTdK6eNmE7tk9bwyaLNi9
         skklVyl0m25JxEt0grQEVNC1uteQH9w7YDstpU7+oBOmxRh9sfVLtbj5RZM0H5znMfIF
         NUvt2d74H5jazGrmMnojpS69B8Dm2LDLXV/K1FoKPY+3twLLPD+lwEsgxVZZ6WUgJuA9
         9IdHbolzjIeMKX67PrUJ9cADGFb9lT2LGONOfcBm639gkOzBb4piJG2YdbIcqUiI/oo2
         A5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042993; x=1786647793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQkVjA9pmubbxZYV7B9I/KJHuyXRTQBwNfT5h9lHEBI=;
        b=Ysd2lVvlc6aCcOUPjjsdbAIrKkXRvhZdaG/ZBLAwIph9o4DSYyIstdxEFIg1CH1amv
         ru8AGdRZO2BpwjFgPXeHmTA3lAo95cmP4uZi0CU07xWwbR8tfpEnc2NphqnvebzyC7K3
         aj7ysLsWK79/J+PEpEFfd0rYl6qUKsWda9I0wmaBt1qHu+oaqhco8wrY06JESLDie9P4
         y5TXEZLEeq3rPG9/ciyzgiRpaya7gJaouffhwxECtZhjGqjhuyB+sGIwxxXiTTRIvCnj
         UnFbMcGmgG2gLbZeheGhjDkJ9A58ZrmJDfRF21SMPEbEkK1NMKxwI+WFwaJhbRujlBUA
         KJ2A==
X-Forwarded-Encrypted: i=1; AHgh+Rrwk/Yr7OME2AfVc22YiGD34ANLmohtt73QIOS4HC6Zf4yxobTsLPYRBw0bCazIYsVRao0mh0z0SZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjoKF8XKjo5SwzDx5wAhpLuwge1E2x9PkrSzZ5J7D/VIvglSU
	mKwoowM17525fU3U19bqYFG8aBxFuSOJOWWsbDz1EZOuxJDaFlhaUi7YacDP8CMi+qcbquSczmU
	keHoELsUOj/CYLtDZCfUhopRR9F9tAStOsgKzARLO90yNkNc3OqtIUzfTZTga3Jo=
X-Gm-Gg: AR+sD13Csypq7sYmBTURiKYxWEybmR2jcee+KxJaTuxaDDzQBG7OoCDNZu3yefe4A/D
	l9Oabxk6mzharN1mD3Tltv6qkfPOtRwTn3oR/Hf9VX059PgfABmRL6tBQQLbs+mfv3sq4RQ0VqA
	1sGwFaWehcgVGAxKcrRov+VAwTXCX1CuetNxY0Fpd/ZLS/V1fGlSg4obUQdJJ7hFDHXyIbInMtX
	i29vIorGnKfw5PPUEw/ldQWAVR3/LPskcYHUDIKHUWjaEQLBlLtkYrsgHl867b3dv3cZojqrrbO
	A5XuEa8Hnih0VABUevpGkkrUErMvgNSV/uQc9R/kG+5RssAlf1vAhUVF0N8dJTo0t1kFAk4MFiP
	igOSruTZfL5t4VIWOq5vHKIxQI2C8AVaceQ==
X-Received: by 2002:a05:6a20:244d:b0:3b2:a809:ffe with SMTP id adf61e73a8af0-3cb85dcafaamr19832901637.14.1786042993249;
        Thu, 06 Aug 2026 12:03:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:244d:b0:3b2:a809:ffe with SMTP id adf61e73a8af0-3cb85dcafaamr19832835637.14.1786042992725;
        Thu, 06 Aug 2026 12:03:12 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.231.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158678ec37sm30465262eec.23.2026.08.06.12.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 12:03:12 -0700 (PDT)
Message-ID: <336f3945-75bb-4cba-8565-063384020672@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 00:33:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/14] i3c: master: Add helper to query bus wakeup
 requirements
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-11-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260806131857.119830-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfX8xJWZd+Za2fB
 5PwWNZ7K/wdrVl6L4YdRk28OaxuGeJRyE0TzlJgrsl84uTyqEamg//RC7jf2mbd6lcvRaVuaPMb
 oi6QmfTSpcjG6RfDjjEWdJufEQmCJJ3YyIfQA5hJgEmSlu1E/xfcPPvW60h1DCa4YLDb22NEYEi
 XBuCOFRB+lx9XZFuTAnRpDrgRU+WpAAOZzMckY+cgG+Pa9oDbGqpBpkm6MwBVmxV5DaKIVVh8UX
 mi+mLTF1k9Kx9SlCyJxSNQfcrzRahW6y2hdc34J4oHqw04d2z8CG+atIn48HoInr3Lxl7paJLwU
 foaoi+DfitZQpXVtpdTYIkOjCqDQb83n6RTxNq5h+d5rR/m9IZNsIfw948BaLDU2vOOi752ZLQE
 QhjXbf2M/ukujGQ2LC8qOEIJht2eapN2voDpGPJ8NLuJQPhz5IJTWtjIsXraTpmFA0EBzUdnctw
 HEvmzqO2hOTlGRTIpag==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a74da72 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=uB10XSru4U0CyR2DWkO06w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=ir2BDiqAYjbXK5kd3AEA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: jbLcqpmk9HqEMWJeork1yboEMEgGn8Tf
X-Proofpoint-GUID: jbLcqpmk9HqEMWJeork1yboEMEgGn8Tf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OSBTYWx0ZWRfXzdC28WHzhEVx
 qlOxXYU8ad7D+LX641q9MuYh0JsmjM2IfekAD/QHiqfNwfSH37K7KmvZryAr2FUgtcqApd/7+L7
 YORR0rcUZ/BnLnxLEOoz4IgOK68teIY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060149



On 8/6/2026 6:48 PM, Adrian Hunter wrote:
> Add i3c_master_has_wakeup_enabled_devs(), which iterates over the devices
> on an I3C bus and reports whether any of them are enabled for system
> wakeup and have IBI enabled.
> 
> Controller drivers can use this helper to determine whether wakeup
> support must remain available while the system is suspended.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Acked-by : Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
