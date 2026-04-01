Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120B36998C
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027281; cv=none; b=qGeWNz41fKdSMpdbuSyiQnHOgi766GehYI5OdsdrNheI/CpbEtghwSiONctc8EpJAXjJj8u7OV5ykGZWHkigfS24r0/BbNS6RDCTk8Nisas9T0HgAXEI8eJ3El35hDCO2TXpTnsAN1yBvH9mrSY6cDFnzAnO8xzDKTm3/S+V1wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027281; c=relaxed/simple;
	bh=BSCNS1UNMXIGtFM+QUX7Rbto0UCstaR3LYY/zZnmgvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJ1OJbzTngdUT9oyrJNsRkw6ZDu+N5E0IHpqLNbBXJeMKajvlKAXqL0BTaAnzJXnFOG+e+TECUJQgg02DD6oDmdtMEwFVwGxQodbuG0uouZ2ZUaMNuiKklyuFbQdViELoHtfux0lZOguT+IpSvK6stpqjNZMM1eVTnHC1GkZCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxtuUiMV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NSLy9ZUT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxtuUiMV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NSLy9ZUT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6314CfeB1579362
	for <linux-pci@vger.kernel.org>; Wed, 1 Apr 2026 07:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=h6zxdLf6xUW
	szA6KhrhvifDZ0ndILcCybaBSzNjg60A=; b=hxtuUiMVdgvrUovJ6tJEdaYYz9E
	I2c7cYpZD2KHUFZrCBe3rEYROwp8345L6XyV8WUcqrW3BKAkG5kgGVhaJ0idN3s1
	khGeKmX7CNeYmasPtVkAd78i0b3O28LAAWFVI7cN76Tis7sCTJV+BE0iEqeCq1lN
	eUeuXnNARsJHpZ3kX5balEu4P/VtLMa//K/A2zzaON9NLId0PHP7H3dPpFDfZ0rK
	pbORauWx783oDWG2QBZQ1iF5OkFUaH/8yDhcihIXylA6IEPkPoC23hqSa2GSFPS+
	Ja8Qc0ZhgrXIbNyF+LnTe92F3jlJeGyFNgkBYtFRV2GWB5Ea6Forly4i6wg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2t93t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 07:07:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso18928097a91.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775027275; x=1775632075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6zxdLf6xUWszA6KhrhvifDZ0ndILcCybaBSzNjg60A=;
        b=NSLy9ZUTLvHPPBqhpw5wPklQwgr+LJ6v/+Bvh71Oc2YPeRSgo0neI0TeILx4IaBz6K
         mjD1Cb6zC6GdHxjc5Hci2hrZxlH/7jtJiIAfzE55gpi4Rp7fi83hCqTJqlLnhcZ9C0Ej
         RSY8gGgeRaygT8atTpna6vsmoAPZQDLehhOs/fkOLaWGy96PF4I1wqHD0I9Q4Rd8DAnT
         c7f3pwQYcT9rBNq5Nfe0MSXEErJDesyuAZlhIHy33Lw8ywNpA5nn3CLAu7QzsltgwfF+
         NaAbmkBSj3UPnbJsBh69r/BHog73R8igqJ88+RWhxAVytmwXni+jfJbntcdcIIEOl7oB
         7z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027275; x=1775632075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6zxdLf6xUWszA6KhrhvifDZ0ndILcCybaBSzNjg60A=;
        b=HYvZFEIra9jF0hM+3g4RAHMZN6yTtqS407Kvol9t0P2uf2apbYaRjguMKiks/lRWwv
         9sNxj/xaWff2LxSqjn6R/J15RSrdx4G2cyTfX1wChbY703fe7YW7vVSqG5rqy4aKBPOB
         88nkY5fh2vkdL+I2obxizTPLeWRengpDGTZ6zDGL45SlzOmzqmA4NnbMEAZ7B07JoZkI
         zQBJZweuN4H1mxdZkCDcz23PKJMKGCEljnvroqrzT70V5eMO1iXakUeAFYvNyYbif9wF
         6GqBC1Wi+9RHGxyrJIXTXyEQYi8biTHQP52uyRnrv2gR+LK/9b2j0/7AKhk9tJvSBVqD
         f0Sw==
X-Gm-Message-State: AOJu0YztOzyTPVrDboFqBVmAAHGyd9Qx/pSqDy1yyat2ZXk9QLVHzyfR
	8LHNXdtkiur3pZ5SpUv3HwhS+ufpk1t/m5g3Nu43bpJlmvdZYs5Wi0cnO8CjhMeSMHH/uO+Fea+
	PSFdq4tX2mY1CvJRypN+lloc5yoNwhLNRxS5WG/D2Zz9i9FJJuf26Z1IxTQB8gBU=
