Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621667;
	b=XPbp2iWX/3nvIY8GjfchUj9XAougQj3jPtFKlTEvAFVccEaaBsdj4foz9FL++u0hngaD
	 35KXdw93gldcxudLhhpuFmXq4oz0QoqqyahBbYOwsPTFrWM43mGHY/ymb9SYb9LNXtdon
	 Dv6N8w9LHB0zxeMP2wnZoYbSfenMDA37VDjFD4fzolMIaBA19r1pD/VojU9PBGImQ/EzY
	 3LEEVW5t4ENZfMxLL641RrGMyhcD9VeLpYN3tVlj5I43u4j2ROrrLt/RqJNJxXiFa8ASg
	 DiEUgDm4wpDnk8aaY8ldR/teUCTUzsonLOYpVyyNxsK+7IwFS2pbZIZymtO90YHwW0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621667;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
	b=2MyRjJhT8/DXEfv9FLv42IFhOhpqTfubiW/kL7MM+Y93PZi3uwupb3IUtfqUT/iqlCNH
	 p41CQtS8lAJUNpna3uv6KcMFxxPilIfViN40s9aAWOP55ffuQKnHDSMWqyr2uuMJc4MRk
	 uRE7JPjURc3L3/2EB3uUQSGvJXpefOMfLBHHv/DxJkI5oRxW3oqBD/bPEHZe7k8/DP2P3
	 jrBjiRpQ1yyHAe9wuMrpGl+td44sZkA/3EnWFkddYfPRCjgITz0NPe7rdfLg0ejFDyYsM
	 Aff2c8WG+lI55YiZVdjYPia5I9iH/sJbw0hSdQCW4FWqrsESqrmBHj9QRYujS2Z+0gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PzXSZHmP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VVJa9l79;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370D60A3826
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D370D60A3826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PzXSZHmP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VVJa9l79
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE20EEV072002
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=; b=PzXSZHmPbBPCB7HA
	hn/8sbYBAHxFIXL9DXDrrD54cbAkryq1Xgu/vJI4egw1ZbTwAcO8vuFcwGwoN0C+
	udDBEgvBbxsB9HVseaCKsV/MuFU4+HzQ5lrH2gLyY1CK0c4FeyjvLq2kdl7ToYK6
	Dlyq30+Bu8sBtaI/MIldw4ouJdrKmXrHAZnXI3Mn9bfrN4SWlAtMTCEY6B+C8zsi
	XiUD9y1FZx6EBq3S7lrAP+U3qfbERNld1fdnWvvNqzC2Uwh6Segwkg5pvab8PvT0
	pBaT131EtbaOtad0EGgHyWYeDpj3IH8h5XtLIhp0G8PESoz/03nIfE0DHYR0r8d/
	1ISApg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx662stgv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:05 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-154e9d2d94fso4549369c88.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 18:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794621664; x=1795226464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
        b=VVJa9l79VTTmOzGI4cTChHkwJxCRPBig1Ikq5zJAbsIIFql7ekbDPL+f3cGeK/5/LR
         maeKZ4JVHK0RPFtvJaekYGCyyxBCUE2wlr/3Cp7tC+FgA98zgtENhXsHTn7MLZxqQ99M
         S0BchRiUgDpHBspCXyLVQRCQ8pe8x6BWT8d3gQoX+Ib0k5p8X8e7AU8D3LbHIMH+0z3l
         xwetRePUlbrqiLQIH8QB1MZQZV5pR/kjVinbD8cxInOVEcHVSPQ5exJ1GdcnNTOE+94f
         Oqo0N++FHozwUKm5hh2bEakJac6943AzSUigaV6UM49a6758ck4J2TolGvbsdfmAJPrS
         92JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621664; x=1795226464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
        b=RNICWUgHiQ26NfVFJPlNCE1KkhZ1iVsuyWbttgoEf0nskyajn3yzwb7+xbHxmH0XRQ
         ajcQlxIPDi/j04pI8fQGD8QK2lOIFWlGrtQsvefZyEUKouutL2bSoizI24KEp71VxSnE
         ws34A90dpgS6x08wcNO3HVyHb8axMTujiN09pa3t2axF8vMrhO5R8fJS91HBbMyZfdhx
         iMuTvi1RsOA9BHoI9og4iuFJvTDmQQSiUH8sl6buCmHnEFXatfqY8RzIvhcF4UWuXmZR
         rPptz9tfbSE8faRioxDxfSZ24jHQIWMoo9rYTdjqGTHWudCVwJ6wBPocMWPofpqs1jGq
         TrGQ==
X-Forwarded-Encrypted: i=1; AL+hErHoDf5Ti+AQhhuGsRzIfr5q4t6+cPIeWlgtM83lu0kuw/T61t8/0VP35M/OdfIv41QLZGLZLhWvYJQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ftz2UDy74RFoMHytCHoXdZbOVAeVISBhgLyR4ZQTjEB8AW4yW
	BnnS2jbQLJrY6WYndZf1fH1uBue8h1L3JJs3voeE5fgQh2Ky+2xKCjpv7IApd6b5CFBLHLqcJZ8
	LZ4njNmWVl/WAC3Ya3UjC5m6Km9vGF3i8vE5+EFJf6q47t/Ap33u3HiEDaefeCTQ=
