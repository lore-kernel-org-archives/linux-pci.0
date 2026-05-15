Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EC4EA381
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865052; cv=none; b=tgaY9KWDnMakgyD2X4LWUBcjM5pkTXdEaaY5yHLwPnLZMbb+9EQyBeohBCWC10dGitJfhGT+h5Bua3xL7hdCulayQ+7PT+Rw1aItVZiM04BY63OAZmriAzXm/j9d9luMHhh1MwbvX3VtJ4w9i1WZnKWBOwZkaHAugOCCmeY78zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865052; c=relaxed/simple;
	bh=3Tl5aQy2w6IrccP/oBSguy3DD60hEyRLFgCvPwyaGF0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tqwbiUGdfFiixDFKwfrwS4+ilXOJlvRSnUQgukHyhc9WEaTwaplXp3a9BPRsUCA2c9gUfsndRQ9RI+iBKbaQn0AdBPkF8wrpKoyJw3yeKsVtj3H9DwnqbNuxZq70MNOiq+y/ia5X317QGqJ5Sf7SIBaqy8tJhDh4NCUKWMjwhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vt/W4/ZE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HYb4Xja7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vt/W4/ZE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HYb4Xja7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FB1riM3197662
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7J3thL3GCbBboipeCsQGXuYdZX1osalYVS/liyYpuX0=; b=Vt/W4/ZEBO4rtbth
	qWohdHMfN0rnbYTHu21stt0jb0kA0IfY8QKPwKx56++woTM1LZzwhmeVm9NZ531U
	uwqbn58PBl67Vt6mXcW3x4ev+rAL9PoLjln6ih80bSV6LFfFW24aJtK8vi8SZfxy
	vxiiDYB7+9zld/t67cFGuiLxPtYYpLiRfUpBMFSXMIZ8fvyZlOFv+V5Ah4IJlqFJ
	fpIapO38VaHrryghBJMCBsRse2kjib5FAzTYTAvpzj3AwrnOGDnoo6Pzw3dhuWEU
	GAmOhOeHq9xORYRBRSDFnWIFze5dL/nNG4aoNfAy+VKImrJTRwaJJJzLlG2FtujR
	nXjyjQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qc5mk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:10:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b9b8137828so1491655ad.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778865049; x=1779469849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J3thL3GCbBboipeCsQGXuYdZX1osalYVS/liyYpuX0=;
        b=HYb4Xja7bGg6hq+EcbT9JtSYzzZLUY6zfg4Ov+JYVCsFW3dYXlCzvjsrsqmb+orOu9
         ShOX0vB4GdltsLqEdO1ckrP8GQQOx8UzEPy5NwRMxPeOXNkqEZ4PG4tBR+3RZ9pmivz2
         8x+2xr7b9Rzyx5wnDuiSXka6bcmMNiy/bPJNB7CjP9b50s0laHhagvCQlyExsmgG4hpN
         kqWsoJ5KeyCy8sNSL9kNReImTioO/50DGGYuJA5MrhdVb86YEOQcpeRGt7gFPKcsE7Pn
         uMRKnRvaO2poIaiu/R+gbIThvt38nDWk0y+5qIUbZkOLWLMTEHD9Rd0XZmVO7DhQGGuR
         CS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865049; x=1779469849;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7J3thL3GCbBboipeCsQGXuYdZX1osalYVS/liyYpuX0=;
        b=Q5EyW6ZWE6hAwoTEpFT59RIyELYzBelRw1OV0hAeZAoFwfIRxFFY7mG3U/HJoCdmm5
         lsc6+VysM8GZN4l144OCzFKv1dsjMcbNMWpTxevgjDvR9IOzqK4b/LNH0mvEhiZi1Pmu
         LOJ4xcjmCcnTj/V1Lj9kc/I+ZjPPJfrt1GfJfS4gkoT+xnTQO3HcNF3dsGbfhiyVBKb7
         uq3fIOJpaB1GsxoFfqSJHcRQRa6fXLQ7r/39F/h3jeJt57P+jwUIAWwU0EDO+a4OB6LI
         KvFOTTWB/lngFuyqs/qnIsS2aMgsBZIc9TyxnQv6DmWeoVO7ez1xAEtA9XcNJhlvdOFO
         XZOg==
X-Gm-Message-State: AOJu0YyDwTWIeW1lgyyOsNEKxw7RDa7PNoByy+mquhXtAjG27WcG5zxl
	ymW8qpI+IOB7fQqUE+4hXDXiYcAQl91BALVNjxULJ2HFL9ZIOh5zqCe9l3urfWvgsRcZS665uoS
	lZso+OaZBuxdtCTkygiV1mXJ3aLsPfWm4vvhXkPmYW+RwKntdRvlfbQ1yGsGAAU8=
X-Gm-Gg: Acq92OGSG5cti5buc3ZAbNMSfuhZAFk4N0S7qcS7XJ/wqZG4MW18vLW/ZGGlXLDpAiw
	WZ8q8z0A2WgLiswSt2uVUqgItgk9kuKi0hgeL4hmossUWgSwShN2Kqu4EK4efCg/mLJi1ccEV/b
	N4SV6dzFb/a51Y/r3B+zT3SW4OLii8XiMGozpd3650npeM+9/Vtm5Ut391cHkNDHIr2wIqXFU4V
	kIiYgnOvw9IKhW15c5PCIBIF/wuPVYbxUO00+fmgX1y5htn+SG41N1gbPbz49Ut1I1mOzagcgdg
	zuz97tw2efLsKyea5cIOSEdjXkKPtZkasOmw3HLcwrpXDey3diGFxOTLam5AZ1CB7q+buSzgHCJ
	3MukbIAaxs3NqpXU2T6ft
X-Received: by 2002:a17:903:13c8:b0:2bd:8395:feca with SMTP id d9443c01a7336-2bd839605e4mr45821805ad.23.1778865049253;
        Fri, 15 May 2026 10:10:49 -0700 (PDT)
X-Received: by 2002:a17:903:13c8:b0:2bd:8395:feca with SMTP id d9443c01a7336-2bd839605e4mr45821425ad.23.1778865048670;
        Fri, 15 May 2026 10:10:48 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.141.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d234540sm64176835ad.79.2026.05.15.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:10:47 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260505105918.1823170-1-wenst@chromium.org>
References: <20260505105918.1823170-1-wenst@chromium.org>
Subject: Re: [PATCH] PCI: mediatek-gen3: Do full device power down on
 removal
Message-Id: <177886504429.10117.12525954278575161298.b4-ty@kernel.org>
Date: Fri, 15 May 2026 22:40:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 1wx3oMHGqDR-xAfDlAw_JWvLpXwukFUN
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a07539a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=8TBCxnFsifAbGBbxUCxq8g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=Gg1cva48JAy7FFupKUQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfX9GP20NDEMylO
 HUmp+wt1aKZOcVy+mepAL4prMRMlIQn8qWX3wFoPBFoYFfMvfHKc9W8uQf5hkCV/nLMoL6xGTwe
 YTBczJDMDzCNTbQO7LzJZpiylyjTZdQjfMsU+eDV3s1E+i0AhMpRrXfOuv0p57zqW5K2mYTNZti
 40UlPH557IMnzAZ+INvc0FP9+hMj3CtOyDz0i+DnRGDA8HiQJE0JJPAKLlmRxW2eXYWNmkRVbqN
 2462IkvIftDdrk3zYNrYoCVzmdtPN/CYxzZofl1Mub7RLTIwUg0UTqTe7ygzTjT3OD/bag4ImcZ
 YS6p+NNYKEK1fQwsv1r89FGkruXqEgZc+8HWA/AZQatJC+H87Fh7lJLyKcBWhEj1sF3msqq8C6h
 To6szhUDG0aP307kXMubXdq7DtCCphLS0QBwtAJTd+LyomfE0HSfRwHDPHjn2N4e/pIJg9dGh/N
 EAd0DIlRhIc2hNgfwgw==
X-Proofpoint-ORIG-GUID: 1wx3oMHGqDR-xAfDlAw_JWvLpXwukFUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175


On Tue, 05 May 2026 18:59:16 +0800, Chen-Yu Tsai wrote:
> When power control for downstream devices was introduced in the
> mediatek-gen3 PCIe controller driver, only the power to the downstream
> devices was cut when the controller driver is removed. This matched
> existing behavior, but in hindsight a proper power down sequence should
> have been followed.
> 
> Call mtk_pcie_devices_power_down() on driver removal so that in addition
> to removing power from the downstream devices, PERST# is asserted.
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek-gen3: Do full device power down on removal
      commit: 2b16d6b9de2f00fd8ecc433b15205c18f8276b3e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

