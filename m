Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621674;
	b=AcIFXp0nmi9+sotqWajNP4ADWG8gmVHT7SF/BvT8IPoGRAW1Y9ILyA0g98FXKc790BTp
	 DK5ciGR+nslyxGGq7JWvAgECP0EldBGIjfM1HCG5hAPclEdLtXoxFCHIqlLON2pBV/wSx
	 p63zaJau7EdPpuaWobXlJ3R8Wl7BXFcHDq/re+uSVn90hv312B35wKwsGyQAwFG+lE1q8
	 uJlFz1kUBFXeJQrvoeBu4RqWoQwjfub8RRUwMjb97B4fyc/TCrG33lA6KvFdseseEoL+9
	 IBiOVnqSu6wnaNcbMWhZ34kwvll2lDsKormEz/SzXsdsNhVjU9JF1+YeLvQA02Ks9Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621674;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oEZrtAfgbltww7CIk7QptQLjgCWmm65T14CEUlIyEjE=;
	b=ozobFxhr/J9SsBL5j2eKLBymh5xzeNXwxJTk2htuzBkW3NM7CrzHohPZEOcUcFikEWWa
	 44/TbcBwWlsrlcLsnz4IKJgzdA8/s0i5fNJpyXycHwqXeoG1gZBxqIqxMwBUBbkpeggjA
	 +8vquQiIRnqxj8+qej/hUI8yPQddfQJFW83/gPYL2l6d2nGYmX5nt0IS9HRkMZbumd0V9
	 YHglh3Qh8bTrGsrmtGBCUGgKA2QjZfWJVS5QoCdOWl4waTsA3RRyNtFfz6OfXQcoS5Ab8
	 digugxj3OjuO+HO3FVO9enTqCyMfW3LR/JVldzQwyFbjoicWXb93PtAgaUy3iTF7log==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IX5Lf9fW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SPbNLetp;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A760A5BC8
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 575A760A5BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IX5Lf9fW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SPbNLetp
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE202563350015
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEZrtAfgbltww7CIk7QptQLjgCWmm65T14CEUlIyEjE=; b=IX5Lf9fWLbAeSkOE
	mnPfLjMR/F4m0wh35OJV+M96uRsSpn/4G2heO/VBJvfA/s/Yeo5wMCqcUUFaFfxR
	SU0RpSDgVcguDuiUEMTFqt/qUQp2lRD7XeXGp8IJRR2aNLQHsaFxpVfAebWopToK
	6X232dCiPSQOta0U+GXiH8d8XN2Iis7awYQ2orfylWeVpVqn1xBvWP6Jy4XiARJV
	2s+tiQ6FOTjMk8UmiCTTuy1rJMb5LEzEAevhTxMZsgIyklbg2ybh+AVLRVDk5h2s
	6vSjrcTz6DXh9R92O/KVhjSGR8o+4La/7vjXvuG8vuRddhjQlSwTON667+GVqRdk
	GunDEg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bpb2xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 02:01:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1a71dd190b0so1756148c88.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 18:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794621672; x=1795226472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oEZrtAfgbltww7CIk7QptQLjgCWmm65T14CEUlIyEjE=;
        b=SPbNLetpLhgu3bSbnlvXAMrtcbH4AYKKvIPHMmZa6hUbeqDN+IJoSxkFSFr7WbQhrb
         x0F0WmMwYfCe8CvfsftSUvKh6ldgQ5ztjBwj8uZJSyVSOqCoaFvSXMYU+W5vThf3tzGG
         jdXeDFOwSs4L+SHyZcIASbvhJ01YUGIqJXWECicLSdr6K8Dy5VdHxZqVgPvClyXRBGgu
         7VNtlS3k4bJNLXe1sFhk77jXQcdX8aA4aFuyK1q4WjcA9AoBwJEtUf7hGlAYW4CS0wyU
         eR7Bcd2T9i2Gk8b+HEpugmfHe/A3Cw+mLNU8v60131XtS+EE08SWJ+sUaFTAdz0dFUBx
         cLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621672; x=1795226472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oEZrtAfgbltww7CIk7QptQLjgCWmm65T14CEUlIyEjE=;
        b=ycjqFarzaAto+ruNyzF8A9IGxaEcqbM41eHRseeHF6uSwZ9ru3oqyr9oxHAyUVrK0I
         DzySgQvsxxkxlgSTUFZwdxgb+EctNV7nVF1Tsm3QboliN9Ij6EFjyjlHWTFvOBK3lLHw
         T/mkP95WtYykYYjwb2pUZovVw2Eo/zKUAJxlygQmA/NEWRiwxM+jo3uMlKRCrljDN0Xs
         uuR1uz/2uElDcq/qFqpz2N+6DgEZA5bGsK2lZ0S/mlH2UIlgFdOwG5CsTRTSRN1q85Qz
         nGe8ALnMS8jCCHtTnJ5Fmlci6F/lTeMUDV+A1+12Jl22VuBwxS/9pCfZ7gdpq9uFAM2F
         QrnQ==