X-Gm-Gg: ATEYQzwS3isBDQaltvVZzCmsAGgNUTPeX0BEzIlNoKNRpMbNTmK9Q7Y6HLFasK2jU4V
	kcAZ5EXLSLwCwpB37KfzmT6QzPTMYb3f594CaS6FQPY0Sgtec9E3D0T3IMydhtzuf4obKQ5v8h+
	9VFoJpBDaEmpIxYYah+CUq3xFTtWaXbHhEaZV0BA4CaOmK33V0TUdx9GL/SVd53Qx6E1ZQBXfSK
	pX8bkacuDaazxjzbPCh+XJli924kq3sv52lcxayCL5i0l8bKJ/swsrnMWbPAOTbLOHjNfCm783l
	MPYQRNvz6zj3lZ0cTArqG5il+je5iUDwHT5c48MYYL7d65Lowg0u1wI8eb+Ly49Za2S9LEymBT+
	uFogGkSw1VDCiZJpqDcvuock0yy7KpmZMk5N2
X-Received: by 2002:a17:90b:4b05:b0:35d:943e:3c2c with SMTP id 98e67ed59e1d1-35dc6e77ee9mr2279409a91.5.1775027275104;
        Wed, 01 Apr 2026 00:07:55 -0700 (PDT)
X-Received: by 2002:a17:90b:4b05:b0:35d:943e:3c2c with SMTP id 98e67ed59e1d1-35dc6e77ee9mr2279369a91.5.1775027274518;
        Wed, 01 Apr 2026 00:07:54 -0700 (PDT)
Received: from work ([120.60.63.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6e2fc9sm3956464a91.15.2026.04.01.00.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:54 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/3] serdev: Add CONFIG_SERIAL_DEV_BUS guard for of_find_serdev_controller_by_node() API
Date: Wed,  1 Apr 2026 12:37:34 +0530
Message-ID: <20260401070735.107162-3-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69ccc44c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=zTATW481NYPnotdwU90osA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=b1-ATBUx8nBV-T_5hXwA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: TLr3iWau6Tglf2OLWwdQGnUIiCKSFVOd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MSBTYWx0ZWRfX4YJ4FKfK+SE3
 G3FUgZDZpUjni8PNx/vsYa5BNt6hbU6rSPzajfxmWRx4ZnTI3+8/Bn0Mol/6RDH3sPM+nvhsymu
 pEIjnLra2JctCs2fkXxObM6z2k9HqRU5h06VDAmq1GP+k5/sr8ytJVkwaQCmX5AXHY+1RsaNAvP
 vA9wbCh3H39DvMG5Vzk7tQi5sEXEKS2mwz5LuWm7oBvCoF4BNTc4r3ufcoXuIVg/EHfv4kdPgqD
 ZPvYRyfKkIzFYKhNicnsXSbOp1MvLQGASGcBc20X1jA84oNfXfUlxtinnVpKCgmPmMlv0EFuYdu
 /YmfNPQy+m0F3Vt6is0v9SY5ScSdhkJLiEk4qGgexVkQ0YSQn6vU3Rg/4xu5zqkb0OtyOugKDrg
 cPyLc5FOqbGoAQ9XCJWiQuJuRV61Dtb5xmeT4D/oKwJLb8TsD4i1+Xlj6f2q74wch3Jw0bUQ7MU
 G3YihIAFyXMWiXbdfNw==
X-Proofpoint-GUID: TLr3iWau6Tglf2OLWwdQGnUIiCKSFVOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010061

Currently, this API is only guarded by CONFIG_OF. But the function
definition is guarded by CONFIG_SERIAL_DEV_BUS symbol in the .c file. This
causes below build error if CONFIG_SERIAL_DEV_BUS is not selected but only
CONFIG_OF:

pwrseq-pcie-m2.c:(.text+0x924): undefined reference to `of_find_serdev_controller_by_node'

Fix this issue by adding the CONFIG_SERIAL_DEV_BUS guard to the function
prototype.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604011226.KGNn5974-lkp@intel.com/
Fixes: a2b4814190af ("serdev: Add an API to find the serdev controller associated with the devicetree node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 include/linux/serdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 0de261a26284..58f000534bdb 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -356,13 +356,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
 }
 #endif /* CONFIG_ACPI */
 
-#ifdef CONFIG_OF
+#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_SERIAL_DEV_BUS)
 struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
 #else
 static inline struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
 {
 	return NULL;
 }
-#endif /* CONFIG_OF */
+#endif /* CONFIG_OF && CONFIG_SERIAL_DEV_BUS */
 
 #endif /*_LINUX_SERDEV_H */
-- 
2.51.0

