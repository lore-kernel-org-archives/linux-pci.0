Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BE39183C
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145991; cv=none; b=X1E/3qfChORW5/payH9QW3CG5Avqrn3tKg/toUrzihWDJZX5NBkmwV8JNeLBoU84Iwssh0t/sdvpnyfzgmiL8t07CWE+ZkeSMIOAn8E/mgt/dWIoQ/1iirdvk5pwCdNN6lnCC8E7fSLdFVSJWFBdA8OmuO+9auVXCESRFQYQ7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145991; c=relaxed/simple;
	bh=SxCA5XEAWKCcLkJi+5jHbvA5AUH+9sF5/jS3yVkOn+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDtlKqoon6es09NmeL+1lNji+W3h7RdazFc2+7Xecz2gdz7uvK6Lgbtq2eMG2UV6Qywyl+1XvS8wSo5ejNsHKDJyvh+pLQrjJtI+M+maeDIhnzKpVBCMQRPn5srhMcMp6z8i0VK1rN9gZtP2/mLdd0Cfh78a7bfK5la6L/89eSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=anGZIaxG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ou4peQ2b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="anGZIaxG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ou4peQ2b"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JD0fgN3601123
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZm8p07OPUwjWzI9g+/BN5XpGEETr3ffQKeDhE670RY=; b=anGZIaxGsLZQRJhu
	tC8Tf1KIAXcfjXEgxXtHkEnY4f3lRaKQjfFctshUG7cuNcl/+ZxmgTwQCfBUA7Uy
	GYy/ug4hdsAVNdkcO09ckYeY8AOvxL8djFVmbv8kWey2FvLp1814TzGxxpEC8ad/
	k+jR1lBZ/W7mmfIKnzejZLp15yWU/UaqDlLl4CFGVvfwslMi4jBP/nlTZspabY4C
	k3zDvtC2vqnUSEVdp5LZUiEoO3Cowes/hw4UePbNf2NOOPmXIFgv9+o1tcVHrZ/3
	i9h+vbd1SF1P+4rJZe+5in5JdjhYnl1WpQvsm33dbnxQpqI/lHLJMsY3Pae5CEPb
	pIA6Og==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm3dak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 13:26:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so13978415ad.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787145985; x=1787750785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZm8p07OPUwjWzI9g+/BN5XpGEETr3ffQKeDhE670RY=;
        b=Ou4peQ2bCeAFAHi3LIQ20uzK5i1se15YOhTf+LRISY7O7WQ58GXxRf0oK3SZjIOLEw
         YyUbp4gDaBysmlmsI7MWroD8uvIXO9T9KST3anN3WEN4nsVMxAZIRDas6on/NPTVdj8M
         61b4gnN8q2LcFPKhLWJyUCijlIY79kFQflhAn6evMYb3M/Y08DEqF4PT94lCNdKDfkR7
         6DB4zsXYV3NCEv/+4hSLQom0HMHa1r049udeBnMpFVmvVEkEAQm4AmQ7zv40EBZ3YX/c
         0jdCsZ/L0PzGR3BfteaNpR+E5W187YJ707ZMGzkdzPe6y2Ce5YbbS+x2kTY0d/FdrtCI
         IUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145985; x=1787750785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uZm8p07OPUwjWzI9g+/BN5XpGEETr3ffQKeDhE670RY=;
        b=n/1GfKN4P+AOwMnnVFCuInO6Nu4um5RnxiNkJOnuAxJWIt5qBR5t3a/rmxF+akC7Ag
         zmVeHbxexQUq7NpMjMFOXSjsctmrQQewp9/Eo4A6PtUI6b30Hr/xgyM9Os1t19J9dIuA
         XrBGE4YSainCF93TNaUA/xB0fDbVNvoC7xR3EQ3/+M+hklpVx9Fx3zQLuiBxITnck1S/
         8ziOz1QDYFLe3EKhwK9cMTm25Tx+EsKxkCetVsitlR6Hce96pvLL5UPemGMSNZ3QzHWj
         xXRIT/2IEk0Nlpv0ds9BgUAUmpbRx8r3zDEUntIgqt8gHokAZMUFFQUYiSeFFObViPR7
         rpVQ==
X-Gm-Message-State: AFuF++mCQ528PbwOe5/OywH6Y/iY8ZftX2OeC4GP3qzPJa7TEwR8B7E1
	TgxAyFtXcewdN0DbyL5mEiG/o0RWQwcuHjySz4ZJ/U/tc+FkrXqBNbBmzxhFfNtMoRnFjgIu13X
	7M0EpJl5C6HhBaQEYlFCXS7/n5j+0HIocqH24xUnYQrw3Dua0GK3iEqHKLbdPuo0=
