Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442180;
	b=fgHaYuMYQ3eFUzyy9S/4T+YwtTHoyonoWAhAHsIgr6TP/YR3rqkhZaz6kOaHWgVe3UXm
	 e1Wom44JphutOPR7cSHm6aZS9kkC55Mx2syBTQfNruM0kCWfU71yf1+ctxnG/C+pDCND1
	 CIVI67hQPMjq2VpGm+Vvurn0PB0h06C4m9FcDq/c4uqNbRg4nE20H3YCEv2QSMPfpLbEl
	 5sdEmi1jItwzfW7Akm1QBEjztiO7dv83+N7mXm5Lxsb+seMUrpQXB0SowBKEPJZN0iiFf
	 AMN+VzgJGXKFmtTdbs/M5OkwEDkVKA3FiVt7Y/ehsP+CM3R2P5x3B+koAbm7Xm8dkwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
	b=unDpLVvU7s23Z4+txYsb0nGCNWvKw+JEpeE2xCCGHR/4s6Qt9305vJMKmkJY1nf8k6v/
	 QSFHKxKN3cuo+XiX7aPt5n9cQHgfIWknWC+iHM71RBeswhAGxjiAFYGwvZieczrJaBp3+
	 1H3U23fPxxLcWoXlY0MX11w0IO6tHK98EVATrzfHZQgdVGkyP5K9bSNnbkTcSBBncSRAS
	 nENC5oCxVQ3gQsconUO0vRNK80M5axLXoipvoACPOfxAQRMRPGLT+cWNl+DMEKA+BaBh9
	 lArbQLjRlglDUK8VNDY5sb5tWXFq5cD1/xX+pVQSqFQoZQCRKK2u/KKra6a1wY1D24A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPz1nG6Q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ihsgwavl;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1360A2610
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF1360A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OPz1nG6Q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ihsgwavl
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL6uN2086193
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=; b=OPz1nG6QtqvIY99R
	0o+9QwtfAkRZRg3EX82sz02jE/W2gYYcXfYGAeun/FnN1X+ybipWWnkx5zydDR44
	vhpmn937JJ8xY2FqFNH57FRsE9AberMNL+oH1lFoUkKem9IOaZ6TAy7nDwm5rTEO
	Zk+zPbmZvBWA/K/abFU5GYtulpQf8TrC/jdYEZ2ROs1eTah8on57BJV/EeYeybWd
	yaUpQsjKO1CtvYKvMPze8OWzoV2X4XbOjmH2CD2ncePKX8LEy8oErwi7PqwhkKsq
	5yomR6mfRdJqHiIcOq8YroygOyIN9nRcBRbDsiGp5HKRn9EFGGUiqtvKKgxJBn7O
	/OZWpg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy01npk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-94960bd17b5so560456085a.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442178; x=1796046978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
        b=ihsgwavluhvVp8oGwO3hrlf+SR8+eZcJsJyonoQFrzfXF7HsLHP+YqKLoDjkOonBJz
         UTZqBC+OGL8s+nXHU1hDpGfBuVjavKyK03ckMKHU51Iia/gXAHID7gw+iM7G64/tRbFD
         cPkS1Ym6avMv8lzQCIa9RMMHo20hOu5+W+UWzg2aAZ/tb2YrM9BitryrkZW392uPbFwf
         DRSzdKJtnvSfIiUlMlLZbyPHP1HjGgkZJGpE3MeVtBBgRrDL8bsLy183QUNyyCmfLxxy
         zRcaZQYX6oYWCTKs8OzFQRh6NGOQxbuhyPHsJDfWUNC3VN2yaeP877A+48bZ7iD0qZnm
         Hd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442178; x=1796046978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5Va2F2EmJxKCX71IGxuO/VT6wpOAYxJK3OKtAsPW2Y=;
        b=tZHKbNb28bfwDXas3ROBx64k4WHWsWK0mALFOkU7ujQ0tbd2HIwu+Hoth+9tAJvCi1
         QLvqflAQUnk2oC8RlNb4dhPH9I0+pFgMWqmN+CjbKuQgIN6AslLiWrL0f0vtKbSPIMqn
         q9Ms1pUOVnFSsrenVX39S1idcUhF6xegwh4VOjcdbpe0C3vMGBlHl3QVvSzkIezg728i
         u3iB83edQ7b2M9HoydYqtqa2LGY+XMwG3wV2OMq7CAkAHK7jh6QpU6hSCKIB9BI77VEX
         gco3UDnrhcfYMd6rv1Mw5kI0Arv/6h0NzrXlVWGsrGWHNJ11kZ5Dy2OiJhK/32QtIc7i
         2WNw==
