Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424241754
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331338; cv=none; b=MxteX5d7XXbFYofeWTHrI3/qiiuODC+LY4rHOyTWU6vUcs6HzJnNPFXGI2WnSMr7S4hXAo/xSTTbkRF1dftR+GmJ6E5aeOjWAYffd8pYDp+oZ6Laly8wvsmmW0OWY75CF/3VbuTPFn/MvWufsyLNU/zjvm0dVyoa9iy8DXgjkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331338; c=relaxed/simple;
	bh=4IBOCavmiL/zMpV41D0qn7Sb+iKJTdCa9K3O71dcDhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KfG61Ey10uNmLsxmQu30wZzvOuC76Pav4wuDcfY6cFFJbgPjLHPJSJa7uOVGxcSVCcMONi469iJ564YTa69hd2P7/clwW6tV55AaqYR61+OZ2k3rWSEEcYzVAUUf6lgbTnXaeU0KFFHSciaP9qxBE71X/XLuW/WkHYtft0P6LaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgI3G58h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RKpYbdSu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgI3G58h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RKpYbdSu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5JDhR3627525
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 10:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hofw38uOjdyJknVDS7Uu6z
	l7zg1X1BAsmLdFtBA63zs=; b=fgI3G58hvSgwX2T81mKX2ZFH386A87rrwVjdCv
	QLEi826ju6hzlmYn4efUShDAMKPRkc8xpf8ksIyuAlP0TFVhjEpR4xIx7ExsQuVn
	d1Xk7lmgUhlw1qgfcQA3D7lSXf6cUbigWWhEsigrKrE80FpTVbax6XZBM7L0kKOL
	sHwtK3U+qEVMFKY8iXrbGTrIxiuIfWIsbOkiYXwnaoXeaeMLXwKy3Y7m9dnSgcng
	s2LhV0oPqwBBt3XZsJnETvOcGDX6YLan1IT/pmNCv7Oq8vTlA0bzje3kFsvqXlSf
	f9CGXSi1AiS+PhwbpGQr7w7rW5Pnr+0D4SbbvLTdKLvwXcRg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq38w97-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 10:15:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-338c2e27430so692853eec.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790331335; x=1790936135; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hofw38uOjdyJknVDS7Uu6zl7zg1X1BAsmLdFtBA63zs=;
        b=RKpYbdSuwBi2pGEXBscooKlCL+WFs0Usd5kaO8khZb9Uw4rNrkd1W/MQnuOm1G25MX
         7C580UAI2HsoszND3y6DM1/kJuWw0Up7+PzCbz0iHcp32dDPlTmcyghIphqM/dwjIfbh
         LkkVyBGAB/10FBAzTfgXKXbKG6W9VTx+RLw5SpyVQSdBp17pPNQrJvM/sWbeLmpkj7qM
         pN8W7zqXenyqXe2NDMzqx71svnKkb5zRsUK2Df1NpXyuQ8BBuv405v+gMZprXU5kCiAb
         bvfgyeT8Z4YHF2DonpvarpZtjFaOW8brxht/3qiIvBelnRMQ0RAkoHp69YDjGyySkq3e
         PuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790331335; x=1790936135;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hofw38uOjdyJknVDS7Uu6zl7zg1X1BAsmLdFtBA63zs=;
        b=pt/EG2tJMg4ezN/Lv6QjbgVMDSzqLZHy4lM12BwJR4jRDxCMRAnv1LgEyff3vCey3Y
         J9MwegLRNC/Q6GEqYpDjNmOyD5s1v8eEVHKCnqSsFNh4xLLs2hiD2SLZjoXMpa50KH+O
         G+blMS9BzHxf8EjTxtR2AibOp80XPcJ1JQqSf1n0vz4V8ua0jBMYz/8DWl1P5EeiFl/v
         +qmx478FFnw9E8V32DJMs2tSp0QcuMFauKg23Iu743u/LQMyfGmysp2CCMV7aP84Il1A
         xN1gtUhzlXi/IxbC4lTC4WIOEihOL8bnw8EoTvfIRrkHHaDo2Sr8Zib6YcD1AUElvhx7
         7J0A==
X-Forwarded-Encrypted: i=1; AKwUvBwREOLrGy7H/tMcHgXf+TC16JqXFfziXEVak6bb9A2tdfqTLOKc8ieaHiuv6wipWZnB/Qo1O4tvp0A=@vger.kernel.org
X-Gm-Message-State: AFuF++mb4anVGyThvRV4WRJ5TVtDFEFL9wtohP930o8QPDtFwPWK2Y51
	p4SkM7/ENmYMXad34gFRt4vbwCW331vj6lR5sckWfOB08uGIuFroA5qAnjvJTs+nvsj4Kj5TS4j
	8w2sj/1zEkunGsY3hrjFGiFqJS1cdXNgTdL+ffYQi4pFK6Tp0diPZBX60Xkpr2s4=
X-Gm-Gg: AYBFou08aLPY4KEzItNZe4KlgbYVh0ahrE9mDg+sVmBGi22CLWil0geUJRuDo/dEgMy
	wVumBN7Rt0BtHPcP34jn/3QZorM15JU+pIPYwMkPq1dRUZTf32Rlx7i8KcvHz8lCV2Gb72ktrM7
	Xa27JiVmE2XZveXwbA7tmOp9QOO/Fh96KfkBcUoI8LqWjw7e+abcif0ss4U+qY/5phpJDfzackA
	+5WOij2+mSY77azjp8VsWcX61GqnRSpXTNquJeGAO9ojRefAkvVF3JhiRNaouIBK8+cyqsbonYl
	KemMiGvW5M/kbsCZCGleFnTvdVWPKF3gDxhfMplov1tfk2n0YHuGDJhFTjOXD7t14L6I7722FaP
	8/Q999I5X/Dw9C9+yCW/VUnFC1WNlitqx
