Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BD3AAF46
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146002; cv=none; b=Iu2GwCTp/4fP9QgMfi0AEHrFmwAgUaOb7OewcdDrFTzAoibKqM6wZqweiHAMZ5KvsdVIZBhYv2dA3zYJIPzsYNbUKDQfsIc0cDgvpta5XTJrDctpTVBsace9fuIFmaAZjR0fSQV6sG3gQuMxAitEgOYOcdJp8HpICoDmL9VIZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146002; c=relaxed/simple;
	bh=gzbJaxCxPVY8JnK4ZtjTaXSHrAoIPOQmaGGP+IIpy80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X15StdJnXzS+hFk4LsDg5PJQlCZfTxhA0B9QFt3FXxmCzcRgzDbfZ2psDqxW6SzBbnrEQwbqg/SVGRpaKo3OoUeRipOaR7sw56Xn8V/9wRBHvT0EAEq0LSk6nqV5QzwgRkv/fwAe4uQ6hrHMwlUe/dWcqyE1b1EeEv/XooDoJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e/wHwrFY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F2RHqk4t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e/wHwrFY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F2RHqk4t"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0CQK901383
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7CJo47Rs0M9LCBUMPKGSlXpd8LIC7VDX3pXhIIqAfsk=; b=e/wHwrFYq42rNYiU
	I1hvIeC9ytkAoW6qxsQOgpdSbzt3axbxn9xFlUl+SLna8EukIwer79oGUe/+VIQx
	MP+zC6DOWjvWBw2UavA/HQokpKD3SF9vYuIlUjSeCm51sMW3rA2W64cam7BSWulb
	Zl7BgdaHw6OBlKUb6Ok7RzFfD93cUHxpVH0m1YU7N0BYAcmwXfbht2r0F+4SI9jI
	2/WMIqqQG6itQ+xW+47XGUJ8OquEjrw/+8EYCckbQRJWSDEiviaVOiYRv8r9+jTp
	AOFLh2COC5GxMP/L/vWytpDb9kdYFc3oRQHVPumz/u1PqKIjVvbLmzmItZXi2AcH
	1Wpsbg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfpubv8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so2232767a91.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787145996; x=1787750796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7CJo47Rs0M9LCBUMPKGSlXpd8LIC7VDX3pXhIIqAfsk=;
        b=F2RHqk4tH8hpOsiEfQuSw8FOhpfLDKYAcsjDXJYA4IE6mmSAl4bmtB+6O6QwLJWB/5
         fm8ir9O36bePI+CBp7+Lve/+HVErDnez2fXuROJkfLjDxcyUFnLfpvwRDE1FoFcqeQTY
         +NW/XUjKleSNWxrPlJFMf09mxIRQYNizUFLn3UBIXJqEOKrdl08GDMdMzjmHXcGhvhMB
         xilxs8EHL7TdXheaIqntBeQeg2e4e7FVECLTeM5hlQefgZHpHvT7Cn60OjTccMQx+Oe3
         Uvtx0W+m/zGpycmiBt69c/+hZQxaXXqKNQP/wgG9JpsjUBq3ZKKPlMoQVyCsgjhWU4II
         Tbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145996; x=1787750796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7CJo47Rs0M9LCBUMPKGSlXpd8LIC7VDX3pXhIIqAfsk=;
        b=JZtwex9zYRbHGS+/OnO7Nvz6RVV7WayFrxmrEHKcbS9L2C9CVAatwAVbSvUI58402o
         GvR7OAYwH9ELsf+XVYD3LliVdNCQNbJx3DuToGkOTl9B50b9a/GzWRUEGle6SeAHHhoF
         wqgKOdgukkVfvNofO+OjZip4SDZf24+8QDLzOtoC7eVeNxMUKdD0oE3BjykT538+0McC
         sGvOOQvrlrxW7fb3JT3B23xhQPRgQXSj/RVR3xRBdqIYKwe/QSTzmbnvDEl6oIIDxTaW
         gD59CDbShRw3duHjP+XYVCNcunR7yTREwm/zwen5SztF5oh1fvwwmS/2IAOQeLB+BO5N
         QmBw==
X-Gm-Message-State: AFuF++ki8nSDPR/50zu3GMESPwJsWsvIR/oxDbKekuz3IYRGIIolRU7f
	cctpjK/bKE5epDxWh7xDuBl+AJiumk2dkRpbN4QatgA3I+S5GJ9DlL2POv6olND6O9B4qmDLksD
	YqhJeksYJ+ST/9xmmkdqmnK6N5L3X3lFziPB1+heRYYjObj+QeAXbHBV++GOMo1M=
