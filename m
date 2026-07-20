Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17C3CC332
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534664; cv=none; b=PxpbzFgQRet4e8X8C8xOxc8FuiklRn6pnuGLZ9nx9msgvJaJoI03WJstH7gVDqV/hVqZV/706QVMv836rnzRWbOMXeysgDLLUf7DuMVDmR3Kt4C3ylaJWhloxTBUv4w4AafJx+TMc3v9z8kjJlXX69wSK/MpBHm4mROMMJyH7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534664; c=relaxed/simple;
	bh=sBKai7E3Yd6U51Yiq12cr94RwHoduXZSxDW+t2dOViM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5myPoNN4r3G5WoqCM7K5Zn2Jl2blSfYeJOpW1hUxFPQQj6GE462Pj/3YscpWVPFdfdMYPqp7GO/kd3sbtC6p68w7Gmu/D8WQNeuQ6xXjL8ko6ulmT0mh7DcfBWTxm9wGgZkawn0/HHOz8XTvs2km34KmvrGuBiBNK13DPBfHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAdJsA0f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XqoVZd71; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAdJsA0f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XqoVZd71"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6Rivn1713507
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=; b=SAdJsA0fXMRisTX8
	gVuhsMg2w0YDyNaqQFdxPmzW1jq66viAnkO93uoPrM0Y8UTQ09WR9bub79dYGoLh
	XLitIgyuQcKQQIgpWiYZGJ9b1g8uXShmvNu0wE9YWD7eDRExrLqhY8YoVoM3UP7b
	xgZbzWJE4vuvOEJ9OkbPPrk2WqJXfMVBU4cRFCID2DgIdSr/MtHQ3XdyqztecKCh
	9JIr1nW/2IceKShX8NAMj5JAZ7C+5yUiRTcWK41qSs0M1g0xK77ErlbNOOd/+pPs
	Vh/yNKINmNUkituC0alpfbvkP8ikq9KnwIyOgtOXhGdHy9wNz9u1EF/zHst6nLtt
	lXQUDQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc548r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:04:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1e6f602cso141321331cf.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534659; x=1785139459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=;
        b=XqoVZd71deCAMJlT4cnAVgd2FabGJv/Yx3oo7cDqR82VavkfqkUjRnghXTiu5n1eHx
         F9UePf5kDwgzAKViZRn9Q4nt1SJD3nojwLwC+iD3tWla7RsSRhPewMli2RJp7EAqBsIw
         hW5AhtRnBl9C1+kdKPG3PG6hZwOUhKpsS6jAJFU6AeG0BOSWxk2txQt7ixxOdORF2FXC
         BLTgT4SeLakWdIrWQYXHlNG7r4CCPm1ReXZFhXkXzZ4XqSl950Cxtuex+Oaphmycq7y6
         vEDf5eVcMeo2iM60IM28WCQN6gHt8GLRLVa86tmLIGqlPfdnokenyh5TmIdOMpdFJ9Ip
         9TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534659; x=1785139459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=;
        b=c6F4xN4k4AVWTlz3ez+zmjlJDuo+d3hgzJqdJl4nNOuXvhaJwQPG6QZcFo7cwoPj38
         2I66EaDHccSYSyXsSTOoSqHxqRD5vZ4C6TeJMdHrG96LvE69Q+82QJ1GNPXHxmqYEpQH
         blT6gy2sK38QzJNBjdeWq9y5W5EzUj1fRSVEwi7uokEFPtBA2IKuPyT3m4k4bMwgg4JL
         94catA+BW6OvYoRScVqQQSI337hWEVJCXcJ2eq98Lp5q1dO7ukUojxLKIpD0JxVavOrt
         tdFD76a9jpJGDYj4ZFOiMRlfn03xsM87vhAeVqK2YwJMVrk13m74OXLsI+QfYGM0Pg13
         u+5w==
X-Gm-Message-State: AOJu0Yw5dqbFDzWwmNrgkiekocV6lsQF/p7zzp66bk1FIUE4VG5znrns
	L1/H+E8Ja230ZCD3b3FfoQ3nGDhtllomk0MjN4w55/c2+0mKXxbL9QMCKBZmxz//50WZkpvmkEg
	t3oEq90UnQZtJ1OqXvGBPHc+jKjJuIM2ZLgptXQkvxzrv/V3aXHYN9kDUKrk2YD0=
