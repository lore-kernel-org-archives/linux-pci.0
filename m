Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527977;
	b=AxHGijmFXflvUf2r8LZwM4i0Y3qW/MUa4Ml3A7dQm3Pdr2MWF4FuFtrxM/4LYt8Yt/9R
	 KudkBrL5tfQX76bjJXb36yFSXokYdJL2Pk1G9aUu4t6YZzNkAyZ7naFxEn/gwbPhaXSYb
	 lVZDBPhkeWB7UsjVJ4FIIWEEmsSdcHy4MPhgjberxabhm5s7Pq2FAT/LKo13GQhB/4lU0
	 7JmTrri1UW7V5ztgpMtPRFiVgVqyba6DxEaoSfcKvavwhdf+SiZZzZ+gtDjR7tZqMBTkN
	 Y7ITgcRdKjM/3goEmlIw5iD83kU42Gez2TjsCSBIx1om4livgxjpZ9KO55jqkpUm7hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527977;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zPbiw4ZB1gHphClGjdjeA4UlOcJJr69dzbBrC67QfsM=;
	b=c74G78I89Hcx4M0DvFEcrStJgMLoL3uL6gpl192oh2UezwmrM2Lyor2b490LsMfp3jrY
	 S61UrON1QnCtrNveyGsg+sSzpnDslDPNU7dq/q4g2xhYJPB1g/dk1Iiqvjh+baYSQpwEH
	 ljDTN/+Tt1My1quD0iFexoU0w8zRa2AgCkiQHCw3GZGs13LdikheFJrrnJWBrEh4x5Vq7
	 CjXF4IJ/pSTbwRdS8P/6wCNnhMu6AMQePNc7dlpUfRB3SAFpaUQq8TqcN9Jyty1qrHksU
	 4UdA3J5Uop0mtlGN/Qg7Cf/qE05Z/qMpCO9IcptCZbw6SR/An3grNw7A/ps1+VSUSrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hJrGOuW5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HBsIl43z;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDC606A321
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ECDC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hJrGOuW5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HBsIl43z
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOCDOwK2848992
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zPbiw4ZB1gHphClGjdjeA4Ul
	OcJJr69dzbBrC67QfsM=; b=hJrGOuW5YBaVut9iXn7lGp7xYi/OmdTQQ8JEOixM
	kwf4pcVmkssjx8VSeXYLKSSYgKMPwoNJvSGG8jOQNbhFQqV2/FcJwyzxyZStABas
	MF6J2mZswzBqX0MaeCj4Wg2/ktASqG+2r73J1Rr7+Ju7FKudyffLz994scEuTGU8
	YB89zZfCFMrbGOm+KqQbzzeS4BQVxVjCQM7Dl3oFv0+WvGgE2ULnDitpxER9lIWI
	go/tXT+iY3pw99H22AN7oOGmx+ELK6c9BDX1vSLYDaPRJnz3gjjSws3lO+nFGqsJ
	Zyc8vYxyqMU1MFQ7/oWEz6pILy5a3SuQ4QmE+DB0jLn/sg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7rer4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 13:46:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-382af5cfc58so3668500eec.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 05:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795527974; x=1796132774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zPbiw4ZB1gHphClGjdjeA4UlOcJJr69dzbBrC67QfsM=;
        b=HBsIl43zc2eV5m7cmOVSTp8zWSm9HRvgiqyLBmR2iFgSWKAsdlWxNPLXAUNR2yYTtL
         04XJgKLC9Bmz/YXOYlbUOSwAE4ldrzaRna2xLWXZSiYb6fBpF5xmQNtb0nJcqa3RwdFX
         khoLe4M6qcsZhYy1g8sM4BzA9iTtyIO8GAh7ArsyuMXZoBTiA942WnDCZZNjPDeIh5ff
         pkfe2y5fQcUI3En2h/OA4a3h9xMd6IKnqJ8oKzSBdQyeTn0/1UXUS3+KZwDjz2FP0EhB
         zyPCU4wiyRk7EMttNKhf2G5r2RypNtvcILw2gxvg9f2DDYaxg7RJpUG3rxEA3e5yVQmd
         c+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527974; x=1796132774;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPbiw4ZB1gHphClGjdjeA4UlOcJJr69dzbBrC67QfsM=;
        b=uLmgRcSZ7oPjBozMCX4YwJe8AZFfJkC7jWWTdzr0fUN818819HhDdSbdbOERqpl4Xm
         fngzGnkC3qzJZhCAUN14Fqhu8eIN9e670yV3O+psj1Gst91t0DMVnSNig9jT8yalibKP
         eK6Aw6A+xjEOIT0A3WbR5MqlX8QS3L+C7kn8PGZm5sW9HGVx/QX++7QPBDDT9GjAxE5E
         lpklxJ47RvG/noYUhC0pl1/xgqrwdTKCQDIvCDrLlnRLSJUh8fRLdOM0ghRGjjQv50RC
         5QdghVTvRU+fTGqPQYaA8dRPjeb7BrfC9+nZFys3MoiaqFiqwLppGCyH4Co/vP0a/TG0
         nADQ==