X-Gm-Message-State: APuU4Z/NGgyDxuDpq6lCQsp+zirnBjpdN8qK2KMzwS254BXSvu2N/uS6
	DgV/d7HR8N0F8G6CcJvi2ULr7KBIBm4p7vLRuUqzNT4q24yVEKZSBXtLaNjq5HJjYOrPqZDqpIV
	5aNyv+JxFeEubaz0GiWQkbrFKLa+W0tzlWzbemHYrkv6j6At/oYuKn+IpYBUzJRA=
X-Gm-Gg: AZFdTZfBIBEeEKdPfSTItLL7gPle95pi7X0txxdAzltA4b77/zY104cv+5KXGLXDKIT
	CCX3g6IGlGQgIZOe2Pj1WebPwsvtTycBrHP5pNXu3kvPUqM4HmgFTpLdvBqhz4x/Gh2h+nTb+G1
	7HnjZy8sCz2idIs+S8Pp6oNU4XtZNiFoU9F5GkkpX3/IuNyg6QeyQK61XJcPwVpaUJmQqQ7khAs
	M7Y2DkZcJN3fi8iNPcBd12lkaM+XvaMyK2KoI26hnyrE2uPosRMGAzPpik7piafc0Ngf8vOR0PH
	cV9pEktg9uUOQhiTI96+iQuuLd21Fn6dGqk1thXvFkiIVbdVXTjHr/woOsVnHCODsVQOwC0wF1S
	e2KtMpg15kAL9mlUwfMiN0n3O5+iHGLlMhzW8cEdoqjQNxy21nw3Z8hZzPZf0hRlwsaunpDvyFa
	1HJVRo/mL/c1hHXE0BFln1+N6puOvRWzlMKuIoagdD3DiQmf0tQFpNERHvt7bGE/fr7IGT8YX5E
	04uy2Dr9E7CzP4SAQ3gRDBeIA2a
X-Received: by 2002:a05:620a:2605:b0:949:6d5c:3fff with SMTP id af79cd13be357-949ba9acf03mr1821252285a.44.1795442177782;
        Mon, 23 Nov 2026 05:56:17 -0800 (PST)
X-Received: by 2002:a05:620a:2605:b0:949:6d5c:3fff with SMTP id af79cd13be357-949ba9acf03mr1821247685a.44.1795442177277;
        Mon, 23 Nov 2026 05:56:17 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:16 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:10 +0100
Subject: [PATCH v9 3/8] Bluetooth: hci_qca: Set 'bt_en_available' from
 pwrseq controllability
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
Message-Id: <20261123-monza-wireless-v9-3-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX7efC4hXDQq3C
 a7fnnXAbCEfeTcVIOt/xqGfIYSWqQWQNbZObWorgKQRnFbKkt0Qi6umP9ul/sC4TseqK8c9dTVq
 Q/1xW8qFpufM89k30/z7WcpHOgREwE70Q5ZczM3EJDk8C0BGVgIMuvWOKufAkO9IjZ7opAzUTnh
 eK9Gw0ImVNNFpQoOmusu6yKEB0C7t5CUgaLujknHuyfE6LNEjsJiTn4KtDvbb8XUA6mW9comeRB
 Lx78AAgE9mTXBUIXoX8tksB05g2q0CaQCBFP9J5aE3N3K6U48sJdHGUxV4axhfbJkshHebLuc4N
 Sob4QdPxoTw9FhAvHZhvSMru/avFLZVaDh8SEZylx/O/c3Lr8E7FvGCQNqBzuNLfT547Whkkw7y
 m04e2R5hhjf5nLUTtTeuauD5LdMCEHdsmo74Z3NLi8Duh66Duc5H5VtN+wAsjaFALqAMAyKZqKl
 9bNe3ZsvLm6Y8ORP+NA==
X-Proofpoint-ORIG-GUID: nEKjlhkBWyQMSN6qG-ynjgItFMQtLGnq
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b044602 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8YyhkPy0JF_pzLATneMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: nEKjlhkBWyQMSN6qG-ynjgItFMQtLGnq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX7DeyRGaAeRib
 dy3FmG3UskB79k93JuNk9MH4Q65NPrU1g1gPerSirKhaSTBPBQ1xcuCknZnPiM4NtBH0OrTcBLU
 6bFW5lMb3J9gcVrjx8Hx3w0/Ox2XbJc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5544dff9d10b5064797d41294b126fbc229a8dd5..3c0239e837fed7ff8d8261b0c61e5163945d157b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2632,7 +2632,24 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power && qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 * The descriptor itself is still released by devres,
+			 * so dropping the handle here is not a leak.
+			 */
+			err = pwrseq_enable(qcadev->bt_power->pwrseq);
+			if (err)
+				return dev_err_probe(&serdev->dev, err,
+						     "failed to power on BT device\n");
+
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1

