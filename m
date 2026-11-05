Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867324;
	b=tWQyWUZwhWSoibLokCaOfHOy5sJ+Q7cxlZ9u1VhMu6ZoIo12ADOB62/uZChFaJERfQtd
	 Nwd7le41LaRHx3/4e4dU/BWvIBqLcZgkX/XG/OurACODLXxS6MbqbRBg8Vmu8ZPQiTEMr
	 X8w+QU4iYmf5+Tj9jjYr4k6ThjBZFq1SQ+M4yjXJLFuYYZoXGzlg0iubjjFPz0MzGGhvt
	 Aub4OMORedBnaE5ZHX9PpbPgrrDqDWiyjtdwePplshqslnN+G28bwnj4NILfM8iIPPkas
	 d44a645EJ2feJ+NABGsNKPvMHQ3eeHl8dLZDDfBXqK3qFFshjrpiy5oY6XoA/RtRUOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867324;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bftPnzpqyazExOdCImV1EjtVBi1rBI5waWTx8s8wjvA=;
	b=G/LUk4foGUmV0eFlhCrrOwcM5KbtJji2IBOrCW1LsA11RJNzAdmiTexuQGZ5CZR/dUc/
	 Z8xyiODB/7B0/qi4sdgrl6q4c9LMAF4zEIEpkzh4bwCix+7KN3WWBKlcSTkRFSdmisw/L
	 ifYb7nc2J5B01eT6FktoFxcVimkO/Apr/6NgXrC7QStZXzpuCIyV4r4+0LM3kgezSnTn2
	 VCwKcuam0wJMiUyFprNC7gG1g9FMEveh1wyU8RGIinHk+tRrCXlzlw7C2OTnXSuJNcpxX
	 X6qYwoJb2LjnIb5z6lavFgQusQ2ylFT2Lw3soy5y5w+qeoKRj8UqFCpdijtLeb2h+KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a3jX3CFf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GuciMMuW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0A606A326
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 08:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD0A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a3jX3CFf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GuciMMuW
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UL2V1018088
	for <linux-pci@vger.kernel.org>; Thu, 5 Nov 2026 08:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bftPnzpqyazExOdCImV1Ej
	tVBi1rBI5waWTx8s8wjvA=; b=a3jX3CFfemcGDIiM0nqUVYAhZjawSBL8gSDcod
	KoA0UmHEgWYo/dwB6/a9Bfg3puNg/ainAhfbHz8o0XZfrH83xf4S44fX4p3QxB4M
	LWk9RxupnuC8tM5ewMtbQ8xU5y29a2otDR+ldfrVl/j19+Z0VMZP4PUZr/+jaHov
	SZwDryHeayIZ435VaMt7s1OSlveB2UhJQooUw70lue6YYfIQch5BOpPXY+16lQ0J
	v13PCCq179/FLt370FLxQW6ZNkCLtcf/E1tQM/ZFfefFbHtswWG+TOYAAfhiEsSs
	c1PBlFR4uUf0jsncSxQgWy+SGS6KFOX8F60tJWxqNmZNGEyA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bnm28c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 08:28:42 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc37ee6562so359290137.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 00:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793867321; x=1794472121; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bftPnzpqyazExOdCImV1EjtVBi1rBI5waWTx8s8wjvA=;
        b=GuciMMuW94I1Y7387zDKyXhf3VF2vUTwHu1mrcgwB0y2+Y+zxEvQwjKZxSJPAsGj51
         8/iiDv+m9SIViO8SpVaNvC9Vc9PbhJGrqjzS/d1i4SdGtIWmVAdDShg4CxYxOY1b2+yD
         d5UHq8yZVOAOD4E5JjDA6nlNC1ztEa4gsByjsJsGsw+uxqNGvxZnVJK3k2Efbl0lQB2U
         dTP5nbXo8h12TbBqJcDJoKqLMCp9zcjVda5+nt1dC1L6j9WyTqebEHXY+yADtQU6/RcL
         x2mg2ao9QlNV+ntlXa+4Sz9ccsuBxUbb/o25+00a0KbqxcleiHnf6PF6PxADei4e09mr
         chng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867321; x=1794472121;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bftPnzpqyazExOdCImV1EjtVBi1rBI5waWTx8s8wjvA=;
        b=friXyBtg6WjrPTu+t84vqUuzvECWuSyiyvTRbP6b1dS/CH58esr0uMu0FGheMdmdHd
         NM9+IJjU0ccpvfWvrQLx61OGFD9pwtbnBAfsz2SiLo9068+CtxG3DMQM3OUtAyd+08BJ
         Z9IrO6ypE7qP4cq3xWTEMYtMvF4aFFE1HFivv8wiqH8KLK1eGCRu/Q4wkdvHBCGzSEwR
         eB6NuZh1spLrEPMts0uGYYyvj+SdS2aSViQusYKhQHtrhx7lekIeawq5RAjtwunk6CsT
         pIFOL7uZLUmZLJsOTUOz/qD1XzEeOKf3/wS6DvMtHbTmP4d9yf4YA2adAsNxQ518kgNf
         9nFw==
