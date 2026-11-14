Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621676;
	b=sv/jfR0vWcvdE3spXdb594wPx4z3nf8yLA9WxYw1Q9ctXyncn/vXuWywTuM21vLGttwV
	 O5VBsmqK6q5wfBQ6/DnQgeAwf6ml61GFxO2XOnGi9cjx4MzIdnBBPEwrYRSHxwZ7DEo/M
	 ic4O/B/lTUfRxHDXriWa31wBs66IRfB52v5bb0Bswcxf0vWt91CdGgA7F4JB0Y6GinIZs
	 o24x1w8YGX0oT3RYHjhwzKtUuFIf/MUiyYmwenpgZ68aYe9nV7mPu7zL2MrsDUx23WsG2
	 eajurVnD4kAxCKggD0YIdA9Pu/rrgRQQ+cplFK/VJ5AKOO9tzNlFemcvJkEUIlRFBAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RmakcOIEjNauQl1koJdcjemBDCllm0Kztf8XnpO48fs=;
	b=zao3U50V2McEuwJtMI216CzbuBsQbt9M4gm4yw9CxtPfUJWS8b4ZuwGuUASAfbsp30SS
	 S+X49QIGWZKcSh/rx+NjMepqmxlWtCLlQi2zA2gbdM4UPKgcPATXd+dB7zxcSwflSKrPg
	 d5mUk4N5dfUHzgv6S2keiFXuTKqeqiz7vcr/f0anBdJulB9rp3qmJMpZbqYExJt+fqQhh
	 RfswkDOImvXZU1LIe0+bZoy1HfuUE86iFESAvPQ6ujIDoPoFRhxDvWieXObL88QCBEpcV
	 1+0K3grTfG1KYZaKXMipx4btR1ZRooXRtjSMW1lGtChDfRGIHfWaLhfW5ksi8wJsfeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UejrRufn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A3f4coWj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D360A382F
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C78D360A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UejrRufn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A3f4coWj
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE20NoZ2356112
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RmakcOIEjNauQl1koJdcjemBDCllm0Kztf8XnpO48fs=; b=UejrRufnMaf0GcJk
	Uzr6Mpu3azVPEzTMXdHMgJcYg6WWZ8+MG8ijnapS8tu7TvE5Mt+syZzqVjRuM5OY
	Nc602b6RSZQ3tq1KoerSQX9gP8ccAZxmruwk9AD/eQ5OFRI3WJhLnlwFseenxVrb
	irD8Zy7UQjrCCCQvVRUZQr5qr/MC6XlIikyGGlm2WJhQjwpjaEEWd7g+gwrANKYr
	omsHFsKrk/Uvpicf8HG6/+pJhPTiiA4/kwz9dDqmDBdcz2pDn9zfEnkeDfQs0uXm
	5m97J1iQPXjgOX/XwS86n5bc/1q0jinl4+74WNS5lhH30kfWo8X4mM6gP8iSeDe3
	ClxtyA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxahj0rtt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-370230d93efso6907013eec.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 18:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794621673; x=1795226473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmakcOIEjNauQl1koJdcjemBDCllm0Kztf8XnpO48fs=;
        b=A3f4coWjNq6zWXhzqepwK8g3+NcHwWT2IXDZPU+64PQMbA3h8P068iM3q85xeiPOlV
         +xbiUt4zd03Qgqcb0GPCsjmUhLsJyZNTXR4EwCbCTc+qz9YTEH0RZmzDtXaqy2Twy4NB
         ow7flnMQhltmpzC9VclWtAk61kLT/BsvURmQf9Hsxu1PUDsq3E0H7Nim8/ncfuRHU/MZ
         MjQhwcMaX7wU9CWQxaO6VhNqtvjqU3BRHDGHqBDqKht/r34Zg/mQCI7LPaD+48pl1UIa
         pSfcateRxA41PRLiAns0sABg+wQsjWcUnyyArIDENBFggKU1PSqQ2sRsoR9h9U5AgR8o
         WyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621673; x=1795226473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmakcOIEjNauQl1koJdcjemBDCllm0Kztf8XnpO48fs=;
        b=uo12439KeyTyDr+cZyc9ShbLVsRHtXNgHiE0I0zqXhbXwWi/HS1nXmtqQ5XC9EcRux
         WGhGzZNeTPucW8ZIpUeRoW49aiJzmgMy23WUJXLY8rVhBIYFZpXuaZBkrg9UfGLR63Qn
         vhilwEKJYUoc2BVrdkgwZTzaa46ssnvpkUgegjpEQpLkkgzoaJpwRSgeFO9gazvr6R02
         0Ul1dHcgAf1Q7y/ag5yBMDd64fSjbLBvJsEAD2+Z8eif5Zk4PYxUiM1iNrwGira5B9ta
         A72VG68yI67cHXyPr2MvIWw5iLCyslhDG97wYrIKg+rBF4IeQWP/YoMpCdoB/l4esBBR
         sRbA==
