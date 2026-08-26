Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A23BB690
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739659; cv=none; b=a/fbMdqlT50S4lX+Jfk9RUX9i8rmVidFM4Beq42dq0sizTaE5L6hFCXowZVeRhYPsw82/ayJx7L/SxC2KdbEMmNUj9mS7qCCxfmPwMvpihhGooc+3QZRP6PocMn/b/SkxmYTGgSmXXRhqp75MlvSmO75Ye/Fwc5VgvntTks1Dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739659; c=relaxed/simple;
	bh=VLXTtn7XT08IxyQgaQsGpfBTB1h569tUbQVdJRALfyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFQ6whiyF0/RZnKLx08SRAnonaI89BDcCisPLA7Np9+LforCQkOhKwRQAbja5ZqIT5LsKlnnGUuWT/b6SIDHcnEnvHwylP8qoKzz+RKD62JmkOogOZQzULPbvYRivobguYN235GQ8ZrWtOzXVIeKppCAAlHr9eAAkjk9ZTDrJPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cb84t/UA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tdg993Ds; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cb84t/UA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tdg993Ds"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAGfMS121450
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 10:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YakeRluq/TNMj1t5ic4SgQCt7VzKx0u/UOd
	PF2Mf+BI=; b=cb84t/UAELiftGy6ayC1tw56zz7+Tg7s6QadDwG/GTglJlsi+kM
	YCvULGysKZQsNNpT6ksaDw9RWuw/zX+40IovC1LApUv3mI8YEYuqO13wmqpcVvds
	jMJ1rI9Ay3l28Qjo5X9AApx3nDT8N71MwUd/zEzj5bqxI5o44P0ADYFuT4x4nhha
	3tn3kZke2Og2aUcRtAjEeSDSLgVPkjeA/QIRlIsUDhXz4ruJOSzuZDwaniXZWP57
	LM2x6nkT74HINmQecpzCmOOOPrxpa5AJoBpX5dKq26gAK608yMGa9oa/WhDfc7TY
	1wXjRCN5FV+G1zO6jsPb5dqu3DdjzUow4kg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx99q2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 10:20:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d7886cdso14233871cf.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787739655; x=1788344455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YakeRluq/TNMj1t5ic4SgQCt7VzKx0u/UOdPF2Mf+BI=;
        b=Tdg993Ds0p8W0nh2RMT9Wxhd/bs4UhEjlHpOu39o+vunBsBsFSfcz+Yw77Tpqk/jv/
         noRxVWvR1ndGhp9oUCmO6DuEYCoNHyOtEhvu9YPJveKJSJ5mTzfGNZKACHIItgHs6PIB
         4blB6MkeAUTHD68SF+4PwBaAaiIBcVSAcqd6Eu3aPAJffPW4/DZX4z4e77+nB3I8/mSp
         gAFlr56HBtaR3uhzyh9EkBKBW4uAi+50nlqLq8lIdANBTW+i69uTr6P8riRVPrmSIDRG
         WXWKpvdVS2lkRD5kgjCTu4UjA8PAehQUH4gUEhjdJ1w2AcK+2uan4ptCl4wUCIU3jbc5
         ZnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787739655; x=1788344455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YakeRluq/TNMj1t5ic4SgQCt7VzKx0u/UOdPF2Mf+BI=;
        b=mbZUeNy6uPvWY19KxFQG9W7dl8Y//AczmKWXq8FTe6OHpOhV0Z/zM0lpzec629ovs0
         9GW07zpMULH3l4PCeF7oqviMMZga459AOq7N8wxKSEnyzrQZIK/3rovNo6Ai5EE6IzxW
         nvVTdwkCQkrSXo1iHtyWj/hD2T/k8k3TDDr34+i1b+A2kj1vlRmf0/ukFs920EiFsyNg
         LN2NWV8VqCRNLkQ74vOqFNV5kVpOU9XIJ/iSysmbbWq7m2ZSb2wf3mtBLDwspEPjJp92
         jQxAVb3/1u8qb3KUCFZqaBTVbfKJ2/jcv/Z33rKKvVk5gLNv1/Y+/Cn27AGdV/KCWO/q
         t08Q==
