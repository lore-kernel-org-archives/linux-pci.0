Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809303;
	b=3QMhoT4wlNI7HMzB+eMcTuBd98PieUW+kJj02ZuBnbIK9BbyGf+eWH8FWf9mOMvY+LjH
	 3QRBrAmAaCE+qwyULzQMKGX2zgVlw84O+QltMy1048CSSIPgEiXY93uo9jIkCbv+jG4j8
	 OPwlj37GC+FIxAZlmbV6EvcGaKRQth3bz7obCcs5Nd8pR/R38XGVf7YLy2cfkayJH3K3r
	 mAh+oXiyDaNXkfzdPCpegtm5RnkzlPz+V5cu+KXKmSu7A3uxksenTPi7oF/Mc43FZb8kR
	 Rlhfhn5swriINGEA31ylFeQDZilxKPoo4W+8o3IpDsSP2eknXL4vyQBAcP7snewnr4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809303;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
	b=f0RznYk8Eo4ChekHVpv5U9Bdgsr+SyG+n7F30aCarqarsu2xWRnPoXLyrYEn7g9kdujB
	 +7T60/eAcFsx5KUEWK8oCiygpat0DXRGKIiX8TqO+dqgAb2p7d2+GIyar8vW1eByGsRCm
	 GVdvkNn1k99CHQUn7kNWD25xrJGXtWpYVsQ9e31eonRyc2uWn3vJOb7RqBEQ+dNBrX9y8
	 ij4PHnnX2CQeQoKe8NDKFD9sVfx4RpHft4k1ZFE7eEyCt1dBffHZZedpiUuJ8SQE7U7gn
	 WBW+IiPPCtwu6j/jZ70k65/Au4N/TVfrL1423A2zsdoh8qFZeMwhZSbJnVBhPaKDW7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=khynQdHt;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iLN92zQa;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B77606AAD1
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B77606AAD1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=khynQdHt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iLN92zQa
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FjDli1899693
	for <linux-pci@vger.kernel.org>; Wed, 4 Nov 2026 16:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hiY9I6KwNBi/iiyCvRtimm
	zKZzjCthBLith9u4obNsI=; b=khynQdHtxuXUlWFgn8YrPPweRXKoorWUjVEj9R
	g+naBxh1weCTOQl3ix2Yq8nKsy+wgbqksAcUP8/Ww5M8BBtMUyph/q+2MRqpQLPK
	ynp3STPPgZYOj9gFXPWmFxgr1Mi5mk9sqfDwHomtckz8SG3hFqM7zt1VoYQkOGas
	hz4zEm2yZU7vbHRqvEPPkdXNBq+b/OawJLTQYoPQBDbPF+cBeIhy6hQF2rJJTzoj
	f0rgRN5Gz1kVwy+Pili1w5wR3rDkzvxkGC8PEoeGmlL258P8eKlTqBxyyXCl3WBO
	BeJCZWSqF1nWCHUOlnuz6PVx/Hu+vrDXsJCj7JqcGLvsr3Ug==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqvsgb0f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 16:21:41 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98c73709b84so675157241.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 08:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793809300; x=1794414100; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
        b=iLN92zQaYgz5ljd3Dr/894RuBgk0jDNoizjVY3JidRAuyVKXb6LlzBkKf7BMB59JO0
         pHhPhR/ShoUZHY3yVMGTOrnRE0wk+dFXSXNKszpD+vQEngzNw49ewU+QEr5IEb7CKh0o
         +2R7LAlVqVY5ciJm11u1X2jkGsaK5MonSDQS/6TJt1Lhm9ub7dbZF0bF9Kva2SVxEYfO
         pixXHzgxzIMBmL84d99j0gPzPyKjaPiocB7Dkgp/vgkD8H26zR2Jjm6+pdvEhpUIlPtg
         lxBwxYglsvbPZ8TFqq7j+EEgHZJ5C+HyvzqQtriT4rM5FUQJAewmK+BuKSgUKB+Eae7E
         JzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793809300; x=1794414100;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hiY9I6KwNBi/iiyCvRtimmzKZzjCthBLith9u4obNsI=;
        b=B///HWZr4IczQRc+XP3Bc/MYX4h6AGgHb7zhK5AV86cKjQhhk87Wuyvf7ErlzPDApD
         QUFxDXiJtRNnyUOULe5yrfuefvtICZLkCp7zknFfri1KtwKTPe9JysEuJzJXIHaK2lv1
         w/3flxYt5DGBsJg4EzNY8OWCLZy3dnZY1Jx0QX8X7a+dFmSXH7E+Cj07R+LbIFjGWEZ4
         2JtRH8hLFs53q15U08h9/QMOAeFkv/W6XFhvMFdnjv3cL9RV2XxGxW0zliMrSxv4VxI2
         PR2+Gxaeq/jIz8RPgNbbeWiwR5znT/sjnRvq+yt4/4Rbqtkav/lv2cSqjphbKLQ+kUMe
         jMFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUgoh2nBR+2uauqXseOnoQwYJ9uEh3E+0eQwYvUqTlxUAZuNt1VCbHSyw2mRtjYZCuZ8D2rLdszIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Friof71OJdKDI6A6igHYfgyYU2uiJJ6hdm8mgMO5q/ZhQ6tDM
	zHXUkU/4E/PNtwY6DcE3nh0iAVXMukjKTpBiIJZXNHSbwNoECuU+heDL5AXtOxN0mQY0Gbnc06l
	KVJiSbOZdAm5u7FERanzWw8YSUg5cCPaIrAQQHiys7fOkVghtHG3dF4DWanlfV7g=
