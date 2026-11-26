Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670247;
	b=g7x4YPzr0TB85ODuj+yiX8RfpklB/h8Bgykg52QYpI97K7cY7qtTVPp7udC9GDLSzkub
	 ZpWY9H7GdjX4qcYOHNfz8vUhfoQPmdwFkOSlyLC2gZ+te85a/nt/N+Sbh5/TNlcjAaZol
	 ddC4mUZ3cxlNUonjmEeVU7ZlLn/AVjG3GDuAY/yk/3FcggEbbQK4FJMN29u43lvGN4qXa
	 2PDbhzeflafIKf2H18662F1pegLGFj8lzKB0SPHDpROxGym9S411G8WpADfGb0jXQ9g07
	 FDxek78zI4Cd4BVGiSdpMXmaVOCQ9VnQCA9r3Y/uIpEXMMwJr/1lfhk7p32h0DZ91gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670247;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v7SZC9zJJd5Z+k+XKqU0PQUi4gNV89FyWD6yXGlbEqw=;
	b=bIQ0kF4kT0NOD6bGxh3Cs5Xk/lW6WCp8X7/ciicazkujWHZk1VJtYoWl0/6JIGE/EMoS
	 OeqigbISnigq7Hp522W1zAPM7+Z3Rp5YzkbnAum7Ole8nXineJf3QP/1PL8nOJYcOh35q
	 FRc8gVnbDrDcb7UectfgTQ8uYVUAwm0yjd9npk+AckstGaPj8Hw5Pp+/7pm+z4SATCL5H
	 +zyQuSsh9G5QHBgnckyat0p8Yjr0pcKNN+0upGmrOeDNBQOnkmqtyxhYnLGvcE9FtFI46
	 LSCSYviZHSQqPoLazIU+0PmY9kzMvSkj0BWRirDetX3pEcUprsbA8IDWkgZoMVEmyig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mqTINcSo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eDhGKTg+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BC606A321
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92BC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mqTINcSo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eDhGKTg+
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36R1q1686572
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v7SZC9zJJd5Z+k+XKqU0PQUi4gNV89FyWD6yXGlbEqw=; b=mqTINcSoBgaAg6xi
	opheCea+AQwN6rldH6rMOaf7b71LBJqjErTN9qHdCg3Kk2CgWBhUAxWvcm/4xjpt
	q1D3bvFL4p4oehx8G6ZWtijAzrs4xYYm0k4fOp42bu9NqaE4mUhHzz3JEXUx+e69
	Nf70EW9qnGaNKRi4HM9B+01+cDeAC4a5HaEaD0Kc2VcMSRzWdyCcYJU46sUQM9a0
	XsznMEO9Xu4KMJbMw3byfUdflPxYLv/beMsJ6rW37XZMRMuEFYPWZKmD5djr4Zkt
	VnjEjPOgNSOfKSC76TuBlJpBCc83GDQtslFVAXng+ZnN0FT7ZBKfP30jsXPIOlhw
	xTTArA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qf9c8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:25 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b592e9841bso258327c88.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 21:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795670245; x=1796275045; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7SZC9zJJd5Z+k+XKqU0PQUi4gNV89FyWD6yXGlbEqw=;
        b=eDhGKTg+Lr99zwFn7YY7VESj1n9kxEhZcjR2torV02odGKZjhBMz6axGxQ2QtYYqyA
         f8FZwI7X4dBTz5VxiXMGZR6Pm54Qel6Rfoe2gqW64DMA70OvaMNSFr5A+k8lHPG0kMV6
         bKvOaQ2oEzGA/edUQ9hAhNbOrEQlAhYQ+rZIYFDo0i6GSIP9t2C44jvSLT+gPPZI17Su
         6RwfHp+MfJweMmLVv+S7wIfxMf86Dr9y3LVrLa0cxG9wyy2sWRpLM0es9EitE8X7hbwg
         6hXjon1rHJzq2eb3ohFAUzy+jfbQonJwZAfR7uaFIVFSuIwLTDOpq+2wC/UF85pA/STx
         bShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670245; x=1796275045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v7SZC9zJJd5Z+k+XKqU0PQUi4gNV89FyWD6yXGlbEqw=;
        b=pj1p3VvQ+i8C9jokr2BYsvL6Yq6S1FYdW/oDeMe8GEvhoUb8Nlalxld6TnZ4b9h+4R
         9iLF0bpe5cO98j1qsGn32iXjokREMy4B8zxfv3gWhy8qgrPmATkmw1GUoNsJ6GV9J5k4
         CTSn67vHVwAuXiuL42P9Zokzrt1ZH52SiJ5zbv7VWiXVkcmDKDkXP8b2qPT5Dhfv0d7i
         CUQ+gQeymrWkdK3BxyGUViqteQYT1jCQz+WAzGkmG58tOSTHW+h6dAvcfds07fF/Yt6e
         dTszE1hltj7aVCXqpOqFDU/M87GmwOlIYEsjDa1mfa28+zHwrKmWxLes5oc9YOMVegSl
         YhnQ==
