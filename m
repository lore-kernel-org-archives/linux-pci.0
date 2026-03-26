Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA2541C30F
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544662; cv=none; b=nAdSVZGAGJ688a0kEAnu1yC61B9K+rOy3CEITJled2GCuNFjpvMuGZXVS67048XDoolR2hJIXatT4CTfWKaHfb6iqio4bcy55sOZFF77RXJUJFdCYJjQlmy9jVxqdSDYBdwRuFylbLH2n2b887KEO2Gh6yvbbYMlhCk9sPTv/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544662; c=relaxed/simple;
	bh=2wX1Ftg5lb7XEH0GSRoE2+tyw9alX1lvXt+8mwmJcYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kmzWLKpr+Ldb0TK8acwgeLpB45VrisOz23zoz/U1V9gsPFmOB3wkT2poVAooh8gviVYrU2zSFJmsGxJhH1QfXxVNV7Og4wfdGqD6yPSl2V5vKaYaxOmkztCE5gMvz3m6Eyor5lcR2PN+eFznvSaOdrCapYfF2x4mEmFCsg1gS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+Cjx+Z7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q+eFPl1/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+Cjx+Z7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q+eFPl1/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9rlN3373892
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JA7n1l24YbyNpJ1Qa92tca9WcmrvEJLnO40ixill9Zc=; b=E+Cjx+Z7wrfmkMRB
	uDgwH9VIR5U/XVcpt4vFclMbLTLgE3b7X9+Vyrb1iL5R9JHKvMipa4U33r1JgKK0
	x/rqPwl7Te3vZLs3zTnEoeiaGDLKu3MX0ykkHi0IiwFJaMGgQnyAXLdT03VEpCDY
	LLKG0Si/Lah2YGxkVHYWt93m7ZZ2ackhqfFsEPn7PGntqBvtaua/dWILB9fjPtiX
	h5MdYjG1SygZqtOl3tEqkTxjXJ7gzLLuQO+HDHhAcmTzTEGWi9rlFCbDMcPgwc44
	zpVtqhjD99YdqN9FThjGQiEFz4V+8IsGsYF61Xltn3fMZ1gwyggKQkRG83P/0HAc
	pCrI7g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4qksumrn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:04:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35a0b51eb23so1022629a91.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774544660; x=1775149460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA7n1l24YbyNpJ1Qa92tca9WcmrvEJLnO40ixill9Zc=;
        b=Q+eFPl1/T2c2GjGtrzW68PYWiIPQt4J2XmXY+UDGbdMQcu72wnFY1UowrZQI1aOs+x
         vN6DVwy6vD+It4VoppiWlXuVC8yqRjUTOhAVS+3Nr9E5e0FMRtbU+UJUx2M6iC1llrmF
         ie+DZ84wQCdHj8/n6gGKl9As3PX7FtwShFYmPI8sXcZNp6JvloLj4yoxBXK/Yj+VeVPN
         5nNgSwU07ntzQy+S1xYLTs7T9kbsLjEWlcMos+kmo/BQD2yCSnL+OSD3wg3K8x9Ezj1m
         qNfKe971kiO3A+S5RmgeZHH0saJViN7mK7nrJyebsTpQk/lUNGPpE+Xuw4kUztqP6qk4
         2G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774544660; x=1775149460;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JA7n1l24YbyNpJ1Qa92tca9WcmrvEJLnO40ixill9Zc=;
        b=lU8wG1CqQf9xsjjaiRzh/prFWehhr7FOWxAGIJ0cEWegykiH8tuL+J176sNOb7CI4s
         QLrF0PnHQ79wKxJFdxYuKQpO9HsmplRvxudmEebZjnQrhlnmoaaOmkUkgmJH/xwTIXJX
         nPkqh4Y4xmyGdSX9q7bf2eV/AQ00u55iqHF+i0OYfxNrZM4Lnh/tAgiZ9dwi74SemH0S
         1RpSsRHbVTxvXAw8tAoQWk/BRD2wA0QjeNT40nF4v3tcDpnDXavGEV4o/AwG+k20xenb
         uJA0YpmVJbPL7CzBGOPwCZO/VRXL2Iu5yel3j7XE9jFEHGMJC7bPyFPQg2t7KDADZonm
         2abA==
