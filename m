Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C642B726
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013372; cv=none; b=hm6RBwSl2M6B8R+T8WfPkZ7thOmqBjU0SyY7tloR9WpifTj7ThZ9E/W5Xu1bjHFPjBDmrgZM59fo2vxy2vbv0q37C36zfCx2eRW0JJsnPc71mntUUkMYShRtGjMHBmZKcoI+5/Hs6V8UrOt0ZKUmNG22f8lgFKiJ84TxaRG8Vlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013372; c=relaxed/simple;
	bh=VFWpb6nlpeSfKKIyMesTMB3UdBp8hJBm5iaiiLYyROs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ha0NmVBcBT3Hpb8c5RrJEvZGCuvi1nD46Oa6lkR1n5NSXE0hfAshY1xJhLurSgxJyp6J+iiyMDsgtB9SIResd3HlKnkjqAQOXpaQM7QoQmOF+mAbF9xkxLywmOeV8sJbx55kaOpY3kGIwyzG3S5LfT1Z4TvfX5FkR7OjCysuvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8l7kC8R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZSCN7NvU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8l7kC8R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZSCN7NvU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClNdO2249684
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 13:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zYvZ56efOsNgrNR8iO3UiV96M2Ju3lxmsivcv4BBmUo=; b=h8l7kC8RBABlJ/UI
	Uwh2v+tsrrtRR9nmxleNHUiw5z9aC8yLQHO0dqOhUyCl5MyBahrwnYKiCSoTMk7t
	Rq5Jpj6xsNQ56bh8hl3rVOU+0kmPq4jVCAfZoYovN4Y2oeLmuzRNhD9qM80bW1xB
	jyK5Yc3MHOz7b709+JnMKgTSSVqO7riDJ4M7qSIF2Jlsa32d9XiLNa7E7uOFTaxf
	S3dCiBaeJYgwq0XuJlcrFP2/FtVWVp/9KhqfXlsbDfYTjLWGxa7SVJ0Ef8BCKlmU
	q/h5lwtorPKVwQwVX2yzZqzk8B6/7TeKf31u9lXylUE95QJx/vWbyBr3GQN64xu9
	xR2dFQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wh53a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 13:56:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-842cb4c62f9so2391061b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781013370; x=1781618170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYvZ56efOsNgrNR8iO3UiV96M2Ju3lxmsivcv4BBmUo=;
        b=ZSCN7NvUWx6QSBHlQDUMBkeviUkPgNIgawh4OQ+xpHMXRxsC/Cyq6CV3ug8oS/+1/b
         mikrddXZ2UvonRc/1FXIa6f7VOgJa0qKPD3EpKPCHID8P1smJ81KqnTmSJoGag2gleRU
         uDzX7MCVqsdZTkgTjQIJA4SLKi5dNReJoEaYET8R9BxpnZ+WemZ8feE88NdHBUwzo0jB
         JJAYLvjgliv1fDKddF38EiDxWMIQTEe/f6W17huKYXLNmu9SgItY+CdiXReJvLrvd7Tm
         WhdBKasU+aMA05E/PQK+FgNBxTb4tBTfFvLZHn1Qn1MDL8gFdm/SCwdYD6jMU0/UUsmF
         F6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013370; x=1781618170;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zYvZ56efOsNgrNR8iO3UiV96M2Ju3lxmsivcv4BBmUo=;
        b=Snm6W1Wwm8rSklrPiiEVlBgfncaCDo63B7RJJYkkOAjzvt0+bKwcepNu0klHUFxfEt
         hCGV56Mdx/QoOmd87y+Qg1huNNbVfmZ4Z3XxyuL6+2ymiWXdUvPUqsSChxv7Od36FcaM
         8nS0YcIGUTfEPs6SGByVh8hvexEaQIyxfQQtbSMTGBqdFocqDZGkEElz63TzkctpCIJJ
         iQmKqsEzJTb+RHk9uOde8s+moiuOyLWZpU93Tk33I5rMLFhZ2wrOrBLxXpzi095AMWur
         eemb9Dk0iv4HR7nSVM9FcPDaPr2RVLskmAPboo/MrcN39ADKAcH/IPC9qOXGkfoZ8FDK
         Iz5Q==
X-Gm-Message-State: AOJu0YwJssv7Sc8+3YvkunZWH1tArXawRjLvAGo7ZJTD76/oV/KuA9ee
	xdTaEibI106izn8QeodkhDbvnvKErHe0FKfuXw/dbD5UIYND5E5bXPcbOxfstBwJg9QK+BAfUsn
	lqZpfPKtL3iKWUQa7imCy5Ro3k0Pi3Pi5ytrR9DBpT2tB1H+tEmSQACh2zdNFEDJqjs4E+vM=