X-Forwarded-Encrypted: i=1; AL+hErHRJogjOkyMX70tizdoNdl3EHRnqllJCvIvrXn9/KRdLV7en62P8V9QjuFPZ3CfyhjLcFoOttIdwtY=@vger.kernel.org
X-Gm-Message-State: APuU4Z98IJIVuUEqUlaIRsZOqIMqk+agRxgwdUa14JuIeqESA3j4AOm9
	so0qXGepLqAk0m8u1MOM105yWFLgaYdQNuOIDXcEhB7GtApfY5cN4Yq8iK97Rqj59a0+uHL8an+
	uQOnZMGTZb7XASfMnkN5QKhn+srZKhezjPxJrETLDoIDdhzGzXzXlobf/szOqzic=
X-Gm-Gg: AYBFou2CXjqijSHa/4G5mFwvJ/AlArR1veyXt6eK/arPl4j93CZ08VAyl5J+FOeJ9vS
	4PgWwnBIZECgdVeYlILfdP4T3m1C0M2QD+qhKdXBwF+F9jMByBKHcD0tB9wVGg6gX98ZXdNjE0e
	Bvk5Ns38uAHwfO0HQMRhW7CVI3cZJAoyOIdAWfWor4QeWn4m6VOY/x5phFhXZv9LGNETEFyWdse
	FQfcDIsbRs0AKwagrI8Az763BYZTosGyu6wVaWIm4KLZP7FbXXVo0Zg189tq4/I7XwfwZ16LXmZ
	kLuexdJ9r91GxoN/qoUx3vq4dl5HlBJ70ZCZqtn44AiY4a3cup3esqpmFebJBI2/gEKl9QjMwvv
	iTXu9FrOq7Nx2qADxrKW9ZRid/rK2XXbfXEcVheF2ugRYLdtFTVrDtuNS+JU+5uYNolXo1tHKg3
	nl87E7Qs1f
X-Received: by 2002:a05:7022:1305:b0:1ab:aaf3:389d with SMTP id a92af1059eb24-1b50308b44emr3961434c88.1.1794621672046;
        Fri, 13 Nov 2026 18:01:12 -0800 (PST)
X-Received: by 2002:a05:7022:1305:b0:1ab:aaf3:389d with SMTP id a92af1059eb24-1b50308b44emr3961398c88.1.1794621671385;
        Fri, 13 Nov 2026 18:01:11 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm9952742c88.7.2026.11.13.18.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 18:01:11 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:30:53 +0530
