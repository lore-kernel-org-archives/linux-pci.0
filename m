Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E630E0D5
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863914; cv=none; b=h20QlasNTLG2KSrlGHX7pzgTZ+xQ6K31STAGkSspNAOIbDcv03rTY0Z6B+emP7IFW8WJUHkM7KOxaunwcOniX0ANiNQACTA3vCd+XbPMYMLuqigzsCJQBX3YR0EI4ab4HfzKDxB906RCkPWl2EdebboK38oOEPlqUJorLR20oDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863914; c=relaxed/simple;
	bh=GNQnTqvMrNbcJwLNm0gQIxbBvfpU+ljSsQI/UkizJ5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPHrib4VTPMBa8cD6YG1mOJUs3hFsJnDukTIdA56wmqp5LJpyKxEx55F3Y8CwWswFMbTIF7L4hdtTJKy5SYS/AA8aRhWCs3JkIj+2kzJjK71PnhCWqAfZ7vC9SjIrAbAfrr6/ljksADx2ct5glJlOaejrFQIqek6DAi4HGjsPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IraS8mIn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E77ERssK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IraS8mIn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E77ERssK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N8bEk73018272
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sgfc6Qe9/YaCooZGkC1L+LSJ+OhHoKPGDOHRcffCz6E=; b=IraS8mIntf+gMSGs
	dq98enbYj57qNyOa8qFH5TqTItMONDWgapRKkVNfmGbnjZBkwfPrP9q5cUBIU+q3
	LdKFs02ZE0/sY+MkfmxDmS4C718Q2z13t9N21dVIfLL1zlabhV5Hnhv2R2zaXoeU
	2m1I6mP5zfoHz4wONN5rNa4nM+KlhYmLIgeiz6T3w89pXV5viXRVAKJctnevABxM
	KLppNnaoKtzmJw5O/V2y06gjYINKUaX99ohewnQ7OMeDQNSPDt9mwnQbcc1KTKn0
	9jfTFtL6IZvg0DwHqfMHHlSD/DOtktWTExH3rds36yS5735XjAVqJ9F7SYLmgjqB
	PrBuow==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5u8ndrc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 16:25:12 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1270dcd11c1so5878010c88.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771863912; x=1772468712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sgfc6Qe9/YaCooZGkC1L+LSJ+OhHoKPGDOHRcffCz6E=;
        b=E77ERssKcl5Sbt1dLomonhmVjjvoiV/nrNDosxuy0Hj7U+CvZdy98+pIRtmojSC/Qh
         0TGFaf6ILzOUh1tHtGnxqkGH806LRayLOidMtYT7WXQpKe6o/XruPZqKX7umqWpoxeWX
         LiV9+5nFpQUPLmAHgfxgxYdj7qRHDRqDFom9MaEi2vbP5sUdpkDdOKaWwz4Gs73bvTh+
         mo3AGOqoic5fPDzp5XvEtck2jZGMifvpWJdL2n5yIhJ+b/sDqGnLU9ey+bKdtFWTRllF
         UVUKoCznY9VwEIXigZ9it2YlBLV+yRrxKRBJylp7Mt3QQTcZIMhpO5e0fGtidvqnaK1o
         l0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771863912; x=1772468712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sgfc6Qe9/YaCooZGkC1L+LSJ+OhHoKPGDOHRcffCz6E=;
        b=vXbEqyWZ6jhH3sV/5xX2PoUDvrQAgsJd0hFp0tRFUu+uWcUIfqxgSwJ0PVw+1vENhV
         LOgy3gYABrobKCjqF8xaGSnT566T8/nr0lIX/PkDEwcwqHShW5onQHMa9J/UFO7BuS+O
         b4b6zFyt1LfQSf5zNj1xCdbotZ3LAPApgmnjsOIl7t6yfhhQWJlctZHrr4TN0wDRqbiO
         l/708u4mwOQLO4QMdZp/3+O5/vm/jE7qW5InRVYT3+yJ0Sx/fHunoqICQstjD5OuoPTi
         IyPy7i1Mh4vCcNmc1LHXPVi7uWl47b5XPkkEmTaEqgXHHkxdkt6o2HPQIB21hG/6/Acs
         9RKw==
X-Forwarded-Encrypted: i=1; AJvYcCUb3Me9QKvZzUOqi/6SWVizfIi6EIMjDLoG3jcCkrCZ4ww3x/7cEFXdTj8nLM3qKlJs20sU8G5lLnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNs8SGNx5AtQ/ULlVV65CYtLvYAVJEOySxWZI7Htw1O0A6z9s
	+mGoBIwhKpcCB+fMPKoqaoHvpjnleJaA5H14WcTRU/SAjcvfd/KwHFfgRyG0mcejGHOx6C2c5it
	FmqKN8OqTh81uJxyX9NIiEmzIW795gwEQDWlDYEqrxCTzsayHbgN+di8lnsuv21s=