X-Forwarded-Encrypted: i=1; AHgh+RpI/bstHoxSITEx30fmUNMLDCKWMqiZI3BpOy8H8S5tCb1vP4lIg6QLF7tBdAj5SJQRILq00n+U/94=@vger.kernel.org
X-Gm-Message-State: AFuF++lzp5Vwkn6UKeac9m2HiDrWV6cg+ymYulgr+glS/7K7r2PYuyHD
	7ZBwrWxR7kMZvyS+/4+Yzc6jard8wCvTn34Jy1AogvQr1ppRRgXIQDGQkbWRrTSZ7YccKbpCK+p
	3GpYNoewHvnCMwJHYbXsaXOACtSC54sJ8x5Lu+GbzI3l4F1AZijYUKxn0WoX4y8Q=
X-Gm-Gg: AR+sD10ArkZJ8FRENAtEynmXiG3Z3aCIhQwPjRZ2i8oIgEBF4z8tpkKojmlks5LXrYN
	+BYTnGDQxACQLPnshT3icPx7JRhEah2XdBgikq7HGh6FBmpdwNGeiR53pjv4rK2nZSjri+YbFQ8
	e7gn3XES80KlTEy+rQEYbcsjBTYomnXd4aK/ILB3DKHfDxWoeBSvTmL2DFFLA/dR39M4qNQx1fw
	HSpTIZ3pHhcV62UvK/slNgZWY1S5xd2QwYaEalS9VQGzlBd4UyodB0WJDFiq4iEEwNxK/qmiH3h
	vcCRnD14kDC3IqvRN04A1ob8mNIhxXwRs9BFQVUTOPlXPjKMvzHse19XBCoZL09TyT5Zij8Q5UA
	7Qyt3VPsPh4P2k/c=
X-Received: by 2002:a05:622a:4c15:b0:52c:cc14:ff63 with SMTP id d75a77b69052e-52e4239c2d5mr53841581cf.37.1787739655453;
        Wed, 26 Aug 2026 03:20:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4c15:b0:52c:cc14:ff63 with SMTP id d75a77b69052e-52e4239c2d5mr53840311cf.37.1787739654609;
        Wed, 26 Aug 2026 03:20:54 -0700 (PDT)
Received: from quoll ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5deaa8473sm4566479a12.21.2026.08.26.03.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:20:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
        James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michal Simek <michal.simek@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Linus Walleij <linusw@kernel.org>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Boris Brezillon <bbrezillon@kernel.org>, info@mocean-labs.com,
        Olof Johansson <olof@lixom.net>,
        Shree Ramamoorthy <s-ramamoorthy@ti.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, imx@lists.linux.dev,
        linux-media@vger.kernel.org, mfd@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: Drop redundant white-space around values in <>
Date: Wed, 26 Aug 2026 12:20:45 +0200
Message-ID: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11056; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=VLXTtn7XT08IxyQgaQsGpfBTB1h569tUbQVdJRALfyY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqjr38uizHhFsyaUfbShh6aV91h2LuTgXLla7J1
 iRWfu/7MTyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCao69/AAKCRDBN2bmhouD
 1//ND/9VUySGE4BflnGzefwaWJXA4iuKBkmzGwLMqN7eUXpUbSoX8iLtPrxbX+9yUzLueGyH4Xo
 epcJibxndgTnzbc2klHFJapQc2tGlzVR5FvpC1La3tDHMiqxYLIpJfOwKJZ6fK+WbzJvh4jzKLL
 dhhU1tZ2bbiPbsDE1crODu4QizlzaJK5VCmopeUHNgfmXG11v15zISMWX7nXpFJRKVbM9bLv7ii
 zN2ymvdCyRS34rWLOfhEzlse4MsoWGETeqq4mqsY+qoJn1bxtHIHskysOWKvS85nA4uP7oiXuTr
 6ZdbAxuTjE2nfdS0Fc4cHCue1oAJ2743qN6ZLilYDjsCWUFbWQLCnisqa1h2+Ax+R47myq/12aF
 dwX8qT6VQpVIBzSum/GvJ5i2NUuOasfdTEArp+7j9pDh2QNcJZ3W0Y0tGloGYcrFQ45NNWEKzdr
 FX0P6H+TNG/r09/AVrcy+5vX3n+rXdzubmZ5EWtDNdSigLS3Zt6NCZp7DTbhUBunhAHrJChToIb
 /pCy2QEk2nreFUlIcqtnzF+7VdbnzcFJMytpjCAAPhuacDmnEsfObOM7tuHZn8gzbdA7iurAmiF
 M0WmAj98vqqauR0HjMqzgpaoc9BO/aVy9sVx8UBgGD71N977fkSk9PqCIqWt1QeIggzlZWg30M0 R1M+6g3LfXeMZjA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8ebe08 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=aRM99mu1m__PA3yi2SkA:9 a=dawVfQjAaf238kedN5IG:22 a=bUPTxTJnKXFcjW2UzhXP:22
