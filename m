Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455F2931CE
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787728611; cv=none; b=HtXkfG4XDy6bsAQOn2GV4s3+RR48By5KyBcKP4oNBrO98foAuel2mkMMnbSsnOgu0vTUJvq/hixPl1HQW23b3vfuUGYzDPdPFpBDbwG1GCqYT+A2N7oUEBFYMv5h0LAiphNAzBA0qCuIkPr/tqXKV6OuHr9dkWpyb40kbcoID4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787728611; c=relaxed/simple;
	bh=NL3e6lSDwolXTEQEXxOaRqaxbTOpDo25fI3lmsTFnA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ttiHYW9KVwlp5u1pmV/iBP+TYy6yAJ4j6NUlu0OBm8o+BJi19RS6E3AOdSYQJ+MEZf501/1BXcWz75lKQPx8fqWUAAQplpgz/7fN9zuQtIQINtMC4/vcqXa4iQCozfaaHUVVvq2ycpUTCT4RJLZUGJkFakTUz81f0CbcHsT7F88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T4io1fmQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DuroGTVJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T4io1fmQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuroGTVJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6S7Qq4097221
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ojrjt6AFu0pYOjors39GFF
	/bsR2YDyUbcT9UWfVi3y4=; b=T4io1fmQl/uID8u6cgTERmptOw6XwNjOY8cVMY
	FgHFVJroxFMT8Vj4EC2JS6GHsZ+i1TnQc1PmLUqw3bN9nJ/LME+X5i3PnSIiPt7M
	9lhokF9Ew9AQHPO9e/2cWaxsfy0GRvy256BqtOIjy0uAu9k0YsvKDdU5JIqsZ4en
	3SI0+Z71XEV0esccGAZ2y4XZWc1P5p4VqI9R/wR4mzeLa8ibJBUhPlB0Af6ow4mU
	UKGIpOjdoo0LCged9OIq5Hvys/+pSO+GWhX8Q3piHbmwnwUtvB9Ys5OZOcMus6he
	1tvDyLlbLyMchO9EQEtZqctqkLubXjTBcRU1w5s2+3jl0vRA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fcetnm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 07:16:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cb806660so197885a12.3
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 00:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787728607; x=1788333407; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ojrjt6AFu0pYOjors39GFF/bsR2YDyUbcT9UWfVi3y4=;
        b=DuroGTVJ20wI1dp4uLLVpzxLmr/jEZHEdp1a+NubfXx4SaJ9gxtvY6OjPkxCHHnJJS
         Jw/GVh+oonqkY9q77jT4LDb0gNsnlO0QlvUdu3Zw5JKxQtrb6Udpfi0MfF2soZyA9kOv
         WzVTPqGlyq4jVkDMOGdUgwtxZDBliV2q3aoJ0BOrNwXR9/LjAbbRG0MAoLhGipp9tojg
         va8igJzfRgudJ16DWV1icYWVxMuA7uZwEUbeLgy3k4jH8+Zs2ZSRI1Psa7K1C+swQY/+
         rysmdOFQKHd6F2P8B2j7bVn+1fMvGLlci80MQRs/oQZochTwDVIrwCkn8mNcUTLNCXPL
         rj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787728607; x=1788333407;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ojrjt6AFu0pYOjors39GFF/bsR2YDyUbcT9UWfVi3y4=;
        b=QQLeb1e7GV9ffeMg3pO4yo5dRL0y0MsKwpUzdl6fj/yM8XgdI9JrQwf6/3vbhakX9K
         JFzgVMg7SNKNh7DHwAQ/ALBFEU5UH3zStV6l1NNHNz2p3X9MQTvTEXREh1vLPWniGgR+
         xPsCqw2WbsB+ZywOZWvM8afxeruRqINhCpVna2bGWgEk+pUsrUn0BBmFl/etBEqSG3Je
         tDQpfGbuOL0i7797cTF0KyQEIGwqxjxi6UNDXJmWmlsCW1gJdVKiYZAC2SHMJpTzY0SO
         6OtMDxdRfjhm493VlwCOttrQpsX71QcJSMKPfPaZmwerBsD/6gcGzvdQXLAAl/CTQN1K
         Xhlw==
