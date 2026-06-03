Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E5399D00
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470839; cv=none; b=IXXtImS4hN58w4X8/0LFavvPY7FyR5dUxoccTVNzQqLXh4MXL8wvPmhS8gF8ko94SgvI/45eJMQjcql8s/fQJkxGcVNMz1Te3KR4JZnImEFXw0Vk8SSfyBMgFiSwH2zycOiBWJqotoYzOS8UNMrJj22rI0xrETnPqQ+ji2CMbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470839; c=relaxed/simple;
	bh=Apl5n/Pzjd9vmSQSRMgkpTLVqhSrFq2QSBpaHbx7a8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ROhjSOMjqEa32axqZRx+Yr+CCt5F8M7UhnTvZgcQ5Z4NNHRwhQ3W9laKiIVsLrSSxDNjXr2Nk1iO2Eb8nlWMmiSY+SmVR0rTi/TKQvCDi8VccVvQTHhY9N0E/mxunlIlGM1S7IzmDdTxlKNA9NIBBLiFQHl8vkllVH7jS+9eo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kBuLX+pW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HGMkRA6f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kBuLX+pW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HGMkRA6f"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RHGm2076091
	for <linux-pci@vger.kernel.org>; Wed, 3 Jun 2026 07:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a90V1I1+DRANjjP0Y4PAIs
	EY9nHVftwWmZpEDYnlklE=; b=kBuLX+pWYaJODgNPBQaQuHB4h9D/x4GNB5grET
	aS0VYppmZ9NM5T2jQ3MilDj/uPWDeheHshsvCcmqAxn2XqctjV0pe7C7gKAurCk3
	AveUvPBtHda8UHWP6uwTwChCxJfupMjGmJp8BNbIF4xXxK5y78Bo2Qe8IGlu95zy
	VW346GYSYoRSsokJPcYqFLRh38B4tNkheZFt95JYQ89wN3a5O9kMkmS8WlDy5jhl
	VEpc5iHLAYwNrnSFWdGNo/05AdDAKx54fpXXbzfclf93Afz4IQuCTz5n0DOMEpCn
	7V9+wCorH4hX7LXV87P6aZSS0MyP3L4HEfdn9HZKwWZr840A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev1880j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2026 07:13:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c272e532so37751775ad.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2026 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780470834; x=1781075634; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a90V1I1+DRANjjP0Y4PAIsEY9nHVftwWmZpEDYnlklE=;
        b=HGMkRA6fptVmaGQEz/c42gfvsFK+4NGtQs8UJawrrm/AwSgzsVJzQHl3M8dUCl27WH
         wH5Ys/hczVAM85E4jigfrrmqyoM6ewKhSA9kZp38YE+meijEQjBtLU2cNAhC8QNAhFfT
         NRLQxjwpKZU3nyxImToalL536dI3VOF8m499n1QkABn5UY93zCWYLJAI0Rnx4QMlpGFq
         pJWa56BjOp/XZpXyB4o542+p69o6Q8LbXUo1/MZUwL7y/rqHNxDTcFEPJwliwCei+8OT
         11HNMalOSnw2j6NfRN6x+Tl8c/TxjceTB/r3L/0+WVzoh3kIE9tlSpJPgT0StTNZsgk3
         IFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780470834; x=1781075634;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a90V1I1+DRANjjP0Y4PAIsEY9nHVftwWmZpEDYnlklE=;
        b=OM0QXujp/Un3v8GO+kipGhqptw4w+PdBgfuIT/M/zBMn4kVmtFCoHyn8Jiu9krrIEq
         +iyyacBGZ4tIcPdQl3iWI/M4UvHT5coSQTQryQyScwj3ZsaHNNmtOL/Lb8afL5EApVGl
         MEBtwnRnW20/KGmSe7kHttZ7W8UEFbMOfRwMbK1RNJ7TMEjIKpNqGA1ul23/Gz2zw0RJ
         ml+byhKhohmoEd5ozVGh3gdT8isH4NazSS7l/P8YCTSHU+ohM3/UD/YJoL5H058YFTwO
         z9qut3Q+V3hZ1nOkhHbBj0HPixN71B8ia8WRoSxZWsEpRn0e1teNcfnpYG4u4gzvT9jN
         zKSw==
