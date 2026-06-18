Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEFD3D8104
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770111; cv=none; b=SzUjn6nCCbtUMCdNzc8utrBD96/knd9FB4Cg5iB+JmCBeWUjldhiUtZet0rD5jOdP1LlKgmPzEaHpCoHZLHwsVzs6VkhpZ1fZF/L94lXUi93+XLtC5+WrFKf2SoHX/nEc6dKiF6TMQYS+DvFObHBHcbm4a8j8osbTZ+Pl269g9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770111; c=relaxed/simple;
	bh=d3kmsSFhoL/T6GWgXDVeaxbsnc//AKnWFet0s4rAODU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMQnFtp9+a7vA6AQVZNprV8NUsQA1oBQlCYBGM8iKCdV5zuwJMfhb3g35V7GvIoc1LHSXv23hWNjNWbaqqRU6ZW6gkI+BzWHiuPegzJiIBHB8RhjlesNTzLOs+1rjAqjIZTrGwHaOPpBLwxKqgBasTKDVrW2EO2wuJDnu9Mh02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q4Mk7XVZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jrXS5+c3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q4Mk7XVZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jrXS5+c3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I5gjKG3588672
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 08:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8YnjuolWJPPF01ovKYGXA9FNau+KmhkmxXT
	vFhIk0z8=; b=Q4Mk7XVZOfjOuPWOFqmti8pWgyXE9ypxDBeG7zFuIHApSN4Lvmt
	bWcMWBkcrJrdoxV4Zctb47AVciLdZuUyjVv309Ggw5VvitcDZkiJGfsbUGpSagup
	nArPwErt3QsNHNydgP1orJq4hkqm+56DTx4xWM9kmGTIXZuLIoHC1iqaghHmQzew
	2l+zgZrPNj4QT9fQFrCFZq+5b1KNjko5o2uhh7X9ftWeqBstwdoUCHpsw6Y1b3dk
	geg65aYU1eyUq/IpjSJwKp9Q/uX5Kx7pY7GvOLiCW3QQ/IhBnUDfDZjlbT9NL835
	T0jUgi9Y2u8CgG5IcD0c41pPQEdXer3fiKg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kjh7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 08:08:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d982d932aso747857a91.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781770108; x=1782374908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8YnjuolWJPPF01ovKYGXA9FNau+KmhkmxXTvFhIk0z8=;
        b=jrXS5+c3nsrZ3riPmWKOw3XXCIsDlThdH2rBSk7rdRYVE9Ccp6SYIS7ZXcuapb8qx/
         Qv64P3rhkZBnGxJqYtmr0mcXwQnIDHtI5l9PmFtH9B0fxN9azcssJcHYVFczAHRAxSms
         iKEQu2Dtoz4kjGlDrpqlcgFlH0Js/UhWL+AMbVsEy6FOMF+ZPCqHRsyX/K+3LPSdrhHh
         EJEkws8ym4Kx2nQhZ3w7v9L+qCfh1yUMaMjOgxA84FxPVFVQaKvWb+Dcs9iBEIrDqR18
         3gnpPIpJ+W7fyx3BJEOVxZc5ZkhDGiCqA87CA+FZVEvdp1MbNEgznvZMtbOIoMOYhzjT
         vXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781770108; x=1782374908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YnjuolWJPPF01ovKYGXA9FNau+KmhkmxXTvFhIk0z8=;
        b=LhD3aRSbmPOcS2ZuFJoQcwzJFpePRzshzZ72YswdzdyyhDC9OlOlp8EX6/1S9U6/Uz
         EfNwmnsmknQq/nooqNN5LkMaBQA2P03Oc/J6acbbaZLiH1edjEp6C2qspd3Gn6RV8Gyy
         mOS0mFoy5bvKt3lPH9GPd1+7v5qqpPUT4IrjHYWxHiphbrVbuGdVQKTuRvR7RMuU8dHn
         sLRsBg7WPp0B1akLH8Z0IATvmrhyk82isiSnru28Wr/9U4jMXofiq5qLSR7JY2ci+2i5
         y8QvFVG8p73HGenp9kvwaxXJpsXlhiqnLlI72SZh2dFjA4rYQoMdPGFh/PW0UP0pbCWg
         dPoA==
X-Gm-Message-State: AOJu0YxIwqIIgqH0o2jm/WRV0Xts8XyBXxDn7cAr9AE3O4XRd3NniAxM
	t9SmWDUq6xkRjCeJP4KHLGP3UvoCgUjfH8OKHoYe9RoXZGvCVZ75ezvXPntinbAkprMlBSf45DI
	o+GqS8YoIunDt292SvkcmL6ox9r4v3rxSb9sI7yyoJWA7ea6sMoOReMJ26PuOX1aQejyO1JA=
