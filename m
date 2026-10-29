Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793247593;
	b=iG19RoyIHY1cIX6gIHeYBxhXhMKgdPaSPmqZSNFyrxJeQBQz8m21gHbdfmrNgFWBMCb5
	 +qO0uEBJIzH9YecBkP46FP8asMXRahi3SzUxo+LbP7cBHkX605x1wlwfNAlnJpgbF7Ehq
	 plJjDulu92WZGYWVprGzZ+RqlutSSp1OlNYEAzQ06nWNlmloF3wIfLzTRmuUUTfqLDMhB
	 TgJZuiNw86AqCQH2vF1zBHb3fMcnG+DfjKdacoc1jdmBgfRN3627UB3PJgPILrxWx4JUD
	 LcO5vIi4pJbZyHkBD/pb6T6BAtZShD4SKv2fgqU2zFITctvxYhAwdEN+muEvPAOqOqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793247593;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rEbY41YsVheZzdYrsvwCvwskR/iVkvycxy1h1Iiep0Y=;
	b=iH58qKtRPZdE1qF1GjwnH/VqcuJiAYalOpJ11o1N/b1Xfldackn6Qcb2xjNVxCp7cXsD
	 RX34HijJP8CcKBEVv8GQsQv2Cupk1ty7px163Fvgv1i8s2CPGeIad6Sl8gMlQHFRROJje
	 9NQy4cEW9hBk1zdQwW4rwG5RvrALzm8zdnFAee0dHPLr04BitHYNHDE5IPZBhK+lGEjB/
	 gRO9PmCGdbYMlLX/xn31dT538Dta9KvKsPpr3JtCGzzVW3XiQICLP8YAMv9zFCnEexmup
	 iY2VJeQd8jry8JhMFHNcEmjI5Ita0q4GSBu2QL1tmCmhjZ5qGp0n97FTlcTQUtBkr+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXXQF3GC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DbcxI7pD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F5B606A335
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F5B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXXQF3GC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DbcxI7pD
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T1jloG2523174
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rEbY41YsVheZzdYrsvwCvwskR/iVkvycxy1h1Iiep0Y=; b=GXXQF3GC71loMgO9
	snmuMQ7oBYW67RHkDBMsWTm2LbPNoJqAuktcgn9lQRo8aw0FZvHn4mcrQZ2yCM7q
	ATYtJQmcKzHqMhUcDxTcEsCkYI1072xTV5kg7AVtyvQ7s4OGquz6dmN0Z3Bvk8hr
	0Iltac6eRsx9naS+8nU3BqC2HszZsZ/eemOwXne3jdhY4rniIHHAEQGpBWjQDCxZ
	71InPbeKyMPV3Ryb+OpAjoW+8zYQ1q4Ut0E/x3otARSAi7zpP/cewQKC+5aAnM7A
	VBzCfAzFXwYLrzvjU56X/fW/Wu64rpC4yq6cCL91M+mCfzHaAio7jnTIg1AuD1nj
	yJdlQA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknkpa39s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 04:19:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so3413385eec.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 21:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793247591; x=1793852391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rEbY41YsVheZzdYrsvwCvwskR/iVkvycxy1h1Iiep0Y=;
        b=DbcxI7pDRZZPKiqyamaYPyjurvzpHLY41PuCtng4Bp0He9cO6PERCWOvyJ4esrp64Z
         97fl8OZW5K4K7ksfayuVfyLbffU16VbpQJCWqWHgXa2mTOA8JbQPeFK+t10P7eY/XQKe
         milhy9RS4c7B32B9Be+JsKoyP7OIT5iznjVPyXZgKjQfm+SkgBa0xH0SH7Ejp9rYG8IH
         T1oqGGVpv8odKAFmYBucXsNvsZeNr9X1eKt2Rhtp6Mqiz7tOPt5+kj2YdC/XgN0LxmQD
         HyUDYTUkexuukhGv+uC2pXoIV96ZAebCCXKVL5Aeen9/1aJFP/CRY48fYikjqQ2mvZNK
         X4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793247591; x=1793852391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEbY41YsVheZzdYrsvwCvwskR/iVkvycxy1h1Iiep0Y=;
        b=EdtQRJvEmPSZNYKXHAqWUN56aKAMVTIa2NjBvQQaTX1ER4Ogsb0TsSyP99wRltMYbx
         jbuTPYgj8zenCfi8WzbsNNuOmDvIatUUnRJri4kpIPlxKZ22W62Q74IG4fP4UFv8wIa5
         Wrxz4yOqDG4NNfCwZTUWCGJS3H4b9eG/dbwVMc2Ry22KfQKpbOMMVaQLpRepDlrjCluF
         Vd+3oS5Rqha/zYuon7Gw5etfgCA7YSN3KBaDvl9sh/w3b/vRzEYNTYNwZWmPr8Q66ooh
         p5ERcXIsYgpRc1NlindPsZ3k9mdPoA6Dx63tdplKb2ZWj2d6+ESbYvD9z5CXUsyRgk/D
         y89w==
