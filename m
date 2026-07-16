Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB437E5F1
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218723; cv=none; b=kU8Kqv5O5vrS9DsB4OmDEsK76657t5TxWxjNfgG1XkfxDEY/4mkO6361zJKvpchIjuagcYCH2LBJWUyT5MAvaURU2aV1eHgbpyBcsrdqYk6o97EjDyw3zexNVUj6zCQdke/FljidVXNgiYOuVMmmCVQd72lc7jD8XPTXO5v4Z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218723; c=relaxed/simple;
	bh=USfleaUVsPGQXLVUjbre3lqCswipT+fDSdHAw6xnKWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpPD84EjX0R+rkXuSgSEmrsZKet2JOxvVSvOS4AG3AuM4sm0q/8ZR246oWUvc3WSiICNeX9ISZmXpKNo1Q8G7lqTwBo3VRvzuEpTPCTSIE8gRutwbJSHBm9FGGEcfHdt7R8Bx5noymPK8ZBvCF+OpdcuviIq+zzXTgqv0MnDfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eF7HNDpK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CXRFDymM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eF7HNDpK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CXRFDymM"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJpup2972580
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=; b=eF7HNDpKPmRuaZx8
	4/5SO3m/WN8rIxWyJyqRFTfL9lRHETXR3kVhlb8C5ztZX8WFv2SBm/TlzxayYyYZ
	TlfMWnXUpU3HZrgPVsdvRLFQUwkU1xFcdnGbXvP/SfM8ZVAolffTKbtAdcpEvNdQ
	vugk7lwawDpVEjYSSZlZhk4vb0OwXs91STcWn/L1NlrFLDUJI3clQdfeQB8rdj1q
	iSQcFURn8OKp8qPFzVBS9JLjcQiefrQttOxtBpoObeSrOZcjYqEuelyiFNZq+AWH
	QY5OmoHodAV6VF3CnnsqjILym/2UpvhfnReqpJjgSPyUnAxp7+4Hi79vSAiS9XSL
	NHhXUQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10aa3r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:18:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1852a86fso77344031cf.0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218716; x=1784823516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=;
        b=CXRFDymMiEeMlPBfzWKrNRP7ePZUD2RKPUUYJEH0eZAeStuwvThBwrCr69LEEHpHrK
         IpHH9kuIze6Fc9mPrFeJ0BnHGWDHk4gFinzxRsj9zYrsQ+x7pxLpq+A/gr6zHoCGQbLt
         13/UTpKxljHA43ubS0NcASWaT79Wb1izxxAzWEI1mTuK+Dq+TpyQ/lxyZmF/3wJNfC6E
         /0DnugoewLcJ069rUCHcSk6oOTXlyoQOgb/cWsA2etKDR+nTppkzP4jLwrfM5EbJdJeK
         NXnTVcrNS8CTVxI3OZon+YaHNA656OkbWoH6OeeZJmrBm4R0EV0L7y0Pk2fFyo0c4OUh
         i1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218716; x=1784823516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=;
        b=NrWEIJFFTCr9tfhxmxe/O0Mr5ynl0HzCEDAaEbKVoAfhoa41VG41uKwYMfhjO6o6Tp
         4KcHTRtckTjM9QQywZKuO3Wgv8OnJSJoTKE0ELmhp9FL4960PKWrTqcxRHs2v6GRSg97
         IFFoYfFzIMbA9tvQZSwTT69sGuqlev8l2irg0Jm1HfIPUChDHmNh8uzDnclbZzTONTQm
         io8VIV1NCB29gV9nIsaH4HcXBDmE/7hPibgh3gMJsfY0XoEdr4bGoZt4ZcoGNQrC+cwv
         vhZ+1GieBq7Yz9FxL3KD1BP61fs2oL/carfzf7vGE39BMzkFGIvHctM/q9TajmCYCqsi
         L5AA==