X-Proofpoint-GUID: 0sQXQsUdi9yrtZYAItbpUmedqdBLCJqg
X-Proofpoint-ORIG-GUID: 0sQXQsUdi9yrtZYAItbpUmedqdBLCJqg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4NSBTYWx0ZWRfXxCtQxGQrxBVm
 aYEEgl6pyMl8zhk+EfPJuqCAxyoSYv3vqGye44eooKVkdVXm21AzSoQwsEFGG3NelaKtEsvGv1I
 c5A0uFycdZgQpF/2hdGoA3A/evYHXToGT+ek32T8r8yWFFltVsN6IPVAkrLEXjWQuv0kstPB9SB
 zlXIdzU9EBEfF/pUjXU2gc8sE3lp6pU6MB90X1SsAOOKf4wPTnDQKE1x9ddUuJsHxj9IDhkpZJQ
 3QJCIBrrnU6qUxQHhnN/nA2nO+QlZz6Mnw8wk/sPYSn4qeVs2DRp5yKL0MU3FefXOhgZ+hPXk1L
 iRV9LClRgKAEZu9MYXPvqXPIRQMjwVdaQvKZWNP38gqPh1TdesIufcCxfSx0h+cc1u4j8snMpO2
 mfP5o+j9YR9USowKrPl2LdEvcApZ5puvOePMey9klThdjdz5jQ4H/unq0g9eWWNScCdpECRejE0
 WZBS7+vbjE0CJeIPpqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4NSBTYWx0ZWRfX2DMVDkYLPNMy
 VmCL/ugos76+8/micrBrGf6u1oLMxwAA4w+MpTtJVGRLLi//l4xQw8VKWQbxY5/yX6o9GOJnXtP
 nyv7j2ReZnOF/lG9eNMHiHFKW68IjCI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260085

Correct a few white-space issues around <>, which will be flagged by
dt-check-style.  No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Rob, Can you take it directly?
---
 .../bindings/arm/arm,coresight-cti.yaml       |  2 +-
 .../bindings/display/bridge/sil,sii9022.yaml  |  2 +-
 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml     |  4 ++--
 .../bindings/iio/light/upisemi,us5182.yaml    |  2 +-
 .../bindings/input/matrix-keymap.yaml         |  3 +--
 .../devicetree/bindings/input/ti,tca8418.yaml | 21 +++++++++----------
 .../bindings/media/nxp,imx8-jpeg.yaml         |  4 ++--
 .../devicetree/bindings/mfd/ti,tps65910.yaml  |  2 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    |  4 ++--
 .../pinctrl/sunplus,sp7021-pinctrl.yaml       |  2 +-
 .../bindings/spi/aspeed,ast2600-fmc.yaml      |  6 +++---
 .../bindings/thermal/thermal-idle.yaml        |  2 +-
 12 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
index 949444aba1f8..f4101f94241a 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
@@ -308,7 +308,7 @@ examples:
             arm,trig-in-sigs = <0 1>;
             arm,trig-in-types = <PE_DBGTRIGGER
                                  PE_PMUIRQ>;