X-Forwarded-Encrypted: i=1; AL+hErHGU+DmOxDYhuncaWKWPc4pUb+ha9RFn2glOJ/vX/ZHLCwx+exzHw+7kj6TjESiuB86er03EbrhIyU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+i4MVPSEDKfgiTKE+DYdeLAbp2kjl92Pqn+fP6tIi7tbn2xFyT
	OlqZ56y40Ut6hz/1ycvDi+VY6bax2RjIDpdoR1r0LuVoWTrjiJGQHILgVLgT1FYxHMMkGq0DE2p
	JzETcCt5FJUTv1KAmNs+hs/Tt9ZAAc9uOch9Ngcsp7Uzu7BMol4x7DzJNolX0VS8=
X-Gm-Gg: AZFdTZdOKWcLn94ItMRSm1bhzokO4wD5+3kRt8eXpsrlVwm4cQsi0rSt/M1iNrev4g2
	MSmNYAsc9s4nPY3MpA94W7uUWzbLwbhEal0rEKCTL0OMrbmsZWvSbd70iksLV1r/Tj9sEKoRJFr
	Dt81sJI7Rh6mKJA33JWdIehDCDy0YGrR5IafC/7f7Q9TWXswo4KFzo+vhzp+hTV+elHzwTZJPkl
	hSepLfEDj4gtxZVlVfhcsKzhQ0pQtPwiCJur5yGglzozuXIbkQ1i5El618QkNsrZKKVoURx4+No
	GRtyj9ZvdCr4mpERDc12uRMj6TH1q8FTTLbLsXUn0UUtuBjWvNP9ETUxWi3h8ZI+xD3YQRfjqeo
	HwtiC90Zw4Vo3/smlXbPUwkZnNoFUqgh7kEoxI/V0Q3ehPzFeVylAM/kYyN5n2OFSVL0PX+DYtD
	QK6+ozU2PwGBYJ+Uiu
X-Received: by 2002:a05:693c:805a:b0:376:a6d7:8f51 with SMTP id 5a478bee46e88-3856e63bbe9mr18149368eec.12.1795527973957;
        Tue, 24 Nov 2026 05:46:13 -0800 (PST)
X-Received: by 2002:a05:693c:805a:b0:376:a6d7:8f51 with SMTP id 5a478bee46e88-3856e63bbe9mr18149346eec.12.1795527973410;
        Tue, 24 Nov 2026 05:46:13 -0800 (PST)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386992b404bsm33790831eec.1.2026.11.24.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:46:13 -0800 (PST)
