Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A57339381
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258520; cv=none; b=BRO+Xm2LXhjvqAWYL1zSTz+j221DVd8JgPSPpzJSkZvIa3RlsivG9V/Fh34mVOIYWTCf8T6uyMjfaVLpe9NWfHnkkiSGwlLqa2qoygSLRZ0ci8++h4mU8W6wPCmfIrdfJ7HzraQ2peH9TrRcX304rAebjQAbTMegWV3Jd+QrFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258520; c=relaxed/simple;
	bh=WDv2cWqcgerf4rOLuZ3a1betGI8bkPDTNfMkI3Fnsfc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BzDE/y8DI3hJdHImBcIWWjAkZBM6UsV2elxJX2WlyLDXhq+LozNuFFmC86KIbR+CWofG9FHOzzbKZ/NZaCZtCK8sDHwc3Gktf7CjdM0OyX79DggLFD5SzaAn2sTNhbdyeNrQoXNtcmd6sxFUCKAzvsViXa4SlbCqZiGidpwMJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N0KBxcKn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwRoxrZo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N0KBxcKn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwRoxrZo"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJqFZ2494780
	for <linux-pci@vger.kernel.org>; Tue, 1 Sep 2026 10:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m8I06tVkhhPeVDAEZ23gzs
	kzzd1BaHp+2JxbIuHKZcA=; b=N0KBxcKnNAFWiyqhOxG5ZPRY4YkvBLccWROwan
	ylRMZxOqBObYvOidrLIeVbW715Mo+zznjWUi00M1DAiFoj8Vw5s+i0YLudlGNpOF
	/yMZNKyNRDj3IsPkkEoaj5QqxWnKhRfl58JqHrZmGklBYowAC0ZDLnnYdwYYhWkJ
	UtdgnZhdGiHZ+lYMVYU5vRyUX7wmRNUiadhgwtIluHFdk2KdaCZBBgBLbPx6HXQ6
	wnd3jnsB9/izICWtfO4evQW602XEXQaBjvVD22t74+HEunSbRkRSSEWM/IpwgntU
	1cD/W9HxCOZlJqIj+MO+8nRAaIZEEstsIOjgA7bJjERNP2ZQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh1jb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 10:28:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93909014c85so734122585a.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Sep 2026 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788258517; x=1788863317; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m8I06tVkhhPeVDAEZ23gzskzzd1BaHp+2JxbIuHKZcA=;
        b=ZwRoxrZoTN/21fD1kI1eHlyGXx04vlOrSYeKiyYhToqW3u5M0tme9JquwrAOMlCptu
         hzdfKJF0J9P8J641DhIndyLpREWiBEGEZvwyer38iT33JykoMZvl1vsGdGfOCWiHRjKY
         3W3j+MwTzLIaQQfRP13YD2MXb/wbjO/vRbXcisg9VhL7w32ZHqvO3VxIRUeyiHhzE31X
         faJifxzJneRPrCmvVTYxKwF6pm0kR0ZHHhnJ3F3OrZBiavVGLsymUUkdSwrlJAf/RE0k
         jIbIt9MeZbuWu7okXX/hhq3rIcc9Hb6fzP/Q2yqbNkuQWBGo0AufnfkMgzWvPCzsqDmG
         sb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258517; x=1788863317;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m8I06tVkhhPeVDAEZ23gzskzzd1BaHp+2JxbIuHKZcA=;
        b=qEYvqB220nwRk01qyUmbbusoP+eLLOHXQBZLANkBfHinZJkhH0Kr7wJq+ICDK6DbLL
         mnr9043Fd2+4ukmKHVY2yxTXO2rtqn3YsydzFo6OECWuyndDqFdKpv9jyQ/Pw7Jbmaql
         MhkabhU7s4049GmTYeOMlK9w8BFSwJhua4FbizATBtuWqoEP94yndXaRkdbSXdlU2TZR
         KJLDZeBsF4ZAJmSf3kM9cZAPsk1tHtUcv+67HmOerA1Ty/LNN7M8pxF1Gn33V8hVSzE9
         QHkcwYeWGIl9S3K/tIxjDdbKp6wblW9i5rKTa47qhmIjI1siK4C4XSaFNEgiQPN4wOjG
         NyrA==
X-Gm-Message-State: AFuF++m4NV5fy/ChaNudCn7BIjZ0n4nG9spSyB2a76Eu0OrqcxbdKoSE
	EzzM/g57yMjPck4X+JKUyKaNDaPtBkr3SB5ZBsPE2+ATX2JMzAMQeOp2R6ySnmJ/QZcnKnB7Avn
	FRTOkDh5WToOa9zYiyQ6gnAm6DlAe1YPiNNsTnPbpTFtrM11gwLWEqFW5r5K5kqY=
