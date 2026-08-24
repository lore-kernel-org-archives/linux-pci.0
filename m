Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AB23B2FE4
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549718; cv=none; b=Qwu7dGTKiJybBy/59YPM3edOpuGS3SMqwpEhIDV2O7JXTi5fnlkt3XyQsNaZDL7A/LxtTBlzeAmuFI1Os7uQrnRMLqKQMZyRsYb5ztlrtqp0diLSKUmpMDRZRt2L7xuY0MdaChVws3s2KCog2m/nsT0KtgM5k2lgoyqrXOZBfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549718; c=relaxed/simple;
	bh=i18DXA1UuvFFxlInAjMEmK2CjnCD979tKCem1E4xy6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EV3NcE4kATo7N4KE1A4ec9YFVahHTdBv93HRw9P7lGZYFZ37nAR0ncm2t3Sv84qwGdRqeIuk258Yj12sCWiB5WOO1xeYkT2cVNMXNuZ5IS3ZmgveKKr/V+Rzu06dU5pdmTThIzzwAY/xp3l6rfz1+1wch7fH/BO4oPZK9/Voje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DmIdoIZv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZT867f8+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DmIdoIZv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZT867f8+"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5R8hY2058144
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tsfm3B2VKYEmQm7+WBrIBL7ccJpws7BXCiuSJtGpd8g=; b=DmIdoIZvetS5t4QR
	P9MduT6G7urPR0JuhgcuxNIUuzrRRr8RGhpkqqWMz409U+4T/47HHL4HLhDUy0pC
	3zk26oXRYFrPcFKJljSkx/OS8+6x/7vtL1XlkrrPe9s5RbuVbkzcTYSjB63KHVeY
	diF7uHyku+pSjwxVSb0xgbkivysCrdlejaV5jFxfsxUfwRVT/IuiTfz+mostGBKP
	pYg/ww+GEgTeYoMxJuFYyiZ4zzP9dBpkVVKCK0uCm71o7mQHSvFvOF7EMlcDEqEw
	xkWU6gQhpPFwtI3ZzToqfbwMnguzN0091S4uYpGl84cwAKI6oicJzKp73u8DRNTn
	gDySqg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr0q9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 05:35:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso4401023a91.1
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787549712; x=1788154512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsfm3B2VKYEmQm7+WBrIBL7ccJpws7BXCiuSJtGpd8g=;
        b=ZT867f8+skwwLb6AtWZFGdOsAgBctSnDJjoqlzQFN24+HkIuNErFV2PUTii8yyniJr
         jz5lHPV8znMnzVXWmcOtmz/BwjHduw0RHPh0I25nHXWwYGegGaO9nMr5Ii862R2WrjC3
         Qw9uKv9o6SA/DL0cBrvfIQar9btvEEwhoVhjci68GxPUxvicm8VaFGvsQJs15gbn89Sv
         7xhe20+Eaw+7qPmXv3fhyrgOslXH06nKjrlG8hoOEKRAixpNuNfIfpK8BdlJa1vddjN3
         2RtrPUIfg3oaBVWFdyplGbztq2gghUqrtHXsIVUERTNG80mqoFoiGnnTyp4vBd/QbXQX
         TS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787549712; x=1788154512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsfm3B2VKYEmQm7+WBrIBL7ccJpws7BXCiuSJtGpd8g=;
        b=WSyhieZbn7lzvjXp/r7hhdc/QU7CLBk7pzlS9DROJAg/KfFXVxJ1c8yKHwLzfkuukP
         r9QFgBoZODj0T4QfY5s2GmmdjH1kZqjw7GT6a/FKrRy3MlHlzRH0Hns+IzhFTfXTrntD
         DKekLEgens0TssUNowshJ37WKgzD4wAgchNhwVoJMk+Ix4ZYyFZN4bAStbLskmCh6A7m
         AZYCtyuXEd+8bB5p/oMK5HTX1NOYnVqLFpgiQcONrqgZp9fHC6iwAEilsfry9P0J/uT+
         WOLG2ImgNoOKu2M2bpdteJv8q56YDMkJrrtVyOZvLDezU44KW41GH9C8QNtyoQWBbTMk
         9VFA==
X-Gm-Message-State: AFuF++mElLzj92Jb7af1i2TPHIyiVeFrc+dHV6V6gBrCaRLo2wcmadEi
	Kng5flHhF6N/52xcZuJCJvYn/Wa7kOPUEUJVrPpWSIlUljaejpa1Y1IJBz8kmU8jAsSQB7NZnvO
	8PPuSSd9e2cG0OrvVNEofcPqPMgnyJMyd2EXtErK4jYr2jENzscWdj+mN/zd1QbY=
