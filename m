Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9714384CDC
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804022; cv=none; b=KtYJoe33S7/RcqFNi6smI4ofBnN6/VZNOanoSNLWdxaWZap+/lm+Qt3OWItklVQLQ2oQPGqg2/KHwCzxXTuRtNGT1e4PnBnXmmnhj5REmK8Z3kQIBB/Qs/Xz6mQ5hlrsPgM+NH7JqvlzMT0szzae98fra/kc90f2jCRKNCxN8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804022; c=relaxed/simple;
	bh=m5hOpeZuulIzIeMFgswZviFdTs801wBKp4kwoyE7T+A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J4NlG2wweIsOKawWw+T+FM6/zOxKhKdtgSTXe3msmK7dqTxFKOMe6NioKd1nH9WRzlrdaqCvfKV6RyeMxiVgW+bduNpiQ0uDdJ/qKsip15aGZIHZQVAujRq0vf9WcCuuHPPPbYyBFsBdphzfDl3IoJxAoA/Qq3bFHFB6/l6NgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WCt1s9gk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bZCg3XJ3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCt1s9gk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZCg3XJ3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U6CP3W1097887
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 07:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3K81payB/ssmTCzPC25RG2gl9qwdhhPB6zdKyYaPSMA=; b=WCt1s9gkySEZXdgB
	eQGrmZt2QpwpKzU6sgYaT7BGLzNL8hq9Nc/Cp83L2EENGpH/uhzY8NT7X8C6wOR2
	ZJor6BJQOymIMEQvbMPRcTJgDWxIUbqp3ZOXCKRRM4oZwPkjBVV+FbS9lJKTumxA
	0NVdk45Y9m1kFjxe9ihgb8U+SbPGfkx+x3ir32FXLm6WjNKsHhvSDYTscLCqcRW+
	c1cQfyVEl1MeXHBnIVgZFNWvEHxwOVFKjqAItnyR+8T15gw948+xFGbfjSmy2Q5s
	3ZM35zy61EewvOG6ZpllYxLZU5S2TOpqgUd3DNkdVjicsIICoYYVsgUTA/b4bnLM
	kY3tAw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1cteat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 07:20:20 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-138acbc0e69so19769641c88.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782804020; x=1783408820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K81payB/ssmTCzPC25RG2gl9qwdhhPB6zdKyYaPSMA=;
        b=bZCg3XJ3WN0ahz9QJuXfdgnCveSx0pLQ0EZGs+5yKcui1gIjuv/NTndwJ5F4HR/j7v
         Nhly1lX3YGWZGF4lSs6x7M2G/dqzkreTtLFNlKV4KRK1FUehgH0GrSILW1dvypzJVXd8
         OUxjrYwvetJgqSD7QeSpU/h6zHnclMVLnTb7PuplAOVaeD6Gp2y31SjuIWQSJZ1vHyZq
         qH1gMEfNW8xTJTgpMHqf8y7vCBnkdLWViHjyiXzzY8hBy1L/O4FBIfWx3TfAFHSqQH0q
         bSxr7cXmNWQ7hQyDU24OU9LZ3XWFDFyIJIpytLID28wFzVyqohMdhNllSozwlaMZ1mLu
         n9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782804020; x=1783408820;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3K81payB/ssmTCzPC25RG2gl9qwdhhPB6zdKyYaPSMA=;
        b=lHaJvJ//vx1A0LurQnkWtPBQiX4/pjm3bd7i4pggT1VigHLM9j/achIVcDoa05oN/x
         keND+MaBVhcZhYPn+I3v72Dbb4X41OnEbsr+91pXC/Wl7WWLSK0YSkvkAgvIJHdur70e
         Dn8gbyuaOJsM09LXPIDl3GGwLi0mSaN8QAO8YESPVfdozCKDeP3whNBPl13P0yzWJU65
         TnFY4rMW8gebBNquoMgLqGuXsWtixxMjoRfrCzuQqjqZwXF/GRu8Tbvf42cBhrf1XCWJ
         YqjXBUkYUWVEV2rSezHMwZmqFYBPdjRBkeCGu18WZzq3fYjjUC0X7jA/n7m6FBMBtqa6
         CECA==
X-Forwarded-Encrypted: i=1; AHgh+RpypDle7m5iYwNATJBPFPYSMZuzTt0OD1KNFDDGGw/XHuVug15nmOhoNFyDebh+E7mAPmMcQic+zs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvwbn+SkJikQBw8/t/t0wAJHV9N8AYAzrni0NMSVUyo6ImWxd
	OkoQbQ1tzN0NrZ05TEEa3MDcedF6un5XIkPleChSdX/O/zfTvDZ/GRm2AnzgHocWr8hLR/6Ds7Q
	cqze2U1cJRHKjMPY9FHozbmX0aM8KwwU32YV8ijliszxiUOU3APw7nm/AXPuTAs8=