X-Gm-Gg: AR+sD10p+EG8Omq8iNFHsjWs4MmraMkW12sb6EiRFZZRh8SyYECN4IlHQFk6Fdn2Lz5
	ZO9jlgGFS2eAV5DrNMymUA0PBxSSatPSF6u7X07DRBcVskcmrMGIZlrq4gDa7DvUkCW6tw19E/a
	kZGi+FLP3MGaQWXCHTAFGJhM6iQMjzvq64ZPq+Rbp5MinNrEn9HNT5Ez/y3W452odiDmwtFze8W
	cxOIP6aIdRVnWapdbQMtDrqOJkxkLntNRRpEiJ6rtndoEppHOk1LtBpDYZcRn+MLt1ktKC8SdlH
	IhDT88CO5tD7Z1UBnWvbEkmkp431wNaoZDjYerKxeyAtx81Kopt2POn9iAHfbl8YPN4gc3Ua/vQ
	7e9KoVbFgEGMa2jHR/Ymki/jrNEGVR9pBlNw=
X-Received: by 2002:a17:903:32cd:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d5fca022b5mr42665885ad.13.1787145985193;
        Wed, 19 Aug 2026 06:26:25 -0700 (PDT)
X-Received: by 2002:a17:903:32cd:b0:2d2:72b6:556b with SMTP id d9443c01a7336-2d5fca022b5mr42665355ad.13.1787145984708;
        Wed, 19 Aug 2026 06:26:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c2a92406sm6126465eec.11.2026.08.19.06.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 06:26:24 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 18:55:52 +0530
Subject: [PATCH v5 1/6] PCI/bwctrl: Set host bridge OPP and optionally
 disable ASPM around link retraining
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-bwscale-v5-1-6dea79786b37@oss.qualcomm.com>
References: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
In-Reply-To: <20260819-bwscale-v5-0-6dea79786b37@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787145973; l=5454;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=SxCA5XEAWKCcLkJi+5jHbvA5AUH+9sF5/jS3yVkOn+A=;
 b=+05IMJ0Y0LiMP+RJM/+lS+Ieb366h5UNezsjnd0NgWZJXOIggWGrqhPxMjNciQkqd7wJ9Tsh4
 r6NglZRdgamDYFX2v5ULcjIPuRYE0iQYRf+qfr13iweVLysNF1dR4Zo
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: H8XLAgTfsOV4xx1UjNOp-mM7P0vsIk5U
X-Authority-Analysis: v=2.4 cv=bth8wkai c=1 sm=1 tr=0 ts=6a85af02 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=m7h7XtmfQhPoxq-7kmMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: H8XLAgTfsOV4xx1UjNOp-mM7P0vsIk5U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfX/ghgCE4I3pyI
 RC5M3cMM1dScf3rPzWy4dKP48THWFFsy9P8VFjgPecI4ofq2V9jLD4lg6gPxhdkuBQ7i+mxgYMp
 ITqwt2lT66w0fe9e9XczpSWrUeycWc71jz+VdDCuOu4/2dJ4R6xjHr84/54MJP0e2+hI8Un6MWT
 vBEbV5j2y020cj0a0f/Wkiclll1TNtjHX6KFTN+rZHJLUdZMCHCoVaQPdm+mOvFwXvESd8b2seL
 GIEprPTboTKKDL21apZdUovQMcZ1ffwsBIyNuoGhLmHdZZAffrab6e902hiHvjhkizoEEIgrVMK
 pOWLArZoE4cYskZIBvsdeQ2WWS63XzLyXJbBliH1jAmKoxQhJubHQh3IX3EsLJZR/B+OZAu72kz
 4Gfkf/h1PJcNTcmLtYqneRUEpeJ4kVm8ZGcvHG5wlczT4LGAacukdlc8G5FPYSdaTHWjnJCrFgG
 zlbomuXf3cRoT/d8p9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfX+971npVt89qk
 TFLKtKFHGil22nkm9oXfXOGv40NHwXzzgjJPkErk9iIJR4oEDMqbkfjOsC+es6HIgDcEwPEcamu
 7lwufExh3klj9hqx9xAHRrZv+5Kna0Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190104

PCIe host bridge controllers may need their operating point raised before
retraining to a higher link speed so that hardware resources (e.g., RPMh
votes on Qualcomm platforms) are available at the requested data rate.
After retraining, the operating point must be updated to reflect the
actual negotiated speed.

