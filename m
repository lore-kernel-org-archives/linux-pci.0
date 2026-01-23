Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCE23EAA3
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160715; cv=none; b=CB3Ve5oSK41oydxMT/ETZGXSYp1ONVEduAV6pJae6PGQ+p8BSTVQR113+aQGf+dRNcHn0Ut1nhb86gn/HRxWiNgdVOEHiKEhT3yhSqPp/uEXPkgPErGNqVJReKiG8oUBsk/mtMOl/PX7PT/YX2v0upMoPR+zbnvM8APjRCSblTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160715; c=relaxed/simple;
	bh=LAdtpN1rCikqAOAR5EK+0Wp5HeQ/8qzoaZ/iaXhGfFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9kuKlRFUslErgyo9ABUE73O59bavxPg8CRHNQbJEYFLl588rIfl/s/6PyqA32cu9ZheW+bF2O/RS+J+IiYoGXDEgIElMUSuX7iRih5CF+1GwONHRBQlMgh2/0VM7jP45SRr6MyEqtErWLXoa9Cz1yKmnZOGHW71xwa7TYdLa5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUyuQBKB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cRt+xBbm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUyuQBKB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cRt+xBbm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N5I0DO3705183
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 09:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	26CDK72HEOnmUsZ1CXy1/05/oLpi5raMr9WBDPBMZ7k=; b=GUyuQBKBtsywwiSU
	R1OwPXA81vidDquGqqc28No1zzt67cVhsgBYp2pCqS9pfqgkULNner+r+hB817tG
	EYcSBfrlnwB49/42tOhjioOI+F64teuAOEUVcNI10lgBcw3D2oAxFfdxtxgz7SfN
	uYKcMGab6GlKl9wD5NgmD58lb179KAkvVMcLRX1gTjkK9+3PNUVzcs7z/J3jaIZg
	sjxjwF3FLLRhGB/vjiCA0YFJzM3cXV4xxATTVthnybzHIySwKD0LPRdYuzNwnLVM
	V2nR/ELYU3+1GXzsarPhdbq++Q0Cy1lWqFZYsgEJEIBRTD5ihz5rPOaSoAVge8ge
	6qs6Qg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buuayt7mq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 09:31:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a5bc8c43so552257785a.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 01:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769160702; x=1769765502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26CDK72HEOnmUsZ1CXy1/05/oLpi5raMr9WBDPBMZ7k=;
        b=cRt+xBbm3pM1SRIk9kYNM1W9X/WSF/Ury95PMCX1O1OCV+EW1M5h+A1QoRBlYstQGQ
         9yL7USz/IdZvi+wn70+of4uApJdIt7zF1ceKWh30fbo3PDjotcW60BPo3/wShGvq3GGR
         n6exb+hpXk59oJCu3SJBAlzyw3nZVcUkjcDSH/AsQk/CfT7V0De17OuCA4plNOeKTWVb
         gHo3Fl9CXetlsymKsQQUP6CbTx3EuuOr/7ciJfUh2t6+KBtwPPq4PxzihtZJNJVX/dW5
         W2OPr65bk0YKbxuefxv3VmxfuyDwem3eVrqu7z3pTRIbWCMSPwCSdpR2yofD4UvEnhwE
         EELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769160702; x=1769765502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26CDK72HEOnmUsZ1CXy1/05/oLpi5raMr9WBDPBMZ7k=;
        b=CzpolEvXxChhsH9P7X8QB3vJLwLYJFsQy579qNgcQvvdBSoffnNOUWGElHPR4x/fFu
         Kr+YAtnzNlYypHDrww7BcNCSIz7PdGEB+2A2sTydeXesUByHsFAJCKnSx+KJJOt267N4
         HAhYHNs51aSNaDMpp17T8xFtjJ6K0mTjcjZVRk7DpfFSyMIZYnk8Y7lQxgAJ1BwR9uCl
         nu3KcE7WocdxS1nDh4OgQiJTJFLhjuc2C5WM7cdbS0PP3Hzi3foUsKXivewKsydoHq9H
         k+5sSN7zLHtoa3Uysybv67Sgd0k5xxNmk0HWNg9rdUl/UUhHqocuZTIt/7Mf4sfy5uEW
         J23g==
X-Forwarded-Encrypted: i=1; AJvYcCVqQ3kmWZcbS1sp5l7PYEnhGFWNOYAIYDgHkdGPFQx7+ZwiMBZvrdumq/GJEP9fWHHI3kdXdTCwm3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YycohINiFsIOnYhvKJTKzjeAIy9SAtRRhh9QUSSug7+rHzm2faR
	eWwyO6jub7Kx9oxrcitzveEhe8zBtS9BXe/q+v0cnge1fkEI3TpIypJXxiqOY/6yVZL6zizHM/s
	ZFsI4Fny/luBZfTWab6oHRvH7C0w92alIvGOUTdRDivVv7E60CA6VeCcayPNtTKM=
