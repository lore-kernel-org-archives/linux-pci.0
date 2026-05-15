Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F33B3C15;
	Fri, 15 May 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854993; cv=none; b=QZsmMcciUqDwJ83OFMLkX6wh0Qy/ytkW+54ouDWWY7iv7EEb6Y4Cy07mGfeBIYOBC5j9vc8yIT8AdHBtDN6oetjJLc63DKb+JYW7Pm8IsOuyM+SvdQRLIZGr1JbX8O9WABrJcxQTE1oyWReiCDyFXS158bNyrnn31K5bryxOP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854993; c=relaxed/simple;
	bh=GxB52n+bccQgWw1J7PtaLU/8C4d2aMZq34tOTChw92E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H+v8Q8/DiZsCRFX9ZQO7+KDwTZhFpOeWnaf3t0siPzyrN5F7kqQtDwrE3mJj3d3e/mdGXmYWYrxWcR4FJz4lrrdkwxbX4fOLi69+cJhmoVQ0mCjELA4pObwQqO6O0UyaF1t3FrNBO1yDCxldGYEuAppKubN7pc18CHrxDfN/9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jpe7yWrR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jpe7yWrR"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAe4wY4193977;
	Fri, 15 May 2026 14:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=hlkm53EkOwBFPaDIOKZBSELdA8nH
	YftS688xEuOoghU=; b=Jpe7yWrR8pmsxBAomkb7A8nSDqw87mI8kHQ7yDJe49Py
	VpBgiArLXfLuAHCzt1eS3bwAZcLv72q6thYXwsF8FygOLqT0r9EeuVHDMRjANeHv
	HfTRYVp+qEFfDQG13wEbLTb+ZywWOVWjffNt5Qz7YoiDwYFasG2iV0+fjfHc8E1b
	fXZHA90876Kk6UqjxzTIhg6Pj+9Cqit+wC3jY9ISzAazQOblJAV0XvjPUqXh5VpQ
	AeUpISsK9hfy8JPjD+fAhjoB99xqam5KPFbBN4NKylP5Hq5D9QIiD9j/ugdNrJqK
	V1EqiJ6d5P9EDtVCKJN5X+IEcuIUWrzZ5B904HhHSA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8y3f7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FE9aaL006591;
	Fri, 15 May 2026 14:22:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvckve3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 14:22:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FEMNDm17236336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 14:22:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71F5A2004B;
	Fri, 15 May 2026 14:22:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C71220043;
	Fri, 15 May 2026 14:22:22 +0000 (GMT)
Received: from [192.168.178.55] (unknown [9.87.148.246])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 14:22:22 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH 0/5] PCI: Finally make pci_root_buses private
Date: Fri, 15 May 2026 16:22:02 +0200
Message-Id: <20260515-priv_root_buses-v1-0-f8e393c57390@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAv1JytlArrl8REZeoudiSqAji3w0eZ
 2DmAUEmFGjMA4wXCYVdIU0MTNuwr2hpVgbvfOFyV9nIdPUcwtGPp6BY9RkuvijrYQatIuNC939
 su/f9ABjl6/xhAAAA
X-Change-ID: 20260508-priv_root_buses-0263ef2679ad
To: Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: BhW0i5iCtwRYcCsYhKF1TLTEACXv-Cab
X-Authority-Analysis: v=2.4 cv=RemgzVtv c=1 sm=1 tr=0 ts=6a072c24 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=3TEdfphp4t-7w4sqoLwA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: b_iyl63R7uRxWrlAjKplQflIOIoOa8Gj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE0MyBTYWx0ZWRfX5lRW9LSZwXbw
 5DmQmgWZLmEcf0d1PjSDDl0zFQGVRV8b0nwaU92OLakcli5f8x6KAN5xqitcTW0qp6aemQsBops
 a/S0t9NsynbCGPow9aQ/veAC86+piUom6Okaw345o4J3QFSEm5JuxK3K2HtXcdWGXf2eMqFXHsi
 HTbp+tlQ8jJGYnl5mMCErBUmHRKiLKA4TrsOItR0AB7JC1nqk2m9Ap18w47o+ah2v8wWEOSlQ37
 PjPwXqJrz+tcP02lT4vxAEYwcd76SDX0IuN1ldo+jamTwHSjWH4pwGRLerjAg+x3HUnNDF6bpW9
 RxsS0smz5JxyvL1NGw0wrmv9cuMY/8lmQc3mJ5Y/AqVxvEWbam86Iu58739vi6qBaVZT6h+82kS
 +cMPP+BrBtFbxrPzq3oJ/k8RUY1d4liuOb2Vf427Xjn8WQkSZDWUVotXBEiECzFmdlbdpBGG4CL
 9rlTXdY/YkTgDlm1UxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150143

Hi all!

The ominous warning about pci_root_buses in drivers/pci/probe.c caught
my attention. Looking closer, I found that there are uses in four
arch-specific files left before we can stop exposing that symbol outside
of drivers/pci.

Finish off the job that Yinghai Lu started in 2013 - see
https://msgid.link/1359265003-16166-23-git-send-email-yinghai@kernel.org/

The entire series has been compile-tested only - with defconfigs on
alpha, arm, powerpc, and x86.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Gerd Bayer (5):
      alpha/pci: Use official API to iterate over PCI buses
      arm/pci: Use official API to iterate over PCI buses
      powerpc/pci: Use official API to iterate over PCI buses
      x86/pci: Use official API to iterate over PCI buses
      PCI: Make pci_root_buses private to PCI core

 arch/alpha/kernel/pci.c          |  4 ++--
 arch/arm/kernel/bios32.c         |  4 ++--
 arch/powerpc/kernel/pci-common.c |  7 ++++---
 arch/powerpc/kernel/pci_64.c     |  4 ++--
 arch/x86/pci/i386.c              | 14 ++++++++------
 drivers/pci/pci.h                |  3 +++
 drivers/pci/probe.c              |  2 --
 include/linux/pci.h              |  4 ----
 8 files changed, 21 insertions(+), 21 deletions(-)
---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260508-priv_root_buses-0263ef2679ad

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>

