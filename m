Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A24E330B0B
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781227086; cv=none; b=Xd6eXk8LJNF9seB0SEPTVXuEntnlp8K45iS+nYy6laDzmRcpNpZh6boJRV+DKdhwFH+Y0nXTSXGM6zKQqm+hYua0lb4D9myYSY3qCS2IQ/D5KA9x/mLJH1NjQfe/DFIdz02Z319P4RdD10VKpGJw4nV/JnK3G329n+KoXtQcpDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781227086; c=relaxed/simple;
	bh=Zuowp69okHqoeqjXee0h4XdV2JsffR3X6Im4oI1USEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nun9JGjotOveWBD3g2Fm1lJZPKX78qMt8ArCS00kdgnNBMQx3znH8UnD0ZRHVuDvLq1KjZjKv7Y9SOOaX68fApG63u9VA2hO6xeXm1bOVEHvJsF30XpLCPJr/0HyEWOq9D5zULKWD9tEYdOD4Lu0eZJY8+tqPVGUiRT0NrYh3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XBu3YVp9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZM6cEeLq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBu3YVp9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZM6cEeLq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BMUtCS1865328
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 01:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4EqFMpSpAm2KuA9gUkjE2CCc
	/4B8cxyegXiUK2f5fww=; b=XBu3YVp99cQ3B1+pNoy0HhauSovp/N5ocz9wrTuE
	st0uvVVGpJC/imYHuAyuCfMWq9Y2f+YFz3tEoEE707ud5wssH40gKLpi/7K0oaAj
	ynXYaAHZBL5QkrkN/Rgme/fRnO9EAQ0rReo6w/dRP8DfcJsNObvUaSmWcoUcdzJX
	1pXAFWvtT27wqlQMz/UMHgLzWSEZVR6kWzCLllsvQIYam2/N4ENo/3UvPrXE04Ot
	PgpUQymgMW4sUc9FfTMt27QSzn7wU0o3rDYWQFR7/aWOEktvTCHmm0iZ9Fx7H/xU
	oYK7xIcTvXDJPEzw4nJIaaIDnwsCt99q2yARUQp9pcmtpw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xchekm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 01:18:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304d8613efbso668166eec.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 18:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781227081; x=1781831881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EqFMpSpAm2KuA9gUkjE2CCc/4B8cxyegXiUK2f5fww=;
        b=ZM6cEeLqLkQIh+NJ+1ZYTOAwTceSCeGbC9RzQ6nctkrAE4SyQZL11DNU4EMF0oNA7Z
         ZgdrfCTrP/hB6DYsl4jjne5n0qjmmaQaNE2+/nxhuemfaVoJ7KIh8cuc6ZZF1P+aL8MY
         a8cMuBIQnMDc8pAyWsPzTu57dG/4CGNNg+Y09QgwwcNVbRDvLVjEwHD1Uo0svGFxzoaH
         COA8vsCPYtPGf2Nj5M96dO4kk4O+nXvH31UmnHiTzL9tiCrF3vnGgoJHUDWGg2Lud+n3
         y/uYDJ5rCVsilBixmTUO4v66+d4Xo8FKK2ohGuwQh3doD7dpy7l0DxSPaab5+ShxvW0o
         NN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781227081; x=1781831881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EqFMpSpAm2KuA9gUkjE2CCc/4B8cxyegXiUK2f5fww=;
        b=kubYobeeR3xn8FghWnq+kztOANS5eVnaJW7RRWatTwhw/MLJxhVh7jCmyyny+K2Vii
         7Bgp7U0FPd2wwv9SwmMd/tS1Nw88YxopZ3CpCIfZ7sWfRdjQrl7RTMv4/WxS6Wo0LFUn
         4ieUifzJ8QU2HmLUXLm99gr9ASdItZO93OfhaYvfSwgFx+QJjnCND9rFFpMFBP/RwcXp
         qSrZDz3C/PXv4rw4ubXNINJFT6PITBJ9nnfRpQh3lNRRidNDqL7ebbWu4UbduAV62saP
         FbwVRNy9U3ktfFjEqaZ2/TNX6Ibw3QC2SgbinoHFDPE15yTFaoOpfKnI60wpVlrFO3Nw
         aonQ==
X-Forwarded-Encrypted: i=1; AFNElJ836U84fm9P6MF0//DLaLI9B1mN3jzK4PF4D8ZlkmrD6ISqhwyLTmdjBSVaaKtg0eaR9CSgNiY/Etg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMPIo1PdTfeOXkVLhkMF3APQ0xEJgRkr9cMhSU5uCjXooLmmQ
	XTDVlOyeFeiapKBKa48jgy8yMaSEKfH2VEzu3SjySoXUnJoEtaJvEi7rKBxASPg4Dh8OHLXxWMe
	oFjjiXjAAFEaFsHDgdrb7JKAgO+EsmIPv73vhkDEnV5duEc2GXuBY0OCQGhQNbnk=
X-Gm-Gg: Acq92OFnFUphJMMjcT+NSO6uHESJtlRxQYdrvVlfsxl7XYid5RoKUZwKKqXirjnDGiZ
	hqe5lzdUP+yjb86Xz1+XPUZPssLxNZwCqxdYzDkW1YQiEZIWEDLPQqnnoWJdY7mZJqb4eF2QHwN
	w/Kq8t8taDrm2JcAGTa2jO69TG5GaBSvnFqyxvPe7lu3kFhloR+MUu90bnpf8vt372QN+p0hng3
	FgPUgfeuF5gYZnhUx2wJnDmeJReG6iGAN7D9TxPQdTf3uy1eB3wq4ZYyI4VqhJQaCQ4WvFkuZ2I
	ODxMQrKcRH8tFuN7h1KoFyJNFX75aZHmtE6JnxoG1OM9kXLpPlovkqqGX1AdZFYSwVQ/guqVRY8
	X+NPl5h1ltN4d2ZOh31M7ZqqoV6hCr/h/ZTUY6rKQ0w/hp0koUYx+1DNZ2IK8TT7LRCHCEkwA6v
	xWbA==
