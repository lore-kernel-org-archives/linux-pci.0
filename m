Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DC38E5ED
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 04:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782881640; cv=none; b=WgZQfqcc2WZO+o/Ga5IHu9f3n4hlR+kOv3d8pgmXizVocvGz15YsDWOQUnyhehT+P02nqTCMSmK5MOtgPRGJnpNasEnIgnnQokxeggeNNCQaLZsC9OU5uvsGnHUmS3Bk/Ni8cQTL5S89aKSS34ldYUz7aUugYjCt2rOd6tYhF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782881640; c=relaxed/simple;
	bh=1bjN4Sm87DBHQuSH6KwWxWKq7PfYD+aRsJU8d632m04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xpe2z58lE/0FXdvEI77+fHICdMGgP4KbkIpeTrC2VEynhnNk8I1LHS6Tu3RORg+wJMaLhgdZJl6M5fv+MLhJHWjMVNd5wCPCC3nM3VOf81uUOlypo2LVhMgJP8in+SRNlpuyFYVhPjC19x+zV1Xf94lakTdoRTZDuqjJ5bj4Lxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FgYsc6/A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IowVP51c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FgYsc6/A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IowVP51c"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612tKcL3933520
	for <linux-pci@vger.kernel.org>; Wed, 1 Jul 2026 04:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VVYG7n43yNFPLs0zWma59iXP+2x2rW+eKZMruRCfPhw=; b=FgYsc6/AP6UBJFrC
	Btu3un/9GDOm8KEFtQkNVUKEjXbnwFIFTvkoT/dX8XkcblUfVrnDbwJ1cFt4yxos
	kOr6zVeQA0EMCTl2ESOjJ3JOGJXag7e+M3XqwoBWsJdvuQzvQHMWHDyiQll8OVaQ
	UmloFwwkQ4Kot4ZD5IsQ34xQInrppzcn6/vdbdMhFhpmUyUtfp4HCxdgc5GZTgsN
	xlFcVmdDCXvdMzl2zCL3FDk45d7F0BkFahaSl0isbHPS6zFcJM3jsSnEyT3epAUh
	fh5y6J+dEiB3GjrBBw8WIUlNxzDfEayFf3iwUQctSrYvISNbKPkpAUkPmNWS15Fv
	ob/zTQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc0bb5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 04:53:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30eefcf4a1fso449411eec.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782881637; x=1783486437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVYG7n43yNFPLs0zWma59iXP+2x2rW+eKZMruRCfPhw=;
        b=IowVP51cklvqyp68zlEsGb2dsPT1AegVwf8587DS83cPYhFwvAtTIa0/vehLxsALYV
         jMIOupMZSV7JTCmSqwtgfCPk0RU2oVbxRHwxsCgLXofcwRJgN1YxwGAaHJXhKve1S1FB
         3esGxYXSHmkoyg1yicRLAjkbqb8ldsDKvJuVXkPwkOcd+eTmGfHKQ9X3H2LgR07uKK/Z
         gsM97bi/OTyg/fHRglJCNptVTV4LvGPidrkqC42fW5v40RILE3XFTWuiGRlW6vQZeYVK
         54LOflsUqG6c0X+j0B40n4ThxQmYqtEuzLNmBdA9jghQtaLjy4nLhTsL+PXVFNuv3Vq5
         dXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782881637; x=1783486437;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VVYG7n43yNFPLs0zWma59iXP+2x2rW+eKZMruRCfPhw=;
        b=rPXyEg70asc+26w2lm4iXJpPlRXVHswRbyZWiqt93qCfnMQMN3q7UIO53apCf3Ie+K
         N33iDi8/oQhMLo9EAmf3EgTOFrygXiLC1uSuwwyUg+ZSf3DDEoyknAqE2D4sZTw0FkQz
         uZeZlNlaVPRRQyungjghbYsDvCkOXXOadti7Cg3SQ0HKoNfIEn+M2Ej0YUmdeMgWH5eb
         fl81qT56u0XRqrk94LMjxZxiJnMTemw9NDAz9WuS8ajxUve5F3mSArTXnwMy7GLraeBy
         1SoZ2pv8eaLfBtdZigCk0mL0m4ipAuNJvUTL9kPjSMIyyLLoAY9dVLnBYSvtwKX0FpQL
         +4pw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+6VRjADY+7q/6jROtLmsU8tZdTz+sHbJBygNz3BEH94McHBPbv/o06umW2n3+TZGZEfjMrJxqohY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP50RsoTkKS6NUaF+kbGk6L61fqbz/X7cmlkJLIND3rrjnTYkD
	83HG5AyNybgJC92eWJW69/4MsfXs7pRPhysGqFf3LM/EJAs94IkHlwx9Z+2BgajzS9+U4Jyinho
	XKJt55l40N7tD7NF+CU+ufquVSyEgvYuUHP323ycSnAOMeTa7a86nDYZ6GkClMnk=
