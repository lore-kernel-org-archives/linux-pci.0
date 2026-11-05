Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873760;
	b=p3RspaeM4GvbsqC0PhOw4NyvLKHjVaDYHsn2YFqfTGbh6hcQCjEqRZkS7bPEjHxjKWmT
	 J2PiWR7FAn4lQlSyhgfOeZ+QZhz1hb4Z0KtcqpGeaX5yctwgkl4qF3SM0F1KDe9sKLpTW
	 D+d92j6RJO0XJC8HCwF4k3tlTObvl1/i6AFhDLFVJgX66r8LZSfecN4uQjzOtcfcyge+t
	 +SdsO00p7NU56kFLZe74I5nsiJMjyNGJcC39FVv9vOwN51HZ7WN2BR2RGCkMCDK9x44NW
	 LlDbc5D+FQXeM69TdDDdkJOzpM9qxrXkB3/BlzpUo7ApfZnPzoQUYlhRcn495mgH6Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873760;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Du4ZHb0WNED8SK9t896iiYWnwaWFQnoc2q9fvg9+ork=;
	b=DmDOepMJ4Rj+EF+fldKnMCnSCs/tQfk73eKjJFE8AG7/p0GJ2eO+eoHSgJK2tvyqExnH
	 vTIaDBubJSmLbQPgMIpxYdipzcT/hXWK2u6rs6L5jgRHuArHqA2mpGNe5N9WTrYGoeyJ2
	 tJh16GTtd6iOKGW8U2b28HnAxZt/xcnwspX8yiFJO70A+rtoTjaOE/Y9N5CWQUwXaK9rf
	 TJizIe1k5gmAKl73J9mYsyvRWTEhphB2ECoGXfMthsf5EYOnzqtVYiaBtwXWAGhTf0C4M
	 f2roai01fKGJS0M1zTDlDjIoQkBdh/dQac9WHiDoUFFIicTBl1R0bEZalQ2OldeElwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IMReMmE9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SUcZgWkg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0DD606A32F
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 10:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F0DD606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IMReMmE9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SUcZgWkg
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tQhT433390
	for <linux-pci@vger.kernel.org>; Thu, 5 Nov 2026 10:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Du4ZHb0WNED8SK9t896iiYWnwaWFQnoc2q9
	fvg9+ork=; b=IMReMmE9YwT0NbY2NpYhYrw4BX7aFXtdbaCFMsCCyPXzAY6Bces
	9vMWiLYdYn4vh/mNvIwBJqKI0qTVXB1JMSR2CCLjnHmcCM13xYSi8IzLE2K75ZGA
	M+mf2UKfwiYYG3W3eXpU78w52bNM6ykaS1w46UGEjW+iQ/CR4inCgdB6XHjLnnAA
	vS80EAGYrytOiwUwF2TFpHGEeenXgS2GRiC1JA1JlzDmBRtNXj7lS6ug1yqFORwn
	uFbOsXC/z6ZIpZIQoAX/GcftvXMLQen99/4ahos0hcCnXqPuY5+qc5ihM32i8zdc
	88OTq42pQJZWMsH1e4Hoo0RCa1O5az1pfMQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd8xqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 10:15:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd6969473a4so1063732a12.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 02:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793873758; x=1794478558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Du4ZHb0WNED8SK9t896iiYWnwaWFQnoc2q9fvg9+ork=;
        b=SUcZgWkgyx3CAdh83tx8kQAf5Zd/7WHKxn/h7qUfJnIBAgMkBfZSKrSwRZfjjm4RXB
         8BTg7NE8y1EmRBEr3UjFW++kjZIuGINBKiEWthBKMYtSb/cwMWdpDF9ooJcdmk9KZPZc
         ideZQZjvxeTFleUoY72b3EuCOLDTVcK4Z9eLVNrlXiwrqvQVqf+NIKrhXH4trAxEfQvK
         9QKaNkz60so7IIQi95SQgr2XbbQHIEbMDQJT5kLo3zu3AB3mpbr2ELO8hfmMj8IEtLnN
         hQrO9KjVb9PwlQMltZ/lQsVbdT05ZyhPMjSvDye9k7CzabeCVZjqodmi1N50EzxDvB+d
         TgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873758; x=1794478558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Du4ZHb0WNED8SK9t896iiYWnwaWFQnoc2q9fvg9+ork=;
        b=uwk1DwRePO0TK3J6N49/U2d+2lhhFul/X7qT7xkXqmiG5sAr+Y1FLaa1CKzEtLSoqV
         coo/BHITNtIFg3JqLZN++7VoWIf6i4XR8beHt43/GmwtceHWXRBei9M3xV+em3vvwoH8
         fuNbrmZdVBCMtFmR3iAtGKrVlsofsTYwtyLR9An8yaLvd97EQD2uluMkNfUskFx/jDH2
         qPq2RZJVZta50f0xBHXEuWYqBUf6Uj1jDI2JUWu+MDYBsiUv7sSNvjUrZ/mGLFriesiN
         HKCgkAD+arEQxwShq6VU5ZPT8rKPiRnb+UIBczs5OXo0fmFhDaMolUjSKun/hfmvhUYJ
         YixQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2APZmWi2vfUZxwyb4NUu+XjsPz5aT0z9MNZKHFdKL4zipd57OjOD5+q7Epolxo6RxDyWnblGCSKI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m48tuGleY7UVKp75kPLwujdNCNIJDwP/eRoErDizyI4vrs9ug
	/BgIcrW9qV0vg2J0r0u5Cg2z/qkkdEw+KzSG9VambSYLgcI+jlexIvNoFSUpcZRnVIYxJeV3YX2
	OQKhwe2LMxLDAgJyCWxXAI+XYZI9tEAsUQgCKkUMGJGyH5eAQaAu/PGkKKGDEdZ4=
