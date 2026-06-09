Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F44233921
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012771; cv=none; b=JUqdR5VmhDSwpokyDUpE8Gkr/nYyF5B+g58FV2J/rxHclcG9f1j2xf9U0QV50KXaHf7fixYSZJU+lDlMua3igJRDUgQ4ZnhqrgugDwDU2r/dJUwLaTXQnko6QUaWUzBJPA+JKpF69qMjGu+Vh2TwRKOw9IX2ITGp+1v6y5SfUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012771; c=relaxed/simple;
	bh=x8FGuuvEVnnO9SBxvZFpvT8usiFSUi45emEYRvU3SJQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WbguTGL/rYkQ+slygw8o6D+woPg59t3X/ztzq4so4j04SgHiXFuXhjgJJHn4bJqkKaheSGsU5d7Ih9QFo4TW+PRDqdoOUK8dxhhhQ52nmgbk0em4d++e4b7pr/buW9gs34pMuRU5w+6XdQoGhaxfBtUWwNyfYCbtQ0Xo9IgIJ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bpvsj4Aq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VOAUD40j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bpvsj4Aq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VOAUD40j"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClQow2286794
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 13:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BvgE76byBkrnG87M5GQBzCx6Gesq1V6QYXCaC3lyE7g=; b=Bpvsj4Aq+hkB8ev8
	qS6V/ThclFQ3bGiM/zhmvfP1JnwDvp5OTRRNPWDWQIb/MzuMT87JhlKABvlMp3fh
	MGiTqfaSZS8MZxSlg5VqbWXMILDaBSOn/YTeV/dz+yizmy2Jollw59kpX+azu0Zj
	6N98UocmW1+IIAUAQ3vlVvAMEa3tQ5Gbk6CJOayZ08e4G2GFUMNQV5LMrjsFDKAD
	ovPn7ixC8dR/eNap4G79Brm9XBBks0js5eyB9FjOfpE+UsQ3xy906aWZgzanyEih
	11RsMpE6Tn975TMFt573T5AhmQ5t4aoNDpACJZxu4EbrEfFC9rPIjRoJsPAtX7r8
	7/dCQA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3js57r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 13:46:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bbdcf36f0so4921254a91.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781012769; x=1781617569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvgE76byBkrnG87M5GQBzCx6Gesq1V6QYXCaC3lyE7g=;
        b=VOAUD40jJ8oYzMPjMTaacix8R8jeBb3teg790j7vL/tvyJW8xbkDuTPcWtqyIgRD6L
         p7RBsqAAJygbSi/Npybx4R8zteTZX+48ihbqyw3OrOrIkuMhuqY2HCv3G5G5Z8cY6Svk
         KhB4MoDpxMRA65SyShDXr8/KN3P5gyxHKDrZdiBOnRZBWPj0el1VWkqrG6xDRM60QB8Q
         iHjOzCe8iAcrqi0DrcBN0H6m9nXyeEhNYGcpMlf7VPQ4m+OD2VgGmNMH8WecCtKYzXI5
         qyJlXLqikTZfqtvXNCXpcG1Y2WOsbTd5180ODFK3M5341smDEHDHA9RpWUN0bWCAUkCw
         Uurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012769; x=1781617569;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BvgE76byBkrnG87M5GQBzCx6Gesq1V6QYXCaC3lyE7g=;
        b=GM7CDJkR8Kyv29bLS2EOQ9yQ48AvPJVH/Pv1GYtRmV5LM3i2rCPLHDiF4bRiCQZZph
         Zl272Q+qpEky/QDrGAFJ+5iF0pxhCQRFh4nN/tcEe2TlOgEwGzdirwEEjVaugAdgPw5y
         ElaUqWcJUVQgEaRpsyIoAEZYgMfYbF8z/+VgS5EbmYuYgqnYwBmvpK/9a5k/PivHwX49
         O75kbzKejrBpJcicYbdUnGqPYA62zGzmd/g2lzoKruIJEI5H+Ux2GjyeyNxWgh30cDt5
         sQM1nI5QvFmFqK25xbyrpDdnzzQEDRuFay51iqwJbGkDvQqUmLaHuxmMSd7wFAXSm5D3
         NNRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pGJqzmH5Idaq7zFeG3wLvjPC4sC5tP/BX+PdNEciKEfqafNMxht1OoLEstaDNmaakrUEgrAXye38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWHS+bdD4ZHQAUhtIsxQ+mXxroDq/OvCjG/7CbplTJpjxLrDa
	QZBgal4ItEOL06WoGwsYWI3aZBnI0hjPMm/5X8EsLck59wWoBfZ27sIVinoDJDxPegM+GThVvx/
	kkTMWJHQL0F3+5iPIGEVINCG9LYOsEDUcn7fecnqM0sKk0c+ghYtQbdyYFUMIDqDOmqpBoGo=
