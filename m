Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E359577E4B
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967743; cv=none; b=Q1sNNwzVjFTkp+mULd7OQ3NWpTp0faWdwB59oo6S2ppXW4iKgM/morSu1QS15IRkEL8eDll38Q/32m5aFX16AQjdAqI+jSGVUHYtQUmi/+3WLU62UrQaJWbDzhAtWZL6I5XvIIzhHJd2xbNiyMw81DEvBxSxGSlORY1OLyex5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967743; c=relaxed/simple;
	bh=rxwmwlykKE4DG9ZaXHDnH+mXKs0+O+3tZbXDTt2yJec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tzrWfXOQa9TNwLV3Y4DO7nHFN7F6b5hJcWHg97oKT3o7KB6l1uR2eM8yz3J6IDbbsbPx2kGdP7rDRt7vhryL7x4UgfmGAHoEOH+QySYSz1x2IjiGSCCWKqdX816udTtT1OfMoiHuvR+4HVV+uyzKCdtQsP4/GrJOnRIcRbdJY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=btzrYb69; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JE3MwdIu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="btzrYb69";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JE3MwdIu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689DIQc62080970
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 15:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eGpciK17+nN15e2MAbuwD5
	vU4nJ+WiK7cEvpe8rsqmk=; b=btzrYb69NGf1xr8RY7E+6J0vZwE/AOq2nhrOog
	pDnTfHSpwxEHPkyAKwMzUHnswciuMRCCZlgb/ODQjxf4CCgLi4i6nfaB2y6Ftsxc
	i79opPy4lisP6byKV0m8U3AOIN9/J5Q4jYjDulbuAKPuEE1IDSVOBIMhM1hXs3kN
	Fi1eWfno/2JRjBzQLr78bdGyranFRk7VgPZKh5j0na9Yp/Wtk7ZcG2mk30d8l6zi
	P+xPVIonfQzjAfyP+z+UkSA4vvdzgKxBIdzC8Xhsq1jhuNDa+npul9TgxEOqm5WV
	FouCbHTi4qNinUZjGYhWQWHRqMz1iQtnIFclZ6QWN9mIGKBw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r0n2a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 15:29:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936708f129aso763804985a.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788967734; x=1789572534; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eGpciK17+nN15e2MAbuwD5vU4nJ+WiK7cEvpe8rsqmk=;
        b=JE3MwdIuLiwVN++cLjkD0hFMZQglDu8JTWKFa7vd6QfYZJur/S35j28oarN9s0furM
         MGuUMpSFkLmS89njSrs3Hass5BXn87d+05i3YPOD9OYERfvpA7ejwjEmebqqGLVZ9rSL
         0C950uI4MbcBnXAWb7iwGwUfrgWJYZWtIxcWD8Esznvi1Kt8YmwRk+mD/5jH2dnmSmh2
         BOXCiF5abFN/oB7fTf+mMdzLd+qc/HmN4O7zBCwQ+5uQ1oaEh8RYNuQ4FjwjqHZYX9zm
         Od3vgs9PsVIuaM5LzI0KRE2jVf5E1566vsLnd5EgJS8fY6345sCC9gJNvqnWOMhu/HIQ
         6Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967734; x=1789572534;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eGpciK17+nN15e2MAbuwD5vU4nJ+WiK7cEvpe8rsqmk=;
        b=AV9PynofkUI/SLUdgmFkLqTc2vOKEXm6D9g6nsmbxZKpePLBwkWwjEbpkGHwfUzOTS
         GxqLlyKT7Qmz33KAK0c9lLmNDJCTeUqgIIgHExIH/mWfDf8lLF3PFhtodgcXKLs8t2PE
         TZzsJO/9g69JYCNtrnLkATUqL5+Sba/6khSui9Uv6qk98uYk4BLDmM2lUViJcLaGCBmM
         Pes2lwYFVBP3iLe5R2FZ8TUC+M9ijH03K6PmNP+VyqQhESRbhZ06xjZvQXg2uA+lSxv/
         UJkQ3tzAq9YD2YF3I6yvLEyygQkOr/WQ1st5DF0uUkFAY7+CPGyaa3KKCcGC9XV7zuDW
         XRvg==
X-Forwarded-Encrypted: i=1; AKwUvBysDbU+zKBbJcOTYCiOYJ7prJrKuwdIZHX67PXIUkHawMg+QUvwG8/HCzQBXSeR+v4EwqQ3QRY9aQo=@vger.kernel.org
X-Gm-Message-State: AFuF++kUnaXLZx4rgYxg/GjWzc+kAjkj+VdLmebIWXaPtucQ73z9TUvc
	I9FJd7ZqChxo0WhwgC8i5FF/riUQzPhDOwJ3F+CY2zXRPVPlrrZydQLIo9L4rcLnhxHR1XUu3ds
	pb2PkNY3SdMzZW7rKSMxkvde41juEkp9Dg551MydHHSKPcYpi/qNQZRovcfs4frt7JzLYJcc=
