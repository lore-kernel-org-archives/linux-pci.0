Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31851413D82
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846258; cv=none; b=fNonUD3nUJAWd9e0FC2tw1lrIw/VKLzqU9JDyJrh1BzEp7mcplZHOOInAhP0UwXUWnf5LxfkPySe7i62qkwtraU342AkvCcO9QZROQxtfw/a7EBcTtVngiJLLhk9Nyp2hMKCykis6j95PzywvCASlIE9i6943+RTtrlcbkQvlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846258; c=relaxed/simple;
	bh=RTnxmJmcXqptIc1CpIlZkuSiZ1cZFh1FUN601H5hlC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0UqsE+1sScI+ud90Na8PzXd/gWO6SdCZAXWw0oUwP18koRKrsEKnSw0cNKUSPwBmfM89VpfkrhUc1GqMMpa+jy2DhJP0XUn1Jrqh7ezaotfO99OJMzjv32jNGfFUpKItEIYPnNW4x1R4ekCXRFaSjqztSbzndHLXMYX/YbHv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fxcnZ001; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S96URSZJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fxcnZ001";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S96URSZJ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UI8avH2721561
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S6Y7YhobAf0BVh62LWHOQSP9ynKHGLmfRU7MX9qDErg=; b=fxcnZ001O+ruLVK0
	BXa5CxzuAefjhn7iYYCvlCwtrsEk0blxOXoLg9y9bd86Kxk4dyXqoOuipge7H4D9
	wxZrY71mt5uXx2OH/aaazQsa2zVvwd/wnLl4Ic06+MGJLbD1t+H3ocZ/8kQLLlfW
	0ThzjGa8xmIqLPprp5RdLDXM/onc3TJLxUDBFnWHUSLNz39/B7B8pZM7D2h+lgHt
	dm9YmyM8p3jOBJ/NNclZzLITV2XXim1sU9uRGwUNBZFss3AUeHVb3MEMJ233DieU
	wRVLPDrzPzCa8m0nPAEdMS593Ic3SQyI0vQ4zmKzwyCXhEqDGEfP5PimuHfs47ON
	HPosuQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqg8th-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 19:04:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30cb5001ed8so129165eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782846256; x=1783451056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6Y7YhobAf0BVh62LWHOQSP9ynKHGLmfRU7MX9qDErg=;
        b=S96URSZJgWeNbYCISnNcwXo/oeYCTuVvlFHRLkdG/2RfEP6tfTCHypaYkSJYRJFnz0
         pikrvi7HJwLmdunp8HJB9M2NtXW48ouATp9inbty8oiDh01ckQK+ITPHrU1Oe1HKY08X
         OnsKURk3jVRQ0tkKvSvSssKp1KIefDDCpesTBrul0kGYhIyaYAKNfnqy1ZH9RhDm2pJK
         EY7lwnsGhUO5558bFGWtDkNTu7yRX5NfEIbXlPOGSQg4tvPKXqt2HN1ZrgC+fjBa1ZLF
         lzA5/iWKNx4dWmyKOPPHkoAqjZ3Qpw87p9mKMoaC6d4SS8Fkl2w88teUuVsITMgm17rq
         Et4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846256; x=1783451056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S6Y7YhobAf0BVh62LWHOQSP9ynKHGLmfRU7MX9qDErg=;
        b=AgBWyxv5lYFAoVR5ekaG0jzn6Wis5G8CrAbMHPmOnm7uzr9C3ndaTGzNbc1bn5re29
         A6/5hCASLUAewb8kTkeQP9XWWXsaJQZZk+u/88800fnJ1pqed0GG1ZbHNReDQoJrqY+E
         WT2a4OVyfWjMak6amPE+m/zHJmSGKP1oehXs5XZ6k8JD0VvMUQVpbkt77mPswmy7YVX+
         AE4iDxbPI9nIshY4nl1vxUn4bv22MXkJvYkz7lbmOqXZwAgP43/fVXcf/JCQyWMedRDM
         QcyhI8maECW1RxKRjXZ5MhxBlfTuLgMFvPzxZUc2OOH+epxbm0JAVw5XI3AF0Ga1LcWm
         Ulgg==
X-Forwarded-Encrypted: i=1; AHgh+RrlXPMqbyaDi+vn0SSZRr08NEw8mubhd2Ya1kcctbHOBvS15iRqzzjUSoF5t6oa5MDAf0KLwNPzEEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9SnXHQRUMBlooMi0K7DDFgC6CMjmfuU65SsaeF5iQiQKiYsOG
	PqEZKFgzTDry1WehYz9KzQu/ElvhMtjQr9LKFozG95UNqzCdRf4E7KR0h8t9RzrI5rY4EdffrfG
	LMxVAHXBZwXNK4Nl3LEMlxFlXjr9M8jKr5OrpWfFY31ClESH0kGG+/DSeXkLiPss=
X-Gm-Gg: AfdE7cnvdBpTP7thgP3tmxiILBxd1FKZvD/Jx465cO9vXSe2yXvFmBVMEihO8b11BQ4
	QNAeyydWP1QLnUThEM4mvgGMPft94eNAA7Y/SxCDtNvaLi98gbUWmOBoZy3M7waY0D5Ryx3usp+
	tdtTCBsmuQwBEGpU3593OPmrh5z+mY9UfP3dcdrDZuHbsskuV/+OomBMd/ufuCtVDuW250PN1YP
	zsG8xOxiFOWWFzrtFk13DxJc/kFhGYudnQI3WxuGa9a9z86TzE9h1nPvqHuAZINzTZ/MVQeiasi
	F3c+M97qyJWJ24hrrs0ONL4ASz7DSTO/E83fGy981KDdAGRQ0ilRyLpKvSGVJ4H8SyXCxnHgro6
	PstF4OrjuqQCNQpw9OtfVRD9lw4Sf7hxbH0gUHHO5YGJZsvk=