X-Gm-Gg: AfdE7cnhrOWwOyFtivDf5/0uQ7IA3P4Ei2RLKvv/ZLQOoVj6FBty995IAu9704zBIf3
	3GC/Vo9d0UTx9KRJr4yoyoZo8MrnDPFQmBbHH/tVOSWbp77TCMB6wtRCPq7dw454zvJJZoCcZuR
	dgClIeN8PwSofW5caazipDNFSTvA6ove4SumGW6bizXj3aHEd8OXIKMXByYj4LpSF2L4nRcF7cP
	RBKU63dGXkvJtATTEb8ANpMeRdFnCn1Ci6yKlTRNUnzhw9VjzVIzy1zrY7GMVgoMFN9+3NON7b0
	kOG568YgUp2ogtVR92PvjD73C+fLvuEgMhtUsFoIb4BpIq8n0xJAE3oJWIIv1a1K9vZlxRlr/Zl
	+YYDrrtdsZnK8ZEpWT+YsDyYiDXd2U7tQxHwxxCAN2PZjIhzgJCt62v8fo1AjIL5+zLtVr6pdM2
	bVaV/mh9vZeDiLCg5zywChDFJqA5E5hWWQsis+xF06qQtyBmd8Nzk=
X-Received: by 2002:a05:622a:302:b0:51c:7b12:120b with SMTP id d75a77b69052e-5213ff50014mr113828091cf.73.1784534659413;
        Mon, 20 Jul 2026 01:04:19 -0700 (PDT)
X-Received: by 2002:a05:622a:302:b0:51c:7b12:120b with SMTP id d75a77b69052e-5213ff50014mr113827921cf.73.1784534658991;
        Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:08 +0200
Subject: [PATCH v5 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-6-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX3TAOVJBecPqH
 uhIpz6XyOhSyhowy5krrjpJ5H6Bf+bz4hEgGXU9ZHCZDR+Fhw9zCQNXrCgWlfea1eoi/uH7QOoY
 Kv/8isI4xyNVPDIEwnANjfdONzu7QzY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX8hh1nO9yeLRQ
 9291O2QswjZdDDcrJM3RDRraWUBw/NO3MikxTRYWZVjnWk6H1qSZAR8zsucsBVHpO7U/M2jLzPK
 +E2V9kgFyx4jaRTg4tXhjQiFBzRooaUAL0RuBpR2FxliR/Do2Ra9AlR2i2a78P/uHepsVeYjyjk
 PyHYjRat1+yHocYfL9cUIwjCdwLj+eD7pnugNHxHiMyuJvA2r8yw0Tzh5/VWTyVaEdJYpFtUsUX
 dIX/qGMrQBkAoPiOxgYtAsXTg6XhD5XYqfMXbvlgyFxr4u+v9Y405u0J5KUmK6L5GWpmN1LgNCo
 p13o1gLXjcLORZ7RDKYvjNSHLQ8EDK0bK2y3wBg5ffbI26UQ1d8TP6cCfMaxiLehUwac7BJSyu6
 BRKlYc3Hrk30LHesS08kK/zOyBtEsGtn2C6VlSyNM2OSJVoDh5lBndfLjkEWdLPvjwW1veM50tA
 65Pru/z+P/ejEzXstug==
X-Proofpoint-ORIG-GUID: Hf9SUsfsE5tlBFgv0jm9f2QUpY9njk6A
X-Proofpoint-GUID: Hf9SUsfsE5tlBFgv0jm9f2QUpY9njk6A
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5dd684 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kStU6zbECEpzgAoP-VAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200088

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
 drivers/bluetooth/hci_qca.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 17f436484e1e74d1dd690ada22134315abb767c4..81fa41915363ce577ad7c6f25fe1b0a69536d462 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2548,7 +2548,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
+			 * The descriptor itself is still released by devres,
+			 * so dropping the handle here is not a leak.
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

