Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7B39A819
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284044; cv=none; b=eyH0175T/IBu3ZGtED2kxgau2iEBbBfneC3yJK167EJ/mjQMKqXtV4gc3orehUwXkk45vDztDnOwMnps5LX6XD9VbrKUKg10qnq8M7izlqdM4WsKhwYQpi0Cb7friibdd8wqas7Cn8Vd/1iM11rpngEGEZSlZk/scuI+boEIPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284044; c=relaxed/simple;
	bh=kPs0DtXG+9QUrv1Us0pa6hxYPDLn14oG/QFMp/cxXH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BneYe4MXNUMRUInZUOHzeR+QbJnefGXcAjQtvQUCaEEU89A8X76HTqQNYeLMI0r0tCGs7S6s0E0vlbDK06KGOmUn+31Non1ygy97TWs1wuTWJ4UQwg32UQe8ke9/lLYImb+wN+XjRQCech3tu9QecWzZznR1uhZO7W8I3qkyHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jx8R7AvC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YSH0nGWF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jx8R7AvC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YSH0nGWF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153e2Y62158111
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2026 09:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lvQdTkGdnJIP/VHAznG5qfzYCx3k04ZHT1+
	Hz9zICkw=; b=Jx8R7AvCqo6p+3yMJ1wn+YrNaTSjHpV02CqXd6EcGHVAOp0T4WW
	s0pYoMubHwMzR/LobBnSpaNU4QF45LUw5UVv6pngG2p/V+qj1AgWvog1JLbYQWiE
	0doVzeFUzMHQdbC/oIW78o8HMhihs5Kvnfzp4Z+XHPSO8dGCmru2uWhivNSb5BnL
	1YZ+YaY9fo/KvA3y0/3u8t++2DJ3/P4eKYamqgHKgO71Kga/z7cZqa8ZpkGKYdU2
	Yf5JWj3XOKMFP5BRQPuuJWvWV260Z9NsZerV929KGP5yqNESTyr1i3TACY/JpCpm
	L7hjzocIEoBPWXzxxcha0HKpc1QxIkJwqnA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4gynscu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 09:34:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8243767ce2aso118448b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 01:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770284041; x=1770888841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lvQdTkGdnJIP/VHAznG5qfzYCx3k04ZHT1+Hz9zICkw=;
        b=YSH0nGWFbxVBrJXZ5UlPgtbRwPs7J2hgYsYZ2slaIU9t7USppIBWlDDi8tkQeKsv2g
         U1BvPm/9AgBOhSn3HzuPiCmRrVQwSGcpEOUSuhMXhSR8j9A0srw+Xe1mTZKotPz5nIVB
         zvYLfY+Ml5F5f30KUN6BDzal13c6nG+9C3gjhwgiXcWS1GVefReel3JiNLAFpOwfENKf
         2FoW1Jq4tRiCny4s0qzHs/wiQsDEFYyeai7O2tCNtGuPktEgl8YN2Gi8IY8qwjhKta9G
         Q4p/1gotBKPzOzMsvvK37Z1I1vYHTAJ+RHroe8kEOvDCTD1lBNsPsqCyFD4Lht8IKX96
         xIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284041; x=1770888841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvQdTkGdnJIP/VHAznG5qfzYCx3k04ZHT1+Hz9zICkw=;
        b=c3mYvqSwVxZRZDiuGmSoNXdJ0ckkRynL/KVafzZJtqFe+11JYh/0MI35JXTfUhvL8C
         R7okXdA//C+J64b77tfBJM7NyxHflZeSERaqoMfFqDvWVdDDCdOQUlkIxnhTWU0QsvEj
         poi847hUqjcnu/NjXHApQHcxjdVRybSQA14G4VvwwgKI6yfnMGZ/WJuMiIMYYj6bxBxw
         g0i76fI+ck2hFljHNcUAp6TkxVKA7HR7iHkO+QCHy7tpQ9p8l689iM2TzIVLKwWjeyfQ
         9Vl598hLME/gYZIPhYm/2P/SUYIe4JXhJNP3ICshBXgorHpLT1b0YblaWavihS8J2EiX
         R1kA==
X-Forwarded-Encrypted: i=1; AJvYcCW5NTIpcnZo4dq9I+I1UzuKF7zSPK9EI7BAZVfQUp7pwi61Da4BtbjkZpeG83e7s1dnK0hOxr1vK5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfqUDgUOmae2HSOOc4HFFAAMdQSKalCjQ2433GrFQvdPfWg++d
	QZE0GcJu8FNCe1VvnngFGaey+bevTlZ2Yl6pdtLiHy3Uw+vlQAODP8jnLJ/HQOTN5tFnfgOdO9Z
	Khl1aNfOFygaokwHI4pm5T0YBXX7aBo6cHGblJVnlT9YEIUc/++fkfOjJpMnLOm0=
