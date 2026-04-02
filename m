Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1C63EC2C2
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149093; cv=none; b=VEldfQSFbkGFHgpRDdOf4wer4Tsw7tuC2Q2g50kbfw/dZZXcN9rQjN+nKPy2C57pWeJWsp2LoYSUq5Vm5T3/SdXeZBsCfT5exv435ot8gMQGYtRbPVGc9v/eLWpXPdLDBQhjkfxhoBDE4tRI4pSl9Gb18wZy4ih/JNCm53foSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149093; c=relaxed/simple;
	bh=iVO6CClRzCDCdn9sT/whLwtwO1UaSpLvldz8M7JrZ60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E5Um9UAh2NTarWlAFc79+QKne1aDoN7rYZPAs/Dg5hMZCkX05mbzSZjvC+ywsGeN9BzzN7Yt6DOiWomWg34Gq9b2kKYTD9rvMu+arj0t+T932J4HlrqMpKjgslbrmPldSobwmjY07C4Z6CaNLfs3DIo8+bjJ7f4K7MpkH+R2YBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bf26WH+/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IcTyj9ba; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bf26WH+/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IcTyj9ba"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632G4Skf2255005
	for <linux-pci@vger.kernel.org>; Thu, 2 Apr 2026 16:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hFJkuoa7ytoLT1UO6Pac5qwA/yzIHHAaZ9JrTM5bhGc=; b=Bf26WH+/dBfUSx3V
	tP2v+J4ciOrokkWLfCXaLAhUJJLbLcXurHv0PNuPz4p3/qhtOi2ycFQCI4OIZPIn
	AmXTTvMY57lGOJr1x6jVC6sU19Dtp1+jV5HbGgtKthH6gECVzjwjqJM25/r9VP/P
	JEIYvnTvC4E6b+G36a2rzMChKKNo1Ugrgh5FF+sIw2D7eoUO0wunrsLoL9WGfPFW
	D4QiquEpKupq/dKcoh0Iva+/il+iRmFvvNlNjBkcMMwYKejhLtkiqXW8NvYv58Oc
	ZiYrp0fhJTwcFR1VCPb80v19P//GghsHJpK8+sS6qKzyr/k7EdJf9x0Hq/2nBmqv
	hs5Ywg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t1yb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 16:58:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c7691378914so488787a12.0
        for <linux-pci@vger.kernel.org>; Thu, 02 Apr 2026 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775149086; x=1775753886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFJkuoa7ytoLT1UO6Pac5qwA/yzIHHAaZ9JrTM5bhGc=;
        b=IcTyj9baAD1Uqqds/Uhs/qxwoXUsUMurymsnrD/zNlQOh6CNMUz5/SupU6ExF4ATfQ
         D0D9K5eHzUw60rMRM6Ufc7/5t5fT7LmknhzqGlEnV0CXpRyujnIafE8h/OR573PmQ5re
         0Qy8AugJJydCf6SHRcvzCfpy2b/0l14u1SGaoSbECdT8+r/rsoprxhdFjghq31uTVOfF
         uHwAhZTtMMqcSVvVzVbJJvJixXLR3Mwm3KzJoeXeE3FUDcibAC1hTVIGAPoipWBwfoVm
         c+07cWFg/5EAdyjwtfj8SglRH6e5wbJMnUVmhX3uIf9O3e4PsckY518kslQxF3jLsQQd
         m3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149086; x=1775753886;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFJkuoa7ytoLT1UO6Pac5qwA/yzIHHAaZ9JrTM5bhGc=;
        b=spn5sl4LsNRUcgLiNYo7CGDfhbu/aVkyXSxxV57afNiHXQF9ln4X8nOqo3Nb1D7Kgp
         z40BGS+GRZHQ9hzWDgPcrT/OTrahWIcppzH04faEtamPo5os2wyfG7fPywaym1wkBGbd
         K9hdenQGwrGajoEwmEqqUvPNIBe3glyx8oq1Q7cwi1yunAKrFMkEUu96IB4ZwS1LulMq
         sh4QNhNU5j6ljNw+429vDV5J1U9rVwMAoIPGJ/9nZdK2hd8tNt66lNSgcCgev4Z9N2C2
         qZYEtQ8Zb4nZJoW8D0qGOgMpBiplSzCiUVjFEOws0mm/6fpO8NDCwDNlYEQisRFneD2M
         OiFg==