X-Forwarded-Encrypted: i=1; AL+hErHw2lyEgVAQBm1D5IUASptTtfkBq8mXEMC6KBid3Fmh7VVcDvx61cr6+kY86ojM2/a1eUats9XwbQY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3D5uiADcGrjI5jaVaYg9vQAqfck8sU4RI4FUZ3/yo01IRwg2Y
	x+6kryq+I9ApKQ8KH1GTU2UTfxLk9IUHgpW/P52rzHQXg8tlO15jw8jRXoJJyX7I5x5OzBETG6I
	DcPWTmf7eYpBM0zV041Idtbtg629gIkDqG51tCo9jJ4w+KRXDNlXapeJcthfPBcc=
X-Gm-Gg: AZFdTZdbwifgillxYELb91kS+e/FJYSzJ9zq/fZZKt0qHnvQfxX2vr9NheXwafLbjje
	xjqydyaM1l4uUCOjAda+dWTFoPoFjKFkZW05pd+rKdULCsiekAw32700QBJXMm0NX4nyQucsJPR
	Xn5NIHiX4lcgfq4RyxCI2/QTUx2RzUU/qPG3JuV5RcR9DLzEIZIyQtmiB/X0RzVNbs49VivBMHT
	Zw251tmEBGwkqESB9Xlob52/6xAsENU0ESP6xVEzHin+xHfC/hiU+KXHwJKyk65/knI8voGVMvi
	frf2opWymoDiTSEcV8Tex+TSEf4EyQe5jGNC+6ZGQ4JhP65duEM4iddE7UvU/NlZPlLdVV5zGYA
	RFMCh23qSgKFCq/wndGI7VlmECVMd7OGRwItXOd0HTIQI7urMOPN56ALTFXkYMRWW23V6hfp7ri
	/xfpoHP3WC
X-Received: by 2002:a05:7022:1103:b0:1b3:b3de:9232 with SMTP id a92af1059eb24-1b5568a15aamr17512712c88.9.1795670244468;
        Wed, 25 Nov 2026 21:17:24 -0800 (PST)
X-Received: by 2002:a05:7022:1103:b0:1b3:b3de:9232 with SMTP id a92af1059eb24-1b5568a15aamr17512680c88.9.1795670243786;
        Wed, 25 Nov 2026 21:17:23 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm52132934c88.13.2026.11.25.21.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:17:23 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:47:00 +0530