X-Gm-Gg: AZuq6aJpIBJmAv1hD00qzo0N39yjm01xLNiXpk4VHPAqyg8w57SEeNKlgzDrB7ieW2p
	Kyscg+Y00ueKYH2idO8RMw0jGpRwAsg2iTI/Bb5zIgZOvCWMQXVGSHBeDFKNAtsd1SH7XFNU5+P
	ujcC+GlsgRH8yW5W0qoei5ILicUT+pAzzuxOnVwYhrcAF4xVzW0NIokKHkAW4QNlVuSO1Hfzdz0
	ZaUh4TdBBRSpVPRF9JlqwrABSnqdKb1ao5ADf7pNhhKO00sOlHm9RzyjYE4MSJOUSQCN016v5gq
	PagyhQHlLnfnObwzo46ugeSSVLQEDm8zqg9FfC/8gm0E2Y2XJ1T/lAYQZsERXA2fo5V6UlZ6Q44
	GVFNhvgQLH+/CQ0fscgz3hSFs0WIjccbrG/UACqajEEMd
X-Received: by 2002:a05:6a00:4b08:b0:822:abcd:db0f with SMTP id d2e1a72fcca58-8241c64fcf5mr6075327b3a.52.1770284041451;
        Thu, 05 Feb 2026 01:34:01 -0800 (PST)
X-Received: by 2002:a05:6a00:4b08:b0:822:abcd:db0f with SMTP id d2e1a72fcca58-8241c64fcf5mr6075305b3a.52.1770284040974;
        Thu, 05 Feb 2026 01:34:00 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d487886sm6181538b3a.59.2026.02.05.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 01:34:00 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, mani@kernel.org, krzk@kernel.org,
        helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, krishna.chundru@oss.qualcomm.com,
        lukas@wunner.de
Subject: [PATCH v4] schemas: pci: Document PCIe T_POWER_ON
Date: Thu,  5 Feb 2026 15:03:46 +0530
Message-Id: <20260205093346.667898-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA2OCBTYWx0ZWRfX6P44rX4cNiU9
 9WP5PBlVqGYj6Eo466yWj0Xe59smxGHgdvuI4syjMkABrFXS8AiCYYqqo0zG3iR+TvGrh0OLTvP
 JTpaQ47EsACa5sSMMuib2+TlzCTwWqVDkHtxO0q7XzIvNs33ltXWOMgLUZC2H0WUcSi7uaiNhL0
 SPAX3BDp0Rzkdj/pJ3iuPz6N/+KkfpV9XwKMx5dkpBcbJJqi2h5CkudV3RAZ22I3/M9Z/5W8vMh
 dGed+UwRxOaeIDprBDszbmvg+HiraVWYbHG+j0DaVn0UTgl4d4G0c2aGAusjVzKuNaOD7EQhL4E
 Mqw8lLnYfxKm70+hCZuzryKI95KkXwpg7G7/8SjU0vvz2mmFxrFLs4cN5DnN66l1+zAH3ZQIHKw
 A4gL1k3iUgtdxkMI/Fw2oM1cmcIVygorMbRt+52vZbm4mURv6DPKyTa7CGJua+0Xa4tsV/xKNXd
 pSll5AO5cUzXExrsGzQ==
X-Authority-Analysis: v=2.4 cv=GdcaXAXL c=1 sm=1 tr=0 ts=6984640a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ji1uk-MP7uB9YWhOYAAA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 4J1fu7GE7aS9ZxkIDKAnKxki4TFAmwm1
X-Proofpoint-GUID: 4J1fu7GE7aS9ZxkIDKAnKxki4TFAmwm1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050068

From PCIe r7, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
minimum amount of time (in us) that each component must wait in L1.2.Exit
after sampling CLKREQ# asserted before actively driving the interface to
ensure no device is ever actively driving into an unpowered component and
these values are based on the components and AC coupling capacitors used
in the connection linking the two components.

This property should be used to indicate the T_POWER_ON and drivers using
this property are responsible for programming both the scale and the value
of T_POWER_ON to comply with the PCIe specification.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes in V3.
- Couple of nits from Mani & Bjorn.
- Link to v3: https://lore.kernel.org/all/20251126103112.838549-1-krishna.chundru@oss.qualcomm.com/
Changes in v2:
- Move the property to pci-device.yaml so that it will be applicable to
  endpoint devices also (Mani).
- Use latest spec (Lukas)
- Link to v2: https://lore.kernel.org/all/20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com/
Changes in v1:
- Updated the commiit text (Mani).
- Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t

 dtschema/schemas/pci/pci-device.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dtschema/schemas/pci/pci-device.yaml b/dtschema/schemas/pci/pci-device.yaml
index ca094a0..a847500 100644
--- a/dtschema/schemas/pci/pci-device.yaml
+++ b/dtschema/schemas/pci/pci-device.yaml
@@ -63,6 +63,15 @@ properties:
     description: GPIO controlled connection to WAKE# signal
     maxItems: 1
 
+  t-power-on-us:
+    description:
+      The minimum amount of time that each component must wait in
+      L1.2.Exit after sampling CLKREQ# asserted before actively driving
+      the interface to ensure no device is ever actively driving into an
+      unpowered component. This value is based on the components and AC
+      coupling capacitors used in the connection linking the two
+      components (PCIe r7.0, sec 5.5.4).
+
 required:
   - reg
 
-- 
2.34.1

