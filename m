Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670242;
	b=ngmgWAmE4IFM4bhfyS0vmkBO09Pu4C2GORCyuVbBQ2Bn7c+QdtyVG2sLHpXER6wsc7I3
	 P/bwM5GKTcEDOhxV6BN2Di8NuEykn9C+eJyhXAArglm7e+EfKG/LN4lg23xmZq3gjPhq1
	 rL5dhMeYPg9K6MFXDViJcZ3Zt53smPsBU1vHPhlW9QVT8ZoGPaP5lRl2oG78eggBmNcp5
	 uXLZ91qz18jPuM5BdIUTZxWt0tIHqMsMTH20Oiv4WpYWJ/BAT2wuvokFAPPXx1gc7RD9e
	 Ufos9F+YeSktqUBlfmQta69xMmNcWe1IfYJoOOqNm/OKc0ZM/7EFPIjzag/nj49Zn1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670242;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GqK3bpzM5FZtay3bMGryeU6spO62FC+7I+8VOgahwf0=;
	b=SDPkW5zYR6VtZLlLs6e77x8SWN+UVWtqV2ENLRxw+45F0thiGlRGughPS32ctoU6UHS/
	 mowjYW3DKcYKb+JCKLJprQ83QumnlSAyIXg+JMBHbwUpJd+jmQIbNOCiTrwauE/WQOtaR
	 lgNLI20RgZeNUFkntQms+iwl5Ty4e6qltj/9dP7WWYyXE9OfgPS4xP6Z7lm2S9E4SIkoF
	 U53asR3ymlpwcS+CDtWjYT5W78nHdT+lSGJwyTjIVWhR5Udx6nhnpfr5+3U+//3/7E3eL
	 lwxKomaN/ePY3HPsFXaPBOz9e66HVQ1IFOybae52aLGfmAhcuvVMylwb/NSALI/SG0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="E7Z/vZkW";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CqIv++GI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E836C606A33E
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E836C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E7Z/vZkW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CqIv++GI
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36GgF1157387
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GqK3bpzM5FZtay3bMGryeU6spO62FC+7I+8VOgahwf0=; b=E7Z/vZkWw7uxXA++
	EalEyVbJeQ9ZLWVZJeI+8FPEIowMfBSWxVdvDpEECuZMrJIyfb9y7F7pnaP9I3aH
	zUur194t4glPzOK8KgbvR6lHhXv4f+myDAFB138d7N5kEJuFzzG1aJDut3ouvzuP
	DHPeF/mfE5JeL7P4dqylP+qZE+GZkFrJP740dNwTlD+GEfszN4vPttybEDH+fLQX
	Rn9JfheXnXGC7gEHt7UIflSXch3mEikg/R3ekIAM88V+9OuhMF47MzCUiUfnFajs
	zko092A7RglnVIhOfaaPNo5Il5VtVoo3MS1Bg0WQQ1MVB6nUsFUaqHabfAR6x9+e
	9WI8lg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j62aejh1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-386a0f79047so7025354eec.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 21:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795670241; x=1796275041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqK3bpzM5FZtay3bMGryeU6spO62FC+7I+8VOgahwf0=;
        b=CqIv++GIQzD6io+u0zQJXrJtrrTBenscBICThH4JPaz+7V3lFWqT2Yy4l+YbCoPVsL
         kSuM4ZcMSHd8PkfQZ7h6HU21UJRBmPOK7fSmsoQXo2DYXkMAVvLzOE/nqbQReEX95wrq
         iXoexgPQL4NJWrUzkghM9QwJtas2aQC5lbF2kcvlYRU9nHiX+Jcp4EgbTUswk0qeF2Z8
         /q+2i+l0Q9OFs9iSr8noj0PMhkYxQLx7as0YmlC+PGSj489hgmbhwSJob4KXZrj6oe1z
         jB/AMYmY1RD8uKnrNaE9/R3XkYdH1Ksq4/d2zhAg31bhNRR/hU3HfgX+YgboZJ3/9Nnv
         421A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670241; x=1796275041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqK3bpzM5FZtay3bMGryeU6spO62FC+7I+8VOgahwf0=;
        b=u7Sdc3JkTZ3dQa2bpOYpIlQetAe9B+2q3rkhjYfBa6l8/iFlByWBAdxDo0FLvZmuQ2
         J/8aZq0T3seF2jCuB9bnOOyntK8tB9GWrLnPfTWWImNu9L5d89Vm5vVBepVanDqbAUb1
         d3FVl9xDxgoSg4Lfjj45N1OFmf53i9srZzEODsyM7xnxolv2jZFD/rV1Mt2kakdmA7EQ
         0yCkXjrqUBr8WqL08Fwjgf5qgJi42aHwBugCEtEriPpEUZDbr5h/sWcOgKPlDg0bctOZ
         wx9HGVKGd15ryYvHstK3Zh0vTvENQW4jUgqrcQF4F8SzHBEUE7zOAehks9jfT0pHuzqr
         W2pQ==
