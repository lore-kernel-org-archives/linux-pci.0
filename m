Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442175;
	b=hc6RqLCopEMyWKecmI0Sl1S5bP3AiymLwZIIKTtVd59yBHuOYSqoNGZRNGMCpa+Uq8uR
	 49Hzdy3Q6VTqwa/I0NPTUOkmKLuI5pRYsdrzzvvT/xstXUn5WdRk8Vt7wSEoN5aaGzrFI
	 E/nskvq/wu980C9rBYpyPwJiwcNX9jvs9JfRx158ffSVuJUCKzI4Cbz/+2dFOeHftr+h5
	 3DgVZ7DHWNyDQ17jTn3Iduy2a6g6HQPvLN1bxh9/teUWOczOn/w2D36wfSxOpjqc2ludv
	 aF6Y7ntrZn2cDlqDycwoHf8KlvMDZc8SueXJ8IO5nKOY8HhI5gGlloXoxX1qZr+wRgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442175;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8Sw+MMhxFCG3aqs1lI+8E2lgYyctKL4n0R8hZbBBbWU=;
	b=rqTihDKrGg/hCkCeB2hNM4OMZu+our7JgP6LHpIC0p/qxaPfcdcnzaYt7SVBJbBfANFl
	 n4Rr9ChUr9Vy8RkqAZKR6hbDN1oxpfpdia2Y41aSkm6dhj7ezviRt7d4RicXy1NHFJuWr
	 mX4J+w2wTSc45uSVaCc85LrgSJV8nfBt7R61wQxhE+eWN4eNkb7F6++Hu8cecQF20SUv8
	 X+LsNOuNKNMDqxcD+r3l0wGGzWwttbjxybIXPJJT7svpZ/xtXoY8OX3XtZk1DNP3UdXBg
	 0SmdNmsZcFeGANBL4tVA2zYJOReXlxBRBXourYS1uatAnOY+4fcj42oqwRQZr/xa7dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BQbvXYyn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IEehc3r6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F30606A69F
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96F30606A69F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BQbvXYyn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IEehc3r6
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKsbW1974136
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=8Sw+MMhxFCG3aqs1lI+8E2
	lgYyctKL4n0R8hZbBBbWU=; b=BQbvXYynsmbXz0PhWldh9vbdflxXNpPGvNrIMX
	2wYzsJIRbys/GELxCXFbrQOvZWe2YkzQyfYxZynwk+X4/Of6STCO/x4Qkm8C4Csl
	ssGiDwEz4vVdKzf0AgTbB6pBlAy4kzQyJS2uX9L/7DIvymD4LOVhwzlhtmUzWJ0g
	h4uKyP1s0jFPZlG3wSJL15drGwo8aKO2jF8EocfJ3Nvu0HuhsbLZAq+LFnb+KC+C
	D/eSgl5hTredWL4ymrWJ6kHl/MNsNkm9M+IF7RaNgX58jY7ZhOF4usWfFnjbbyEp
	TILU4s//bgtz3XOr4ebwUvxT8xap/JYyRwuGZL4zq5B7KY+Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4m7urkk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:56:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb7f9bb86so665061085a.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 05:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442173; x=1796046973; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Sw+MMhxFCG3aqs1lI+8E2lgYyctKL4n0R8hZbBBbWU=;
        b=IEehc3r6Xp5QwJzjaxdw9e8cZ5vLuRBxErgGiRGhtdPkIyeup4kylUQ5vr6ZQCAju8
         bhMFCnkLJujNxmU+SgJFmy03wJkLlcTSI9afizUZ7IGakZ2Z7Bg6CI4ZFESym/brzFtZ
         Qm9fFQWUHj7AP/hihaGN3A98hl5TyOz55iN6RwNRluMbgYJxbk2M94meE8dy5tV4KeUb
         DdFUglRBd9XgwfLrbEYsqDAo/AYwWnv11GQuVldaq4sigp7FAXRT5PLX4P0Z7YwXqxSd
         Aq9WW0xRzUDKCbt8bQv52m91TMLCXRtIhoCfuwzlNR8beNfmK5QncGM2VfWRAIp/bmO5
         tbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442173; x=1796046973;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Sw+MMhxFCG3aqs1lI+8E2lgYyctKL4n0R8hZbBBbWU=;
        b=QfNHtqpmFenykY/6uhKpd/5jfU+x8I7sVUeAe22HeRGdhBlM7cLycmgdWHRmIPVNG1
         TUVLH1re6aGlKAEEL/wRhZ+0VVjZjhS7NmrDug/fHMrJHERN7C9cV5fjf3F/zgLUpBWm
         cyZOm0KSltU1jEAj2VIZuE9BmPKZs7qBqG3pPXFD/Tcmm+yeg3jiqfMjNIjlP7r56UR9
         tpnwySDVZFnwa9eSk7HKpmAnhD1XI2BwVoAlKh1ahhceXcN1IpZWbk5uxegl3Yefp4yt
         dQC1amdtsn64YPcMckp9leUop7A9pINUhbL0PKN0/6moKbhZ4w9vRQ1nlCyjwZg24nB1
         1pDw==
