Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719619;
	b=NePmnVqiNuvneu4T+pSiuwnG7jy0Pgnu9JzKWXrqaYz193TRBrS03VSb7eGkOtAC5MIc
	 lgiLE9TPzuQ9iXt1p5D8cjf9rLyJlY+JUnRcJhsdL5bLUtsXW+InUYnh2fnaWJSDiBuJd
	 v6zsrNSDOMxn1DQ/Flpw9/AhWOyJ9yYExQ4+In2AaKY4cg/6JOPEw8X7MKG9uVCMD2sw5
	 VX9fQaXlkPQxkZR8/UDxOq/nqIv+CDrZi4PI6Yx7f+LA/6JosmXaMgsmnoXwxmUGxiR9T
	 n21i4hy3yTIfuLzsNd/Et38JYkGKT378DWsut3Y/9UmJ7NxECRhJncQ/AkdabNdMkXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719619;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4IOae1sTZD6d+T98tKBjA43zUCmiaBBmOoNmMspUZgU=;
	b=FSZ+H6aX5+ZF6MSXSoBxqKXMPF0XrhEQmOQlfzDIPpNxNuMU4pcZbjxEgH3DuG0Soizl
	 ixaKO1Ew4+Mix4OWx7of7VI/PCkfTlHBZoxkEWCoCjks60259hCwYjmieA1vLUDXUdz3U
	 38kAYf98KRfGn0T6eB8oa6BdrLdeS16L6uFpkrvRnZHWS3uzXUBBCA4O71FXoMhuHrM5Q
	 t7MLixtJNJCvJR++ntL26fxpIUi1rqXQRmDabhNvZpOT9sVSYRD+L8Blsck6TVl+rPcdQ
	 JR1hGckNDFIHW9Vs4f6eqVMb9gN+XofM1ZMjilsmWddgGFMIHXo1cRWojjxze596T9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RORMn7lU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5785ACR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC02606A32C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC02606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RORMn7lU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5785ACR
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFu5Rl1847837
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4IOae1sTZD6d+T98tKBjA43zUCmiaBBmOoNmMspUZgU=; b=RORMn7lU6cjZUu9n
	rBkXpGhdt03vuQ/8JNw4HTz9VLUfhi8wsI2OrO0yC7CFvPDJaBQr99JQ9Bcj2Maw
	CT/w6cFZfk9zqdByUUNYzlqh88xjQ0OzDisuhWy6SUrebwr8Ai23u54uPukPiA9x
	AfDDx6k8S+uVwPRjvPBbbh25yEAr2EvqydMDhHCrf4opCii9eacFe/AF2aP+icwM
	7Y9JwUinzImZi5wFyvXuImg7fE58GMr2r7OJYntRjSyEXF4GE6dqIqW7AZvjH9yO
	9Hbz5LrBu/tXvxH3zEGvSSxHaO0w64b6/dzvvTR/vAJwoXuktMm4xitYSG1vI3as
	qnS6jQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6fw7tgpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386b8624cf7so5053396eec.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719616; x=1796324416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IOae1sTZD6d+T98tKBjA43zUCmiaBBmOoNmMspUZgU=;
        b=C5785ACRL/xE3g+whImGQDFsgV5aWS34tPslLonRiK+ZpOSAZzArTXeB4nkjxQtgoX
         GJC7uITWj/gM9jaHn90/hLejBEi7qTWRyBnI/brnTbgun5ZTke4qIC2tfZwUKNv/xJLU
         2/RtgFjXUOuOhKWnZhxqLWXir+R7ZaMGfVvRxfMgW6DMdTDjFQlhqmrIV7ItEAwhPwV3
         o2J31ENzpK8ZP6+pGzqk1vzqG0qn7Ba9VWFwdZgNGyftlSe+J2IhHJb09Cfi8qPtRY0b
         UTsfiRbUF1lx1QjryINqxZpg5ojJLNYE1P6z3wnDEHvi83UXtvAcNJpXiysmh96tmLoY
         kp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719616; x=1796324416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IOae1sTZD6d+T98tKBjA43zUCmiaBBmOoNmMspUZgU=;
        b=nuTtgoLZ0bUewZtfb/QGW4di0xpIAu+62ok3k4SEcIuU80PQ/+LaQ4TAz1r6saaULr
         SToJ1/GlkbonS/lx1HLfoDehRkh1p+BykPIdLyBFDyUfZnoSKse8ScOOKyous0XJ/INe
         js6/cgbYPKrTSDqBIj6djEpYD5JptnqdbmAxpX5O9YfMFJ3lT7voudMfjlHuA7HcW0yZ
         wiDgxEwMqwgAd51UoNDFBG5PhbjPU21FBBCSs5JvzxrAS2WDYp7gVjW9xFpx03nymQtH
         nCFxFXFawNxevbcywUrnzd8fYGVKpnW4eBDkvPcid9vJkOldGMEaoLS/AZ6YOtxJLYOK
         eaDQ==
X-Forwarded-Encrypted: i=1; AL+hErE4LHSFzmpWvyh++k3Jz8shqnRCga+fSFlPDdfF89p1adFRtRj8o5c0YXJ4+zCz79pJehjXHJTjxkQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+snsqOoPaX8mePLhmA5ywS2KvyBvendcw7bQc7p8izkmymD6db
	U2NhB8segB0Oocnd4h09+TxaVkGmecvq2sY/aYxdQY6B6jMEfSQbzWTFKKQbMFKCPZMBuSL3DBz
	nu3r5XqL/Pd6lcIaaxinNaCc/jgOIVAMW7dKGzAuv1jMhVlPmH4v/jlkYYu4Qj3A=
