Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94636F426
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254873; cv=none; b=MrTDImSf1RWzXRhKhyX4si1XLlsXnRcvRm+P3djc++L0MgeSrOooF9gi3CQHlq0S7HElKSkhN7MKJXPc1nXfiTcZwl8Hise6pq+jSzPJrBo180A3jOOW+YTxlAqHnWM4At8tb1N1O1fxYtqvu1JaIvVksewFAA00QddnaIUEPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254873; c=relaxed/simple;
	bh=K8DthgNvpP8H3W1v9rUrPVBz/IFhRniVZrCwsEvBQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQi8REorrACQlVhgrA/TqbDQrG5rvxTjEmn8ADxFm9MmbMYWLcxXVmY4RXgRFobLnP7ddQh2HrPHhR8CsycW9OHbCj1K+D0ua7jCrwbqz8t0gJqe5CjbGZj9Rtu4d7ueYm8Zj79GYNpdI3bGjrN4sp2yXprMlmS9/6bZUIGvxGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F525Msj2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WPqsOVFl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F525Msj2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WPqsOVFl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NK0VLN999837
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 22:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=asq7qdr/KrrmzhR4T24h1GJS
	Iepx/Nw0a3Z1XgC25/M=; b=F525Msj2pgDAEAbRB3jeiUrK4GOoji/yIEmbUf20
	r4n0faO/Uw10FEsoDdztMyGSxNgHdbOU4Icv/kieCbgfIz4x2uvEBBIa+Eql9RkE
	ytlzR0IfWeT5Cuav8JC1L+eOOYqIsjCxDhRTTDTCh9BnfFwS3tVp4ErH90HKROZk
	aUw+ntmeG5w2flb1YayqjEkYLj5hD5cb256gmOQ4aG8GDmJrH/OTHzePl8+Rx/eW
	XxSBxUN987xUotAcWvpAel6NpgcHKyp+7BLwmEyOONIVOyEN+Iny78J0XXhjnWzS
	9E+83/SPJGTq4G+T3qFPdy65xQrQWNkC+cyZvnSxzY5grg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9yty22-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 22:47:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30ba395b047so1031708eec.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782254869; x=1782859669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asq7qdr/KrrmzhR4T24h1GJSIepx/Nw0a3Z1XgC25/M=;
        b=WPqsOVFlxdzS4keSGvO3oF9EwZpMoV8tYe7Gp/6x7vZ0rt6/u7hnn39MSownLtSlv1
         rTnIXQUMtI2SyVl6AhzNSt7NOonRS2CF+8/BVu70encn6sB42IDn4EAiMadCvotnrSNy
         ++RRWusJmBeNapA7H3FAY2q+vdGvOQ7k4zaypWGDLRJ5Onj/e+XwmWoau3c/kuYuCm67
         y013MudWrCdPbBTx0nmsgo12AsW4O0ZOr4+RK7mKYt/Ww7yDG0I6iXYKeUVMuALSCVXl
         UhVw/BzJebX9hkNvG+svSfe4u0Re6mguROY1tTDa8ogsOxkKoT1jx3XPX+v73NaMTkZ3
         /g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254869; x=1782859669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asq7qdr/KrrmzhR4T24h1GJSIepx/Nw0a3Z1XgC25/M=;
        b=U+kUhOENllQowQA2+WfQ0NGkqYiU/5X7JT1zgVqETiTiBHbbTAV0g2NqR4MehzZuXx
         xlY9RBC8pWSfqq+LgqBxjsUH3g82X2m3pZblFZLIbMWR3GKHv0+kZF3qzOPiMtKU2wir
         I/BqkjbolWVHHYnzj6WLJn3tTzmSmhmO+diMcVjD2K8hnVP0pud/k3h1z3g3eWnnd5Bo
         cQ4DpFSxaDjYpkRHO0Q8pNaRC8Gc6Shxd099Esv7b1Zk1TcNAJRw2Iu7lajvput+HDr+
         v21pa+x2WeySFEauhXKfx/h1rTTU5/6ycmj1nfa68+gUf1Ng3SOeApDpwDpJ71TuZSOk
         I32A==
