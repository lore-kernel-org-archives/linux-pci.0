Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087640;
	b=g2AhE8kVeYUo3QVUWNjiIw7tyVaM5dN6GBHPLS79G7QLnpsRO0wzFbiektvF8cxGq8fe
	 unEQWbeBhcTKW9fWzBQEoHsV1SJYhzVilkVv/6hF4rkWXYhehb6WBKw0AZCRY0yFAAejN
	 eBJ3IwI5PoWLmmFZ8nO0ursLXc4NOZFBqgTfFB9tuDEl/5R8LZDLZc9ymjIguON6he34t
	 Hn5RuJPZ2PWbFYz1ss9DVBfWAPYJ/rj6ICwmvLvQSHF2dgGMl3cTNHY6FUnN/DEMzAk3S
	 MvmHdgIBlwlWuet9q6dYBSO5Yn25V3TkFInzxXFvimd7yvFdewGrMSLXUfAjwfVj1TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087640;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7NgWLd61caeetSDwQ+8TNWhgbja1dOPLFdjr+q4WIrI=;
	b=X7tLi1uMTUl6qpG2NWDMD3GthLj79GT89bRL2G0T4B9IU8D4twkqMgVvF2KROQBK7v9m
	 um+dpHC7UUNWWjquAtYKYBELM0y8I+BU3H/WCa7FKT32nf3TjayBCiKiK3CdAjs/R2N3t
	 BCsVA3I/ao8YtzYrgbNj+ashpFIJv/yoUas7thV2KW7FBDyZRnw1AGqVK0vAjdzdcI9Gw
	 MiKwVRLkxky5pifoe70YcKmmbsuwC4RxaniW3GlRwnoHT2OVAZJfDggEQbBIWxiDfengp
	 oS5AJeDkIhPvEqdkJ4Hk1VsQJ/hfrcfEkthoC867uJe5FabXe7B70MD5yB9HJANc92Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJTwwDW7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jv5lEhVS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD9606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 11:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12BD9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJTwwDW7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jv5lEhVS
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBFi4g2151630
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 11:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7NgWLd61caeetSDwQ+8TNW
	hgbja1dOPLFdjr+q4WIrI=; b=CJTwwDW7Xv+6lVrV0Us294tT2ASlRsb0e1hyRn
	eOsmbKEQhgAQEmgenS1EdGbBQynTX8M7TK2vt9ZI8/Ngwuhm2i/wcYLVfKhsOGpR
	EWtP6zffXxXmUO7faz9HYuv6ppNa/vtp3LgGfbkAXbfqdxMVOWAnmJEgCTJu7CJ5
	jJs0wRcnhCgmQWsNMgfDo3i504lcGeLf85d4Do9DyljOPhv6Wsv8MnmdJAWqin25
	awYm/GopNz9fIHlv0vQrYl2WzjWiUlaOzT/65zg4cW0QP4TCMmGUwc19oFtsVvhq
	9lk68mINRhDHvvWqvlaOKEVmv0sesr5qHk+7cMQ+GzxjCrkw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1uux99uf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 11:27:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso2770059eec.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 03:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795087638; x=1795692438; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7NgWLd61caeetSDwQ+8TNWhgbja1dOPLFdjr+q4WIrI=;
        b=jv5lEhVS2iyR1511yi4ReOHuD0jAXB9obsxli4IsDLwzKt+1bZN4wQb2dE2pTepRzs
         5f+tvRPsDuEdzbZgy+YQ/fVqXJKe4TE1GsdDAcUv3fmXrJWENJPeeNVzbvdmngklqE0S
         Vogd8Rcwjb7yz5L10BOlYm1P5ijtHwK6eyFlJXlw4uWITWQjLpM0hCjjRdtn639aDaYs
         bSV8DHIJuSsN8YfhasoFWsuvRo5OcW5txOAMSDPMp7/ZRjsNT7EichsNjwfvX0s4xJL0
         c25QhgPbAjWbsQvJ2IRPYKNsRPT663XiesRLzc78++wXdI1L21CtavFNaItDOZGKx/kL
         D5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795087638; x=1795692438;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7NgWLd61caeetSDwQ+8TNWhgbja1dOPLFdjr+q4WIrI=;
        b=Oa5rAizR33sUvzRfT3u5ohhc56mLzAT61MmS6sry6/cCipxeckHAUVz4JvVrlFIR9y
         uC+lg0Xr70OZxKW1an+SA3axCDBwNRUPbmg1cWRwgGwibCLMwPA9V1sysTO/rxuwhpUQ
         Jb5RCTjLIAfgNzKjCzwEY7ujy7c3mKE/xIh5BY/ZsbQcvtcmWpK62vryfpEHHGxy2oNi
         dw/GjAqemWJmCCUQ/ne74rTTvqS5FY+TRZIrTayyiGfvYJph3kGB30BvjyzFI0D2HMUj
         +tfrzM3iwPZ1fVZFxlb/05Ui9/HyAxhwGFp+0bLesQRau4hDK6VywVWvLJydKIAtThvG
         U+jw==
