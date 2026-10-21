Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590708;
	b=v9swFwTwLeXNiHaT5vaJL1q256pp+cSsEF4fFwJbawty/5VM6R8t4Ni84q903rtuEWMk
	 oPBjQ3budlPFKSw2XOIjTCKslcpHgM5SS8BUpHDG5Mcaj4ZhBR3JBHRLu22FCrO5CIGtJ
	 mMIkO7fl4VV9gJQliQm5kTP+sXbupz8NNYAp1zrZn4uoHIP3E5gccr7fYM0SCv9wY22+b
	 lmctRN0c4jZ+2sgl42vG/au/dfFJVPnaLzlEgaJ6oOAYsnmoFjJjPJ1ggs0gqctMBMF4n
	 sR+eemyaHouLfLRhx/vUjLtfUJmpOhe9ByXOXNwjqgM1zwEqmVug61OVd3THiVYIVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590708;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dVWsWBCRMZYjSHMs8vlsyzTh7G+H8wKUyi8fgvNpbTw=;
	b=x+ejskUamVT+pg5S3Lj7nXg28T0CiV3QHStLVOwG+R8ulvLSqpjNer1qHzlEwbzLDfuz
	 M1kaZpz7y9uxbYYS76cdDyHd+IgmvmIm2UVPp3QyOj2B1mFPcHwunFEsjS1PU7fD4NaLK
	 zlhxJQb+yPqi5mzgsfQ9VWbehj/8+2NebdMhWD9lY3rGCsep5o4YUly6CCU0hjCspKo52
	 PQ9iBDo033FeeBQlQ469bKECyOfQqeLVUjO1CKgF69J9D7k15mAOdsU9SopnbYyrJ10Gz
	 sfBJBMiUSvWvwoMQAmL1TqJBKBqwkEnP5lMjH7qV4O/TBR0/fwVEyoY0gTkCSUEMvzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XRpM+auj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N6Ak0N8X;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C460A2607
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 473C460A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XRpM+auj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N6Ak0N8X
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBfw4r1599787
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVWsWBCRMZYjSHMs8vlsyzTh7G+H8wKUyi8fgvNpbTw=; b=XRpM+aujYckvOMNn
	5+yu0Juc7EZshslGjkOahJVUO3kw+BGJJapxZTP4nzSvjnpdR2CqwSBaCJkjiJzY
	LhN6m2vUwjdUMpCnIS7Aj59CtnYdIAxyfiXAOgyl0o99la7byAKe/Tg6z7D/MTqt
	Pc8G+pcgwp+za4Zdt0moTyIoD3pa9uUG9jopZx18l6E+uCBILuECexSkucw0QDaU
	fvjBNP9ebEOflRjZuVA0bzlwIaWNUvkA2i1QPFBAHyAkhhHiAhZkLan92YgMXpKY
	y8WAdunXzmyd+DodUh1xg1lg4BH0Fku2s55XVePcCwKxxtCgdXnt5PhNWy5Mtbyi
	jLww0w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heuhugspx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35a04491c56so819198eec.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590707; x=1793195507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVWsWBCRMZYjSHMs8vlsyzTh7G+H8wKUyi8fgvNpbTw=;
        b=N6Ak0N8X/KfFSyA9/PFHAryf3Rltd/07WSOoVG/lbuu6WM2NuiX/sSkZgBRV0aKvj9
         /p4MLYqELiZmER9HN/ftkyMJiWehdJjLmiQsWfNJAWkUCB9g6Z4fh7390bGGsbUxyg8N
         TG9MpRKzeeJGqBHRiugjTgQ222rygcxb6ujXEa05kzMmtVwmXPiLegLPaXJBnciX7JvT
         ximpuTFK6j/yi3VEgKbEhQi+0FBUY+ttCXXyYBklPrcdoLgdJiraJtYPgaSvat6grwTr
         9Ulvfxb4MtjgHBxWtpiDpC+hinesN3DUKob1AvMYuKKLY7zdFjqMNG8gk6si2c6oFDMQ
         tRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590707; x=1793195507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVWsWBCRMZYjSHMs8vlsyzTh7G+H8wKUyi8fgvNpbTw=;
        b=Rfz9nn32/ngEjbB+l9Z/gvL2BjC7T3MFLEdrSbnSo1eTCnQtM982KL1kusjYC6uy1R
         iBs9DE+ER13CxbIqGjiOrNsmgB911rhE4rW7Fh/QDZpAVKzvFBm3VhkVtRcig8uyTK24
         oA886zHMIpilv7mQmSvVPQc1W2cKf37mp4VU/QHAAUec74nLFn59IARugdAguEkVApBp
         v16hzCLgUy3RQmzT6jQ1lvKXWb6kPRpqtq8cELWP9OVr4lV5Hq0hoehj9KOSzMX9maXa
         iQ6+nyIs3gledNzXggnX7spmT4Pi1WulRXOKQrYP6HSHdZFD6rH2WIhh698eKn0BT82h
         nZyg==
X-Gm-Message-State: AFq9FYK4Q9/UH0fkomta7tjhT8frnY3NAkEjK2xysoAyGguMP7IVcNHz
	ijCC+Hawb8Z7pHC0i4BeFyZ0dq5niViG9KKl3uqcvoHCuYmT8MiL3iAU/73JZWbyP4ADRIFLvZA
	+Jnb1IDX0z1C50XuMeBP9xtfMiJNcRIEPMucFGUFTafzNl0HKzptN1Vhpwm6A6PwjEuMXIP0=
