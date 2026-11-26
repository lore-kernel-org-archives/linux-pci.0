Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719644;
	b=4TahLPhq/8+Hj4II1b86MknemXd/0Cm/doZWOvmnHJl42GEBmLNS4H+i5OpYNuM2Dy/2
	 Rt7Lx8DyJJQV7PHXE8Fh3vYGVtPVp7wR4DVGcJ5uzmCuq84jOFlS0XOYI49NPTNYQEKVx
	 M1RCRXSzZby5Drw5KgMsSYA53L7AfGVMoEQ69D7To73szaj8mVOqzUChcuwNsW+DZivzL
	 4Oly3QI/jaC8Mbd4xtAPZ7YaPx6eXM/9GthAGZKPAq/i1T863h1wuDVH8mEbTg7DfR7Ct
	 G6V1sjJKOpeGoHXMzFqnu7tZAYwrf4LjWVX/KhYbRCSBZIWVTrazYd1YNP1Qv/cTcfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719644;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hvrwhli92ejef29utqXfTUqutjxeG4jEb3yA0cFFYgg=;
	b=mguVgAGIzLGaj3ywXiGHUNCYezMuff5Cq+vubb1+KHIY8ZXiXafnrXlRnYeigk4jd6FE
	 tbUHsCFMYT90rFZyZiX68zD0mdoitXSxbs2HXjFPaB0SJxSMChyR4AnlRHcida4FADAE2
	 dX1BGdDiStEnkXBzM/g98TUG+ysZvyYTNfRm1k8tVD7dosHdgDFRz72m7hjBe4gj9T1mh
	 Zf1gU5//E8HJplmMzrx8PVixx2FTPo9PMijoj4nzZ/oKJ0+WWeJ2ZkJN73zc+DtCnHc63
	 1QOYQ2gLLpXPXZtzm0hCj6tA8cdScUCH/7q3bV0sb8fyR8wTXB6YR5hQjgTdg+xvKbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jw0solnT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Czdx1CmR;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B6606A337
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 917B6606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jw0solnT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Czdx1CmR
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQFtwAJ4048190
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hvrwhli92ejef29utqXfTUqutjxeG4jEb3yA0cFFYgg=; b=Jw0solnT9tHTJG48
	ebAXfqFbT21zSh21dXuPa6qRGXWuVgCQtUvHbEoY36XHk7PzdwzB2lAWD26Tol/+
	W/YQEwXa/v6TurRAyTh5LQzIVBtOWPw11bfzQLf58HIzH5zwAAtVqbujbsVu/FVv
	1TF8QUQBjkVaiB5bjvyzgBTOrTi6EXPODeFDwvhSWvoM6srvPeDhYuo0TfDD8De6
	+huDY3Dt6ZP/ex5s3sminFpI8/HsGpUxhn08L9kNZTmk35NxzdLYM1OFczCKNH9A
	CttlR/S1Svd6Y2YnejfSdWkm4pDk7cLHjKZJYhI3TBoJt3GfqJGRydQp6iKQAw5y
	YbvhLA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6f8rjmc9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 19:00:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b25d977b91so7776825c88.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 11:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795719631; x=1796324431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvrwhli92ejef29utqXfTUqutjxeG4jEb3yA0cFFYgg=;
        b=Czdx1CmRbWri4oJ+TnaysS+SSAeCNiyDP2jS2NmG5uq1DyNwqAEgvWS72O6o0ouBlL
         GQrvsT8Tb7n+58lQmcA3iIm7Fj11Tvs8AYP1soXU0yTppAi7L9SMQ9I1c3319yHghKWt
         vX8ljRkhdkJ0vLlAVXyuz5RPZh0LnV9zUT4nrHdNIIOmULCl/2vrLsltS3qgJfOmkKnh
         ma5NCySIcjVFAE6i3jG/kq18EN0lH/O8ARm/dl76uKwONeZIouhjpNA1BBOb0CD06+wD
         wOgCqzqGtP/MN4Q4m3qFG6rkTQ1HOZyDs20vhtTFllZH7jmS9hWJ2cJg4p26PARyPRNs
         zZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795719631; x=1796324431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hvrwhli92ejef29utqXfTUqutjxeG4jEb3yA0cFFYgg=;
        b=HRQOCd7jnEuKv7yDLFSFKH8w9wZzr3X/XfeN5LLTL19MH5a/mxuk1+sNFZILDfz0ib
         Ls3FyOburqe3jsxe6VFqpN/oIg39b+lChR06JO2tmBJYevi1ovLFqQjw1jFogxyUoWhG
         wCmeFamjABItAdzWPJFDSkgzQLx2IlwmJqEP0mW94DAmBBR/nvN6PnJY3PcP3SpbC4sJ
         BgdHo+AhpdXNc/w182laZ1hKSHhuSij1JQJK4XDFXQ7MO7HB3XHxdYBpOw5+FY0Fv34a
         +XY/5vVSfpKY0rl/kje51cQB/3I1wFFFiOeVy7vsiDFNk0QEQN0gd6y1J2rxskTshv3+
         2RSw==
