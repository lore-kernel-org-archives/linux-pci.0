Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B54CA297
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585821; cv=none; b=dwNCXTkS5WcVlsVvvd8SMxCspZF6czURnVmJnGkJ7pPfOGC2Xni2Z+O4s+UJWN+PPb8Pa/1KFx4UW3Ag/Luu/JfttUOVUsJn3uPORISrWrLq5kXR2mgOSrPQ7WglsMwSW2AopEZQBwJjWw7MgQFKWNvaj5CDHshYYJvO3937m4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585821; c=relaxed/simple;
	bh=8U1Ja8P+VJXeTYjM2KI07QBXve6dg9X7VaRLyfyRjQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=g5yVFEnZQg0Sw5jvVIg7qinF/ANXaJlkll8A9TApfq5BmOsxNxWVEWL/1D+PHyWREflBnWnL2e0OZoDt8W5281kLGP9ilU61b2KTjXUanbPn8W5EmqugdPzd5d3CqTSCbgveoM8j2eQQ2AUqp5TchNCWZE0Dva6hnd6DyuGYKrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1WfPUjP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YIjk3lrE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1WfPUjP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YIjk3lrE"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CAe8gV2186405
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3cBTDDbsITV08dA6vkggPs2KMXQ9klD2DkmQBC22iek=; b=E1WfPUjP8ZtMxZ3D
	YxwAq8EBI2Bo4lE/2GMs8Sf5KYGFXvg7CwKkbv0pmegVAqtxu03mFyaXJethDD/b
	JgT069pLF2ukFFA/mz+X0H3bL7XkR7ZdrWakwnM4+TAlh41UG7AwEaPmx4YoPzHG
	JVgE+qBYWmTtPJPnd3gUO3VH1mMn8pgPacGMV3kkeJ0B8P1OOLVYW844chuDNQB9
	WVHwsZOz5Ha3imG/TgcUpAa5fbdtY6fMM+2XTY0JEKgE9idEuNLEoYqzvHSiZ97G
	y0tmeAv6HUEhYr6X3GK6HZys32GekpDTNYBbcBBdaDaRm668NHOMqALwXIkX32Xj
	jSxi8Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0ty0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:36:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8271fb4407so3240419a12.2
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778585819; x=1779190619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cBTDDbsITV08dA6vkggPs2KMXQ9klD2DkmQBC22iek=;
        b=YIjk3lrEojMXUP3GokqnHJHcH2RieP404e09g6WGGu46o4OqXuWbGOLkerqfeA5Qej
         pAVoZSGQv8bdGwlAfQeqHyIoUy4yhM8Rv1EjzE4olwtLxRWGQXUrC4heP1LHschA3I0v
         H1lCGcMERCZR5RJtyzI56VrkYjdzV5vPqlvR4fqcVIdLO8ZXAKMaZGgMqCpM//h/ccTQ
         B8tUnM8ayDzicGAX56YPUovDilbFNCd74BLZUdWu8Nwvakb28E2QIxltZ0CY1dN8Xhkg
         tl29868oOryWwrc/w7fBM9o8iIVQj/vKHMShKQk2kZtcw7GPAlCEBLBTZXQSVwM62iMS
         t4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778585819; x=1779190619;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cBTDDbsITV08dA6vkggPs2KMXQ9klD2DkmQBC22iek=;
        b=RgOJhUMAdMSodz6ViPPLtU+a5FWR2+E8IxBk7wcLq/68dsPwUzoQhxFRmlNvUySGRs
         AH6cqKBVlVMz8a7RJbOjuEu8KxSfSvfh7aqWA8PSEohvrlZDjkZUZZip5GuTqR2keQWd
         gKEPo9If34ucdyICL+sQPBuuZR5TyDKXcmVgnwBLrrxCbx9zI0AdqL22dtBhdFHo1cds
         pMACmmkwHMgmuVtYcs1YSQro/MHVXWyh8o9vvyb/AvQ32g1gHWrQNoc6/3l0eGW+LyAu
         Cujq7sMtaG5hSVtW+h/XRm0heEdGu20Jd9pYIERAnwht+ERpmmxbsX7qI55BRkRmaook
         raFA==
X-Forwarded-Encrypted: i=1; AFNElJ/xgW9yMpgbRbUdB8V97l0Ul9mT4ZDmBxS9NwLWONPNvPDzJbV2hrS88FYUvxsbz7TsfboLH61vGbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzboMbZ9twxVS6YMZW7h1EBwUhaWK1qWKygL2VYSqCcbY8Toni5
	su3nh/riMSpW5P2O7AePmwfS3dazjvzVuXcjl8nIHRQ1VG3K0mwIgxJBVC/Hg2eYxKxOC9ggbnX
	TKdMPXwxQ3KH69/DVEaQ8OmzxgsHA3xF6FH5y1jnQI5Xjg2xRjoYvXZ8fbixm6JQ=
