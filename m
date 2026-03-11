Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943223CCFC7
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224822; cv=none; b=ol59x3Og/Vn98UUk5gS5AYs+uiadWAYggRgiQlS5wxEqp4Dd7IDISeIgQCSqJzD86+V8+nQh6B9Wa/McZ8C8TXGEYac4z3NKNqF+IyLvP1fa4ABwS+lwtTft2tzfb1N1/5oYjweRhQLN0IOvmYV09JzlSp1pr87gb0x5oOp86Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224822; c=relaxed/simple;
	bh=93ygZdeQRqHkq5ovyiCONEu23NLO7pmiNx5kC7Pbml8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gXhSuiYb2tFA6V1ojycOt9MVcYpY2T191/bzb5DUUDNI0pXcwZauGiwzbMHvQmeBXmTfbbs7ic+ZTgGFSPJ8MCgKIHNqrrV+0e9oc6UwDHOWDfqfLVDqCENletWQg7wr0j3CIGKrbcDdzgCDWMThrAK4yrf8iz7uXdYLQmUpe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aDyg6H2b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ETfvyzuL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDyg6H2b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ETfvyzuL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BA5har294388
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kBZoQvcumGpdfznzcBnvdbJ48xIvFXfaJ4VllTrdJNA=; b=aDyg6H2by9l2qQfT
	8m4QMgH+Z8CgsOPLtW8JnhK3oCB0eLQUb1HMX9g47ixWYpJnqNLEH69l8YdwIHPl
	tWZpOsj8C4i3hGgz70k+84l2UqRLSuFX5BI1l6AhuDqOHCCxUOos4AnC+u+cFKY1
	aKQfExmDC95gpK+JNtFJdC7HodVA9v+NHkA9BbKV+Qapa2vG3KXG52hl/2x7rBja
	cPtrDyLGPvFn4l9wwE9Z7ZwkOwZ7kVM9ClSgUguFM+tbmoSzpQGWZyqbV5ZoaRwL
	s1dyFxeeLSeEQd7yzs5pZzjk9Dfq+uqSCGwYh9Q0TOZlSOHwuiUhpfz10rzGK3+K
	8JnMag==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu6bb82mc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae42659a39so624878445ad.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773224820; x=1773829620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBZoQvcumGpdfznzcBnvdbJ48xIvFXfaJ4VllTrdJNA=;
        b=ETfvyzuL/qTJmgwYajQJnwft9ibffBKvarMAUeu0f2AeRsIU96F/6nt6Vu4He2ZgEt
         2T0ZA8pJ/ciLL0/pbVrnYx77sOqTycWwAH749W4i9TOYGXoh8+GQr8waSf3DgZUfVBDn
         +CuZO7KzlHr7/aRZt5VdkumrW7AKdBUyVGUCAYFYtgR2IH05dah8+BJ2e9GF6rTSXGEx
         Sx+SH8nmnObG8+AHzYN9iuZOAzD4jnxfWWwGeRHE8DFJ1PafZ4y1EcPuhtqg4PehifNK
         IG+o6X1xgiDTDsSk14P7v7Q69bDfD2N06VtxXPEMWI3mF0I3z2BVmZLsE+7h6IWQlpQB
         A9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224820; x=1773829620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kBZoQvcumGpdfznzcBnvdbJ48xIvFXfaJ4VllTrdJNA=;
        b=l9h9D67a/AUypF0su/2DnRLVpfy0lsqFH9eWGuuuVFIFBTK14Jux6MSXCCxIvWoXV3
         wj0IKAusa+442KuIW+ke4MsPbBqgWzGN9Gmsygk+BwH2MorOOy0NqWKOXhXxRPSv0iI+
         +YZTfqpg3+5FElN7lN9xL8zeeH+/RXMyvaAnzJ9KsrLoruk0rQ6nUUn3XxI77XLPSAzI
         3NPEsSCnwnYR5oCEkKR4Faz6fhl/bE77nTaLT7OSplMWAW5qyTHlPUdThvyjoIz/UJgt
         0EcKPmWEZALmkUxw4oWEKrQefcMXJfjKqXwheAtmfO5g9YxIgtoP7143/kOALI0VsvjT
         kEaA==