X-Forwarded-Encrypted: i=1; AKwUvBw2tIMfDSH2poBK98zpXhdUiqwBhMfOpyhcyNFWRvhqcPB5BoyT8bW7Ub9MYqy/vu8IjrRl8jrda8o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwALv58JQew2HH9dtzdS4JqA7z96kXmB7XycaqOwKWb2M98+H/
	qSTMp6FEqKDoslrCIr1p6c8W1y6ytMnbleNcGoT43xnfY9DSNdc0rm0Y1gyk9WNSdvlYqaxljK1
	yKt6tdTnhbObKKhBCMrcbPtIl5TTzgWPeZmnDEx5A0EZ6a35FkWCRXX9O3fpWlMM=
X-Gm-Gg: AYBFou1d+07geDRQ3MQvwAzjzNUT4cJndb6Q4E/6zv+0P6bEqkEpB8Zkx9NAzSVS65d
	beVi2HJPJmg7D2SCfW4+H0Qm5BIWORBQ4Kz36Zy6GbsLTYyYu9PSJQNPb8d//lVNMclGowNRTl/
	JiAYlZB+9Jgimav24HRXsOXI1yYLQ4pHrBDPpBJo7gd9N9rSaSvVMSDbmFo2Pef4Nd2tdb2n7cB
	a5QwzUPY3hoXaAfsX0/7zbdDU/uCbCDVDPB9XMLibOjS9ouhO3Xlc+75VZBjmnm+aj4mC4XueE7
	YTHMn3T0dA/IsLYx5Vt/xJ9XTimXyyC/uArQKYO2MnrOrjZRXYhO40IyxmbwuJB2Mt13jBtoU3/
	l7uqypCe4GIn2+O40bRoQkJzFZpz0G9xaxaq+3rLDL2XBc6pGXNJW32v0UJ+RXH62OtJ3hMCApn
	W1P9jve5g=
X-Received: by 2002:a05:7300:f894:b0:369:a162:af96 with SMTP id 5a478bee46e88-36a2039ca38mr6257714eec.17.1793247590614;
        Wed, 28 Oct 2026 21:19:50 -0700 (PDT)
X-Received: by 2002:a05:7300:f894:b0:369:a162:af96 with SMTP id 5a478bee46e88-36a2039ca38mr6257688eec.17.1793247590027;
        Wed, 28 Oct 2026 21:19:50 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a237be80csm27504539eec.2.2026.10.28.21.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 21:19:49 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:49:28 +0530