X-Forwarded-Encrypted: i=1; AKwUvBzXD2Mrk9aByTnpnQSoyqESADxpKNfBgG5j3KRjW0W20j+fmnEIbsr008p4DTRaRP9jYFwrbQqSWKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dBeFXsGETjj9MqWnYgb5n2/TbTSwliFwiVQv6iAAEbhv9bwaK
	uzX3iIPkld7JtcfoHTcr2EP0vqTjvEEbl2Ncm+YL/dRLswXa5kJzMHxXTZGaiPM5XdupstG/Brl
	mOa3GO/jAOsamgCB7x8KNY52O+Ct5SvrzNbl2swsYiom0n49ZU5fNtdNNfkF1/Wc=
X-Gm-Gg: AYBFou1/xUde8FDUwiqzFPrBL+th3+6VRsL3rL5c8H1F2MA9FFWMIpOZDMmLiDPfOrs
	h/dqIuT3olZnh1S7zCuQSSJVLwPmm1hMsaRVEWSox7cXFmt6W1L+16GONQWX6yGgdSCggikay5W
	8L8q2lBFSHTpzF72SCF+TrgVCg/KCXYf6hyHqiJo6UntxlZ3vJ3qTqYPpB8GKfBYrdKuHxdZZnN
	JmOqPjNgZQjEU1H0c4x+fsO69R6BfAb8ikuSFbLsUAj8SmPMc2ljwEfJFdv6R2Bl+WBtZltEZ3t
	u/cGtcV56RRtYgP+vFYnITqk+30UVN1LKtsSmZhMRI3jLZz/OLl/BqXqlMJz3Rw6QhGhFS4v+0q
	yBNhx923wlhGelzCpBHE4vyKZ2Kb6MYlWknumpQ4+6CbK4w5KCE9l1rKbur1bDWQiweXpsMhKad
	tW5g==
X-Received: by 2002:a05:6102:3ec5:b0:7c3:8150:83e7 with SMTP id ada2fe7eead31-7d072635dd8mr7059159137.9.1793867321227;
        Thu, 05 Nov 2026 00:28:41 -0800 (PST)
X-Received: by 2002:a05:6102:3ec5:b0:7c3:8150:83e7 with SMTP id ada2fe7eead31-7d072635dd8mr7059145137.9.1793867320695;
        Thu, 05 Nov 2026 00:28:40 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed55249csm7406821f8f.35.2026.11.05.00.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:28:39 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/2] power: sequencing: fix use-after-free in
 pwrseq-pcie-m2
Date: Thu, 05 Nov 2026 09:28:34 +0100
Message-Id: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIADI+7GoC/32NQQ6CMBBFr0Jm7ZBOQQ2uvIdhUcogTYSWjqCGc
 HcrB3Dzk/eT//4KwtGxwCVbIfLixPkxgT5kYHsz3hldmxi00iciVWJ4ReEJg3WMg8bZdGhIaVX
 ZwpbtGdIwRO7ce5fe6sS9k6ePn/1joV/7V7cQEirD1DRsqmNRXL1IPs3mYf0w5Cmg3rbtCxXpd
 Ae7AAAA