X-Forwarded-Encrypted: i=1; AFNElJ+QH7jlJ+Url4xmScJJ5FBtZr6tNnLSX5ARK3T5byLchR8guKJ/J/YC97B8X2K8ibzzwaggyLqWYlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZWc6lgiDMcm8321KwIn6EdsYU7kbEPDcIeat2G6hKYGa7myC1
	L4XaVDv9RL58Q1KbL93m1trh/vcAy1h8Al25uYkJYGovvWjw4o/mCwhoBZjiDE9g1vqAwPdXj89
	Zq2aFL7QqVy91Tn/+/TR+11wC2pXTE+i38tGciHFitGKvnB5/LAlWTXyAr2hSDm8=
X-Gm-Gg: Acq92OER/5MP8SDOt2xU3hpbVrVJ20wARMDON0gJdgo4lGYWFeAuIyUSZdQoNQwhYN/
	XW0nkIiBGh7nVYsxYwhV+bKIx3XRR3HeUpu/X+Eh/CZwuPZbR9XPOQZXn9ZjFoZykgDFgXjdqMs
	CA4mIZb4ZpvOeSQtd5i3sgnb611Z2vJ+Mvje0O4m0A+Am1Al991x+A09U3OZ7sWoKw1fG58xiv0
	66aVtyy+u63VMXGCeA3t+UOLxOgX0Om/lWOy3Bj5+uPv1ovWPKiNpPLgVrsYwEXCziYWAuJD98X
	eU2fnwGWnUJPPMebcb+QAZtp6LpyfPynDqcx+89GIIoosiT/hZb+SQt6U95zIHhLPREiRGW9OFY
	DjzDICcVJlWE48ccDEk7VP9iBxK0wY+7wOAAnzau+YBa/eCNLl5sFu4ktB4nkvr/8t18=
X-Received: by 2002:a17:903:2ac7:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2c1643aafcbmr22604895ad.37.1780470834363;
        Wed, 03 Jun 2026 00:13:54 -0700 (PDT)
X-Received: by 2002:a17:903:2ac7:b0:2b4:6d92:b002 with SMTP id d9443c01a7336-2c1643aafcbmr22604615ad.37.1780470833821;
        Wed, 03 Jun 2026 00:13:53 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8429fsm17249725ad.18.2026.06.03.00.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 00:13:53 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v16 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Wed, 03 Jun 2026 12:43:11 +0530
Message-Id: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAfUH2oC/33QzWrDMAwA4FcpPi/F8l/jnfYeYxRFlldD2nTxG
 jZK3n1OL83B2UUgIX1CuovMY+IsXnd3MfKUchouJQH3shN0wssnNymUglBSOaklNFccMx/TcD7
 fjsR9nxsgrQ+uRe46FGXuOnJMPw/0/aPkp5S/h/H3sWPyS/U/bfKNbEyAjpiJLMPbkPP+64Y9l
 a59CWJBJ5BrydckkIUipyIhWoTQblGwopStUlAoiBzRkuRW0RalVpSu3geqUIEpBi0tM/otSj8
 pI9sqpQsV0Stgr5yDbosyK0qZKmUWKkgVATpHevNX9klZJauULVRno/cYDB+4Rs3z/Ad2ByTlf
 AIAAA==
X-Change-ID: 20260301-parse_iommu_cells-1c33768aebba
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780470825; l=13317;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=Apl5n/Pzjd9vmSQSRMgkpTLVqhSrFq2QSBpaHbx7a8I=;
 b=QFGRXpY+qWmK+T7ctaWDbrINLCs1a9+0pUeDE1gl/BFcv55CiE90+ngTegwN4D1pcQzq3q59E
 NMVAa6JhzU8AzrSXEKGgT9s2yVMyWrIE5DzBeuN0+uwPYqDe9KB2fVF
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-ORIG-GUID: EQ_0NsinrpEtlBmBRAvzgxC0PGJz7T1L
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a1fd433 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=c92rfblmAAAA:8 a=bC-a23v3AAAA:8 a=zd2uoN0lAAAA:8 a=tA7aZXjiAAAA:8
 a=7CQSdrXTAAAA:8 a=8AirrxEcAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8
 a=iox4zFpeAAAA:8 a=DBfv99YmAAAA:8 a=JfrnYn6hAAAA:8 a=cWRNjhkoAAAA:8
 a=HuIPyozGVqDkMI16_zEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22 a=sVa6W5Aao32NNC1mekxh:22