Subject: [PATCH v7 2/3] PCI: dwc: Force L2 link entry on shutdown/reboot
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
Message-Id: <20261029-shutdown-v7-2-3fd7a76a6991@oss.qualcomm.com>
References: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
In-Reply-To: <20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793247578; l=8264;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=wbV9rrwWR2G+Za98K3S+aHq+nCTGmFr3PDk/SAK1uBE=;
 b=fbIIseNWjxQ+FttSGUJukWR7PZ3KrbXpuZI26A9Q2C2tLrvBvOyovPQaYoojGUdkhwRRVHSVa
 omm5c1V/xK4AmiXmeB16bYYnmggaujEr+teNRdn4/75sYS8RlDyXWJX
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Ju9kP84C c=1 sm=1 tr=0 ts=6ae2c967 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-MHXjDPJGaOMKVajueQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Dw1mmMKpmOrm2PJ6ZwbLxNKubjz5Dk23
X-Proofpoint-GUID: Dw1mmMKpmOrm2PJ6ZwbLxNKubjz5Dk23
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAxNiBTYWx0ZWRfXw6zU4JWPJQne
 pMGhin3Q+s1EN6lEeBxqjS82WHaC/EKKE/spMlK0nZ2/+xdppy97wVKRLbLA1wMBadDLjxQyskN
 rZO6PLsbPhbavNBAHm95cPBnaPx9UEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAxNiBTYWx0ZWRfX45GR00+RZZ8E
 zm3kJ5m5JOIIeD4c+aHWbUHdNCN/8hyQgYmSoxjc9pZ83pin1nULwc4GfYSVhQKo7bq70lSU6Fw
 nBrXgaylgcfswaP50A2jslAtK3QOiUU/1z7Nq9jHmfZ8a04htN4wEjwdmVJoPnY5MunOjl7EQDk
 creVAFMLnRKL9H9ABS8y9VI3IK39gT/0cJFd0Ondc8mmblV4adjokferfpR0jcGOVG0hsoEpOuQ
 ehocxvfeAZ15QpmPkSxrNjs6nko9tfJ0ueugOo3qIk2hpbHnxMjgdO/q2rk/82WB9Hw8QvdvJk/
 8XINQHjMJ8UyIDPBTOyM9wfbnx/AgtDHbb83Esgl0G1+UR/lflY7wuzqiZvd226PKrEFK1dF77Y
 I5ZTM8jvNOiYjU73PP104L5AK1+7HpqjZEcXzJZcku7HIjaXEQVscDJ66+yAnaFphGgCq9pf2WS
 YUvA+dB/9sQIG1poBNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290016

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
index 83fbd998551d..1f2b942e8423 100644
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
index 7f37a0537159..bfed194834d4 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -382,7 +382,7 @@ static int ls_pcie_suspend_noirq(struct device *dev)
 	if (!pcie->drvdata->pm_support)
 		return 0;
 
-	return dw_pcie_suspend_noirq(pcie->pci);
+	return dw_pcie_suspend_noirq(pcie->pci, false);
 }
 
 static int ls_pcie_resume_noirq(struct device *dev)
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 869a39107a81..e4d47999613c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1235,23 +1235,22 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
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
index 6d788aa00011..4905932cfaf9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -861,7 +861,7 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 const char *dw_pcie_ltssm_status_string(enum dw_pcie_ltssm ltssm);
 
 #ifdef CONFIG_PCIE_DW_HOST
-int dw_pcie_suspend_noirq(struct dw_pcie *pci);
+int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
 void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
@@ -874,7 +874,7 @@ int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
 #else
-static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci)
+static inline int dw_pcie_suspend_noirq(struct dw_pcie *pci, bool force)
 {
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index 1bb44696057e..21d077172724 100644
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
index d903f10211c2..a7835e8a51e0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2464,7 +2464,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	if (!pcie)
 		return 0;
 
-	ret = dw_pcie_suspend_noirq(pcie->pci);
+	ret = dw_pcie_suspend_noirq(pcie->pci, false);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fceecbd16355..045d33ac61ea 100644
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
index 523f454c6c52..59341682213c 100644
--- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
+++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
@@ -193,7 +193,7 @@ static int ultrarisc_pcie_suspend_noirq(struct device *dev)
 	if (pci->suspended)
 		return 0;
 
-	ret = dw_pcie_suspend_noirq(pci);
+	ret = dw_pcie_suspend_noirq(pci, false);
 	if (ret)
 		return ret;
 

-- 
2.34.1

