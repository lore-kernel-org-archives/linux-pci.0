Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71704766B6;
	Tue,  1 Sep 2026 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252538; cv=none; b=V/M2UJUmFt901w1bPqQLzeuA9ca2IyGqCY0iVhC+TVtMxFq/n6qw4A5UU0xZHbd5fU7XKPFoLFqiSdSu3S2I+EZb+HJQa4snuje6vpL1RmE7zNBnghrgrV+mV8D1EfL4qi4dkF7ncwyXT+YOLxQvs2f0QqyHTMWFqvp1e86qqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252538; c=relaxed/simple;
	bh=oDplWRoiwO5NuQtrHxA7ZfWcC6OR+6v2pC5fKH/TROk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MK+jOgKsT4FKFv2vmP6PD+v84paoOeDapye9Mu6Ojzc9Un8Pdb0PfbJ22B4wWpP6z5kmvqKJ/RwuwpBQF86cITrmz2pV0lwvZiBUOXTm5mmwYUraqxrYRMw7LKL/I/84KYIL0ivKOGu7NTRFu0IxKtWQvrG31vEajw6qHHlm/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1788252505te49710af
X-QQ-Originating-IP: j0zn8JV8YG2Na5F1kBXtTpcNGNwxlSCLn2r/eXAtkZE=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Sep 2026 16:48:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8002565544933552914
EX-QQ-RecipientCnt: 29
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 01 Sep 2026 16:47:57 +0800
Subject: [PATCH 4/6] dt-bindings: arm: qcom: document Radxa Dragon Q8B
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-q8b-dts-v1-4-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
In-Reply-To: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=sophon@radxa.com;
 h=from:subject:message-id; bh=oDplWRoiwO5NuQtrHxA7ZfWcC6OR+6v2pC5fKH/TROk=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFnTJjqzbZkX+ofzc+sR0R4nue1x+naVL37ekzz5Y5PLk
 T2n3dOsOkpZGMS4GGTFFFkU4hnmslfmXnsqVqoHM4eVCWQIAxenAEzEPZuR4dqe5vPLFuZ15f1Y
 8jKr6qR3rbzwn2N1fsm6ffL+IuzHpzL8r51lzRt5QdNJYD7v2i+cCjd0lZsqF878U/JHPLt5nmA
 KLwA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OYMEOeTae7mlmx+Rp0A0Ql7aIoOG6RVaU5J8cPw3jOtO2akVFB69QBW0
	wny2TQtfpO4Owh4Wko6ZNGrmv4l/MaK8pFIBrcdE1CNZMVrR6B9lhhZfLyjZg2X5Vllhg7D
	v6zw50oZK5QUGxLlAsG4WnKmdVM7UJRcH8Q6ZYS1RmjtEq8Twm9tZGkXRUWnuuTiImmhDqF
	6wevIAxqitWAZka1oj2D+MywFB834cN2Rr9G25bSfoOcd8ky0HZZfx43r9BPdv2rYiSowKl
	SXLDOCnrc5l/CzDUtiFuHUIhPD1GR+SvNWimbhZCnmdbpNWN8CKXeOe2a6reDe1sTmYiGys
	ShXbkzGivSayxu15fmzFUPHskFTwVzzKgvJ2bK6FZRV9eSwnCQ07JwS2EZXy9+POAWil8jH
	T1RetR2h3ctBvjNSEMmULsR3fMVjQjGaaaVCxFevJWPNkJLJ7+jQ2s4AAlT1I5KhO+f5zyP
	nZCDfEY0lPPc8Qr69sp/UxgggpU/amRdG0Lsf/OvVQcdaPdrXcdifO5bz772svFZ2yN4Yma
	ODyzqGz0jj/QgaRoLmRUrzzIAF5sv/4V//jV0SRZJ30SOSHHVmuZ5XcmGr0CkqYa62Ib1Mb
	z0zhV0/HXibDg0035G5sRUirjBnvWBibZICaGnysckgHHQ42fRRSiO+jwLs3lelrWewodga
	Ia6QS6E9KXXM8dHFt/Rw1UwkHe2MTI9zr/oVQx04dxw5ZZeaT55Va7KOPo0hxDs2zNvTt9j
	1wO+5pL8ziPiBzixt/aGzn0MjvOsO4ZneddFnsFgHyaae0AAndTfww4UldhtFA+JRzUcX4d
	eCoOVzbZZ2FGt2j3J3PrgCWNTEIBXwC4wzyTYDVJNKtpv6sj/6AWq4N9c5Tffk6cViVAxA+
	fiu6evohBClU6BVhH2VFP3as26TXTYd7UGjCI1O83HSXnlMJ2UVCQ4x7CQ5CuiOEvG3MoWQ
	n5l8EkJcXW2SzWrTmX3XVCg7DSjJZ7/o1uHiT0Nm5yrOkEmfc7hvGOWo1zo+F6+1tVwexqy
	huLlzQ4Q46l3fxotnddzd4LKUS1qLWqCWaQ2G15iS1XVDt4drmrk+XhBL8WW0=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
SC8280XP platform.

Document its radxa,dragon-q8b compatible.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..4341bb04f912 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -902,6 +902,7 @@ properties:
               - microsoft,blackrock
               - qcom,sc8280xp-crd
               - qcom,sc8280xp-qrd
+              - radxa,dragon-q8b
           - const: qcom,sc8280xp
 
       - items:

-- 
2.55.0