X-Forwarded-Encrypted: i=1; AL+hErGTqzDDtRVkaEwPSD0Czq+ZAPKdW1tHQmpM1+QG8GW4BTD1C669Cw5yjbF2WbDJJgBm2O2dmWv8Kyc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dSCRdK8pRh6xV7ZUZFQaTdLd/VbQlO2rl+o8BSDotErj+OIX3
	J0og0pWfurmYwaeM8LQxpg4PCmyAMR5AO3NjSTtaghL1brGE7ImWM1+00pTtUMfnFL9Cvdnh0oB
	ikiSxOSbdy94vUXuNLU/5EsL3yFqfXriw/ew558d0Dk2bbZuuVSlZLTyVP1874HU=
X-Gm-Gg: AYBFou1+99ANKEJEgs3ffJAXUAjSLvCvm8q8jfsOpGY3m4Jz72/tC17IwlIJvccdbdz
	j+dFwHX3xWabk0S+IrF8VslsMWaq4jVz7vBvuL8i3EMLiMNJ6KaA4ybRdyiZZ+yO6nYptFT/RCb
	xfAk6oz6XCwQnN3dzDKLOXU48jst7RiPRTErNB8y2tv8EJbw1ZxdWoOOrhxJ4T8h9RCz7SKnQva
	ZHINWbdZIyJonE/y75Cm0dNBRToUSVBmRqPx0uKPfSdfpWqamrH+4C4UD2kpr071PcwepjHsp3i
	dlzqUQrUtjVnLkMBwyTzjmkHZvDo+2aBAf3cplypUp7Py2kIa2ikWKpBFe2MLgd0MdcNmNy3Hsz
	L7ZmTpDosR8eN0WY65pv7wVVh66oKbek3/J5kd7A+xnUD9gUqlJ0CyxrVZXl2fItWMqjJrXYdU6
	+XRkNR79gX
X-Received: by 2002:a05:7022:3a87:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1b503068f8cmr4401342c88.1.1794621672686;
        Fri, 13 Nov 2026 18:01:12 -0800 (PST)
X-Received: by 2002:a05:7022:3a87:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1b503068f8cmr4401135c88.1.1794621667378;
        Fri, 13 Nov 2026 18:01:07 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm9952742c88.7.2026.11.13.18.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:01:07 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:30:52 +0530
Subject: [PATCH v9 2/4] PCI: dwc: Force L2 link entry on shutdown/reboot
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
Message-Id: <20261114-shutdown-v9-2-5430c9f242ed@oss.qualcomm.com>
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
In-Reply-To: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794621655; l=8264;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=soL97KD69Sdc2M4FJlv8YZ37P82fCiiMjblCTbN0BDY=;
 b=p7FsgYPdA7fNw9Tbq4NKJWXcRZz799k1ycNUX1wBGirnTFFQHZlnFCfcVcShIn6lh//vLE5D6
 IgGGlW3ug3+Czg2CwqoIXSBFTNB/vYV3idSuDfyXTwLCZoyGcon+0Zm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX7OzcugmOXKSH
 NSJkE17tW2+lsA9lKMgBo+QmxAnFtJc1ZTUCqCeR8oKxg4nyOpENE+Ado8frHDdgKOlsI+7kxfv
 Ftrc5SxhcC1jyCBsn/6mkWwZaHfi9jjBfgmBnrgkpMOGEtEZJ/gzZd6h0sTII/ne/LJAcRV9yJk
 TYWdStYPfXZQBlYv5FptcsIvv+C6nIo5ebIhJiIoBNcryfd8dXBtb0LpMoSn24H1mjUeEH4DirA
 7hY+ZPNSIh+x/MfAb4awFmu/+7XUZsuwNNTjLyQOS+w90IVVgkVPaqJjHJGE3XocGAbIiMifubk
 kXGx2dDClt3VAP26kGBMN5vhz3dmnciuUM+xJYkikhKXPQtGj5j5lWf2ZUREnC5kxDXYG7KpyeQ
 Z20FryQAbXNnX6AK2rq1bHvq9nIImhza2I9lQLSsKwUjWShjjafa/4KNtg3kp7WCTEeGjWFFmUt
 USkftY/UJkynWGaJ/qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX20inRqoCFIpU
 ol1eItAsB7+jFuZ7HIQiWHSDDfEPv4SW2fp2IZK9Raez/fPmDkGz8lbvkRDcJhyhs58nXsV0tEE
 8BIrBLWXDf+u69LjdvdCAR+kfQb4wzQ=
X-Proofpoint-ORIG-GUID: AHXFl2Zcxsvz4TOblaZhR-1GdVGP8nfY
X-Authority-Analysis: v=2.4 cv=Kv/YSmWN c=1 sm=1 tr=0 ts=6af7c0e9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-MHXjDPJGaOMKVajueQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: AHXFl2Zcxsvz4TOblaZhR-1GdVGP8nfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140007

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
 drivers/pci/controller/dwc/pcie-eswin.c           | 2 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c        | 2 +-
 drivers/pci/controller/dwc/pcie-qcom.c            | 2 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 2 +-
 drivers/pci/controller/dwc/pcie-stm32.c           | 2 +-
 drivers/pci/controller/dwc/pcie-ultrarisc.c       | 2 +-
 10 files changed, 14 insertions(+), 15 deletions(-)

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

