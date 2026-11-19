Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093033;
	b=hHi4aT+gGak1DApY026XpkqHFz9ycafSzfFqzwnxBkX/vaUehjBX+uNXhDv9no6aqxqI
	 JGG2k9TLdPrR5GoLdExFmfLkvMND8GeyqotZHjK6gJLcSpYPfg8e3GG4iLbaXbNM0Yp6k
	 /NM9+BF7eSN2ueNbYlvYY5hCEIACPbjym2aaEgaAeF4jxLk/Lx73d4vwcWKIv8lsGKAZZ
	 fZRUjfH7mqNGQQWWZMXMNf+MO8GfLc9XkSsHnLbH7bwl5FZZaDvRws8TW6YbKq01ainru
	 oSkOsugaeMdIYgj76NAYQJl65Z96xxfgIOVaiWjCmwrYK58mnxw7icaI4ZYJfHcgbIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093033;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rNdkunqr6u9bKRK1A1668SbUnjs3NSYIwuYmzohANi8=;
	b=VrhrGeBPnjh0weDuEI4m7Ww+nWpYiaH9CI3Ok9cN9tSXe/kehaVLCEp1wp/eKS8c01Xd
	 EgDpYjUkqe+SI/VzaBeROVBtonvvHBLpJhHaSfWCQbQpieZ4qRJC3yXFd734RR0Bq/P5/
	 bwVaLdjDnxTedF16yPazA+uONF4n5+B5gH7cOKOw6nwaLeY1iYwUko5RPoAG8flmDbKsn
	 x/BQcVXBjqBRDgPGi5Dtmp7b4OgQrZhRzv2A3nW75iOIHxAyDib1HmOSp7qZzYIMebneL
	 +M2ds/y82UCK6wbAfTa6zbtkFHxAXScYj9tdRwOEnI/A23+FYi0BbMVxplRK+7r7ojQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZRGivuQ1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J96yC7DS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E260A2603
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB9E260A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZRGivuQ1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J96yC7DS
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBjmMp3583466
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rNdkunqr6u9bKRK1A1668SbUnjs3NSYIwuYmzohANi8=; b=ZRGivuQ1oWWQGCRi
	sCfEA/ppJkCsTOqCJL+s41gZI1kLSsJDxN9jfB8tC2tt3E+l2SBcZbDTRAQ2Nt5v
	ZOPtBlcVekwMteKFgFVUK/aHwbfkqAqOWSJq7J7uXF4eNAEaU6HXNM4pwrmBb46y
	o3lc1NqC2KrfxfSB5wILQ2xVlMZGwgnlzlphznYFAUi35fDj1icARv5quHfbj2cK
	Z8H8HbTsxJGGs6NVR8Evjyrb8lijApNynaAkgQxY4lkm2/R0B63ZOeg8wwXdfSnW
	0RqbJ2GYL2qrvF35pLsEyIjKx4Jf4CyUgfYNZO9JBSsjkQDHVrBFjAfDBk2EBOWs
	yfC7Gg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xymgmbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:57:12 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30bcb065bfdso2420060eec.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 04:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795093032; x=1795697832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNdkunqr6u9bKRK1A1668SbUnjs3NSYIwuYmzohANi8=;
        b=J96yC7DS//5V6PtICWu1L5GlNCDE9QG10CJHsDdE1OrNjqkAvbJVx2Z9BSoVhBZCuq
         FN4GQQgbURpL88+Ce8rLLhQto0C3gc+w4vRHQZmTZrwMICaOjFTZtZL1o/x6bcTBqT//
         lziqbsWFFUFCuAvCtuoob3PsSA8gHo6025sHf+2/SfenR2qH/qu17xDdEP6aTnF8sfDC
         9iJ2JPpG+cGkOjpUbg6aFYtgI7a3kKpn36puci+bg9EwiluUeGngIJNiMS9PwudFdkGf
         RGADE5V+vY9u7GtcW+RdrkGDblwnNjNeVqT3VmOAdWfRKuneq9Wmmv/dRec3M0WscJsT
         pTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093032; x=1795697832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNdkunqr6u9bKRK1A1668SbUnjs3NSYIwuYmzohANi8=;
        b=VA1k2bbwr5LCWHy0lFaSaYis/VHpo9l8QvQtgBBVDN/j8z9Y87kl50uKPHQSyl7tcz
         DVZu9GRR8BGHpxOWPrbdQ2QMO8wM+xU0qtSSshpn7hwtfPt+pWLrZamnRMtXVSSzQ8UU
         MAgUIhqHGD8Em5+HncDqfDUc2qpHaS7sKBJ4Lb881q9qK1Vd3nBvVYPG795k3aY+Uaft
         s8zqouElMZQhUQ340EkbC4MH2f2A4BC1xUHFisD5JeACo7wJKC2fHf9C0+rfoSiUmqqs
         0mrm0HPSxKNX7yX5vUZijNTHigdzNL7cGowogIcMARJ0NNPjxl6DRY3R8Z/1xTtdYCGF
         GqDw==
X-Gm-Message-State: APuU4Z8Rew9pFzybwvSqMaErSDQH01uAs2T4pwP/ESohIVYmI0wA3Cfo
	hZkIusPcoabEE2647ItxMg1dQMiuddGr5bkZ09s8sJTfIOJkOZ9MXR8CDkFgp5rbH/R+12ppu5A
	l6lTJ1bhYDmBIijdZW7tObGR0qtbNrLUAyiQdZUcyEDBoF1DpX9LkY/+B37lJuM8=
