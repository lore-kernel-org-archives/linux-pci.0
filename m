Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621662;
	b=DsLIPRgtVQazIj6HCLdUab6YlU0h88O90SJ2jo4GDfX3R04hz6oCnZCvvhLN9cw9wH/y
	 x1FCR9hIlnHLJ7QOGb73K2fTxW4sbECp5Mno9Niw2YDb9M1BDGLIj5h1ARjOz7m62KRGG
	 05LqwKpGyi9CNnT+UpJPV+HbBTHvDdLoEYnUQp7lB/BIcYqgSp/hg9HoKAl7LgsQ9CVST
	 cEtDr1oMsplKO9AcCZhICIdpKoJN0/TJkvjl3GSRNzvTbkXP8cBPuh33aQc5b/x1aG7nV
	 E0g7TvZYvocac1fwVoIgFfu/QNdYtsk0fYMgLTwQc0WKKgzHc5lQH+68WskyJF8rjmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621662;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=w7TGz13hmATNS26qR25ht8QXbJCOX338Tixp/mKTVp8=;
	b=2pcuGxcTAll2feBPWOg5ZW71xjZTz1vIDAd67eZeVLWbtH863rjhRgFgqAsKfmNnSD6d
	 twQO9r/VwZwpHD7AQPsJa7ygWWj8sb0eIsQr90R2MWeJMRLXkO4Jmp2Tc4/iGRPayr9wv
	 SNtlgK8jzBxWViKfV5COX1y48RWaTqjkzy+mz9VkQHIkm85ZWq8AN6Xb+x6ybKEsYa0wC
	 t+FNueR7QWlVWrWGmLn1uetVZ1dHZX1GkoX2uz1z/G+ul+NfC64yDemtFAb5Ixr8h9w2m
	 q/VOT0ez+W1JyplYmyu2e3rpydurK1sKr9Py7gTinhdcw/3tX3ZZ1gYKDFGHTKPwRww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PuYMMSrJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d5z2Wvnj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4530760A3812
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4530760A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PuYMMSrJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d5z2Wvnj
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE1xvL92696081
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w7TGz13hmATNS26qR25ht8
	QXbJCOX338Tixp/mKTVp8=; b=PuYMMSrJtDA20dZj/OqRb2qzMNrjscffChgr8U
	rF/PhND+whNzS6hePQxGRXI5ZBLRnVZoOJ4kDUH1z3i4EuIX/rccZfGdjVrIUNPS
	o4jEwsUXDICmXUHE2kFSlEGhmdHRvONlSTbHhZCcB6/6mhtCHW36D0r8n5cgpB2s
	C1Cg9E8y6KJjGaexgo0MtNIdeNGCr5OBv25H/Kz/V0J0V2ybXO+WocMJyPd4bK/l
	G6rpFqj+a8rqW3CJN+FA1Ii1gYiLQqqHGz03zPzSsiPXKurjeUoEV3c6pTmd9tKb
	NXcj6J3xpisV7uwV/JcyzOvBZ1mv59p9WKXhmu8yFKMwSPnQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx87dsadb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:01 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3ae17c536so1373554c88.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 18:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794621660; x=1795226460; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w7TGz13hmATNS26qR25ht8QXbJCOX338Tixp/mKTVp8=;
        b=d5z2WvnjbLLwMmtLo4YYYBcp33w76ehXDF5AtpsCTJkVfef11wa/hVGM/NgOkudujG
         MEvO4XCUtHhOiR1mIaIJ2kJqir0yOSKynR6W2LinlWPHsXXJK5DqwvekEzYb1TD8v4lO
         iUtbq/No3XqzW+aerHYh4gOyxbNdQb5s3rcLdC9veF0m90gZhJ/uZHfbwC8zjTZbcGX0
         tLdmYXrP08YkvgqzrCVXWPgebwKTpHDaVoUxdavBQm20CnoEDAFEO1fwlGyHQ4S4Hfez
         mZcxjI24HCSdfAoDbBW56pWPpI/BMDuZhYQXfXFAGqQrIEoQeWCX1AMC7n3Xu7CQYzK8
         eSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621660; x=1795226460;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w7TGz13hmATNS26qR25ht8QXbJCOX338Tixp/mKTVp8=;
        b=I+MPGSFeJUhW3QQl2vlq3/yOip0HhkPUeFCmicWsB9T5oeMQPAbTq9pLxaEmlZX8H0
         hPsGT++TUIuXFOUcg2nszK66LLin+vBH+juVtwkDtrjQcabGX/o1U2O44R65XKinbrXs
         ShDfyKThaz+p1YMAbadL0UgPbAyvfw0m/R/l0H/lkEeU9oQgdNQEVy3uQjsJvvdDQKxp
         r5EiXZAeNWNVe09kpIBoM4JjEZhcbGw3/eACrQfbOj5IV3iRLD7lwT81eAn0EWdpSJp1
         MJKZcQhKJOhMs5gxK4e5+c9I9gSlcI2VL7OjLMULUlxMYvfpsyYeXntdq0JvOh+2J/Bt
         IwuQ==