X-Gm-Message-State: AOJu0Yye3RI967TqV8pKL7MRhxozkGrFjwF618y200QjLsfzIxPSOVV5
	beJLxCpF2Z1LT+JFMqf9zPqHZF7yKV3jvnobFp5c8KtcvY6WiePo4BE9gUt0tfocfJxcQa2lByJ
	ViHRMnp013jjSTx2QyhRj+i+kSUkUX8+RKqbexk93XJobv4tU7lVXxnDv60YxzwM=
X-Gm-Gg: AfdE7cm924jl9ncEp5JM5/xGU5YDiOmshc3b7ngmilS2vhmxfwCwPjLzsld5+6P59+o
	TLle8ed5dGRvQxUaRxocyqmZeHjFoVE/l7VW8ofyzJopC6/3xSdsPU05Vo21D6aenjKvWcUqlkG
	k+kwXfj6xx8oqpglI6JzKRqNGXhSSfwRXgtnfo8BMULyDIIvHx7vaevVNp0mdklq9y7fxeveThD
	AokJFMSbO9rmNcX0G3GKpU8BBBgqJfqK1Ggyro9XlUAqyzlPMmPVwr5bMnrJgeh8sUQ2LJcKblh
	Q643nwfrVTtM0vy0qH2EDHalVkucsRALVQzzbx4EXkJUBG1zKwYR0wjdwZsnn644vlKeWp6UZZx
	N3i11pZUs+aorTuDSvGfVe43lVSCwuKWimbA3TSj+QGz+doOWAOy04CuUKe932fFCQbyTLUm8qV
	MJqEIwAqhTNWBGpoC0+8k9A77oEU3+/0Gn5ew5q17RYm5BPVMAWlA=
X-Received: by 2002:a05:622a:190c:b0:51b:fde4:cd4f with SMTP id d75a77b69052e-51e4237cd7bmr114630501cf.30.1784218714791;
        Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
X-Received: by 2002:a05:622a:190c:b0:51b:fde4:cd4f with SMTP id d75a77b69052e-51e4237cd7bmr114630181cf.30.1784218714223;
        Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:23 +0200
Subject: [PATCH v4 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-6-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: rUiV67aQzHep6ZpeARctnNiZqTubI48o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX0LHEZeu6Mlhb
 gjVlxoCsVkiUT9L5bdgTNkd9VDH7uz7lDwDS6zyWTdjZq6OG9NNUvO8wAEfNA3JiqoFDVwlhtST
 +hGTpmMFpqeqgwP8mSF/9zuxCaJfBv1C3J7RLhVMtOi4CFcFwRtD3xFX9DPbffTnM87m8KipoFW
 OtwZF2VZSKPFdjQDnSKj6pssYDw1YPj/jtkjqslv4l1Uq4Vw4r4D3HPju46SK+opFQATs8HHFgh
 PT2FlsmfXZSvkG+UKkh9Piov+YyrtNHYjT22XeIcdOfycN5qIMxAS4HPL9YobxgoLnI/yVkUmzs
 MTVCvKKhT6LFCpmpZ0a7v8BKGDmKk0BOMp/o3XJ6e9cr1gWlXY++cssMgyDFDJE/OyFWIRxPkd+
 lj7Dsreqo7qrKh4meFSbHT9wcJxKF/S+NyC+QSlLh79P5zW7HWxsBFao2TD5YhL4yq7QWXCpQCM
 Elmv0GR5DYf7q9V9HdQ==
X-Proofpoint-GUID: rUiV67aQzHep6ZpeARctnNiZqTubI48o
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a59045c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=kStU6zbECEpzgAoP-VAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX7qh4hteGEdZq
 OB1f4EOg/A+YFiHxnqnr6DGHt/vA3/bPq5IK6LBnh96azjFcCCjMyGBDBkOE26qZhI65DTWMheU
 X1NJnXvmhMWHRHrtn5W+4ZQI/S3tpnk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160167

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_is_controllable() helper whenever the BT power
comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
If the power is not controllable, clear 'bt_en_available' so that
HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 17f436484e1e74d1dd690ada22134315abb767c4..41e8c302abc2a820022d1783f1fad76b358ae67c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2548,7 +2548,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 */
+			pwrseq_power_on(qcadev->bt_power->pwrseq);
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1