Date: Tue, 24 Nov 2026 21:46:08 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Mask PARF_INT_ALL_3 events on Nord
Message-ID: <awWVIGmkGzyVL89N@QCOM-aGQu4IUr3Y>
References: <20261114084700.907031-1-shengchao.guo@oss.qualcomm.com>
 <179492110006.194330.16578214355369868159.b4-reply@b4>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179492110006.194330.16578214355369868159.b4-reply@b4>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfXyfnIEPPAtWNz
 WMOER70x+H1wHIR2WPhy+TIRwVGfe4BoOndjy9UJVp6riQFbuq/FE9ZH7HZ0zCPmHWP0cTDRYLL
 bO0MsK98Ftj1gsemdHnHj2I8ZFuOwks=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b059527 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=GkseLWfAocwtZgMctr0A:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1MyBTYWx0ZWRfXyJ7C4sNW0eqv
 z8vCXZCcijnWW8rL6hxVfNbtR5RWqUh43FsRv8PZ5D/PAPrPCx9Acy0tgMD3IEqiHQ8RW4qrgt5
 S6hD2Hj9tXp9gpfVq0Up2i2/leF+LyAWmena2OcWXYvj5y+JepjQ8a3cu7BxZNbsJ6hjmNyg+d2
 Ac5VLhSQRKWMpHNCUKY9cQeV0xTAbn8stSxfw3S0eeZnTf8W7Vrmxab+sUioQbG2KOGh7yphUUy
 i0NzFbHqiaAZe96KNfT6viCMLqzLSdlE2zmqugh4YrvURCzx9DYJc1f+Y92igmmgTiVJrPpufN4
 yPs5lygHaT4JMbcf/zEwcVZnL14yxLcz7srCyz2n9JknOBQ9RS+jQ13kNTNkuwXemQUtulCOvGf
 UrlcUZlB6OmDTkXkWkyd3ClwBzpkO3hPmviA1qOk8WdQ3THz3/QYP4YWKnGZx40IRlANZTGVTUj
 RGwxiE87GG6PPg+1E1Q==
X-Proofpoint-ORIG-GUID: LSoaVQOuXnDaK0hLAvnCwOxeCo7OlWIZ
X-Proofpoint-GUID: LSoaVQOuXnDaK0hLAvnCwOxeCo7OlWIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240053

On Tue, Nov 17, 2026 at 02:11:40PM +0100, Manivannan Sadhasivam wrote:
> On 2026-11-14 16:47 +0800, Shawn Guo wrote:
> > On Nord, the PARF_INT_ALL_3 interrupt group is unmasked out of reset
> > (PARF_INT_ALL_3_MASK reads 0x43fff), and its events are routed to the
> > same 'global' IRQ as PARF_INT_ALL. The driver neither handles nor clears
> > any of them, and the global IRQ handler only looks at
> > PARF_INT_ALL_STATUS.
> > 
> > Some endpoints send a Device Readiness Status (DRS) message after link
> > up, e.g. the SK hynix HFS001TFM9X186N NVMe drive (1c5c:1069). This
> > latches DRS_MSG_RECEIVED (bit 12) in PARF_INT_ALL_3_STATUS and keeps
> > the level triggered global IRQ asserted. The threaded handler then runs
> > in a tight loop with PARF_INT_ALL_STATUS reading 0, starving other work
> > and stalling the boot (RCU/SRCU stall warnings).
> > 
> > Mask all PARF_INT_ALL_3 events and clear any latched status on Nord,
> > before the global IRQ is requested in probe and again in
> > qcom_pcie_reset_root_port(), since the register is reset together with
> > PARF_INT_ALL_MASK. To keep the two writes together, move the
> > PARF_INT_ALL_MASK programming in probe into the same helper, which now
> > runs right before devm_request_threaded_irq() instead of after it.
> > 
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> 
> Missing Fixes tag.

Will add:

Fixes: f75d2d64fff1 ("PCI: qcom: Add Nord PCIe controller support")