X-Received: by 2002:a05:7300:3c2c:b0:304:8361:a87e with SMTP id 5a478bee46e88-308200c5969mr426759eec.33.1781227080820;
        Thu, 11 Jun 2026 18:18:00 -0700 (PDT)
X-Received: by 2002:a05:7300:3c2c:b0:304:8361:a87e with SMTP id 5a478bee46e88-308200c5969mr426735eec.33.1781227080168;
        Thu, 11 Jun 2026 18:18:00 -0700 (PDT)
Received: from hu-mattleun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5fefecsm1203063eec.13.2026.06.11.18.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:17:59 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:17:57 -0700
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
Message-ID: <aiteRU8cWykuhlVO@hu-mattleun-lv.qualcomm.com>
References: <20260529-hawi-pcie-v2-0-de87c6cc230c@oss.qualcomm.com>
 <20260529-hawi-pcie-v2-1-de87c6cc230c@oss.qualcomm.com>
 <2tenqkmwcr2gshtjwh44pvban4gtlzcgrm3iibkfrs4zh6vphb@h5losfunylr6>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2tenqkmwcr2gshtjwh44pvban4gtlzcgrm3iibkfrs4zh6vphb@h5losfunylr6>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAwOSBTYWx0ZWRfX4ionHHy0/bjs
 DQg0l3x3XxpokSj6xKaCpOvHJa6xlM/UlAlAFGHUIldllEAqhB3WT0Ic4lVBdHD3hR/DF5852r0
 DOyrvz+TtTFaQ8kcyYxP7SsV0bzzpe5Vl/Wkeek+/Q2V0Iwykh8yGvzLwQlzuyyId9mqR34/aYw
 FElewAN37Vcx2TfHjVPLwn6HOGjRVhYBgj0gLbMMf5ku84uusc4h8XuMYT3my50539Jut2TkEdA
 raCEoHrZjO2HdaJ1it/aF3CikP2c/ditX86VD4lOt+FjLQWslOFexU3JeWOqx0au9ORMR88FraC
 MMETaYHlB2SePrLf7XrSoRC4Nf7KjUcFHyBttVeKDq5Q8GuLtlgUpyM+RqD3y4hLV6fXdp58sni
 pYoDEnMIPjLnhxCwZ/WPWPntvnZw61mMsKPq0LINPR3b6k8hZo12Uwwwlm+7RmaIRQW8eJrkpjR
 9/Ev59rO1SpfEbwF3Wg==
X-Proofpoint-GUID: qi5P6WjUakiJ8tJ148DjmnaoCYDwifNX
X-Proofpoint-ORIG-GUID: qi5P6WjUakiJ8tJ148DjmnaoCYDwifNX
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2b5e49 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=k8qvQEqTjxYPBieS1nsA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAwOSBTYWx0ZWRfXxg7IreRiNiqe
 V3j+HMwGIoMJnqFMNv9ELT017t0MbwXfmvoi2NU9a44DQshlCibH4M/b/7brz9ba/LrgcSVV3rq
 +YpPWgwqJ4JZjL8Sg1g5sFQMC9ROcos=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120009

On Sun, Jun 07, 2026 at 11:01:10PM +0300, Dmitry Baryshkov wrote:
> On Fri, May 29, 2026 at 01:10:08AM +0000, Matthew Leung wrote:
> > Add a dedicated schema for the PCIe controllers found on the Hawi
> > platform.
> > 
> > Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 204 +++++++++++++++++++++
> >  1 file changed, 204 insertions(+)
> > 
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,hawi-gcc.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interconnect/qcom,icc.h>
> > +    #include <dt-bindings/interconnect/qcom,hawi-rpmh.h>
> 
> Stop referencing clocks and interconnect header files. Replace used nocs
> with ephemeral values.
> 
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> 
> Not looking around should be a sin. Take a look at other Qualcomm PCIe
> bindings. Compare them to yours. Then fix yours to follow.
> 
> Hint: the extra soc node is useless. This is just an example, so use the
> default, 1 cells for address and size.

Thank you for the feedback. This new binding follows the examples set in
the qcom,pcie-sm8x50 bindings and retains the same formatting (extra soc
node and header references).

I understand the example can be simplified with your suggestions but
want additional confirmation that these will be the convention for new
bindings going forward.

> 
> > +
> > +        pcie@1c00000 {
> > +            compatible = "qcom,hawi-pcie";
> > +            reg = <0 0x01c00000 0 0x3000>,
> > +                  <0 0x40000000 0 0xf1d>,
> > +                  <0 0x40000f20 0 0xa8>,
> > +                  <0 0x40001000 0 0x1000>,
> > +                  <0 0x40100000 0 0x100000>;
> > +            reg-names = "parf", "dbi", "elbi", "atu", "config";
> > +            ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
> > +                     <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
> > +
> > +            bus-range = <0x00 0xff>;
> > +            device_type = "pci";
> > +            linux,pci-domain = <0>;
> > +            num-lanes = <2>;
> > +
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +
> > +            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
> 
> <&gcc_pcie_0_aux_clk>, etc.
> 
> > +                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> > +                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> > +                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> > +                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> > +                     <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
> > +                     <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
> 
> -- 
> With best wishes
> Dmitry