X-Gm-Gg: AYBFou2W4i56Sa7adG014JAh1bhAMmrDP3ArJ2oki0HLt3d1z2HcuIzuVHCw8o3shts
	a7VdgA8Cqf8hvav1cH6SAm6yec0oK4S6rWAX1DXadqxo9L6HvN6ptUFBlLAQFcuRL/omagrvgRK
	LLOReC1e36Wto6crSAV26uYfatguBj6B0o62AuxlX3CiqE3snHoJu1F6eF5foqd37+XoJ7q0f0t
	ujCiwIgJxLOeKe1QOpdKfbb9mzZea4dN2z930nIx3VJhSlH7D4b3i3ntgYULadWcOSxb5xUf3TR
	dvb5Yxg2jlDa3QJqJq4FATLQWFrTNdby+hPsNVrcUGPBXJr2LfHrvB5SfYIq6DPysTIWRGxfdCN
	LS8giEULsotw1buA+cCqiZLlb6oDlDGlhAGYP+1KB6fG18c1nfQrtIYc/NYIV5mRMUG4b57ACSB
	0HGw==
X-Received: by 2002:a05:6122:1346:b0:5ea:e197:93d9 with SMTP id 71dfb90a1353d-5ec689cf04dmr7881261e0c.19.1793809300273;
        Wed, 04 Nov 2026 08:21:40 -0800 (PST)
X-Received: by 2002:a05:6122:1346:b0:5ea:e197:93d9 with SMTP id 71dfb90a1353d-5ec689cf04dmr7881216e0c.19.1793809299708;
        Wed, 04 Nov 2026 08:21:39 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aaa4b91esm138706365e9.11.2026.11.04.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:21:38 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 17:21:34 +0100
Subject: [PATCH] power: sequencing: pcie-m2: fix use-after-free in
 pwrseq_pcie_m2_vregs_enable()
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
Message-Id: <20261104-pwrseq-pcie-m2-uaf-v1-1-0ae1bbea9533@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAI1b62oC/x3MTQqAIBBA4avErBtQi6KuEi3ExppFZko/IN49a
 fkt3ksQKTBFGKsEgW6OfLgCWVdgNu1WQl6KQQnVSSla9E+IdKI3TLgrvLRFLYUSg2lMu/RQQh/
 I8vtPpznnD8lY35tkAAAA
X-Change-ID: 20261104-pwrseq-pcie-m2-uaf-a10209c3c4d7
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4813;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jrKYHbzHuQtQDH1LJjU1wsAH7+nStAGDkNwI3EwYo/4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq61uRKXGWBdRrvCWYVcvySwfBACYO/OgtWSoo1
 sH3o/YY8CaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCautbkQAKCRAFnS7L/zaE
 w/93D/429Cp5VXKSuk7vHjuZgz2bxK6OBXmyg+UxhWJNt3a3nWo8uf6x/Pdky9bSXKvULi3jB+5
 o83Lo4ohWZAoEzbrYlAJgcphlNxtxzWuZMMgP6yVmfK5UDdpxZYHtvvYTmY4ykmv88r/I99dDTN
 CAqKLvRruicC1Wk6pVmdYgMQ3fnHeDGE8bcgWrwT6SROynUzMKqRhLToaq82aIj0IGXUxISBE7d
 73/iOuPMsuEUWUB0ueDIq74J4dHhedi5HLW+WKClWxJBqok9EOUhImsfTxbgNqnSYM+e+sy9A7E
 1chdLNuXKtEfz/lobUGwVlUXaE6/k5tdSfOgeptO2HxaWbktFFoN8ZTkfzJLtwihwFrR1915u+C
 0nQaRYajsErdHDAt4xZhplP6rKrGnisuM4usHmgm5WXdw3EFE0lxIg9OkDhfF2boEh4F+3c3ma1
 tTaSZ8tdvhUT8fDQIl7yJCamrScPkxjNV/vzdOGl+37wOUsLZHMkIe6+eNf/scoMJitD+DBuzcv
 bp8UODhN8pT25NIhIBhyhPl9vK+2JHwsjKJuAcdE7tEg71E5vA4zMWGammiRjVtIdRsn605AWKb
 Fe5LYBkw8SKoIkP5FSMYwinDiYjhVdbdaOhdKKtN6CDnsl13tR3xHIqIO4UwuB0NqOofDWVFy0U
 nZMv1f6vrg+A/bQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=GtnXaU1C c=1 sm=1 tr=0 ts=6aeb5b95 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mM_0bNS9DA9p5V46oFgA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: Sq-gQNNfOc0BabNoclwMxpHLKt0L3iz1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX9/7wBfjb9HWW
 y3jqYTMVFF27Vn6MTL6yMpK029g6DQ0VxY8sUz7fRFjOiq57F4zUNtu11lS7GUg0O7YZgWw4aWU
 msfTt+/54aSxu6h9xaFCPYme18og+D76PFTxw+oto+zOOlfi5NNMHUfUk37OeJn0DaXKVPEznUK
 CwmaEm2D+3M+GdCyPnWZYT0g6AteJ7sYkiVjDPXbi5tSGyHZ4o7kKyI8D5K3inrXq0feA3EMwZQ
 Q7GOxUws07woVp+eEtorQN8RbkU+WpRp5/kHl9xxk7D2eWjvWVcuHI5Id9wGgqK5p7nxPSQEfqS
 iAAbU1j7OQ7WH56QjndSPF67FK6gZd80n1XVkLJ2wUjmPxOMh8FmkPDGdOG/T1dwXbry2w4YHl3
 9R8aCLNuyopwbwPDY6zPQgZ1r5vuLeLdBWSoL1YhuyvxFLYo2baOcVxFbcxS4EB21rWKcmAhIi6
 7jiaxI5VYivDh/BAMdg==