Subject: [PATCH v9 3/4] PCI: dwc: Add dw_pcie_mask_msi() to mask chained
 MSI without freeing domain
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
Message-Id: <20261114-shutdown-v9-3-5430c9f242ed@oss.qualcomm.com>
References: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
In-Reply-To: <20261114-shutdown-v9-0-5430c9f242ed@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794621655; l=3587;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=dlM+4DysSk4XqxuJ4iHr8Yg0JS+rtikUaX5y0PL4/vg=;
 b=wJJ6jTRxeXwNTqLf5s48GZ84+hGD5tlQsx4lrdnL0EgUrvAFzBC5oZFPToY5dV5Z4FTWqgYPc
 FtdAuCFmumlDvB+v+3izgm0ETSQ0HlCVqXShvK0/0l01b9U7qXdMtFp
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af7c0e9 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=H8WLNgnoBSHn1WVVwwcA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 8If_p05pcXEUM4iMmLebI4etsqkuXY-e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX9JC0tGXzfLL4
 0y5ZdKpFWyje8feAnTpgT6mFfYy7Bay3jNa/EWWN+QuasrjyWrb79LDpITMq7GvI6Z7z+Kh3NhT
 q4kSjiA2UeCEmqtYqsu1yQLQaoo4T24=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNyBTYWx0ZWRfX27RxY52uVQUE
 NSaHHEyEc/hFBoaoGhHc383wSuZPLUa43PsrK/Rru/6m/lWUueUfP9TOqQsgqOEBmhMnW1jOwKk
 al/ZLCGDW2T9x97GGc3kPt2/ujl0XTf/14APT/NZpRm85DFDFo1n8xSogYVsEEbHwcfEqVgSMnb
 uglVc+JrL3Oh1IcSaUhp9ewptAAOP6Tp+F3iv33mLu/z+oamIS8kNrIEEV72SjzjJsFQiybYdcG
 Uw5FfmYQ2XGCgJXBoayo3noTxlMv05smWBojB1rDkpeYkzkWvjowGE92+7Inn3UceRBiyo0/s5A
 CqYhQ1XoqoRvhcG1Ca01p+083x/d7SUtD1N3CUJF24E1ZMGrbSD+o9USdib+bcAr3GF6FGfL5mU
 ooBSjcdmCxKQN6KRuQ3oiMBSOYfmNqws3o21rwK4EC1N3A7e3BUV07AjPWhtAdm+GJFtE2gPIlE
 5LNL67Ut5csk1ZEJeAQ==
X-Proofpoint-ORIG-GUID: 8If_p05pcXEUM4iMmLebI4etsqkuXY-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140007

dw_pcie_free_msi() detaches the chained MSI handler(s) and then removes
the MSI IRQ domain via irq_domain_remove(). That is correct for the
dw_pcie_host_deinit() teardown path, where PCI devices have already been
removed and no MSI mappings remain.

It is not safe to call from the shutdown()/reboot path. device_shutdown()
does not remove PCI devices or tear down their per-device child MSI
domains, so endpoint drivers that do not free their MSI vectors in a
shutdown callback leave live MSI descriptors parented to the domain.
Removing the domain there orphans those descriptors and leaves dangling
references to freed memory: during a subsequent kexec CPU teardown, IRQ
migration walks irq_data->parent_data and can dereference the freed
msi_irq_domain.

Add dw_pcie_mask_msi(), which only disables the controller's chained MSI
parent interrupt line(s) to stop further MSI delivery, leaving the IRQ
domain and the downstream MSI mappings intact. This gives the shutdown
path a way to silence MSIs before clocks/power are cut without the
teardown side effects of dw_pcie_free_msi().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0837bb9e67e0..7f0126c5336b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -240,6 +240,28 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
 
+/**
+ * dw_pcie_mask_msi - Mask the chained MSI parent interrupt(s)
+ * @pp: DWC PCIe RP private data
+ *
+ * Disable the controller's chained MSI interrupt line(s) to stop further
+ * MSI delivery, while leaving the MSI IRQ domain and the MSI mappings held
+ * by downstream devices intact. Unlike dw_pcie_free_msi(), this does not
+ * remove the IRQ domain, so it is safe to call from the shutdown()/reboot
+ * path where PCI devices are not removed and their MSI descriptors must not
+ * be orphaned.
+ */
+void dw_pcie_mask_msi(struct dw_pcie_rp *pp)
+{
+	u32 ctrl;
+
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
+		if (pp->msi_irq[ctrl] > 0)
+			disable_irq(pp->msi_irq[ctrl]);
+	}
+}
+EXPORT_SYMBOL_GPL(dw_pcie_mask_msi);
+
 void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f774fc6d2a24..677e5423c5e4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -908,6 +908,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
 int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_free_msi(struct dw_pcie_rp *pp);
+void dw_pcie_mask_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
@@ -938,6 +939,9 @@ static inline int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 static inline void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 { }
 
+static inline void dw_pcie_mask_msi(struct dw_pcie_rp *pp)
+{ }
+
 static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	return 0;

-- 
2.34.1