Add pcie_set_opp() to look up an OPP on the host bridge parent device
using a key of (per-lane frequency in kHz, LNKCTL2 Target Link Speed
level).  Keying by generation rather than total bandwidth lets OPP tables
remain width-independent.

In pcie_set_target_speed(), call pcie_set_opp() before retraining only
when upscaling (speed_req > cur_bus_speed), since only raising the
operating point requires pre-staging hardware.  After retraining, call
pcie_set_opp() unconditionally with the actual cur_bus_speed to settle
the votes.  Both calls are skipped for downstream ports of PCIe switches,
as those are outside the host controller's scope.

Some controllers also require ASPM to be disabled around link retraining.
Add a disable_aspm_for_retrain flag to pci_host_bridge; when set,
pcie_set_target_speed() saves the child device's ASPM state, disables all
ASPM link states before retraining, and restores them afterward.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/bwctrl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h       |  1 +
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index c4c8d260bf96..6fa1522c47db 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -28,9 +28,11 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci-bwctrl.h>
+#include <linux/pm_opp.h>
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -120,6 +122,38 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
 	return pcie_retrain_link(port, use_lt);
 }
 
+static int pcie_set_opp(struct pci_dev *pdev, struct pci_host_bridge *host,
+			enum pci_bus_speed speed)
+{
+	struct device *dev = host->dev.parent;
+	struct dev_pm_opp_key key = {};
+	int ret, freq_mbps, width;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
+	u16 lnksta;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
+
+	freq_mbps = pcie_dev_speed_mbps(speed);
+	if (freq_mbps < 0)
+		return -EINVAL;
+
+	freq_kbps = freq_mbps * KILO;
+	key.freq = freq_kbps;
+	key.level = pci_bus_speed2lnkctl2(speed);
+	key.bw = 0;
+	opp = dev_pm_opp_find_key_exact(dev, &key, true);
+	if (!IS_ERR(opp)) {
+		ret = dev_pm_opp_set_opp(dev, opp);
+		if (ret)
+			dev_err(dev, "Failed to set OPP for freq (%lu): %d\n",
+				freq_kbps * width, ret);
+		dev_pm_opp_put(opp);
+	}
+	return 0;
+}
+
 /**
  * pcie_set_target_speed - Set downstream Link Speed for PCIe Port
  * @port:	PCIe Port
@@ -140,9 +174,12 @@ static int pcie_bwctrl_change_speed(struct pci_dev *port, u16 target_speed, bool
 int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 			  bool use_lt)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(port->bus);
+	bool is_rootbus = pci_is_root_bus(port->bus);
 	struct pci_bus *bus = port->subordinate;
+	struct pci_dev *child = NULL;
+	int aspm_state = 0, ret;
 	u16 target_speed;
-	int ret;
 
 	if (WARN_ON_ONCE(!pcie_valid_speed(speed_req)))
 		return -EINVAL;
@@ -152,6 +189,24 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	target_speed = pcie_bwctrl_select_speed(port, speed_req);
 
+	/*
+	 * The host bridge driver may need to be scaled for targeted speed
+	 * otherwise link might not come up at requested speed.
+	 */
+	if (is_rootbus && host && bus) {
+		/* Get function 0 of downstream device */
+		list_for_each_entry(child, &bus->devices, bus_list)
+			if (PCI_FUNC(child->devfn) == 0)
+				break;
+
+		if (child && host->disable_aspm_for_retrain) {
+			aspm_state = pcie_aspm_enabled(child);
+			pci_disable_link_state_locked(child, PCIE_LINK_STATE_ALL);
+		}
+		if (speed_req > bus->cur_bus_speed)
+			pcie_set_opp(port, host, speed_req);
+	}
+
 	scoped_guard(rwsem_read, &pcie_bwctrl_setspeed_rwsem) {
 		struct pcie_bwctrl_data *data = port->link_bwctrl;
 
@@ -176,6 +231,12 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 	    !list_empty(&bus->devices))
 		ret = -EAGAIN;
 
+	if (bus && is_rootbus && host) {
+		if (child && host->disable_aspm_for_retrain)
+			pci_enable_link_state_locked(child, aspm_state);
+		pcie_set_opp(port, host, bus->cur_bus_speed);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18e814064b51..d1f2d382189d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -662,6 +662,7 @@ struct pci_host_bridge {
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
 	unsigned int	broken_l1ss_resume:1;	/* Resuming from L1SS during
 						   system suspend is broken */
+	unsigned int	disable_aspm_for_retrain:1; /* Disable ASPM before link retain */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,

-- 
2.34.1