X-Gm-Gg: AfdE7cn0d0P5fq8xwdftateP2DiaZXVDprx7a5H6BNJ2fwQL1ws3l3mO8mkgvVUrnL3
	mYM9kCzGRXyNabd8QKIfhb9ZA0XvBn1br2FlLLqfVztjopknLBwjS/dfayzkPCoeqvBN3H56qo0
	6tx2M3WLmkkPa4ykk5/Xx+HBlY7YLye95ruzdpWohy26pwHCCIBhyaBF5sX/OWWvFjEVnEo33GJ
	PEcFy3chuZzL4Fsqm0gYmutFlEAI6uCVg5iA0C0Rt9yyiuGr0LcFOvItdRQIRyPBAKjp1DYkJoF
	ce4q5AOsyKW1thq1/1s5TSyAm6cYCJ9+K2DZ3u5HcXGBwiPbxRYII+lS7VGZx2zUiMeKP2/elAK
	MvCsPKsOxXg/5yNkLIMSP+Wm0A7rLY1bhKlZo/EEUbJdrS1F12tkHekmv/Amt
X-Received: by 2002:a17:90b:3c51:b0:366:1172:597e with SMTP id 98e67ed59e1d1-37c9ddbd2c3mr7122624a91.9.1781770108168;
        Thu, 18 Jun 2026 01:08:28 -0700 (PDT)
X-Received: by 2002:a17:90b:3c51:b0:366:1172:597e with SMTP id 98e67ed59e1d1-37c9ddbd2c3mr7122580a91.9.1781770107640;
        Thu, 18 Jun 2026 01:08:27 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.56.194.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a47f8sm178325575ad.47.2026.06.18.01.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 01:08:27 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mitran Karthikeyan <kmitran@axiado.com>
Subject: [PATCH] MAINTAINERS: Drop Karthikeyan Mitran from MOBIVEIL PCIE entry
Date: Thu, 18 Jun 2026 10:08:11 +0200
Message-ID: <20260618080811.26337-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA3NCBTYWx0ZWRfXzkvFfIFu9w1O
 1vFkPCC+R4UEpJ0FcUhdqsCK57MYQaQpQI1ZwF2kvISN1WhzuHVNZYHSBOCU5PghMz6I8qYeCTN
 4g831vkMw7719qBqP+jh8TAVaoWy9wEjYHgatCTKTm62VRnaApJjK3yCLThjY9nQMwdG4kejDgL
 lnHq2QKzive21MWgZPg5MTQjQyluAvah+n/twRhG9nPgJKganSRuFwVmonM1Vs2rFqwV2xcODBY
 tRTD5hdDTntiAg00qzWAHtTFlbvL29xP+NP2PADZGJUAtxFf3kZdx9SRZMfFRosSDrjfN9x+YCu
 +5Qib0kz8trUGLyHhDJcC2Xv9JEYVlwSOahiiv7ZE2sj9t+r7Xo3vuG2zQnjvtByKrg2dmYp7SH
 /S+JCIVxMCqLECTh5MRgDrvEViD/bDsviw0z7pUyhTW2JpxLzEw69FRLCiRg0FXsoH7uw8xBCJc
 DIWE85A2vbUOInYWRPg==
X-Proofpoint-GUID: 5Bym2Bb-LqpVM1IIzuM2UdRLFZ2TMh6d
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33a77d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=aEtE6H6eu/OUtvW7cy3Qsg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=440cDlBIAAAA:8 a=EUspDBNiAAAA:8 a=y42tSk0uAAAA:8 a=8AirrxEcAAAA:8
 a=TgZ4Mh5Td6Xgp1e-BA8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d9D1X1bx8dWolqnE4HNT:22
 a=cv7W0dtPmLjOYCONSk_5:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: 5Bym2Bb-LqpVM1IIzuM2UdRLFZ2TMh6d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA3NCBTYWx0ZWRfX3uHQx8FGgNWC
 nTjxz4vZoPRCkfWFq/PAbsJLQF6U47FZ/BYsMbsmJHH658D+JmKIe7Uu1VrU0rNg/BUfcPa91ci
 xvkWFTvfJCzCa9mjZEXlntjjPt5Vtfw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180074

Karthikeyan's Mobiveil email address is now bouncing and there is no sign
of him [1] willing to carry out maintainership duties for this driver. So
drop him from the MAINTAINERS entry for MOBIVEIL PCIE.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Mitran Karthikeyan <kmitran@axiado.com>
Link: https://lore.kernel.org/linux-pci/ahWB7yRchlW_KjEm@wunner.de
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d79275c6..f58ca3ebbe0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20438,7 +20438,6 @@ F:	include/linux/switchtec.h
 F:	include/uapi/linux/switchtec_ioctl.h
 
 PCI DRIVER FOR MOBIVEIL PCIE IP
-M:	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-- 
2.43.0