X-Forwarded-Encrypted: i=1; AL+hErFbzQeesG4yjsHAPxxHCGf2wXGgTVjnxS2YzeHyKG6OKh72ZJwfIx5l8EDFXB2w0dS/sqFipYhZvRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DtGqbQvtPxj7e62BmzDdQzmDC7carqdi02hU5UiH54vTmRuwU
	UAdCUHbHsCoaTe15qmD+31fO8u/hL7rsaqGuALPaEN3t+yhS7EgVt/Qe/3k630nKcG7efKPHwQC
	J/pEiBT+CRxFLNjveB/rr+pIDmC0YnWzqtE+GRjDy0UWUDZawbNX2+UZScP7amGQ=
X-Gm-Gg: AZFdTZeAEjp/R+W6DfT55zjlCn4wyAvzsj1a35RFWNJ3N0cF3LMF24BGApmIpANIZrE
	39KUvJiU6nlRK9CIrK2mTMB+hHYTf9qs9/oBhLNqs/O5/nkYF0smJLo8tNc1Wti6d+xT6IlFXq0
	zEbdIoTEZ7Lqdx7g8yrE1jzgnZ3DO9hcS7/7I+JZediiE8iD4yC3Ztq9IerlLsVNRoaUz92vV1y
	1T87H64veiSCLd1j737i2AUKgV/0zs2iWbE2MoFnRYGZnJnrrY2RAWiHZgw6Cjuxfys5sVtB8ES
	YB63Q5OWTrjPpvFneNjEq8bRSfemfRYb7K4RZ1F8gjLM+mGsl6jIVDoJL+ocC8b0AhHgpNp6cTl
	bwiPDyHIyLdLq/PkhGQwr1FAsJi9pHES7Sv3jN6e+bN0xMDT0jxJPUcwAB2ysA9fM7qLCNYm8pi
	TCqbif28zg
X-Received: by 2002:a05:7022:23aa:b0:1b5:23e7:3387 with SMTP id a92af1059eb24-1b55688dd29mr27963601c88.19.1795670240396;
        Wed, 25 Nov 2026 21:17:20 -0800 (PST)
X-Received: by 2002:a05:7022:23aa:b0:1b5:23e7:3387 with SMTP id a92af1059eb24-1b55688dd29mr27963556c88.19.1795670239808;
        Wed, 25 Nov 2026 21:17:19 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm52132934c88.13.2026.11.25.21.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:17:19 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:46:59 +0530
