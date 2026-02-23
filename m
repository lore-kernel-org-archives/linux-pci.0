Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A835C190
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845646; cv=none; b=FqQB/wV02TA0qLYJwPe8qvvEqe5FGhF6GmX3iShYXoiOYy0wb8FQ9hZMRuPkxycKCP7ArWHDIAF8PmyNbam/bRMTIo25Nbfte+KQpYzvMlDz7NpTPHgJsgAO6avWiB45sv3PpqnF5KJgXmGst6PTm0K2TEno+M5HBY0e4IyWvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845646; c=relaxed/simple;
	bh=vR4GbE5tO0t7eMAiqDkRls4S2OCBvskL0+rRHRV0jaw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u2gnXyn5gY0UV9fF6+y+AyeGlAX7LY+pPxi5gzJPrtra+5qnB5C5XBbRvtfAMujhW7VNBS8CIVuIf60ZsIMDYBS8/DP1m5RTQz6s20MGVpr5bQTwEdAzJ83iGriqo5iFj0E4Sd55PCZNaua1Wq9qKUyrQi15Cp0rEHqlr1NntV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BWOzKElX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SvT/ykT2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BWOzKElX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvT/ykT2"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N95bxY1427508
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vWZFhNaftSjOq2EUx2lrdP
	hoLMUbbWMLwGx3JjXujmo=; b=BWOzKElXVoIJpB+l0OZENCMAUZq/JHUZjdnzOp
	UmhNfbTNhz9eQbQW8DZr4lo4siNn2GSuVdI7dCw37jP3wbfLaWy8YzvCjxYBj5fL
	D7NFaI1mZojmYF+P+vYnvrDsCNqsaFh68FbItGtiJ3HxRYKlBHuIzvW+mv9MkvQc
	2hum5isFVQzHI2z1U+g8vAtqUhmq1UVjUDshz3YPXxV3Gne2okr8viEW2nOWIoBE
	299RX5zp9nOVnVYCPEDem5Rrjo/q7jnHUixrhyNijK+QLqDTpULFg7dDDd9gHIEH
	neAZnEMioN7RUftgu3fqcqiXXh191n1rMTY5ewSI5JMWxq3A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5x7vh53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 11:20:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e1dab2235so2541760a12.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 03:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771845642; x=1772450442; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWZFhNaftSjOq2EUx2lrdPhoLMUbbWMLwGx3JjXujmo=;
        b=SvT/ykT2ReR8ISmC2NOpl/5Wj1brEdTc/KRaRpKbFOuw59kz+GsYPTseN/w+AOox2M
         Qksv+XKCiXVia4s4aohhl9mgUYsynfkClV6LeHKAGgt9mKErz7cmI7nRlU+w81hXC9N/
         /o0m4NmF2DCjuQeX2kAdlW+sCGbEXtw09cP+rYlQDOUoMrPi90wckFPBiBTlyI+Bvz7W
         JEUoRpB0c81jnsl0icUCvBrl+TgCOP64ligjezcmHMQSRZChgjiKLL84I/4n3L+bDtHr
         RVDdBLzrlz4h2sPj8zrPpF/b72q/shWLizk82AvTzWH3jg5nbru/H7yF7HBCYHd84ix5
         wN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845642; x=1772450442;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWZFhNaftSjOq2EUx2lrdPhoLMUbbWMLwGx3JjXujmo=;
        b=wah7ML02pQxLbjP9+9jTrLWcUDd6q7yhQuQiXuQIP2COifWMlzGQfcpK+RkaqW20LP
         hJsozhB1w9FvSpJ6pNbOrJVyv+xveiZ2IvYJW5dsMfvQAqnbCm4o/ZwQBQ8pjlnKzHwL
         tM945QSjEMwUsajY3+WO+nlwcBuPmGPKwXlTrCIpEMW9pOq8Ha9T7bm31sP6ozjAnXgx
         LMvqVkuAbrzhEIl+3S09qggoRkTkfheA0B2/n7qwNUNbnQZuciNNQQAjlEf1+JdKgq+w
         hvRSAnFzUAR/lVuSOy4MXEyeTZASQSDNY18Eu32ACxlk5Nku2QxH79aSs9i8sPU2YT3U
         MqTA==
X-Gm-Message-State: AOJu0YzfNtkhldnj0gejQ0RJatdGmFxbWFNQ2KgY3zXNT1463uBF51lT
	uMUMpQ6b+HaFlFigfLwlxyhn6asCYba1mmUkVDfjYlGQRczS/9WQUU4WbXdKLNP/Rk4ligMRceV
	l+yh/lehMIOxY+kYBrbFI9UbW2ndhttNvlCuwG2LBWtEeeknjm+915g/myYrJ9qGkoeUB/fg=
X-Gm-Gg: AZuq6aLfgd5q6kU5YAMQ7mWwLzUFeidD949S99m1sB0g5TnpLoVQ5lvnJoT1UxLY5nM
	jz0LG4gy27f3HoJxI0flMyQA90ULxIl1ofHi4fcD+x8X7q6a2ykfDzcXHe1vJuZ5qdfxe/vwMND
	d6P/wW3vr8FuG2t6eoRhesVWUv1IANBl5USyzC9GYqh+dqEFdTRbbHYNFLe0VlHlZXfevXZ8ukB
	CWPyGJQFzjafn0+U65nwCJPLcWy7wOiRQf0qkHMPlZBhQoTyuXglXo4lj9hWCoGIY2MBTSijQ1h
	SP71GqA5TnpArpXKSfh299I29xqRllQyAe493qQJU2C7HUKe3Ijb+UwRMaLcutwtl/rNOPAQ1GG
	npizA3yNQ3OjuOTMIEJFt8akWTTQrWgQ8lscM5QYUa6NFrRbn2uOa2itf
