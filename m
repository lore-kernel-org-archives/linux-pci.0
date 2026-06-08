Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C003B2FC0
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910233; cv=none; b=LVZLjwuyGDn/D1EWKO8am7CyIW119XJmvy9+eawLF9aVMTgrBOP3weDlIAE1fXz9BTMP49XWk2EoYUhrCE4lJG4uEdkcvitAbIqCOARuYaBnJVLljOkvcaf5tE7/4aV6c8Dul52Qdwz9OJT7A1/bAHzn/U7oN5VHiAbdY+aH0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910233; c=relaxed/simple;
	bh=5l2djtNbAKG4yz59Sy0TGxxB5M2aM0T1Ix6YMc2Rlxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=laQEFgSGZg6RoMLJCCm5SjcZmua3QywLs8h48GP7PbTKh7LpgponxQXnNiHpnmUvcM9Z0lyniU6kCethPuy6/hMxnTrGydWXOmZyzpiF3aZ0eQmqh1iYG9Qb8XkYO3KWkMXPtLgJhC0WPbXcrFzOempBxvn8Tp4Mpvvqi1pJ+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=clyMt8TZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a4R4WlAV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="clyMt8TZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a4R4WlAV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Pk8m2733114
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 09:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9TQChVoZGJE1ujfnF3D1YTCmrzz01p+wDC5
	U6eyAgsA=; b=clyMt8TZ9PBMiGr6oQ63qZiAEfMD750Be7MXNqRyIJ6k9WuvfD2
	eAzU0SJ/10PkBWQFZvnPx6UUXmurumz+J/4WE/5TfgPW8D3kIEQY8gNFbhnQJT3W
	KUPVJJZ0eF1WjixFVCtgKDX+msGmYCHp1XpROWIVoJFzp/caedoTiNTqDnmT1Mxu
	Zc6UT/xfqCHqcmVltzYSALh1/2gZITk8EYOqw5aZCH/UoJIUkpaaJSqtMEWwI3sm
	2e7I4Tu4+Cl6v1JNo1YrjV9+cqPHOOZfc0h/eh56Dzi4+ShBQQGByJ8Sg9vqQFWR
	BmKSYvPAP0eWVb+PjkRt437lXHvJw6ov5qQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf75b2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 09:17:10 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1380494d27cso266634c88.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 02:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780910230; x=1781515030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TQChVoZGJE1ujfnF3D1YTCmrzz01p+wDC5U6eyAgsA=;
        b=a4R4WlAVHYjFgjivj5e7q1Z/gF5dR29Bhoqm7NM9dvG9BB9wL9zV6hU6V7zEpKms5m
         LatT/Pjgn4DZR4yw64Bk/ULZwjZBojSIWiSL6DpJZQ409TgL8PJ6ogJ9ket1sSLaq/WV
         TVV/HmgCcjt8h/nC6FP3gzabX5RZMRPsAkSxEbX5N8XiHl7LHhHCh1AqRkxIPsJmpefC
         ShoojDcux75ss8rUurbasp/AO66+xU12n6BtXJ4TcdAseDBb8/InHr4g61F73hcLVu1I
         W72oJisrnGRCE4an7ov1+Syufg7k80gC38NqAGHQDYqSwi4Mp/ZVD14U/gNtfhSNmIUE
         xu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780910230; x=1781515030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TQChVoZGJE1ujfnF3D1YTCmrzz01p+wDC5U6eyAgsA=;
        b=l0PyT8OlgVkf+Nkz70W/3zSJ4VzEqMMpOGmkefxeGJ+g66SBOV7pVg8IS11Icx1H5y
         Jr+UHlpJkCOv1QgqhkdI3bdmh7oI/BdCB5xKYcWR14K57UvyGhJeOZZhLOcWfYYQGrQq
         xnnH0OyGexGYMrjReGn2oboc0s73J3V0ZDFBTebL53cylKWNn0LJskwBffx+ey+/TvBP
         DYN5xbz1wbCfCQzmGLE3iFYpAZknSjZXWsvrlMYgtJMTfRBwn1niFLmVW8b7TAKzahNe
         WAkVVP+YA/E9V8CYiaf0B6LKh4r/cFRoa6AIBoBL1YvZW/kptb2bhIxnNZoZEPjdQLIo
         MyHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0PGtatqAucan9NvwaQ8Ll1v8M4TyZG21npAwBn/Md2ndZbwCq78Dlj5gU/uG8cg55iK/OJGZ5bXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZzmnc9WvqHs1qJ44mItK91gzqZmouipukp2agFZ/fNwAnrmW
	y3vw7ApE3fTIBvPU1NN/l5mji91rUUFI59/+9APblhCMis0FoNCbfMHJsUGLSFsVT4p+oD5KmO7
	ltnDXIrg9BLJqdtbP4O1VlNidOechPAv/lb4D/rRu/WXYkUAU2RlURbv0cjbolpw=