X-Proofpoint-GUID: EQ_0NsinrpEtlBmBRAvzgxC0PGJz7T1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfX2N9w9mX46W+0
 5Fy9ym8vgBnefWnc/4GD23N/5vz9XaGZ7Tmf1+CxAb+aG+dZ+8zrQD/M6HVwnuZIFMlzBA134GS
 prvwVo8wzTFr5OSdx+rV/of3NR8q9gr8ECp7kP8REh/rXqcTv7LMMREGmpd+lkFr1+oJJYgRBar
 hbolBYnIuVz3+46zAUW+Rl0tPGpGkQRFhR3/i0L4UkLoYLfVr67an0R1L3ONBvYYLW+J8wy4/ii
 KYcphP/IRM9Rd2dYUxMJxU6E16tNQfNEX4lEwPQPZl2856LZhO8FBU6mGO0JMFoIZvuGDdXz3d9
 HeMdTE/VD5bhSOlmqgfZNZ0mSIUGxe3a9aeKOH/SnVRR1fvN33VZRW8+lDBC6+eBeAwdXkrEoad
 4YTxsOggDusEvs5h5G86OEXYLSTGchIm31iZ048503yNM9T3eIFvWQxjJwdOiQvXx9soTu3hJcf
 XuElmvhXXqP+WE+p8Pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066

So far our parsing of {iommu,msi}-map properties has always blindly
assumed that the output specifiers will always have exactly 1 cell.
This typically does happen to be the case, but is not actually enforced
(and the PCI msi-map binding even explicitly states support for 0 or 1
cells) - as a result we've now ended up with dodgy DTs out in the field
which depend on this behaviour to map a 1-cell specifier for a 2-cell
provider, despite that being bogus per the bindings themselves.

Since there is some potential use[1] in being able to map at least
single input IDs to multi-cell output specifiers (and properly support
0-cell outputs as well), add support for properly parsing and using the
target nodes' #cells values, albeit with the unfortunate complication of
still having to work around expectations of the old behaviour too.
							-- Robin.

Unlike single #{}-cell, it is complex to establish a linear relation
between input 'id' and output specifier for multi-cell properties, thus
it is always expected that len never going to be > 1.

These changes have been tested on QEMU for the arm64 architecture and
on the glymur platform [3].

Since, this would also need update in dt-schema, raised PR[2] for the
same.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
[2] PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184
[3] https://lore.kernel.org/all/20260515-glymur-v6-5-f6a99cb43a24@oss.qualcomm.com/

V16:
  - Patch 2: Fix potential NULL pointer dereference in of_msi_xlate()
    when msi_np is NULL. Guard the of_check_msi_parent() call with
    "if (msi_np && ...)" to handle the case where the caller passes
    NULL for msi_np, as documented. Reported by Sashiko [1].
  - Patch 2: Fix OF node refcount leak in of_msi_map_get_device_domain():
    np was never released after of_msi_xlate() transferred ownership.
  - Patch 3: Default to 1-cell output specifier when the target node
    lacks the #iommu-cells/#msi-cells property, for backward
    compatibility with controllers that predate the property
    (e.g. arm,gic-v2m-frame). Reported by Sashiko [1].
  - Patch 3: Add !cells_name to the initial parameter guard in
    of_map_id() to prevent a crash if cells_name is NULL.
    Reported by Sashiko [1].

  [1] https://sashiko.dev/#/patchset/20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com

  Link to V15:
  https://lore.kernel.org/all/20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com/