X-Forwarded-Encrypted: i=1; AHgh+Rpff19eYoDLFZV35WOcWxFBWU5m084QTf+aKSCJP9uLy197N37SmcLrd/X+h0+r/RXzBbJLTrUf5c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQ6WWt2CAc0rWxCVHtzksb4ySPd+gSnZxzgGXk4Ymo9mbEOg2
	CSXcogQjwHpYRAEybQSK4gD+23H6PWNGHRG4qvTEaGfJTyn3aV4gkRTouKrUbtHNI9trRlcILJb
	2QGKXRe5FOB3svOgvynjpIRJp8ODZaEPT34UjEJol50gcEMiWIn0yQHeWhM9KGw0=
X-Gm-Gg: AfdE7cmp8X1pfvfxKhGwzyUba3RykkuSzLx0pejzLIXmWUVGQp6rPZ+Qal4yZvUkMgK
	iOxl4EekX3pEPkHjvFQ/+V0CPdm76PToAE0qwgXD/B0LeTOeLQGDYCEHCm7eGvnjYabH22QXHMH
	z2uizTG0dHEGqqN8ZODg2VoDtRgL7vsr3RAu2UL3VIifzDQUCJS0O6ayKgeVXuNL/nOPoQxD/zV
	xwewmRP/5kvfYwLr5zwygWK5DlqLECzXP3R2iTJYQhznYSm6tyBRhmqRAfCK0eVT2H/eg21HDhR
	ETOryUc6nVnOORRxwF6QsT2cxORprI0vIztLorERl3446SrfaboJUvpZ3jslYpCfuAoBlePxWav
	M5i/Y33etNkIak4i89elATMNr1MZPwNH3ZGFH0Y96N11mTWPNXlDYDmgY5wdSyUWWuX8=
X-Received: by 2002:a05:7300:5bac:b0:30c:25c4:70fb with SMTP id 5a478bee46e88-30c68e33484mr1215360eec.34.1782254868602;
        Tue, 23 Jun 2026 15:47:48 -0700 (PDT)
X-Received: by 2002:a05:7300:5bac:b0:30c:25c4:70fb with SMTP id 5a478bee46e88-30c68e33484mr1215333eec.34.1782254867956;
        Tue, 23 Jun 2026 15:47:47 -0700 (PDT)
Received: from hu-mattleun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4b24esm18691660eec.27.2026.06.23.15.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 15:47:47 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:47:45 -0700
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Message-ID: <ajsNEftGh/dC5JhK@hu-mattleun-lv.qualcomm.com>
References: <20260618-hawi-pcie-v3-0-f31880bfb3ec@oss.qualcomm.com>
 <20260618-hawi-pcie-v3-1-f31880bfb3ec@oss.qualcomm.com>
 <20260622-brainy-observant-crocodile-d57bef@quoll>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-brainy-observant-crocodile-d57bef@quoll>
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3b0d15 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=BYOc-fOMsGyrnX6sEagA:9
 a=CjuIK1q_8ugA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: M6swgzsv94poGuw9ptaVmmsmjkjQsA22
X-Proofpoint-ORIG-GUID: M6swgzsv94poGuw9ptaVmmsmjkjQsA22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE4NyBTYWx0ZWRfXyJQiXA1aBj15
 NpK8iGH0qsXoBMKO4DxeQG+nVBatO4lRUbp/oMU10CB7qcDXKCJHZUcw9d1P1cdB1gY798rjsBS
 hiTWyEIVcZV/zn4PeBykMyg9YTguH9hjoCkd/kOhd5ltQXs8JQjry/AieY/YT+TRoN2mMtoehZ0
 LsvNJ8O5BbW7REu/OkvBlwhwrwMBJ4izUA7tdbZN7TELu4y9mRvL74LUq1RNQdxpLAd+JMK4Gsv
 f7wXzdZ8BU4L3YSvQHFeTaumw/8g9DCdfKw4LpFfyvYrOp5GmNgHiS2ucv8UY7CJ1gELgxClGPj
 dVVhznkn+gCW8pQKoPctZ70qblqGo1HY80MVEPSiYMxUbn4cb0YUFcKflEqtywr3e95z6kwjmb8
 7h6sKURF5Wu9vTCRZLfopQwi9K+XnZdB2XmcLdJQPQIeqNoyBhX5Pu6sly8Xhjm0zFUkLq61buK
 7AFmp+QdzDHV31rxjRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE4NyBTYWx0ZWRfX5wdCxF/qiVgO
 vfPyKJtN4Qe1IOvOoM7Bq3k9AuTvkHKgMfz2XG4OZUDVeuF2+ap4IqMKC+qpTMZ4i/S5AVM+qg8
 dIuYplmBqIQN33PSi+wGGCjB4c4zIT0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230187