X-Forwarded-Encrypted: i=1; AHgh+Rpo2z5QZegrazniTsOq68U7FqzW95vMdVcAPr/w5wofU/dDPJOqXKghXffE8nW9YE0zJMAdCbQ27Wk=@vger.kernel.org
X-Gm-Message-State: AFuF++l2ZOi6ttDM0lpSvX6VTlOURNYySrpPNlK5JXAyVavbFo3d9QRW
	WSA6hTWQ3v6HQ0vKpJDh5Ibd96KEnnN+xo6EQx4h44zJ5TlOaEQ7EwnDYf5VCKW5P7GaGNq6Szp
	/SCODqCTkDQuOYvq//nvPqhoVQbI9OMHkRHBD2RxKpGzT/G49+GyGLwlagqLoar+iMVlK5VI=
X-Gm-Gg: AR+sD122wo8dQm2b3Gy1gznidpkuprbIFfiFvGaPKcx2bYhl9VNBOqGKP5Y+CDqxUPA
	DNp2NHZ+76qF8vCw1Ap08ZPkkkNiCd6r+I7swv+0qvONjJjRzmswrLy6ooemwjs1iKa405US5Vx
	rcIln2CgEKpUyfFiLlwmwS0R1UhbS4vNpYW6OWxP10YG5Q4vhHtNN6gy9jGxdkFiLHiDkuQESyg
	QkYSxkU+ZIDRPTqbA+Xv3Q7SjLVW2Rr2sT8v+XZN0JVEHYrjLHVq8BTYQBvEObCg8FeUyTSPSdD
	v6CCDEVI90Taaf2Yq2HMcPIeFaxu4nBC1wmP/fSE9zEI7dSjpUf9xOEKExBCpWVckcSE2Fi2Mxr
	Hqmus4hkIpsc5808Z4aqHmwuOQiQmh9/Xc28=
X-Received: by 2002:a05:6a20:258b:b0:3c3:8c91:5da0 with SMTP id adf61e73a8af0-3cf8403244cmr7730806637.15.1787728607424;
        Wed, 26 Aug 2026 00:16:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:258b:b0:3c3:8c91:5da0 with SMTP id adf61e73a8af0-3cf8403244cmr7730705637.15.1787728606953;
        Wed, 26 Aug 2026 00:16:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8dc465sm5553772eec.24.2026.08.26.00.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 00:16:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 0/2] PCI: qcom: Implement shutdown() to avoid SMMU/NoC
 errors on reboot
Date: Wed, 26 Aug 2026 12:46:29 +0530
Message-Id: <20260826-shutdown-v4-0-eb5fe9d454ae@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2SjmoC/22NwQ6DIBAFf8VwLkZWVNpT/6PpARAqTZUWlLYx/
 nvBXjx42WSSmbcz8soZ5dEpm5FTwXhjhwj0kCHZ8eGmsGkjIyigLhgA9t00tvY9YK0YKY+t1iA
 aFPWnU9p81qnL9c9+Enclx9QnozN+tO67/gqQvJ3ZALjAFRS8ZpoIyquz9T5/Tfwhbd/n8aC0H
 sptTzd9GXtGJKFCNJxwvdMvy/IDVFYad/kAAAA=
