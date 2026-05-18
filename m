Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17131A555
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098836; cv=none; b=nAV1+p+X6asqlrzRCf8sLbXuA+to0Wk6iVDqvo2CFBgnR63zxS/JSSbo/y4TeTYDzWRccCAjc5Ih605NS3uIZN7jhFxI2geIZiy8oBUvWcjQZkgG6+HOPJ0GL5qHAVR67vl/aCUdHmM2bt2Z84SouDIf6SbKU+1J9xXZRRGoRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098836; c=relaxed/simple;
	bh=kItwfnF8TSLRgrCFXfJWAqvgmBxpb/zPSrYis6Gt18I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFFpuYjya8ko5talUf+VctTyAVFipW5yyTTd1QF+oKWjV4xu7/KLuwpTf7AQsHrpYqsz3M6+NQzH/ot4/2XEbehPRPrHeL220qNHt9KeTvBoCcKVXoHF0JeYI8DzmUq9y7DXyw65Y5IGW9fNcTnzS+p4XFt9aG2dd8j1x7dtyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+mFykxb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hf8ZRBO+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+mFykxb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hf8ZRBO+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I8wplb2566976
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 10:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QWzJIIjJ+geDV6i4FDTcxztjwUzatxE0cuY
	IpW+2aa0=; b=E+mFykxbGJ/68W9+Y6y5BIaNUtLK2NlK0dfSxMbNh3gBSxTF5Dn
	ki2uHJfdyBkyFpNQd76YWptL9y7nk9sW7ZF7tE+oB1gsyjj36wFdTenzHLuU97tv
	6men0eloUNx5c6HhRNUKjVLwIYL8UmFCUFvWoqVc82qQL0cz2ayUtGygTqOq8adf
	8Uv+uFW+0pjp+yCh4uIR2/K773n9bhcjZP5bDt8kS3RLQfN6goBPIlD8C18RQWCj
	Hysm2sm7AORjjNqXg6bfM6q8uN5I1iSEyYyHbvxVNDRgTwC8z64g8QZXGC7Ke8Lx
	Oq1cKdShdJbnbW+A+Bdn258Ocm09pwwLsdQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvqwxps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 10:07:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50fbc70cfbdso64217241cf.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 03:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779098830; x=1779703630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWzJIIjJ+geDV6i4FDTcxztjwUzatxE0cuYIpW+2aa0=;
        b=hf8ZRBO+VqY2lnsoe+6CruXcRiRcQYYp4bTOUDJp3OnbfNt9pG0AKO4tTiQ23pVOOO
         eXNFSzDbX5dZBN/kGgItlHN9t94+biujZwVlJj3sc3t0XUwqwOXBhqC7fEF7qlTrZIg/
         FlyDNapMJ77hjvgohlRa8Li0PcDVku1576NZxDroXK//pLej2GYYB0txTweJwx6QK3RI
         VjdPjnJ1UIJn45zKIrj80Xw4NpOtqwKDtm0YyBt/4ZiDYYzSK7JnELEY2STdwdUv9vmY
         DN+V/1id+P2iX+Cs+SZNgH+eDwiKrb/bouxF/hzAhInkxZmcynPAWnu7+aC88TSqVpQT
         GcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098830; x=1779703630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWzJIIjJ+geDV6i4FDTcxztjwUzatxE0cuYIpW+2aa0=;
        b=rkWgsyWJDxH68Y12SKdjew0XnvnKHbS1E5m2K7H33kTszkT8IRI5ek/VpO8xwp0iwn
         +4kn3DR0AX9Bqv8q5H3tuwYP36YmINKpWM3a8LpsfN1lyZOsouthC/YFXX1gHYCM4NA4
         fRbym/832ydlhmmiQPCeTGeO13jSKyDc5ePsqVpSCm4cNEDfG7orb9ZcsSSjIoduEwtW
         06VxKnmgScFXq49LTgaibRVCsowi77mKEfPb4tNGoMYzgqucMi4KCpa8YnI4ub6/z0yR
         53MTk2DXYwgplUgbZuOHA7BhhLvzslJEDiBf86K1kCa6o3WusGAodOYYw9/VrKC9pBiu
         x21A==
X-Gm-Message-State: AOJu0YyUn2TuDBsrC0Q2/Eg+X//bIYTuP3eC39PUYVo+0Dck9MY1I7jJ
	cSztXyftUyaEI9Xbum1kZ1YaEKYXWdIpscU+T3mes2QguxIa0UQwyjsV9ciQvYi72U33RksYZ/V
	hOw4zOISw2UELUS+EIOB1vpzy5jzUHd+ui3xg7c6xPc2vFsM6OQEjpwwDYQuxPhY=
