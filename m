Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9E4756C9
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401958; cv=none; b=GetYwTja9cCxDefBfh73gOd6Sv2F4Jg03eJAnm2csyJ9E/b6e/hnwowGGNb6QKJL8D83wv9jdnvJynwkr6XXODgWnFaYSOfC3wQXZZUgw0Jh6V8d/9fx1lXhh3M8THb6SggSf04unJPihE4QoKnSo8uCdfpcQAKOR1N2pQVXl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401958; c=relaxed/simple;
	bh=lXeO7bP7idTFtUBzuKbosYtATj9Ndsw4dWgt9vtKsn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjMVi5ZUY+kctHe3omrCavrJAHU7aJ3pOvNqpI8y+JU06fklqgp1iIsMooTAWZeWYgPiwt9aaDCdI0bQbDu0rqkIFLPhDaDRj/rRYfOfb8OBQfuZm29uCWpsWzN2ySmnruDXMFqzpxuW8JLMqCRHicd7pFhXyYRWPs7gbUv5hrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d2FkTV8U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UJanArfc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d2FkTV8U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJanArfc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8YiYQ2688732
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZqNPgcDIDE6Bp0KwMFBvoaExUNRvYuzoKfkIwpxCEXY=; b=d2FkTV8UHXYJiKNw
	Ic9Nf4JeODiAasoFzuWwMZ2q8POGB2MzoXGNxB2LPYUEOcr4YLnaGALtx4pcLPkN
	RtHQiq/SG4xwaloHlwNIRjB68NhAs56o7/1RUAoW2mGs8mtSU8JnPkTARPN9vmjO
	UcvO4SuZHcXwkRDGanA+2h7XFjbIp8qVRWAaOKzfK2vwNj22ILXzmGBz3n2KfMtb
	EBColTIxKBUewnNOgrbMuBbWA8aP6VY6wmYNik4x+zydgu6hMEWfVH74Wme61ZM+
	x8inA8KSoQsiv5k/j/zb9O7klTm/OKORiVzSppyClc9dsofQHonk9WKoGqb2Js6Z
	n1PQww==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn06cu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 09:25:55 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1663fb7e005so2162104c88.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401955; x=1793006755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqNPgcDIDE6Bp0KwMFBvoaExUNRvYuzoKfkIwpxCEXY=;
        b=UJanArfcctal/2vnX5XxgRfKPjC786lNL+H479l1RmwhfRAFtvWqr02swC39XrKasq
         rjFqf0KrPruLNWxWxzt6crURX9nPIDjDZWHSZf7kOtKKHHNGJVrMYtAGJvj3ydpKFmSx
         WwsSi5aIwLdQdIaAcFmmhpl6BFrphKa02TVgFiLcHOoxwwqijCZ6CHu2mOvhPF/J6Ufx
         jVpRj2n8J9V7c+JfxCUhgbcVcD+nXB66K5AogURo6BcT4U6h34lCJoyV/9gHNt2mUC8R
         enZU+PjOefS8JvIgqtuM1EgRWxVkgEIuMitVNGzN586vfsqo+4Tnb+khUap+1FOM7P8u
         P9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401955; x=1793006755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqNPgcDIDE6Bp0KwMFBvoaExUNRvYuzoKfkIwpxCEXY=;
        b=Bur2plZJev/2BLQAj1BRNDIri2eRxvamQ8DNt/GMY/3PN8NiiOHm/3saX1/KdQhvpD
         QUYe1mpkEqDSUF7yyMS96NWpDG/zivfKDuT0ka3lgJNXKJcZckJcvDmW6GKKbDa3A8b9
         wzcwlMCapYAgV5cyUs6EgfhhuDng2k1a3XY5Ud/G4SCPEYkN04KRLuXdcHRjCq53h7z/
         XAMHGBLNmCwbiPFGfnjOhG4G7UrHJI/x0920fIRBJGt226G/zhnOrTihB2E0uzxR94XD
         AwwYL6V+7pAo9tCMXw4fhGinFVxL87ndshIS47gtupwdWFNgjAdWVmyNUFhWHfrdbNg9
         ZoLA==
X-Forwarded-Encrypted: i=1; AKwUvBxktuts7X2mYRz8zculb/lAPZ82Z1eZdC7nzc9XlliuSvpmQp1EdlS48WwdZBzw/vyED8K/VLUODJ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfsaV2lOTTAxEKtCdSirWnsNxi2jgozjQ8FcvNCxYVXezYrWYA
	J05QHi8/G8hfYFRKjT4gLB7e8W4QMCc4ZVeUciwnqb48Ve9grcksM7MAh5kKtpkpocEDhWRjg0j
	TkrmIjRLf0XPhfFkLQdXKIg7UF2cLsr43q8rVVi6bO//RdcYJKwu/VJQI7cUSnCc=
