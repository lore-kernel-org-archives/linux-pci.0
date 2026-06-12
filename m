Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A0934F24A
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245336; cv=none; b=F0jLrLk1mbPkpR3LC58xMlYtulqBVEeBya0//NnFAUzul6FgxgW9xf5nOTDPjAkxeOy6tEJmdiYUPScyuzKYdUsgqdkJic05wrI/3yrN+14+PH1kofIAau1AwZb0vl7qm1bCEFX03kQBvwJuSTsDEt5elITuzemiMt4EPKPrUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245336; c=relaxed/simple;
	bh=9iqy1lLQxvVwdgkFr/jdiScy6r805+sd9YPN4XMJ5oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iILVPvp/rJWmsYCmJdmIuvdirfB9aEzWKovwxzlOkshpiZAoLDjHIz4ijhQHieshlcqVKQtH1Scw7tfsZuJBpi31C2qqi9ZOc8SrGGfnS+oMC3qoiigSvIjQMVQUh9M/cQn4CG0A/UnQH0t+O4soIYCeaz7q0iHfw5nOZioC074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jZFgzOXK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P7a8XEre; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZFgzOXK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P7a8XEre"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39fxb2497007
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 06:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n7Yf1YYFjiuiIuFcDTEBV9uJ
	IVRQFm5qqW6YmchUZPg=; b=jZFgzOXK9pKsRi2r5t7j3LL0DzuWJGnuEJvYH0Gd
	CXK0x0Sn8WX7d28XX2Qz7rbvbz0nvfJyJYkG+FxBa9SzhEK4XlckEZuuhHxna15m
	vQau1gp5ZqWskc7mVmf3RgoBBRCDbr93dKQ3/iZXoTIPGpn43K/DYvfF/ESw+/ez
	SfllUhLNKp/jFNUCroHLzTdp+KhLZACJLyb+6Jzi5EIdsX/YZTeruBfkA7lEG9uN
	cm7OYFoCOyU7WheX24qlJsN969sn17nYm6PUT1GTRhsbdPR7bWRKfXkkMHpNaN2q
	rYhXJYf6wLuamA70or1UgOrWYGzLoqKtf1lSGMtgC1F7+Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7je0j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 06:22:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9158f2c4b55so111440585a.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 23:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781245334; x=1781850134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7Yf1YYFjiuiIuFcDTEBV9uJIVRQFm5qqW6YmchUZPg=;
        b=P7a8XEresDdl0eww1tsRJN1CQ+AFQSv15H0dUStl5O3MG9o4hQbdgk0hl73i0Nw2MK
         WBNEZeRqeb3hVOM4fhRHWTZgVSty1ZeXZg7n6S7WlikaL6V12t1NG6rjFrqYmN+NVSnz
         WyD4r+NFmVkDzPW2gqiblklKDWPLsAzWWhYKnAcItK2LI12CgEyTb4/U7uvC0kU7MAuE
         y6ul1KC1UJYTgCGOryIYCMnL3YyYZTQqoeInokm30k8tff7vIWep+guXbbTFtoup+m7j
         o+QCtJK3/UhBLjGpzg7BjiT9G26gbhXZxFDsKLsCPdf453j4Pq6Y23uPAYrhVEPBwTjT
         SW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245334; x=1781850134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7Yf1YYFjiuiIuFcDTEBV9uJIVRQFm5qqW6YmchUZPg=;
        b=L05oREHTCKvTlqWE/3QtcLcHufJR835GBhEUVAU/WL+YI8qgfJfoNhi8L8GOf+1FPz
         o6RlucY95BrbO9namLnk3LIsVVw9+XySZG8ba8bO0OuHo/ZbqFNqBrd6A10Q+7svv7O5
         XcUft2ZL67wo5cSiG3qi45+ApErd1GQr2oApjl0SOLlrIQsFFzFz45ANwViixsYyHlDW
         VB+oCRJIkjrz/dD4X+ZEgDBdfhbgfaA1NxxjeXPdKT1Rs5H2rDuhbdrKCoO9rQkW3Lt3
         VjfEcUwjFYUZSge3vJwT2tISdOIO36hFFKSxvVp+ken6URYKJpkv2zjaR1qIKgfh7MvA
         xFuw==
