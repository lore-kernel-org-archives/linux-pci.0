Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB139BFF9
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485357; cv=none; b=tVgjAsE7PmuP5Ho2mxppQjBy/tES1W1QynYJBo+M9qedph9PatpXHo9DdX6qxwJsDsC45JrG6RgqTIHt92eayhtT9jPUGq0XFSXOXjF6OGEE46fV94noTtNckIcQvIlBVXlKSC+2w8+i1cCfmfLnmeRVaVdJUYbr1lXQOtSZxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485357; c=relaxed/simple;
	bh=IxaTFWPs5AeZ9qDZDj/eON2uwYfQsG/fC5lChCcIAM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dCN4zH6w2l3SAt7s9FJP0FP0+gTOlgYfeLdgp2Tbpq3R3JGUcoIyk1rq/yedJdT2hCRfXfL/g3aQT6qKpsFQJOOvWDJgv7PvMMYTocUEEiE5z0LXQANkvAAXnKWi2Y0/bDV5H4o42tNtfkFU011uDkvqHvJPWuaCJwKKySUuinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=alTkTJdE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DjkuZaHw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="alTkTJdE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DjkuZaHw"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B77ZTo519296
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jWLYsunHeNy3UIObpc2vi2
	o+8uNEW23EaFlmiFzQDvY=; b=alTkTJdEtLqWvggJGBWOL9xaM1ZyAvMKMX8zJ6
	/WwWUeAIJlSXZkAe4t5oxhDzOc/YjEi3GWRzCop1CD9v+Dl54OE8XxEx7bSaK28j
	1X0OkhRdpTALYRsPI2nzJJBPrYZHiEWfVOFdQmNwcIJoMYY/K5cIKcHyPaXIOPpx
	4smM0C4ZU9s5XpKG22qg+yKeJd0v8C53R04gsBjCYFfinGXw1V5tIB4vQ6cGm0K7
	A5Kg57NMTj9wqky0U89rM+hz3klpnXxs9s+2K0ZNpq32gaBUUpfhCIj9hf6XMJgs
	1j55V9jgw6lJJ7iiJ3uVMXwdgGuteTVPCYKp2jYbS6Uc+JmQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1wpecy0x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:42:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so3542892a91.1
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778485351; x=1779090151; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jWLYsunHeNy3UIObpc2vi2o+8uNEW23EaFlmiFzQDvY=;
        b=DjkuZaHwTkwUUSSkyA4KUiAL2Zb5+uyz1vLcgjbeuv3t41JpbxRvLxBjIwmw1zwdxl
         NtQtO0uXc9dsMOr52a1d5n3mV6YLcbBxNRzfOCDzcuSycYFBGRpsT1wTFDdYo3dZD963
         Zfs8AyBI16x4gScgh2SpWBww7RT7KZL0DNLR5WuVGS4jmIyWQIeS3icnXIdQd29fTLP9
         omn75FxrswIIbD7FHhvYDxq0EG5Y7cgy4oHbN/QX1/n9wub8io/85JuO6cWr/zl8Vod4
         0n1qJ0Ie5FyXHU8OtEFpFa59k2aieFPOG0eDSRfFQZLcG9t0lq4GqYUBjbwtjUORkOdS
         NrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485351; x=1779090151;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWLYsunHeNy3UIObpc2vi2o+8uNEW23EaFlmiFzQDvY=;
        b=s64OY5S7LqH/2tBXQnXxgpKq7hThaYhQSxJYaB5lNR4xGmDHeopeKWaXRQa05IJfkQ
         NMQZg73juZff0fTzPXCifkWQIVeuKVOveTDC9pf9l204S0ETaoz/mnlAcsa7rCEDsLm6
         +p5XsK2rfX81U0YiwbWbofYbqIbA7o0ORXVCm4m1QM+hFIdR/3x5j4+g5P1id4vO752e
         YiWfT1RsDW8r8lw/pbbvOsDP+aDSqdRh+wntBS9kWQhN6dHPHB4vR/WnolEVIp7ym0A/
         67NrKbNM6x5sQvHNUhFGLCWzlVDfOYsCnr9id7Eg/KhE1FtctkA736otZAp5o5dNwdpa
         onQQ==
X-Gm-Message-State: AOJu0Yyy3x+F3vzA97Pk9neAut0gAlLHIYTMUACvc1gEewK0XnnjcpxI
	sRqgJPH/Krb5uqn1nlMDhEBGwEMtDnLcmDpK77BlAFDJflUOBKr17JRtXLDck1flg7xEtuMp3nJ
	34Xp/Cc6fKHyK+0AuBBYDhakFaS9KYH0EXWRSKMHNcR7j7ikjHmqjDdUyl78Hlsj+aVJZC18=
X-Gm-Gg: Acq92OEptqzsq+6Y2RpYl7l50gf/BrM4roVP+Ed6ZDCNauLrY4QXetg+MvmhJlIrg50
	qAejWy+m7hvUzZAr9kAUxRNpN7WyC2Sm0uSlDmuRL12iTtEmXYCJi1zAy3UwiWcOQ9tYsvIq8Mw
	MOQUmHq/PtJNVCK8DqZc1nt+w5cb76XtxNI/ib826kw4dwf5ZYZXhUpFkN4zer685AzQp2OmmyC
	yPYN82Allk9NA2OknYHeE06ipbJU2DCy7XZWo3E7KDR/6ONvSZmjw36bPU6Zg5QW98qnlDDqklD
	1hw+P/kGofjdDQphPPcTLoqumC8I9klCPvk9iqwuQ/E1NsNYorr00Nfv8+WKnzw6jtIdycE4yf5
	IIULPkHMaYxmI5V2IGc6I15G1pd1RCGYQeVNj4N1jfUj9KGN4+dRZqWvA
