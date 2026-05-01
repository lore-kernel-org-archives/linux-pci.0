Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994CA3019DC
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655126; cv=none; b=JG50kMl8jpZyo+q6cB2m4f15MeR0mzCjG9LnrtiyKx+AhZqfCTebfQss+SoE+TjhY5cs9QwIL29ZVVyS80HGiVlJMTYU2nKSqc6VykufENmV758UAbyBT0YaoA6EZ6IrzYFgvqrT8LxXIuoOrgzNJOw1pCqZPmO0xZTykHKDCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655126; c=relaxed/simple;
	bh=W1iWygkXW5l6NAL3Xr3DeQVV8ZuT1ZpmAXEPw9XmYQ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JZ4DIFvfKy5tcsUSZvjpZA4qj31RdRpCslK+0ljRTY94IR3csrpBXB9XgfH10tgCZcHtJCuAqCOCXu9wDGKPtcu+7kT8X8IpcF8ZHj7LYtBe6CwRMWXrk1dhQ4XpUw4dj4illcVvh86im7MUDVwOTds8JvnVvTBxyPCDxvbrcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gG7K3pus; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hF7q63J1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gG7K3pus";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hF7q63J1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641GLgm8625475
	for <linux-pci@vger.kernel.org>; Fri, 1 May 2026 17:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x6sigO+fveMga+jZd/gOn4o2A1z9Ya8vATb3c3sXydA=; b=gG7K3pushjSzZJzd
	033j59/fzbxDoVhO9+j8umsTwgFeUpiu1Pv2qF3bw/CFfSqeBIZlulmCX8lm4EqH
	xYgFadJ2ggMpbZyejTUocrGi5KAomu+O8F+RR8TvzfeF8wM7ktCKRXN2JL7mF9xD
	5xEEIKCYs1a8s3lbD9/zhrWS7CCYrBwm5VXVYZL8RNc8jA2xa+Gv9lJpmNgrnL2/
	72zvYrxhi/0NWXaCnCCVLpJ6TfhcMxrx3TPhUstu0WFBcgSUwwOhIZ2Y3eKHEfP1
	6UMQLS2JF3oQlSWFocKFd5nANrdpWEL/UspTqYNNnkNqmmV2zrc+EEuahKFOfFTc
	J/Si8Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvc45betd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 17:05:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3594620fe97so5355472a91.1
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2026 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777655123; x=1778259923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6sigO+fveMga+jZd/gOn4o2A1z9Ya8vATb3c3sXydA=;
        b=hF7q63J1wGGqlg905hN/DgZklVbWEWypV+GP1RLlArDU1gIWCzgasleS4wbJfHcNrT
         9DdazMweb612KOaPcCIdG9jiRwo4kZ3OeBBca/B8syTMU/sq0/I53UoHB9YKqyWxCfVf
         CULVms6pwU6LnLW2ZIPglDu12izsznEOXWvvy6Wf7OhboFfk/ow44TnVnOSeeIfR/t71
         XrTVFUYQn790dEX2J+9LiE68FoSkN6CbJ5vGRQT3vt0K/re0pJU7IGI7061xGz+MGyCO
         q9q5GYtBmSPbci3IoNoyLz152xULeDzou+ZF/g/jO03YbF+mt+qKGjmvFvypHrVhOCgP
         3FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777655123; x=1778259923;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x6sigO+fveMga+jZd/gOn4o2A1z9Ya8vATb3c3sXydA=;
        b=hee2u29+2FOPXpg1pKUxd491ham0wjCz+q0dV4sdCAgXLq/PYQcfeyeOt04Ss6PALN
         XABe96KdYQF/+jZIortV7s022L9kxS9JTRq5/udpmbn/Z03I6Ae+JnhjLDwXC2nXOrCm
         9lmRxhWCLerF/vzBUIeUQuc6psuNdH/nJdlYz15akR66GlHFqUs0oSbUqh0Yxnhjkcy+
         2yEwHvuTwm8V8lNXVqDGWyg+SyOf5xV6YwMzLuHgdiAKHH7p1LdiD29kzjIhXfPOOPD/
         OuhV6p/v2fAV/gtLVMQB723yYhcmUNpE9T9CgzPZx8WUj0enqpzbVoyPVgwSx0W3gioQ
         mYRQ==
X-Forwarded-Encrypted: i=1; AFNElJ//i5fsBS9/ToCyCE6uscXQQYb4kW7Q8F/lb9QJrOL6SQ5TaOhfxW4krilmkE9E3/wertdtfIlYTec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXz8DDf/gVCj00VdAubVYh/h/TMxA3kvPDa8XbNeLuWs7pPr2
	qtNT8A4BTUZQcT2aig1fs71oXrTd02CnrgazM3ZV4O6X00C5VUzCy5LYmF59y9CeL2bxOjvuTzE
	gCCaCXpKLjI9rt3P/WAKCB5n/ztXrg/VmLy/g+kMm0bkS8upbQPHVnso+Bd+Ytio=