X-Gm-Gg: AZuq6aJVgkLYgDEwOn653MP/qHSAwV2adXG4FwDl+PzyBUKY49vomPbGdvVpQoinw1j
	rdk9nhrppstzwdTOVlxPUvBD1mdP4fmN54jmrSOV2S+/h6wWIz0NALjH0JozXy4rigvFusio6q3
	EBeNqk0n4v5N172CTWZTxmAMJzaVooiXMNqqdV5/aaHIBbGni01w/HmTq+RLemKLcA9lL8CJCto
	xr5B3+Z4viw2rWn4lrBCEfZJpreWVdzyfC1wL3DZ9vzAK20/UJDTMKHfDBmeF+Yf8Bm7Y0P7r7j
	vGw35nXSAV37Gb+X/2UdEK846UaNz78ZhZnz+d3RGfzbETpMFEgngoD3FY/fWAdgwVhfZBE9xeJ
	GA17pwhQdvnOOP2014pBICIKzp+iZcyW7jkO7Grv1tBSrjQZwjTW3qO6bo9Vvv8zyO1KoO0oY0w
	I=
X-Received: by 2002:a05:7022:6b94:b0:122:a2:ffcd with SMTP id a92af1059eb24-1276ad622d5mr2369797c88.23.1771863911420;
        Mon, 23 Feb 2026 08:25:11 -0800 (PST)
X-Received: by 2002:a05:7022:6b94:b0:122:a2:ffcd with SMTP id a92af1059eb24-1276ad622d5mr2369787c88.23.1771863910794;
        Mon, 23 Feb 2026 08:25:10 -0800 (PST)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af2edd7sm8614239c88.8.2026.02.23.08.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:25:10 -0800 (PST)
Message-ID: <d69a2cc9-15fe-453f-b647-41c5ead7a1c7@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 09:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/37] accel/qaic: Replace pci_alloc_irq_vectors() with
 pcim_alloc_irq_vectors()
To: Shawn Lin <shawn.lin@rock-chips.com>, Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
References: <1771860581-82092-1-git-send-email-shawn.lin@rock-chips.com>
 <1771862143-89507-1-git-send-email-shawn.lin@rock-chips.com>
 <41d7d63f-bcda-4182-9340-54d480473586@oss.qualcomm.com>
 <6f0932f0-1e08-62a8-eb92-2380bb9f6928@rock-chips.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <6f0932f0-1e08-62a8-eb92-2380bb9f6928@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4m9g0ipZSGFq0MzQSRiAoLgCiMeaRjtf
X-Authority-Analysis: v=2.4 cv=cJftc1eN c=1 sm=1 tr=0 ts=699c7f68 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=rUhstlRxwOIcCgk686EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 4m9g0ipZSGFq0MzQSRiAoLgCiMeaRjtf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE0MSBTYWx0ZWRfX1woBSdMmHV29
 kdmHShZlvWb7X7/MCFhrVxjfXGj0EbeEoNvMnKDPq5827NlbATFYw5+nnTycmadi18cNRovYK4V
 SuXhha6jZV+4n/KZ3VlkMpqU9G4i3SyLzsbGWzGiDjG1jKSbLLBE/j5aI51OWsr+PeWIHW/EtgH
 4BazlSx/RPy1h/jRkhZuTc54d1xWlVLHlALTb3FfNNnV0Q/gcpoqhPYAIWZoo1mM/CkVB8Sxkml
 bzHjjq7Q/N9tIC5iawYCy3kMxKWcWvRpTU3QnXz5uuRj8kuymYEjyzcF29usVwk2Xa1tTuEUKoo
 DL/iRyiMFrHrmWfG0nPksgfEsQkPgnZQaBorsf9/DDMAzpewXQaagufcnBEc/A4r/nD8oetvSTh
 qNXE+1MFMLMEX3B8LJPolp9943A0r0X709ZTfmlayYDW8askRIJV436w0CpS2/z9yGTD/Qnd+r0
 Kfw+Ng3uMF4FNxTYBFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230141

On 2/23/2026 9:15 AM, Shawn Lin wrote:
> Hi Jeff
> 
> 在 2026/02/24 星期二 0:01, Jeff Hugo 写道:
>> On 2/23/2026 8:55 AM, Shawn Lin wrote:
>>> pcim_enable_device() no longer automatically manages IRQ vectors via 
>>> devres.
>>> Drivers must now manually call pci_free_irq_vectors() for cleanup. 
>>> Alternatively,
>>> pcim_alloc_irq_vectors() should be used.
>>
>> This seems to break bisect.  Surely you should update drivers before 
>> you go changing behavior.
> 
> Patch 1 introduces pcim_alloc_irq_vectors() and then convert all needed
> users to it. Then the final patch(37) remove the implict IRQ vector
> management in pci_alloc_irq_vectors(). So the individual patch for each
> driver should be safe IMO. And if these patches go via a single
> tree with acks, it seems unlikely to break bisect.

There is a conflict here between the patch description and what you have 
just described. It seems like the patch description is wrong.

The patch says that pcim_enable_device() has already changed behavior, 
and now drivers are broken and must update.

It seems that the description should be updated.

-Jeff