X-Gm-Message-State: AOJu0Yw1CwPyYBC4Bq2ijfl6wmgSxpeqdMwMRqj4uMdiaehqCmO9Fze9
	DrX6uXzuvoEyGfiWpajOSDyze6V0sDO5yljdVI9jjkJ8RG0pptpz1DfaOnPJqgMljqGqt/wrnPw
	m8NNnC1f1y04ATBRZngUC5W8WfOND0yHYp3SqxvTs30CCvfXj/bmKMwiywaIkB9k=
X-Gm-Gg: ATEYQzzdOtPHi4IcGjG6tPx+v9Dtnr2vUuvWP0AgKOFRroR57877PI1eqomdeJ4E+Sw
	uGcJCMa9e9ra0LdKVXCVtF9JOyArW2H6DcGSfIUyBkaiJhcklSh+8FptcNt5vu/Yg7V8vMfOsXs
	5vFMapBhCCU9qHCfnkYvD8DfAtjcW5O7Z6ZdH2r3seqYmU2spJoEri+bhHvOrxEqLBL9rhuodC2
	R/Z8jI5Mbt73YuBzyLj6MCeZXBapN7KH/TT/ODmFGusvB9jg2SLpb4q3bLW6pNMgulFgl1+v652
	4UiweALK0eBgtOBBecfNEvYMMF6FuPZLZR90CH1kpLef3eSvIqCYwuYRJFiqSl0eM+P1iLERZmE
	k6S9JrKjBBT9l5LfGHlg8Y0Rlk8H7hZIluvZCqS23V6nXbuHBLM0hX7CG
X-Received: by 2002:a17:903:1b4d:b0:2ae:3a1e:3490 with SMTP id d9443c01a7336-2aeae890bffmr23536575ad.38.1773224820065;
        Wed, 11 Mar 2026 03:27:00 -0700 (PDT)
X-Received: by 2002:a17:903:1b4d:b0:2ae:3a1e:3490 with SMTP id d9443c01a7336-2aeae890bffmr23536275ad.38.1773224819581;
        Wed, 11 Mar 2026 03:26:59 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222872sm19575245ad.18.2026.03.11.03.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:26:59 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:56:46 +0530
Subject: [PATCH v3 1/5] PCI: host-common: Add helper to determine host
 bridge D3cold eligibility
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-d3cold-v3-1-4d85dc7c2695@oss.qualcomm.com>
References: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
In-Reply-To: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224811; l=3882;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=93ygZdeQRqHkq5ovyiCONEu23NLO7pmiNx5kC7Pbml8=;
 b=fX66UOrcHSNFF3TnAdV8GYPmQS5WtCr5vzQSqYKckneMe1mFqHcZX55g6QyMI+wwv6zKXww24
 EA7Oo9L3jQVCD/Zp85+FhQ2kcVkPZBvQpjLkoNDQpT/3nPFMcA4gR9J
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 51LkQZQRifr53i4wvuTvOs0SbOG51Z0P
X-Proofpoint-GUID: 51LkQZQRifr53i4wvuTvOs0SbOG51Z0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfXxh1BWlL4YoWl
 YfH7k/WSZo6+ohdGtJo3JC86u+QLg32E18I061MKskpHuD2XBZ4eRvR4xe6F6dZAnZB5Fg678Er
 5xILBtu1xAszCXkgaHlDYKmA1bZ2ZVVIMlmfBIN1BOMepjBzk0tBYvKzl5d4uFYTF6Zw8x2GUUc
 tjtmb4H6ccnAcN3DcdXLFxw+rsCSM0U57v16uXUrpVykkhHhibfedvwsfP4TBxU1iOM7NiUJoxE
 /p+r4RRlRGSBpT6ALbHeXTB7hM4KqO4bZPPaoUcqr+wzBn7pi2a2ZpB1VezbMZRAUpGnIRQINM0
 jiW0AuyHHz19/0xDXDFAGnJJLkXIV9TOp/gbFsMW8PpVoukBcGlNcojwjp37fs7g0s74bOSH/L3
 nvVAQnBH/B/1XBV6gsbcpG5mArN0pEPpCusZKnW5j95tLtu8y0FdnYs7gAvA5/ZkBSAT7NeqpA6
 YHkbB0wWiZTnzT3SSNg==