X-Forwarded-Encrypted: i=1; AFNElJ+h8gsnJyWZRSLcx3rar2zBSgCMZJFH8R6TLb3FSHz/i8t7w/dZZSjTDje38g4npnX8x6MNqS+OjTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bDBLyhVY0xzypd51y3kB2o06uhph+N/SAvJAaXPqKtM/GIRk
	5h5p1oHxzhP2BXSeU81rSmMceSIdiiwTTWVUqGQLfraUfm53L2bl/lLV7yzPuc6Vgy7XAlgp/Ai
	6LkRSa6EqNF111qZ+pyXy12JC9geFQbeijUPURE74FpmXz2kROo3syQ9OO3pyVhM=
X-Gm-Gg: Acq92OHKz3oqLx66c/r42x4MjINtZ81gNx0fw8EYwsMgDtjJih5zsUhG2kw2EdXaKVL
	C1QoiZ+H9Bch5WJflBX9WV8WVwoUzWI4g0bKMYf3HJgw0ULCLMbMTrZXhppJ2MGVaSXCTAlMJL4
	5XGAfv7pGeWHj35rF+4KgaQnWj3ruHAVx/X4o9rTKL9CO3Zrlv517GPCJupaQ0QQSDX+N1FR4Jc
	n/XK9M+7UbffVqV9W54i6BWGcSLU5HHYv2m/flMZBxCVxCXYlxkcvJ/y1oTqfIVrogTceJPgWWv
	UJorHppgqkRi49h8VSMFEIBbX1/BT/shT5aGaR653+Axl9X5W00fzPr7J1ZbzgiUuXDcIz/gVbz
	VO9I5aOAIXEM/H6BrjCqEorUuu30LlpbJmIz34rE3CcWCxHtsjqi6elzRCbd1238pgd0++wNArm
	fRhwim8v1E94jyiwHy3Qd0IS4gQmV8t1Yr6Rw=
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr18736001cf.52.1781245333849;
        Thu, 11 Jun 2026 23:22:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr18735801cf.52.1781245333414;
        Thu, 11 Jun 2026 23:22:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1aeb6dsm253549e87.64.2026.06.11.23.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 23:22:12 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:22:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Matthew Leung <matthew.leung@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Message-ID: <m2kwzigrz4fbdedzr2bj2auqtvafj6qstbplghssato4d6tdnd@ftug3clgxmd6>
References: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
 <20260529-hawi-pcie-v2-1-de87c6cc230c@oss.qualcomm.com>
 <2tenqkmwcr2gshtjwh44pvban4gtlzcgrm3iibkfrs4zh6vphb@h5losfunylr6>
 <aiteRU8cWykuhlVO@hu-mattleun-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiteRU8cWykuhlVO@hu-mattleun-lv.qualcomm.com>
X-Proofpoint-GUID: aoSJ9qgWYVGJEtrx1bsE5sVDoZ6kt-iq
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2ba596 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=onbnNvR133blzQGUTA0A:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA1NSBTYWx0ZWRfX9Mf6gH6oOclS
 y6GGuAaV8iXgEo//I6aBec2g5xPDVuDnyaILSVEHCuGMFVQbTht6dZObBMDB1aWJvOnV6JYUuFh
 JQn+SmrKMdqE4F75gAZDymn8RMdJu+xk7GuFQ2VMiA5hGpnFEbMT998XomqRphVHYt1IzPCh56h
 LVAiOzxTdYwf52VNXQWav00CesDi8Q8YqtTyZsy13Wc8pZhSwh9BiZCKKyflnSiVXiojsd4cCtF
 at1Izm8HlyuzmNr5+y/WfU6bipHinQ2cxT9+sbCHtGXWZxld/X7wg0NTG7lVnoM/nJP1dJtLsgp
 cVHoUuU6yhD4GeuH6eHo/WUYRZP0YsW14Jay+IVEn4HZ354IutyDS47iF3kPHrkraW4Pq0MDzVf
 TDU8fb2hAMKoUrn8vV6BP3wIk8WMNYe2gmg5QooaesSIndziNUdP9O4hF4qbuSLv2A26hYYk/cX
 biXZAY7ebXl6e+wCp1A==