V15:
  Address Sashiko AI review comments on v14:

  Patch 2:
  - [Critical] pci-imx6: pass &msi_filter (not NULL) to of_map_msi_id()
    so that of_map_id() returns -ENODEV when msi-map is absent, preventing
    the '!err_m && !msi_spec.np' path from incorrectly returning -EINVAL
  - [High] of_map_id(): explicitly set arg->np = NULL before any bypass
    path so callers can safely call of_node_put(arg->np) on all return paths
  - [Medium] of_msi_xlate(): pass msi_np directly to of_map_msi_id() and
    of_check_msi_parent() (removing the local_np/np indirection), and use
    'break' (not 'continue') when msi_spec.np is NULL so that msi-parent
    bindings are still checked when msi-map is present but has no match
  - Guard 'id_out = msi_spec.args[0]' with 'args_count > 0' in
    of_msi_xlate() to correctly handle 0-cell MSI output specifiers
  - Use of_node_get() + unconditional of_node_put() in of_msi_xlate()
    for clearer reference ownership

  Patch 3:
  - [Critical] of_map_id(): add 'cells > MAX_PHANDLE_ARGS' check before
    using cells as an array index to prevent stack buffer overflow
  - [High] of_map_id(): the MAX_PHANDLE_ARGS bound on cells also prevents
    integer overflow in the '3 + cells' length check
  - [High] of_map_id(): fix misleading bad-map workaround message from
    "assuming extra cell of 0" to "treating as 1-cell output" to accurately
    describe the actual behavior
  - [Medium] of_msi_xlate(): guard 'id_out = msi_spec.args[0]' with
    'args_count > 0' to preserve id_in for 0-cell MSI output specifiers

  Link to v14:
  https://patch.msgid.link/20260424-parse_iommu_cells-v14-0-fd02f11b6c38@oss.qualcomm.com

V14:
  - Updated Patch 2 ("of: Factor arguments passed to of_map_id() into a struct") to
    fix below two issues in of_msi_xlate() that were introduced by the API refactoring:

    1) The refactoring changed of_map_id()'s dual-purpose **target parameter to
    an explicit filter_np parameter. In of_msi_xlate(), this caused
    of_map_msi_id() to return 0 (pass-through) instead of -ENODEV when a node
    has no msi-map, terminating the device hierarchy walk prematurely before
    reaching the root complex node that has the msi-map. This broke MSI
    allocation for PCIe endpoint devices (e.g., wcn7850 Wi-Fi on ARM64).

    2) Additionally, fsl_mc_get_msi_id() passes msi_np == NULL to of_msi_xlate(),
    which would dereference NULL with the new API.

  Link to v13:
  https://patch.msgid.link/20260408-parse_iommu_cells-v13-0-fa921e92661b@oss.qualcomm.com

V13:
  - Fix bad_map handling in of_map_id(): 'cells' is re-initialized to 0
    on each loop iteration, so the !bad_map guard was insufficient, cells
    stayed 0 for all entries after the first. Fix by explicitly setting
    cells=1 when bad_map is true on every iteration.
  - Collected Acked-by from Frank Li.

  Link to v12:
  https://patch.msgid.link/20260331-parse_iommu_cells-v12-0-decfd305eea9@oss.qualcomm.com

V12:
  - Call of_node_put() unconditionally in imx_pcie_add_lut_by_rid()
    thereby addressing comments from Bjorn Helgaas.

  Link to v11:
  https://lore.kernel.org/r/20260325-parse_iommu_cells-v11-0-1fefa5c0e82c@oss.qualcomm.com

V11:
  - Added explicit filter_np parameter to of_map_id() and of_map_msi_id()
    per Dmitry Baryshkov's review feedback, making the filter explicit
    instead of overloading arg->np as both input filter and output parameter.
  - Removed of_node_put() from inside of_map_id(), making the caller responsible
    for reference management. Updated of_msi_xlate() to properly handle reference counting.
  - Collected ACKed by tags, and fixed minor typos.
  Link to v10:
  https://lore.kernel.org/r/20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com