Subject: [PATCH v10 2/4] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-shutdown-v10-2-fed60d9687f2@oss.qualcomm.com>
References: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
In-Reply-To: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795670232; l=8831;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=qbU4YfdzhryKir93LpnQ4Mk3Fg91dCUd9XMJWJuZ9eQ=;
 b=g74Fcj6teXiqcYjkhpsMCh8kgAPp3WNncjt9WQ+K9uzf5c1+5aKIb/1VDwmHngYztgeKbnMQY
 LJRCEzCMrB+Cp2pTzGXAPxE4CmC5o/hUbc1xNa6G0job2fBD4gxKv4N
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 9pbZi72-m_kovNN_5ndBa8DG3Oj7eK05
X-Proofpoint-GUID: 9pbZi72-m_kovNN_5ndBa8DG3Oj7eK05
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfXx6wzXjGcR0dv
 2bw5EugR3tlgAd59OG+bt2y4SeDtgZG/bDcoKKXMDN9eMwZNWLUfGzc6GFlKhGdPiuloxYSROP4
 9OzP5o/Sv4nDwDJLNE5HyxZ0uKnRneQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfXxnqBkc6qwAFz
 x6UxcSbosmO9/AUDrPFUWg6RY73tIl0pp1fxrd1QhTukZT8SXS97lveXoXya451fjwbwbkLD4re
 dq0dZLg0+wxeam82m1fTefykmiCoRWpUn3RXwos6X8fHFSBabQAyd/nA+7Nb/C4EGnv1318w0ll
 xvzyumyfBxpueshp7uYwGexoHGAnkFevjKRpR49R7bNitlhPdyZJ4Y2WIgoHPyTz6VA+MrneDsd
 zfJksQSNrYBu4A4EZVIZobZIH87nerxYaZcXCulDHqXhjrgtrYPgIx23TsesyBg9oG45uhrvYYC
 v6fFsbJLz1FSCTSbLgtcMyaCDo8b+5SL9vHHEA/IB62r37VONEY2L84RIQvZBl7oZfc2NKOgYF4
 JeccwWpDdbpkKf1XPoqSPKYcLcebBZhJP5te8UeimD5QqVnx8dN8kBuzNqOHI61LQcpaHxMwwFW
 H5/Sy+I9N0qTaPZJHOg==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b07c0e5 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-MHXjDPJGaOMKVajueQA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260019

dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
to check whether every downstream endpoint can be put into D3cold before
bothering to move the link to L2. If no endpoint supports it, the
function returns early and leaves the link up.

Querying D3cold support during shutdown is actively harmful, not just
slow: pci_host_common_d3cold_possible() requires every active endpoint
to already be in PCI_D3hot, and returns false otherwise. If any endpoint
is still in D0 -- which is common, since endpoint drivers aren't
guaranteed to have suspended by the time the host's shutdown path runs
the check fails and dw_pcie_suspend_noirq() returns early without ever
moving the link to L2, leaving it up right up to the point where the
system cuts power/clocks to the controller.

Add a force parameter to dw_pcie_suspend_noirq() that callers set
explicitly to force this behavior, still call
pci_host_common_d3cold_possible() unconditionally, since it's also how
pme_capable gets set, but ignore its return value and force L2 entry
regardless when force is set.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pci-imx6.c             | 2 +-
 drivers/pci/controller/dwc/pci-layerscape.c       | 2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++-----
 drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c     | 2 +-
 drivers/pci/controller/dwc/pcie-eswin.c           | 2 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c        | 2 +-
 drivers/pci/controller/dwc/pcie-qcom.c            | 2 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 2 +-
 drivers/pci/controller/dwc/pcie-stm32.c           | 2 +-
 drivers/pci/controller/dwc/pcie-ultrarisc.c       | 2 +-
 11 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 865438ffde87..5a410e89534f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1788,7 +1788,7 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		imx_pcie_assert_perst(imx_pcie, true);
 		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
 	} else {
-		return dw_pcie_suspend_noirq(imx_pcie->pci);
+		return dw_pcie_suspend_noirq(imx_pcie->pci, false);
 	}
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 7c9fb3bef682..8481fe5a0bf0 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -370,7 +370,7 @@ static int ls_pcie_suspend_noirq(struct device *dev)
 	if (!pcie->drvdata->pm_support)
 		return 0;
 