X-Authority-Analysis: v=2.4 cv=CKwnnBrD c=1 sm=1 tr=0 ts=69b14374 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=R0UKu0mhgHHlQpweOhEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110087

Add a common helper, pci_host_common_d3cold_possible(), to determine
whether a PCI host bridge can safely transition to D3cold.

This helper is intended to be used by PCI host controller drivers to
decide whether they may safely put the host bridge into D3cold based on
the power state and wakeup capabilities of downstream endpoints.

The helper walks all devices on the bridge's primary bus and only allows
the host bridge to enter D3cold if all PCIe endpoints are already in
PCI_D3hot. This ensures that we do not power off the host bridge while
any active endpoint still requires the link to remain powered.

For devices that may wake the system, the helper additionally requires
that the device supports PME wake from D3cold (via WAKE#). Devices that
do not have wakeup enabled are not restricted by this check and do not
block the host bridge from entering D3cold.

Devices without a bound driver and with PCI not enabled via sysfs are
treated as inactive and therefore do not prevent the host bridge from
entering D3cold. This allows controllers to power down more aggressively
when there are no actively managed endpoints.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 47 ++++++++++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5ec480fd2a7e50b3af39ef6ac4c8c..bff23bcdb5d032d2781d963eebe4a3fac0505517 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -106,5 +106,52 @@ void pci_host_common_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
+static int __pci_host_common_d3cold_possible(struct pci_dev *pdev, void *userdata)
+{
+	bool *d3cold_possible = userdata;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return 0;
+
+	if (!pdev->dev.driver && !pci_is_enabled(pdev))
+		return 0;
+
+	if (pdev->current_state != PCI_D3hot)
+		goto exit;
+
+	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
+		goto exit;
+
+	return 0;
+
+exit:
+	*d3cold_possible = false;
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * pci_host_common_d3cold_possible - Determine whether a host bridge can enter D3cold
+ * @bridge: PCI host bridge to check
+ *
+ * Walk downstream PCIe endpoint devices and determine whether the host bridge
+ * is permitted to transition to D3cold.
+ *
+ * The host bridge can enter D3cold only if all active PCIe endpoints are in
+ * PCI_D3hot and any wakeup-enabled endpoint is capable of generating PME from
+ * D3cold. Inactive endpoints are ignored.
+ *
+ * Return: %true if the host bridge may enter D3cold, otherwise %false.
+ */
+bool pci_host_common_d3cold_possible(struct pci_host_bridge *bridge)
+{
+	bool d3cold_allow = true;
+
+	pci_walk_bus(bridge->bus, __pci_host_common_d3cold_possible, &d3cold_allow);
+
+	return d3cold_allow;
+}
+EXPORT_SYMBOL_GPL(pci_host_common_d3cold_possible);
+
 MODULE_DESCRIPTION("Common library for PCI host controller drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index b5075d4bd7eb31fbf1dc946ef1a6afd5afb5b3c6..c0ef2a2bf3994ce66686b3f8eae25538f3a902b4 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *pdev);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
+
+bool pci_host_common_d3cold_possible(struct pci_host_bridge *bridge);
 #endif

-- 
2.34.1

