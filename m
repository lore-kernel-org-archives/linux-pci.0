Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FD3FD122
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677468; cv=none; b=UWQqWqGoQtMwWrFhTyRr4TJz0LrKIMEMGfHV001Qd/S4nVScJwvcEtFcuCQiNaBM6NB4GPteYEqs3r4D433XRRiIzANVDLRZW9C3fmxjV9n/4oZMrDCqRE+1V1NFHiidbLCIBYYjEbCpqDnAiHAwDVzJzKLR/U+gdv7P4Wwy+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677468; c=relaxed/simple;
	bh=2FBpwvvQE75I5khIUailuHtmF+KaL1qEU+l8PSLJfdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=at4BG6pWGl1VdrKL4OJFJm12UtQP76bVrV62XqBbvJoWKUdUHHcGcu+JU9fdnYZYH1Qlew+bv8WSTBwEtIM8yI0FESMLQFWH4v/Pa+700Z0gyq1m3WmMeUG1Kp0Z6oe/z00ZdsjypS78BHQ0P4JdfEnS8xmJ4qmPzCStQVrIACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JH4UsoJa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z61Sha5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JH4UsoJa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z61Sha5x"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A9TTqE291947
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hRa1V0rI3XaAjqfNbDQPKrOYUHx+ncbEbofR/K207A0=; b=JH4UsoJaIxL9Qnjt
	EDqt7UIvTRB5R1k6fgCRhtToC1oYoDSqCv+GjTm5MEd7ej2Z5jDAmIUWkIj+6+qU
	lim9C3adByloFraelPCK2neFe5Gmr4HaFA41CM7W7WqFEXO8pnDMnr8fiB1pGIcX
	w3ONI6cP9njcHc2Uln7Y63nl8B2DaBvD/MctKrnfv0g1jvQQEET8EM1+LjEdIA4P
	vW53GtNes2rbLtve+HR/v+R/Vuu5Vt/AlC3OMVewk+Fto1X02rQI/e3h+lALOn6x
	MScoikM+O2ChKkNm42YUYoN4AgHw878FRtMMv8rdwQXBlYrXmvkiAyPoX8xQxI2N
	m0ZR6A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dg3ju-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:57:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so13989031cf.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677459; x=1784282259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRa1V0rI3XaAjqfNbDQPKrOYUHx+ncbEbofR/K207A0=;
        b=Z61Sha5xuv+KyJpfvYsi0L8SRPDwV2+t0cuzTNY9K4eH5rnUyaz6Gr4A66yeM547id
         MK8d38lbM/frxnF2NnWTiUnYarhgaxdQTmGW9rgLOSpf34PYAm+hjiBHayfdDBIvSEi5
         KoX+KEJt0y7WGzTP5+aRNLrZUI3ixlM0KX4U1+0qOtG8iny4GZV+LkUExXKlpmElOYYh
         0g6PjYmzMBtZb4kHaGVeH3UaABBgM7IE4jix8OKzjuDOBiOoVSGDBZwxgZ0o5UEWiPZB
         oVUj0/CCAAjysBTY0KIA0EbbJhZ15w9tPqoyRFbOfSDBCCxUqhbQuOr+VeCyT2Dw7dDh
         CtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677459; x=1784282259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRa1V0rI3XaAjqfNbDQPKrOYUHx+ncbEbofR/K207A0=;
        b=W9xskr4A/ooiIiHktTpU642tHGVgrepybeqX+vCvYhKQOSxVE9v5kzDSjCt/SV5wV+
         EQraaX0C8kga5wEuSqQ1V18/i0DqBDPhNQaimu9bjZaiiemebIrT05icWdXOUfszfPrB
         55FIyCKJGS4GFaYBNKnmmYKy83Bhr34iWUPKHWNMU3JxZXTI8vxpmSSmMDmU3BjaioyW
         DeD8CK9gwcp/KPAK6Qd69ral0b/p3JKZnbkSEp4fI/O/RJDezRKE2wZHP5Q47naIQpA2
         codpRsU8NQkifbjkNwgGu6f2pu5j2uN56kuzZL9VVBrWSqGzc6XofGwBYZtzce9P21jp
         ZyCQ==
X-Gm-Message-State: AOJu0YxHHb9yx9oGMEYvv6xkz1lBzOWYMUGb1BQVKIYDM6LsdRa1AR3a
	ZQABrgsw7WQPCXeByK34H6mgFTbs5X0eauGKcg+3TtQd2ULWjGfzTRipLdGgF7rEa+K9ijI52tg
	Q+c9ICH0LSVyqA9mh6XV+W+m9owFlgL9Y1E6VcX4jjZX21R9qiy5gDFyjhlsx2TQ=