X-Received: by 2002:a05:7300:57a3:b0:30c:23ab:b7d2 with SMTP id 5a478bee46e88-30ef0975166mr1520406eec.28.1782846255673;
        Tue, 30 Jun 2026 12:04:15 -0700 (PDT)
X-Received: by 2002:a05:7300:57a3:b0:30c:23ab:b7d2 with SMTP id 5a478bee46e88-30ef0975166mr1520344eec.28.1782846254702;
        Tue, 30 Jun 2026 12:04:14 -0700 (PDT)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee317095dsm14963815eec.15.2026.06.30.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 12:04:14 -0700 (PDT)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 00:32:51 +0530
Subject: [PATCH 9/9] arm64: dts: qcom: shikra-(cqm/cqs/iqs)-evk: Enable
 PCIe PHY node
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-shikra-upstream-v1-9-e1a721eb8943@oss.qualcomm.com>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
In-Reply-To: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782846191; l=1973;
 i=sushrut.trivedi@oss.qualcomm.com; s=20251127; h=from:subject:message-id;
 bh=RTnxmJmcXqptIc1CpIlZkuSiZ1cZFh1FUN601H5hlC8=;
 b=H+Moevnq+AybpYWzC/36+UGo9gtMkD6aY9ze/Ewovw2zgrcI8aCNgiY2Gku5HmDaOD2qP+Ot4
 qWwR9iSiBJOCnJ4ToDj/gO5wgkYZBE/rhbERXLbAk24+D74dWgNVj9L
X-Developer-Key: i=sushrut.trivedi@oss.qualcomm.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Proofpoint-ORIG-GUID: WXN4s2JjBrO2B3xnfqFvgdPNhn-Yo1zi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfX6XAQ0/F6/BU+
 AtVvAzoRfcO0fOxKbDViY2f78OZ1b94U5zJNT+Szd/ZKu3W6dgciHjQN9il5QZO6bZhjE+cw9+d
 x4WRtUhh0wWhyOCsYlULY0tAfQHXrpy5FC8ZFh4FT6uiKXWHtiA80GBMwyZ8My6HjRdMc45mr39
 LB2oGgEAjiUpRWl0aNsqQhkSJsLxf7AGbnvekEpeaC5khuiE2UJ2jXHz7b4kyM/76ZNuJWunT9x
 ksZqCQCZCjkUj8/AT+TR1DQBkEiAW7XFzsNhuvmksZbyio0mUrPZDsoeQ1/1fxm3wxIDeS6Lwwa
 G2OAZwx27wHBErVKwkjhM8Xo6MwiJaHq/ajURZWWc/oWQ6AFSAmr0hzriim69HkV0CwbUDCOcwi
 Lq6azZRW+aqSyiES3W+M0K06QPo+Z9TIl6uCrDY2/NBqkTBDSBxI6LYie0+Uek7Qt2DTWP8T6EA
 1N9JFUgizqpoMAfAvqw==
X-Proofpoint-GUID: WXN4s2JjBrO2B3xnfqFvgdPNhn-Yo1zi
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a441330 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Dx0sEE52Z9zFkSaW5IkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE4MiBTYWx0ZWRfXwBybrRL1tYJA
 f2ES/MIxedDWeTdf/xD6NnhUaMfU2CVZV8e8OL7lP6IRKV6pXNMbL8O8G7gizjMLUTU4M7/MYuA
 k2ePEYUAhxeToMnbswf8b2wbVK/FcSg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300182

Enable the PCIe PHY for the single PCIe intance on the Shikra
CQS, CQM and the IQS platforms.

IQS platform uses a different powergrid than CQS/CQM which explain
the different PHY supplies for IQS variant.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 7 +++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 683b5245923b..06ad32041546 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -60,6 +60,13 @@ vreg_pmu_ch1: ldo4 {
 	};
 };
 
+&pcie_phy {
+	vdda-phy-supply = <&pm4125_l13>;
+	vdda-pll-supply = <&pm4125_l9>;
+
+	status = "okay";
+};
+
 &remoteproc_cdsp {
 	firmware-name = "qcom/shikra/cdsp.mbn";
 
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index 26ff8007a819..e467c46a55c0 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -60,6 +60,13 @@ vreg_pmu_ch1: ldo4 {
 	};
 };
 
+&pcie_phy {
+	vdda-phy-supply = <&pm4125_l13>;
+	vdda-pll-supply = <&pm4125_l9>;
+
+	status = "okay";
+};
+
 &remoteproc_cdsp {
 	firmware-name = "qcom/shikra/cdsp.mbn";
 
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index fd691d53a0fa..a7628443cb36 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -68,6 +68,13 @@ vreg_pmu_ch1: ldo4 {
 	};
 };
 
+&pcie_phy {
+	vdda-phy-supply = <&pm8150_l12>;
+	vdda-pll-supply = <&pm8150_l9>;
+
+	status = "okay";
+};
+
 &remoteproc_cdsp {
 	firmware-name = "qcom/shikra/cdsp.mbn";
 

-- 
2.43.0