-	return dw_pcie_suspend_noirq(pcie->pci);
+	return dw_pcie_suspend_noirq(pcie->pci, false);
 }
 
 static int ls_pcie_resume_noirq(struct device *dev)
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ab343ed53ba5..0837bb9e67e0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1229,23 +1229,22 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	return 0;
 }
 
-int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force)
 {
-	bool d3cold, pme_capable = false;
+	bool d3cold_possible, pme_capable = false;
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
-
 	/*
 	 * Enter L2 if D3cold is possible, or if the platform loses RC power
 	 * during suspend (in which case L2 entry is required to notify
 	 * endpoints before power loss, regardless of D3cold support).
 	 */
-	if (!d3cold && !pci->pp.suspend_poweroff)
+	d3cold_possible = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
+	if (!d3cold_possible && !force && !pci->pp.suspend_poweroff)
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0ece9c433229..f774fc6d2a24 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -902,7 +902,7 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm);
 
 #ifdef CONFIG_PCIE_DW_HOST
-int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
 void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
@@ -915,7 +915,7 @@ int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
 #else
-static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force)
 {
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1ce5f700b9cd..10c508f96ec5 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -1047,7 +1047,7 @@ static int rockchip_pcie_suspend(struct device *dev)
 	if (rockchip->data->mode == DW_PCIE_EP_TYPE)
 		return 0;
 
-	ret = dw_pcie_suspend_noirq(pci);
+	ret = dw_pcie_suspend_noirq(pci, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index d08277e8cc69..04fe45e137b9 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -367,7 +367,7 @@ static int eswin_pcie_suspend_noirq(struct device *dev)
 {
 	struct eswin_pcie *pcie = dev_get_drvdata(dev);
 
-	return dw_pcie_suspend_noirq(&pcie->pci);
+	return dw_pcie_suspend_noirq(&pcie->pci, false);
 }
 
 static int eswin_pcie_resume_noirq(struct device *dev)
diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
index 386e44dd0477..cb9cc9327d85 100644
--- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -365,7 +365,7 @@ static int s32g_pcie_suspend_noirq(struct device *dev)
 	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
 	struct dw_pcie *pci = &s32g_pp->pci;
 
-	return dw_pcie_suspend_noirq(pci);
+	return dw_pcie_suspend_noirq(pci, false);
 }
 
 static int s32g_pcie_resume_noirq(struct device *dev)
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a6a0e3ecd921..532779295734 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2480,7 +2480,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	if (!pcie)
 		return 0;
 
-	ret = dw_pcie_suspend_noirq(pcie->pci);
+	ret = dw_pcie_suspend_noirq(pcie->pci, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index ba8e6b297674..e3807da316c8 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -1071,7 +1071,7 @@ static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
 	if (rcar->drvdata->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
-	return dw_pcie_suspend_noirq(&rcar->dw);
+	return dw_pcie_suspend_noirq(&rcar->dw, false);
 }
 
 static int rcar_gen4_pcie_resume_noirq(struct device *dev)
diff --git a/drivers/pci/controller/dwc/pcie-stm32.c b/drivers/pci/controller/dwc/pcie-stm32.c
index 349618ea5b9c..7b3a8c1b04a4 100644
--- a/drivers/pci/controller/dwc/pcie-stm32.c
+++ b/drivers/pci/controller/dwc/pcie-stm32.c
@@ -78,7 +78,7 @@ static int stm32_pcie_suspend_noirq(struct device *dev)
 	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
 	int ret;
 
-	ret = dw_pcie_suspend_noirq(&stm32_pcie->pci);
+	ret = dw_pcie_suspend_noirq(&stm32_pcie->pci, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
index 514e08a12b5a..8cf8b81a0de1 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -187,7 +187,7 @@ static int ultrarisc_pcie_suspend_noirq(struct device *dev)
 	if (pci->suspended)
 		return 0;
 
-	ret = dw_pcie_suspend_noirq(pci);
+	ret = dw_pcie_suspend_noirq(pci, false);
 	if (ret)
 		return ret;
 

-- 
2.34.1