X-Gm-Gg: AeBDiesoZSFbbc9H3kMFV9RYSCmg/MCl80+q1TkGDpoKI+tHmMAqaUy34HlX12SCZvU
	mQcPIFZWkGWhD2Smg+m/B9WimYBkvsOIMGvJJ8Yj+aCxB5UXvoDIU/D4Q7BDt9fxH2xDuhx5ICZ
	1TbQptWo2eUF4lUGTatDyL91NeDtlqxGk2GRwU8uHcj5DqfV035GMEJr+MpHkdzKMp0qMbkrG6S
	gU4SDxWuxOM7/S60hObnQeD48oK6GGthfcOxe1WDj4yiR/cGm8hqKws4qc2CBcDhBiGYkbEpJ0P
	Whh1sU18oOOBjrfIRuvKgXvyPg0nI5ZHarAQ40JhpXb6mD8z4AR2SRGzWPwhqY0D61V50NQHQVV
	1jIAbOpHN7D4Q3eRVbNwVF7CCjrbRtGU=
X-Received: by 2002:a17:90b:2b8b:b0:364:7467:53e5 with SMTP id 98e67ed59e1d1-3650cd866dbmr86724a91.2.1777655123369;
        Fri, 01 May 2026 10:05:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8b:b0:364:7467:53e5 with SMTP id 98e67ed59e1d1-3650cd866dbmr86665a91.2.1777655122809;
        Fri, 01 May 2026 10:05:22 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.59.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2ac19sm7931034a91.3.2026.05.01.10.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:05:22 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, kishon@kernel.org, den@valinux.co.jp,
        "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Carlos Bilbao <carlos.bilbao@kernel.org>
In-Reply-To: <20260410230300.135631-1-carlos.bilbao@kernel.org>
References: <20260410230300.135631-1-carlos.bilbao@kernel.org>
Subject: Re: [PATCH v2 0/2] misc: pci_endpoint_test: doorbell BAR
 validation fixes
Message-Id: <177765511953.14110.9172762868334944803.b4-ty@b4>
Date: Fri, 01 May 2026 22:35:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2NyBTYWx0ZWRfX5umH6egV1UK6
 3qM7/vRXDsWgZkyylZWASOvDDp48UFkiJJHFONOKawOe/Sk3bk99IOZT3EKeDGAcjLctvKM5slC
 8/+w5c675B264DnD2apYwA6pw4AYR5dunrU463NviAbJfbFCK69Ba3uiM7u+R73kHi/4gZrrOfh
 raQn8p6eid+ZUZ18kxxCkBT4GxR/ctL/6rfezoK4DnN1sLbTvGVROnmSUeaE997OTP43UmSDXXl
 RepDthv2kRQD2AnfKg7JAwlRtsKzQbubveKBpL/9Lveh6j0qzlNtvQ/jvdDzI1kR/nkuPIPGa0o
 wm8m90PACGMHgXwjbHXefV/AXJg5EcF15WwKZYApycsyZIchrhTHxf9NntnXNEVoBmfgaxA3TmQ
 /u90aPRYNAYaaj6ltsvn9V2tWICRy6lMR7zJ4xt3meP0CAZrtC9+bm6zCUOJuEJZmMF9Cbi3cw4
 Npp5t3QyaWT5LRF02EQ==
X-Authority-Analysis: v=2.4 cv=DP+/JSNb c=1 sm=1 tr=0 ts=69f4dd54 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=VvXziC1WMG9Np/cC0Lm1wA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=bz-RGvMlN0y8VhokIKoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: PGg4Ki5VlXM8aY0wbcT3FTB-HME-jtcb
X-Proofpoint-GUID: PGg4Ki5VlXM8aY0wbcT3FTB-HME-jtcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010167


On Fri, 10 Apr 2026 16:02:58 -0700, Carlos Bilbao (Lambda) wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> 
> pci_endpoint_test_doorbell() reads a BAR number from endpoint MMIO and
> uses it as an array index into test->bar[].  Add a defensive bounds check
> covering both out-of-range positive values and NO_BAR (-1), and remove a
> dead register read that precedes the writel sequence.
> 
> [...]

Applied, thanks!

[1/2] misc: pci_endpoint_test: validate BAR index in doorbell test
      commit: 36b80ae4206ac382fa298286277c70be1d6989fe
[2/2] misc: pci_endpoint_test: remove dead BAR read before doorbell trigger
      commit: 89b3c5044867c86e421a121481b1ca8cd00a3f6e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