X-Change-ID: 20261104-pwrseq-pcie-m2-uaf-a10209c3c4d7
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=949;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aAxFA3qkGlDii85iAxLxDJATeMYC5RHkXba8JCBSbv0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7D425MB/sAxue2F4PG6iwn3tTVcnjGQ1hmtwK
 3/rxiilA6SJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauw+NgAKCRAFnS7L/zaE
 w/8zD/9VB3pSWjES+zOIEFSqznp1LFQng3ReR+JIg6ByQl2GPnHQFXPk50ziOllOPu42EOYm720
 H9A3mTqOjivDnZUOm3yJL+93uGC6IdedLV7wBYpufI+5YRUclENePTNl0yxYEkswSoIv2IZAgo5
 sxCm36n3aadwEYcZOR0NiLsrnbvREkPpHrdHgKfTFRZvahNJEvz/p6hLfqKSmoJUpvP8MjBe540
 b5ff9UQt99YCG6wzzySEMn99VgqouSvGh8qCtYn0wd/SYPWRCF5J4YbUz5ElTm09wA9Yt1/+6EG
 RBogEGrcVMyCgIweVjiEp967EEfz170/34cJ39lmygUDKmX7jdqBUc/Jnl7qNsmb6pygKAP1yIw
 LAQW8s02GD6iA7hJAeP3IPtSgAfipWMDAu0tnqumtax63apqHvoIYJp9tubhKSKPBn24lB0dt+Q
 1JzN3uxlb+T4tEvRW6ywY9GgGtxw10yZmbYYcfQTRT5F7NY25wDlc94W2IdjwWICf6xx8kzjUZa
 b57TGlaaOz0rka6G/YKKq6Svgx30qWuDON2EySmib6dVyUTUKQA80ECrAOh3R17X+lwqLOFRWt1
 EM8cWxalJYrm/77bJKirR4ZwrIx1C+nQ/rCSHa+TM0JM5KFWNKtAtybnx4WpA+vaE0JBTY1zRvH
 TBNCX6wfSgOb7SQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX30ckJZ1Rk7TS
 HdMTAi76rU/KcgAdokqoiTIOgJ2TUtKC4MihLEgqNx5nKytPRcpq7pcUX4LnQkCFEETEMzOQ+VR
 9lv72rS25Mbl2mAPcwJp5klIrQS7kMNB7zI23sYz7qFqCu3ZiP7ergon6xAspTYV3xej57bfe9r
 MBAcp0xDNyfyQM/ur05B2l4Cdq+zlCGDNahLnIG3t4UmdmjkQCWILEwSBkyXqc337w803+2kNWJ
 NJhq0JxOptwz+OWUYHgGJjwv2hKOAGOiu8owwAewUigcBsqNwgVGqwDhRxsTaXu1haYvGQhunmY
 YqO788gRpBKh9ZqsERjqaIBtbJhedN1JOBWSqm9h2TBBn0QKiF9HmEGfs7VVP9yO/YIBBLpeBKK
 l7TDjhNEqo9wTxKOmnxnoYKLoIkNShOlO0Q4RSI1va9885yUkFu5epfYe4i3g4Tohp7SJ+6xWAc
 Cu1KXmHmZFErTjRj3gw==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aec3e3a cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=jdBmuWH1ZFAqDTLJ8pQA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: mpayRozYNsqqxv93luHhHii70okJUYhj
X-Proofpoint-GUID: mpayRozYNsqqxv93luHhHii70okJUYhj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX+fSYqUIfohlR
 UHjmzxSFlyHLnt1D6X9gZ2YwEuiLHzOuDHI+XsmcCMCmhoqUS2wzxPYP0jZJ7HDHDyLvKgViH0O
 eICeoJm22Mky5hdB3xM76QSBq9+heMk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050033

This fixes a use-after-free bug reported by sashiko and then cleans up
the error path in probe() by switching to using devm_mutex_init() and
dropping the remaining goto labels.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Assign ctx->num_vregs before scheduling the devres action
- Link to v1: https://patch.msgid.link/20261104-pwrseq-pcie-m2-uaf-v1-1-0ae1bbea9533@oss.qualcomm.com

---
Bartosz Golaszewski (2):
      power: sequencing: pcie-m2: fix use-after-free in pwrseq_pcie_m2_vregs_enable()
      power: sequencing: pcie-m2: use devm_mutex_init()

 drivers/power/sequencing/pwrseq-pcie-m2.c | 53 ++++++++++++++-----------------
 1 file changed, 24 insertions(+), 29 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-pwrseq-pcie-m2-uaf-a10209c3c4d7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