X-Gm-Gg: AfdE7clppu5ITARwlE8DER5LXW7pXDhpmFe8LYr8NZvNK8w2NsWxXGsv3LLGJBotI9v
	ZL7xisuMdVgwutkvY4nkGrYn4FH9xUVd7Q48MViEDa3jw+zV2bn6cZ0/PdstjlBPN8qvFxadBgd
	Bxl9qKYmN7NmBoXd07BVffo1a3IPczkHIyYSkIDyNeBrmAqIioHqhgtvSDZAO1bkQEvoct8GU5L
	kktSVoxA+iHN83lshrKZCo7zMO+eAx97iJqTFB+HapO/v+OuepGpNGomWx84AUR0YMlMcy4rs0A
	2Myj3uf9EC8HMMtLsnYPqC7th37CFlqNUBGH6H6R7a5zRxwTSMjlY/At3NELV/2O7azp0Kh7fKF
	gtlh+OYDLtMHPHOi4OygWKbkIAMOH
X-Received: by 2002:a05:7301:4888:b0:30b:c502:23df with SMTP id 5a478bee46e88-30ee1211bfemr2036186eec.13.1782804019645;
        Tue, 30 Jun 2026 00:20:19 -0700 (PDT)
X-Received: by 2002:a05:7301:4888:b0:30b:c502:23df with SMTP id 5a478bee46e88-30ee1211bfemr2036126eec.13.1782804018618;
        Tue, 30 Jun 2026 00:20:18 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.56.202.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2fbe011sm4857374eec.9.2026.06.30.00.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:20:18 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com,
        bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, will@kernel.org,
        "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sherry.sun@nxp.com
In-Reply-To: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
References: <20260525065443.2338629-1-sherry.sun@oss.nxp.com>
Subject: Re: [PATCH V2 0/2] PCI: imx6: Improve PERST# fallback logic
Message-Id: <178280401285.286395.10401291228239552702.b4-ty@b4>
Date: Tue, 30 Jun 2026 09:20:12 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA2MiBTYWx0ZWRfXzBD9MGMJR0Ka
 llis39F9oyZLmC6zyfuRMKdB2U89erIUV8etpVZrBjMVXPSrQNuD5QOaz4jvMF4tZxho8Up3Agi
 A7CHBOSAGEj7dFwiIKYoreXK+gkAJC9tZkzldlwC5C/jKhUXapjX8ZcvzHIofXpltWC6Xq9ESoI
 D7plCvVNqbdQ+PeDArEM8C9cT4pnqqJ0+yNB7okuDL8unEJbAXJLjNnm5NxKDf3QoDXoHxCh1pB
 8YUnCIHRElazS0NlzCy4W9tlMqtEwKXlUhZQESJEkGdhJJtWi0K/n02gVIH4ci/kGg2ieZHEjhX
 fWSxAbHFt1/8yN9/AH3FfaXE5KUFWWxrwdmz6Ut13q5hq1hnMUGQCObdqLGh/HeSuBJA7BX5G9O
 ge4bbZeZN5vV0AbITntRa2LSS82snk3Ul7RhJRisagi0alBU+IcfNHqnkZRNxjwkHPIs59F9BWJ
 4iNYLN1ggMNVjfiwb1A==
X-Proofpoint-ORIG-GUID: uHuVlwjH7TjYzuj5x2qwCHuq3-VzZNjA
X-Proofpoint-GUID: uHuVlwjH7TjYzuj5x2qwCHuq3-VzZNjA
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a436e34 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=d0NiXODO0fVjScRmrPHHeg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=8AirrxEcAAAA:8 a=tFJ3_42GrAp6gSAKR0AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA2MiBTYWx0ZWRfX4S6slEo1CGj4
 kBfOP3BduO1bVpWDQdS4eug6FI7Vip0d8R3WmLSyFDp66+xWZIIrmyqcpZfDmdcW99subfaYTKe
 YKuTZgEfUb2sTzxmWef1EnVOc34HBJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300062


On Mon, 25 May 2026 14:54:41 +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> The pci_host_common_parse_port() shouldn't decide whether to fall back
> to the legacy RC-level binding by checking for "reset-gpios/reset-gpio"
> properties on the RC node and returning -ENODEV. That's a policy
> decision belongs to the caller, not this common helper.
> 
> [...]

Applied, thanks!

[1/2] PCI: host-generic: Simplify return value handling in pci_host_common_parse_port(s)
      commit: 4b523544008aa70cda4b34c0589bbe47172c2637
[2/2] PCI: imx6: Add imx_pcie_perst_found() to inspect the parsed result
      (no commit info)

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