X-Gm-Gg: Acq92OFum2fKNyyJscKmWkbiqFtBhEr6jfrxNbdrb3rAs42rFMr3kDOZvk6HODX2GVY
	ooc5U1c+WzjvGnCHi9fwL5PF+egFIx1O1IZQeoxWFUrYQpuU7BICU4ihhq5BbWj2F6Do6AOvFmA
	yrgjmBy6rdCAyrOTJzZWKEtw9ZZllss4vOTqaFFOltaKFKJ9RNqPpRPeumdwc3sr55OdBQarNLX
	AVivNUdNpfvfdnlB5/nwiPRc3b8VjfTOWjiMZTX2BO3NRaTQOa5dSZI4Aw/rMzwWSwGlPEI588q
	dTDMDv/0MaV8fbKUwGT0zlTu+AIZozsMmdG7EFqyrkW3q94ncx9EPf6FZiyrsOHCvOmqI1SdeP2
	98ptN7aIhRis28A3ft5KM0DDM+wXFSNc=
X-Received: by 2002:a17:90b:582b:b0:36b:b903:994 with SMTP id 98e67ed59e1d1-3713029bfb8mr16531443a91.4.1781012768690;
        Tue, 09 Jun 2026 06:46:08 -0700 (PDT)
X-Received: by 2002:a17:90b:582b:b0:36b:b903:994 with SMTP id 98e67ed59e1d1-3713029bfb8mr16531402a91.4.1781012768027;
        Tue, 09 Jun 2026 06:46:08 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.129.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712fcb3a9fsm9454149a91.0.2026.06.09.06.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:46:06 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        lirongqing <lirongqing@baidu.com>
In-Reply-To: <20260515005552.2343-1-lirongqing@baidu.com>
References: <20260515005552.2343-1-lirongqing@baidu.com>
Subject: Re: [PATCH] PCI: mediatek: Fix operator precedence in
 PCIE_FTS_NUM_L0 macro
Message-Id: <178101276196.5924.6945802406808403415.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 19:16:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: kwxeQZkUO-lpyWSFKQUQOA5QPjN3ls1m
X-Authority-Analysis: v=2.4 cv=aa9RWxot c=1 sm=1 tr=0 ts=6a281921 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=4E6x9rGNEmwsBi5Sc5cS6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=z5-zIPkyTPHoBrqrsb8A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzMSBTYWx0ZWRfX92WTV0X+QfHb
 OpC4C3UojYEGE5MiC2st0q7ZEFIvbWOnWflN/suABbxFuYeMUtKI7AxNgVrOEC5MJuX/6e62kvF
 Qb5pY1ykQqRvA8WBYhJJGmodWrPZFXIMrJm1Enlfdf2c31eoS+OTogZTe4twu9pN1X7WjDFcLgE
 4xGmGCZnO3lR6aokdziL0BLcI6pguevoFzzHbgUqJfhsVEMRcSX6Qh4iYMW16/4uFt/guGFadPj
 tmYbfrsBXl56yUsB7uUzAl+KznXdk4ekG6LDobLdam3vbjbIUtVuxLPhD3IF38UJJIwJndJf3np
 j1UaU8PpgFsyzcfTnnBAHCOMNTteyLBmS69pgFNxYRhLqBvW9kGOPXEnN4LfsYOED4QpJ+tDQjM
 U9VPOO0Gd8p9/9TbEnvV4x+HK2QyJURXG3fYfoGmEvKVVF/1u2pWl9AQo7iTD99FDem1E6pt8HK
 OQDLOhB1GYjPnatrXrA==
X-Proofpoint-ORIG-GUID: kwxeQZkUO-lpyWSFKQUQOA5QPjN3ls1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090131


On Thu, 14 May 2026 20:55:52 -0400, lirongqing wrote:
> The original PCIE_FTS_NUM_L0(x) macro was buggy due to improper operator
> precedence, where ((x) & 0xff << 8) was evaluated as ((x) & 0xff00).
> 
> Instead of just fixing the parentheses, use the standard FIELD_PREP()
> macro. This makes the code more robust by automatically handling masks
> and shifts, while also adding compile-time type and range checking to
> ensure the value fits within PCIE_FTS_NUM_MASK.
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek: Fix operator precedence in PCIE_FTS_NUM_L0 macro
      commit: 282305d7e9c0e27fd8b4df34b7cd5506a1eccdd6

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