X-Gm-Gg: AZFdTZcF7WOFmN5E9inwVhgKzAOctYQ15NiV57MTYVjjlsUmwW+1AsmMBh//Jh1Arr+
	BXZ9TU8RdO9mFF+x/Vb5c2R1gIdc0661BWxURo2dduMzPywCZLd8Rc0x1yGYnaHChCLr+5XyI0K
	xM7+ardQ0ooJMDJitEKzo+5p6RgXY9KKWZA0wG/R5DltZ+DcoHkRvzElqyQbXXcFsrSf5h9B9uU
	rGxan5u6m97W2H0ny6co+hqAwaHJBB2Bbu8mC6rfDWjvG4rMoNBPjRPMZTAHFb/w1lTurmTHP15
	ZfXly5whJOp0fzocea5L3yqVi32M9h+gZIqDplE7ljgMpQBVXkFmL2mPjQJwAzePDrIMUar06/w
	XDMTjMUPnqLDHRAG5HvQEmybF5N4OqEc0wKHJ1a0NUVFsWbL6IdK6JhJ7Y9OuxqVKMYMMsiLG8c
	9fuquhmmGk
X-Received: by 2002:a05:7300:bf86:b0:379:8df3:d2c9 with SMTP id 5a478bee46e88-3827f98f348mr5032273eec.13.1795093031616;
        Thu, 19 Nov 2026 04:57:11 -0800 (PST)
X-Received: by 2002:a05:7300:bf86:b0:379:8df3:d2c9 with SMTP id 5a478bee46e88-3827f98f348mr5032235eec.13.1795093031084;
        Thu, 19 Nov 2026 04:57:11 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm18529369eec.28.2026.11.19.04.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:57:10 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 18:26:35 +0530
Subject: [PATCH v6 3/7] PCI: Add pci_lnkctl2_bus_speed() to convert
 lnkctl2speed to pci_bus_speed
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
Message-Id: <20261119-bwscale-v6-3-9a9a715fcb46@oss.qualcomm.com>
References: <20261119-bwscale-v6-0-9a9a715fcb46@oss.qualcomm.com>
In-Reply-To: <20261119-bwscale-v6-0-9a9a715fcb46@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795093007; l=1780;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0zEUl2S9sKA63T0Lpy4WWFHatcVllvfZJQrn5ZSlMz0=;
 b=QiPOhPdWYBohHyIwt2tF1rwyCA1O/3J19GBbfxfpRGsrmthwLR54jYh7vJieyTmuzer/m6ZUK
 +J7M4UBSalZDTdbAAM9bOcqLpdX402IQeObndCBqPYoPYTjrhrq7CX5
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1MSBTYWx0ZWRfX/V5AMM+n0xcy
 HgJ9LFxkCOuL1Y1LMLOqLz+zr4ZuqPpyqJJCsihOUIDKH2ZdwHpDwj2347wnLWHnEC3RiHmHxmL
 vqHMzdMMCQOzAYgJGqDTTVnrC+q1OFk=
X-Proofpoint-GUID: PTVDI-vbE10nkpY4Q4NBJpVl9axyVbV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1MSBTYWx0ZWRfXwH76cwgJgM/i
 nI6V7g5GwWDCZI5aPk+vJVjhgCCHqu8XKEAjcVUchmzWA3zw1hzjXlnkiE/W2Zzl5skjysdHHVP
 HQkeTr/zbAhsM5WRmXvgucAmpiPigCt0G2XbH4jAkKokVU9D5no5DQjLdMmw0GfezID/ugDxoE7
 JZbauUuaGZkmu4/tnw043ugRGEVa2+RreYXHOxpi8Cejsali1gpx7kyPeWy7HS1zoPdbBonqVpV
 EDd1pkGzEEEmYlnYXKLxx6NKqociBPXL5mXbv7LskwrwEJ5LOrZIx0OsLv4GIjlHVhk4+6ZwH7b
 6V0cWIiVugEhNWk5qVEFObSUD1az2qSXEh/wL08lWiZK6fcSFL8ZlwlmruqKjIOkCwtb82lk2fc
 uA8BSr7IuFkNGHGxoMPifj3kjT8AIaNVAPNhq0a0McSRiX5JFJ4XPBiOtWzEDUQl92hEXSF3cFX
 RggJ7urihcBzgiVBcyA==
X-Proofpoint-ORIG-GUID: PTVDI-vbE10nkpY4Q4NBJpVl9axyVbV6
X-Authority-Analysis: v=2.4 cv=WKPqzXsR c=1 sm=1 tr=0 ts=6afef228 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=rcts_Xg4tTJKaDXoMsUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190051

Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
so that other kernel drivers can use it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 15 +++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..a89955617bec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6056,6 +6056,21 @@ int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_link_bandwidth_mbps);
 
+/**
+ * pci_lnkctl2_bus_speed - convert Link Control 2 Target Link Speed to pci_bus_speed
+ * @speed: Target Link Speed (TLS) value from Link Control 2 register (0-4 for 2.5 GT/s - 32 GT/s)
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
index 352079393edb..d12875c95491 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1739,6 +1739,7 @@ int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+enum pci_bus_speed pci_lnkctl2_bus_speed(u32 speed);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)

-- 
2.34.1

