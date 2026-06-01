Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E43955EB
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307223; cv=none; b=dIi98fKUyWargH5PdTHShPSDt8eqPewf5p5el/D1nh2Qmcehonl56qAK9peDFj+EIJv3I4ZVl9oRiebfvW5bzianrFuz18RYQSQLdB4Ghjtx+xab81lGiKH6tKVUv6u1Z0dA8fMoeuqVsIJ1DNgBCoTOCSAuZAyoO5mmxPhPKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307223; c=relaxed/simple;
	bh=7IQl5gBCstIzsB25wxagTUyFt2zOmpRhZY2BOPvDRsk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y9Gjpsno5SpbLuTKueVywcEssWm9d6ZKAgaG8zqLL/FXYSv+pMsd/j68FkuQ43D0pNhAcrQhG3YduaVR2AFUY/kS6sYomw4ascH9uGyZupXWnKocIVOJQ8dcj/ozCeT+8mHAMbRIZUiuL7Gpgv7RJGqSxOenVLcS+TVHtkVz9rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fw1ENjO5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cz5syKpG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fw1ENjO5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cz5syKpG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dPJB3563542
	for <linux-pci@vger.kernel.org>; Mon, 1 Jun 2026 09:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bQKthfhJHJ/OKF7Yf2J7ev
	+iNLRDR1B1zOFtNrqX460=; b=fw1ENjO5pfCylBBNsHQKFNcEffxXp7oHYd4ydD
	J23U7GKbOFGjNNzHFJIG2ZN1mMWAmFxo6Jk0Cy8pZ1IRLRBiiQTZCEKvs0WV7WJB
	NWZW4Sso0dfkrYFXu/WrhEnawt3xv0EJnubx2hIcNz+pOIVAinGRLyuwIdyOINnO
	klaIG6H9xMJI34y1kAkAlub1d2EZXaIPIi3lKvKpX4shkvnOz/5iyruFYCUESust
	M/aVEqKNej/338Os9eCUBGYtPKzGzy+rE1mkJR8mPL4YhV7MM+I4nhvg0CpMjEnJ
	H18LM+R2dvONtm3TJ5wW03fDye5Upe8B41DzxOT/k7nMQLMg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6rxr9vj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 09:46:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516d38bfe83so209880611cf.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 02:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307213; x=1780912013; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQKthfhJHJ/OKF7Yf2J7ev+iNLRDR1B1zOFtNrqX460=;
        b=cz5syKpGNFSctP1iiLUGH9YG/N2Lp03pnCqa4o2ZDPssmgBN6XxA62gLLPNquOfzrL
         taHNvCatkIpgV0lSzF9Py0vUlOjwvTy59WjTzFDFmf1Q8CmpixcdXbsbbKzoN96y3p9u
         H036c3d1TEVmcbYvLQLJZu77npCvopCBjQ1vN8tA0ouLmPuVnZg8YLFPtfEHZ7NuZPOQ
         1eAiYXWgGFWzguFxbiGz7ecrnnCxEHUd1QMCx5nX8+QpQvTQ7J6gG5snqL7R+BlBAWxH
         Duqra/ZLzCLjCIlDPno6fuSVkXNRDQivtsw72TjQyGJBfrDhyJ4IqJpieLYNzZDFoGu6
         fLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307213; x=1780912013;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQKthfhJHJ/OKF7Yf2J7ev+iNLRDR1B1zOFtNrqX460=;
        b=EE5L3yE1jMjZ8Ll2Ql8MdLcLEq1se0j2DK75hevb96S/mXC2J8Wv1zJOP6QjsKhEvs
         cqFKTVC+nhVaUyLnrfRooXE3dCODL00JxbIiUmQTrQH9frhBPB1trgudm1NsYaq9dQFp
         ft5/T7BDwjQDbNNcA49eQ+5fy76j5WiOHE5gHDySwM3wZWempXvIXKFesAUtuvPUJ3sj
         8Oq/iN8J5EdXcT1JTBH2tXQ8SO9+viOsJzOZVwvOqdI9apq3uIuSjIJoaYuYbevNEQvC
         oXEovzZKGxSOdOTEjJKyPHd+GSGsgE6FYe8D4x6tLhuK7Lp1AxAbKpEqkFBocc35cG4e
         ZN5g==
X-Forwarded-Encrypted: i=1; AFNElJ+7jfcvT4Bn1j9onflOCna3qO4tv9jCqryDhZYjMUR9pmB57yMhtMRikZEKKNSRKXWM1c2myAwMWL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9CtL973fXqxwoB2ZcccGxIxpXea86V7jj3kBoP+d5yi4M6KXI
	Kg1Os+qbsXzkogCNYCpcQYNN/lRkMv7Lw2NpsFCajPOdsNp+ji3KXwqfejPsOxe05atLgFVyC1g
	v/wl8+arzPmYSyGRHswRS+raDZseGWuElS0Xk3FKKfF+e78l2OeLzWcZqes2ALW0=
X-Gm-Gg: Acq92OExgPtmURt+5SmIbOmR/PyfILWR/Hls492yqFGisUBuC2WOGXE5fOLx1jxbG0v
	iy9M4bnx9xbtXWTmLoiX1hVJcetF2IvRXY36xo1PlGPcqaB3HguXz3EgtaibmjYervQZZpCgBSw
	GptfnAOVU9IBQdw9XIrtu86KMcLo0vyi0EB1Ijt4tcUj/n5mRU8jWVxC0d6tsPlYptVDZvNww8M
	RQotczGFrd4lBwX4LwobgdcrVohtlhEZUmkAA8XU7b3NHskI/5CbN2NXcxumTkhapdvPKaEBKVx
	piRiBrA+LjjAJWWsbNkLYdi4TFNkFa35VBWwCi5itrUdH8/eFlxESePwLihCeuUP6b5MAKrpXws
	65KSCEOfjbc+IF23ElCkdbnxQzWq6D+wGXtoDr+oXux3LCiXbIkbB/fUUwIlw6wCuNIuLyNLSW6
	M1tCG9mij5Ewy0hUXabmBgvwzQsZoig7EQgZc4hXFicKg+2g==