X-Received: by 2002:a17:90a:d607:b0:366:132:fda6 with SMTP id 98e67ed59e1d1-367d481a4e4mr8216254a91.11.1778485350571;
        Mon, 11 May 2026 00:42:30 -0700 (PDT)
X-Received: by 2002:a17:90a:d607:b0:366:132:fda6 with SMTP id 98e67ed59e1d1-367d481a4e4mr8216232a91.11.1778485350061;
        Mon, 11 May 2026 00:42:30 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d64de478sm6724798a91.13.2026.05.11.00.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:42:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 11 May 2026 13:12:25 +0530
Subject: [PATCH] PCI/ASPM: Mask ASPM states based on Devicetree properties
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGCIAWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNL3cTiglzdlERT00RTEyNzy1QTJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tANjtNvBoAAAA
X-Change-ID: 20260429-aspm-da55a54279e4
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778485347; l=2653;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=IxaTFWPs5AeZ9qDZDj/eON2uwYfQsG/fC5lChCcIAM4=;
 b=Ufr6D7e9wg8xF1mv8wFCFjhQm8YjzbCGgxo69Gn5uivnIZoTOx8SGFYDd9xc9K1UuvdPwJi2T
 oTVxhvMv7wEAZw+2IEN2C2A/DXJtcqPla7NMmA5yZLkgK11Z58Bba7z
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 3oaoAIh9a2aMRq9UuIFp2WhSHSQbYUpr
X-Proofpoint-ORIG-GUID: 3oaoAIh9a2aMRq9UuIFp2WhSHSQbYUpr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4MyBTYWx0ZWRfX6zjnYrGaoFcO
 Zj3K6TOzBwYZYUtMeSFu1bHH1fc2n7e64ZcjikRtR5ptVSsfya/irUWIQ7COhbuF/LV4uSW90Sd
 qYIkSvBCLmkJPWfgF76Q4ylFqel2RzgXrKq5y/7PsrkFXSzs1cCI43ZdFnzDmNa5XwwQbrPfWS6
 SdGvQpQcJBGjziUspS+GVJa15VYlvvuw113NUdhfIKH4ffcqOvQ6PM63N4FJ5W9mwi4qFJCfI8z
 UAF2+UpR7huz102ckuKfUyeoXXKEDOUkDfnztzfE1PJCElwHlegurTRXo97JXAC6i0KdNpEASl3
 i51shrG5nSZ5yIjlTwFRIKphwOXaZIhoF1bFnHnlLMG2z2WceypShmBP2G2WcG5l7vw319fIAJh
 ueLg4mwvdqe7yHWAAuH0mnFAMBBlG5mlffVkKZc+9l2XSidmlBa/D/JQzrR4I4xftuPNAnCieov
 ksv2pRpO6RbHoLenz4g==
X-Authority-Analysis: v=2.4 cv=EeD4hvmC c=1 sm=1 tr=0 ts=6a018867 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=wuQQqu7ThqwHlQwkt1oA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110083

Some platforms require selectively disabling specific ASPM states on a
given PCIe link to avoid link instability or functional failures caused
by board-level connectivity constraints such as PCB routing, connectors,
slots, or external cabling.

Devicetree initially supported disabling ASPM L0s via the 'aspm-no-l0s'
property, and has since been extended to also allow disabling ASPM L1 and
L1 PM Substates using the 'aspm-no-l1' [1] and 'aspm-no-l1ss' [2]
properties. However, the ASPM driver does not currently account for these
properties when determining the default ASPM link state.

Update ASPM link initialization to check for these Devicetree properties
on either end of the link and mask the corresponding ASPM states from
link->aspm_support before applying the default ASPM policy.

Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
Link [2]: https://github.com/devicetree-org/dt-schema/pull/190

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 925373b98dff..3111ef7fd226 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -799,6 +799,13 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 
 #define FLAG(x, y, d)	(((x) & (PCIE_LINK_STATE_##y)) ? d : "")
 
+static bool pcie_link_has_aspm_override(const struct pcie_link_state *link,
+					const char *aspm)
+{
+	return (device_property_present(&link->pdev->dev, aspm) ||
+		device_property_present(&link->downstream->dev, aspm));
+}
+
 static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 {
 	struct pci_dev *pdev = link->downstream;
@@ -806,6 +813,15 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 
 	/* For devicetree platforms, enable L0s and L1 by default */
 	if (of_have_populated_dt()) {
+		if (pcie_link_has_aspm_override(link, "aspm-no-l0s"))
+			link->aspm_support &= ~PCIE_LINK_STATE_L0S;
+
+		if (pcie_link_has_aspm_override(link, "aspm-no-l1"))
+			link->aspm_support &= ~PCIE_LINK_STATE_L1;
+
+		if (pcie_link_has_aspm_override(link, "aspm-no-l1ss"))
+			link->aspm_support &= ~PCIE_LINK_STATE_L1SS;
+
 		if (link->aspm_support & PCIE_LINK_STATE_L0S)
 			link->aspm_default |= PCIE_LINK_STATE_L0S;
 		if (link->aspm_support & PCIE_LINK_STATE_L1)

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260429-aspm-da55a54279e4

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