X-Received: by 2002:a05:6a00:6c81:b0:824:b304:2ce7 with SMTP id d2e1a72fcca58-826da906f7fmr7181451b3a.17.1771845641555;
        Mon, 23 Feb 2026 03:20:41 -0800 (PST)
X-Received: by 2002:a05:6a00:6c81:b0:824:b304:2ce7 with SMTP id d2e1a72fcca58-826da906f7fmr7181434b3a.17.1771845641085;
        Mon, 23 Feb 2026 03:20:41 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd899386sm6744057b3a.43.2026.02.23.03.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:20:40 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/3] PCI: qcom: Program T_POWER_ON value for L1.2 exit
 timing
Date: Mon, 23 Feb 2026 16:43:29 +0530
Message-Id: <20260223-t_power_on_fux-v2-0-20c921262709@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFk2nGkC/3WMwQ6CMBAFf4Xs2ZIuFiqc/A9DCNKtNJEWW0AM4
 d+t3L28ZF4ys0EgbyhAlWzgaTHBOBshOyXQ9a19EDMqMmQ8yxG5YFMzujf5xtlGzyuTXHXF5Sx
 lKRCiNHrSZj2Ctzpyb8Lk/OfoL/h7/6YWZMjonpdYkJBayasLIX3N7bNzw5DGgXrf9y+BZj28s
 wAAAA==
X-Change-ID: 20251104-t_power_on_fux-70dc68377941
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845636; l=2048;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vR4GbE5tO0t7eMAiqDkRls4S2OCBvskL0+rRHRV0jaw=;
 b=2zljMSIfVVuOWOyVO8iNsGgVjX5qYYHvu4cQLOgGWzSvCVf8O+rjn9akO5wPajSbEPhtug0sL
 71l9HfyiA1XCVT5Ab27GtDwQOtRSOhA8DGIDcxHQYq3iyTbZqZki12e
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA5NyBTYWx0ZWRfX55/rhMPU1w/i
 JP9nnYAmxIXL7bLmOHRiFAw+fgMjaLANU8EVJp7LF2TC6kvDh4vUyrLtPXiLOK/FemW6PGK35LL
 IBtNNuwamquZownANPm/DhlDorHAXWsnXA271UuTl0yJY18VLlOjeCD8SxrUvoxzYjtkoL46qPc
 nARjuaZ2kC39vBm22J7oJ0ggDECahgzPJuXzftg4BudTS0nFYbk/50u2hGqVtn/CWxG/fl0w50k
 +5Jc59VJ43Iiq8RgFTh92za2VK1aHiTVfPAAIy2+idNBLESk/kdAqaORYYvvSv2nVoNuCsvTjLc
 W31tPMRu4TdbtfTCbeWeahIF9rmdLuXQZ0kXc5/jwWoCvIUKooiMWaNVPrZ/aqCIgT0WkgMRE/Y
 nwGTRdGbuD4EtSbdmDouiFsvz//v44qysWGxIi21fTkcFvQkayPUBQJic2uR+3KYkPL+eF/sOk3
 HBUESCBhAszC5SH0LfA==
X-Proofpoint-GUID: sQfshfCRPz6dCnA05HZ0IZHg3WZ8Ip8u
X-Authority-Analysis: v=2.4 cv=X71f6WTe c=1 sm=1 tr=0 ts=699c380a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zkpMToBQJcapbifWyZsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: sQfshfCRPz6dCnA05HZ0IZHg3WZ8Ip8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230097

The T_POWER_ON indicates the time (in μs) that a Port requires the port
on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface. This value is used by
the ASPM driver to compute the LTR_L1.2_THRESHOLD.

Currently, qcom root port exposes T_POWER_ON value of zero in the L1SS
capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
which can result in improper L1.2 exit behavior and can trigger AER's.

In this series, qcom controller drivers read the devicetree property
"t-power-on" which got merged recently[1], and use that value to over
write default/wrong value.

To convert T_POWER_ON in to T_POWER_ON_SCALE & T_POWER_ON_VALUE created
a pcie_encode_t_power_on() helper in aspm.c and also created
dw_pcie_program_t_power_on() helper for other drivers to use these
helpers.

Link [1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Instead of hard coding the values in the driver, created a devicetree
  property "t-power-on" to program it (Bjorn & Mani).
- Link to v1: https://lore.kernel.org/r/20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      PCI/ASPM: Add helper to encode L1SS T_POWER_ON fields
      PCI: dwc: Add helper to Program T_POWER_ON
      PCI: qcom: Program T_POWER_ON

 drivers/pci/controller/dwc/pcie-designware.c | 27 +++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 15 ++++++++++
 drivers/pci/pcie/aspm.c                      | 43 ++++++++++++++++++++++++++++
 include/linux/pci.h                          |  2 ++
 5 files changed, 88 insertions(+)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20251104-t_power_on_fux-70dc68377941

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

