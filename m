Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B438644F
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904634; cv=none; b=qjqt3PqDLIZsJc2dWh+/KaGxg+R+E1WafqHtm16znf1efmxNSZ/d4GpqprlS9WfieqGBbIFpoadV4uTKg9pYPNNr1aLU6Gp54Y/mBOi3X0sNvwahxyxJNIkCF4feucY5YKpH/cjjmulLh2J+BsuOuVLQEcBi8mO7m3CcvV2x/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904634; c=relaxed/simple;
	bh=mmyfZPaCUwrVyVzelZcY/HtUTXHtqBdi6SVGNq/yq2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwD36aA2SW4I/bsFl1HlJPNRRdfYErqCZ1uckEQugY3uBXYGXD9T+A8UwSG5pefCxpjJSOwnszICWsLKRM+kFpfuiF1Aq8El7a1CTf3QTJDcBy2nzqZxrVSMPH9kOTOZlDqMp5DFCGE/D6oucAjIqKq8SwJ0D29nTO9eFLsXcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ArHoDZaD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMD7jPip; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ArHoDZaD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMD7jPip"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Pko92733114
	for <linux-pci@vger.kernel.org>; Mon, 8 Jun 2026 07:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v+iBuTlJCGQPNjwvDXc2jqve
	RsmYKmF0YLF0hTmr7hg=; b=ArHoDZaDltiuEKPKeaKHn6mF443fBaa7o7B40KOm
	RiQEWFxSeU37PIgJ/aB1iRmZOCb7GumPzM/kFDEKUnPvx5WB/NdriWqus2Dzkd4N
	oqM/pycXMImx3aJtpppD1kZIJGwZXsF8rtU7uKxQsHMspEUh7b302kZ24gZQXGYo
	PUhkY3HA+F4d7DuCbi9kQres7w6EIls3etClxglrh3OxeABDrPDAuRSnOdkrzJYR
	96bcmfidO6GUEpIZT1hKZwq6fNpOiaFQbQnaQM76WUqF8Xjeu+pXXRpQX9jJs5rT
	hF22CiBX89YUzRbk0aGEE2uJVZmVFtXwTl5nVuijCo3Bmg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf6q27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 07:43:50 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6ce6f8465a9so4944009137.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780904630; x=1781509430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+iBuTlJCGQPNjwvDXc2jqveRsmYKmF0YLF0hTmr7hg=;
        b=kMD7jPipW85hjez7AOSPkED5GxnIkHqYiIKuJfOTQ9f4xP4TOn92Q2fDbHkybVbd9y
         gO+jd1MIB+QtVSUZdwj9SyQdWcH4Uz/MHxIAri3p3Hqt0rJM2HrTM4Y3t97aCv4H+YED
         lZLy+fiApbd0HWGs9PRf+P+BBD7jTNxrYzU99d9gBEibQEZ2odC/vYHicfo+713fcPIG
         kaKjUPTlCSnfWqKL4U18keqEuOBU27emuC9Rqm1WD1ZtBIr+nglaKN+KizbODK+bMnJx
         0P9Mx0p3G9nlaWyhYgyoE3ndzLcqFhG9mtD0qXpBLqnyXpTYwffcefJjsJlDAJKQxGwL
         HBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780904630; x=1781509430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+iBuTlJCGQPNjwvDXc2jqveRsmYKmF0YLF0hTmr7hg=;
        b=PMYeKmlJQIP084XlBrCIVnI7P1PYp8T/yVB40xuFWupFDNbJvsC159VEPr/yEpprHK
         JbjJ8mM6Eu2zMdUXnNAfV9FzaBgC4EAIFopR9ty/a1vkWCy5h3rGeikGN3ww69U3KY/a
         nrxKW9/c/jqZfN4JB+KeUUNfhFW65nAbrp1Gee9Ya62owFoaBQuq+a8SOQ1HAUmcs/UM
         SA/y5fXA4DD56XSQTEmUGBJ5GCDBVeP06CvfB2ySwkIiz6Nb/8mvX7P6lWH4u30Lqp+p
         iL7Hw3X+Io5suFPXPNxbVGeHvlqd2Q/W8xOn+erl0G/6m9BWj7uwp7xbLktP/cpRztYO
         cNoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gMDZbqwo1AtV0bAY8bjyrr15dsFYa+1hnXxjablKg96asO0gLeectIhp4JE8AsXlQp+NJlY1CeV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Qq9qw6EZeYE0oIbVL2A5jmuzMzHPf5pF+qStnMleyBQAX1Bp
	F5wlt2HRqzWTF664ZPHje+dZa2o6WYWysoMMBmbSpZNrXWsUzKz7OD0V+PoA65gDPzykTVbOxYM
	wUsKOY2LWhrbE75eCAcTD2FuT/cVRVsM//Co4fZ2p/Rr0LJYJ1L5dt9jIv+P0Se8=
X-Gm-Gg: Acq92OFBtrl0ohej8/fxUjWESoeQB4tV6VZzk6GSaQlNwZ8OEWBpJxB15t/0W7xKEMV
	QPAcqBLo0JWFLWmnea58K+LHObmDzKQKPbTvp7MrN+SRjzlL4u3BwNgqZsE8cQo84dfMwSD26Lq
	PZ9z1M9PmGsF0HTPu34K110V85TXLkbK9rJz6c3/YZQ/Y3G+AeCejlSsN5bI/4XR7yXb6m246c6
	0X6j2OMeja/5AF29A2bpiR0LHDfSfy5D90Bm3yTBUgV4RcJ2+kxSddUPNwg5j6O0xsesmOrir3Q
	AKm4agcZ4ttU14OyRdsxabQpKWFx64w7MY3q5kDCC624xcbIB2HP5sniGsXE0Zi6Nil+I8hb/Zm
	QC30DvowuL17KDsXFCmmMVpLmlHha40YSEJmKK7XqFK5UR+gdri3pAeik4bqbMmIrLwBQmLvQTb
	W9laLKyZ8sGBPwWMN7Q2vh9MnHyuyKucF5PnPhCCM879WX1g==
