Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429546;
	b=RddjTJHVrK7Dme1N3FBdtar2sDQRY8siBdi7jaNuMkg2q1teuIzfK9tTHu7gyv9o9Pqn
	 K5P/qUisvXvyp7qC3Ym1p8rVoz7+CAihYfPujmuMntqgr9Juycr3VquA9XAUa6xjThPpn
	 7BZ6ioXFXlXEJ5TCIQfpS9qEgFL2i1NiUzzFqj8qpvEw+3KGjreYZojuz3UjNqitnpvu2
	 d2kO1YpY30+47LOdxAhzo4F9kAGhN09StcwRf9W7nbgk1vqayKQAe6BVJys4z6DdGREco
	 IeDtIwAR6XAZKPl5im/SPDUz28cik2FckX7HrxCVTy6QS9thcMybmUHg3QbloPYiIEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429546;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RyL2h8rRzpp+gpzd2jMK24Y7kpQu0aCp0E5ZMxcZ8dM=;
	b=RbPXWWdmw/1/BalrAXYQjZMdyI2JePrmEbNk6ojMxMMgEKNAjtS9ewCe7DsYVoRcVBWe
	 hAhdBPQhtK2nDSvvJGw3qzs8SYoGqIWNUd2ivfzbIJUAcHu7BmnsqUxcOzSqrH+b2Zqm0
	 C/FPAyFNsQ2Ydk6hMuFU1GNia9kdJREGsYf8lSvsg2dnVNpyH1s9cGHjBi17aK1iw7f6S
	 glCMXG7dNbJsKIIDdSLvONVrPTfFSfAfXcBR3aSuU+BpME4aPauw77IDoWREZRVkuIE7K
	 JqEbYkO+1l0Siws3fZbBHEeo7Cqe/z7snSfgN+BFcLNgPKc8AVxQ8r7LASTIaMYem1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YQMJUnok;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SdCCE2Ia;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027960A2602
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0027960A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YQMJUnok;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SdCCE2Ia
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G69G1899666
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RyL2h8rRzpp+gpzd2jMK24Y7kpQu0aCp0E5ZMxcZ8dM=; b=YQMJUnokdQqqXjQQ
	QmNUh1wJ1gG3fVspCItRgIloefTGB1mnctBdSGZ4q+6QotxjRyY8ofIcB249WSAI
	8mm1EDiYN5YDDxkImKVwssrXBW4jMklrxIJo/IuHoYR973KZ2RDTlwmL9NPwxE+B
	W8bmxqm7EpCeOLQrlq0rAYz1uudJtT8DBkNXR4gFEtzPznyptMTImFxrfPqFT4qL
	PICxDBfXZRxxG0IGMc35U2XpH9w8G6AM/Viopd+ziIqBzCz32Vty9EuCArHxRCzG
	A9L6cupAw33u8vYlHTrvqGpC8zpvmusOO1F/cC+4oMW5hJv+IhvgnZWvCCXAo5by
	wFzHuQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k0xke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-94961511b61so534061585a.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 02:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429544; x=1796034344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RyL2h8rRzpp+gpzd2jMK24Y7kpQu0aCp0E5ZMxcZ8dM=;
        b=SdCCE2Ia9lMS24lOVRB6IPL1wQGjR+31eptDmf0xKdvpRE4yTk96meZYlOGf9yyS4i
         fKw9VvFHFmG5rELWJkLVb7kcwM6DeztQfRxUAwdspX6IyFwhqGi7gASuZzQEIHtBG+Qt
         0Wk7shylj4U4t6L1Q/5aQvXSSYRfs0U2LZy2MVM3u4TK+TuZX6/8xA14k3NR1Fk1hh7R
         73saZAT9heW3kui9oHUvEzgmxW+fjPROsmPSMzBA84HgPJm4Zly0oYS80ZlKBSZjLZ70
         rQG82JMe6zBvLvxfv+i6oMcSpPMFnmOiw67gPm38VPh1ulT+BaZAEcPuPy/ttKM8lL7l
         gajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429544; x=1796034344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RyL2h8rRzpp+gpzd2jMK24Y7kpQu0aCp0E5ZMxcZ8dM=;
        b=Hbp8c0bwSoLF+JaczS9TBV+51LR63moSk3BDK251N9xTdoCrFSSJ1rXs/BmE/if8qr
         7o2xpoLxIl/UGJH9xq74MKrzX9laOAW0CA/OKipnp4OtYDD7JLjTMzX6vlJwWv1cUdIb
         3UqOvxKFm/NPAdenDrU78uMS6JBIFFsubP4rqOeEEyVt5Awe0h5fW7bDvluSQHl+om9E
         sd0cug+5l5QDu6m2vRIt5zGJoamtdrXS4ELdN60Fz8knS9EehP7lI3xJKuabcrxLuXG0
         Npzdea7P0KWo/5IVorgMu6Zw4jDCpEEXP2ZP6SSsP0/xbBQanTXRwsV8IWmFw9UvhvKs
         o5sA==