X-Proofpoint-ORIG-GUID: aoSJ9qgWYVGJEtrx1bsE5sVDoZ6kt-iq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA1NSBTYWx0ZWRfX3lWsbIBvV4Hl
 er3Q6zgdV/LmN5+vQquwVZ4LP8+wwAxDpHV/2McBaXCaQN7Ijnwhe7XyYwp43IIXfTJVjZXCqDD
 p/zer1G/0j1uH+3NcX5gmTIuYBCM/IQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120055

On Thu, Jun 11, 2026 at 06:17:57PM -0700, Matthew Leung wrote:
> On Sun, Jun 07, 2026 at 11:01:10PM +0300, Dmitry Baryshkov wrote:
> > On Fri, May 29, 2026 at 01:10:08AM +0000, Matthew Leung wrote:
> > > Add a dedicated schema for the PCIe controllers found on the Hawi
> > > platform.
> > > 
> > > Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
> > > ---
> > >  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 204 +++++++++++++++++++++
> > >  1 file changed, 204 insertions(+)
> > > 
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/qcom,hawi-gcc.h>
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    #include <dt-bindings/interconnect/qcom,icc.h>
> > > +    #include <dt-bindings/interconnect/qcom,hawi-rpmh.h>
> > 
> > Stop referencing clocks and interconnect header files. Replace used nocs
> > with ephemeral values.
> > 
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +
> > > +    soc {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <2>;
> > 
> > Not looking around should be a sin. Take a look at other Qualcomm PCIe
> > bindings. Compare them to yours. Then fix yours to follow.
> > 
> > Hint: the extra soc node is useless. This is just an example, so use the
> > default, 1 cells for address and size.
> 
> Thank you for the feedback. This new binding follows the examples set in
> the qcom,pcie-sm8x50 bindings and retains the same formatting (extra soc
> node and header references).

Hmm, interesting. Then I'm a sinner :-)

I looked at msm8996, but I didn't notice that the rest of the files use
the soc node (and match what you've sent). Please excuse me.

> 
> I understand the example can be simplified with your suggestions but
> want additional confirmation that these will be the convention for new
> bindings going forward.

At least, let's keep it for now. The other comment stands. To remove
dependencies please use ephemeral nodes instead of depending on DT
bindings from other subsystems.

> 
> > 
> > > +
> > > +        pcie@1c00000 {
> > > +            compatible = "qcom,hawi-pcie";
> > > +            reg = <0 0x01c00000 0 0x3000>,
> > > +                  <0 0x40000000 0 0xf1d>,
> > > +                  <0 0x40000f20 0 0xa8>,
> > > +                  <0 0x40001000 0 0x1000>,
> > > +                  <0 0x40100000 0 0x100000>;
> > > +            reg-names = "parf", "dbi", "elbi", "atu", "config";
> > > +            ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> > > +                     <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
> > > +
> > > +            bus-range = <0x00 0xff>;
> > > +            device_type = "pci";
> > > +            linux,pci-domain = <0>;
> > > +            num-lanes = <2>;
> > > +
> > > +            #address-cells = <3>;
> > > +            #size-cells = <2>;
> > > +
> > > +            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> > 
> > <&gcc_pcie_0_aux_clk>, etc.
> > 
> > > +                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > > +                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> > > +                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> > > +                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> > > +                     <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
> > > +                     <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
> > 
> > -- 
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry
