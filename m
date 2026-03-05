Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB0347FEE
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709926; cv=none; b=a/aQKQNY1U13C+EgV6W5PSeQrTrh+8n62KA8BZrmJ00D2ULjDWZ3WL1ZHv5cl+/UOfE4YVT+pcLeVecFds5SCfillbsLSWhDcb8V1z2cdwmABIdDFRpGWdv1z6aTI5UHaja6gMHVl/nUC8/Cl1o1SwMZltaIdwY8IIbzIF8RzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709926; c=relaxed/simple;
	bh=OKaOPeoB08Ev24ossXN8DF59mMcz4l/TtbCgHEn8+mU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EJFoK9rQr3/eHE55r5MBft/rT48ybqItPmkGb5gUCmzZwTUpgNxZz6VO2T0JcszWlYa+2PSv6u+JfA7CBD+TSI+h+jyaaI0/0EeE/3p+2ev9P6wEc6mnyX/JvxCIRbiUhJS+Hzyp67hxeK2ozCA34sCgUltRPkzIL5p+qHUMKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bzrtt2Gi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S5rJMiOX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bzrtt2Gi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S5rJMiOX"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AUFh7169125
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 11:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qCaqx93JCAENW1nRSG9AMS/82dshB5hfXtMYMvCEMh4=; b=Bzrtt2GifPS+ynQ4
	60p5eosCH7g26dQb1mKXhfd0YAhCnyWNJbNzKNgy2dCikZlrjxQKqZFMQasyHIVB
	dGEzDAvd9bzxvGV/+FD0xoVVPnr9Q/uiJ7gAs2EeDyuYoWwrTDZqvUWHKzibJ6dR
	6cSx13EqcnUEXMmSc0DJ4/ESBkWNmWAs5zGvir7fvnR4cBueIvwpZUEtpFuR9Ko/
	CVVlDDw5jbx1BZq5XemT5GIQgr88e2hY/IyrapkPxy4V7LX20hvFzIotNSjjboBx
	HulXq2BSW62enSbeixCqzJlAxOFvZnkYjSUZOQJkS4w0Z6wDoA0blgnXtcbBeFGU
	25BgZw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq84w84d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 11:25:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c738f3fe31eso360651a12.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 03:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772709923; x=1773314723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCaqx93JCAENW1nRSG9AMS/82dshB5hfXtMYMvCEMh4=;
        b=S5rJMiOXnUtsEy+3yOjTGgTWpNEk2RJp0V9GywQa7xvPLoLZpa729X2Wr9sGFidmOP
         vgaCiZ8MBWqdG5kRdz17O4z2EWKwCvQbauk+UtR+OQPRptQA+5ryNFmiJV9Z1GC4taSG
         VcygaCTTmHzKgBKPjV3ZplIuH0GIHNUXeNOW++Sw3yVo4y7L1VjsOXHkGfLYS6xyKZiE
         cxJIpNsAJta4aJoh/pnC9yHF8SyjEPzlgGuG4ItFktc2Wb53hYPn9uWDNWWEKOUyUIxH
         kbPNPmyA7vEu+QQDxxgp9injwkIPmlEQFwuT3j/EFCfgXqmi5DWi2In/YELcnxvr0kXE
         B/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709923; x=1773314723;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCaqx93JCAENW1nRSG9AMS/82dshB5hfXtMYMvCEMh4=;
        b=sHA1zzQf71HrrP7Hs2yaU7Er8/PTx3934DAxTjdn4wPX1vKpqhC/kRSEmUZWB8OrAe
         afaha5br1g2hY14CC4YW0XzpgQZc+LX5X+S6qX6tS7//5/J6tmOKMGopBIuM3YgEMR21
         2dXirgUQdowM8wv/FQvFSBHO4wyEZtSTm9zWJy/tFOqOeVeDSPOcKBVO5j/sVxEcNBQF
         mtR5+hexOb/eD8li10xFMYxPhtHqtmhgxHUiGrx2IikjkPKjg7zylQxKrzM9SSjuxCJO
         FIlHPFotpdk8Xrb8j1izV0hF9JJ1Lu7AaumwnJr9AkfUUfO20kZRcqHzATTkJ+BrjwsJ
         gPNg==
X-Forwarded-Encrypted: i=1; AJvYcCW9GBN2MgGfv83QR4xWiyIO24EuidoirNusyhHvxFFTCd/DRoM/k+32SOrI+7vTUwt8LD7fQnhvKb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xiWuLdfWo59NOXlDITZPzWEyM5mC8ejPv2e4pzzDA+R3dYiG
	dkJZSaaEzaUBH+rJJYOQabfOpRh0qCjGmefZiPKdHeolcarc8BdRnD1gr/8kTzPWIBqGJAZwMTw
	E6OanbznCw352nUp1swP/Z5phk4TR17t/at8HC4Or6bfZBAKhLiWY0ZPdiuhu/Hw=
X-Gm-Gg: ATEYQzz8k28zCcrtqkVvIVc//StjxSSjo2+RvVgcmSQWtU+sDyGZRgiNKFEYjP/2AWo
	dSakfDRblkF5ravC6Mzdsvh9e8I0mJaRXsHaj2DT2Muld0xZfdB6uRdbov91LTHnHGpqJVr7KeK
	DvyiQ9eO1S2K2DpQVmkTfFdQHdhKt/xi4c4BzQtRMfGyYC1Wfm6fXmMUmpVhj+k+6XB9ifB1ay7
	x6pe6AR9KwqvUREqNll2PKJeIf6TJE/aEwnjqUixmyakqK1wydJw7b996TMSLLQSUFIi9WPbq++
	uP+mOs7/y4zRPX75+GyS+EIbFRSXklG35kGkLlU4o7w02lov9P49Ko0HqNJdML/UjMHDRCbwp/Z
	pLOH3O1nblSJJAoIqvmWHBZs=
X-Received: by 2002:a05:6a21:3d85:b0:398:4bf2:4285 with SMTP id adf61e73a8af0-3984bf242b8mr611086637.16.1772709923223;
        Thu, 05 Mar 2026 03:25:23 -0800 (PST)
X-Received: by 2002:a05:6a21:3d85:b0:398:4bf2:4285 with SMTP id adf61e73a8af0-3984bf242b8mr611061637.16.1772709922665;
        Thu, 05 Mar 2026 03:25:22 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:1b86:2ae4:5dce:122e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7389126194sm2605943a12.24.2026.03.05.03.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:25:22 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260302053109.1117091-1-wenst@chromium.org>
References: <20260302053109.1117091-1-wenst@chromium.org>
Subject: Re: (subset) [PATCH v3 0/7] PCI: mediatek-gen3: add power control
 support
Message-Id: <177270991808.91433.424863497385792823.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 16:55:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: v9tSeSseZgZwFQ05RqbeSRlwR3E4c230
X-Proofpoint-GUID: v9tSeSseZgZwFQ05RqbeSRlwR3E4c230
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA5MiBTYWx0ZWRfX/9twpb3OqblO
 71SqzddFXqrH2uhoDmtWc/dafnwceEhWXe4SUR8WwaUtnAwPXuLEZ/oYVNmEqXV+2Vi28RhXLW6
 vU/r5VtlzUbJO3BgpnEuHpMVyrK2lGVJiLUbXquH8bR7g7awAcb1YiszaPaafKvX1uPthKdA9k5
 E929w68gOAOOWLnxBqQnvKHBMC/tu1dcHJrHqcjbs3s+j6VnRnJiNqnEvefpKwoArTsChsrsHQ0
 V9LkbAjhCtd0x1qn4g1r6tHAfa8eZwyTjl2tH1j5sFM0dNFYTjDqnTuVstMiGpbJCrZTwCunijk
 AgKX8fHzQ5UsbCVPVk1vV2jHYWFfFgbchZn0v77J48jsAesQdDC9ULSe0P8TtcOmPVFmsN5ZRvj
 ZSNdBU+XOZ/DgQv6vNMydTMqgABz5dLKUIZpCkYKuQeahgA6KVDXWcl/ugltfm4mYat9Nqc8qIZ
 pgl9ZPPqMAecUim9uRQ==
X-Authority-Analysis: v=2.4 cv=N64k1m9B c=1 sm=1 tr=0 ts=69a96824 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=4KYR80hNXaiQ2IXsO9UA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050092


On Mon, 02 Mar 2026 13:31:00 +0800, Chen-Yu Tsai wrote:
> This is v3 of my MediaTek PCIe gen3 controller driver power control
> support series.
> 
> Changes since v2:
> - Link to v2: https://lore.kernel.org/all/20260226092234.3859740-1-wenst@chromium.org/
> - Made PCIE_MEDIATEK_GEN3 select PCI_PWRCTRL_SLOT, following existing
>   examples
> 
> [...]

Applied, thanks!

[1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
      commit: accd5483cf12fe30b99f3d8585921b34c71c0a76
[2/7] PCI: mediatek-gen3: Add error path for probe and resume driver callbacks
      commit: 26781cd7ac6cedb7c669d8ddd384dfd914b8ac4a
[3/7] PCI: mediatek-gen3: Split out device power helpers
      commit: 01ddd5ab62127aeaf05a4ef99a1f566ed739de59
[4/7] PCI: mediatek-gen3: Disable device if further setup fails
      commit: c0275030fb4030be4cb78b460af5bd819d2d8b91
[5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
      commit: 614bfdbba1e224f91affe0e1e71d5672d3807a2e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

