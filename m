Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F32CCC5
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154604; cv=none; b=VwFrGnIesAb+TpRiHJanu//KkHf35SZwHkgXm0oJ5cwtBowVF/OPgI/JBbSdYptAP8KCjXXgeRm368Jy9ZjkcqYXPyrguvM7GS29krWLldu1L1lLXNeExbfFEOs+zBFr5rKyRD21/7bHPftZ0y2GpCoQsnWzfINE0WkMAxsywlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154604; c=relaxed/simple;
	bh=yLCTlYjQ+FZe7T4QOyiIwafK9RT2sSnHqhjwIWNBv5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1iY3x3tJlYrLzor4HAvoIByHXbIP5Rr+41hrbRdJaP2F6X7dZs0Z8+M9YhVhwSKeKfJNAO4p4emt2oNKCvIGf9ZlwKDkRGMekwoksirn8L1It97b33tOjJI+0GTTLPmAl2H8pWimiN00Nsw5rZnGG1uOKEXDBVCdfRg99f6w6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aJLvRqm9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MXtLvRtl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aJLvRqm9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MXtLvRtl"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52QT53678801
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 05:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZAfc//S+fi2smReCQHn4wz9b18pPkHF5tuz6SNFWJqg=; b=aJLvRqm9PC3mG7fe
	ck4ElEh520bYaqJBHrhG3OvjOA5Za/oSLOpRhjytpgyicvJx1D9CY223qrNYoj6s
	IYLr4nGapQH3IfaQcH/66rjb43WtcoxbORB9Qj2BRxGhBwrX6fiVDAo2TxcA7q2P
	aqpzQLfRqgElUMTMc55BI3YIE55rjz2eIvU38I7Ki2nlbZgP6rYxk/UkJHmThcOq
	QwxRhEUoB9Bw+OLMzqIG7iMTLoQUyxCpG4tATybAhvecvVajf0lIfF4za48LzNAV
	fxN+REr0iyaYo1VnoyQHAtDqMP//WEX9a44H5CGlHsWhitEasGgmEHhgJPro3ERm
	xcpk+Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h1044-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 05:36:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc21bc2923fso898996a12.2
        for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 22:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788154601; x=1788759401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAfc//S+fi2smReCQHn4wz9b18pPkHF5tuz6SNFWJqg=;
        b=MXtLvRtlI5QOpCAt2LJk7OiM0Z2f5RhwZn1uCeRYXJkrPRQidYt0VoalLRGjpxBjpk
         YBcVyV9o+X3NX93ExKk75mgekVOBvgrabvVDfQ455K3YF4ECiAb4gaPZPg8uMskL+Dfk
         nDZ5NkY62QO2RQjujX1nCATusAqzhUI+RTOoKPa+9nzeQ3ZXgujiuVfDtQQyKrzal+eJ
         J4yozM7ZGMh8KFEVGY4n1o/DMVX7gdn/HlisxPVdCFhrXJeuzdijRhSRDvubmTgWDI3K
         kiisW4UX4Kjf/0ldisja40L2LjrC4iebRwmtGf64cco3wLOIEbj2ZjV0hTNKozIQ49QZ
         UhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154602; x=1788759402;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAfc//S+fi2smReCQHn4wz9b18pPkHF5tuz6SNFWJqg=;
        b=jJ64FXopUIqVwx1eW2rrdfRhismrYUjckMrGnhnfEVgjxnkjnOnkC2Y21FthXMjk1o
         9a5wMcIB0Vn9n4n1aGYAOJEzXCuyNFLS+4ZO8IoE4WK48Tkv5QPJ/4k9+7gZQx46v4FF
         Xg2AmXM/vJWV9oCZps1BMVWcRTHHRYO9jsKxEiSAivL/P8cJ7ZXbajzlapI6OqQKMOe4
         F20QYGINfFLnl4tG9ijKRPQDO90D4xnpm5ZhL0tiXJOhTfEku4lW96bQY0q0NbvLaUID
         c0sop8reLnrLZebO0PTGNfAGCdFQhUuFE7K2IeJf2vOWPk/fpLOWz3xXmUovpOTRBmA0
         Xb5g==
