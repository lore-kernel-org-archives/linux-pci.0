Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6A3D301A
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754618; cv=none; b=pB/RAnTeKjwuMI5LlhkB0P6Dj+qv0bIe/cY0X10hp0IYcf4++GZyQeii0Mg/ADj80tUogBaIbGYe/ITkizBSI2vGUaqRUhAxOR6kfsvs6HXbaE1KDaFGtXc1Xy5GkxLQHyMh6OPX4ZQSkwjfIuDFUzqLXJ7jhmCDyQkCgRTxcTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754618; c=relaxed/simple;
	bh=OL1e5tPvFQWde+DcU1cgdp5okJRopejhQ2bazf/i6iQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ggJ2aOuY0CHrM2Zxg+wUR0S9hgiQ/PhTOU2zq5h1RDQWuc0n2GTiKEO81G9fd+mHl/+p4907PBuDS2lA5+O562Vio6NhxCGxISr5M1x9fFUfcEy4/e3/yy6vQwuQ0hYBMwgkEO1aOEabOw5J2btc7C9wYSaPncXEUzm2qieh2wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAqp7TtL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AouYNMVt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAqp7TtL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AouYNMVt"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639BcGvt4107774
	for <linux-pci@vger.kernel.org>; Thu, 9 Apr 2026 17:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xsecLaZ7/oDrXQvZN6cfDHd2xAZq/z3MKxUZtMtZdak=; b=RAqp7TtL3cJIlr87
	newUuC4kH0gD4QjQ+siiYLSILsler3FYPYLtQDIbCTDq80RRgcKBmOTNwaV+BGpn
	X2YHCCHpxNUK6URML2aPoU51R4sU+9GE82VVSDJTo2VKpcmUM/Dzpcz1u75Kdi9Y
	DjGLD2jAeJNznHjKFRrOLXxXEbOn3NYiynLiyNFSwcC/wyPfrWyfLYm6YeUkzbSZ
	ndWqvO6nfxXBsCgDfR/n2TuoCVetEVRHcqtwaDft1K6t1uBFXEi2wLaeC1/erSJS
	/v18aGL6jyyp2Gd1/B38h6R0vnSvmqs7cG2PABiUPg5kYMJqlEch/OGNLR7Ixj5k
	IvzCEw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddxhakymt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 17:10:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0f4e632caso18811215ad.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 10:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775754615; x=1776359415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsecLaZ7/oDrXQvZN6cfDHd2xAZq/z3MKxUZtMtZdak=;
        b=AouYNMVtt1zyLxTsPeSS2sTQLebAlCU5Z8JR2+ke3rm0sn4izrCPTzBUEPbC1kqaoj
         HhugsjDxnp8ZyfU97rm95WDRcxQcYnF1jzXf6Wrta8UDhsl/BkC/WwFvVzL2zEBrF8f5
         HuQcQD5Wyo36hbEysWCbGZ3srLOZ3XsVP6sSXSqFS+/18E0g9U6x/B/fbRV8/oGSjkJo
         4bLpL+WjUALWRREqNVMTmPwXGgw1dC3zqJ5nGjhGMvIPthMID07V3uxKh6G1a1eCIXOB
         83T5wYnTKfhwc+n+L2+X2n9dso0yM3tLE7Mx7hLtbrDztjf7+0vvBIZxzUErv8b31EKe
         nKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775754615; x=1776359415;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xsecLaZ7/oDrXQvZN6cfDHd2xAZq/z3MKxUZtMtZdak=;
        b=KcXbiJEOPvBn8Z0adlAyxyrxKmHyBRpuof7JxFLPLrQHZViW1MBhutgrVE/zE8Ad2F
         eIfmIsEDSrFBu8jtmHQV0ggA1Hi292kOGiz/kIO1h79FdI9hqKJ586vXpiX9bmlPgiDm
         4Wwlkurd1xKx7ZCX5WyCL+H86tZbQk8iemF76fb2ejgofBjJI+s/W8fhFfFvy4Q4jc0W
         cGDyTjksSjMIxhLUVCLAd1I7NKHrhvBCCZ9GR1BbPRHY+oemYMaSmxN6EgY5pxJa+XKG
         NJi79rTW+0Ya9zuLreZmuSiTNal1i2dKzqS7dQ4ahIJGg53nW1FCYsordkuxzsPsKYwB
         iyrg==
X-Gm-Message-State: AOJu0Ywxvaubcx4wZA92Ob63mB4pE+nMEGCiK30Co1SV8sF3SdxhSpMD
	9PnSJVFXWS1YQDD/aCtUOQgi4935G3plg+c/MeCAphwlJYITyJbLbj0hKhZN4Mex8dl4+0XTZuS
	CooaEtoVYCXEhuwPK20EGkjgBiRvA9XEtY1ZWG57+2ZQgBA2VkmugSfIqH4aA1EM=