X-Received: by 2002:a05:622a:4e98:b0:517:5aa6:acf3 with SMTP id d75a77b69052e-5175aa6ada3mr18890031cf.12.1780307213396;
        Mon, 01 Jun 2026 02:46:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4e98:b0:517:5aa6:acf3 with SMTP id d75a77b69052e-5175aa6ada3mr18889581cf.12.1780307212935;
        Mon, 01 Jun 2026 02:46:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:46:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/7] arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
Date: Mon, 01 Jun 2026 12:46:48 +0300
Message-Id: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhVHWoC/yXMyw5AMBBA0V+RWWvSair4FbHQGozEIx2vRPy7Y
 nkW917A6AkZiugCjzsxzVOAiiNwfT11KKgJhkQmqTRaCR4zbaQ4qCWhrUxNbp3KdA2hWDy2dH6
 3svrNmx3Qre8C7vsBHvXkXG8AAAA=
X-Change-ID: 20260531-sm8350-wifi-3b0659bc183a
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7IQl5gBCstIzsB25wxagTUyFt2zOmpRhZY2BOPvDRsk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ZsKFf5IqHd3afcHFRblpsxG6r91a8WNJjg1xtg1Xc+8
 1202rVORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAEwkqo79f1StnvUu9p28ewx0
 pvAtL5unt3uFx92tDfXqV08E93y4Z7/C4NvbTW/iki7VzG5L5CtpkxT5qr1onur9l+U5Sco9UXo
 x3ZOSOf91FtWxHAv/LbeO15PxtOKqxmTTVdu4GBhd9wSGb1yyPTvHLkqAZ9OJK/t89T89XCkQL6
 Yi3T/pW/xv6QKug53v2vIZzjPmBPX9tt3Rt5/r8Y9/nm5vdNOTeXyNVv6RuPRejudV5e8Hn+3ky
 73z1D7k8H3a9erdMtcbzXYvWVxTT2+Q9VJkXyac1NGc+zpO3adZLdXYNV8nVezQ+tkbW1c6zvC7
 xPU87lhbqGdI/EweF+0DgqwcKgm784Su2k41OLnhmy4A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: tgTH8ekeGbwGcN5WP4x75nl1kfAppiUR
X-Authority-Analysis: v=2.4 cv=dsfrzVg4 c=1 sm=1 tr=0 ts=6a1d550d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=6KS0kTMdj-vf8_meW0gA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX8UeVk8ExFw0B
 U9nx+xZERf/L1tgFgJlxalYvtg2ENL76Bf37vhld/rxWyr8AZRRl9PZqwAVNsiZvQz1GVo9pUhi
 mYeJpQYnOcc/3JyrVPeEy//3RDPwUkonWem0zm359hm13IRd9AwI9yWGIVT+6DBX5+zBFoNin2G
 lrO2z0Gt1EOdKbdr5hLtXrxHWCKDQ3t4phKReONkgX3SBPuGrXlfPZBZoxCyi1otHScDsvEoSev
 qGKT72d2uTfnIN3JWekMpT1jeh8qDUwc7ru+alXr7KvpOE3L4s1c4z662iHhHs1EkjFMuwUGqLj
 bMMPZ6tgkroHLayohOIAQgYTarZaFaTA1T87u/pYvHlk9GOmKyz6lJ9LTC9UPCfC5legW8URY5b
 4y51mXwytu9DAX6Paa59sDyNa9LtNax/qYFriHwk6yPOxMNuKjQCCzPK5QfVWz7Uctdyex76frK
 oq/cSIsjxDJLZ6MeeCw==
X-Proofpoint-ORIG-GUID: tgTH8ekeGbwGcN5WP4x75nl1kfAppiUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010098

The SM8350 HDK has an onboard WCN6851 WiFi/BT chip, which for a long
time was not supported. Bring up different pieces required to enable
this SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (7):
      PCI: qcom: fix parsing of PERST# in the legacy case
      wifi: ath11k: enable support for WCN6851
      regulator: dt-bindings: qcom,qca6390-pmu: document WCN6851
      dt-bindings: bluetooth: qcom,wcn6855-bt: document WCN6851
      arm64: dts: qcom: sm8350: expand UART18 to 4 pins config
      arm64: dts: qcom: sm8350: modernize PCIe entries
      arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip

 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |   8 +-
 .../bindings/regulator/qcom,qca6390-pmu.yaml       |   4 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            | 142 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  14 +-
 drivers/net/wireless/ath/ath11k/core.c             |  92 +++++++++++++
 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   1 +
 drivers/net/wireless/ath/ath11k/pci.c              |   9 ++
 drivers/net/wireless/ath/ath11k/pcic.c             |  11 ++
 drivers/pci/controller/dwc/pcie-qcom.c             |  25 ++--
 10 files changed, 275 insertions(+), 32 deletions(-)
---
base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
change-id: 20260531-sm8350-wifi-3b0659bc183a

Best regards,
--  
With best wishes
Dmitry

