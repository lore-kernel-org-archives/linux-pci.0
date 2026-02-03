Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B68314D16
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123482; cv=none; b=OWuYJOhv+1kySiNnEU1JDySB+X1OwxLowQ+NsggBpIceMS2a2GGdrFsRpEUFVR3yuonGkaFPlZ4sRVeSQ+DkYMmh3qmCgu7v9eHmfCpvtvg63+Cn+qmILXuLgg1fUW6gzEJZsgY6uQlr8Tzk0Vt718FDyRvozSEV3GHyZi3tExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123482; c=relaxed/simple;
	bh=+mKFET+e8i5QW2DEffDUHTC3weGam495Lmz1WJ6t4MA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IeNWwbMi3aPEO7i2DCmSIgKUEFPsur/Fc067+JOM8XweYAFjKJ4DV3HywTzfXOy2HKgpL+5s4L1UCQHK+5s/RkT6OsL7tP3xOq2Stz1Xsp8DAWaPpMDZMVDrzyhlCHAAnC/f4yZgS/6oWYPwt7fJx/JdRRmGQS4d3vCGMSXX3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NDP5U6KU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cBsAYuNy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NDP5U6KU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cBsAYuNy"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613A422m915414
	for <linux-pci@vger.kernel.org>; Tue, 3 Feb 2026 12:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pqeK5vhKka3TksDZMycGOzJu1d0Xo7PaA5U9WEk5Iaw=; b=NDP5U6KU1pxo8VkU
	qfS/Zmd7R5f1KFqLk5ELIRifMxJ9JNYiBzbNAUOPg3MJYaH+qWcYvcyGk7uY+gnk
	yGuK1AscQwJPmTmOrlhBzW3JLTPf0bvuyyJ+MLBW1vFx3LF64hlufasS7IMhDatl
	kXr26pxBQuO2gyahXnB9z8f7RbsToGMQYzOn6GVkI2NfGZ3afBu8EipQU2eMQiCc
	PGFcewrzyQwNO1xwAaWNlsXXrcwL0SKcdv5Odl83tmvd0vAftIkltzNgV4HzUWqc
	hx9sPXxOs2HWv62X188q9jA+J+tYKmH9NXi3IgN1OU4wU+HnqYyBhQ81QDpkIkDy
	F7+CHA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3exk8fxb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 03 Feb 2026 12:58:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352de7a89e1so4789766a91.1
        for <linux-pci@vger.kernel.org>; Tue, 03 Feb 2026 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770123480; x=1770728280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqeK5vhKka3TksDZMycGOzJu1d0Xo7PaA5U9WEk5Iaw=;
        b=cBsAYuNyCXTXQq+5Lf2ewjaAAIqix10O0625NgNlfXZhLbbSLYYCiAWJL+PMy5HbpW
         hq9IelWEK261Ma4h0PDKgsX2mVlDBwkbMrJe1ADi4WzrHu8t2wtnAEx9Grfd4Q9FYYPy
         MxIqqCpBX5gJOBrfxkmg6HEGS0Wey04Lxveyh5WTIqisJA7LVZXv97xYSWY2t5Mg3jZ8
         QMiUJjWuqtNwNL167wxSHJSsNDPb3eK5Fd96SpPWAQjljrzkC/J9oU0wGhxr6h6fMSIb
         l1BT75wiodms9cZchjRLGQtNUSc9+jcUe3HXTx+uxxbs6HEpOkCVnd4ivZSb9nlrehY9
         gPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770123480; x=1770728280;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqeK5vhKka3TksDZMycGOzJu1d0Xo7PaA5U9WEk5Iaw=;
        b=cL3b5reWaRtK27fReQsjeQFRZfwe3kLfmG3rCvE1RSU/M9pDFkiEf96TFgexbbG7VM
         ox4CXuNPcVzBMaAtQ1BaMXSz4Ct0KHyFp76s2HCCfDAglk//Fv6TAUynLWzCNgaygY23
         l3L8sRMJkQfMGlPQG6JdwQvQhNJrQ13WHTs1ctMC+FLOpamWlbw/D4Ybu3nd9T1OeGAg
         YUfRaXKhKLX47JmBCJ/2QMFq92O+evINogbsQw+l7aagqEozYv3IqQjO40Dyg6YhPBDf
         pNi8cm3R2+HpSQqAMou6TNJxw7T2agS5PKRgm/HUcIGx/ki7rjJ2P0RdLhW/x/LyoL69
         2xKg==
