Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893611;
	b=IXEbXlbmTumvsTgHiAjeOYBotdGalnp2say0Bx/QoDqQeEUOH8FSbwb+YYlhVl0ipd+/
	 99l1szd1GYK+bQ5jykYF00Fn6n9THsUg/arjRwcjEKNKP2/Op9T5P0W5bmyuPqVIYigoM
	 Wn6S8ri4W0Vnvg1hjqr60v31YpzymXAIblPOOsGl0IE/PUjMrQzaDtxhOIFcxQp5hmcsd
	 hyRmN2MxZeKCMDVtCI/9ZzKTs9OV5hM6nk+fJ82ZXNDDPjETAsPfbbE0T8ZD4IkCWbFR7
	 Q9yTSR8MYtoy4kZF/LIZMMQr4NRdZ3u0flLGcyEb3BAWF1BDib3K4/znhaoniQqNQvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893611;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
	b=ksGaXTEXzBc0k6ucz0Vd+OptM3EIin3Hq3jOuUYO19OYXXTTirgRD8KZVk69LxnDXXBv
	 vP8ejrrgx+cpr0MXAfOXicZEvtVMtf87zRIlfdHfD3grC90X8WCUZO3DX7vQd/zOEQmTE
	 H/cMP/3JubJ+uq059/VGAWTnH1qNfkfw9MauoRgM7My8WtQ5X8zW5kiXjspWeQHCA4Lv/
	 +yrzyN9+MBrLqCNefwPGiBECM3pW/nTjETLWs/EXm/toUq/bZbQnasx5K7ZT4ZCyWYdJK
	 kOJUpK6CF0FTUWotxlU+TcjftGiKZlwIX0k98/PTbwwkQ11svNihIWopu3/lfKtKFvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UbgLQfmH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NeiuGTIc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A0C606D802
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 15:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A0C606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UbgLQfmH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NeiuGTIc
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQG8a1049828
	for <linux-pci@vger.kernel.org>; Thu, 5 Nov 2026 15:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RN+WEUPp4KINOTOtwDMjWG
	bdxhennDprUx1GDkbGW6I=; b=UbgLQfmHay1X+yLkye7NquJWqU5e0T0xMorbpE
	74Ttkk3IcQCJZwuOfogWU5uXpQKh/oTjnd9cYKbq0bW3rj7XRJDB1tZ3CpwtycAn
	BeZOC//LnRvrAnZ7u7FlUyDLOuQE25ubJNXpbEIEMIOuxl9/M6/W2+Bnm4XSIBze
	oKceZdEID2DXR+k+W5EFVf+Hvo37clM7+TRhEM17pGLdFGC7JxfxvzrXcijSkJVf
	8N9YDYYc5R92tCaQ3JJPnfznxFcQ46sztjBN6p/+92aE6IAAnFuQSQK35wbGUo5c
	hqnW/zSD2V0yeutOmQorrudVCg5uwEG31yCLMWNzjGuuCVHw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaahtsv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 15:46:49 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-999bc06bfd0so1110893241.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793893608; x=1794498408; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
        b=NeiuGTIcDa0UFX5v82P4oZ0WJu5KVbWMNDs3GR2L8p1fx7zZcZyrjB6VxrX5NUCB6N
         eHdIDgVXXkiHUpu6/FHKgtE9FvhR1ig7GAEei4+MFiIheIGXYrapXFX15FlVWRgUG008
         2JtuIba77h77V4H2b045mwUGoFGTyholICVyAuLpku78CVH/5uzpOSWqUxixZjXm1aqV
         ud5eIyCvvoXAf0VVQ7jcyQCeBiFkBfIZepROugkZ1Akwv7wapLoXaNuxQrFLGqLra3Zt
         caoI1dEF1whJDIBvf8nDVFBbw7CZPUdJdtoHxPakiSdkasof596lWyN2l4HiqYj0sYe9
         h5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893608; x=1794498408;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
        b=r1E4oyNbKsZ6ffGziH18W8WkPhSnLOB5/9J8TVwZqixj1q6pRUfFBjgEqoFBKdeLtF
         VfodtWLMEhBxMSpPmpim+81svaADBVOXbI+UsQioz6rMBRxyAinvvTlGZKLgiTv+0ucr
         mLIVQtBvz5mQ9KMDBw5N9l80ssscHEcCWWZJpXtXXcYbWkZiyYab9CFjE1OL2XgI1AQ3
         bqwJFmhNnFoRq6VBtFApA6G2I8ZGe9cuk4hHYN2Ag7pm03vAYI3o03X5BaEdYwujUzRk
         bt+4mYGFLtfnnf6ILBjE1748b3r5dwWRRBt1RHjaXot8vuHzTnsqf1+G7xDPL28iqyPq
         ZMDg==
