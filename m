Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429542;
	b=gXhlXI0kj9CYRjoIuu3ajDltVEVLaxGggjSv9oHNs6E9Nggd5D1fusgiXz4U/X7HKln6
	 3bVVue23Kks3yp5dSB3fABqodaEV7cSTAMk7/oisDE8WH+FOo2W4UbwIIJQVtwUmp1Yq8
	 MVXDkXaRlGiUyZyJDbfoD0Ue6idpqoj4I/6aNqDxZ7WtMCv/mlg0fjfGZbZpcQlxZXj8g
	 SNmXgV6DzbLMRBFSEYXbnqnk8/FOkVp1g0K1tbVoZ4kIaHLGU+qoz8nNpw8eihutmpdkD
	 YNICDtWxAXCcU9DUZJ22xCdZxpYQLVaLQcVvkS7yIqMFApFiWWpIYSErtA+1TSGZBPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
	b=UuNfxA4Dkq2lyjwa8MuzXk7vgG0YZMQ2N0+XnxuwQ7z2krKCOIpE/8baNSuQalrwdMzh
	 dwF+gt1dCUED27embyGgWlYZeHlrEJPg/kStRieSUMAtc9DVsGyhj6HexxZBfUZSWgZf7
	 1CEMPL0kJZ0Rpm+ByVHEYPkaKToskMe3NZQLfXVUi1F9Px6IxY7Z1F+Ryt4rwEa0L8Fhw
	 QJdXGyUaiVl/EpWgAgiv2tQbDE+zQouO5QnOKL2WpNBKWbpiFeHIXkT8ZkDLWdSP0NckO
	 rLugNAPN/dDZvf4oWXz4H0lqgsZryGatHuPSUpa5HUdnd0qK+jQkDOzNgYnwsCHZtAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="K/ne0YAD";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eT15Du6l;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D895606A33D
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D895606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K/ne0YAD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eT15Du6l
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G4v01899656
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=; b=K/ne0YADjHipBOMZ
	09MFX+mU3kfu5RkHbTmdid8Lg6K4HetP/hxZXxzAuPi4W0dRY3DLa7rsZmLR2ERE
	a8uF5xkNBbxMMK/Jwy1c6ckjbi8rs4UjrAo4KCmaE/DiPcnL9wSPn257fTWot4SI
	5/H1Q3xOG3EroJMiTnHkXLmk3iZlrB/3z4OhdCtcWHGgR2Nvd8gOu7mAP7U+CDzk
	xqgJyUYBreB3Mdz9zxBhPSmyVPVEGcDQMJYRSrLC7o/xNVNwljkro9ybdVOlBaPu
	agB08qKosIZITVjww1BLG5pwGeyDbSyX30JfbARFcH7OjRdlXSK7YPrKSJRWJ7a5
	dA2wWQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k0xj3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:25:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f3969a2a7so480174485a.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429540; x=1796034340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
        b=eT15Du6lbqFyX3bwcEWiihPjz2qaQDBNzz8mUEIzOi29oyPGEH7vPLuOwVntnAH1Xc
         nnNpvF9Tr6I38fJWhtS1Yo0/RL0lk4F6xZ2kp7ddj+alkPOkbIOZbeXYpHl7rlCX88GM
         otD94jOS8BPz4gGnGcEvBg7rURuz5yGpcAa+89XdoSiBCqJM/qCCpqkMVBDR+ByMmOIO
         Riq2EING8nhJBSjrmBQ1VeSOb1TDXPUn/nVfEJu51Vl6c5vvOcZ4L5cDif+jz6dFXU+Q
         Rpac5u2mN3vLz9ahdOitb0LzG08C3V6Xv1m6h46gDcT2Zqd7BCzU1HgmihN5IFJ9hTPb
         H10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429540; x=1796034340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
        b=jZHR0VvHWuAO1xwyMF7ZLUEl0dliMSehhcLaPdebUCiZ0rWmuXes4HGBZAZQcLr9FT
         1Oi2f6JgwrRLTezSB7FtU8uk2QBGJSaLI2JGN/WQVVPkDJd333+L6eBm602V7A4uCN39
         fUDFj2cuXjLmpTGHW47H6YW08AlsjaQXXG7NLKEZzjVPbQfmFmqQl7KqzWkVfqlsnedw
         cSfmkuXwCMo+b1MXtn7WbWESpjOcek0cywGRqocEqiSoxrl7FOn5HO5s2g3ahKeMppit
         TBsuLthzAuQW+om0xLSpEDvdTnSoKdnnGjLq7YJ9dxPO+kf01lH2aujgUx27xiWD8CmF
         +ELg==