On Mon, Jun 22, 2026 at 12:12:04PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jun 18, 2026 at 10:00:32PM +0000, Matthew Leung wrote:
> > Add a dedicated schema for the PCIe controllers found on the Hawi
> > platform.
> > 
> > Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 202 +++++++++++++++++++++
> >  1 file changed, 202 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
> > new file mode 100644
> > index 000000000000..fb3145f89f7f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
> > @@ -0,0 +1,202 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/qcom,hawi-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Hawi PCI Express Root Complex
> > +
> > +maintainers:
> > +  - Bjorn Andersson <andersson@kernel.org>
> > +  - Manivannan Sadhasivam <mani@kernel.org>
> > +
> > +description:
> > +  Qualcomm Hawi SoC (and compatible) PCIe root complex controller is based on
> > +  the Synopsys DesignWare PCIe IP.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,hawi-pcie
> > +
> > +  reg:
> > +    minItems: 5
> > +    items:
> > +      - description: Qualcomm specific registers
> > +      - description: DesignWare PCIe registers
> > +      - description: External local bus interface registers
> > +      - description: ATU address space
> > +      - description: PCIe configuration space
> > +      - description: MHI registers
> 
> Why is MHI optional?

The optional properties were carried over from the previous binding
which this binding was derived from, but I see those need not be the
case here. Each of the properties are used in both instances.

I will update with making the optional properties required.

> 
> > +
> > +  reg-names:
> > +    minItems: 5
> > +    items:
> > +      - const: parf
> > +      - const: dbi
> > +      - const: elbi
> > +      - const: atu
> > +      - const: config
> > +      - const: mhi
> > +
> > +  clocks:
> > +    minItems: 6
> > +    items:
> > +      - description: PCIe Auxiliary clock
> > +      - description: PCIe Configuration clock
> > +      - description: PCIe Master AXI clock
> > +      - description: PCIe Slave AXI clock
> > +      - description: PCIe Slave Q2A AXI clock
> > +      - description: PCIe Aggre NoC AXI clock
> > +      - description: PCIe Config NoC AXI clock
> 
> Same here - does that mean that once instance does not have this clock?
> If so, mention this in commit msg.

Same; will make required.

> 
> > +
> > +  clock-names:
> > +    minItems: 6
> > +    items:
> > +      - const: aux
> > +      - const: cfg
> > +      - const: bus_master
> > +      - const: bus_slave
> > +      - const: slave_q2a
> > +      - const: noc_aggr
> > +      - const: cnoc_sf_axi
> > +
> > +  interrupts:
> > +    minItems: 8
> > +    maxItems: 9
> > +
> > +  interrupt-names:
> > +    minItems: 8
> > +    items:
> > +      - const: msi0
> > +      - const: msi1
> > +      - const: msi2
> > +      - const: msi3
> > +      - const: msi4
> > +      - const: msi5
> > +      - const: msi6
> > +      - const: msi7
> > +      - const: global
> 
> Here as well - why is global optional?

Same; will make required.

> 
> > +
> > +  resets:
> > +    minItems: 1
> 
> Same here?

Same; will make required.

> 
> > +    items:
> > +      - description: PCIe core reset
> > +      - description: PCIe link down reset
> > +
> > +  reset-names:
> > +    minItems: 1
> > +    items:
> > +      - const: pci
> > +      - const: link_down
> > +
> > +required:
> > +  - power-domains
> > +  - resets
> > +  - reset-names
> > +
> > +allOf:
> > +  - $ref: qcom,pcie-common.yaml#
> 
> Best regards,
> Krzysztof
> 