-            arm,trig-out-sigs = <0 1 2 >;
+            arm,trig-out-sigs = <0 1 2>;
             arm,trig-out-types = <PE_EDBGREQ
                                   PE_DBGRESTART
                                   PE_CTIIRQ>;
diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
index 17ea06719b56..b869552596f4 100644
--- a/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/sil,sii9022.yaml
@@ -128,7 +128,7 @@ examples:
             cvcc12-supply = <&v1v2_hdmi>;
 
             #sound-dai-cells = <0>;
-            sil,i2s-data-lanes = < 0 1 2 >;
+            sil,i2s-data-lanes = <0 1 2>;
             clocks = <&mclk>;
             clock-names = "mclk";
 
diff --git a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
index 658ae92fa86d..edd561d9733a 100644
--- a/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
+++ b/Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
@@ -52,8 +52,8 @@ examples:
     axi_iic_0: i2c@40800000 {
       compatible = "xlnx,xps-iic-2.00.a";
       clocks = <&clkc 15>;
-      interrupts = < 1 2 >;
-      reg = < 0x40800000 0x10000 >;
+      interrupts = <1 2>;
+      reg = <0x40800000 0x10000>;
 
       #size-cells = <0>;
       #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
index dd78abe0ec8d..979d7e782290 100644
--- a/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
+++ b/Documentation/devicetree/bindings/iio/light/upisemi,us5182.yaml
@@ -69,7 +69,7 @@ examples:
         light-sensor@39 {
             compatible = "upisemi,usd5182";
             reg = <0x39>;
-            upisemi,glass-coef = < 1000 >;
+            upisemi,glass-coef = <1000>;
             upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
             upisemi,upper-dark-gain = /bits/ 8 <0x00>;
             upisemi,lower-dark-gain = /bits/ 8 <0x16>;
diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.yaml b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
index ce910e4ac823..bef8f9813535 100644
--- a/Documentation/devicetree/bindings/input/matrix-keymap.yaml
+++ b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
@@ -41,8 +41,7 @@ examples:
   - |
     keypad {
         /* ... */
-        linux,keymap = < 0x00030012
-                         0x0102003a >;
+        linux,keymap = <0x00030012 0x0102003a>;
         keypad,num-rows = <2>;
         keypad,num-columns = <8>;
     };
diff --git a/Documentation/devicetree/bindings/input/ti,tca8418.yaml b/Documentation/devicetree/bindings/input/ti,tca8418.yaml
index 624a1830d0b0..a8897c5c4d9d 100644
--- a/Documentation/devicetree/bindings/input/ti,tca8418.yaml
+++ b/Documentation/devicetree/bindings/input/ti,tca8418.yaml
@@ -46,16 +46,15 @@ examples:
             interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
             keypad,num-rows = <4>;
             keypad,num-columns = <4>;
-            linux,keymap = < MATRIX_KEY(0x00, 0x01, BTN_0)
-                             MATRIX_KEY(0x00, 0x00, BTN_1)
-                             MATRIX_KEY(0x01, 0x01, BTN_2)
-                             MATRIX_KEY(0x01, 0x00, BTN_3)
-                             MATRIX_KEY(0x02, 0x00, BTN_4)
-                             MATRIX_KEY(0x00, 0x03, BTN_5)
-                             MATRIX_KEY(0x00, 0x02, BTN_6)
-                             MATRIX_KEY(0x01, 0x03, BTN_7)
-                             MATRIX_KEY(0x01, 0x02, BTN_8)
-                             MATRIX_KEY(0x02, 0x02, BTN_9)
-            >;
+            linux,keymap = <MATRIX_KEY(0x00, 0x01, BTN_0)
+                            MATRIX_KEY(0x00, 0x00, BTN_1)
+                            MATRIX_KEY(0x01, 0x01, BTN_2)
+                            MATRIX_KEY(0x01, 0x00, BTN_3)
+                            MATRIX_KEY(0x02, 0x00, BTN_4)
+                            MATRIX_KEY(0x00, 0x03, BTN_5)
+                            MATRIX_KEY(0x00, 0x02, BTN_6)
+                            MATRIX_KEY(0x01, 0x03, BTN_7)
+                            MATRIX_KEY(0x01, 0x02, BTN_8)
+                            MATRIX_KEY(0x02, 0x02, BTN_9)>;
         };
     };
diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 6ba668aa633d..4727dd7040a8 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -95,7 +95,7 @@ examples:
 
     jpegdec: jpegdec@58400000 {
         compatible = "nxp,imx8qxp-jpgdec";
-        reg = <0x58400000 0x00050000 >;
+        reg = <0x58400000 0x00050000>;
         clocks = <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
                  <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
         interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
@@ -111,7 +111,7 @@ examples:
 
     jpegenc: jpegenc@58450000 {
         compatible = "nxp,imx8qm-jpgenc", "nxp,imx8qxp-jpgenc";
-        reg = <0x58450000 0x00050000 >;
+        reg = <0x58450000 0x00050000>;
         clocks = <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
                  <&img_jpeg__lpcg IMX_LPCG_CLK_4>;
         interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
index f1a76f88fc0c..f285e8cb29fb 100644
--- a/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
@@ -208,7 +208,7 @@ examples:
             compatible = "ti,tps65910";
             reg = <0x2d>;
             interrupt-parent = <&intc>;
-            interrupts = < 0 118 0x04 >;
+            interrupts = <0 118 0x04>;
 
             #gpio-cells = <2>;
             gpio-controller;
diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
index e863519f3161..b6801057e31e 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
@@ -160,7 +160,7 @@ examples:
               reg = <0x2800 0 0 0 0>;
               compatible = "pciclass,0604";
               device_type = "pci";
-              reset-gpios = <&gpio27 4 0 >;
+              reset-gpios = <&gpio27 4 0>;
               #address-cells = <3>;
               #size-cells = <2>;
               ranges;
@@ -170,7 +170,7 @@ examples:
               reg = <0x03800 0 0 0 0>;
               compatible = "pciclass,0604";
               device_type = "pci";
-              reset-gpios = <&gpio25 2 0 >;
+              reset-gpios = <&gpio25 2 0>;
               #address-cells = <3>;
               #size-cells = <2>;
               ranges;
diff --git a/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
index 94b868c7ceb1..0084350ec579 100644
--- a/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
@@ -339,7 +339,7 @@ examples:
         sdcard-pins {
             function = "SD_CARD";
             groups = "SD_CARD";
-            sunplus,pins = < SPPCTL_IOPAD(91, SPPCTL_PCTL_G_GPIO, 0, 0) >;
+            sunplus,pins = <SPPCTL_IOPAD(91, SPPCTL_PCTL_G_GPIO, 0, 0)>;
         };
 
         hdmi_A_tx1-pins {
diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
index 80e542624cc6..ad830aebb798 100644
--- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -62,21 +62,21 @@ examples:
         interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 
         flash@0 {
-            reg = < 0 >;
+            reg = <0>;
             compatible = "jedec,spi-nor";
             spi-max-frequency = <50000000>;
             spi-rx-bus-width = <2>;
         };
 
         flash@1 {
-            reg = < 1 >;
+            reg = <1>;
             compatible = "jedec,spi-nor";
             spi-max-frequency = <50000000>;
             spi-rx-bus-width = <2>;
         };
 
         flash@2 {
-            reg = < 2 >;
+            reg = <2>;
             compatible = "jedec,spi-nor";
             spi-max-frequency = <50000000>;
             spi-rx-bus-width = <2>;
diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
index 1b77d542a7b8..6b4b16580adf 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
@@ -137,7 +137,7 @@ examples:
                 cooling-maps {
                     map0 {
                         trip = <&cpu_alert1>;
-                        cooling-device = <&cpu_b0_therm 0 15 >,
+                        cooling-device = <&cpu_b0_therm 0 15>,
                                          <&cpu_b1_therm 0 15>;
                     };
 
-- 
2.53.0