X-Gm-Gg: AR+sD11ZUb6QQQqmM084Nk611xD0HUgeuJQvsnrxpwrelZAGtyFE485XAdvqXORlYps
	LTik7oZLGAigI2N7Ylw6+DC/CTzXaTn5d1/26yHMp2tJ/RiDfluFM1Y7zf6Gr19YpUT6n7YRX7z
	2yiDWmdGg8TIFhdfTszarQGVXJ60uXlhqMDKuT4sGSAhzzIC58EmL6jz2EMP9jqFRbuMeCqPpSb
	NFZX5EDK+Zlao7vFUYFLJCM9GO8HbZOcgsVVn6N+WhRK4Khb8cDkB82ksd76HzWJbv5PWnT8HBY
	BH9+MYjt1tG/U13TGpFrEowucGHEKmHNheWNvJJ4l+UNFqV1dbqrsx+Y0J7ZCWyLu927OL3gZzK
	PAgZ715eo/ISVAXE0mC+5j3JWAGwv3l5Opvg=
X-Received: by 2002:a17:90b:3d85:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-395c3573af2mr41879349a91.11.1787549712013;
        Sun, 23 Aug 2026 22:35:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3d85:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-395c3573af2mr41879275a91.11.1787549711613;
        Sun, 23 Aug 2026 22:35:11 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327ff728ca7sm20166492eec.3.2026.08.23.22.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:35:11 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:04:59 +0530
Subject: [PATCH v3 1/2] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-shutdown-v3-1-81c14bb7a1af@oss.qualcomm.com>
References: <20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com>
In-Reply-To: <20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787549703; l=2654;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=i18DXA1UuvFFxlInAjMEmK2CjnCD979tKCem1E4xy6c=;
 b=IEzzy6r5Nd5xEiu6vni6gbGOnON3InhmtJy1xbHXNRmiOzPlbkPTCbb+WhTd6vAlhqzygWEps
 mNniI/E/eEiD0E76k2Ykcl+cgDcNux+szymd75ur5TnV26IeNikkCyE
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA0NiBTYWx0ZWRfX5aJ+aQL2Hmdn
 r9jKNyZ20+dSK0ku9CWC+FUOMP7UAys/G4QiYcNPDTppJiXEKAhHf/euK1PyukcmpizfGG92788
 1pgFN/8ije3MnLhA32N6PZFJ0Q9qZwsHZYoyj1WT9X0FWhhYd85JEsSgkdzyK7N16w0waesE6Ty
 rTGtbRogYxjHzvO2WtxJ6FN5sTFDGFIOZ4lHaWFe+cIkPOLs562v4d04eBcx0tKc2WTYjUIqc5t
 W5aJ8nZ9W+WYJwYCU9mmdLWlpt0VMPjipSFLjmo+ppSibAsT2CF9vW4H3YDlNShTLcMt8oioxQT
 DNr9+A18EGyIaIElEvDrpn4fRlAK2i66QHG02SpdrR6jeput3RHh8HhZF1FhzBZ4O/azF3JCA05
 IuuDFalDpG5OA1wu1UtA2xehNiyWOIjtfFcWfpLLMuU50JlBuiJa5oKoyw2aSgjvyzk3tXqwCj9
 SqCRfhsyiDfKN8v71Kw==
X-Proofpoint-GUID: hnLKUe6G78Oa7VIbOq86i_D6-nLqwceA
X-Proofpoint-ORIG-GUID: hnLKUe6G78Oa7VIbOq86i_D6-nLqwceA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA0NiBTYWx0ZWRfX+2xIgRTdy1up
 9fAbVpp0FdEzuAlaOx49w3Eio2vqMmIHDSo9Ly9VIPN63elCgv4GA02q9HOS8wO5DVOScJWLTc7
 ncoWgUoXU1FVGel+EjiHqpOEctxlRHI=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8bd811 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=yeOUdISH2rptVKx3L3YA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240046

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

Detect the shutdown/reboot case via system_state and skip straight to
forcing the link into L2, the same sequence used for the D3cold-capable
case.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 06722259d2e3..98cd9dd2c7d7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -13,6 +13,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
+#include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -1222,16 +1223,29 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	bool pme_capable = false;
+	bool shutdown = system_state == SYSTEM_HALT ||
+			system_state == SYSTEM_POWER_OFF ||
+			system_state == SYSTEM_RESTART;
+	bool d3cold, pme_capable = false;
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
+	/*
+	 * During reboot/halt/poweroff the link is going away regardless, so
+	 * force L2 entry without checking whether endpoints have transitioned
+	 * to D3hot -- there's no point walking the bus to find out.
+	 */
+	if (shutdown)
+		goto d3cold;
+
+	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
+	if (!d3cold)
 		return 0;
 
+d3cold:
 	if (pci->pp.ops->pme_turn_off) {
 		pci->pp.ops->pme_turn_off(&pci->pp);
 	} else {

-- 
2.34.1