X-Forwarded-Encrypted: i=1; AJvYcCWer9ELTkISQFa/Cl14DrK6aVmpuIBH9+Gpq9aortu/QAl0d13/A9PVvaA7XJ9bWg+1FnamyiNpkKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ30MGsUwSLFyKKGzD0XSdwk0+pEdYW7DjPvYL+in+7NDvOdRe
	5JlFb/YFmsJ2LUBGZ7WFzIhRsTxcJkfAaEs7vKhi6EacRnOsPi79Zzj6NjgOkrhKjQEk/GsPixi
	EBjjdjHQIfuFb68U2VveSIMpsE4jTo+j1fk+D7s0HHN9GjMQT70U7A7leinCPgMr+iAAvv7s=
X-Gm-Gg: AZuq6aLPeK1CC8k1XrwU77aqndg8pofq6vvuyVwmDDoasRUjl4EMGWmWzn1w9jlYhO5
	iO9ut0pLKLRG3w/FhLeUg254eiEyg1T+bmpjKnlcUBe1ZKKzycBcADvOzB66dG4MjPEpGFV3q4E
	xTfTJhB+1RSutkEBofEmS4tKZf8xS9kWcm+aaU917fFGWt6rgsbL/pBCl7UJeu06u/Kp2ExQVxh
	RJjhok14TcQ8o6IXxbFjdoJcCmsrPa/FmbFAw6gwHF1cQXpImEFIqDRQHWIs2n3eqvpCO+7t/0u
	fVQoogzXWtwAllXap3T7B5epHXM9QO2GKEBCoRslmeC+0PKu/eM9doiWnWZbxwSj1iISa5XBhRw
	eFbx8mJ68
X-Received: by 2002:a17:90b:3fcc:b0:340:a5b2:c305 with SMTP id 98e67ed59e1d1-3543b2f30d1mr12888748a91.2.1770123480143;
        Tue, 03 Feb 2026 04:58:00 -0800 (PST)
X-Received: by 2002:a17:90b:3fcc:b0:340:a5b2:c305 with SMTP id 98e67ed59e1d1-3543b2f30d1mr12888727a91.2.1770123479509;
        Tue, 03 Feb 2026 04:57:59 -0800 (PST)
Received: from [192.168.1.102] ([120.60.74.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3547778cb83sm2486926a91.13.2026.02.03.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:57:59 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
In-Reply-To: <20260202151050.1446165-1-vincent.guittot@linaro.org>
References: <20260202151050.1446165-1-vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] PCI: s32g: Fix ports parsing
Message-Id: <177012347566.13350.2655028936116528318.b4-ty@kernel.org>
Date: Tue, 03 Feb 2026 18:27:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEwMyBTYWx0ZWRfX+RnbEKljigpX
 Hpam988iu2eQeDUDs53k6kmppYniIvqaQNSK+LLRa6lcRwKH5dEC298Jg3MxJnYpYBvqrGbQXg3
 YTeCYeMNMSEFO3VsKFRYhxxD1TGuKHdIXvQl/kPJAibdhbKJymoty9ww8ayfZj+G8CBT6o0sX+0
 q+VbjEahgI3dnMTIM9KwOCmByDua1KIYfbrwwH0C9VwIp0Om3sEBNiDSni4Itb5hYLqHSIspcRp
 RtdP5BIYB2Gj5Xd6OeSe0ezrj+c9i28TgU3WU822vB75t83eGKvo73X04LfQeZO3p5UcHcDWeqx
 ELfazc1a4Sn5Jm9Kev+zec5lb4W23eH5dI1eEffAj1SBC5/mXaDE0tK9jiCvaa4Q451tUgIVqWB
 kC3d+r74i0GMCIfK0IgbGx94ODW5Lrpy6iIhu5AwY0c5Zgxe39agKkQFpreS5odWCMBOQSwp8zf
 PNitIrcue9oLEC1G6Eg==
X-Authority-Analysis: v=2.4 cv=XfOEDY55 c=1 sm=1 tr=0 ts=6981f0d9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=A3/yxVAzUcVmDczBgoabkA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EvYTMdlcmL0OrTEahKgA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: TlEFFEMyalKxaeGKJQfo--Z7xfAhpgU4
X-Proofpoint-GUID: TlEFFEMyalKxaeGKJQfo--Z7xfAhpgU4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030103


On Mon, 02 Feb 2026 16:10:50 +0100, Vincent Guittot wrote:
> No error return is missing after the loop resulting in removing the
> ports from the list.
> 
> 

Applied, thanks!

[1/1] PCI: s32g: Fix ports parsing
      commit: b79e0875fe8144fcb09e4fc1cf386cb3b2262480

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