X-Gm-Message-State: APuU4Z+2kqthUdOms2WIHdbnM+Xe4SKj4WpvUY4YmLCY4ob9WB2J8oiU
	Z8B/maneCQj5P4EeQEjbnPOUjC9czZXnAzXyvjocFBtSYoSerX7fmQxFB/am5SjWQAZj5umdWso
	Uv/aXHTLi0vTEWC7G4QMgduKzwiaRPnd1Ymb0wr76OLhCpvCIjJYaRNKrPh3csBU=
X-Gm-Gg: AZFdTZfApBh9t1QsMhQZnI/9yYtm7Y8Y78s42qTIPWLM6taos11eH296YpCmftBksAc
	pdJV7z5vrBAakTx22eAdhBdbbaTESwu+T5GjhzAv2LCQPgCpaJ97TmrMcWTAwk50dz1obWp0FdC
	bYuo/na6CWkOFFkHOlUr3xXc4FAxMimryAmV9NetAJkGi/MMezRnKpRw/eP+HnrZsVM8l8wzTbL
	CYxv0Pr1pzMWcco4i7/FuvyS+NiLtMetR4rfAv4XC+At5uBUpuJ9hQIsiMHi0qkWKSqqH4aW/wc
	CgR2Infn+L0MQOejDyNTIeQKtHlWP7XOnKbdFJly9QlvIPLZfVBf60LGPyhWZmA+z/ze4YpdO/5
	AZExo2446bBxzX0ZHZ0HVkY3zccnoB3O9g7In50iTSBJKu1tcWeZDg1EbGCM9VyVZGHjKMyMaq4
	JjZEyn45It7GeZEENufVsAZycjAHr5chIXQ5IyrURo5njguvU9ZxMq0g0lEhO3ghn7QYxObwumJ
	0GXqS7A4kgzifPYmkmUauGSbHvT
X-Received: by 2002:a05:620a:2856:b0:949:873d:3dbf with SMTP id af79cd13be357-949bab58cebmr1771947185a.59.1795429539500;
        Mon, 23 Nov 2026 02:25:39 -0800 (PST)
X-Received: by 2002:a05:620a:2856:b0:949:873d:3dbf with SMTP id af79cd13be357-949bab58cebmr1771945485a.59.1795429539029;
        Mon, 23 Nov 2026 02:25:39 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:38 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:33 +0100
Subject: [PATCH v8 2/8] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to
 'bt_en_available'
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
Message-Id: <20261123-monza-wireless-v8-2-a8b38604be6c@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX819hdl/W/732
 67h6gxktscanfFbxRtQCCaDu78Er/yo7mAE83E7mQzmoc7PxcTt5Bf59Pm0W3Qwzno9kmsW08pQ
 36+U85XKlvhmX6UDpShBckg1s0eCt38=
X-Proofpoint-GUID: m5-ce7r3w-RAmdMPjdx1C19l0GsxXbx0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX+9IgCE9kUag0
 +a9MNu7WGVfwy+04r0SI7Vha7JgWjPABEGJaC6b/eUYoZqxGfgdOiDp7WNeWRmEwcrUogorGstC
 7HaggEXcAJ+RZT0kuXK+qS5+oBXe01dO49p3aDE9ljpG++fZqAH7I/LqLFS1c1JoU8DzSGE2rLG
 aeENZdSGUGRHu2AAyddUDnPQUGXC7O3a4x9774eGcv/lhW6ma0Kji5w6rDtx1nqqbyryyQlLXb/
 3MKGppd0YdAK2GRdc/0pj2SS2NxjlwIHIc9eKGcGtTZZ5SX37BCh40CvBIsihJnTiyGgSU1MqKf
 ala6tP4eJc4rFYDAKR9WyS08bj06lHVeTMcUUsL0iKR3X75sVOVtjukQonzVqnlIcyFFcSqDY4u
 ynhfqytGgPvzuLt3LrtUdhe6PCoZaom09r45fa3N/wOC2St+ezcpM04e6rE148DizVwmA25lfwS
 GY+oSrKTt/nzv4+d+HA==
X-Proofpoint-ORIG-GUID: m5-ce7r3w-RAmdMPjdx1C19l0GsxXbx0
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b0414a4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
GPIO in devicetree. But the naming causes confusion with the new pwrctrl
framework.

So rename it to 'bt_en_available' to make it clear and explicit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 998796ea618822298d7f956a00c6c50f14332363..3b2792a3639cfbd9ee7a781b6e4c26c660495391 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2477,7 +2477,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc_obj(&serdev->dev, *qcadev);
 	if (!qcadev)
@@ -2583,7 +2583,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		     data->soc_type == QCA_QCA2066 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2622,7 +2622,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2640,7 +2640,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