X-Gm-Gg: AYBFou2CtZDCTdk/XTfDXjY+dA8gZEMNpwjIkjFhMcauwbzd0RQlV/xT6h6qOxzWDhO
	5zfuZ2UuW1fl1P4U/Mx4F+/EnWcZlKdXQwxlbyYa/dvDxmZ90eB6wV7PUbMiXaho7XGT/cn1CFz
	ePUnKbjk1e87fdkz03vtu2wRPiR078nnqX9hTypkqyMxBMLu6qoVKUMS1bf5qVvpeAZvpK1+nY3
	zz8MGqufVP+9cGy8n9k8nf08PMYS+naojn+AxQuGiGXKNNj5pKJ54QAuZaLaoBpeR9Kk2qXlBkH
	n2O7J5bi+3Q6n8aNycm2PXQEhF4JlR1LCrqzxjAYtw8Q1BrKrCOu1mgChO3WjT6DcBVWxDLdJIb
	z6U6Ut4tEbwL4Wh7Mfvji0/xStioq/sOajmhz7UpOV66XT1A5OPo6CdsWUGtK7sfmU2dShUvM7q
	82JvUuPMQiUXw=
X-Received: by 2002:a17:90b:5243:b0:3ad:3e8:12 with SMTP id 98e67ed59e1d1-3ae89806353mr13699090a91.48.1793873757957;
        Thu, 05 Nov 2026 02:15:57 -0800 (PST)
X-Received: by 2002:a17:90b:5243:b0:3ad:3e8:12 with SMTP id 98e67ed59e1d1-3ae89806353mr13699063a91.48.1793873757320;
        Thu, 05 Nov 2026 02:15:57 -0800 (PST)
Received: from QCOM-yK68p0sug9.qualcomm.com ([183.160.126.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b099189fb6sm4027532a91.2.2026.11.05.02.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:15:56 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
To: mani@kernel.org, linux-pci@vger.kernel.org
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, krishna.chundru@oss.qualcomm.com,
        bartosz.golaszewski@oss.qualcomm.com, deepti.jaggi@oss.qualcomm.com,
        yadu.mg@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Subject: [PATCH] PCI: qcom: Power on pwrctrl devices for firmware-managed hosts
Date: Thu,  5 Nov 2026 18:15:21 +0800
Message-ID: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec575e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=cl6WQ9rKrKu23RIucH9P8w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=CABk0tZIDWUp0Uuloh0A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: iMLu4jt4dL8lk1oTZwZitsol61itfgi-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfXwoNdqlHVaeZ/
 HzmmER4rtuV7B9lY6pW3eZmwGKls9GS1WHgnrtQRF/DoDwpVSr4tKEU+6naKn5jEGzdPhflZ1iQ
 fLFHbXjU5D8AOunhX4Mra/i5ymOyCJE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MCBTYWx0ZWRfX4jmbYr/LLgym
 omC9aCyLl481oOfWk/1nLLqpEeSGFtHiGB3Js6VW2qSQiTgtRltJ+mRjDrYRRCiFZrIkGBc/W2h
 bd/Ep88xUnCu9MAhXuyaiEx/XRgW7X5Wi7b8Ona1a+TJV2KpTenkgaXdoWvIMekDOveTUiHxewF
 Lpl9qmbWpKDWkp+7/ghkiHPPL6N+eNyyPCstlYiOWs2vpPQ3GnUzHQ89lshSd/JQDLDraMdI/kC
 miLOU1CN0s9yJC8hTgEAX6nDsABqtJ5YIKpAptt57DfKyujY3Ltld2TcU5cwn08O5JVa3hK46tz
 urN/Ixf1oKMc3awMUmeptGRu47Urn6LzU5w7GTkrcgJqEdDy8GntUDmmNIoU+L+yTxGbRmn+cn+
 oycY749CMBOkp7Qa13Ym5RCqjyokjMaFw3/NvWV3NS4Wm2LWgTWkEnrTqZGVq8qF5Sge7jTYfdg
 ClPTzj/9ZoqlVvthwuA==
X-Proofpoint-ORIG-GUID: iMLu4jt4dL8lk1oTZwZitsol61itfgi-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050040

commit b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power
on/off, destroy APIs") switched PCI pwrctrl users to explicit create and
power control APIs, but only added the calls to the regular DesignWare
host initialization path.

Firmware-managed hosts bypass that path and probe the ECAM host bridge
directly. Endpoints already powered by firmware, such as NVMe devices,
remain discoverable. Endpoints that rely on Linux pwrctrl and pwrseq,
such as WCN7850, remain powered off and cannot be discovered.

Create and power on pwrctrl devices before probing the host bridge, and
release them on errors.

Fixes: b921aa3f8deca ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0d56051b5de3..7313acd7e480 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2308,11 +2308,27 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		bridge->ops = (struct pci_ops *)&pci_qcom_ecam_ops.pci_ops;
 		bridge->msi_domain = true;
 
+		ret = pci_pwrctrl_create_devices(dev);
+		if (ret)
+			goto err_fw_pwrctrl_destroy;
+
+		ret = pci_pwrctrl_power_on_devices(dev);
+		if (ret)
+			goto err_fw_pwrctrl_destroy;
+
 		ret = pci_host_probe(bridge);
 		if (ret)
-			goto err_pm_runtime_put;
+			goto err_fw_pwrctrl_power_off;
 
 		return 0;
+
+err_fw_pwrctrl_power_off:
+		pci_pwrctrl_power_off_devices(dev);
+err_fw_pwrctrl_destroy:
+		if (ret != -EPROBE_DEFER)
+			pci_pwrctrl_destroy_devices(dev);
+
+		goto err_pm_runtime_put;
 	}
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-- 
2.43.0