X-Gm-Gg: AeBDieuUhihLVvVZJ/64FLGbLD64c7GXRikr8TVKQ52yuuRjZkf7cTjdcFvdxLx7E0e
	Fiqv6YmWuQLILUsAVJzH4ZZeaZrzhJtIi8IiH4a0JOmaBcWUS8IYeG159VxpEjicFRomucNDqnh
	3DNc8JC3EpOUf9aZoBo6N/fwV5u8d0iV3qO/SS9RvnvBWMU/p32YtZysbJFc9Ud8D8BQPd8cTPk
	DO5G3vVZiKNCAMmGj0tGo+I6gXWPXPPSlcRGYdTLkWNzyCivdnOeghtOz0P9CMY8ozJ/NOcFDEq
	DFGtytcKjM6qhB6L1z/rIfuYwWxE/pNv2hle3v/vNysyH2Ii7cNT1MHvx+XMP2q85HGb3QOZxfC
	kBLvjSvPtRufTIQ8RnG7J
X-Received: by 2002:a17:902:f611:b0:2b0:5cb4:d894 with SMTP id d9443c01a7336-2b28173fe0amr299412505ad.13.1775754615268;
        Thu, 09 Apr 2026 10:10:15 -0700 (PDT)
X-Received: by 2002:a17:902:f611:b0:2b0:5cb4:d894 with SMTP id d9443c01a7336-2b28173fe0amr299411845ad.13.1775754614666;
        Thu, 09 Apr 2026 10:10:14 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.53.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f0adbbsm732895ad.46.2026.04.09.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 10:10:13 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Hans Zhang <18255117159@163.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Manikandan K Pillai <mpillai@cadence.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>,
        Yao Zi <me@ziyao.cc>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260405154154.46829-1-me@ziyao.cc>
References: <20260405154154.46829-1-me@ziyao.cc>
Subject: Re: [PATCH v3 0/2] PCI/sg2042: Avoid L0s and L1 on Sophgo 2042
 PCIe Root Ports
Message-Id: <177575460884.106236.1760269557924720215.b4-ty@b4>
Date: Thu, 09 Apr 2026 22:40:08 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: uKH8zQviey7lWEmVMLyjZ1uwmSrqKwR_
X-Proofpoint-GUID: uKH8zQviey7lWEmVMLyjZ1uwmSrqKwR_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE1NyBTYWx0ZWRfX10LwT1j0WH26
 Egqe8c/XpFGF9rKOHCnZWu0jf+CRRpvV/FL/XV/tFykUI2KiQiWtzxRsXAzYDVUV8mT4wT/kS0E
 ATO8QlSZgutXsAKI+tcm7h3KZzEXj81LouNkt7yXr2q63B/7qDc4LWbY2u+W72d911BPfHHimFS
 kZ+PufB701zgOU31oI4G2M1kMT7aT0K1+aRt0JIZ/5NnCYlM2cx4VrE7tDOlYHmg+JeUeyLt8Qf
 tU+NaP2FBXOz7fnw2el3nuTEIHaEjQ4j+S4Cpc88KmvgyHKGy3PJoZZhgqda3CIrUqsy+Jy2b8+
 1KTYuei/jfFY9xYVQ9faW9nkrOd2C1F9snT7pF+KeTQq/ux/YEd8tp6/ExT5s4Ut6RT6nlvi4OR
 +6QhYv7OS12C4WEtiRymnxhNRc4+qIM3Z7DGrT5qWNmzhmarpfauGyZ96XVhShowjOEuvMO3jXe
 DYe/ZEXBMb2fz6/mLRg==
X-Authority-Analysis: v=2.4 cv=BefoFLt2 c=1 sm=1 tr=0 ts=69d7dd78 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Gf2Mh5FO6res/WGn55/Zaw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=r7UFEzjstGzoFFv7LMAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090157


On Sun, 05 Apr 2026 15:41:52 +0000, Yao Zi wrote:
> After talking to Inochi privately, I'll take the patch instead.
> 
> This series defines quirk flags for Cadence PCIe host driver to allow
> disabling advertisement of ASPM L0s/L1 states by overriding LNKCAP
> register, and set them in SG2042 PCIe driver since SG2042's
> implementation is broken.
> 
> [...]

Applied, thanks!

[1/2] PCI: cadence: Add flags for disabling ASPM support advertisement
      commit: 7336e9edaf19d6710b93cc1232270361a20891be
[2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe Root Ports
      commit: a4c1e32555ba488e163b88765de739c872da340f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