X-Received: by 2002:a05:6102:6b0a:b0:631:7781:fe8a with SMTP id ada2fe7eead31-6ff084a55demr6792173137.19.1780904630274;
        Mon, 08 Jun 2026 00:43:50 -0700 (PDT)
X-Received: by 2002:a05:6102:6b0a:b0:631:7781:fe8a with SMTP id ada2fe7eead31-6ff084a55demr6792161137.19.1780904629881;
        Mon, 08 Jun 2026 00:43:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b90421dsm3582675e87.30.2026.06.08.00.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:43:48 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:43:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Handle mixed PERST#/PHY DT configuration
Message-ID: <usvxtl4r2ioxpmmlp47ms3stoqz7b42agpnuiromaw7qwvz67a@y7suscxylym6>
References: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
 <gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonmexsxrra3v@v3fobqasxnmy>
 <0bd70e70-68fe-436b-8366-8a497861e21d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd70e70-68fe-436b-8366-8a497861e21d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a2672b6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1EBqKiz8AxVLgVlipLgA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: -gUOaPoYBRjJsIkzsvPonLYPlFb98mjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3MCBTYWx0ZWRfXy80OUs5lcNl3
 MuWD4pW+4dOctinocRFjqPFhpmOi5tBjInd1hBCxDwsnLbvLVCF+vkxXs/tgk/FnZEDo1yVwgZq
 haX5EpI9czwMuKri2dZWUUc5pMcLGyb1zJ+Gf7gDjBfeU1HvMwMdxRct8HeplIOYyrPWjJdryNJ
 d82AyTxHPImR8gOkpYu84BEAju0SpvNGl4enm4A+RKe0mZbOXZ1VSOjberJtOE1E4xQ2+9cpM1i
 pSMG2n8XknqWTj4F9Kuu5IornSQf30H4tGgFXUzQbUJwM5oi9NlA4PfYEfi9TmNj4hRMakU7lmk
 5GS72oCk3sHcXBkHmkRNPd9p4kolC/1wzqhVA9JFLLI9o1PRoewhOjr630Qn5tJ4+QfaOAAXbBI
 3HrwXmw6iKliefyFwka58mLD5TUsV85HYGBkAwWLzdw0qzITQET4k+f2vDHuVHD05dcCXnFJv9F
 aGWL7RIZNcc5RRRQakA==
X-Proofpoint-GUID: -gUOaPoYBRjJsIkzsvPonLYPlFb98mjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080070

On Tue, Jun 02, 2026 at 10:04:22AM +0530, Kathiravan Thirumoorthy wrote:
> 
> On 5/31/2026 4:37 PM, Dmitry Baryshkov wrote:
> > On Fri, May 08, 2026 at 02:54:19AM -0700, Qiang Yu wrote:
> > > The driver currently supports two PERST# and PHY DT configuration. In one
> > > case, PHY, PERST#, are described in the RC node. In the other case, they
> > > are described in the RP node.
> > > 
> > > A mixed setup is not supported. One common example is PHY on the RP node
> > > while PERST# remains on the RC node. In that case the driver goes through
> > > the RP parse path, does not find PERST# on RP, and does not report an
> > > error because PERST# is optional. Probe can then succeed silently while
> > > PERST# is left uncontrolled, and PCIe endpoints fails to work later. This
> > > silent probe success makes debugging difficult.
> > > 
> > > Handle this mixed case in the RP parse path by checking whether PERST# is
> > > present on RC and, if so, using the RC PERST# GPIO for RP ports while
> > > keeping RP parsing for PHY. Emit a warning to indicate mixed DT content so
> > > it can be fixed.
> > > 
> > > This keeps mixed systems functional and makes the configuration issue
> > > visible instead of failing later at endpoint bring-up.
> > > 
> > > Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > > 
> > > @@ -1778,6 +1785,14 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
> > >   	struct device *dev = pcie->pci->dev;
> > >   	int ret = -ENODEV;
> > > +	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
> > > +		pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> > > +		if (IS_ERR(pcie->reset))
> > > +			return PTR_ERR(pcie->reset);
> > > +
> > > +		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
> > This patch breaks legacy DTs (I stumbled on it on SM8350 HDK), because
> > now devm_gpiod_get_optional() in qcom_pcie_parse_legacy_binding()
> > returns -EBUSY (as the GPIO is already requested here). I'll send a
> > patch fixing the issue, but it's sad to see existing platforms being
> > broken for the sake of undeclared "mixed" case.
> 
> Dmitry,
> 
> I have sent[1] fix for this issue and it is squashed with the offending
> commit itself[2] and part of controller/dwc-qcom in the PCI tree.

Ack, thanks

> 
> [1] https://lore.kernel.org/linux-arm-msm/20260526-fix_perst_gpio_handling-v1-1-9170507bb4e9@oss.qualcomm.com/T/#u
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc-qcom&id=1a23bcb452d95f099e530414504c0d99ee076b3f
> 

-- 
With best wishes
Dmitry
