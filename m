Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3A469849
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864825; cv=none; b=f+dI4whZ/1RDj5Yk6Fh8/HY/vBshtWEtZNtdzvFNTHQCnPgEaqrUQzRN4o6gGG8FNu5XoiwLIvGNZf6+41xvXtjwl1/5q8gtLxIC4z+bmdhtoGq1IKWsUPELdXHEOVklkAoLvuvtLr+Z6+DLEtil+AL3myEC5m0/H6zUxmEDWCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864825; c=relaxed/simple;
	bh=s5GrUbO/K7GURFg+P5CxA0Qxa0DU2VYDxIT+ut6Whsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubOCwgwpTi8HsSsDfAu3uYHeqafLXo/wSyU7nlvo3fET9NsmQi6sFZZDBnCoYFOa1f8L5ScWQLm0RBIZ4sZJ1HPo5o8fheYJUg49fh/TULvdB9RLTEpQ94UcTCPE+KaSttLErl9UF0gRVXOvcLZZO6XnahK5EH4JvXbfAyN5EcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSFpLY38; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CjBPgeHy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSFpLY38";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CjBPgeHy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674G5BC64072256
	for <linux-pci@vger.kernel.org>; Tue, 4 Aug 2026 17:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wyItnuYAoSw/iX3WQl8cdPxSiwleyAQ9qgrs/f/zFks=; b=WSFpLY38+80fqZZO
	T0ca8XTtSMvaGsVT8TlKB8IYPBbmrVMphHdIBXmQNPQVDdldguwuneFbwyTW4Hym
	K2PuC12/0ohwXc1ftdZdY2J/OxT/hromVjhdprIjPPDxouVh9GX5o8jqZiCR76hl
	tEyxTFN+cqt9fYQBW2TOrpd9MTTQJc7X5kRYyHSOcMw4H74NpnSxFZ37SDOFKuYM
	woz1mR4iktjID03UP0IqqvJHCqqsF53ZPU7S8qVHMNuxlfQpug0qETs2sZNxkBfy
	SuatTR5Io7hgvD0r3EUS9q8ud5j8LKR07YLLEexUOxtS1FiShrk48h9UaL0k4ZzD
	6z0Klw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuk9u0e4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 17:33:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84a3514f912so67302b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785864823; x=1786469623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wyItnuYAoSw/iX3WQl8cdPxSiwleyAQ9qgrs/f/zFks=;
        b=CjBPgeHyDk1+kB4y/JFdJD3vIPVF8KkZZ+OFHfQWTiFZqFE12Lo48CB/EEgm0O3iP7
         pnu1wo1B1RKd64apUu3LUioOYc6iBXACqmrIuRk2nLTswld0B8ipoc2zrI1LdzEV/o6R
         p03wfP2SfIqTdIX8JKvSGEKvRQe0gHMFl1XYc8480YuCtGOBiJ8fMkpjuqhqNiob9UfS
         WqAZqKw5lEDkTuwJwgJ/K46R8yxBHYtzhOFo6yk1BrtgtPmeOEEV8YIxeUA/XBv4jFJQ
         DA/bUsNo8Gl9s3i0Rh7M+nFvNP6cZfar9yrfslq2EWmmGYIdhwNS/5GXe88tDbW5QpoO
         GXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864823; x=1786469623;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wyItnuYAoSw/iX3WQl8cdPxSiwleyAQ9qgrs/f/zFks=;
        b=s4KrMqrVPGM44uZKhqJjOjFrk6JRueookI//1NQ2C8P8LmslgKoM5rcFa4S98EYgQQ
         dGSbqpy2wYdLwM73XM2J3Td63VnJSA9Z7glys/Z14wjgAh6xHbXIyAd4oiTmYAFciQww
         bYEFtMbx74LeSC6wag+3tavX0UdStMtJqLK4sFcSPL1+XXZ8SQuWRKOPiUbj12Gms+iU
         eIB2AXl4y8d5Sh6beB0Z5xR/MBgu02BBmnJyElr87vyQWVB6jqfX7sZGwPk831Fn429M
         +QdkrOcI10kkHXOC1gbTPvMjTKO4mbQCZNrbQCTT2TGf3udc2mKbjanAXhuvV8wWWeJv
         kvlw==