X-Gm-Message-State: APuU4Z/RWoL7WFfX7b3t9teSjIy2I1zPvYlqxi5f93iJ8zwJWa3rPUGW
	3mstG3EtpBHeBhsDfDOSx/D+3eIn/7iYtnsnZ+OeWcmfUsOZ0jGMwhON2LcubkDjpzpFe2ymDJw
	3G62rsKOiGfyKwKT6c6BBW+WuguSFCTNZB/zmvSbQ8meh+VYQdRRXeizx8oZ8bD4=
X-Gm-Gg: AZFdTZf0ei+1QyAZ5VTeEilsbDpCikqfWZWrlU/DUqxFpTtCb1K+0Vq0PvJM2oPMczx
	lcbguCwT+kpyd4AaM4iDOfSByOzmc48aUGV1QivYL/2XcEnLyMrBpmdlZJoZAgYg/M7yOOZ1nzc
	9tKKPSQqhds0tRa79Qansb6j5qxtlw0QzJxsVdMFhVidwdFvdKo605pJoOhxI+TUKdjAIUzE2Ff
	VyJpN4QmtZnsAFRCHCA5hRpXG1TLs+EQ85fubbc8LXWtvPoc1SicZTFkjzCjllR0pOBaqrIqkbB
	5n1xe2QazmV8ZihNCP/rVH0BpKUg9emI9F92ZEM9kmBtngqdTUjgpy2dVU2hx3TRxg9JHTy/HgC
	tD6XY46Q1g14uMa2mreln/eDnXN0GAHBV54yWKPMACHge+3wgpQVv6P6cfFiw8MwIh/znsfnBRG
	sNULbjcPxTDcT1JCZYsKbZ11JpC/zwT+yDv8p1jnbZZeAovnEZfAc/XYJFZiOpfh8gcK+NxYK+x
	fPJiINOCj8IgOjqITPOkctZ3+nt
X-Received: by 2002:a05:620a:1313:b0:949:7b51:2dc1 with SMTP id af79cd13be357-949ba80f404mr1891455685a.2.1795442172473;
        Mon, 23 Nov 2026 05:56:12 -0800 (PST)
X-Received: by 2002:a05:620a:1313:b0:949:7b51:2dc1 with SMTP id af79cd13be357-949ba80f404mr1891449985a.2.1795442171926;
        Mon, 23 Nov 2026 05:56:11 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:11 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v9 0/8] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Mon, 23 Nov 2026 14:56:07 +0100
Message-Id: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAPdFBGsC/3XSzW7DIAwH8FepOC+VMWDITnuPaQdCzIrUNmtos
 4+q7z7aSUullAvS3xI/g+WzyDwmzuJ5dRYjTymnYV9C+7QSYeP379ykvmSBgAQGodkN+x/ffKa
 Rt5xzwxTYRpAqKifKpY+RY/q6ga9vf3nkw6m4x7m4Sfk4jN+3ppO8Vqv+JBto2kitRiWBjHoZc
 l4fTn4bht1uXQ5xFSecFQu4ULAotjPE6MlTryuKulPk8i2qKJrQKOOsj1RT9L1CC0Vff9QBMkW
 j295WFHOnPJiLKQq1HMhqZbQKFYVmpQW9UKgovQsGNHaKY19R7L8iAcxCsUUxZaxsibAPXUVxs
 yJRLRRXFO865Qh0V/bqgXK5XH4BxssqWLICAAA=