X-Received: by 2002:a05:7301:9c91:b0:33c:342b:3742 with SMTP id 5a478bee46e88-341973d0227mr1336618eec.12.1790331329892;
        Fri, 25 Sep 2026 03:15:29 -0700 (PDT)
X-Received: by 2002:a05:7301:9c91:b0:33c:342b:3742 with SMTP id 5a478bee46e88-341973d0227mr1336588eec.12.1790331329179;
        Fri, 25 Sep 2026 03:15:29 -0700 (PDT)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-341451457d0sm6234108eec.21.2026.09.25.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 03:15:28 -0700 (PDT)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:45:21 +0530
Subject: [PATCH] PCI: qcom-ep: Clear runtime PM error after
 pm_runtime_resume_and_get() fails
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-pcie-ep-rpm-fix-v1-1-855d56cce43b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALlJtmoC/yXMQQ5AMBCF4avIrE1SRYOriIXWYCRoWkQi7q5Yf
 i95/wWeHJOHKrrA0cGe1yUgiSMwY7sMhNwFgxRSiVLmaA0TkkVnZ+z5RC2LohU6VZnKILysozB
 /xbr57Xc9kdneDNz3A8glPyNzAAAA
X-Change-ID: 20260925-pcie-ep-rpm-fix-b288a0b36464
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Rama Krishna <rama.krishna@oss.qualcomm.com>,
        Nitesh Gupta <nitesh.gupta@oss.qualcomm.com>,
        Ayiluri Naga Rashmi <ayiluri.rashmi@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790331323; l=1725;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=4IBOCavmiL/zMpV41D0qn7Sb+iKJTdCa9K3O71dcDhs=;
 b=VJhc4I0TBheA3EYunjvHm4gVU3/uJyIjqPiOJSpk1S66AB9Aovd/0sfMqGFlw80utyc9zxQTa
 Le0SrL3dY9nDRYtU5Larnj1q+MYz/MDn27n/L/icu3ezOQbEo6Wqcl/
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0MCBTYWx0ZWRfX5W9ibtDDPXHi
 cnc9EoT20MEG+olrWNORtc8m01VDOU+UcCVlkZhxz0dA39WYsLla5qXiVpDoRafZiI4CxgPQQoG
 CWMO1asgj14s1sXZZDkeYddUA8S1EZ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0MCBTYWx0ZWRfXx1QIzuDHE6MX
 PD3D7BMFh6uylV5yiBqwqE8uAc10FmJ+TtUH9yy7DBCnMKII3tJgwwEwnNcHhtfaQC2FktJTXuP
 3hJIAKWxrx9TX3jBqWzRT7ySK5LOk5JylYrCxvp5HZ0Bjp/Kh7kmMJ/FXrSCDnQ+VpDr2SMUCcZ
 1oeuQq+crRtSIYCLrUAwoTShVPHRSjeLKfrG2+TgS+Qo08dqifWAlkzpzhYz9pxuIdN4Jr4AYYk
 8JNb16ifph7C6lUDxuzUPT/T2R0dK2kkMfztf2+wrBL+riy38JOKnxYTxjVq4ShWlzsZHTFdnuh
 A4j9KeHYIkRohkXrxFm5EKMdJG0m/983j620nQcTi+NxwlVn5u1cDTNBrq1LV5Cn8t3EhhhQo/y
 zQVSBonyu8RFUp3n7cL5ftPzxfzinubKlF0C8OsuWdG1tzhqyqOYJw4TGPRCglvX9RBRGiG8CHS
 iGJnruwJNhBiJXFDV6g==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab649c7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=-MF1NldnQhdhfN6ga6QA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 15It9XJmVvKBHSQURzmmBAW7M8muykaa
X-Proofpoint-ORIG-GUID: 15It9XJmVvKBHSQURzmmBAW7M8muykaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250040

pm_runtime_resume_and_get() sets dev->power.runtime_error when a runtime
resume fails. As a result, subsequent runtime PM resume requests fail
immediately until the error state is cleared.

In qcom_pcie_perst_deassert(), a failed resume during PERST# deassertion
leaves the endpoint controller stuck in runtime_error state. Any subsequent
PERST# deassert event that attempts to resume the controller will also fail.

Call pm_runtime_set_suspended() on the error path to clear the runtime
PM error state and allow future resume attempts.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
This patch fixes a runtime PM recovery issue in the Qualcomm PCIe
endpoint driver.

A failed pm_runtime_resume_and_get() call during PERST# deassert leaves
the device in runtime_error state, causing subsequent resume attempts
to fail. Reset the runtime PM state on the error path to allow future
resume attempts.

Thanks,
Mrinmay
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 8364696a1b98..5a3dfea702ce 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -404,6 +404,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable device: %d\n", ret);
+		pm_runtime_set_suspended(dev);
 		return ret;
 	}
 

---
base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
change-id: 20260925-pcie-ep-rpm-fix-b288a0b36464

Best regards,
--  
Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