X-Gm-Gg: AfdE7cm6gu3q1nQ1Kesc3zC4N6zK9yXmJvY74RlpV80wibVPM9NInW9xH9xsLNueDej
	dpA84/2VMSpjOOogIoRxxWRXt4qkeKpJckYhOxbjF8HpcqL99lo4dVkYX8mdIwIl22Q2sixPYu7
	J7zd7Bfu64P43p4G/lsoM6rce7wRotLadQESj+eG88kKcoeiAcING2DYV5wJP3PpHddhAv2qBy6
	ZyTnPCiMsAxx4SPbQgO1Vsj2Wx6v0hkfW7Rt4S0WI64L1XcCm2tEaJZNCTp4CeTSuiwF093X7u0
	0NfYIMtD/UU83WZyKOtJ/NAzBSzrzuB9kT0ow4n+Db9RhIZWPXLkwS52MqpNW1IsZlwy1gznEQ+
	pbnifjFY4V3Kg+ei8oQt8awvObD6RIP7kXbtaYTdz3v/HJhYYYlL6FlF35MhQbItBHFbAikgiy/
	TBh9acLHRPIRCD+OEsTZlA05X9L43dCpChwuBE/D2v7yyp2IssmPdDKGxTlgUK+mGvp1hdkn3/Z
	K8miTytOzeUn6albbaD
X-Received: by 2002:a05:622a:55:b0:51a:88f8:bef2 with SMTP id d75a77b69052e-51c8b3daeb9mr118302861cf.28.1783677459278;
        Fri, 10 Jul 2026 02:57:39 -0700 (PDT)
X-Received: by 2002:a05:622a:55:b0:51a:88f8:bef2 with SMTP id d75a77b69052e-51c8b3daeb9mr118302571cf.28.1783677458821;
        Fri, 10 Jul 2026 02:57:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:38 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:30 +0200
Subject: [PATCH v3 04/11] power: sequencing: pcie-m2: Report power
 controllability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-4-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfXwsbWTdRa/xZT
 9OABYHNReWV09mdnu76PCXA7PamzVTLyHXTblBmFm3qYDlS27GxVglnq/pUlVCCFVK1aWF5xFAP
 SnMBDQHgjR/Etb7Roao6JXZx+yUD4EM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX/hjrV1ZUOr13
 ZoHbu443ZvxK5BEUGDoFeOPZ2X2Un8a+qvp70QmSCypWJQyvziW79P08a+GBV3wOwwwyqtHsH4y
 ggryI5cBzUiblwJqr20UHFmYfHX6cfzd5ICw1w5EnEtb4s88Jj5tPKvXSmJrQJ3qewZyaiVwRI7
 kMaCJXSdwt/xjAMM+QLuKG635enonqcftLNaLOV+rSNbiekJiMoaTv4wHG7e/ip9nuhKUtMWuw9
 sinB9sIufhVPy5Z+berESScUoUSstFpweAiSzVFl5l1F9PiiuyEKaHVl6vr8yY6dkjcns9MVfw3
 m9ys4dezKff7YfYBHScBEJk3HRLkyFpnS4G26ljc5x/uiuplYeUwJokkTiY35FTdhKdoJq6opxQ
 Y693htd4H4obp+kYDZ9YYapIztw6pTrxIfD8crQzPXTy3dZk8pkqyJ4crENZXy4kdn5+omqoCuZ
 mTxeCvQcTdw4S330cHA==
X-Proofpoint-GUID: 0OGPe4w2zBA0l7z47XQnhTlqpB4fSCNv
X-Proofpoint-ORIG-GUID: 0OGPe4w2zBA0l7z47XQnhTlqpB4fSCNv
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a50c214 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ZbPLKLkBM29APCUVJXgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

The M.2 Key E connector gates its functions through the W_DISABLE1#
(PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals. When a signal is not
routed to a host GPIO, the corresponding enable/disable callbacks are
no-ops, so the host cannot gate that function's power on its own.

Implement the per-unit .is_controllable() callback on the "uart-enable"
and "pcie-enable" units so that consumers can query this per instance
(based on the runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
pwrseq_power_is_controllable().

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..4bcd5078609da1be966ab30c73cffae5e578934f 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -84,11 +84,24 @@ static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_uart_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The UART enable is driven through the W_DISABLE2# line. When it is not
+	 * wired up on this connector the enable/disable callbacks are no-ops, so
+	 * the host cannot gate the Bluetooth function on its own.
+	 */
+	return !!ctx->w_disable2_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
 	.name = "uart-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
 	.enable = pwrseq_pci_m2_e_uart_enable,
 	.disable = pwrseq_pci_m2_e_uart_disable,
+	.is_controllable = pwrseq_pci_m2_e_uart_is_controllable,
 };
 
 static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
@@ -105,11 +118,24 @@ static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
 	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
 }
 
+static bool pwrseq_pci_m2_e_pcie_is_controllable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	/*
+	 * The PCIe/WiFi enable is driven through the W_DISABLE1# line. When it
+	 * is not wired up on this connector the enable/disable callbacks are
+	 * no-ops, so the host cannot gate the PCIe/WiFi function on its own.
+	 */
+	return !!ctx->w_disable1_gpio;
+}
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
 	.name = "pcie-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
 	.enable = pwrseq_pci_m2_e_pcie_enable,
 	.disable = pwrseq_pci_m2_e_pcie_disable,
+	.is_controllable = pwrseq_pci_m2_e_pcie_is_controllable,
 };
 
 static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {

-- 
2.34.1