X-Forwarded-Encrypted: i=1; AL+hErE02hzj6oyoIWsAtmT9b3+TAq6Ho0KO0BYMIRNCM3dMnf+vg9T+TuTqxKW6vTzwlWVpMA1M0tAmLMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m07wguV2OqwoXVh4in1hOYERWX9J/bncp1NCuBpUeG4Tn2jGi
	TV1DxEel+IQ5z8Pn6hSE+c0wof2Gdpb7yBEJ1v8283+kQuSHF/YGFo97NezdjbHyF1uP6uviFGw
	gsyk+eNWqj4KFFvtvfKIgETTUj6K4fWm43ipyxHqPb+K6idRocTXsSqF5RK6Z/+Oy/xzd5Mk=
X-Gm-Gg: AYBFou0/aM/Jhp/Ngmb2UXw2FbSrU6QwjSIv6Mn/R36gFMhjEWFVbHIGRkgnMxI1OPN
	FriEq68cxVM2q1kRaQgR5mGjfKEKZ9sqrgEWUl4rPRE4JDi+/R9r/JByM7M/nQgvUclFjvgVK0I
	Pl0HFEwg9XrUFLMQFdThP/eSaXPxKCSddHdhSlUNKKARAn6VXSduNkM1a6cV9PqZO25HEo6NI53
	EcZdueKto0UVjjL+sPC73HF9E8/5FH99o8jc/YEtHJ6F+HSzlq47ixc0+0/4hqU9tG6WrCYtCGf
	6231yuIzfrosuT9U6Ub46B0whXIeNHI/pBaj+trh1BFhWkczhwBsmQ3Js6HBzupHoz3+EfVFg9C
	oAW++z80B+DQT/Fe3+aABxugV9imeUcAeI8bIqERqOKquOOV4E3zN9nyAKLIgUh8Z1dJ3TqBtSR
	A+vVwTuaEL
X-Received: by 2002:a05:701b:4642:b0:1b2:42e3:e5f0 with SMTP id a92af1059eb24-1b5030eb063mr3538973c88.12.1794621659771;
        Fri, 13 Nov 2026 18:00:59 -0800 (PST)
X-Received: by 2002:a05:701b:4642:b0:1b2:42e3:e5f0 with SMTP id a92af1059eb24-1b5030eb063mr3538941c88.12.1794621659118;
        Fri, 13 Nov 2026 18:00:59 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm9952742c88.7.2026.11.13.18.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:00:58 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v9 0/4] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
Date: Sat, 14 Nov 2026 07:30:50 +0530
Message-Id: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIANLA92oC/3XQzU7EIBQF4FeZsLYTuMAFXPkexgW/DsZptbRVM
 +m7S8fEYTHdkJzkfOcmXEiJY46FPB4uZIxLLnnoazAPB+JPtn+NXQ41E6CAVAN05TRPYfjquxQ
 14yakBE6RWv8YY8rf16nnl79cZvcW/bT5rXHKZRrGn+utBbbendkFOtpJoBZ1Yk5Y+TSUcvyc7
 bsfzudjfci2vvDWi8bz6jXzTDinLLNpx4vWY+NF9dHJFE0QUti44+XNGyobL6tP1KOzybIg9u5
 j603jsXqsf+oCAw4cd7z694xC61X1PAVlFVo0hu14ffOMqsbr6l1CqjwKMI7e8eu6/gIJ/4hvO
 QIAAA==
X-Change-ID: 20260822-shutdown-fe8139dff2b7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794621655; l=4535;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Cu5rLdDWJqafbz3+M6KVDjIsNv0OakL2e42N/mtr/lo=;
 b=k1j9Nc6d4s8kj5tRPQ8BtpVSXBOSpp0XcIYuCWX+0/UfRXfCVCfO/AymCOr/NZQPIeN9Dcwp0
 8UI4NTefO9mAsrdwQkS5Z9jEMhYVqv6KRPf1wU6gh2xe1fmZsWRFp5b
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX90epk7J4w2yB
 JFNZQ0weg/KUyk/DVqs6ixDRB55RG9qKjkJ++rSZ1C09rc7Hn+Q9Uim0QiPvK/lzompDgbjJ+Zj
 q8cCTPpfEguRqeWKUWOdnSPfQNam/ZW3OkAsgzYJRZuaWI24aBIrNJ2K05y6VWPM8OVlgazGGLr
 erBBQBhNKB5C0H6Fd2uHQ2R6nBA2pNzpbiwLk1FH5pq5Hm+3JZlcFu52NmSSCf/L/JX4Bkt5vko
 0azrkx+M2IZU7a+3Qd1cbfasZyullNCzgq/62pS/vlH8kJgYSpOh+XEYQxqFXgStHx8vigpkY9s
 p4KDYhgGNcPf7PoDRh4khRQiutoY85E/6mvyiGe1zlA6/FNLBdb7W6sXrJvxOi3BlZgU+6tWzZj
 IN7VGvp1lmYnbvxt+XBxQl6plpxGyieSDDCIbBvy/dAOduRYaja2Nx52hT4FmY6SvH1d7+bXNen
 TxScak/8gz05VuwIQNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX7DO88hbPRhQm
 jwwRDdFp7PIzgEBh3r7RZzADfUqbCx3cvnzZUbvBRP708/6uRSTHB9v5l2sGWAW37EoXMpub9cP
 JOas3XdgTSdIF5y/hf67RgeeQL3oTfo=