Subject: [PATCH v10 1/4] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
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
Message-Id: <20261126-shutdown-v10-1-fed60d9687f2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795670232; l=2417;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=AdMsyjE2U658wo9GCc3C4v1LK0MFmWfjDkwn5I63cMU=;
 b=rcI1ccufPYHfbWcNrTqR6g4ZNMspDWAXucjiM1IWLplFLDRprXpz3ufm/VdbWcN/GIKBddpSO
 wmU9knpq7goCMe3loOpYbdMSkmYK3oBVZWAFWCbnUKmNDoKtgn/+VGW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfX6TCUhooXvW8f
 x50jrRhBNCrPK87SSbUifFFOnQh8e8f20+2CywceF0YhykZbG1tTDHWiqkv7gi3gYj846InHGDo
 WsC0P8zjCzQEIMU9diPDnkf9up17uwR0y2EgEQmnG6mtHnXj/bnKzzKpeQbCrXEjAhClqM3gNCN
 SKY9MvJoKAjzBKBGdbJK2S/N/1+M7VF9yvyMAZ0qjCEBUQbzvavNlzf46uRyvxwLnLyZf1Rr3iz
 O0Ul3TH8HD5BQdQYfvHwXx8v/IONxQCj3IbEU82gLWi9jVfGOKtYXTy831t4jf2mJHhK7q47BkQ
 rRtLni+2PdAHyDD6y6RaYQ4eW4ZlITnA9YefSREi3zMxQAAWHpbh6z8H+Lg12YOz5a+S94gaIGB
 fPTGN0Bi5hdsox6FT4bIPhGAtyaJpu4ojgoVNlF+/XAUy3y6I7N8AQPPDWIV1uhFsNZ8Nt72CXi
 eU2RKb5oeZ3HvvbhI0w==
X-Proofpoint-GUID: uwUAmZHiQge_DEzGfmnNSh6U2H-xTNof
X-Proofpoint-ORIG-GUID: uwUAmZHiQge_DEzGfmnNSh6U2H-xTNof
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfXyXuVNt0mJ1iu
 9JbdyHrJbisEVQ9JKhJj2PCtAZjtQcQUw+Z1+5coa73H0pujVkxcn+9/3rl8Xko8vDi0mNdI4/X
 V2lBqeRrGvDWydA3+FfI353MGLJNLJc=
X-Authority-Analysis: v=2.4 cv=PqoG/AM3 c=1 sm=1 tr=0 ts=6b07c0e1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=RIIKlrP-v3AzcS8hWasA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260019

__pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
the walk as soon as its callback returns nonzero. Any device enumerated
after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
capable endpoint -- is then never visited, so pme_capable can come back
false even though such a device exists on the bus.

Since pci_host_common_d3cold_possible() already returns false whenever
any device disqualifies D3cold, aborting the walk buys nothing for the
plain suspend path: the overall bool result is unaffected. But it
silently drops pme_capable detection for any device ordered after the
disqualifying one.

This matters for the upcoming shutdown path in particular: unlike plain
suspend, shutdown forces the link into L2/D3cold regardless of whether
pci_host_common_d3cold_possible() itself allows it (see the following
"force_d3cold" changes), so at shutdown time it's common for an
endpoint to still be in D0 and disqualify D3cold while a later,
PME-capable device is never visited. dw_pcie_suspend_noirq() still
uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
result here can cause Vaux/wakeup support to be dropped for a device
that actually supports PME from D3cold.

Fixes: 1d2a29ccd3a1 ("PCI: host-common: Add pci_host_common_d3cold_possible() helper")
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index a23907a875e5..c2c852c64aa8 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -275,21 +275,16 @@ static int __pci_host_common_d3cold_possible(struct pci_dev *pdev,
 		return 0;
 
 	if (pdev->current_state != PCI_D3hot)
-		goto exit;
+		*flags &= ~PCI_HOST_D3COLD_ALLOWED;
 
 	if (device_may_wakeup(&pdev->dev)) {
-		if (!pci_pme_capable(pdev, PCI_D3cold))
-			goto exit;
-		else
+		if (pci_pme_capable(pdev, PCI_D3cold))
 			*flags |= PCI_HOST_PME_D3COLD_CAPABLE;
+		else
+			*flags &= ~PCI_HOST_D3COLD_ALLOWED;
 	}
 
 	return 0;
-
-exit:
-	*flags &= ~PCI_HOST_D3COLD_ALLOWED;
-
-	return -EOPNOTSUPP;
 }
 
 /**

-- 
2.34.1