X-Proofpoint-GUID: Sq-gQNNfOc0BabNoclwMxpHLKt0L3iz1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX4ByEgY+KurtR
 UkfFELZNUc7XEl22tacnJ7vd+yxTbMZXXTYZfSVUCeBPnWDpMome8KwUl9IRZKtBwOMTEmjU2L6
 NMDYKYF0IeTCrjlcAdHIkSqDvuil8LA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040065

During device teardown or on the probe error path, a concurrent consumer
access triggers a use-after-free in pwrseq_pcie_m2_vregs_enable() or
pwrseq_pcie_m2_vregs_disable() due to a lifetime inversion between
devm-managed device registration and manual resource cleanup.

The driver exposes the power sequencer using devm_pwrseq_device_register(),
meaning the device remains fully registered and accessible on the
pwrseq_bus until the driver core schedules devm_pwrseq_device_unregister()
to run after pwrseq_pcie_m2_remove() returns. However, the driver performs
manual resource teardown within pwrseq_pcie_m2_remove() and the
pwrseq_pcie_m2_probe() error path, prematurely destroying the backing
regulator array.

This creates a narrow vulnerability window where the globally visible power
sequencer is backed by freed memory. If a concurrent consumer invokes
pwrseq_enable() during this window, execution is routed to the sequencer
callback and dereferences the destroyed ctx->regs array, resulting in a
direct use-after-free and a kernel crash.

Schedule a devres action for freeing the memory used for the regulator
array to ensure it runs *after* the pwrseq provider was unregistered.

Cc: stable@vger.kernel.org
Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth")
Closes: https://sashiko.dev/#/bug/linux-bd17e5b1-a000-4717-b392-0ff0c2a9c376
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c10faba6c978265bcd07a6980d2a52..a794e2ad6a9c8cc71b1ca426df92abdaef8aa85b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -533,6 +533,14 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx)
 	return ret;
 }
 
+static void pwrseq_pcie_m2_free_regulators(void *data)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = data;
+
+	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
+}
+
 static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -561,21 +569,21 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get all regulators\n");
 
+	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_regulators, ctx);
+	if (ret)
+		return ret;
+
 	ctx->num_vregs = ret;
 
 	ctx->w_disable1_gpio = devm_gpiod_get_optional(dev, "w-disable1", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->w_disable1_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
+	if (IS_ERR(ctx->w_disable1_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
 				     "Failed to get the W_DISABLE_1# GPIO\n");
-		goto err_free_regulators;
-	}
 
 	ctx->w_disable2_gpio = devm_gpiod_get_optional(dev, "w-disable2", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->w_disable2_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
+	if (IS_ERR(ctx->w_disable2_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
 				     "Failed to get the W_DISABLE_2# GPIO\n");
-		goto err_free_regulators;
-	}
 
 	config.parent = dev;
 	config.owner = THIS_MODULE;
@@ -584,11 +592,9 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	config.targets = ctx->pdata->targets;
 
 	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
-	if (IS_ERR(ctx->pwrseq)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
 				     "Failed to register the power sequencer\n");
-		goto err_free_regulators;
-	}
 
 	mutex_init(&ctx->list_lock);
 	INIT_LIST_HEAD(&ctx->pci_devices);
@@ -613,9 +619,6 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 err_destroy_mutex:
 	mutex_destroy(&ctx->list_lock);
-err_free_regulators:
-	regulator_bulk_free(ctx->num_vregs, ctx->regs);
-	kfree(ctx->regs);
 
 	return ret;
 }
@@ -627,9 +630,6 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 	mutex_destroy(&ctx->list_lock);
-
-	regulator_bulk_free(ctx->num_vregs, ctx->regs);
-	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261104-pwrseq-pcie-m2-uaf-a10209c3c4d7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

