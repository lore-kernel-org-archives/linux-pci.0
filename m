Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC8218845
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757871; cv=none; b=R3vIXzR0o7Yx4Wu8TMS6R0bUVB3OEvgaRCC9uPYJElPAE2DdRBIe9WO+6qddBlJOArUDhAUf+iF2iSQL8bip7i/HoDX0kCgglsdqUl9AFP7fXmY07wGaGrs6tDIPsivzEm7glyh/7q3WdWyR+OMnuUfdOfYMLmpmJ02ifupeN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757871; c=relaxed/simple;
	bh=e2X3uLyEyJwxM5HjZMv7HNmigKfP2gEwrUoXrdaESkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5xCoNFjHvO9GX0MRWr5rMPHGPlVTIaJxetuvUc/MJzQKn3ZnFj5/SwP4j3+JGs5RUbMr6B3REDC77UkO2NEF69ieAv+zkisESu3wdClVzvOU7NHhGXwCD2Va6/LSG1fiT9Vq9CUGU2nfhBm4wrVvmWmFZGV0HkxwEppnfxSIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cbiO7uKu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NW/VVPgT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cbiO7uKu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NW/VVPgT"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I3wkVt2845619
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 04:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TTyZtbn6rwu4RjX2VYmmyUvR
	qm9Y3D608YZqL4TcQDg=; b=cbiO7uKuI7iG/4dvMRCT91ZpwfANL9HtWo5FsymJ
	DUza1/WQRp58RU6yBxST6QoirvbOcYMJTrfE+FacjmOOVUxpFwwJ+eTX7ZxFeTwl
	kp/p2hIyxglfjXQE3Ovg2r0y+KTvDOmlKLxrcOS61mzepZWMMfV0fQyv7AWJgF0p
	BX6orKnRo+c9m2hp3mgVabTBGxm8oSJi08DJc/0jGK+eifPnCufXM5sUvfftKPIM
	MbRibK1wSQrleVouV+/yPW41hKxRlSMVl2zkG/QngLtjet33ZrrQI0H245ctn3Uq
	cm/tvqvP4nFQ8K+/UJ0yAQVldMs0185nQiHQzzR8RkC32w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euxt52mqa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 04:44:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30ba395b047so2192685eec.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 21:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781757868; x=1782362668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTyZtbn6rwu4RjX2VYmmyUvRqm9Y3D608YZqL4TcQDg=;
        b=NW/VVPgTR+eL045c1omPCxGWh4PgadN/OyzVyULba+szg0Stpxn5l2qmZtyLLrF6/w
         m2FkylvRYSRK42V7u7ux3GF8T33FyVcfT/Wp6fNGLTWadh4uMMJIQVrolpFFtc2lssX4
         87cKqtUnYE3PVS0PWA+P+Wt5+JyrkG5lo2MoA/9aBBAvXfhjduh/p2ubGDa84WjJwGX1
         Jh6VJn43Ob5ibr6LLGkSLhbdF1u73T4ZJSKFvgl4r2Y4qomWAcM7U6120ydmdm5kP3mz
         RedjFQbvExGy3psHQPSNdmZ/FSY/zubdmfOdK/3wIwF/zSU82jqGcyGifqlN7Bb5KvsD
         4i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781757868; x=1782362668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTyZtbn6rwu4RjX2VYmmyUvRqm9Y3D608YZqL4TcQDg=;
        b=sAoto9Q6WceLLY6dlnXxOUTJD4VCGJo55hQd+8iiBUTtiDE+uNwpQ+L+fijhtsloaT
         OOJyloOArChH6I/UXTm9hngdWokIEmOJ1f52Rv5zRWzR0+FO/H1GI7r7MW3XQKf+kkib
         0Hx1/j24H0eTAyp9jRPFTikvnLgzCY0r5ZoH9eO7mN5quJMe1l0ZdbbsBASEjaSlAhnQ
         5I41H3MPmlFnOMr9+mtc23crY2Vj9RBiBIVi6xDcZjsghfI+1sO+P8q4Iuz0LJxOwdb4
         8gOSjSl8YvUhSm3TUw1ehVv64+aa+lkdl9Da92/89P4B3XKIZjmgSisBOpEabs2td/8E
         jIwA==