X-Gm-Gg: AR+sD10VJlFL7yWGR6myl14mQd8cHuXltj83Dsw7iDFWtHv5Yfx0qZdouMBwE1MdJW1
	+74sLJbfKsV0KkWqibBeE2dYT3lrER1l8z2aXOj8zjJTvuUhDZsNYJsoq+SYNxM5Dvf5Yd/9L31
	I9j2a6H8OekdBnFzfMGtR+NatU886tS37YFGWbMdB4AkFViq0547tg6F9yBjfpPObh5Crjfzto8
	mnHWjVt9bCOL/gPmiRq7uX07b4Kh8qExTR/oWGMZw8u5LF1/6K7gEAhVa6Dd83lyBkPdxNDZtnA
	rtEmrGa8G/Um3AISSDvOsW9dOnBhcXirN4swfxYwQu1QjL/OHQ3vDPnlChkrYuDvgUI1Os09VMN
	HvSfaYLZJyzfkQJisuqUkL7ApjP/qodZojvc=
X-Received: by 2002:a17:90b:2792:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39581212156mr9783580a91.10.1787145995937;
        Wed, 19 Aug 2026 06:26:35 -0700 (PDT)
X-Received: by 2002:a17:90b:2792:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39581212156mr9783480a91.10.1787145995520;
        Wed, 19 Aug 2026 06:26:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c2a92406sm6126465eec.11.2026.08.19.06.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:26:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 18:55:54 +0530
Subject: [PATCH v5 3/6] PCI: Add pci_lnkctl2_bus_speed() to convert
 lnkctl2speed to pci_bus_speed
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-bwscale-v5-3-6dea79786b37@oss.qualcomm.com>
References: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
In-Reply-To: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787145973; l=1763;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=gzbJaxCxPVY8JnK4ZtjTaXSHrAoIPOQmaGGP+IIpy80=;
 b=loA59unnBaRnNZxvG/WUrecr0BJunX0WpPSWWcivrQvZy9B0XTfHfNyaXVEQX9wEluKQnYWPM
 L8B/TkvKplZDph1FExIucdFvjt33wTNOLQlKQDL/w7YzJYt5HKKSivy
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: J4wPtJ2SVhQzbBMcVX69Cq1n08Lua2i4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfX828IwWxtj0RV
 s3lMR8IylMnL1WakAjDxZHlQWJFljE+8CuWSAp26XfU2gHsiv/75w9kdZK7yDNn2LfFW1snEV45
 aV9rtdqpIlig2bO8QdojfrrzOT9WFVAAWCl0qwA1j6d4eKYDCWj1v+DCzvrmaqr3kUIAJwk6mEI
 xOTbX0nLn8n6+kVR93xPYAcBG3OeNgrFh2q9MzdiIioT+cHfS441XEHMl0rrO4+c+VfNR3ZJx6A
 0Jy/IBTrQ14NwQjECQPkKpZLxEHNeiegVbUFeuVq5WBJPWSqb0tL2RiWm0Y4LkCXSblImvlMrk5
 Wkos3bD4czyrKYKUF/nEqOXk4sE8aI+NIa9/tHXSYkNnayuOb0V1M+pDeDCg7EPCMpwhxvHcXzb
 kqbgNe9Wzkin4LfWor9Hx6YiKyB1y+GPC8x7XOF9dRazSihX/6FtulTDtiGqGgAB581JAKSIQB9
 u78i6peieLBfV6UZ8sg==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a85af0d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=rcts_Xg4tTJKaDXoMsUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: J4wPtJ2SVhQzbBMcVX69Cq1n08Lua2i4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfX5+7bkgJLI/nR
 JCiSQ9JULnS4hFF0Z67XqJlNB8jfvR2cBzuYO4v27OcGfqnjsGNJm9PCbC4H9baEOWmQYdqq1X3
 wLgha0aJI9iYu7/3QjMB5uv+HN3zZWE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190104

Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
so that other kernel drivers can use it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 15 +++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..cda7d210ddbf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5939,6 +5939,21 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_link_speed_mbps);
 
+/**
+ * pci_lnkctl2_bus_speed - convert Link Control 2 Target Link Speed to pci_bus_speed
+ * @speed: Target Link Speed (TLS) value from Link Control 2 register (0-4 for Gen1-Gen5)
+ *
+ * Convert the Target Link Speed (TLS) field value from the Link Control 2 register
+ * to the corresponding enum pci_bus_speed.
+ *
+ * Return: pci_bus_speed corresponding to the TLS value
+ */
+enum pci_bus_speed pci_lnkctl2_bus_speed(u32 speed)
+{
+	return pcie_link_speed[speed];
+}
+EXPORT_SYMBOL(pci_lnkctl2_bus_speed);
+
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
  *			      device and its bandwidth limitation
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1f2d382189d..244c145af04f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1727,6 +1727,7 @@ int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+enum pci_bus_speed pci_lnkctl2_bus_speed(u32 speed);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)

-- 
2.34.1

