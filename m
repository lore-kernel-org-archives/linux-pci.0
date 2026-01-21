Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF54346FA6
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988412; cv=none; b=E48nXDrxVLDqnJycqsBwnFYF6mRfdIZzE+7yV9VQszYFXB+STQ5MSLPsCSlxM+OWmzttSVTEfclE+nm9vHZOtmydYm8yUkv69aNKQ3ppdZgsetKyyGtridZ+M6AfVi7b/6QaKom8nmswcLmFX2qae7X4vEDP0lOvrouTuYW5nTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988412; c=relaxed/simple;
	bh=RqhWWU78eavUc+/hce5nNHYpseqeri4dhGKCpoqACT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cWofA3J0N3yKU510F+MObm1Lf9etCueZzMU3Dl6dQko2x1w4LZI6dT1jaDCnl+/xJLp2PQAokv3XEWl3+xDrSUlZ1cr3hFD/QQ9BmlYh6ouaArT2O6nuzR4OyewqBJlOLKQmPVugtu41EGp+/oSEZoX9poKzT5Lkozi/Fkoi9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P1ssyxIf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QtpeOSwY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P1ssyxIf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QtpeOSwY"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L6X4YE2353900
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 09:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J4Ehy94Fv1ZXg3yukgsvhncVRxUO7ynPwWFfhST7HNw=; b=P1ssyxIfhRn/9CAw
	aSS+XClsUJsN2UoudxSo5YYR31epKp8cajWoKDFzAR/s7m/LCGj0uFA+lIbTsYJw
	8z0WnbxxKzEizba4R6P1CbtspKZPkFH8GF3PhPvWSfMeHQD1+Z1cNe2YcS6nE1re
	HwQYuH/hHYU+YR7mLG2kc8SmX1ef3DcQekSbHS9rLPJ0usYmBWf029coslnVtp/a
	KpAvqBV3RmMPqSzZyncFYw0rQZnZDlYwZ6w8mrf8p0599JNs+wePNydlu0hhjKAF
	k/JyZvWwBAcCgxVhj3OCXwNCLjOILoUu9svJtgE4gK9CgOt5hclI/vQ9FtMM2Osx
	H2RSWQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btsmprqqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 09:40:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so5689778a91.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 01:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768988408; x=1769593208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Ehy94Fv1ZXg3yukgsvhncVRxUO7ynPwWFfhST7HNw=;
        b=QtpeOSwYhL6EJkdeNTxIEDGUDoGs7WIePhR+gga8MAcZAUYhipLm/eV29E2fsjWjPu
         pMDi2yqscnZnAtBlTnDXbCo2dJ6pv6IoXFxeIVS09SrxMEtnpXYlQXQpAn33Q0dFEdXh
         qnguveUioRxe6b4iSjn/4N6FdFViTkvqP7EOqysnrJP2maph3h4OG6iyYS0bGyYFsLeR
         jmfzlWTZNilLT0+8QWc/7u9QdGQlz8Xa6IoTaXGsJLQ8+TDLuwxGw/EyGa7Uc+1eMaqM
         9Q43kgiu67PCF5seybOlkOSSlf3O62ztJETplo5kDa3PN5Qza0SOg7neXwdC4qz1JYG1
         MXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988408; x=1769593208;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4Ehy94Fv1ZXg3yukgsvhncVRxUO7ynPwWFfhST7HNw=;
        b=LnpXiusouJn8W8OhpfUuNfKJJ+4BTpkDbF6Pc4Zq2xWEoUOr9lskbWkfA4o0/y1VsA
         370OFR1K2scIlVDEp3C84rccEcgTepdkDSzDxtRFkTw48jJYd3olzU0lMzjtVQYXMVoN
         K7LVsaiETJRHAL89f6/Z/nIRHRktHfW6VtxAWDy5fLe/AJKvY9OHWdgXy8PYwEwKhmmI
         b6jc8j6C/N5JIWKN0PDKk2p27I9s10/a1Id5sm4h7Eut4V0E47zMvdq81Ght6al2dAWV
         790Qk8lssj4UUsYx4TaqZ5mXijN24OIDZiGsPHx76OQxYv7vqzAwx3VNWoM1nnRpCj+7
         hWzA==