X-Forwarded-Encrypted: i=1; AFNElJ+IQnELhnfPnYNK+WMmHUE7inhkQ5j9ZUlL0cedn96WK4G8AWKaZfC8aOQ/H2ejt6GwyGONvsFg4bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIWwkUzIcSQRlyHIXhNBWjcr/Cjd8DQrsAjiEzGmxS3vemYxq
	pM96/m1gQOcS8D0oXcMk0I5a0PpMGCYQpULlMpA3RqlXfZLGvmxZIwRfBh48m5uzQz1dKAhx0oA
	LOi0bRSJoHI1aAil/bSMMJbXMr4HpQyuMZ6Pf7LP4YGlXCFnBTNXjSSYFYXHqCRM=
X-Gm-Gg: Acq92OGVxAVf7fJJtoWIeSrFrlY+GH4pwLi7+gXwkmIjGx33KhU/5dCORIZ4dTYkkz9
	hDwFQho3N129Gbkp6AZsU/8cHdEJXejT6RLKMshOA4he97urdJMTZpGoqLPTstFflokdLQfqnF2
	tIPIC1k4Y4Kvj/hVW3YVW8bfyqUrWnKw0eKsL5bcoM9SasLaiX1EYgC7rII3U86wmTjhBEWtPRl
	XTITPp/flIF4UlB7BCBYe6fEQAnL2laduc817Fk5zNZI6tBP2x8j1WoxDBeWGrrTJFF5ZUT7ab1
	VQHP6IKQBC+0xX6B4F5/93WSb7Hb/edWzWsar/js4GTpXoJFnXU5P43xah2uceKkrmGyb5Ue9XN
	3MUnk97aL9nhjFInMNT/QBBEF3qZUOIkxxBBCXbR8lXYNJQ1M/Eqy2zd9tBW+Hz2cTdA=
X-Received: by 2002:a05:7022:493:b0:138:2a54:f6d9 with SMTP id a92af1059eb24-13997c79011mr1185373c88.25.1781757868346;
        Wed, 17 Jun 2026 21:44:28 -0700 (PDT)
X-Received: by 2002:a05:7022:493:b0:138:2a54:f6d9 with SMTP id a92af1059eb24-13997c79011mr1185341c88.25.1781757867797;
        Wed, 17 Jun 2026 21:44:27 -0700 (PDT)
Received: from hu-mattleun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bd23401ecsm4461963eec.25.2026.06.17.21.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 21:44:27 -0700 (PDT)
Date: Wed, 17 Jun 2026 21:44:25 -0700
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Message-ID: <ajN3qfWV75SqNzgo@hu-mattleun-lv.qualcomm.com>
References: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
 <20260529-hawi-pcie-v2-1-de87c6cc230c@oss.qualcomm.com>
 <2tenqkmwcr2gshtjwh44pvban4gtlzcgrm3iibkfrs4zh6vphb@h5losfunylr6>
 <aiteRU8cWykuhlVO@hu-mattleun-lv.qualcomm.com>
 <m2kwzigrz4fbdedzr2bj2auqtvafj6qstbplghssato4d6tdnd@ftug3clgxmd6>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2kwzigrz4fbdedzr2bj2auqtvafj6qstbplghssato4d6tdnd@ftug3clgxmd6>
X-Proofpoint-GUID: 9fBLAzEG1OZbBTLu9UvrgKiorp33OXnE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0MCBTYWx0ZWRfX+EU6Jqz6TIuy
 s+a0QmpwW9r0HCrtT+tDqyxuawNc6xt40vKLB+pUqaPz49EtJNyWaN/EooAuCelHu57MMOTmr9h
 13UWemuxMCzKwXO/T0fIjCIJuntL2Cs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0MCBTYWx0ZWRfX6+ZimoqmwNyB
 3GHrrPvyOgqZ+ZZyZYEJQ/9dH3wfqmlu+s5S9W4IpoA29DwhBRg/I2kx4QMw+L7WpUhWueoFuDZ
 4UImOf5eOn9SjHFrEhjnblGn9aG7yjzhDPXc4DfuxSstVJ+dn33rr7io1eL/6KpV/f+9savmB/P
 5fd7a8D9UA14VsW6XriD0fZMY+prM+sFX+hhAHe8sXvQ9xxboi6qMj9xI7wKbe+p7lQPyfBKyUZ
 jnf0DMt7s8Lh4eoSsqnhLSI7PBfJRh8K61pDJT8M1aIs8iV0yx8lDYFDw4z91K9r7N1USysSBY2
 VgfnW0U4GgOoob21RFVqqA5vum+Yjb5xMTjfekVYZuKftlbVU3xPEKdc77Tr4x4M+BJWixE9IVA
 LRDqBDOzwQAVDbTlaGestm4NHiVHS+pRo2xskNYP3YRvN1Zfi33pLtIastyNRIIlIe8FA9FOODs
 FxF2FWkbRYizBqNdsDA==
