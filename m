Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6F2DEA86
	for <linux-pci@vger.kernel.org>; Sun,  1 Mar 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362771; cv=none; b=E8uX7cFcsTExD6cpPB6vSuAAQnKk0qoGBwMwsZgRsNC3g3tOT2+dRhKRa7zwj4uyVplUk3ZGl2HqeSykyjQrauxnReu1Ldx7Bz+P63zNmyzZfvOxUpkRO+nyj8rGi73UDoZWyy0uI3K8SE1JBBV8Z/OnAChsVx7aDtt96KgRcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362771; c=relaxed/simple;
	bh=ma5KFEqHslgRuuIwDm092krRisjxb/PVQ/WF+lX7RAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnTvmqHKFZ4Bd9Ew9XxbkWfw6GTnPwdxwVyCII5PRaMzk9AvFHR+6hPAFYMvyvjQ7MUJPtv0Txdiaeo1oZKPR8ZmwRVU2VyjbKdXM2QRjPrhygVQTFvF0J4sRyxcJYrfm2HsQKsuGZXFuoKx/j4tVCimG+mypBIUZ8EetJMQrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZbRtpKNV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FNjodZfR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZbRtpKNV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FNjodZfR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 621AU6Sm2979634
	for <linux-pci@vger.kernel.org>; Sun, 1 Mar 2026 10:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tWvbzoSirp2+/mfj208EVtuC
	kSsURTVI0XL++QIzXe8=; b=ZbRtpKNVrLZlATBeln8U+o1HVMJ1NJFODQD2g1Xt
	5zqmD26FEi7oT89X6dB/3Kf0XkkF6A8sXLJiy6k2cdCfTElYXz+CjMK5FIy3AQPe
	xpwFsAEbry2aIJz+ovYfTdhNnokCCupYZNrBBmfiE6N5iXxEnaecxqJfkBq7jA6g
	atxv+7P2SKJ+CThu9PnqyE+e14r5zyxB6+fChJWyb7bmsbhO1nbIl9sdXtyQ92aF
	9NNtP7wU75FlG/y0oxLuqIE1sXvncry7ovuFrwD64sbYiUvq0bz1X2QeTCCuTyIj
	PQrXowySKFMO/mebdHFA3zvBB6060oQ2+M3ZZuPrtLkY+g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksf8jkuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 10:59:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb3b0d938dso3401668385a.2
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 02:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772362768; x=1772967568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWvbzoSirp2+/mfj208EVtuCkSsURTVI0XL++QIzXe8=;
        b=FNjodZfROy8PDZ8894bTGs3Y3BWNGtnrD5haRrzP61itCm0bPjRxDe13g01iYiNRCq
         Q6qkdKSXweYzT10IDgSp6A9f/oZFntmUky9Y4fhPB8ZUKH5vE1VDlNR8kx16Vw1LiZHs
         7ASk5gmBkK2LWE/6uWxWvYG9VkyxZu5UCxHkj9z+7MLNcC9gF+yls+5MD7bFp0odipLB
         8o0+poh10AVUi3gKRlMvMOMI2uSWRVzH3yGbSsWVdgl9IztKfUB9yHdQMSizsEiuoLu4
         Zx3xmT8m4TbOiT6ZWV1z0lH46ARFTadI5cQqNFTvCKQbS4VedMFCeECn5J4PSbJ3RxCy
         QOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772362768; x=1772967568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWvbzoSirp2+/mfj208EVtuCkSsURTVI0XL++QIzXe8=;
        b=WAe3arw0Z5FkF2wXyoCe0AWIpZX5hrIQ1H4uRDKgh3pwQSdoCkwIquH5ZC3B4rFLcf
         knU0IF3bBeIHVmGIjW549QhQab31twqYuechmnWZsEzBxYNEG0cO5rJ6V8s1/J25t3p7
         0XeWbeurB7VKJD3Ps3oDx/Sq2YAlvXnDFKwH4PcmJrxkdWb1sFCbev6qRBr9KzwbRX3I
         cfW0ni6xG1bo8goGp5ErTyFarpUp3+/GXWayHzoM5mdI8dxHzlywhfoP4XM/tFlTyUZc
         g7cA+PPx/aCGZJ044HbCEHOFO+vRty3RYsvUZKkWEDfcqMXVe4nKf+fRxfEEjVSfuiUb
         CCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVZYmR711lRgWQuAfrHsNSZ5iveFehgbtFQIHpF6lHpkKnemAGgr5kPWV/QT67KmmjxZS2GgaEB4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWv3aUi6S3L2IdDap9tPMaAKsZ8Q99p09kHR7S0NcE/ddnix+f
	Oy68/tbfGyJbRxrK+psK+UULDlN71Tx9itNZ7Hjs4S7MCEPOihqR9Rie+UOWS5hlo3+0AetoXyQ
	LPeaUtZkfKw484xbZ2UDdO4LgJqC7yrBLUGRAVx0eE++Cgl5mVNX+vSydmmvsF9A=
