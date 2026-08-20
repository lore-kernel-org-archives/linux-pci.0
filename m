Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3F63DB632
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787214048; cv=none; b=ZPRRvASQq2tgVFMJ8oQAcQfejpyXFRgnA7Yb2F021pXy6TdA4dtqBYaLYtaSkbiv/8UkTsa9oW/DEVoz9BLICoSlIr19zx7185CXQSBtBBWrHh2HLCW/VXMCBHS3o0XCe3p3mwEkKwAXcLaVbogNYo0BKVVgKgNj+vAKFHJhMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787214048; c=relaxed/simple;
	bh=xCxFPtXy45FEI6pYYE4+dwqoDISdThee/RqkmTl3zYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSlSteLGWWjk7K+VTNnQdtzhe0oTPvVfzKMr7ceuNW/0U/yJjLxKQ1cmoqLn6B1LWTU+LbrzFuFT5kMunt3JPzsllHP26FsyBMc6ykA+XDr99R75L/D1cVq+wWfl975uCX68DncIdW/BvgUJY7reCJJmzMXYLqkZnOYEMnu9Lmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIn+A73y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HPZYj+P8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIn+A73y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HPZYj+P8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6eYqR2161122
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 08:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FBsANaWfVt7UvQv8Hq0kM8h2pttIyL4p7mQ
	X/jBZlrk=; b=DIn+A73yHuovO3Ar+yGLWFPJGfJoyWu1Y6ULt/C3ZBXBRB/A0PL
	odJDAlI7dG0A0OZI5Pkpm6+YV9EjQ5KLPLhVUvnw/BUPLHhgEGPwTfZhZuauzNbD
	wMN5NpGizP09LVB9AstlhI/FCtprVYQB9QYUvJTa0kVINAIpyR3UxTT/06AX5KEB
	+z/tDY+bUZssxqqGRfC+5mmwLmw9GVEyQukHknKXSdPTSoUpBMnNDpH0rUD3Qe4K
	Q7nxdLNbkqikhmGN0UBoFlklERabPHCrRO/R+7cZ9XbhqnRJffw8Yj0EJybWFzmf
	f1EwiUcfHvbvWjCXw/qrCFloVTc0LND+/aQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7rbk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 08:20:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e4f946461so210475485a.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787214044; x=1787818844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FBsANaWfVt7UvQv8Hq0kM8h2pttIyL4p7mQX/jBZlrk=;
        b=HPZYj+P8iFhWSQYikZKsl6DgD4CGlbeeMaZJC1RVuQFCPItKrOsz4ooHy76ROKnkXw
         myBgQLtYkoxM6R4kzhZnX6vzBR963FmrMrJuos2kK03bzlqESmhJKFOznzlck9QPfhS/
         d+/nHUhqdHIR3szjHMCOysKy3Ch5IOZBvIQ1n8oQ+l8WM8LNawFjRCp3FzpoEK8j3Lak
         ZUPuFCVGUx2+elfJgXi5OtLuxBy47GnylNU3Ch+rqtfZdueKoNSjYCf5ns34jbVn8tdZ
         8Rjs4SPCP9lvbddDRgAqnrALtsgqJt6jjxp/1NrttrF/PLvWpFaNbRyjH9EVZgMLw6bg
         mT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787214044; x=1787818844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBsANaWfVt7UvQv8Hq0kM8h2pttIyL4p7mQX/jBZlrk=;
        b=CT7BKWsfvyJZW4M8n0A74/vilJgQ1FYJ45phoGHV0NJ2csKrBq1XavUcYYbfRdBxwG
         YMtYo3+ky+9fMhrxGlFlRc9z0LyBRY3EhzFvIO7CUg1+lfbCq35ogmeh6qJqCPc2XmiO
         RfyUKd/dhr54ToYJGxDuerk88rB2itwjN4KldvkP3fJbeQUo/1dMUUiH6o441niW8WIv
         h/0zWB+rkBABGAHIPMdY1ZHhM6Tz0URKLGXEuvfwnrt5Rn/4p5w8JeWMuZgLcG82Osrz
         Wo23UfAtnhq1qXXs3el1lbymNhaCpqXa0icUjTDA0wvpLpp+WEX43HGik/AURhlVFvBs
         /4EA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4AgoJlt3YvXI2InjHtEZosZaHqe2n+RkBVKBeCCuLvBaE65CarHZ7eNjCxaN1C4Gt+f3AvvUwStM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3omPbcJoHZ/vNFiISrn9y8ydJIMhgmZNe2pl/BL4w1HX3BuGI
	4hqtJ3C/nHIuow3yBCgGMJ3cnTfJTIfVb3aux1xI2wpeLmTtS6F8kW6V6p0QbAxVO75tpLXH1Vb
	Rf0Q7d5uqWIrzCEbVsJr9GYcvW18a9+Ioq/UR7uYr03u9NNg2m2IQ4s7oIj5pv2w=