X-Gm-Message-State: APuU4Z+25+AQm7hBcGyeHQOTCrG5gp85jtqFb/4edRTuQj7LodEfoD22
	k3VIRfysptFfJJoTIS1wPFsABx+3SrfqIEsUs022oabAitp5zkAnSD8j80ohU3iEPv6qp3U6cnR
	Xi2TOXHkhIcOhyXg0IJ4yrpcnkdkyAwm6ouFq3QdsKppeLuU52+JO9JrhvAnqqSE=
X-Gm-Gg: AZFdTZejMwO5qmBri1TW8eA2u32rxGmPCwSW9yRR8Qr3EcQ9op4x2K4LSqGNUr2Av5v
	CK/KIL94aAnIDrHVtyFRItkewTToEMswXWtvhkjl0cmYh5CLDu2GIc3mz9yptyTk0/MTb9FQoXr
	+5DvjSuMs++lIcBAkCpTulEXZ6Bfuu0oi8nfgsBtlul9rRii+JnYlNSo1aQPDBAmEtKyWdzQPji
	CRCa/j3lk/STAWqWnpJWuGWdO3EHsLwYchmzZ/DCMPPpXgCoau1mPzO953REhRU6qIhtaGeJJMX
	rQgLkMpg3aEF9KPP68AES1fNrNzqNUeblhptLljn4YRS1NyHddiUT774plmIu0ok3JYfw5K6CGA
	kMA6i1pZeGQe2LWjHvW+321FTzBi6nmQRymfVOqjFf29hx7LEsRnICBz6EHS1d+iei245vbp8hP
	4nd4L7u791GWnYaw1Ft49C9Ionh4EaCPdTfMiO3Ttt+mhIV9qZBkGTw/u6AixXujX00oixTOSAQ
	YvZk1q3av21uuGZLi6TVjp0zqdS
X-Received: by 2002:a05:620a:a403:20b0:949:c967:eb68 with SMTP id af79cd13be357-949c967ee7fmr965737085a.1.1795429544388;
        Mon, 23 Nov 2026 02:25:44 -0800 (PST)
X-Received: by 2002:a05:620a:a403:20b0:949:c967:eb68 with SMTP id af79cd13be357-949c967ee7fmr965734785a.1.1795429543925;
        Mon, 23 Nov 2026 02:25:43 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:43 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:36 +0100
Subject: [PATCH v8 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
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
Message-Id: <20261123-monza-wireless-v8-5-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX40YjN4R5UZiG
 0yaQVMMcTifOX9V8JI1z7TWbH9ms5MATTdQNzlsZKD01uBg8OWkw2/D7MZxNwN8w7bIoDHHAspq
 9Ao8xE9j9NOJYfRlaIdG6rAfjgufWr4=
X-Proofpoint-GUID: X5EX-aQt0eHAP5TgkwppDG2dkc6mMS4W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX4F7yMD95Xafp
 VcOk8S3fSrahP/JWLEe+6sUW1WErJ14+EHKNk/TuZgf7D59pSGtqn6fkpg2Y2YPrUO1erAS8SAm
 AbH7FGfs3KlE7w6Ji8EkqJiwK8o8p8yC1llNDFyHrkwAVAvkxsVTm+fKgXOxru3DIQt8l/Mo/D/
 GO4AoaUEznxbrIVwxvBw3jmCzjc3i1ASUk1ctv1RzhogVPprm/Ow83D6zB0dPvioxI9p43a8EWU
 bXKCO4qKQovmGT3aic1RSFTeI55YZGWLFr63NqHon7rBnwy2t/d/biK21I+yh/HTism79luD1mw
 eTmpFA33QRGDSsVqHmWAGK594YOlKcHP6rcbc3+RE+uvkjDjI4iy8KNOxVWoz75aZVWTrWo/hv8
 MrcFGEqFEmhl8xsOeqswoOvETLYjAUSa7sJyE8j50V1VkP/JlDok+Mrmig5SI7Vik5qNWRkTt2R
 YH9WEeH0Kk/HIibEHZw==
X-Proofpoint-ORIG-GUID: X5EX-aQt0eHAP5TgkwppDG2dkc6mMS4W
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b0414a9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CW3gqymaXyTMcD2nhgsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the 'uart' pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 08efce663eea4344db8dfee2a92eda686d7c97e3..f8b572a5c3d2d373993c49bbdb7f7ae7c9fb9b84 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1907,6 +1907,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power.pwrseq)
+			ret = pwrseq_enable(qcadev->bt_power.pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2456,6 +2459,9 @@ static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
 	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
 	struct pwrseq_desc *pwrseq;
 
+	if (!qca_serdev_is_m2(serdev))
+		return 0;
+
 	/* The pwrseq is looked up on the serdev controller (which holds the
 	 * OF graph to the M.2 connector), but its lifetime must follow this
 	 * serdev consumer device, not the controller. So acquire it with the
@@ -2501,6 +2507,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2511,13 +2521,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		if (qca_serdev_is_m2(serdev)) {
-			err = qca_serdev_get_m2_pwrseq(qcadev);
-			if (err)
-				return err;
-
+		/* M.2 connector modules are powered by the pwrseq acquired above. */
+		if (qcadev->bt_power.pwrseq)
 			break;
-		}
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*

-- 
2.34.1