X-Gm-Gg: AYBFou29kkkC6Z33SNIshNwc+nmJWeUKDdnGSTOu+0OCsMVICNEiM14n0Ahp5b1Hf8u
	PBYQ2Me1SsYPeNHi2zq4G3KOStySvnUxnddbgk5R0xf/alp4jsTbjMIsl84GIcKaqVy2TvstvpS
	n0ZqDGXQm4a5H6NjCgtZK6RS4i4m++CILQdZqDkwO/4hJqB2og5kOLtyWIDPWqICXcHIkYZ2akr
	f06ed1R93xM9ZmRE4dQAOAyTtLtjdpljQq+A+I3ihiZYfJTdztjReWFC8WirSKPoJhdqQQN9zoJ
	TZYorSaOx4V9gyHo7qhcuzQJYsdRVVS4u+OgE38LvVPWQq4dD2Bn3gweuAUPoV5tIQa56rn84Q7
	JrvfMfrRktOOjZfTVmRJx901paJTc0vYKIg==
X-Received: by 2002:a05:7022:170d:b0:154:d06c:e70a with SMTP id a92af1059eb24-1851285ca17mr9769412c88.23.1792401954807;
        Mon, 19 Oct 2026 02:25:54 -0700 (PDT)
X-Received: by 2002:a05:7022:170d:b0:154:d06c:e70a with SMTP id a92af1059eb24-1851285ca17mr9769372c88.23.1792401954201;
        Mon, 19 Oct 2026 02:25:54 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm26682584c88.21.2026.10.19.02.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:25:53 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:55:13 +0530
Subject: [PATCH v2 5/6] arm64: qcom: monaco: Fix pcie1_phy compatible to
 list qcs8300 first
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-monaco_ep-v2-5-852cb9f5d012@oss.qualcomm.com>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
In-Reply-To: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792401919; l=1159;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=lXeO7bP7idTFtUBzuKbosYtATj9Ndsw4dWgt9vtKsn0=;
 b=sjm+65Ib8YrCBQPt2R/Zbrm5GYLWerivul8CnzzIcez5z+2TGxqbmoQ+cWL8+ZPUBvyxNeUU0
 zbxSJSxjNTFCH4PTwZyc3qwws3KG0sTG5DvGKJYveBomSlQsGmUVvcH
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX0grw9Q1Ye6PL
 Zq5HpXm9TGqvIik1w695LLl35Imq14aIKgFEksAQYhS30SaAXeOF4qZE5U7+JY5cvQ00Vz842iF
 GTsGifig45TKznD0W4tXCtJH3x+t2wI=
X-Proofpoint-GUID: vE7adsHuVVmO3XJBTHRX85673Gfndq6P
X-Proofpoint-ORIG-GUID: vE7adsHuVVmO3XJBTHRX85673Gfndq6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfXynWKkvTYp4Dg
 Qi8vWudHWZW96wHjXN3rr1w7gwV/AHzbL3TbZqXpHiGNaa73IvzZBKgeKcd8ko7A/+aKZIPyk1e
 ndeHMh7Nj6nEMbKNIzOj0rTNSc0ZIvos6qru9yCSAdzhYOM2SmIt1QOSDMRomMSlAIaYqdh+cd3
 wfUDGzg5sDYx5H2lHON5g33nZx16PA+9sewSnDNzyokAu4IV26ovzPvBmhLnpn2LSyT0SLWQP1M
 SALCuPHXPldSNjJHcV++SuwcTkqZHEthVNyEH9hk0Zsu7k0VlVrctcHxsDgeeHBSvQcy8QelCr3
 wa2ZaBwMXwSRytKIqtT2zkSETKAddeuakKpiprh1RLiZtfojVY6ZNZUmCsgxlGIiF8vVdZr4Z1n
 co1c0yGUi+cYNbso4D0F+ZJeJ/ER/hpSuko+Cwz9ch9C9v+La3lzp6ox3FFiXkGX+LsDkUvN+En
 hCz7CRx3t9+zI3Rzriw==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad5e223 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190037

The existing pcie1_phy node only listed qcom,sa8775p-qmp-gen4x4-pcie-phy
compatible, since no QCS8300-specific compatible was documented for this
PHY at the time.

Now that qcom,qcs8300-qmp-gen4x4-pcie-phy is documented, list it first
with qcom,sa8775p-qmp-gen4x4-pcie-phy as its fallback, matching the
order used by the pcie0_ep and pcie1_ep nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index cfe39f923224..d7d135e87a8c 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -2597,7 +2597,8 @@ pcieport1: pcie@0 {
 		};
 
 		pcie1_phy: phy@1c14000 {
-			compatible = "qcom,sa8775p-qmp-gen4x4-pcie-phy";
+			compatible = "qcom,qcs8300-qmp-gen4x4-pcie-phy",
+				     "qcom,sa8775p-qmp-gen4x4-pcie-phy";
 			reg = <0x0 0x01c14000 0x0 0x4000>;
 
 			clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,

-- 
2.34.1