X-Forwarded-Encrypted: i=1; AHgh+RpV0y7mbbrITcyQEGLwFUoV3+r/oxIqNIGpFb05VqKRftV40bpnLa60IrjWA4ISIaLkk+HcyY1N9Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9LKN6Kzw3CYW1KrXPr7u4rjoH5zdt6ou56FTxhYE+MK+0FnX
	YqzXLdRP/7NkzwZkXVpqX08/7HQI1E94IakrR2R1ilgdmKyLUfXDjF7gBAEFD+sgXtdEi1Eh7PU
	EZ6MAYwKSz+j3JuRamJuuhHFaS8Ny63shNlt21WokhvQ79GgjohnAKEOn5oTaZ48=
X-Gm-Gg: AR+sD10Jp8Tm2CIaa5XS10IYLUa2ig437LAiULLi8BS1K/0TDPwpRj8sUQV4GlX4Cfz
	Lskpc6h4yRkRviP6GkR132moSGQVN+n7DVw4j4YCMU+KwhhLeXUpardvm3R8ze6MbjdBCVhBUJG
	1woanqQ5W14SNjhoIyX6ZAA+/mpAKE777uIPKXMacxLmeaQnNv39aPM091MQ1slxn59oehV3dqv
	DXsPmqX/OMVPZknR7CVs6Q8OcNi2CZDYu132GH6kOMR5A9iI/PN7b0H3ucg1I4DGxqUvb2t4WU+
	5AzJv4wp8czJCmgeXoDPic7qnl+wVzTcKBq84rE9ZAuB1lcr0mY7JOelL4/7J1azNfDe90AeP0S
	7K9baXe6UqAcvEmhVUivNXvpZy4STTm5o7Q==
X-Received: by 2002:a05:6a21:6b0f:b0:398:9379:d04d with SMTP id adf61e73a8af0-3cb85e6c922mr471751637.24.1785864822739;
        Tue, 04 Aug 2026 10:33:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b0f:b0:398:9379:d04d with SMTP id adf61e73a8af0-3cb85e6c922mr471711637.24.1785864822315;
        Tue, 04 Aug 2026 10:33:42 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be99sm12590660eec.15.2026.08.04.10.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 10:33:41 -0700 (PDT)
Message-ID: <ed403582-d3a9-4d64-98a6-5bc8537f0f54@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 23:03:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 03/14] i3c: master: Do not treat master device as a
 duplicate target
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-4-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NInlPU6g c=1 sm=1 tr=0 ts=6a722277 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=RtcsEO40LIKQJCypwjwA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 7rlWshIdJM2_17qz-CXqYGnsIP5VqHWN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0MiBTYWx0ZWRfX0uKO7FNpOK48
 madrB0zjIFppvs6jJw8ikcl7PwtV83rhrogT3B55RDajCZz1h4opi9v2aSABVSKH4AG5eHPI6KR
 Bj5j/t3cCBgMKK9PSwyAuyR8jYdVc+s=
X-Proofpoint-ORIG-GUID: 7rlWshIdJM2_17qz-CXqYGnsIP5VqHWN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0MiBTYWx0ZWRfX7hqUGoEdrUjW
 yZWkdBkDDuc843Bo1D8OKyxFv1pl5xjSaT/cRCII3UWkRO9eXCd8XWjXG5dL2r9iWuFsvBFz04w
 PARIHCkQSyv80ZYapIEKxrsL72YHzr/NE1lMqmHWdVcRwo5/CsaHyi7coDkfYNQOcEuPdDeFskf
 R/ykl02V9KOf8L582cJ7zVoqqFkt0yN5zQdilcs62Qw3ie3Cwc3O6qLwJwnvlvJbQ2Zmhrpu/yO
 tkLHlCXuUnt+mme3kpC15xt0ROplLR6VgXTZc3zApK/UfOq+nQ1VzeaA/i/UOg2TLs20rEvXgSt
 2iMOGZOo2sWYgCcy7HFkfIVHqzICiDpXULySK0AXd0mvsHpdw7gpIYugrz4beyrjNrSjnV0roUw
 3ZckLSkNoRRSsTvspbAO7CdLupiRgwgfhQW/Nml30lXaN7jwSUNYqDMazwN1Yy5QiFkteHjTieM
 6jfmdDNtGp5Smwoogtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1011 adultscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040142



On 8/4/2026 7:07 PM, Adrian Hunter wrote:
> i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
> device with the same PID as the reference device.  The search can match
> master->this, causing the controller itself to be returned as a
> duplicate.
> 
> Since the controller is not a target device, it cannot be a duplicate of
> one.  Exclude master->this from matching so that the function only
> returns real duplicate target devices.
> 
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V3:
> 
> 	New patch
> 
> 
>   drivers/i3c/master.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