X-Gm-Gg: AfdE7clNK7DIAWViAUp8cNxqkKNngPuw0uGC8YClOu0vltaAGVpGnW6RWbifoI3P9vX
	Oke4/uoJf7HFfVX8IsG80uvnw/kyWHj+o96TvwGLeFhzNJx3xBQDrgzvfXbBU9SrVXcT3dZqnrV
	ameeo81PVbvyl8lYFkTKYoVuqJXRnIpJrTueBoWLg7AwEdMsDY4h/wp6g0YYTP/FCpRynesjQex
	8PYjVdY1CX8/ykFBrx26SfPURM8hS0TwJxJy3+O5Fyl34lgDDRcmtEAU+b8mJ4wleRUOdvgWByn
	Cw/UOwQprchDIcEg4+6aMZL+wlAr2ZIiJksZS4jyREC3tLG4YExqnEwE72de0Al7HMzfyviS+WL
	2/w/jJ5YwGVTbjPgmp4IhRzJonuZXvw==
X-Received: by 2002:a05:7300:8623:b0:304:e587:5063 with SMTP id 5a478bee46e88-30eff0748eemr156615eec.12.1782881637419;
        Tue, 30 Jun 2026 21:53:57 -0700 (PDT)
X-Received: by 2002:a05:7300:8623:b0:304:e587:5063 with SMTP id 5a478bee46e88-30eff0748eemr156593eec.12.1782881636884;
        Tue, 30 Jun 2026 21:53:56 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.61.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2cd21bcsm29818457eec.0.2026.06.30.21.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 21:53:56 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260618143629.2035247-1-arnd@kernel.org>
References: <20260618143629.2035247-1-arnd@kernel.org>
Subject: Re: [PATCH] PCI: imx6: fix building against pwrctrl
Message-Id: <178288163351.308055.2627204508258761615.b4-ty@b4>
Date: Wed, 01 Jul 2026 06:53:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0NyBTYWx0ZWRfX7jLWDCX3A47p
 w786kyDDs3n8Z288l3qnsrZQbxfvIesP8UM5JNx+txdcN/0kJQ/eeYJ2tit9WtTgCvlLzwlqwrB
 DZzyd9CYNKAwu8qLR4KFScs6KAvDTQ0LQzh+I0OazvhcFGy2Ro+7fnTpKr3ahgowhDSGV+DLzNa
 77yDnAdJmjfB7GmJO8lZbHPbdjzJHojfPVjgkPJl5g4rHChzCHGhjKNZ+x5EBBlBShbnQuVyYAv
 JBbjvd6pwTM45Sy7gSs6kqdYf3Ip/TBW1i06STpfWDA1G02pJQuRPtqNu3IAIcb85AWyJGJrNt0
 zRu1e1M1w8s22ypHtPBbP4OZziZ04N1zLVxpsQ3cYg0Vij1B0o2n8ktI0IqnSLqRg5yzxQC1Ah6
 LYxnaBDT6XJQbvk6s3yE3Dipjewn3u6BG2qH5dGZczpKRFEfYm/mPMDS8dzW0jz/gjd/G0mDl7F
 iEAL71RJnzj2Oq5DkjA==
X-Proofpoint-GUID: nc-ml6EXkJJrSioN4WXHhLEfWWVA38DX
X-Proofpoint-ORIG-GUID: nc-ml6EXkJJrSioN4WXHhLEfWWVA38DX
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a449d66 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=H7IkG6lIOHbWVTtTQWLpKw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gZVUUpDGDNxcYiTA8g8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0NyBTYWx0ZWRfX4yjhPgvxr9eA
 7yVMl/vdNjHn+cL4SQ3KYI2wfBLApAihTNJ03gAPVlkNpKu7AbUBvqcy3xJF3ASxud+1Sti4OVx
 krut4Cw2IaALpp6Uo75tbk3mVhsZbEk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010047


On Thu, 18 Jun 2026 16:36:08 +0200, Arnd Bergmann wrote:
> When endpoint mode is built-in, but pwrctrl support is in a loadable
> module, the imx driver fails to build because the unused host
> support still tries to link against pwrctrl:
> 
> ld.lld: error: undefined symbol: pci_pwrctrl_power_off_devices
> >>> referenced by pci-imx6.c:1988 (drivers/pci/controller/dwc/pci-imx6.c:1988)
> >>>               drivers/pci/controller/dwc/pci-imx6.o:(imx_pcie_shutdown) in archive vmlinux.a
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: fix building against pwrctrl
      commit: 7f4d9901eb1fdd3d2e56b514dcc325b33185b8e1

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