> 
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 30 +++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index eba1b2cb30f0..03b2e61fc20f 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -73,6 +73,8 @@
> >  #define PARF_DEVICE_TYPE			0x1000
> >  #define PARF_BDF_TO_SID_TABLE_N			0x2000
> >  #define PARF_BDF_TO_SID_CFG			0x2c00
> > +#define PARF_INT_ALL_3_MASK			0x2d8c
> > +#define PARF_INT_ALL_3_CLEAR			0x2d90
> >  
> >  /*
> >   * Outbound blocker range registers. The blocked range has a write pair
> > @@ -294,6 +296,8 @@ struct qcom_pcie_ops {
> >    * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
> >    * snooping
> >    * @firmware_managed: Set if the Root Complex is firmware managed
> > +  * @mask_int_all_3: Mask PARF_INT_ALL_3 events, which are unmasked by default
> > +  * and would otherwise keep the 'global' IRQ asserted
> 
> Reword the last line to 'and are not handled by the driver'.

Ack.

> 
> >    */
> >  struct qcom_pcie_cfg {
> >  	const struct qcom_pcie_ops *ops;
> > @@ -301,6 +305,7 @@ struct qcom_pcie_cfg {
> >  	bool firmware_managed;
> >  	bool no_l0s;
> >  	bool disable_cgc;
> > +	bool mask_int_all_3;
> >  };
> >  
> >  struct qcom_pcie_perst {
> > @@ -1738,6 +1743,7 @@ static const struct qcom_pcie_cfg cfg_nord = {
> >  	.override_no_snoop = true,
> >  	.no_l0s = true,
> >  	.disable_cgc = true,
> > +	.mask_int_all_3 = true,
> >  };
> >  
> >  static const struct qcom_pcie_cfg cfg_sc8280xp = {
> > @@ -1871,6 +1877,22 @@ static int qcom_pcie_set_max_opp(struct device *dev)
> >  	return ret;
> >  }
> >  
> > +static void qcom_pcie_enable_global_irq_events(struct qcom_pcie *pcie)
> > +{
> > +	/*
> > +	 * The PARF_INT_ALL_3 events (e.g. DRS_MSG_RECEIVED) are unmasked by
> > +	 * default, but not handled by the driver. Once latched, they keep the
> > +	 * level triggered 'global' IRQ asserted, so mask and clear them.
> > +	 */
> 
> This comment can be dropped.
> 
> > +	if (pcie->cfg->mask_int_all_3) {
> > +		writel_relaxed(0, pcie->parf + PARF_INT_ALL_3_MASK);
> > +		writel_relaxed(~0U, pcie->parf + PARF_INT_ALL_3_CLEAR);
> > +	}
> > +
> > +	writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> > +		       pcie->parf + PARF_INT_ALL_MASK);
> > +}
> > +
> >  /*
> >   * Qcom PCIe controllers only support one Root Port per controller instance. So
> >   * this function ignores the 'pci_dev' associated with the Root Port and just
> > @@ -1928,8 +1950,7 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
> >  	 * non-sticky.
> >  	 */
> >  	if (pcie->global_irq)
> > -		writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
> > -				pcie->parf + PARF_INT_ALL_MASK);
> > +		qcom_pcie_enable_global_irq_events(pcie);
> >  
> >  	qcom_pcie_start_link(pci);
> >  
> > @@ -2429,6 +2450,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >  			goto err_host_deinit;
> >  		}
> >  
> > +		qcom_pcie_enable_global_irq_events(pcie);
> 
> You should not enable interrupts before registering handler. So you'd have to
> mask and clear here and keep the enable where it was. This means, you don't need
> a helper at all.

Right, unmasking PARF_INT_ALL_MASK before devm_request_threaded_irq() is
wrong. Will drop the helper and leave both PARF_INT_ALL_MASK writes as
they are today.

Before I send v2, I'd like to check where the PARF_INT_ALL_3 masking
should go. Masking only in probe and qcom_pcie_reset_root_port() misses
system resume. When the controller is powered down in suspend,
qcom_pcie_resume_noirq() goes through dw_pcie_resume_noirq() ->
qcom_pcie_host_init(), which resets the core just as
qcom_pcie_reset_root_port() does. I checked this on Nord RRD:
PARF_INT_ALL_3_MASK reads 0 after probe, and reads 0x43fff (the reset
value) after an s2idle cycle in which the link went through L2 and was
re-trained. A DRS message after that would wedge the global IRQ again.

So I'd rather mask and clear PARF_INT_ALL_3 in qcom_pcie_host_init(),
right after ops->post_init():

        if (pcie->cfg->mask_int_all_3) {
                writel_relaxed(0, pcie->parf + PARF_INT_ALL_3_MASK);
                writel_relaxed(~0U, pcie->parf + PARF_INT_ALL_3_CLEAR);
        }

That one place covers probe (dw_pcie_host_init() runs before the global
IRQ is requested), qcom_pcie_reset_root_port() and resume. It also runs
before PERST# deassert, so the mask is in place before the endpoint can
send DRS, and no helper is needed.

Does that work for you?

Shawn