X-Gm-Message-State: APuU4Z82X9/RLNm++FScIdaUFGT8fjUj9+IZo9Ty9xaZ2ab56WM0dZsU
	60g9aIRZVEc01FPgfh6FR6IEk4WUXSgrHR8CLaxFy0AHj1JeggxpImqK8AV1Dux4yWrzwYQvYET
	NUD5XmBPYfeozAyALnJTMSQw3Zwt0lb2qusy0DeyxWbi6S77vnns3kbc1b6Vm6bQ=
X-Gm-Gg: AZFdTZcp2DsKehXk4INmUjvfKT32r2FUO+/X9pcgZ4jnGixnBNu0BUmjQz1EmOVu073
	wXKnWznAYjkjRCh91p3OlJ1TfTULGO4BN4ftdHQmszEilVJXred00ao7n0fK2htJhqaFGoJac+z
	JG0wow5kkSTyrtZRocTDhRqFQDrDb3oBlA+7ADI36AFOKEemOJHboVLKt/x+tU3wkScWWJbt3+9
	ME517t5dfUf0nThs7zKu8RdQs5riWbICB0pN0zo52wokkjte/gWjr+8ANyybW/3y7OgrxbuLCN4
	03wn+8cx/NJY9XDz0KjD9q1nAgD/qXKaHw3Nlt1gcEORiso6XbjoJ8tHpPEWQDj8B34S8uF9z6D
	q+L6W4Bi8/Jug6VZk7XPUPiBj/EOTGqK6jbQHqUVKFFJHAvE5upuF2/Mf+0/+AKHTeiX7L+2zwf
	eumAVUkyAcaA==
X-Received: by 2002:a05:7301:711:b0:376:203e:7d7b with SMTP id 5a478bee46e88-3827d8225c7mr4973547eec.2.1795087637502;
        Thu, 19 Nov 2026 03:27:17 -0800 (PST)
X-Received: by 2002:a05:7301:711:b0:376:203e:7d7b with SMTP id 5a478bee46e88-3827d8225c7mr4973535eec.2.1795087636995;
        Thu, 19 Nov 2026 03:27:16 -0800 (PST)
Received: from hu-kumarab-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a75d401fsm16602693eec.20.2026.11.19.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:27:16 -0800 (PST)
From: Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:57:12 +0530
Subject: [PATCH] PCI/pwrctrl: tc9563: Enable 8 GT/s equalization
 fine-tuning
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
Message-Id: <20261119-tc9563_fine_tune-v1-1-b83c74bf1e94@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAA/d/moC/yXMQQqDMBBG4avIrBtwoobqVYqITf/odBFLEkUQ7
 97YLr/FewdFBEGkrjgoYJMoi8/gW0F2Hv0EJa9s0qU2zNyqZNvGVIMTjyGtHoodcDdOox4rytk
 nwMn+Wz76v+P6fMOm60Pn+QVkIB1ydAAAAA==
X-Change-ID: 20261119-tc9563_fine_tune-1fee86f2e4a3
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, krishna.chundru@oss.qualcomm.com,
        Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795087634; l=2700;
 i=abhishek.kumar15@oss.qualcomm.com; s=20261119; h=from:subject:message-id;
 bh=W+Ek/FXl/YHZtPvfISVMSCtee0YtYtVYdPTP3dUIXuA=;
 b=lXaN0ytDNAwp4xKM6oKfaDluqmGRtCnd7Ub05KoxkPsTT65fVOC2tmAHivdenBZWPfs9iBfOn
 CHPiTjJB6IEBrI0T2RRKER1taxL14vv7gAmFYV7Z1jN8hgMDZEYApp4
X-Developer-Key: i=abhishek.kumar15@oss.qualcomm.com; a=ed25519;
 pk=9+XmrSHYMfaqDuFEwfVrJC3Sv5YurOo5aeFZ+59/h2w=