V10:
  - Move of_map_iommu_id()/of_map_msi_id() from include/linux/of.h to
    drivers/of/base.c as out-of-line helpers per feedback from Marc Zyngier
    and Rob Herring.
  - Add kernel-doc to document both helpers for discoverability and
    usage clarity.
  - Fix of_map_msi_id() wrapper and all its callers (cdx_msi.c,
    irq-gic-its-msi-parent.c, drivers/of/irq.c) to correctly use the new
    struct of_phandle_args-based API with proper of_node_put() handling
    as per feeback from Dmitry.
  Link to v9:
  https://lore.kernel.org/r/20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com

V9:
  - Updated TO/CC list based on feedback to include all relevant
    maintainers.
  - No functional changes to the patches themselves.

  Link to V8:
  https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/

V8:
  - Removed mentions of of_map_args from commit message to match code.

  Link to V7:
  https://lore.kernel.org/all/20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com/

V7:
  - Removed of_map_id_args structure and replaced it with
    of_phandle_args as suggested by Dmitry.

  Link to V6:
  https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/

V6:
  - Fixed build error reported by kernel test bot.

  Link to V5:
  https://lore.kernel.org/all/20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com/

V5:
  - Fixed Build Warnings.
  - Raised PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184

  Link to V4:
  https://lore.kernel.org/all/20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com/

V4:
  - Added Reviewed-by tag.
  - Resolved warnings reported by kernel test bot, minor code
    reorganization.

  Link to V3:
  https://lore.kernel.org/all/20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com/

V3:
  - Added Reviewed-by tag.
  - Updated of_map_id_args struct as a wrapper to of_phandle_args and
    added comment description as suggested by Rob Herring.

  Link to V2:
  https://lore.kernel.org/all/20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com/

V2:
  - Incorporated the patches from Robin that does the clean implementation.
  - Dropped the patches the were adding multi-map support from this series
    as suggested.

V1:
 https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/

RFC:
 https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r

Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
To: Nipun Gupta <nipun.gupta@amd.com>
To: Nikhil Agarwal <nikhil.agarwal@amd.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Krzysztof Wilczy\u0144ski <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>
To: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: xen-devel@lists.xenproject.org

---

To: Nipun Gupta <nipun.gupta@amd.com>
To: Nikhil Agarwal <nikhil.agarwal@amd.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Krzysztof Wilczy\u0144ski <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>
To: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: xen-devel@lists.xenproject.org

---
Charan Teja Kalla (1):
      of: Factor arguments passed to of_map_id() into a struct

Robin Murphy (2):
      of: Add convenience wrappers for of_map_id()
      of: Respect #{iommu,msi}-cells in maps

 drivers/cdx/cdx_msi.c                    |  10 +-
 drivers/iommu/of_iommu.c                 |   6 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |  10 +-
 drivers/of/base.c                        | 227 +++++++++++++++++++++++++------
 drivers/of/irq.c                         |  25 +++-
 drivers/pci/controller/dwc/pci-imx6.c    |  55 ++++----
 drivers/pci/controller/pcie-apple.c      |   6 +-
 drivers/xen/grant-dma-ops.c              |   5 +-
 include/linux/of.h                       |  32 ++++-
 9 files changed, 277 insertions(+), 99 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260301-parse_iommu_cells-1c33768aebba

Best regards,
--  
Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>

---
Charan Teja Kalla (1):
      of: Factor arguments passed to of_map_id() into a struct

Robin Murphy (2):
      of: Add convenience wrappers for of_map_id()
      of: Respect #{iommu,msi}-cells in maps

 drivers/cdx/cdx_msi.c                    |  10 +-
 drivers/iommu/of_iommu.c                 |   6 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |  10 +-
 drivers/of/base.c                        | 227 +++++++++++++++++++++++++------
 drivers/of/irq.c                         |  32 +++--
 drivers/pci/controller/dwc/pci-imx6.c    |  55 ++++----
 drivers/pci/controller/pcie-apple.c      |   6 +-
 drivers/xen/grant-dma-ops.c              |   5 +-
 include/linux/of.h                       |  32 ++++-
 9 files changed, 282 insertions(+), 101 deletions(-)
---
base-commit: cdf5682bcd98422242d95c4e6c10f9c38bcf56c7
change-id: 20260301-parse_iommu_cells-1c33768aebba

Best regards,
--  
Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>