X-Gm-Gg: AYBFou01t+//xxIy4pbiA7lvVdDNTojoRuZlTZ7vnpdJR6V3Lm3GefmREaQXpz5bo3y
	CVoGZuZ9bgvIkEEYZXXJKNngVRpsm6wEEGXuFG5Dq0xdUt0Ej2C2oRpJcfiE4V4pFhl39YsgxZL
	tZXz7ZC9YUzUXVkwJNueoSkRqd3oIyfIAD2RCRLKfc6WGqaEpTIkFvt2C9fmg3A5Wkf44Lie2aY
	+RXgVXlVRFAGX3W+xvtzigcB4Nkn+Ct5PFTVxAPxh+NuyBJKW9h+TNHAWHAqVF+ytCYRTCzKOcx
	Yp0iWcwQnRa41P1HuPqnl3YU5D+q++SFNhhP5vQrN+OJ12zAsokCmHqx47/T48HXA6lso1yU4tz
	oL8p2C6VveSc2QA==
X-Received: by 2002:a05:620a:4397:b0:939:6de7:a623 with SMTP id af79cd13be357-939c9513116mr1008202085a.47.1788967734442;
        Wed, 09 Sep 2026 08:28:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4397:b0:939:6de7:a623 with SMTP id af79cd13be357-939c9513116mr1008192785a.47.1788967733903;
        Wed, 09 Sep 2026 08:28:53 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07b371afsm396304765e9.9.2026.09.09.08.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:28:53 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 17:28:29 +0200
Subject: [PATCH] PCI/pwrctrl: Power off child devices on power-on failure
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAyA4VeRnBfI1BW3Vxk71Cy6sNKWVKYgv
 rtlx+/w/zsUMZUCj2YHk58WTbHiemmAPz7OgvquhpZaR3caMK+28BIwp1UMU0TzIYyev3hj17l
 +pIFYoPbZZNLt/36+juMEvovSz2sAAAA=
X-Change-ID: 20260908-pwrtctl-power-on-rallback-5c6364b080ce
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa17b3c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=8YUH2e0Ys_Mie9xma7wA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MiBTYWx0ZWRfX7j4tDaStarW7
 dcV97Ugbe0pR2iMye5rh9IZX/15pTgupoQr8dDO8gUtDHjN3y7wkOWfIKb69TQt2ptNP8UFsuK6
 3RIWILXxqWIyYelp2hRr3RlskDqAqMRvVA7XF4Hdqwm/yV/gGt1LXG1jag6iheAYD5Iny9U9pDM
 CEFbP6/2hxgW+jkgMVLu35xYA67NWlb2+bryNiikeEjhzmkjCaXQAJHrAeQQeLyBv2UNbbROR/F
 wYvToAmR+eDFH+LMJaSy25keLY4sBC3ZWty3/jPB1rB7kweLimfC/G9msJofaZyZ+qOt4Btnkjv
 0UwbBIP5tm3jevtm5QOCNY04aupmrIkxMBUrNydEzzV+ZaKqbPnVkURkjPu6UXEtMbQ3iuchalj
 6TqTEyTyHHuJ7j14dUOePl63I5vg2no3MDdZPKYdGBIVur11frayTDFJz6Suoalc9bUZx+yxPHC
 APchWcPrk7+gG1vmtVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MiBTYWx0ZWRfX90O04lx/N8Rz
 c29W0lNctDh2fwPjK2rXrykHVNnbD8cG+jDX9gDHbzYd0bRGTWWQQC5wDvCxgPC6ve6rLcvzksU
 Wb6jfJwiX1OdE7mKtg8t6AeyQ05dQd4=
X-Proofpoint-ORIG-GUID: zSM_7-WwEZw6d9579R9r70Mll7VP_4EU
X-Proofpoint-GUID: zSM_7-WwEZw6d9579R9r70Mll7VP_4EU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090172

pci_pwrctrl_power_on_device() recursively powers on the child nodes
of a device before powering on the device itself. If powering on a
child fails (e.g. returning -EPROBE_DEFER), the function returned
immediately, leaving the sibling children that were already powered
on in the same loop iteration enabled.

Since probe deferral is a standard boot path, this leads to unbounded
regulator and clock enable increments across retries. The error path
in pci_pwrctrl_power_on_devices() only powers off the top-level
children processed before the failing one and explicitly stops at it,
so it can never clean up the siblings leaked deeper in the failed
subtree.

Power off the sibling children that were successfully powered on
before a child fails, and power off all children if the device's own
power_on() fails after its children were already enabled. Switch to a
manual child iterator so the failing node can be tracked and its
reference released in the error path.

Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 10d817aefb09..d29cd506972d 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -252,14 +252,16 @@ static int __pci_pwrctrl_power_on_device(struct device *dev)
 static int pci_pwrctrl_power_on_device(struct device_node *np)
 {
 	struct platform_device *pdev;
+	struct device_node *child;
 	int ret = 0;
 
-	for_each_available_child_of_node_scoped(np, child) {
+	for_each_available_child_of_node(np, child) {
 		ret = pci_pwrctrl_power_on_device(child);
 		if (ret)
-			return ret;
+			goto err_power_off;
 	}
 
+	child = NULL;
 	if (!pci_pwrctrl_is_required(np))
 		return 0;
 
@@ -279,6 +281,19 @@ static int pci_pwrctrl_power_on_device(struct device_node *np)
 
 	platform_device_put(pdev);
 
+	if (ret)
+		goto err_power_off;
+
+	return 0;
+
+err_power_off:
+	for_each_available_child_of_node_scoped(np, tmp) {
+		if (tmp == child)
+			break;
+		pci_pwrctrl_power_off_device(tmp);
+	}
+	of_node_put(child);
+
 	return ret;
 }
 

---
base-commit: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
change-id: 20260908-pwrtctl-power-on-rallback-5c6364b080ce

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