X-Gm-Gg: ATEYQzymhR5svzP4Y9GIlSYPA7eHKfbDHW2EJQEMNOdI6axXariuV0EhNwzAUKJFdr5
	84X8uzcP8FiaAOuQw9OyoK0K+7oWnyPk/3/9CZP4Wg5TKzw5Jz+3PgiHRKpxnkV05ggtH4R9CqS
	6WKANZXfABcpYyW3SQXdXPJhZa8XEjxTHWlDJDnKskB1jTKV8IYJRNcpy5E5yciA0QvxZ1DL7Ri
	kcbTsKrBvIkC6fkfn4Dn6uGL5ov/kriErpJauPdMPYDO2qww1Wf6YxXZtku1HZdx1nf/4BiaIq9
	6cr+yKi4vJlBLTY86eAQEX9dWy/XdvXzVtqCuL56gP88p7pYjV78AqTGmuNI2MNBbNjYXvDG83K
	klBmtI52i8Oxm+ZNegHJn6jseGLMSmiO7/PkRQsIZo8ToB3hX7u1ak4GlpBXa7mcNfmaOqJp4u9
	o9+PZpIrryFLera8rGpY9GGTr4b/gM/3YRgsM=
X-Received: by 2002:a05:620a:3949:b0:8c7:1b3f:7d0c with SMTP id af79cd13be357-8cbc8e55216mr1090395085a.16.1772362767954;
        Sun, 01 Mar 2026 02:59:27 -0800 (PST)
X-Received: by 2002:a05:620a:3949:b0:8c7:1b3f:7d0c with SMTP id af79cd13be357-8cbc8e55216mr1090393285a.16.1772362767407;
        Sun, 01 Mar 2026 02:59:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a116de019esm872280e87.3.2026.03.01.02.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:59:26 -0800 (PST)
Date: Sun, 1 Mar 2026 12:59:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/3] of: factor arguments passed to of_map_id() into a
 struct
Message-ID: <bo5kb53hrzvl6e5mctvnpqluobdgbpq4x3m5ca7mwtfnl53npw@7axqsph2vyqd>
References: <20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com>
 <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-parse_iommu_cells-v9-2-4d1bceecc5e1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDA5OSBTYWx0ZWRfX+GqDwo/6lvLg
 2SyRhde1Z45ziLeyCIFVld7c5Bd7vOgOXNDU2EHXL4JwhJE9YaYoTBGBZL2SKS9PpDpoIM6RfAz
 ADG8LeyjFkyKmC8Q6PNHGhBWhaSjhiqarytFgzITXsCb23GhMIzbysXWg8X6mwVbXWbfXeLqOfd
 kHYexaIMM+4c6xrhbkaZSeWMO1x/rrvVfLXCA+GP45AANZGYzXOGA6ZMarIZa5SPB+VjTWqNK/b
 pYILEosCI9K2bA1sDyyB3Ji2Yz1oRNIaTyfiv7iMXvchbx8haKS50JhVahJFwmwXuKvoQmJTWYp
 W0HXZPKiLkYQobPpmzjXBmnewVSa83VwS15Qy9Fd85qlOOhFv+Spt5COLZPQ1uLDavbLpHEyRhV
 LiW+ufbcSQGt2y2NwIh4uVlk0by1juwPKiCb1P1LkAUqRyTBY4juqZeSe1XwYEq79nUtBUelefu
 w1kxMZBr16UmNk3KfWA==
X-Proofpoint-ORIG-GUID: Y9xzJpn5lIFXc42--ClFblPP5ypAmC_l
X-Proofpoint-GUID: Y9xzJpn5lIFXc42--ClFblPP5ypAmC_l
X-Authority-Analysis: v=2.4 cv=I5dohdgg c=1 sm=1 tr=0 ts=69a41c10 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Dq95N7oyZucg39lo86YA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010099

On Sun, Mar 01, 2026 at 02:04:20PM +0530, Vijayanand Jitta wrote:
> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> 
> Change of_map_id() to take a pointer to struct of_phandle_args
> instead of passing target device node and translated IDs separately.
> Update all callers accordingly.
> 
> Subsequent patch will make use of the args_count field in
> struct of_phandle_args.
> 
> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> ---
>  drivers/iommu/of_iommu.c              |  2 +-
>  drivers/of/base.c                     | 37 +++++++++++++++++------------------
>  drivers/pci/controller/dwc/pci-imx6.c |  8 +++++++-
>  drivers/pci/controller/pcie-apple.c   |  4 +++-
>  drivers/xen/grant-dma-ops.c           |  2 +-
>  include/linux/of.h                    | 21 +++++++++++++-------
>  6 files changed, 44 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index a0937b7b3c4d..e1d4b37d200d 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -755,6 +755,7 @@ static int apple_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_d
>  {
>  	u32 sid, rid = pci_dev_id(pdev);
>  	struct apple_pcie_port *port;
> +	struct of_phandle_args iommu_spec = { .args_count = 1 };

Hmm, I didn't notice this. Parsing functions are expected to ignore
of_phandle_args before the parsing. So passing .args_count = 1 is
strange.

>  	int idx, err;
>  
>  	port = apple_pcie_get_port(pdev);

-- 
With best wishes
Dmitry