X-Gm-Gg: Acq92OEUjTdXRg8b/Y4VFL2D6427g6T0WVsKa6QpSey/PE00lnct8p0uQfvP0r6FVVt
	vrnN/vDJuN3WALKOhfdJoVM1A0wKE/GIwLdwq7YBmUiz2w0eWqCC/O9xBVKjILA8l5UmJCql75J
	l4GGqDwBZGR/RtJFFc7CGOgdCGF06daN0QIUa4QuWp5zbQYs470fStON/uwjn4wOgxadLujoAMe
	wG3iSCpxnR1wwnmx4uFMfkOvL1a1zLjOq7Vz0shRaDMx54ARxSDd7Za8lOpQXMvrsNeZqHjlXXM
	wx+G9K9eWV6SYuLXjmcpzKlBN4lsOwUvzGh9ClD9ATge0YllgGNm1/J1ll2xMSaBqyx6bVsI2z/
	6dcP6g9CwGvfjTCKsWAR3
X-Received: by 2002:a05:6a00:3309:b0:82d:162c:581f with SMTP id d2e1a72fcca58-83e3bf8f281mr15611634b3a.48.1778585819173;
        Tue, 12 May 2026 04:36:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:3309:b0:82d:162c:581f with SMTP id d2e1a72fcca58-83e3bf8f281mr15611600b3a.48.1778585818664;
        Tue, 12 May 2026 04:36:58 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.206.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f38fsm22544280b3a.8.2026.05.12.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:36:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ziyao Li <liziyao@uniontech.com>, Xi Ruoyao <xry111@xry111.site>
Cc: niecheng1@uniontech.com, zhanjun@uniontech.com, guanwentao@uniontech.com,
        Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        kernel@uniontech.com,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lain Fearyncess Yang <fsf@live.com>, Ayden Meng <aydenmeng@yeah.net>,
        Mingcong Bai <jeffbai@aosc.io>, stable@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>
In-Reply-To: <20260412101731.107059-1-xry111@xry111.site>
References: <20260412101731.107059-1-xry111@xry111.site>
Subject: Re: [PATCH v8] PCI: loongson: Override PCIe bridge supported
 speeds for Loongson-3C6000 series
Message-Id: <177858581215.17835.9314837252988039944.b4-ty@b4>
Date: Tue, 12 May 2026 17:06:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyMCBTYWx0ZWRfX+Lz0j6Y1zNOV
 tbuKFZ8q/PBxug5QIIiXooK6VsjwAc5cOCR885wpZvmqAMwQ5zVKz3VjJJuG+W6fqllJf1mUB6e
 SB8va3T0GbSvNJfolKhtBWURjBXsgBWOtJxZOTsYcGiExEXwu4/U2OnE5WblAzNNXKsqHkH2J8p
 UrbiR+kIKU0RTkX7V5pcR90GSeafjn/fF5epNY8F8WAoy8SeH4Qvbsfrpx1JV1r1cg9qJZz1EEx
 qDgvgcMmHst3RD5B75r2oZuBp21gIN7Cdwo2cNB/09acV3IJqOIkB2uGBU5+YC/R8HaF8JoBq7b
 mpyMIOYYGrXtjP3CI+i56jnQUzkPSC6vjjY1+9OSYV4zGzNA4yAzUQSSEclHVi8k/rlQZdHNbKU
 VRX8swPTUxtd8NoLEVf5ZftBXHY09Xi08rQYIrCGeoOivdFNPc1wqox0ARpdmgsVt1siir5NxB2
 l7ChqziRggpXESqzCrw==
X-Authority-Analysis: v=2.4 cv=bpB8wkai c=1 sm=1 tr=0 ts=6a0310db cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=QuRtzvr4xB5J0le8HPcEzQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=P1rAUm4iSsRH5tYQsiAA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: TWMxI_7kurqccTGpxZzT9YRVsDaiTEWz
X-Proofpoint-ORIG-GUID: TWMxI_7kurqccTGpxZzT9YRVsDaiTEWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120120


On Sun, 12 Apr 2026 18:17:31 +0800, Xi Ruoyao wrote:
> Older steppings of the Loongson-3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
> as only 2.5 GT/s, despite the upstream bus supporting speeds from
> 2.5 GT/s up to 16 GT/s.
> 
> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
> than one speed is supported"), bwctrl will be disabled if there's only
> one 2.5 GT/s value in vector `supported_speeds`.
> 
> [...]

Applied, thanks!

[1/1] PCI: loongson: Override PCIe bridge supported speeds for Loongson-3C6000 series
      commit: 72644ef266d2d7c679d1c8d8dd7ff5a7ab2171e9

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