X-Forwarded-Encrypted: i=1; AJvYcCVrpnknHtZnAY7SsdKJrVY8H2EW4hX3OdIRiiVWLYyK0Uie4tq2A2NNnbvG9W7wPBojCciSIR8ALCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwBraCJl+zSV/5i4PZ24Nt4YbPhW9zv3OdxNDskl9XwN/bXQBU
	2oZj+EoRIvU8BNkpoPUm+oUeO9P5ADsqGOBT098Fqr+cNt81UN76CsOtB1vm25ngWD6PY93y/vg
	Fn7q7MTDi0C4IfbrUMZdyqQ0uP8pYwhRC8rJYdXFVwxLZWV3ZwShnwTTh7p72UWs=
X-Gm-Gg: ATEYQzyYdYj5X2dsLwEMtbYiyxyqEMAmqdYsgh1jct/Gs4HcoZeMl6zHZapb0HBEd4g
	H43ycAIrUtz2Wi+M6ZA+980uOc/6/lI0yWgWZlzgAxCW/34XP4hJLt990qPWlKIwGrUQKMQf1xM
	TBh6hrZcYHM9PpiVNRFbBNoiZ1iqYhRRq6y1FQOECI+VcGPwGukG2V1dHXUfPMf7iyH7WIMXOU+
	VYd8PGyW2Yxf7GYSR873PK+qID7GS6Usc2A7tWzkaNtsRViTqp4FUL6LTLTOEZCqqgOgu6aMCZX
	8wYAky6qRgkKPCnyj75PwiN3S1MnzHik5NzC2nQibYqvijTQoikHLUk5Y85dZtZFyGf7bvSAzns
	3DJcoVTaz70IKMZz/4PY3Gog=
X-Received: by 2002:a17:90b:3fcd:b0:359:1821:b4d5 with SMTP id 98e67ed59e1d1-35c0dcb0d3cmr8072743a91.5.1774544659762;
        Thu, 26 Mar 2026 10:04:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3fcd:b0:359:1821:b4d5 with SMTP id 98e67ed59e1d1-35c0dcb0d3cmr8072696a91.5.1774544659248;
        Thu, 26 Mar 2026 10:04:19 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22cba9f7sm2324635a91.11.2026.03.26.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:04:18 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
In-Reply-To: <20260305071236.23792-1-mani@kernel.org>
References: <20260305071236.23792-1-mani@kernel.org>
Subject: Re: [PATCH 1/2] PCI: endpoint: Print the EPF name in the error log
 of pci_epf_make()
Message-Id: <177454465631.454434.17284975025081247423.b4-ty@b4>
Date: Thu, 26 Mar 2026 22:34:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMSBTYWx0ZWRfX3w/5vTjIT434
 dL4za1COHsXC/Ae+N3zplkEzwMIMYo4r4ChV6u2gtAR5JmK7YTY9EV5M/1p66DN9oPUbbFRSY7L
 su0xD8bWMXXtjsmBUu6cJCudV75aYrV3Z/4YAfijWggz7J345J5PQHZJ5eqqV9aNJG9JvS3ne36
 9XIuxfQMjlEbyCLUf+TGg+NEh/vgUPLnPfxjQEoJ0lXqMB8Xd2986TUg7cU3ncAkStdde4ZA4Fn
 765jnxS1WT+9m1e6NpNENQQ90/KUb/LR5wgEw79LSZ7oKqxMC0SLLwoFDcvAmBgQipGtOJ6ZDaY
 uBApfZKi+61iKAM4C0xzS5EjMKpF2saeHVI0rLgyS1rrZLvlGWA0tc7KIlDNBanP/4/F1i+TfQg
 7b/XPq99hc/8nOqwssMwARop1larYiyNZIrUS5iyRNgfZ6NRxCrL4GeSZkac0ygVLMLw0o8U8Hc
 WEDopib9S7e6AQglARg==
X-Proofpoint-ORIG-GUID: rIIYW9jAskWb4PqZX3POqMk9NQQ8TzI4
X-Authority-Analysis: v=2.4 cv=eOMeTXp1 c=1 sm=1 tr=0 ts=69c56714 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=mru5uYHunHBfnNN4YI8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: rIIYW9jAskWb4PqZX3POqMk9NQQ8TzI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260121


On Thu, 05 Mar 2026 12:42:34 +0530, Manivannan Sadhasivam wrote:
> Merely printing the error log without the actual EPF name will not give
> much clue to the users about the failure. Hence, print the EPF name also.

Applied, thanks!

[1/2] PCI: endpoint: Print the EPF name in the error log of pci_epf_make()
      commit: ff5387d4f0798cf1d1a4f548427bd9142cf35b66
[2/2] PCI: endpoint: Improve error messages
      commit: 396d44dcaf8d367ed15ecec30e2f69c62f93306c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