X-Gm-Gg: Acq92OHAeU2N38jvs4ATRvo/YpFbyhwr31QwML0Vb2/XD/Nb1nu+qAIhUGwzAM513oT
	qXBcvpHu7c3b9OY4EK5wRSFgmNR7oNUH1f1mi8p2UwLeurI7hSKnbK6966edbRYJ1jdRoQvH1V9
	Zo2tYkpshZpYFECktSAz58LwzEzWKQgY0ePLebShIpush/l7u+Ge1xMXuYG2wZBC5JyUKZDiPWk
	EzzwyUas2vfwuAok1yHqm2C/q4VHkHr7MYbOxSvZFSTfTTC5vm51nSI+CaLoIC6XQ472cQzNBIH
	f6lehmqbwss8pzvKu3FHABxNUInf36a65Y1cumgYSmTTrT0+rvO1xvfI8FC58CllqoBTKa3glAG
	Hu/JPT/QvbGg3dbIq4swpP+Xmzpxk9JE/yYcDxNKsWbJw6GnMViaTR3zOuL8vdoo5cOHtk+FFlq
	miRI/FpXk=
X-Received: by 2002:a05:7022:423:b0:137:fdce:fec2 with SMTP id a92af1059eb24-138067f0b96mr2904762c88.4.1780910229722;
        Mon, 08 Jun 2026 02:17:09 -0700 (PDT)
X-Received: by 2002:a05:7022:423:b0:137:fdce:fec2 with SMTP id a92af1059eb24-138067f0b96mr2904747c88.4.1780910229057;
        Mon, 08 Jun 2026 02:17:09 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm12178656c88.14.2026.06.08.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:17:08 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: [PATCH 0/2] Enable WCN6855 Bluetooth on lemans-evk via PCIe M.2 Key E connector
Date: Mon,  8 Jun 2026 14:47:00 +0530
Message-Id: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a268896 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=g11dK_DTieeChMdKYl0A:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 76za070XNTClyUDHjpGOZKJUhyl6XWN0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NSBTYWx0ZWRfX43Pa11Bi3jME
 1uDtyr9krpXq0EJ0gmjUB5HjMluUkcQJFxh0GLjFWIxBoippAPmfeULJLm+PQcnYYqVo01HmzBo
 PMTZPABLGyVC4yRz3gATG4Xq6r5dfXSyomOU6/YzIKE7ZqgEPRTJpBukXiZOq3gSzLBosqzqU4B
 w68BKSFjosUShOwg04jX0YB4SAk4ZYfWgU/xwuQm3aT1/KMMgpTBzdeorBWews4SaDnjpIbd0ry
 qfVFc7HZYgZswKkCjEXZxGHiIT5i4Baiz2xIZ5EZGpAhEKJ1zrB0PX2iI6IU95pv93NlZpTzaik
 H+lnFNLpbqYyu3rYr4RIzB59vtpsdFJEd9Rx1ORYaWbD57CwcZltIjmJF5fZoAsnnFxa0cLxBAF
 C5x20s3HRSkIiiucrceQQk/9GM2QjvD+cEZKZaBpYw6mZVcTcnjKItrTxxoie4zsVOxEcNeMiGe
 FGcrnjMORRavnmV/BBw==
X-Proofpoint-GUID: 76za070XNTClyUDHjpGOZKJUhyl6XWN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080085

This series enables WCN6855 Bluetooth on the lemans EVK through the
PCIe M.2 Key E connector + pwrseq-pcie-m2 path.

It depends on the "Fixes/improvements for the PCI M.2 power sequencing
driver" series (V3):

  https://lore.kernel.org/r/20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com

Patch 1 adds 0x1103 (WCN6855) to pwrseq_m2_pci_ids[] alongside the
existing 0x1107 (WCN7850) entry, with compatible "qcom,wcn6855-bt".

Patch 2 describes the M.2 Key E connector on lemans-evk:
  - pcie-m2-e-connector node, port@0 -> pcieport0,
                              port@3 -> uart17 (BT serdev path)
  - vreg_dcin_12v (12V) + vreg_wcn_3p3 (3.3V, vin-supply 12V),
    both always-on/boot-on, as required by the binding
  - compatible = "pciclass,0604" on pcieport0 in lemans.dtsi so the
    PCI subsystem can match the DT node to the PCI-to-PCI bridge
  - serial1 = &uart17 alias

Wei Deng (2):
  power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth
  arm64: dts: qcom: lemans-evk: Describe the PCIe M.2 Key E connector

 arch/arm64/boot/dts/qcom/lemans-evk.dts   | 75 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/lemans.dtsi      |  1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c |  2 +
 3 files changed, 78 insertions(+)

-- 
2.34.1