X-Proofpoint-GUID: yPGXHN6qj2v-kFJDrPrfNr2pPSS8FNoT
X-Authority-Analysis: v=2.4 cv=BusIUoX5 c=1 sm=1 tr=0 ts=6af7c0dd cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=bBQ1TlrZeL130n7Dx0UA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: yPGXHN6qj2v-kFJDrPrfNr2pPSS8FNoT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140007

During system shutdown/reboot, power/clocks to the PCIe controller get
removed regardless of link state. If the link is still up when that
happens, it can trigger SMMU or NoC errors.

This series adds a shutdown() callback to the Qualcomm PCIe host driver
that forces the link into L2/D3cold before shutdown proceeds, reusing
the existing suspend_noirq() path.

Patch 1 fixes pci_host_common_d3cold_possible()'s underlying bus walk,
which aborts as soon as it finds a device outside D3hot and can
therefore miss a later PME-capable device -- something that becomes
common once patch 3 starts forcing D3cold entry during shutdown while
endpoints may still be in D0.

Patch 2 adds a force parameter to  dw_pcie_suspend_noirq() so that callers can
set to make dw_pcie_suspend_noirq() force L2 entry during shutdown/
reboot, skipping the D3cold capability check that can otherwise leave
the link up if any endpoint hasn't suspended yet.

Patch 3 adds qcom_pcie_shutdown() and wires it up as .shutdown.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v9:
- Use uniform structure in shutdown covering firmware managed one also (Konrad).
- Link to v8: https://patch.msgid.link/20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com

Changes in v8:
- initialize 'pcie' to NULL to fix uninitialized
  use in firmware-managed mode (reported by kernel test robot & Sashiko).
- Added new patch "PCI: dwc: Add dw_pcie_mask_msi()" providing the helper
  used above.
- use new dw_pcie_mask_msi() instead of dw_pcie_free_msi() so the
  MSI IRQ domain and downstream MSI mappings are not torn down while
  PCI devices are still present (Sashiko).
- skip dw_pcie_suspend_noirq() when the controller is already suspended (Sashiko).
- Link to v7: https://patch.msgid.link/20261029-shutdown-v7-0-3fd7a76a6991@oss.qualcomm.com

Changes in v7:
- rebased on pci.
- Link to v6: https://patch.msgid.link/20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com

Changes in v6:
- remove return 0 in d3cold_possible() (konrad)
- use force as a paramter instead of the element (Mani)
- couple of nits (Konrad)
- call pm_runtime calls for firmware managed one also as we are enabling
  pm_runtime_enable and get for that also.
- Link to v5: https://patch.msgid.link/20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com

Changes in v5:
- use a flag/parameter Instead of poking the system states (Mani)
- Fix pme_wakeup issue by walking through entire bus (Sashiko)
- Fix Irq free issue by using dwc free msi API (Sashiko)
- Link to v4: https://patch.msgid.link/20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com

Changes in v4:
- removed goto d3cold, (Konrad & Sashiko for PME error)
- Disabling MSI IRQ's (Sashiko)
- Link to v3: https://patch.msgid.link/20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com

Changes in v3:
- Added null point check and use pm_runtime_put_sync (Sashiko).
- Link to v2: https://patch.msgid.link/20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com

Changes in v2:
1) don't remove the endpoint pci dev's only keep link in D3cold.
Link to v1: https://lore.kernel.org/all/20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com/

---
Krishna Chaitanya Chundru (3):
      PCI: host-common: Fix early bus-walk exit in d3cold_possible()
      PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check
      PCI: dwc: Add dw_pcie_mask_msi() to mask chained MSI without freeing domain

Manivannan Sadhasivam (1):
      PCI: qcom: Implement shutdown() callback

 drivers/pci/controller/dwc/pci-imx6.c             |  2 +-
 drivers/pci/controller/dwc/pci-layerscape.c       |  2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 31 ++++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++--
 drivers/pci/controller/dwc/pcie-eswin.c           |  2 +-
 drivers/pci/controller/dwc/pcie-nxp-s32g.c        |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c            | 32 ++++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  2 +-
 drivers/pci/controller/dwc/pcie-stm32.c           |  2 +-
 drivers/pci/controller/dwc/pcie-ultrarisc.c       |  2 +-
 drivers/pci/controller/pci-host-common.c          | 13 +++------
 11 files changed, 74 insertions(+), 24 deletions(-)
---
base-commit: 6633c535abc356ff868e72025ecd65aa0106630d
change-id: 20260822-shutdown-fe8139dff2b7

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