X-Change-ID: 20260822-shutdown-fe8139dff2b7
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787728602; l=1841;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=NL3e6lSDwolXTEQEXxOaRqaxbTOpDo25fI3lmsTFnA8=;
 b=GD0xjFYrtBYYo30U6XGHWU6fZK+dCfgosCsPS3QO/EWRzvF/wAax+YHPB1CUe6DMV48MS1weV
 e+XeiYcBm3WAiy1yYGhp0O99RgNmbSTtHntf/omunebG/7rcOhN1jNI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=a8AAM0SF c=1 sm=1 tr=0 ts=6a8e92e0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=TAUCERawVXn9uOooFg0A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA1OSBTYWx0ZWRfX6TA7cdobdPzK
 H68wqUU2o2DN+3O7VEop6d42GsZ2MKRg3Djf8l1a1YsS8cUl4Ty76weCYktWwhs82Wtqb832ktL
 Z+CcV+c8iNXmi/akKEbZiM8onb2KBcc=
X-Proofpoint-ORIG-GUID: fh-4GPo9MAruTYKCHnLMldspCW7iWcMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA1OSBTYWx0ZWRfX6QHGgJkB7Stm
 qazeleu6f3+YB/dSQjkG2GuP++TUlEUNvaFaEfIV/CRha3DwGt9Z5VzhG/zuV7PwoPHDPMY85A+
 oF2jsK7qNwRC8+xPraCyqQlt90VV1DbHDs+RuEDyh7N2X33bhFmHgrgJzlZMhudIDlip0f6joi0
 N1zJIhzgK4gXJ1qdSD1PAOWCeqdh/PlKf71y1B+n6S4s55X7t3PeWL586z12tTUbi0IYhqa/M5n
 vXcTZGJzFoM8HmOIuj2HkXg4lxhKJoiO8fMREidBztiSdZEypipcw2lH/iWapfQrnnNdFgMvT3d
 yJOdiX9EdxPktzqE+fw8c96folRxGQax6YTGDtdOBsZj976wuXrqE9SJYglxqD/Th1J/iOZRMhr
 tGag1pChii3XVU3wVd4MMMOgoJWvkQFvRLYa9IJFAafCo4hPbN+gSJOeF6wlVFcHgExC1jUQKoz
 iSgix12U6Pi8sMzjMGg==
X-Proofpoint-GUID: fh-4GPo9MAruTYKCHnLMldspCW7iWcMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260059

During system shutdown/reboot, power/clocks to the PCIe controller get
removed regardless of link state. If the link is still up when that
happens, it can trigger SMMU or NoC errors.

This series adds a shutdown() callback to the Qualcomm PCIe host driver
that forces the link into L2/D3cold before shutdown proceeds, reusing
the existing suspend_noirq() path.

Patch 1 makes dw_pcie_suspend_noirq() skip the D3cold capability check
during shutdown/reboot, since that check can fail and leave the link up
if any endpoint hasn't suspended yet.

Patch 2 adds qcom_pcie_shutdown() and wires it up as .shutdown.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v4:
- removed goto d3cold, (Konrad & Sashiko for PME error)
- Disabling MSI IRQ's (Sashiko)
- Link to v3: https://patch.msgid.link/20260824-shutdown-v3-0-81c14bb7a1af@oss.qualcomm.com

Changes in v3:
- Added null point check and use pm_runtime_put_sync (Sashiko).
- Link to v2: https://patch.msgid.link/20260822-shutdown-v2-0-520a68f1b4a5@oss.qualcomm.com

Changes in v2:
1) don't remove the endpoint pci dev's only keep link in D3cold.
Link to v1: https://lore.kernel.org/all/20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com/

---
Krishna Chaitanya Chundru (1):
      PCI: dwc: Force L2 link entry on shutdown/reboot without D3cold check

Manivannan Sadhasivam (1):
      PCI: qcom: Implement shutdown() callback

 drivers/pci/controller/dwc/pcie-designware-host.c | 16 ++++++-
 drivers/pci/controller/dwc/pcie-qcom.c            | 53 +++++++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)
---
base-commit: 570f7e331f5febb30f1384817463c7e42b65ca7d
change-id: 20260822-shutdown-fe8139dff2b7

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

