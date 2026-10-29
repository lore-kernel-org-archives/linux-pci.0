Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267124;
	b=XLlShWJjtX6NsmH0IADT8zT3Lq4fNvJ3xdbtczC7+mA/rA9kt0t2vJYg9V/84VSvHmug
	 4buoERGk76uez+CQbPomCpxXtGLjTKjyhpPheZ+J7yDkiV9ccSFd4GdSjNz6bSilVZHaG
	 Kfy9aZNZtiIOmYgFemjivh4r1o13TcL4R1Ytq5BMtRVoJGcSr82xgP0VtFuLmdNdxe/+l
	 vLHOi+UYcjH75ZQDHBUwcg3wx7SRH2QFHqSwHmkwXYkGG+IyL82neDx/m4NBuoqbC9lKW
	 HEUGoTEH/9mWqHQw2ZQPqmY+1DPlfILriZqTVameMsqVMC5u29rD/c61oTwJJ3aHzbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267124;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=ZTQjA8zljN1ZEB/RMOcOmcshPHsNIzGWEobToCZYhQU=;
	b=mklkisZj6A+o/3rhT6tprIH9O2KovP1vsYDikZtWqL2I7DK/Xw9fLbIKq+gCsT4M0Pr3
	 F4zkiER7WQOS/uC7/xD14xuuYJw76nJB9qegudu6CHFdbyotI5ZwAI7YzWipvBXcaYJem
	 E0uYcJ7wZ8OEll0mI1x0Z3q/aFKd88uq1R+1VMETk3+xLTBrJquL0hxH6B2FFWKMTstku
	 Za7coRSqF/v+OSoz+MzU4w1mSgARqWFNk3Dz0YcXO6RPHIIixwVwtDnWhRd7bdac7ZJb+
	 APg8ingfq87K8OawJ8VDuQoj1CPxPzEWoCwKZLAWt62ngb0c6lsamFx4/WknsLT1sPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0070606A31A;
	Thu, 29 Oct 2026 09:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0070606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip4t1793267095te2ba335f
X-QQ-Originating-IP: aizOpLrqBFRuyE4N0lIdY8t7yRxMvqkbkK0qIj00TuM=
Received: from [192.168.30.244] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Oct 2026 17:44:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6592915629139523209
EX-QQ-RecipientCnt: 31
From: Xilin Wu <sophon@radxa.com>
Date: Thu, 29 Oct 2026 17:44:31 +0800
Subject: [PATCH v3 4/4] firmware: qcom: scm: Allow QSEECOM for Radxa Dragon
 Q8B
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
Message-Id: <20261029-q8b-dts-v3-4-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
In-Reply-To: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 dragon@radxa.com, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=sophon@radxa.com;
 h=from:subject:message-id; bh=ha+6AXBZg8vPgpy9CUy+X6vPtWkIMSbkDFJ7rZDLj7g=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFmPRRs9e4W1fVibBPcf2HZ7o4PjX7X36VLhsrrr7EXvd
 PfLRl7oKGVhEONikBVTZFGIZ5jLXpl77alYqR7MHFYmkCEMXJwCMJEP1xj+h+Rwr3dJdZ9+Zcei
 e7LL1Df4nWiWsWG0e63+5APD8oWPnzMy/JdOK/Lb/zaddSfLS43Umpyfp/Q2++wPmiT+8/XFSws
 28gIA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N4KH/PyO63QvlfhRmHW3lhlC9Y80d5G39Z3Mt8h3O/31GMfKRCJZs+61
	SdZIejoFles1DXpH5CTegOaoefX2YkUCnli5tWmDyq/apdg+CYivKpE6PKp//QBl7925HM4
	+AH2JUIvwMkcCNW4OBryB9hIxpOj6IbbeY4DVH9MVKAU8skd3jrE69IE9R8xscT/J46wn58
	ZAdflBGU8Ra2oo+TX77EiR6GcjwKIyevWZh/g4qAGa9gvI6Pnp2Lrm76/4kH6eubOtcjUYW
	uu8tECu15hUNdir8dQqvE/vUANsscluMO1KQhOzKe667MsEU/ocoscqr81eL+mkVd3snvnA
	IQPy9NQMWzShWSRl61h5plHuVJfc6ek/7CezDbg53cMWVNmMyHt+g7Nzsc9Hzh0aCDYqOE/
	QtkESDqq5VY76a5kEQYJ3fuHsWKnLz8FNM4bgMwboDXNWrTrPGVxhwT0lsQ6BYe4zfqo6Cz
	ZyMaWfPe+iKo4YFI/lMYKIVlLHgIzCQJ1jQ87tMHhqPtUokQ5Vba9mNqqEhEoM4FGhY6uf7
	Ox5YfnlhPnjmm48ZryVPuwvGI5FbIp+iYne8KxBiOFvSlG2SW4qg59cf/t6t97t3Qr8LuTY
	2qa2mEv8Aq7xbvOFBuJVI/jGBnXP2LbHkfpSbrxKE5BVJI5we1dAogN9E2l918eBGp/odVs
	rjnrrmnZ14G09Y6eLP7QBecHo9eYdHo/uFTt96piaY+8uHqZLGc1e0yzl6sxP5om0EJPvhG
	SpuZMAjk2k6HIb8d3Xmc0x2r+D6tTbc6pQZcTQqLviiG2s2sWurcvpk7QyzlTfLVHDdYJxL
	kuRqZnf4IUMlaIi4HzUnmutDF1ydfUwHZD6r/bunK3m7InOMiWbQV76eFwTTBQQGyvZiK1o
	VpJP8LNTl+B2FfF/SIiFvz2zAliC2uNld7l78gtrW59VGSVyUc2riK58ZJPaoQ6bLFFOcdt
	fLL2U70QmWRuIeeqwHc3cz4RZWHJPWjb11aAtuspA/rfGcRSMUlxQ7tPBLsUxUGkL1sFdZB
	rk5ISAK7Ex/djA6T39Vt0NmwY5oj0+T5oMPkEoqLGpm3PdRFtopMT1fuC0ik81F+luLbAO4
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Add Radxa Dragon Q8B to the QSEECOM allowlist for enabling access to
efivars and uefi bootloader.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 43e250faea75..0cb6f8e3a5d3 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2266,6 +2266,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "qcom,x1e80100-crd" },
 	{ .compatible = "qcom,x1e80100-qcp" },
 	{ .compatible = "qcom,x1p42100-crd" },
+	{ .compatible = "radxa,dragon-q8b" },
 	{ }
 };
 

-- 
2.56.0