X-Gm-Gg: AZuq6aJxGidXaBVgmuCCEJOEDiHOz6vPPUUM2id+oNhE32JcW/xuH4y/wJ+mcrB5L8f
	qnHG5w+kfKVWY4Gc+BwuQsZqxyepWUX1lMYgb+4NrABBlA+0bvHGrFtUsb0B6KYGGcM95hFVgMb
	mnyPOq1YkEsqoB1c3Lai5oQOXalllEhEQBWrSLP3i4vD4FYFP46G9E8lYfQMzPYdbAl2OqEItI6
	Uv/t+mE9zxSnlUWx6BGJwXgCQnJA64CA/tRyYtQrHfsFnikhhiHNrZswi0U05FRf6K/eJMi2A54
	aiu3c4FTfBoEZ+QyWBr9Vjo4w3J8fVv1GLSIqU6ASIcM1wXzWZcAwVUOL4Xdide43qJge1tc0Bk
	qwd1rxeP4+iP3aujVsvfZoVoEbBFZ5MnkCumRFhU=
X-Received: by 2002:a05:620a:2a01:b0:8c6:b001:c1d5 with SMTP id af79cd13be357-8c6e910a7dcmr53104985a.5.1769160701637;
        Fri, 23 Jan 2026 01:31:41 -0800 (PST)
X-Received: by 2002:a05:620a:2a01:b0:8c6:b001:c1d5 with SMTP id af79cd13be357-8c6e910a7dcmr53103085a.5.1769160701228;
        Fri, 23 Jan 2026 01:31:41 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:1c86:c19d:d843:dd83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c30293sm5717115f8f.19.2026.01.23.01.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 01:31:40 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Frank Li <Frank.Li@nxp.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: (subset) [PATCH v6 0/4] PCI: Add initial support for handling PCIe M.2 connectors in devicetree
Date: Fri, 23 Jan 2026 10:31:38 +0100
Message-ID: <176916069326.12678.16550242235025273411.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com>
References: <20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GP4F0+NK c=1 sm=1 tr=0 ts=69733ffe cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JrKmLYXSX60uSqAbQrQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: xXuIC-mVbhBUCXRem3VfcIefG_ey0RQu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA3NSBTYWx0ZWRfX6h48ozCCqou6
 SNSeDHTAwMSvkb9tjukoeyZ18oWqR5Va3DJz5XXpwQ8cmkUsqs+b7yTBF9DlDoMEp0Q44M1miIx
 ygZgARVdoe6gkbptXTwehg4CFBxidF1yzDKqZk9Rl9+nRy1DuCIPlqcjesBuhDVbErMP1KWlw1Y
 6lGMJLx1QmvID5PNF84KA7vZg8a+rrH/locn7t7BcplmiDB2h1RWVRP87sDu6+nQyqmnsjjSX2y
 191W8iAFYW/eJJ+6YHoPnLbWXXDJyG8B8fejWOeCFluJovRQFi6borG5r4lV08kAp8Uo7VkL9dd
 Tq38vhx2/zx/YNT/WUNiq/Yg/Zk+HO8nXOayKRHZQMrMeKh+0QnOqeLTIsv5jSLhgFy6xSMZ/3c
 E4zEsdCRDHW/yc8Ua7u7sTtPI8HDruUFvLJ0EoDcJ2l1UEtE8hFz3MTUpSXKO+EvpgN6mforExN
 noAvSEJ02f/mUelAqBQ==
X-Proofpoint-GUID: xXuIC-mVbhBUCXRem3VfcIefG_ey0RQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230075


On Thu, 22 Jan 2026 22:46:50 +0530, Manivannan Sadhasivam wrote:
> This series is an initial attempt to support the PCIe M.2 connectors in the
> kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
> Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
> in PCs). On the ACPI platforms, power to these connectors are mostly handled by
> the firmware/BIOS and the kernel never bothered to directly power manage them as
> like other PCIe connectors. But on the devicetree platforms, the kernel needs to
> power manage these connectors with the help of the devicetree description. But
> so far, there is no proper representation of the M.2 connectors in devicetree
> binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
> and fixed regulators in devicetree.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      commit: 926194a6675a9cd5943f85820508648b74669fc6
[4/4] power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors
      commit: 52e7b5bd62bab3851f25d8b70ad7eae9e94aba60

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
