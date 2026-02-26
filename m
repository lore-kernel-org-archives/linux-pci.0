Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480E2877C3
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113208; cv=none; b=oGPSiuYNX/QDNDs6SaSP/ZpZy2yMyLF0nqdcKYlzZP/7BC1CdsZUEuyZ8SO0cAOM0cxtdb3N3uF7BsUjDy0EkDlRSRjpSkFTscKWgutzdQjOIjUsFmJ/lUKZw7M3cgg+ZyKWoD+yF5gQmz7Hkoyg36Kw5xN9LC4LxmgsGRcgAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113208; c=relaxed/simple;
	bh=J62PbT+KnxTsMw7VMieKbDTerOoCCuXHu60WqWgn7yk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPbi47tLa+4ItfGaLqhEp1YJK2LRJx3/q9mY0aWs6t9/7flvItCKq9NT2ApLjpWGHDwGemTYgiNDZnaoI4vO4XWSf1IMvhyRvrJpShUHnpipRo1FNZtObQfsw3bunGQtKjFsrgDcXNZZLAl+2C1F2kzLMxSR3d8RCq4XsYsMDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4Ir3i0d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kaSCs0Q7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4Ir3i0d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kaSCs0Q7"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QAKjUC2376147
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 13:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Y+hnAw9byw7VsoKquyQktEK2L5U4UdglZDx
	00bpdQ08=; b=g4Ir3i0djJoOBbb9zyR3vSLA/3nbLNf8IORmxV4+8cvnehH/uIz
	CI7o+se6iVDu3rU7W3VmWVshOd092pN9mRA6jkz9BLVad5rsDODMSNMMJz2GZmiW
	jSHo1tq700XdvTnBQh+IJr20fHK4IlRxnBBQwCElrFQVmLm1TbCEhva+AbLwos0G
	DnTNxSuYgqf4ttcJgJxyBXgtAF9iRXPMvcnhdYghhKJwbVFMa7Nt5QHs6WAXG/I+
	+OGiISfhWCIrPP5/egrejvP50DU/M6l0/6nHY8uf616gUJsdMRfW0k33dbO8rzat
	3lpKslCHCX+5BbUI4rijEBuhtqg+5R4f8cQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjm8d8jmd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 13:40:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2addb9ba334so9034675ad.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772113204; x=1772718004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+hnAw9byw7VsoKquyQktEK2L5U4UdglZDx00bpdQ08=;
        b=kaSCs0Q7Kya1KRJyOAPkqQqXdjJaWOQVuoIyNmeot0sOiO1p2JcZfy+n9NNnUF6kc+
         aJm2WDKGSj/rr/eNLai49iAhmtym+ricoE3670QiY6kmvGvIudj4CB05P7h4kYPKtmHk
         ICqTTzFw0VmokxPA3D4PfUA7jIWeXJidf/feQPv5eNgSpQXUgP59cCd4ArDHXBvwa1Rr
         fud+4xfiTWaAX6v0xnBWv6dGdOUx5EVpJafFTi6Gb09iFCf7iHTm7P94oLFkuaeEEIrN
         55XCsmg9oZqBr3VsUOsuS1Z6yr4xNFhqvYxt1f3R8HMhU+nYAPRIzB53yto35MHRZqho
         l40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772113204; x=1772718004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+hnAw9byw7VsoKquyQktEK2L5U4UdglZDx00bpdQ08=;
        b=CMF27Q6v2o8SA5Ul6VTWDYpPb2lZyJSW14y90PPxA3NdUbNJMZ1LZ/z4MB7fyoBSm/
         0DUmqQKpB/aZ1iZcdi5kbWmK7UsHWsqbo0qIsXcgWi8xGsLI9nEzLutgwBRfJbm0VhSp
         oDQHfTmVzhlJF6nS4p3GeUXV38YeGaWIh6kZRew2EtkSTZ97a0dhMXvye+cD6IujlecM
         n1GU1euEPR8CBo/WSbiTZVPct9JdIWmFNLMl9epHYcF7rYsRg+90ZTjAQon8vmi73DSs
         BLwjuALAGK0/0z3BtjRgvoomaQ/PB3gWthcJiJv7eahMT0AshWV5pXcf7YWP7mjfGZhB
         FAOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1YN5L21WQGHpIZPUea6HYmd3ZFBp2NeehTPJzqZvSc82iYiaJRiemBGEE9KJ2Jlf7Y5amOss/15U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx25aNDBB8OOV+NEs6L7vV/JkTccu8mLbgQDeZTsiC6tp5zNx/5
	05qMM+kzHipxcTVugjIqK9ftoE039CnRSmbYF3CN/bDbFoj+vZCVKjQkdTSBX7YuBHtSfqM9UM0
	vgTqK+7Kp7Rr5j+KQ7N+68kTehW8VDZzGIFdzBqO3d6LI3Wgh68AWUVFbWbRvSmQ=