X-Forwarded-Encrypted: i=1; AL+hErFZTrQj+pxtLi9DL/5Apy+4e826R5AzTZDubwZiDuD1ZY1Tc7MRwEYKsw6oc0exRttYTM8zkCAAut0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UPJt6ULUihqqVZwVlnJiw8DC25HMlOThs9Vx9maqx01Tel0Hv
	DDWyH6BQEDGIeRllTM74XFTltYTuLPEJ12NgdDyVvBVHeJ4TjQcf7E0V9ymH718E/nPz+ePxwO2
	macD+R/BcCgJnXDy6DK8QBl0LnKw4eyeHtQfCVM3jLICwd92eeutFXFjmes4+HiY=
X-Gm-Gg: AZFdTZcJ0MB/zIIj1vuBrjZNAbNqU0+BLloLjt6p3AKFS7Gtcb5MjC8tBenONrs7IZ/
	hkkToLSafIaiOT/3luneVIGundXtRXwOOBkwaTv8w0HG14WYDd7BMHjxJLVeU/AQOVT0nDgMLCJ
	yCFTnbXhaydd2S5aY8fEZ1MkIC1RPSp2aG01VDddJbLKRXUn+59rcqU+zjAtE4IbQArqUQDrlLT
	/+AupKFJSZvw7aMEKDSEIVXeXdv7BcB/JrctMamUf/1ur8JZrmOdkmCsXPTmh2DsPl5/BGbOwxP
	4gRMgzMNNKjpa3WNSQEVUDh3ei8oMTKxMUnMsjyPgMU2KeKXAYma+Ci1fHtooW/sN0aUpUoZwsz
	MuW5juuZpzflyEnpSw5fxXJpreD5b3UiOSFYTtoOsd1VNpYP3+Gn1i8sFa4TKOHq9XbK3cF9om9
	89OOCG
X-Received: by 2002:a05:701b:4553:10b0:169:9f67:a91b with SMTP id a92af1059eb24-1b5568650aamr20546614c88.12.1795719631323;
        Thu, 26 Nov 2026 11:00:31 -0800 (PST)
X-Received: by 2002:a05:701b:4553:10b0:169:9f67:a91b with SMTP id a92af1059eb24-1b5568650aamr20546547c88.12.1795719630593;
        Thu, 26 Nov 2026 11:00:30 -0800 (PST)
