Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713F37269F
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173856; cv=none; b=lR/N4qy8lA1bnT2ZfdaxKDNNdUiTMbi31/iFOt6etlyg4DlJZ63NLNz1suCJew+/Pj7SEY9tHa2hNVToMMdHWNOK1w/bwRAjuYJ0x+/1hZP+/APMPytIMiLq5+8q/pMJ/z0lB/4uX5jQqRZJ3YTzDU7QjoL5MTgAYQHPrxB2avY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173856; c=relaxed/simple;
	bh=nsunYrujb3/C0+pUWH5dmdoXIwiICJNrPRlO6VaBRhs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dYxOvq+zdYTF9bui9ceVLLhZdG1iGaPLoHMijVSBOXHRcKZuJreX14dTJscbcyCsbBhQetAAFOujyhBP6rl75OXJYpL0/cQj656UwlpHjvojmgTabNRNkFqSgl/oWbE4kri0RijdL8a/NKg4Ym37f2Aogi3ibKeXnYhN/2UTVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M5ZadwRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4sVtIGP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M5ZadwRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4sVtIGP"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647G4sIB1669703
	for <linux-pci@vger.kernel.org>; Thu, 7 May 2026 17:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eFC+WFVLK5ZcU7S0MWbHpoKrXCPIo2GHPqs45JSzbAE=; b=M5ZadwRUPN9ud8ME
	xwcxj/fJbDnExh/q/u1unG7sx+r2wasXAHmelArL3+5F8+mLmAhRY6uViQ8F0b4r
	3Rug4MfGjBITZy+mJtmDmgjV8heO3xDrJ1nVjRYmbRjFF2vdK2kgWx8K8PFE6A7p
	/RseHKRbx5iqeLtXWQip9JZMeCo1dioOpyVdhI/K5Kbz62Vlkwtz3rWbif90MrUp
	xhw3MBdqkulg4EAF0ufXofNeFCvgsSJ0I20x0Zmq1BA3l+VdjpEqopJc1JLyDleM
	iwU1Rvw6IjnFBqPZEmfube+jRAJC4LZs9lNy2c19knBhJUxeekNKMFsKwwbe2+Kv
	ocg7LQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p34ab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 17:10:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b7c904d476so13067415ad.3
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 10:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778173854; x=1778778654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFC+WFVLK5ZcU7S0MWbHpoKrXCPIo2GHPqs45JSzbAE=;
        b=Q4sVtIGPm/HLbpEZ2afy7AlI3uN+TYDJ2vqT6TTXCPAcizbVyTAvgRDA+vG5Kmda5w
         N2z7G5/3VjEmovT76WX5QN5wWAMp/DjTq9JjLvlCFimZWDXRs48ltYEy0mN8ryAH16+p
         fc93LU0wfZREPadYNXlGBac5mfj4eluOlgojZ3pABh9VRecJDSGmZMUt1N7g64ElyTk6
         T8b+9wODlud6kD3z1dIDUZ1MsrejfCqhFa/NZHaqXt1bKVycR0ZNV6Ej2/qw1IGfSfcm
         vK7Iubmo7+9iIE/Oc88YJHu+NmRcUPmchUiZG/vy4afTuiT5nHTE2nPD2VY/vHaaZ/tF
         dkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173854; x=1778778654;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eFC+WFVLK5ZcU7S0MWbHpoKrXCPIo2GHPqs45JSzbAE=;
        b=HyaYICypnhbN/iSXM4M8/oxRll4y2hj4FRkJXDNh8EbujQkYXHs+/oZDOi1j44jQM0
         uMO9BjFFo20Q4q7WzpqO27Zz4hoHCIJf1jBTfTHBvzMG9yEhqeUK3aJy0KrVmduUzG3Q
         MBAgAeE9kaOREROKpiPX0XNjnY8wIiYyWragc6iaXC+H0yNI5CVIRrGXoz51Un7dxqSI
         sGk42WKjZUd3zKcsamrtLaakfegM+npAsKY1EFa/+smLCi3EGGwYdmU01l9b1mFiC0M6
         yq+lRRCIpiCovKDR5cCP76mo3G3C7kd4CoRzejj4lnYs7lHMRUAG1ZYdR8u5qN7W9WE2
         fpbg==
X-Gm-Message-State: AOJu0Yy/bI89kEt+sFA66Sot7ww5Yc256/3zqdXC2bgGsWA256nANNbO
	4qcSV6HgK09y32RMts3gXfsnXyYpj7wis6uexin5KJ3ZVoclMVN+Iajo3ewgHH6DbRbGMd/16gR
	oBtgCzXa2WcUMngWM4kAkrK2t30EBxC8LK8S0mpiF2VBG5nM/FxCDwJYThFTZuKk=