X-Gm-Gg: AYBFou1xeTfmc2TDyHVDCpQDSIDKIVyOD2ZJpfFQFPlGEwOIKBFIlDYi+dp7AufXnD3
	hD+eeAw0hMhIbpFdATkIvbNXj7q5siHPg7jW2wP8klKiWGp4aFFvz5yd8fJ3b/uR/Rldai7cBjF
	xGp2ZMX2W2bL2CCQIlIWVSQsgGvEfmBS9wJLAYZ8LH5rUV/BVHU7EYqiALZ4vW962kdazd1/7KI
	jOrFcfRRuEfP91g9eLqGFOh5kgNVaDHexVsP45xZgQrJ5t3v1cCtXQux4PbtKnP7kOLNB4AsVgr
	Nl8TsqqgOA5AvlsqMdueUxiX+VNPZoztr0RqUIYQ3GyXoQWWk2mB3xMIWmJG7T2LauML67IU/J5
	bmyrRlbSMY4oC3dv2x5pupJdWmZV9fAVk8lIT00J3h6TcY3+jO0E0jwfu4HP7eBI0nAA7e8UWk1
	iia+ci4H8I
X-Received: by 2002:a05:7022:3c84:b0:181:73fc:e53 with SMTP id a92af1059eb24-1b50311d31bmr3900139c88.29.1794621663986;
        Fri, 13 Nov 2026 18:01:03 -0800 (PST)
X-Received: by 2002:a05:7022:3c84:b0:181:73fc:e53 with SMTP id a92af1059eb24-1b50311d31bmr3900106c88.29.1794621663240;
        Fri, 13 Nov 2026 18:01:03 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm9952742c88.7.2026.11.13.18.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:01:02 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:30:51 +0530
Subject: [PATCH v9 1/4] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
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
Message-Id: <20261114-shutdown-v9-1-5430c9f242ed@oss.qualcomm.com>
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
In-Reply-To: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794621655; l=2329;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Z62C1KjgkUfHo1yhmxjksV4K46Bz6P+GsVAjd37UQdg=;
 b=unbeud0Jbm/M4cKx5Xkse0KpMHXkBpv78tZUuAroN1MF04Ki6ksBln4irO3yheoIrEm77V0GM
 UuyDjQUAHpIBNmLj3pMFdBOLA7rsDjHXD0qg8M/i2zn3u0EVNpxyYtW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: mMDPWWhaseGKWAARI9Wiuo9zgZU98g7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX6Io8a62aZLg7
 vYcHmhzsyMwsiMA+xJqZl6dmwtYFd+h7X4MR+HE+X1H5iD9qCvDjijBYHBj5hEbMM0azLHEULoP
 AGjhdhGb87oKxk5r5FCPMc38aZvKbXHpUBxK3aYdW8D6LhxT3RehETHw+z8qWymNwxLAMj+ek9Y
 NHEPlrLernl0GtbC/qDiMH6SjdxgcqBeu1wvx437ciqq4ev1M2hhcPiCqSZSWRb1BfTGYuUR/Y1
 dfujdQH0WfK7rrDSygCeaJYN26dnQh0mPN8sx01lmulr4Vnl8Th4uw02LS1YNmFtcEYnwjIPPGR
 z7ApikUwN6NR5iarmIDr1YOFNEzHHch03upEf81P8SFCXAWJNAyRu0xehvWg5jnIFD5NDpILb1Y
 W69BTg0rszUDDevYJSVT1HYZKlFdM0kh70Tr+HFLhHytn8JeGFQ1Oc+W3Kh1hUX5WwGWal6Yq7p
 yOMHshfvbbfCRsiWIdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX4oOWJvIajuFU
 rOdp6ZTJShCvoTV8csh2HDwttNTUkgH/RX1m3Zl4RdsbXdcaKozi0tDcv7FajbrA9oSIFyxbihu
 TuWQZqDRdzD68wMcGPETy3rDdUcoSck=
X-Proofpoint-GUID: mMDPWWhaseGKWAARI9Wiuo9zgZU98g7s
X-Authority-Analysis: v=2.4 cv=M/nYuCws c=1 sm=1 tr=0 ts=6af7c0e1 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RIIKlrP-v3AzcS8hWasA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140007

__pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
the walk as soon as its callback returns nonzero. Any device enumerated
after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
capable endpoint -- is then never visited, so pme_capable can come back
false even though such a device exists on the bus.

Since pci_host_common_d3cold_possible() already returns false whenever
any device disqualifies D3cold, aborting the walk buys nothing for the
plain suspend path: the overall bool result is unaffected. But it
silently drops pme_capable detection for any device ordered after the
disqualifying one.

This matters for the upcoming shutdown path in particular: unlike plain
suspend, shutdown forces the link into L2/D3cold regardless of whether
pci_host_common_d3cold_possible() itself allows it (see the following
"force_d3cold" changes), so at shutdown time it's common for an
endpoint to still be in D0 and disqualify D3cold while a later,
PME-capable device is never visited. dw_pcie_suspend_noirq() still
uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
result here can cause Vaux/wakeup support to be dropped for a device
that actually supports PME from D3cold.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index a23907a875e5..c2c852c64aa8 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -275,21 +275,16 @@ static int __pci_host_common_d3cold_possible(struct pci_dev *pdev,
 		return 0;
 
 	if (pdev->current_state != PCI_D3hot)
-		goto exit;
+		*flags &= ~PCI_HOST_D3COLD_ALLOWED;
 
 	if (device_may_wakeup(&pdev->dev)) {
-		if (!pci_pme_capable(pdev, PCI_D3cold))
-			goto exit;
-		else
+		if (pci_pme_capable(pdev, PCI_D3cold))
 			*flags |= PCI_HOST_PME_D3COLD_CAPABLE;
+		else
+			*flags &= ~PCI_HOST_D3COLD_ALLOWED;
 	}
 
 	return 0;
-
-exit:
-	*flags &= ~PCI_HOST_D3COLD_ALLOWED;
-
-	return -EOPNOTSUPP;
 }
 
 /**

-- 
2.34.1