X-Forwarded-Encrypted: i=1; AKwUvBzn2h7Lm6BYqP6gjOFj/YcAt+UtQ3/f4ffr0GkiGhExPrmYfhIyMPU2zGZ522CbApvT2Y8lT5wU3I8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wXFp1RzYGAztv8RTHZ9jPoMNRcbXHii+GyaYhaYmrX3TTD56I
	SuSdbMuSv12Rfy/ozYlOfQ2kQ1gHVJ2xA27QY6isihdqDUpRUTf8rbAPiUA8b5BJXxm8kXWJzAQ
	EHFNSpxUhaeKt3lEZ7P+ZFg4NO/A5fR+XRmqx+T04cxrZAGgjTipm4M8Sxg9KDBheyFD63Ik=
X-Gm-Gg: AYBFou3UHAdQoHqCnzDLawVAT2ougJeVhoZTUdj/b0Xx57bnKviLtH3+YS0oJGS7deR
	UVf9gzIUgJTWfqanU0crMyF3y4GWpL94WV2ChMDftUa0wsLQ7sjBtFp1wvtnn/rZkaiUHYODZvp
	GHV8qnHd3qNGJY7vnbRX+iYH4ZdsiosPT3EfqtUTiZg85ibJUq4+V06R/vmObkmx7I9RZDjKdn+
	g1aZxGK/JVuk6vZvUeSaFgkFQuO50DykeDrp1umVifhcQHuXa2sASX8LdBMg6ea4C/mJ7rAVzId
	y1SsM/SZgYkVx3lqWzNGvCjq1M2XPkD+KsAKgzmBi81cKIK66xjPYH7/PaircCwCNiplerVsIHd
	Zu2utKOrVVtIVgHiEzgtI6kpE6Oup02++rJq/ejYsU5+n3/8P1JNR8GaaMl7gKRVbJ3AfrS7rWb
	SNtQ==
X-Received: by 2002:a05:6102:8099:b0:7cc:bc0:b2d0 with SMTP id ada2fe7eead31-7d072d59168mr9324556137.33.1793893608465;
        Thu, 05 Nov 2026 07:46:48 -0800 (PST)
X-Received: by 2002:a05:6102:8099:b0:7cc:bc0:b2d0 with SMTP id ada2fe7eead31-7d072d59168mr9324517137.33.1793893607880;
        Thu, 05 Nov 2026 07:46:47 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm10717936f8f.49.2026.11.05.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:46:46 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:46:45 +0100
Subject: [PATCH] power: sequencing: fix serdev controller reference leak
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
Message-Id: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOSk7GoC/x2N0QqDMBAEf0XuuQdJICH4K6UPYjZ6aG2agBbEf
 +/h47DMzkkNVdCo706q2KXJZ1Owj47GedgmsCRlcsYFa43nctSGL5dRwG/HqifsXJF5xbBw9s7
 CxJB8jqQnRRf53YHn67r+lZkypXAAAAA=