X-Gm-Gg: AZFdTZeRuc6jT1/DxTNBm2INUASMOSIIETsCvy76WgYTW957O2aNcvpsGZ/WOlvbdvh
	sy2+pLh36wDCnYYhfylVzcoXasn8y03438FNZ1UgSVwhPT2a9lEZNEmUMvnxenKRWeoMRlLQ8le
	EyNHsd1H9bloWWi9hjkTJrvBGd4Wcwo1hRK5akW8QcUZ/EeTRutWMQE7Mhffh+d159H1TqhU6th
	+0BJtuzUp5/cPIN7myPYUuFb2PB/gB+F0hTneuqnijwN9V94Cwhp4Jw/sqTO/dxly8DnMLVIFqE
	M+CKc6QOgYdtqpwc3bvRPUSLbpOzeuTl4dWPtbLSI/LoNmhz24e9A1e6kqtxl/XuQcwrUfNnW4E
	Rj+BqAHRkrI9otWIYrX3WbimFzFFE8cdTnrTdkXKgNWZ1bh8ACTMxj7TwBaYU0m0qnh5AGVe2a9
	r0nYlE
X-Received: by 2002:a05:7022:3f0d:b0:1b5:58d:fd9b with SMTP id a92af1059eb24-1b5568f03b6mr23745135c88.31.1795719616393;
        Thu, 26 Nov 2026 11:00:16 -0800 (PST)
X-Received: by 2002:a05:7022:3f0d:b0:1b5:58d:fd9b with SMTP id a92af1059eb24-1b5568f03b6mr23745075c88.31.1795719615743;
        Thu, 26 Nov 2026 11:00:15 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.11.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:00:15 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:27:13 +0530
Subject: [PATCH 5/8] usb: dwc3: qcom: Add support to keep GDSC On during
 host mode bus suspend
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
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-5-485a08ffdc6f@oss.qualcomm.com>
References: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
In-Reply-To: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Prashanth K <prashanth.k@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX7mb3l3aznmFU
 ZSweLnjVk/N2JG/nrJGvc/XxX+QXIyzPpxnLB0TQw9KjwshF3d30tR5tM3nM0EwRby6XMwB131/
 kW/w7CkMQZKyA0TPo0vz+VBzgG1waM4=
X-Proofpoint-GUID: oGUq9WwkKB-_nn9G0dDFimAmG8d2Va6a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfXx+IEdBZHz+kL
 Qdaym8bhQCqiX8v9tl0rThAdFZtuNerCS9iiWYie3xKhsNcX+lKULHYpZcs/hkp7SnWlDMtsS7K
 x4oaXu9ufswf3NcZ7Vs39SsKo5ysPCjFy0Ar86JdAKaHl5/0QGhu4MSzkwnLfEU+RPX9VcT2jbw
 qUcbJtXW5xPUAuFQmNBz9w6OsaMat93P9NPWhsiaRaHXsvCELkgueifQppe02FlH/pWvVT5LAx0
 1ZkWF1bxRAXpTFXRep2XhjwryKW8jW5OIfKypzZowEbFTtMHHbcf0PRNoo6eIJMeTJqAvv/gDKh
 rC2d392a+Vdx5qLAPuRzsVbpK/aCi/i+xr0AaCT0Id2+r+8/7cBIFr5yeTN0l7+xmBR1OtZLCQj
 Z3XCD6t8XeztirCnbASxR4PrLZGUjO05FqYttlBwA7NM7DX9ujK7ST5vFTC5+KrgZ3CnHkKtums
 zDBzeXz3QqpPurjLoTg==
X-Proofpoint-ORIG-GUID: oGUq9WwkKB-_nn9G0dDFimAmG8d2Va6a
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6b0881c1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=g78jQFkTSXp5-VZghQ0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260074

From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

When we perform suspend in host mode, there is a xHCI crash seen on
resume. During bus suspend use case if the device is wakeup capable,
the GDSC needs to be kept ON to retain memory and avoid SMMU faults.
Set GDSCs hwmode to true to keep the GDSC ON during suspend. And set
it to false to ensure GDSC is turned OFF during cable disconnect or
non-wakeup scenarios.

Co-developed-by: Prashanth K <prashanth.k@oss.qualcomm.com>
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 5a68025ccea5e5df8860f540f718262b7d8acf8c..99dce28dda065583b91ed965d917e977519cfe58 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/interconnect.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/phy/phy.h>
 #include <linux/usb/of.h>
 #include <linux/reset.h>
@@ -391,6 +392,9 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 		for (i = 0; i < qcom->num_ports; i++)
 			qcom->ports[i].usb2_speed = dwc3_qcom_read_usb2_speed(qcom, i);
 		dwc3_qcom_enable_interrupts(qcom);
+		dev_pm_genpd_set_hwmode(qcom->dev, true);
+	} else {
+		dev_pm_genpd_set_hwmode(qcom->dev, false);
 	}
 
 	qcom->is_suspended = true;

-- 
2.56.0