X-Proofpoint-ORIG-GUID: mkiJlc4NichjMK8xj573w5lr2T_wQYz8
X-Proofpoint-GUID: mkiJlc4NichjMK8xj573w5lr2T_wQYz8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX6QHVXxC8WKsf
 4wtPBjPnv82aVq9tj8mCac8Iq0bbpdP5KTesZPDpjMMpHs/PdbT/urWHFHiK6qbYqxD+LOb+IcW
 0xcSNFJuYE+AFAGjP4R+kwX7aMfyNMg=
X-Authority-Analysis: v=2.4 cv=Q89HcI2a c=1 sm=1 tr=0 ts=6afedd16 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rkvmEHgfrVuJKAzVtpwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX0+puXa1gnyiY
 DEHoaHJjzFfoZ+EhpCdOsqsDk8RTOM+ksa95bWrs6oQmylBtnQBS5tGsldvi0GEfZDgQTWKohNq
 QQ1bJto88lWha+G1uOm1ndiQLVSqXmQtTx4C53+JmSGEQZniy3w39ifNAe+sZHQFCjaz64ItFJp
 6FIWG9htSk2fb1PomA09qOy6jIdmP2ub/V377VxVwPCPkpSOTdKh2bBdkSQxKL6HlOYNQNvZsag
 hvCi06NiwXYRCkcizApNye+tApKyIqh/s4gfFgZtYCOsNJQ2fHEEwf7dLzGM9OoPWTZVZgVz0qN
 Rb5R+AJUgZIMayce2dnMw0EA8unfGuoFPss8M7yYbPNlebFj0+SVxVqjRdyV2jKSST8ZWNtcOwj
 0/apjs6S93cwswQy+pBwushdec9bD9BNvjIBBHCP7qhj3ZLWD6/VtTeNovqAADzum7vGFgV1Lyn
 EzK5FHtX/c1n8aFsgkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045

On some boots, links on the PCIe switch report a continuous flood of
correctable AER errors (RxErr, BadTLP and Replay Timer Timeout) at
8 GT/s. This happens because the 8 GT/s equalization fine-tuning
setting is never programmed: max_num_of_fine_tuning_iterations_at_8gt
in K_EQUTUNING_033_028 resets to 0, so equalization only selects a
preset and never fine-tunes the transmitter coefficients for the
channel, leaving the link with marginal signal quality.

Fix this by programming one fine-tuning iteration on the upstream port
and downstream ports 1 and 2 at power-on, so that 8 GT/s equalization
adapts the transmitter coefficients to the channel. With this setting
the links no longer report any AER errors.

Signed-off-by: Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 4091a2f30aa7..d27b009430f1 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -29,6 +29,9 @@
 #define TC9563_PORT_L0S_DELAY		0x82496c
 #define TC9563_PORT_L1_DELAY		0x824970
 
+#define TC9563_K_EQUTUNING_033_028	0x824a10
+#define TC9563_EQ_FINE_TUNING_ITER	1
+
 #define TC9563_EMBEDDED_ETH_DELAY	0x8200d8
 #define TC9563_ETH_L1_DELAY_MASK	GENMASK(27, 18)
 #define TC9563_ETH_L1_DELAY_VALUE(x)	FIELD_PREP(TC9563_ETH_L1_DELAY_MASK, x)
@@ -346,6 +349,20 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
 				      ARRAY_SIZE(nfts_seq));
 }
 
+static int tc9563_pwrctrl_set_eq_fine_tuning(struct tc9563_pwrctrl *tc9563)
+{
+	int ret;
+
+	ret = regmap_write(tc9563->regmap, TC9563_PORT_SELECT,
+			   BIT(TC9563_USP) | BIT(TC9563_DSP1) |
+			   BIT(TC9563_DSP2));
+	if (ret)
+		return ret;
+
+	return regmap_write(tc9563->regmap, TC9563_K_EQUTUNING_033_028,
+			    TC9563_EQ_FINE_TUNING_ITER);
+}
+
 static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
 						bool deassert)
 {
@@ -557,6 +574,12 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	if (ret)
 		goto power_off;
 
+	ret = tc9563_pwrctrl_set_eq_fine_tuning(tc9563);
+	if (ret) {
+		dev_err(dev, "Failed to enable 8 GT/s EQ fine-tuning\n");
+		goto power_off;
+	}
+
 	for (i = 0; i < TC9563_MAX; i++) {
 		cfg = &tc9563->cfg[i];
 		ret = tc9563_pwrctrl_disable_port(tc9563, i);

---
base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
change-id: 20261119-tc9563_fine_tune-1fee86f2e4a3

Best regards,
--  
Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>