X-Gm-Gg: AR+sD12mDHE2Fiy0bSN4HQLClazyIncKpCVsyvZysfLVQyRjH1Kq705bNs+21K9JtUL
	yxjqnCRNwZxNkA5VHsiIycPPBuIUQ4oA0xhHXG3D2xE5ZbXZL1Y/gTdSllbjR1atJnJbXBgeNzX
	y4eeihFN3RSuOvtdHc7Xwt9KzaZuD9B1F8aJo/z7iojBMVil71XL8Wrz4JnXCb0Qi7xMxKusnpX
	2TNoPQFVU3HWiUD3B/5WDhI0nWi3eYyZay/dY6skmZfSik2BwSqcaqMzVCpLeb83TOosHcO8w4e
	kAN+ye9gKLSM20MOJNhMFfE9u/XEBHSRMgOQLOKlzg1LMUClqU0hVZuHUPpdsZG4jA+c53QVSKy
	L/rI3VmLrwRuPzg==
X-Received: by 2002:a05:620a:4104:b0:938:fd23:1e29 with SMTP id af79cd13be357-93947f3f7d8mr920981285a.4.1788258517122;
        Tue, 01 Sep 2026 03:28:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4104:b0:938:fd23:1e29 with SMTP id af79cd13be357-93947f3f7d8mr920975185a.4.1788258516644;
        Tue, 01 Sep 2026 03:28:36 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccea87e1asm188966895e9.2.2026.09.01.03.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:28:35 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH 0/5] PCI/pwrctrl: tc9563: introduce support for embedded
 GPIO controller
Date: Tue, 01 Sep 2026 12:27:52 +0200
Message-Id: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2ND3YLkTN2SZEtTM2PdxNIKXTOzRCPLFBNjizQzAyWgpoKi1LTMCrC
 B0bG1tQBIMXY1YAAAAA==
X-Change-ID: 20260731-pci-tc9563-aux-66a29d438f60
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfX1g+/lbhoEN1o
 iGaH1XCWryvmDtIgHSzWIpPOEv3E6agnkVxqTyPDUW3zUR9IcvltH4yRI/SGl+hkvUNkyF4L+7p
 dRKFkEq7JGpEN8S97Dd0I35iro1yH6I=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a96a8d5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=DaOxmBnbJEZ67lbDJzMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _3xsKTJgZrPmWX2WP3QPqB8be_UnIC5C
X-Proofpoint-ORIG-GUID: _3xsKTJgZrPmWX2WP3QPqB8be_UnIC5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfXzCYHAiAaa02x
 /2fR6AvZzr6faBNlXF52IKZ4SLS9zzQWq3EmFuZmQiDk56y14fwdbu9dwTH7MSqgJkaHMwLadfu
 WlXzDHXWG66Ov+Voz7pQAILqN2WEesf+tIBIqhWDuswEK0aSjZBF79yJKg6qdxqA8E8lQ1nYVZi
 dc8Mk8MPtI/fex/WLj/nkcjkTFkFe70wE9JVQfahDGVsZO8iIKPi1iqeXW/81zbzubQPaHYGG+7
 Hni74I+D5RKtt9pDd9UCzAdQ/Wht/eEg4kGVvxq9PdKFId0+WZufs0oktMupPm2NSIm3phHvW0E
 qkg7gchPYWSh3pysMMeAkGiR47Xf6M7Xfe+SnMNe+jYMIvzKQHFM5ukW8ELZNDg4A3e4+P1Evb0
 ZBUTfr27AhxJCVw7ShKbF0dsrwZL2OEKNKQOgHDUPpa5rSHXJEEOuutpoGCBRZfkHZo67/6DI93
 6SBM8G8jmUpCTTkI3xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010091

This series is based on pwrctrl upstream branch.

---
Alex Elder (1):
      gpio: tc9563: add support for the embedded GPIO controller

Lorenzo Bianconi (4):
      dt-bindings: PCI: toshiba,tc9563: document embedded GPIO controller
      PCI/pwrctrl: tc9563: add GPIO auxiliary device support
      PCI/pwrctrl: tc9563: switch per-port reset to GPIO descriptor API
      arm64: dts: qcom: qcs6490-rb3gen2: enable TC9563 embedded GPIO controller

 .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  31 ++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   7 +
 drivers/gpio/Kconfig                               |   9 ++
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-tc9563.c                         |  99 +++++++++++++
 drivers/pci/pwrctrl/Kconfig                        |   2 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 163 +++++++++++++++++++--
 include/linux/soc/qcom/tc9563.h                    |  19 +++
 8 files changed, 316 insertions(+), 15 deletions(-)
---
base-commit: 550ecdbab0f51174202e7f9f6557673090bcd5eb
change-id: 20260731-pci-tc9563-aux-66a29d438f60

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