X-Gm-Message-State: AOJu0Yx4+EvcY9teTnHngxS+3Y0HqlVpXVdVj5e+cShkrQWjxsgF+HB9
	ykPetUAYW47lT4HdQ8x12ZMgeEP6BW2H4pWnvnkpI0S8gHEvYCzVuX9CQeni8bigLM+AfIx3JHl
	f4lB43xbfCw0IUEu4VDK7zkvc3q1CveGgE8o/McTBAlzNklamoI6KswuJoZ/iOq4=
X-Gm-Gg: ATEYQzzI0SYwmnrhlZxUe7cxqrEMHQ6l3EP4LASO3Uguy1/C/M5kiSWcP5AHZ7K0dph
	62EwcqIm1qNS2LWzntdzGZ/UeEXihTk7VuyeJu0PeWoSXEmphmiV8O2dgcekp+pvx3+if8tprQn
	yWMvmxkNVE62LH6BbTDADlwnRBSJrMF93vc6Y+XXd7aZ1qx+SIHMkfYYnDCvjY2tBGVul0FJRhS
	dcR6XCQgqcmqJolmunLCI6P+uVEfDHxEPRGsChq2hB2bDdTrY4tQAIpG+8HnQomR/Z9hSzXPRWd
	rIWZ62jNOwyAu4EeeWRrU+T3CyR0RGWRuaHg0tdBdZ4LuuDHPmXvXXjbR69CVm3uMaArDeAugn9
	dqVhePq8uWCkfV54bzT4=
X-Received: by 2002:a05:6a20:7288:b0:39b:d5f1:4ff with SMTP id adf61e73a8af0-39ef73de98bmr9045347637.20.1775149086035;
        Thu, 02 Apr 2026 09:58:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:7288:b0:39b:d5f1:4ff with SMTP id adf61e73a8af0-39ef73de98bmr9045314637.20.1775149085388;
        Thu, 02 Apr 2026 09:58:05 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.79.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65a3f08sm3262932a12.31.2026.04.02.09.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:58:04 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
References: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3] PCI: imx6: Don't remove MSI capability for
 i.MX7D/i.MX8M
Message-Id: <177514907977.11779.10857136002766145178.b4-ty@b4>
Date: Thu, 02 Apr 2026 22:27:59 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: d69cN3G0XzPqb5ObbwQQEyqa7QOxCwic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE1MCBTYWx0ZWRfXyT3G0t5e2SmQ
 uGPWaKbY68l6nLRPJDj0KL0ObT+zcP1/wVhjSjBzyl1v+KR3G+9VYYJT9vFUFz2OBBJ7f7rQrkB
 deeyNqRWAp0uFNWfOSfJ+DODIzjQzQ7xKp7nFoM+3+iQGH7F1ifmQxOcx9rYt2gkAwu/Xmo2YEF
 Yt+UyUzrKinhTDERtVQW0kh/DD+/J1lHlzy9OHh+Cd+ZPCJ1sQFkqy2S7i6CdyCV3kLZqdh3AEn
 1sz+9pcgSOgzjMhtwxJLiXcSxDgn2hnzxxciDi8Zawotfqj7MWTu4clsoT09I9EovpBvu8OvHKf
 OU/RiOC+Mvwz3NqoszcbaZukhSAyMEo8C8r2yjASQT1QKp6zLjCeUqWqnn2fRLhGoJenWLH/WoZ
 SHqO02Z5LB5KXNIylkWLKL433/a6eayetI9PGeM7noflztwGv1v7/UFLtE/bQXJHjEbam/XDkxV
 Av8IhrOTbb0Xk96KxMw==
X-Proofpoint-GUID: d69cN3G0XzPqb5ObbwQQEyqa7QOxCwic
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69cea01e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=+KsUAYeLG1mN9JXONzlAbw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=kxgfuGgQFWlVBPJi97AA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020150


On Tue, 31 Mar 2026 16:52:52 +0800, Richard Zhu wrote:
> The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> capability register settings in the root complex. Removing the MSI
> capability breaks MSI functionality for these endpoints.
> 
> Add keep_rp_msi_en flag to indicate platforms (i.MX7D, i.MX8MM, i.MX8MQ)
> that should preserve the MSI capability during initialization.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Don't remove MSI capability for i.MX7D/i.MX8M
      commit: a9de12c04779729f6d404192a5320c2e4dac0968

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