X-Change-ID: 20261105-pwrseq-pcie-m2-serdev-ref-leak-f521e086d5f8
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=blvW7P+vdcHikV9wkNkqbWJ4eKvSI0rN+D6MuijpqgY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7KTmd1rI0vmNN85k0PZmqXGbQ8qWCS5DLVv9q
 J9gq1Xa1vCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyk5gAKCRAFnS7L/zaE
 w94KEACA5RwVkTCGlBgYEPF7sW4hDzlNdX/Mkg8SksT9dCIa2v3O3WNBupuy8rIxu3W5/cuYUw1
 c1dzdVJMZYqcH4Mb6pCinkkd5z5+lduqTNLSXtIHVjpiGFL2Ex5lTF1aloa+9FWz1RoHIquisyY
 R/BFEBZ9cyUP39Yx00fnQqnNcgtZwhvcx80PhXqQusGEr2Y9KwzPc3L9GO3OFE7U4WBR3nrB8G+
 4p/ooTTMIJl0yif8KQXors2F0zY/vrLHA4yQyAYiLxoKFck2iSdhu/v75WkX/Li0HMWwx1TjvrJ
 I53v/UQiSfMbWyXATm81qIG8BE188YjxHnlbpowxF1Imif2MuAUUnQUKJb31t7sAhfVdzF3lNet
 meCGbN2bamOhRr+2qtOAmf1QgX9GhUFbLWvP9olvER/nL7JsvrdQrvVFUVMUp28UoWyye98u+CH
 7oqg5T0ge65lwSLsI3DHbMwXLXDwBehf3ypoQ9lq3j+BqJskzc+yi1SHP+J4olgkQxJ9xW9xG2k
 CV5X3Je2nLPFedDOGnIddzjBXP5Dk8D7WBuwVO6Bf9pRH0q4vUjdIbHGD60Gdss5imJnno85qJG
 r12NIf1dbaegpiWbhdb0YRvV46DzaLJdG3iXkZjH0ReHkXBKAhn2Tgukz7k20QTiilC/vRh/vbG
 qzC+9B+9xzd1EwQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MiBTYWx0ZWRfX/Fa+6WGwQFmd
 d8m9U5HkwSj2JRXALNXgSkrS44OwQBpkXGO8+JuaxiavWqMGLSStpf7Fqp0/nG2zcwZmw5EbStx
 ZELoVDsqjKDqyPLM6Q5lI2A7z8DLfF94wMvkaQKKhGZokRiIZsACiu1efyXXc/1dg7DO+W08UvR
 ctn8Wsu2WmpDcZcqHri4v430WETY5lcrlorVD9ZxORr9eGLiTRYFIyqlMzTxPHbrKyBxr3SQzzg
 Q0bCTb9DZbeuEXch4D6HQISzVb3KSG5za6TeiuyFzI0GGIxb8CzJ65KK4wIFbAP65+mqPzww3Z0
 T83KGiIPlubanmKudVmmmalU7lhJ0pbFNHNJhJSd4lYKxv+NqjKBLXj1pD4KzzzS0+q0Fc7pLwD
 rQkqhI2uChdPlEJBu++2wDhiGhgIG3UoWaS49xQcenBtsljrZyR3ccBN7BOD3MfeAJToWng1E5+
 vHnxmWasMHm1kLE8kCw==
X-Proofpoint-GUID: pt44dkv2oCDeX4nEiQvd6gy3R1qQc0GF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MiBTYWx0ZWRfX50lcPfgumVaO
 sIHnHAVS6ppVyfEW5p9Z82pZ4TsdWNXiDRuxX6YpnyyLS5Ta59gS86+zwJptuz8x4nzOe69xM7O
 964ytymKvw6Uma/ZBQN0Qij9QmuLX/4=
X-Proofpoint-ORIG-GUID: pt44dkv2oCDeX4nEiQvd6gy3R1qQc0GF
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aeca4e9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vvZYVk8vaF1dF-lsgB0A:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050062

In pwrseq_pcie_m2_create_serdev_one(), if serdev_ctrl->serdev is NULL but
pdev is already tracked in ctx->pci_devices, we return early from the
loop and skip the serdev_controller_put(), leaking the reference.

Initialize ret to 0 and jump directly to the label that ensures the
reference is released.

Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/bug/linux-07754192-a8ad-42d6-ab1b-cd6f16bec846
Fixes: c4be520907a4 ("power: sequencing: pcie-m2: Create serdev for PCI devices present before probe")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c10faba6c978265bcd07a6980d2a52..e3bc5ebb1e56666d135c04b23f6d462a0a166df3 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -296,7 +296,7 @@ static int pwrseq_pcie_m2_create_serdev_one(struct pwrseq_pcie_m2_ctx *ctx,
 	struct serdev_controller *serdev_ctrl;
 	struct device *dev = ctx->dev;
 	struct pwrseq_pci_dev *pci_dev;
-	int ret;
+	int ret = 0;
 
 	struct device_node *serdev_parent __free(device_node) =
 		of_graph_get_remote_node(dev_of_node(ctx->dev), 3, 0);
@@ -308,16 +308,14 @@ static int pwrseq_pcie_m2_create_serdev_one(struct pwrseq_pcie_m2_ctx *ctx,
 		return 0;
 
 	/* Bail out if the device was already attached to this controller */
-	if (serdev_ctrl->serdev) {
-		serdev_controller_put(serdev_ctrl);
-		return 0;
-	}
+	if (serdev_ctrl->serdev)
+		goto err_put_ctrl;
 
 	/* Bail out if the serdev device was already created for the PCI dev */
 	scoped_guard(mutex, &ctx->list_lock) {
 		list_for_each_entry(pci_dev, &ctx->pci_devices, list) {
 			if (pci_dev->pdev == pdev)
-				return 0;
+				goto err_put_ctrl;
 		}
 	}
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261105-pwrseq-pcie-m2-serdev-ref-leak-f521e086d5f8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