X-Gm-Gg: AYBFou0q42A2aS2Hd12C09/XBa+oOvvXRcZv4wm4tbckum450v3n0xXBnf8SDM9lJXh
	MeN9849pjeq1wFWRlS3iPTBn7p01Zk4ik0ZElkfP0xC0Ehgm3kSgJvFbH3i3wGP3TxcDf0DZLUM
	9koeV5eLeA87cbSUd5eM03lcfuZT/98uJfpIDjtCRLdh9Dv0uMc9e0sby5QV5Mm3+NR7LKaqv0Q
	R6TcDoIlvYF4Yo+LTK+s75gGY1orRDbJamiA/SfynQPof+g+nV+eBKcVMy70ZP1jpOk73RnB9s7
	gAP3LpEUu41tUYiLflX2jf+i3I3ZoWvbCGcC+M15/t+wngb8yTenQp3wbTCAGWNn7/4qyM1WBjs
	fCksTg+UAAGndetHN1RSGDbtTkn5GekMIHQ==
X-Received: by 2002:a05:693c:8801:10b0:353:7f47:8168 with SMTP id 5a478bee46e88-365fb187594mr6216825eec.17.1792590706915;
        Wed, 21 Oct 2026 06:51:46 -0700 (PDT)
X-Received: by 2002:a05:693c:8801:10b0:353:7f47:8168 with SMTP id 5a478bee46e88-365fb187594mr6216804eec.17.1792590706367;
        Wed, 21 Oct 2026 06:51:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm7534332eec.13.2026.10.21.06.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:51:45 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 19:21:24 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: glymur-crd: Describe the PCIe M.2
 Key B connector
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
Message-Id: <20261021-pcie6_fix-v1-3-ad37134c35a3@oss.qualcomm.com>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792590686; l=2234;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=N4sUA81o0uvR6JdRpINVUf4MY/Mr1oj/T6BQ1Wygh9o=;
 b=Mdyqv8Zf06NuraQphLE0x8nVr/anXhWSoGzD68/+GdqDV3SEHuXyw0N0AGK6CGE3tJDTk5X/X
 0f1Bi/Acn5JCklLc75L4R3KL1umI5ACEtsxpwIhEWvgWEfm5OeQcGnm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=d4JgWhjE c=1 sm=1 tr=0 ts=6ad8c373 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=bvY3E1ByFFb03tV5gjAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX2kCRQp1oT/mh
 MR4vl54526fQJ0VRYIUufFuTCE/YMQ/DOUhWzpXPl5z2W2H2eJp8KgUBH/PbvBjj0btaVR8HxTI
 YcX2KQ7IrGzN1jItIBrjWLPqZk/hPMg=
X-Proofpoint-GUID: tJIn03K8rFAcL2cVsK4Bg6QHXAMBQ2sb
X-Proofpoint-ORIG-GUID: tJIn03K8rFAcL2cVsK4Bg6QHXAMBQ2sb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX7ZvnFfHbcNW/
 GM1Wd0rkRnztN8JrJwYOU1an8JEcXiyEWA5ipxo8Tfb3NJk2hYTHMp85Y1gJ++46cp6qeQLHh0A
 G0/MShypzKyUIGug1cNuRukUDDYQzEvrW/ZyEDOtjJ8NAl7XFcETQYKdq1EfUsGJziRnbrDdT5O
 /wYBbff40DqgTXfFCtE8L1kjNgLGymIPuercLavfu2tf70p+q56Iye2jZf06wfq3MNAYF+F+OJ2
 6hddwxdV1imKad/Jzfm1C6/F8xhb2RqIIpHKKfNrMOC0qHSaR50G+Oxg7EcMn06nPrPYvVPeBKt
 QgNJTc4Rvb/51GPONXtj4VRqXv3I7mY3SvXf3+6kYiQIIwGX77/z5kOkjYDOfjaeexB1iUoameP
 NNhBqtfmOSrOooqC08z1XvlncM70fIEvm2Kw17G0+qH1kqvBadBRPzBUbZ5TSjN5IAtOyaitDtt
 CeErOwa6DbfShdPM3Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210055

The Glymur CRD has a WWAN M.2 slot connected to PCIe6. Currently the
vreg_wwan supply is described directly on the PCIe6 host bridge. As a
result, the supply follows the PCIe controller power state and is turned
off when the controller is powered down, regardless of the requirements
of the device connected to the slot.

Move control of the WWAN supply to the generic
pci-pwrctrl-slot/pwrseq-pcie-m2 framework. This allows slot power to be
coordinated with PCI device power-management requirements and keeps the
supply enabled when required by the PCI device, such as for PME-based
wake-up.

Describe the slot as a PCIe M.2 Mechanical Key B connector and link it
to the PCIe6 Root Port using a graph port/endpoint pair, as required by
the pcie-m2-b-connector binding.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index e27c697e3170..73de60b0d0e5 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -237,6 +237,27 @@ vreg_wwan: regulator-wwan {
 		pinctrl-names = "default";
 	};
 
+	wwan-connector {
+		compatible = "pcie-m2-b-connector";
+		vpcie3v3-supply = <&vreg_wwan>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				wwan_m2_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie6_port0_ep>;
+				};
+			};
+		};
+	};
+
 	sound {
 		compatible = "qcom,glymur-sndcard";
 		model = "GLYMUR-CRD";
@@ -810,8 +831,6 @@ &pcie5_port0 {
 };
 
 &pcie6 {
-	vddpe-3v3-supply = <&vreg_wwan>;
-
 	pinctrl-0 = <&pcie6_default>;
 	pinctrl-names = "default";
 
@@ -828,6 +847,12 @@ &pcie6_phy {
 &pcie6_port0 {
 	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+
+	port {
+		pcie6_port0_ep: endpoint {
+			remote-endpoint = <&wwan_m2_pcie_ep>;
+		};
+	};
 };
 
 &pmh0110_f_e1_gpios {

-- 
2.34.1