X-Gm-Gg: AR+sD10B7b6f/CSHXIAkalnwF5lXKRxHjUAxkWUHA36MTllI1eTVGwUKOg0qvdsQH/o
	f3S7lIIwNlytpja6rs0Xf2mnKw76exfOemtNWwz2SSrkuBXU+xrvK6CcMGNPXrZg3R7MgH6gE1U
	kbDFtQBOjY5u8u/RENkC3iAqXFCfvwdcLR/+wvOQOSrqry2vKkDNiIHLbymfLE2lPPC4o/w/+qr
	ZPMc1k5Y7Q1yjOH4XU2hPyOINr/UrvbxxzbcKhHcWj+vRDlDkjPl7GV3LVQpZnokyRH8ueme6+x
	TbVo5wBEg9EIeePolPNlX5np3pF6bIR2Ruu+p9nvF7ruPk0KExANXaGQWuYayZV0xpr8gIqiHxx
	yPex70hjazP85L2MagbTFwXnG7CnTnQ+p9cUNKvB8Eemzgss6HK4HomEXyezijW4F3AQWGUk+mj
	YMcBeJsif1Njzf98U=
X-Received: by 2002:a05:620a:408e:b0:930:f6f9:51ee with SMTP id af79cd13be357-9371e20513fmr976380785a.2.1787214044025;
        Thu, 20 Aug 2026 01:20:44 -0700 (PDT)
X-Received: by 2002:a05:620a:408e:b0:930:f6f9:51ee with SMTP id af79cd13be357-9371e20513fmr976377385a.2.1787214043640;
        Thu, 20 Aug 2026 01:20:43 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df465sm38760866b.48.2026.08.20.01.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:20:42 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G304 switches [12d8:b304]
Date: Thu, 20 Aug 2026 10:20:41 +0200
Message-ID: <20260820082041.13470-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1OSBTYWx0ZWRfX0awnpjKGKGV6
 0QpKPa580OQruZfPkGVB0IL9czXnH8b8Xd5nxLpBkwOq8S92DBbBqG79vk/kD3u5XypC/B429i4
 MzR0smJTpzP7D0I3nOF4eBLJD0J6LVexnk0xx5hA6V1j1Trdg3/gSyLBNEsmf8ltubckBbvSU3e
 iQP9Id92qUdad5mkZ74j3DtFoHdAeK/nxzhr+7wcob/vUTzFnwBBFp2o2Dr07j9o3pyNiHV2r1H
 ZpyMhzhf/C+au4dPwUYIkOC01sKHh16oruVvdGfvmmldh04FtjBgDKaXIWK54yN+9JpJOVbkZno
 qpR2dLUim49mAokaMkFuV83YdVan8qk80cDCDpI3GHy8yswflNYatMfLtro4Hwy7SJWlc/A5wAR
 9lqEdkPHKyU8uwG+RnbGkY5eIxRd3D4b971WuS5WvXFOL15KsmlwVshrG+PEUp+dQjYO59boZRJ
 BQ4lBWelE4N4ZF+rL2w==
X-Proofpoint-ORIG-GUID: -w_AFa4Hbg-6gfwgcedlzjF7BX-DDUJV
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a86b8dd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=Z-ruh6-9VsTc_D7kKl0A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1OSBTYWx0ZWRfX71GN/nMzJ8Hf
 eILA6YLDGXKs3nGUPbC99c+WABAGcDtcLcF0yEDoQiQ+Nkuo7IzukEvvDrma8EfH4Eg8dUMgqoE
 z2NcEE24v9pWx/PCTgWDsD7+ABko1r4=
X-Proofpoint-GUID: -w_AFa4Hbg-6gfwgcedlzjF7BX-DDUJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200059

According to the existing quirk the Pericom E5 errata for ACS P2P applies
to PI7C9X2G404, PI7C9X2G304 and PI7C9X2G303 models.

The Arduino Ventuno Q board has a PI7C9X2G304 switch (verified from chip
markings) with a product-id of 0xb304. Add 12d8:b304 to the existing
list of quirks for this erratum.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..1b4e15d744e8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6259,6 +6259,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
 			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb304,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb304,
+			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
-- 
2.55.0