X-Gm-Message-State: AOJu0YxNupiFmZPqHo2OqIBS8Ib8Gv9OmfdY8f03Qz4up6bgkkGm5Iao
	qVh3M4wj9kTB8MkCnEGHdOxYzxUCi7x1hwo8xC4aciob1VsDEwVPTakxeXxRD9o9KXATbxjUVqw
	nvyxGJ8U8V7Aptez5A+NhOsu9VRfiVUWv6W385tmjefPYIWxb0l44OiwyFSM34n0=
X-Gm-Gg: AZuq6aJhz29gZcVdxpRSg+BtDCnYpvZu4nILEuUkPC/SkKmsgcrWj1DdMHtyIlcwwSI
	lWFiHQgRtHiXXyn3S0FUb4SoWS+lDFLC8reAd27yQ2OEmdPrFo8ehrmoIy9JxF6mzdn9mRMZb0s
	SH/xl9iDZnC/6aOE+F56W3jKD9PE//y8bIr7UXyiflX/hqMOUPL8/7247sf/FYGgy7rHX9E2zFw
	ACEXwKPQgRvR5l2OZtbbNVt+OjtPpOrt8hOkXImWaDPRHzTMWZ8KcFAJ93RIo3DUIVteBk3VxO9
	RilAaXEtuB5t2RUnsP/90/nO/okpui/1J4NBDQ/6HCuO3BkvWkn920xhUtOQvpRGdUQGLluhlJZ
	vT/5pnbH6
X-Received: by 2002:a17:90b:278f:b0:349:19a8:e00e with SMTP id 98e67ed59e1d1-35272fbf464mr13490502a91.31.1768988408456;
        Wed, 21 Jan 2026 01:40:08 -0800 (PST)
X-Received: by 2002:a17:90b:278f:b0:349:19a8:e00e with SMTP id 98e67ed59e1d1-35272fbf464mr13490478a91.31.1768988407894;
        Wed, 21 Jan 2026 01:40:07 -0800 (PST)
Received: from [192.168.1.102] ([120.56.201.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352fafdcbfasm828673a91.2.2026.01.21.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:40:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de,
        lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260114083300.3689672-1-hongxing.zhu@nxp.com>
References: <20260114083300.3689672-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v9 0/1] Add quirks to proceed PME handshake in DWC PM
Message-Id: <176898840193.11172.8990003270800077738.b4-ty@kernel.org>
Date: Wed, 21 Jan 2026 15:10:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=EIcLElZC c=1 sm=1 tr=0 ts=69709ef9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=o3iIPP6MwdQAWb28Nvg98Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=4S7PnLgJINE9Ke9AXOUA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: mcZF6y-hIa9P51f1MQNtkJOshZMq9960
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4MCBTYWx0ZWRfX0k15RkdNp2+W
 6coLvt4+zwr0AMMNzz9HLwfnMTRY9Md5RQ5iqkb9auewzzCErM2y/VVYW16SfgPlsJxVDLQff1D
 Vh9kCZBii/sXJkTEwdFRXTMkCtAXPNWDyWbVpdp3hL/RXA+Hs1xN6Avfxutg4Zi+HWnGjVy9czN
 3cg/BhAf88hvnaWegC6YGc6nvmNXoENAH+cfPgbr5mVWV6Wpq7cnfYzI16aiWE32aHGb+Ty5/ax
 k+v4AlrcSiNmU0aQqfE5pd8dgPT2r31xJIGjeeKeRVPlp4nSPk08/rSLyIz+FgX5a5rOdXDSPdL
 iQmJG1H8qSLwej2Oyx/SDFD/zfKXYOASvCJcV4m/L/xIqlmtF8QtEO9ei57Q96oAVg7AT2sLvZu
 RfnumzmGveiCHGg6t+e/tQ5Zzg1tYJx7Tg9ivPye3Su4Tf0CIDRcIBL668+ThdPPlKEV3YpK4cq
 9zSfLL19+92oRcA1JRA==
X-Proofpoint-GUID: mcZF6y-hIa9P51f1MQNtkJOshZMq9960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210080


On Wed, 14 Jan 2026 16:32:59 +0800, Richard Zhu wrote:
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
> 
> The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
> is kicked off. To handle this case, don't poll L2 state and add one max
> 10ms delay if the skip_l23_wait flag is true in suspend.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Don't poll L2 if skip_l23_wait is true
      commit: 58a17b2647ba5aac47e3ffafd0a9b92bf4a9bcbe

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