X-Forwarded-Encrypted: i=1; AHgh+RoqTOebBILH8J5PG8RHDTOyRKaBxFuDYqOeNZrOlVIjPDUewD+CF3xYH30hcVCHb+1syRzblkKCslI=@vger.kernel.org
X-Gm-Message-State: AFuF++lwkUF7Ye7g8AQQzK+C6pX/xNWaIyIu89CMdCbh1l7fiRYPjbq1
	t7T2u9mZkZNx8vFB2+aYXqJTVZtlO0wZcc4XTs36avM59oc4HyztcZ26RReeKe+EHh9Un66j/1R
	7rwmjd+FQW+71RdWBFYaaMLG+1HMqudxKgxaUlgcDABSE1j1KbFJb/991/WPcshc=
X-Gm-Gg: AR+sD11U3MLoJ0qN7ljWgCdoCzXRWjFTAjeWZejfzb2L9uCKs+Z8UTEtvj9VGQa2xyV
	/iVe+AsfRiQ6HcvydsH5u87SYf6bUJ1g6r7xuZg7jlWXQPbqHelmXztDxEvXdevN4R83v4FR0g6
	0HF6/9quRT2JOuaVW58SPLgHd33Mv6lcOnDHRLGUE6Zpydewub11oUolqx7sktfrXzXCQtDlKDU
	EhtaJqUWIEsr4KCak+yD6uoLHb2M6h7XMTUh0zuHNdATgp5CSGMMDDtoZ9LAltOBJUdFEuE/My8
	E7SgOawZ807xlMOd+aJBtotkrGqMcD0xsFlDGlExcTS0cOF5GNNBEAYBGWsKQCvi1eBdDDLF6fI
	KB1uUij97VBXf+xnH8AXXHY2DDZjSseT7lg==
X-Received: by 2002:a05:6a20:d0a1:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3d26562ead0mr38893839637.4.1788154601551;
        Sun, 30 Aug 2026 22:36:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:d0a1:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3d26562ead0mr38893780637.4.1788154601101;
        Sun, 30 Aug 2026 22:36:41 -0700 (PDT)