X-Authority-Analysis: v=2.4 cv=PMw/P/qC c=1 sm=1 tr=0 ts=6a3377ad cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=8dstwiPKDIhgTtwZBQUA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 9fBLAzEG1OZbBTLu9UvrgKiorp33OXnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180040

On Fri, Jun 12, 2026 at 09:22:10AM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 11, 2026 at 06:17:57PM -0700, Matthew Leung wrote:
> > On Sun, Jun 07, 2026 at 11:01:10PM +0300, Dmitry Baryshkov wrote:
> > > On Fri, May 29, 2026 at 01:10:08AM +0000, Matthew Leung wrote:
> > > > Add a dedicated schema for the PCIe controllers found on the Hawi
> > > > platform.
> > > > 
> > > > Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
> > > > ---
> > > >  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 204 +++++++++++++++++++++
> > > >  1 file changed, 204 insertions(+)
> > > > 
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    #include <dt-bindings/clock/qcom,hawi-gcc.h>
> > > > +    #include <dt-bindings/gpio/gpio.h>
> > > > +    #include <dt-bindings/interconnect/qcom,icc.h>
> > > > +    #include <dt-bindings/interconnect/qcom,hawi-rpmh.h>
> > > 
> > > Stop referencing clocks and interconnect header files. Replace used nocs
> > > with ephemeral values.
> > > 
> > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > +
> > > > +    soc {
> > > > +        #address-cells = <2>;
> > > > +        #size-cells = <2>;
> > > 
> > > Not looking around should be a sin. Take a look at other Qualcomm PCIe
> > > bindings. Compare them to yours. Then fix yours to follow.
> > > 
> > > Hint: the extra soc node is useless. This is just an example, so use the
> > > default, 1 cells for address and size.
> > 
> > Thank you for the feedback. This new binding follows the examples set in
> > the qcom,pcie-sm8x50 bindings and retains the same formatting (extra soc
> > node and header references).
> 
> Hmm, interesting. Then I'm a sinner :-)
> 
> I looked at msm8996, but I didn't notice that the rest of the files use
> the soc node (and match what you've sent). Please excuse me.

It's all good! :)

> 
> > 
> > I understand the example can be simplified with your suggestions but
> > want additional confirmation that these will be the convention for new
> > bindings going forward.
> 
> At least, let's keep it for now. The other comment stands. To remove
> dependencies please use ephemeral nodes instead of depending on DT
> bindings from other subsystems.

Agree. Will update in next version.

> 
> > 
> > > 
> > > > +
> > > > +        pcie@1c00000 {
> > > > +            compatible = "qcom,hawi-pcie";
> > > > +            reg = <0 0x01c00000 0 0x3000>,
> > > > +                  <0 0x40000000 0 0xf1d>,
> > > > +                  <0 0x40000f20 0 0xa8>,
> > > > +                  <0 0x40001000 0 0x1000>,
> > > > +                  <0 0x40100000 0 0x100000>;
> > > > +            reg-names = "parf", "dbi", "elbi", "atu", "config";
> > > > +            ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> > > > +                     <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
> > > > +
> > > > +            bus-range = <0x00 0xff>;
> > > > +            device_type = "pci";
> > > > +            linux,pci-domain = <0>;
> > > > +            num-lanes = <2>;
> > > > +
> > > > +            #address-cells = <3>;
> > > > +            #size-cells = <2>;
> > > > +
> > > > +            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> > > 
> > > <&gcc_pcie_0_aux_clk>, etc.
> > > 
> > > > +                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > > > +                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> > > > +                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> > > > +                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> > > > +                     <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
> > > > +                     <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> 
> -- 
> With best wishes
> Dmitry