X-Gm-Gg: Acq92OFAl92Glci5J9U5djDliWb91Ef/eU2cIKgPI+3P/yVpTQuFAkdGxjyOItuq3C2
	YTQ5FbIAFH1as8PMeRkcFXWbp9pSOO+G6gD/hIImC2yX8IpWOcglRE/jANQPzzx/bf47tlZzRZn
	qsFTlS46Lps3RGGvwNNvRR67hdcKnnkmLuvb/3VJbEUeZjfRrJVCo8vBqMO9eHxUnsCK6+kzn7Z
	SQ6yWGyFpX48SFrut5nAGNKxrQPE93/PXktNmdGQhar7AfMcChpx7wownrNDPXBH20YejJit76s
	4Njgh7SNg5t+77CYgx5Xq8fn/yktrmdRXP1+u8cCeZN2VWGYc+IS+CrfMtlyQF6ER3LBWs6Hs9Q
	N/dtDmzvxRqGGYyQYRNkTuri3Qm59k9Q=
X-Received: by 2002:a05:6a00:1952:b0:842:499d:450e with SMTP id d2e1a72fcca58-842b6766a9cmr14292284b3a.20.1781013369546;
        Tue, 09 Jun 2026 06:56:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:1952:b0:842:499d:450e with SMTP id d2e1a72fcca58-842b6766a9cmr14292259b3a.20.1781013368937;
        Tue, 09 Jun 2026 06:56:08 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.129.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828cf783sm22091426b3a.40.2026.06.09.06.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:56:07 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, Hans Zhang <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260516153657.65214-1-18255117159@163.com>
References: <20260516153657.65214-1-18255117159@163.com>
Subject: Re: [PATCH 0/3] PCI: Unify TLP type definitions across controller
 drivers
Message-Id: <178101336600.7165.3676408183588991498.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 19:26:06 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzMiBTYWx0ZWRfXzWB65c48YyHX
 q1sQitFhTVgCsLUSPNYDtX4RdimScQ4LleMRfZaZnW0lSVUd3Gmyq6XpjkYvOWyLujfmwqUnKES
 p78nfp9pBMwyxXh0EYm08i1q/QN4Jvh30nTadbDAzLmXpnrZnL/rXPu9n0h3CyydwufFtHNsUyd
 VFOXSTIuc5tac3AEYn4iYH4LsOYirn6BCYQqcxPKxikIUgls5GiIjyfkX9Re8XALHy1ofzkAjT+
 pTZt7dnGB5U6NUOglOmxdbp4VagRq4YSTBJa6Rktt2zWXAa/V/TmxJO7SBXNQqs/T08zXZJ93XS
 bOkgk0sNHOSavgTS4vO2ezDpCLz8M15lT4sVvpzaQEqNHprL93S0w2uTifzKcoxuP+bFexMGp0H
 XxSqj4Zi8K05ljtnms4aEnVwZEpTdWWLY2s6Rg68h8p8ER87VWilAEc7dgaZonUnT9cnHHtuF+b
 0uK4HnZRWo/pOrXxajQ==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a281b7a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=4E6x9rGNEmwsBi5Sc5cS6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=95EXXQcGmelWzr517-0A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: VaXvig6MW7uuZDPj7-8ezUIJ1GAOLgFO
X-Proofpoint-ORIG-GUID: VaXvig6MW7uuZDPj7-8ezUIJ1GAOLgFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090132


On Sat, 16 May 2026 23:36:54 +0800, Hans Zhang wrote:
> This series replaces scattered hardcoded values and private macros for
> PCIe TLP type fields with a single set of common definitions in pci.h.
> 
> Background:
> PCIe Transaction Layer Packets (TLPs) have a Type field (bits 4:0 of
> byte 0) that identifies the request type. Different controller drivers
> (dwc, cadence, aspeed, mediatek) currently use either magic numbers or
> their own macro names for these values, hurting code readability and
> maintainability.
> 
> [...]

Applied, thanks!

[1/3] PCI: Add common TLP type macros and convert aspeed/mediatek
      commit: 286db45fb7ef5fe950a60a47c963156d6ece356f
[2/3] PCI: dwc: Replace ATU type macros with common TLP type macros
      commit: 3136184508d2889a11092dbaa097ed6580bc4214
[3/3] PCI: cadence: Use common TLP type macros
      commit: 52015335e5db7e9b0d62d1ee1178de1b601ac7ba

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