Received: from hu-jkona-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm60868190c88.7.2026.11.26.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 11:00:30 -0800 (PST)
From: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 00:27:15 +0530
Subject: [PATCH 7/8] phy: qcom: usb: Keep the PHY GDSC ON during host bus
 suspend
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
Message-Id: <20261127-usb-pcie-gdsc-suspend-v1-7-485a08ffdc6f@oss.qualcomm.com>
References: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
In-Reply-To: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Prashanth K <prashanth.k@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX38faIKxax3uF
 Qgfmf3xwgvhne9qhfOYgAM68j2dHoDtGxOv5oHxkQ414/dpv8oj7/Nb5ML+nwBhnASCJqVayX38
 tUyADUi7oDA7bwnwdPcwsIds2X9MscaRaC5Jt1XQZQVZwnzZ1YddtddU+TIp0fonkwd0RfFypx5
 YtLj2KZ8tj///G61zZ8GiTSL0yguCe68BE+ZlAQzRi9+tzN66FzSe2gz7eDdRHQdGjBlY93hygv
 3mn+3POjPvOmtMaBRNQ+ZIGw9wceCuahMRIgikeZZLV59eaLbHbe/7cc7e81j9yI2JuA8RsvSm2
 5KHlPMBEA26+HxNwapEJtEqAcbetJupCbuvoVUyaYngpiU5/QBgmS0sR59FvZmjrZ12lG5BSRHv
 GPp3P1j50gFRv13EU4ycv6zB2DwFJZUPiQwCt1iVU67SLE6BIcNYjFfoRp3Z2jVFTgb9XJ5iAfa
 LyAF+8iOFdIecahD3sg==
X-Proofpoint-GUID: yzXxYJJlPSdNw0OKMqsABFENZbrMl7O8
X-Proofpoint-ORIG-GUID: yzXxYJJlPSdNw0OKMqsABFENZbrMl7O8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA3NCBTYWx0ZWRfX18ZZYypiTJxc
 ZGfyk6KYLU8Yh3QN1UFIVvuDE0iIUHwevPL8V6NAyFt5bhPELM+SuxgGtczEaXClC5qx/Ipk2HK
 g+/0bkYpW90WFwZP5dmPNd05GuKI3Q0=
X-Authority-Analysis: v=2.4 cv=FuOQbGrq c=1 sm=1 tr=0 ts=6b0881d0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=-5rFW9DF29b7OOe1maEA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260074

From: Prashanth K <prashanth.k@oss.qualcomm.com>

Keep the PHY GDSC ON while the PHY is runtime suspended in host mode,
so that PHY can resume without losing PHY state.  Allow it to turn off
when init_count is zero, or when set_hwmode_dev() isn't supported.
This allows PHY to consume lesser power when nothing is connected.

Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
Signed-off-by: Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index cd1ebe707bbe4ce790f964956391c561d2d1e223..20f64ffe4d3bdb283ce6185c94dbe021f4ec3d3c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -1506,6 +1507,9 @@ struct qmp_phy_cfg {
 
 	/* Offset from PCS to PCS_USB region */
 	unsigned int pcs_usb_offset;
+
+	/* true, if GDSC must stay enabled while this PHY is in use across suspend */
+	bool toggle_gdsc;
 };
 
 struct qmp_usb {
@@ -1956,6 +1960,7 @@ static const struct qmp_phy_cfg glymur_usb3_uniphy_cfg = {
 	.vreg_list		= qmp_phy_vreg_l,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v7_usb3phy_regs_layout,
+	.toggle_gdsc		= true,
 };
 
 static int qmp_usb_serdes_init(struct qmp_usb *qmp)
@@ -2197,14 +2202,24 @@ static void qmp_usb_disable_autonomous_mode(struct qmp_usb *qmp)
 static int __maybe_unused qmp_usb_runtime_suspend(struct device *dev)
 {
 	struct qmp_usb *qmp = dev_get_drvdata(dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
 	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
 
+	dev_pm_genpd_set_hwmode(dev, false);
+
 	if (!qmp->phy_initialized) {
 		dev_vdbg(dev, "PHY not initialized, bailing out\n");
 		return 0;
 	}
 
+	/*
+	 * Keep the PHY GDSC ON during suspend, so that phy can resume
+	 * without losing its state after host mode bus suspend.
+	 */
+	if (cfg->toggle_gdsc)
+		dev_pm_genpd_set_hwmode(dev, true);
+
 	qmp_usb_enable_autonomous_mode(qmp);
 
 	clk_disable_unprepare(qmp->pipe_clk);

-- 
2.56.0