X-Change-ID: 20260520-monza-wireless-e6ce7f013f38
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Jesse Casco <jesse.casco@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ajAHi4YVlcyvbCRUIIV3GMrcSiQqNH9l
X-Authority-Analysis: v=2.4 cv=KurYSmWN c=1 sm=1 tr=0 ts=6b0445fd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=07Bm_TEVN_B7e2KTFAkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ajAHi4YVlcyvbCRUIIV3GMrcSiQqNH9l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXwjFLG6hifk6g
 0+3fqu5Qe5ieOrmENjPkomdSH0OebGxSex0NLeIT5t7UFXxdxy+bVQ+a8juLf3KaLCpHYFpJ+Vt
 YeU/QYYslqESBfV7uRmeE216SV3Tq0k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX2tl+rIeBPIx9
 2hCgAwijfU0JdKdR8SX2W+Zvrg5tv41yMcNHRTOeOKWQrofnWlqX3cNysyFHp8tlhrVpkw00ycz
 DIfU6RbOSUGab/7kAZjrhFRnhtpkg91Fv7H3I8wEa+iNp7TZ4jDiyifuWIaavfAE7VX9fvZRD+5
 77yh4vAo/uQcjAJglD0NMm4HuldPu/x19y3VEZZrH8JRzDQT1XFfp0eNEyH06QXu+feIrVXKTIS
 wzv15v59InN1hKYWMw+TaiDr0OR2DX4lmQ1aPnRfAAJ5ddpumj23jtTBdHW62P2oFY5p0xz+R7j
 +Feasn/qG+l49UqvYLyBX+FGnTnZgUlsjSpsfGJ2q60bKYiCgeacX9eoDwVchbMSp8KXwVF7aro
 Q4j4Tr4lpr9vtdtj82p/qfz8N8mavob+fGcEVPM+GSYuGVi0wHmvX1v6K2MWEzSAj1BP82JTDTw
 8EWpsUy3fCQX53W8eMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

This series describes support for the onboard WiFi/Bluetooth module
present on the Arduino VENTUNO Q (monaco) platform.

The board provides LGA pads for a wireless module. On the VENTUNO Q
these pads are populated with an NFA725B module featuring the
QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
the design is functionally compatible with the M.2 Key E.

The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
signals, as defined by the M.2 specification and handled here via
the pcie-m2 power sequencer.

This series models the hardware using the existing pwrseq framework
and connector bindings, allowing coordinated PCIe and UART bring-up.

The hci_qca patches depend on pwrseq_is_controllable(), which is currently
only in linux-next through the pwrseq tree and not yet in bluetooth-next.
Hence the next-20261030 base, and hence the BlueZ CI build failure on v7.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v9:
- hci_qca: skip the per-SoC power control setup in qca_serdev_probe()
  altogether once an M.2 pwrseq has been acquired, instead of only
  breaking out of the WCN/QCA2066 switch arm. The lookup happens before
  the switch, so QCA6390 overwrote the M.2 descriptor with
  devm_pwrseq_get("bluetooth"), and QCA_ROME could acquire both an enable
  GPIO and a pwrseq, in which case qca_power_off() took the pwrseq early
  return and left bt_en asserted (Sashiko).
- hci_qca: power M.2 modules on through qca_regulator_init() instead of
  calling pwrseq_enable() from the default branch of qca_power_on(). That
  call was never reached by QCA2066, which qca_regulator_init() already
  handles, and it bypassed the UART close/reopen the module requires
  (Sashiko).
- Link to v8: https://lore.kernel.org/r/20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com

Changes in v8:
- hci_qca: identify an M.2 attached Bluetooth device by resolving the OF
  graph remote endpoint instead of only checking of_graph_is_present(). A
  UART node that carries an unconnected 'port' anchor (such as uart14 in
  hamoa.dtsi) was taken for an M.2 connector, so the Bluetooth probe
  deferred forever on those boards (reported by Val Packett).
- hci_qca: bind the M.2 pwrseq lifetime to the serdev consumer device in the
  patch that first acquires the descriptor, rather than acquiring it with
  devm_pwrseq_get() on the UART controller and correcting that only in the
  later QCA2066 patch. The intermediate commits leaked a descriptor per
  probe/remove cycle and left a stale pointer if the controller went away
  first.
- hci_qca: use pwrseq_enable() rather than the pre-rename pwrseq_power_on();
  patches 4 and 6 did not build on their own.
- hci_qca: check the pwrseq_enable() return value in qca_power_on() and in
  the always-on path of qca_serdev_probe(), instead of registering the HCI
  device with the controller left unpowered.
- hci_qca: stop dereferencing 'bt_power' unconditionally in patch 4. It is
  still a pointer at that point, and it is NULL for the SoC types handled
  by the default branch of the allocation switch, such as QCA_ROME.