Received: from [10.92.202.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f552473sm29621422eec.0.2026.08.30.22.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 22:36:40 -0700 (PDT)
Message-ID: <d49788b9-a540-49e4-be1a-ac4a64ec1692@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:06:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Only check bridge nodes for PERST# GPIOs
To: Christopher Obbard <chris.obbard@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a9512ea cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FrH2bHQ3JhTd-qtjZ9cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX+9tOoLdz8FPM
 QWdJhJZUT4x+N4RHF14SLf3skiJ/aWEaEy/UI2QXzhvfqvVh/ULIZN3vL+ow5t6tibc0Xj4RsDi
 IV6clQjQYEnyOSn6v4ketEMF0J/vrZoAuntPOjX7VV/MgF4U1A54uGMjdLnPRlSHxTpMbKWQbbw
 lM4xO3jf56m2rxZJikBRdHxusn29lqHn9gRhM779U1IPEbMkZO/2j9voHqsqmSY0TFtu7wNlsoG
 OoT2E5+kC3fAZ4tyPbkrP6xWp6tSdmAzxQJqi5ylaMZ60TtEftS7+ghHztzBIjK2gSZHZfojCNN
 cxo2X+p0AIHURpnmxP3kO/0eGF0btOhPheqKb2AAiG54rKu5HUdQAaZxU8ueyNn2ryq3YpUBOAi
 bcWdH0VFS8MEi9Mhz+sMevBfaBsIGzPrw3ZFBeCIpMS8gvs4Vv/pgOAx8wM5Q+iHZRp4ojdBRqT
 DU77JCYh3M2EHYfgvyA==
X-Proofpoint-ORIG-GUID: n0XLdoJuIh7Au0lt25qFjVHw9HPdTP43
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0NiBTYWx0ZWRfX9YKQRTevh97D
 ozu8mnnLLNenu/xqnaLKbh+Ot1EpaaiDBJd+32JrGJWcmYwezqIlULM9L939Oc0v9aN43/7XFkI
 zJ771EJp0lBsk1ssmNJMbT5avlaYpcg=
X-Proofpoint-GUID: n0XLdoJuIh7Au0lt25qFjVHw9HPdTP43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310046



On 8/29/2026 4:06 PM, Christopher Obbard wrote:
> qcom_pcie_parse_perst() walks the PCIe hierarchy described in the device
> tree below its root port and collects the PERST# GPIOs from each bridge
> node so all PERST# lines can be driven in unison during controller
> bring-up, reset and power sequencing.
>
> However, the recursive device tree walk currently visits every available
> child node without checking that it is a PCI bridge. This allows the walk
> to leave the PCI hierarchy and collect reset lines from children of PCI
> enfpoitn nodes, where those reset lines belong to other drivers.
>
> This is reproducible on the Qualcomm RB3Gen2, where a Renesas uPD720201
> USB host controller sits behind a PCIe switch downstream port. A Genesys
> GL3590 USB hub connected to that controller is described as a child of
> the PCI endpoint:
>
> 	pcie@2,0 {
> 		device_type = "pci";
>
> 		usb-controller@0,0 {
> 			compatible = "pci1912,0014";
>
> 			hub@1 {
> 				compatible = "usb5e3,610";
> 				reset-gpios = <&tlmm 162 GPIO_ACTIVE_HIGH>;
> 			};
> 		};
> 	};
>
> The USB controller is a PCI endpoint, and not a bridge, but the PERST#
> walk descends through it and incorrectly claims the hub's reset GPIO:
>
> 	$ gpioinfo
> 	line 162: unnamed output consumer=PERST#
>
> As a result, the onboard-usb-dev driver cannot acquire its reset GPIO
> during probe:
>
> 	onboard-usb-dev 1c08000.pcie:...:usb-controller@0,0:hub@1: \
> 	  error -EBUSY: failed to get reset GPIO
> 	onboard-usb-dev 1c08000.pcie:...:usb-controller@0,0:hub@1: \
> 	  probe with driver onboard-usb-dev failed with error -16
>
> The GPIO is also added to the root port's PERST# list and is asserted
> and deasserted as part of PCIe reset sequencing. On the RB3Gen2 this
> causes the USB hub to repeatedly re-enumerate:
>
> 	[  116.479598] hub 2-1:1.0: USB hub found
> 	[  116.488601] hub 2-1:1.0: USB hub found
> 	[  116.496971] hub 2-1:1.0: USB hub found
> 	...
>
> This disrupts the hub and devices connected to it.
>
> Restrict the recursive walk to children with device_type "pci", so
> PERST# GPIOs are collected only from PCI bridge nodes and the walk
> does not descend through endpoints.
>
> qocm_pcie_parse_ports() has made the same distinction since
> commit 45df22935bdc ("PCI: qcom: Restrict port parsing only to PCIe
> bridge child nodes"), but the PERST# walk added later did not carry over
> that check.
>
> This bug is distinct from commit 3edb3a038d42 ("PCI: qcom: Skip PERST#
> GPIOs provided by downstream PCIe devices"), which filters PERST# GPIOs
> based on their provider. Here the GPIO is provided by the SoC TLMM; the
> bug is that reset-gpios is consumed from a non-bridge node at all.
>
> Fixes: 2fd60a2edb83 ("PCI: qcom: Parse PERST# from all PCIe bridge nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com> -
Krishna Chaitanya.
> ---
> USB/Ethernet issue on RB3Gen2.
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b58a607b713f..89a476c37098 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1953,7 +1953,7 @@ static bool qcom_pcie_is_child_node(struct device *dev,
>  	return false;
>  }
>  
> -/* Parse PERST# from all nodes in depth first manner starting from @np */
> +/* Collect PERST# GPIOs from PCI bridge nodes depth-first, starting at @np */
>  static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
>  				 struct qcom_pcie_port *port,
>  				 struct device_node *np)
> @@ -2019,6 +2019,9 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
>  
>  parse_child_node:
>  	for_each_available_child_of_node_scoped(np, child) {
> +		if (!of_node_is_type(child, "pci"))
> +			continue;
> +
>  		ret = qcom_pcie_parse_perst(pcie, port, child);
>  		if (ret)
>  			return ret;
>
> ---
> base-commit: 570f7e331f5febb30f1384817463c7e42b65ca7d
> change-id: 20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-ef551ccc0a8d
>
> Best regards,
> --  
> Christopher Obbard <chris.obbard@oss.qualcomm.com>
>
>