X-Gm-Gg: ATEYQzy/vDgEqDWVAc4JSWPlBtJaZ5bts4QZaDqhyqy4+N/lDzAg5ZqZiZjcUYn+650
	8+PX+Xxai8wcO5XFAkHcJyoNf9EC7uZO7vPAqyMwpxVU+Y1pt1ZmK6r0xmYfr3O4XW6cOfiZTym
	u1xaanURN37vn9SHddbB3FkhtNcWhBFk3XuK51L4OO2Cswqdx5gOHZyzAUR813iB+KXOhGvw+k8
	22nEdgIjjDKCUfG/jxkYTcDLxCW6+8xs3MI9T3w0ijB0CaelGpkJXAPL1VRuUF8Y71BNZvWpEzD
	j0SCgaK+PjpW/bRq782065q0RjHwpq5He0uFE7LLsqfwMTqVTPog/KP9CjjqzGUJP+icqB4Z+w1
	bpGXV+BcNvzw=
X-Received: by 2002:a17:902:f608:b0:2a8:f8bd:bb72 with SMTP id d9443c01a7336-2ae035d05b1mr23395375ad.50.1772113203405;
        Thu, 26 Feb 2026 05:40:03 -0800 (PST)
X-Received: by 2002:a17:902:f608:b0:2a8:f8bd:bb72 with SMTP id d9443c01a7336-2ae035d05b1mr23394975ad.50.1772113202820;
        Thu, 26 Feb 2026 05:40:02 -0800 (PST)
Received: from work ([2401:4900:8fe5:3076:521d:50c0:367d:1d7b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a03fbsm34960915ad.43.2026.02.26.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:40:02 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH] PCI: dwc: Perform cleanup in the error path of dw_pcie_resume_noirq()
Date: Thu, 26 Feb 2026 19:09:51 +0530
Message-ID: <20260226133951.296743-1-mani@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QMtlhwLL c=1 sm=1 tr=0 ts=69a04d34 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=h4SL0BZ7AAAA:8 a=EUspDBNiAAAA:8
 a=K8sXToTmQG9RiKs_eVkA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=Cfupvnr7wbb3QRzVG_cV:22
X-Proofpoint-GUID: _hHweQFjVYShX4U3pVnACcYK6c5WgE1x
X-Proofpoint-ORIG-GUID: _hHweQFjVYShX4U3pVnACcYK6c5WgE1x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyNCBTYWx0ZWRfXwjJSyPcmgFK1
 TBDzpx5K9m94r7rsOcZs56474Ga4RdTqn/bHNv51K/2YH7QrwCC1xWJBNgQrS3wJ7Ejtt7QtV48
 zhETN+zKpmUww0HkQxal4KsRvLoud5wN31TDBNjFedhLjbS7LZ3G2Qu+uWiTNEDU5AUNyT7q7o1
 9oA0QE4lkLW5fj5NM9pkYJTbSmdpn27f5kXt71yQ9sgZjgflnb5Fa8uNzAExKSk9v2xlzk78JFU
 v2W+dY5fGZaZyy0PwYskxY9U3ooiqz/8IOaG501a9+xfvvj+NX3u04BpwArnHMIfLqS8ot3Y/Cm
 rj1dYsDyVGmUT9isuit7lf+UbmjyBlOaYSr+rCODwxgWNd/RUZGRHi8HTJwRS+nbqV76PWvDNYE
 KMl+mFMAQxf7j47H27dmnBF4cidCaTc2MRiJnvSOUwQbNHm4KnRACk1gDxSQ5cw06n4jOfbnvRO
 CR7VUtQE9ewrA4Byr8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260124

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

If the dw_pcie_resume_noirq() API fails, it just returns the errno without
doing cleanup in the error path, leading to resource leak.

So perform cleanup in the error path.

Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Reported-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Closes: https://lore.kernel.org/linux-pci/78296255.3869.19c8eb694d6.Coremail.zhangsenchuan@eswincomputing.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ba183fc3e77c..a74339982c24 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1304,15 +1304,24 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 
 	ret = dw_pcie_start_link(pci);
 	if (ret)
-		return ret;
+		goto err_deinit;
 
 	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	if (ret == -ETIMEDOUT)
+		goto err_stop_link;
 
 	if (pci->pp.ops->post_init)
 		pci->pp.ops->post_init(&pci->pp);
 
+	return 0;
+
+err_stop_link:
+	dw_pcie_stop_link(pci);
+
+err_deinit:
+	if (pci->pp.ops->deinit)
+		pci->pp.ops->deinit(&pci->pp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.51.0