X-Gm-Gg: AeBDievj3aU5AubEGBEI+sUyFw1krHK1XIjTayuHwi6JatApKMZRMesc0aA+fy9SkR+
	fpwVlWUjeqPQIGt4RwVYoCN10kX1pI2qkZW1XSBxw7sdekKOMC1Xq0TxgA7bQIdXFh2gaIhVnjV
	yNuVBYAc5/F2xzDsrYoRl43DuCBv6DZTilKUvhPOkcpPFGNuXUNl4ybcXsIVk2WGydzHliPHUww
	Qv9eWwjLJpcd/aPf7+Jxf+LdXQXfR/Yx0Kq5IMJG94agELrIW82Xy2rtdcqlNC5bGk9dCT3CEsx
	7/AiDoIqmZlAuu8eK6jsVl5cLU7Dx2K97nDgnyq9XSHNd3nQ25Ns7JcYvEY0FE8nS74wzhjQiyK
	Nial7h8RovJy7bwPUQhUGhA==
X-Received: by 2002:a17:903:2fcb:b0:2b0:7e4d:f43f with SMTP id d9443c01a7336-2ba79bebdf6mr57135775ad.41.1778173853682;
        Thu, 07 May 2026 10:10:53 -0700 (PDT)
X-Received: by 2002:a17:903:2fcb:b0:2b0:7e4d:f43f with SMTP id d9443c01a7336-2ba79bebdf6mr57135425ad.41.1778173852997;
        Thu, 07 May 2026 10:10:52 -0700 (PDT)
Received: from [192.168.1.102] ([117.193.212.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae757cb1csm2837125ad.36.2026.05.07.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:10:52 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sajid Dalvi <sdalvi@google.com>, Ajay Agarwal <ajayagarwal@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Florian Eckert <fe@dev.tdt.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Eckert.Florian@googlemail.com,
        ms@dev.tdt.de
In-Reply-To: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
References: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
Subject: Re: [PATCH v5 0/7] PCI: intel-gw: Fixes to make the driver working
 again
Message-Id: <177817384769.15660.3602195621533574931.b4-ty@b4>
Date: Thu, 07 May 2026 22:40:47 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3MyBTYWx0ZWRfX/bexRJBc3QCq
 R1UXCuDxGM5H7KSEGYPbQSyGpIqqOjbaqliKhlBkase+TtNX1OL6MoyGlIRYeu1I+k348G5VFwK
 BjBJRPrnmRphWP0r9FDlpNLftgirR/pV1hdhuyO/sk2R8uuw0CQhRB4j8TeqUw8fEwrFMTBYEh+
 fF0JmcXKvP/JZUAuAB/XXnubh9aTelluV4LS3fgkEEby0hQzpYG8IPl6WVHqFkvQSVGkSPqrTfN
 v1+Txw6kFQjDGCtyvSj4QTdAxwmL7jpuHdkstisI+mdMr1hb3LgqczdDyO64n15EXoGkod42o64
 X3lFwW8fBf/zENVadrfLfrUBvbnsQVn81RWx16j4EYXO/PB7KBf5XQF2U+S+KqOflGD0HnS0MYp
 rz2fMSIW67oormNemngIyMIecxMtFqcjtu6kja7aKo8q4kXaWjM3zO6+v50PKHrls7Sv1LI3K6i
 Jrhit4PIEb+akomk3Yw==
X-Proofpoint-GUID: WEPcoLhXC9d7--fhblHttxuVJ3V_qOl-
X-Proofpoint-ORIG-GUID: WEPcoLhXC9d7--fhblHttxuVJ3V_qOl-
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fcc79e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9ieLJ0H9P+Rp7hqicH8Z5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=Kc-sTBu1ukk76h7PBCUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070173


On Fri, 17 Apr 2026 10:35:44 +0200, Florian Eckert wrote:
> This series fixes and improve the 'intel-gw' driver to work again with
> the current dwc pcie framework. The following changes are:
> 
> * Move interrupt 'enable' to its own function to improve readability,
>   and add additional register writes just as the Maxlinear kernel does in
>   their SDK.
> * Enable clock for the PHY before PHY init call.
> * Add missing 'start_link' callback. That was added to the PCIe dwc
>   framework.
> * Move ATU base address assignment to the probe function and also add the
>   the possibility to read it from the devicetree by dwc core.
> * Update devicetree documentation for intel-gw-pcie.yaml
> * Remove unused preprocessor define.
> * Mark driver as orphaned as the maitainer's email no longer works
> 
> [...]

Applied, thanks!

[1/7] MAINTAINERS: Remove bouncing intel-gw maintainer
      commit: 354379acf4f288642ca0d95793a67c780ccf9160
[2/7] PCI: intel-gw: Remove unused define
      commit: d2c0d6d1731df43920f62bb2cf4540c163930aaa
[3/7] PCI: intel-gw: Move interrupt enable to own function
      commit: c18faeb8b45eed1970cb6e218482c1914e3134eb
[4/7] PCI: intel-gw: Enable clock before phy init
      commit: f1c454c22055fdf26b93a11dbbb57064e3319484
[5/7] PCI: intel-gw: Add start_link callback function
      commit: a758d808c3b488926f74f28d3917a2af3ae8bbfc
[6/7] PCI: intel-gw: Move driver atu base assignment to probe function
      commit: 91ef515328e716b70ab89af47789c15d39895ec1
[7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu resource
      commit: 5d14a593359d668475540a8b0ddd4489c71c8a3b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