X-Gm-Gg: Acq92OFHvUlPrQw35cnom/gHENfL9VHbePajzqIplbfLXk+1OwoNqIfbiO6Jbz07d+R
	4XkKe2HVPM5N42vz1fGKxo+xewYOYAm0yoHwp9z+2P8hfG+kRLjo2I6BLYEyUDtJG25uKKzZulW
	x6BOj8orZfeEk7mDNRBWGX9rrde/x/Q6iQJYa43qM18c9j0HnnRr5zvVBQQJOeqdKheXziPhdf2
	R27j1yVO3S/VbgMi8frcuhLzaMrtAFa1HEci30z0xTh/2rz+laKCWwUzJ0T4v9BNxGQZwtdRllB
	wG+5e86OQHHsRzjwTkCToTS9g6wSdcunpzuUU2E/vGqLx2jpYH+URovwfYVR6/tV7WEbJbDS6H+
	9iYVno7tfK2oiJVAI3R9iIC2xl7W5r8b5HSEyu5yacPqWc/ri
X-Received: by 2002:a05:622a:4a0f:b0:50e:60b7:bb3f with SMTP id d75a77b69052e-51659e9e188mr193853151cf.0.1779098830256;
        Mon, 18 May 2026 03:07:10 -0700 (PDT)
X-Received: by 2002:a05:622a:4a0f:b0:50e:60b7:bb3f with SMTP id d75a77b69052e-51659e9e188mr193852701cf.0.1779098829846;
        Mon, 18 May 2026 03:07:09 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1337:b6d0:456:372c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19a0csm34322951f8f.20.2026.05.18.03.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:07:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH] PCI/pwrctrl: lock device when calling device_is_bound()
Date: Mon, 18 May 2026 12:07:00 +0200
Message-ID: <20260518100700.47581-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PxjTzhhL94Hs1nD3L1-H5aUJhMXltUyU
X-Proofpoint-ORIG-GUID: PxjTzhhL94Hs1nD3L1-H5aUJhMXltUyU
X-Authority-Analysis: v=2.4 cv=LKJWhpW9 c=1 sm=1 tr=0 ts=6a0ae4ce cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=MXdN1EfwqQqHdsfe83gA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA5NyBTYWx0ZWRfX3/SncIE9XvJR
 kwreXOjDl4fsW0jB73W74HYSeK0P9PJ8SLmWR2rQtTHrc1tD/6OWVugPSYmGAOyKCdGE3e9ofkz
 PcFjX2lIEAyt8ME8dB7QZDhqa8m0k6tYzHRkCJx33EPWYokAKqIWg80AuzeT4BoZLzwoc+aKs+l
 AwmUo0oXmhyPkytZ9mbcAw8x7ctVKcD3u3VV6uxrv6Z8JLbJgGF56LzIZGlnPmUrAzmhrT/DwCm
 wByyOcksdyAAsKa+GUXb3OFjrWsQETmeLPb9RMtgwZcBGQ1Fly3XYe6dtAEn/c//4sfPGGq4HuT
 AQDUG1yZfg3Smp7drCX7uxaG9DL9HiKPZ6dyGUSsORKj6ASDsk6eMS7OYH8146OaNQRyK6EBJLY
 UumPMIfzLiQI2ZY8DP8bkhfP/SZcJ8haGDllnkYL5uRxKKmbV/E6kadBS86zM2nmKjeUyOPduie
 5susSbs0MZ44UWOWIjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180097

The kerneldoc for device_is_bound() states that it must be called with
the device lock taken. Synchronize the two calls in pwrctrl core.

Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 97cff5b8ca88..cd08d590483b 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -161,10 +161,12 @@ static void pci_pwrctrl_power_off_device(struct device_node *np)
 	if (!pdev)
 		return;
 
-	if (device_is_bound(&pdev->dev)) {
-		ret = __pci_pwrctrl_power_off_device(&pdev->dev);
-		if (ret)
-			dev_err(&pdev->dev, "Failed to power off device: %d", ret);
+	scoped_guard(device, &pdev->dev) {
+		if (device_is_bound(&pdev->dev)) {
+			ret = __pci_pwrctrl_power_off_device(&pdev->dev);
+			if (ret)
+				dev_err(&pdev->dev, "Failed to power off device: %d", ret);
+		}
 	}
 
 	platform_device_put(pdev);
@@ -205,7 +207,7 @@ static int __pci_pwrctrl_power_on_device(struct device *dev)
 static int pci_pwrctrl_power_on_device(struct device_node *np)
 {
 	struct platform_device *pdev;
-	int ret;
+	int ret = 0;
 
 	for_each_available_child_of_node_scoped(np, child) {
 		ret = pci_pwrctrl_power_on_device(child);
@@ -217,12 +219,14 @@ static int pci_pwrctrl_power_on_device(struct device_node *np)
 	if (!pdev)
 		return 0;
 
-	if (device_is_bound(&pdev->dev)) {
-		ret = __pci_pwrctrl_power_on_device(&pdev->dev);
-	} else {
-		/* FIXME: Use blocking wait instead of probe deferral */
-		dev_dbg(&pdev->dev, "driver is not bound\n");
-		ret = -EPROBE_DEFER;
+	scoped_guard(device, &pdev->dev) {
+		if (device_is_bound(&pdev->dev)) {
+			ret = __pci_pwrctrl_power_on_device(&pdev->dev);
+		} else {
+			/* FIXME: Use blocking wait instead of probe deferral */
+			dev_dbg(&pdev->dev, "driver is not bound\n");
+			ret = -EPROBE_DEFER;
+		}
 	}
 
 	platform_device_put(pdev);
-- 
2.47.3