- hci_qca: fix the continuation line alignment reported by checkpatch
  --strict in the struct qca_power flattening patch.
- Shorten the subject of patch 4, it was over the 72 character limit.
- Pick up the Tested-by and Reviewed-by tags from Jesse, Mani and Bartosz.
- Link to v7: https://lore.kernel.org/r/20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com

Changes in v7:
- Rebased on linux-next (pwrseq changes dropped)
- Link to v6: https://lore.kernel.org/r/20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com

Changes in v6:
- Rebase onto v7.3-rc1: drop the now-upstream "power: sequencing: pcie-m2:
  Add QCA2066 (QCNFA765) BT serdev ID" patch and adapt to the
  pwrseq_power_on()/pwrseq_power_off() -> pwrseq_enable()/pwrseq_disable()
  rename that landed in this merge window.
- hci_qca: fully drop struct qca_power and move its fields directly into
  struct qca_serdev, removing the bt_power indirection (Dmitry).
- Pick up Reviewed-by/Acked-by tags from Mani, Bartosz and Dmitry on the
  pwrseq_is_controllable() API, the pcie-m2/qcom-wcn controllability
  reporting, the bt_en_available rework and the M.2 connector support
  patches.
- Drop the pwrseq-m2-bt prerequisite series link, it is now merged upstream
  and included in the v7.3-rc1 base.
- Link to v5: https://lore.kernel.org/r/20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com

Changes in v5:
- hci_qca: comment why the M.2 'uart' pwrseq lifetime is bound to the serdev
  consumer device instead of using devm_pwrseq_get() on the controller (Bartosz).
- hci_qca: note that dropping the always-on pwrseq handle is not a leak since
  the descriptor is still released by devres (Bartosz).
- Link to v4: https://lore.kernel.org/r/20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com

Changes in v4:
- pwrseq: rename pwrseq_power_is_controllable() to pwrseq_is_controllable() (Bartosz).
- pwrseq: move the is_controllable() callback from the unit to the target (Bartosz).
- pwrseq: add might_sleep() and guard pwrseq_is_controllable() against
  concurrent provider removal with rw_lock, matching pwrseq_power_on/off() (Bartosz).
- pwrseq: clarify the pwrseq_is_controllable() doc (Bartosz)
- hci_qca: lifetime follows the Bluetooth device rather than the UART controller (ChenYu).
- dt-bindings: also add the "qcom,pcie-m2-1620-lga-connector" compatible (Mani).
- arm64: dts: monaco-arduino-monza: rename the 'pcie_bridge_ep' endpoint to 'pcie_ep' (Mani).
- pwrseq: reword commmit message (Mani)
- Link to v3: https://lore.kernel.org/r/20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com

Changes in v3:
- Embed bt_power in struct qca_serdev instead of allocating it (Dmitry).
- Add generic pwrseq_is_controllable() API + per-target .is_controllable()
  callback; use it in hci_qca instead of peeking at the W_DISABLE2# property.
- Implement .is_controllable() in the pcie-m2 and qcom-wcn providers.
- Treat non-controllable BT power as always-on.
- Integrate the pending Bluetooth pwrseq patches from Mani.
- Link to v2: https://lore.kernel.org/r/20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com

Changes in v2:
- hci_qca: extract M.2 pwrseq into qca_serdev_get_m2_pwrseq() helper, called
  outside the SoC switch; drop duplicated of_graph logic and redundant
  bt_power NULL checks (Dmitry/Mani)
- dts/bindings: use qcom,pcie-m2-1418-lga-connector (fallback
  pcie-m2-e-connector) instead of the generic M.2 E-key compatible (Mani)
- Link to v1: https://lore.kernel.org/r/20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com

---
Loic Poulain (6):
      Bluetooth: hci_qca: Set 'bt_en_available' from pwrseq controllability
      Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      Bluetooth: hci_qca: Flatten struct qca_power into struct qca_serdev
      dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

Manivannan Sadhasivam (2):
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'

 .../bindings/connector/pcie-m2-e-connector.yaml    |   8 +-
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 ++++++-
 drivers/bluetooth/hci_qca.c                        | 190 +++++++++++++--------
 3 files changed, 184 insertions(+), 78 deletions(-)
---
base-commit: cf357cfc025e7f72851479ed3fb60d5f16413c1b
change-id: 20260520-monza-wireless-e6ce7f013f38

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

