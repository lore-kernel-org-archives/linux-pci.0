Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161828850E
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726436; cv=none; b=g6Zs4WO34aFGnQ13JwEFzYQdfoLijn2IKJ6IVeyGTkbwLR+fBJv+iWudJs0QVkhKm/cKMhF1f4C408QXeHBneTolewgifTCKPG8Gs6sRPYjyCvNtTSsdyeN0h8W1revsTQUhrdVkySKuNUjGuYGVDCxHWJKZ4QS3zO5iJ6X0dCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726436; c=relaxed/simple;
	bh=Ib2fFpGA8HXSvCdKaT+K1frPjV6b7O+Vuez/aXtxX5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiCNBRDsavuJdciV5m5K2db1C47r/TAEaOfrdHejtLZfF02+0TcPU4mOvUBrPCEQqIOQUm21//UeuLth3sPVWc9uzHD6k2tSa4VQDnl5votVphfdi7UIMZ0c8wHnPiNl+/KY3p7ONcPw0nvSzvlhbeDdvrdi/6Z0vVmFtFo70us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gOuVGQZX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KhTmRs2u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gOuVGQZX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KhTmRs2u"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MD1WTx1082307
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rIMkbAY2u/8YcCwRUcpBFhYi
	OZxj0l75/x2ZVLsA0S0=; b=gOuVGQZXUOAI9gR07CVmntFHO/D/BMf5OOKh6cAn
	M7zA/9GG/q+fri7cpTjqHWUWBQVoYf9K/N5qq87Ny218V+17xAU5J1AeNqZUm323
	cs9gOQyvJX24HLjr64uKE8aF9hgjter/DOgz9Rk5mPghfnluklueg1PZJGGBPO4m
	0DwkAjjquWgBFP/RQfRtOlnTSl3M32RCYVgqinhQABR5pA4P1/8fjEkQtjZjm3iJ
	hhAz7bqSe1U7tDaWkHwXmpNKiX+8c59wImhD0NVMhD7xj9lTXnlgHgU6Nr/n+P2/
	58aKxEHfnS7m+abiG2z9AoKZAQsmN9drgpAxo/XQzh/M5w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt1kjh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 13:20:33 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-971ff89d7eeso1781397241.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784726432; x=1785331232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIMkbAY2u/8YcCwRUcpBFhYiOZxj0l75/x2ZVLsA0S0=;
        b=KhTmRs2uuE/7POoUXY3WKzd8gsrkbD1GX4OTbo+feWsjAyF+NOL4CeZBFtkXTSRv7G
         h40EkZP8X4XlcoZpVmy7e6iTGd8e9G1as2dJtYdRGs/Td/To8deMAAchhOY0IodbNJtR
         r41w4gmI3WVeYKv56ohgG9iqTQC9IssyPloxCn4HMYJWzEYrVDAUhzsYTzNHWJpp0ksB
         zdWQ0Gvn5oWPWTn8rQYYsFPTv+gsqw+H2Eg32CBNE0SNienp6VSpVQxf7yTzBmhkVv2k
         d2tbh8xJptJA5MoR/nT24lC0OklRf53aOFtehGwlj1xbHAJHyf6m7oe/S8TE9Lf0ujYm
         6T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726432; x=1785331232;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIMkbAY2u/8YcCwRUcpBFhYiOZxj0l75/x2ZVLsA0S0=;
        b=huSvUGaQVOYTbHjLLXoJeUGbciLyCnie8OQ8YlynTu1yrJ9g9nwIFTEDR931aCp8ur
         gyta1U4YKRK2AhdPL9LXKuW8QlQFLRqQfwi/A7VVtJjWN+KKeCtXmo6i5O4Z+4jqzmu4
         O5s5JTSyuUs7m62SoMapW0jlsHme2BpS6WbvfeYgcJhlUvxZA3cDKlIha4Nfw3FPIHn2
         +TjIUB2GdJv1pK+CilNsEv6vULtr7R4HUCSAbumA3rCyiClfgpjyWH4+m4XUgIeAkA3v
         GRDAxAtHCEt8EEBpZ7MVnbqJlt9F37j6lNAzxkhcHQKW5E1iTGCU4Q1UpGLEMQmqG/qo
         G+ag==
X-Forwarded-Encrypted: i=1; AHgh+RoCvA8gzQdTZaJyV5p5iRho/3y1zr23XOMmQSRujeo+VwhgrpAlaQXgL8+RwSaN2o75asYH0IkflDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Xcr8vAzOPGYDJbVTQVF/zR6FznMtEgJKsM3JRLFv0QQFp1L8
	sIQp3o0NjEYhmguEhhhH9sEWlwqmeeFW8vKSKsv2myOzwVBycvFodUG6R7oXSj3zy8ap2w19Oqn
	g7GB+jePM6u9hpjIbjFMeCmBEzAZ4WQn8sOrhgVnTPy8wzxv8kBlbORTKGyl++MI=
X-Gm-Gg: AR+sD12xoXMKGjewjBN87DHzH958IXzOe9jvlXC0ByeJlpv3gXF0Akgkg/3kn3QzQRg
	WsiQJAjk4hJvyFqIeahvDNvfWglczaax2K2xmM8NnKHJSPrwLn7Rd8SXAP+FqsXqADik4/q6xMV
	wv2JyG6f8k/HRzKuYyzx0khvTlYYaMV0WrRFED2xqstpk9FRcSt5ju6usTAlXe0uffBSl5UIOKh
	bywKdYcpcxhs3vSebXY/v0iHkI2691Fu1UHyYufNskLlBaY9u7uwwPo35NtR69Xia4zF64ruZbd
	LWJHsIG5cFV9EZDy7JhYqJiQgrWkaPHcz9NWHxNRR+RIMN6zEubwdgVQrOMdBUK3BIBfbDq1F6n
	T5wl7pHCh/58JA+gRYDywQYHQ/GModRW9egoQaVBycxsUFrnOScsxMehyjKtJd2BZ6zW3IgH7uk
	3/F5A08wA4LTSpLg==
X-Received: by 2002:a05:6102:4490:b0:739:8c52:f2b with SMTP id ada2fe7eead31-747536d3ad7mr7088757137.18.1784726431973;
        Wed, 22 Jul 2026 06:20:31 -0700 (PDT)
X-Received: by 2002:a05:6102:4490:b0:739:8c52:f2b with SMTP id ada2fe7eead31-747536d3ad7mr7088735137.18.1784726431425;
        Wed, 22 Jul 2026 06:20:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ef68b68ebsm4860331fa.10.2026.07.22.06.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:20:30 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:20:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Message-ID: <qf2qoy4re4pk6tjoyqohfcj5odlsccfj33rfqanljnmr3v4yaz@v44t2vujmhoy>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-8-69ec6743543c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-monza-wireless-v5-8-69ec6743543c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: JCtAvEtS4mza9i0hiak6DWbG_Dk0mbqt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX/h5sdVD5zav/
 S05mFome16xSJfK2Rr/pOFIx3WWQ9iW1x893l1AoueQkVShJl6yGHtS6sCz55xokPJ4vpxGAs79
 uakPzGN+4hookP7dWybFmVg+z8clSJMjv4xy3aLHljnJD3SZD8JIZW4iT74jI/jbkLs0HuEnG3r
 0JvHLMKZC0icN9Seh87BFKALd1Vm71k3Kp4S8cuDGc7rR89S3ygiEA6W1oRtZz4DIFFmyArntHT
 fVRysKkEl6/LBiLFK3h2gU1UZqYrejo4qia2UOEDWoRKsydT2R+3vuIeR8PNaHEJujtnrM9/A+d
 3pjIVBFAmRpTrmYMGtn4hnfstrtNROYveXYxTLKRhJTFbeOJtFg3EBDpYqrVT4HUA9+2rzyWjWm
 2HDbJekU15Lx09uNDQnvxrjpZ+QE3Ggtlw8dHc8uqjKFDsk2qS50KDxpQFKjyGpX1qi3ud81jCD
 0kENEKoVjVoB4UxPg/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzMCBTYWx0ZWRfX+TGXq9fK63Fq
 a10ui39jZFgWWMpJaS2HCgwo3h8IVgG3OfR6YE39QZ+FJrmssCqFD/wl1Rfxj7+e82pjvdCVVrT
 ei/eBpV8RE0x+iz7dXaPoyKlRe4/j7c=
X-Proofpoint-GUID: JCtAvEtS4mza9i0hiak6DWbG_Dk0mbqt
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a60c3a1 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=huXO1bx5tun3eLEzRFsA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220130

On Mon, Jul 20, 2026 at 10:04:10AM +0200, Loic Poulain wrote:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
> rather than a dedicated BT enable GPIO.
> 
> When the serdev controller has an OF graph (indicating it is connected to
> an M.2 connector), acquire the 'uart' pwrseq target from the connector's
> power sequencer and use it to control BT power instead of the bt-enable
> GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 7e4cb03d3db0722e5f9fa2e7a5a9a0894bf4f18c..8496bd428602c48d093bc76f9810abb9b1c43cfa 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power.pwrseq)
> +			pwrseq_power_on(qcadev->bt_power.pwrseq);
>  	}
>  
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2387,6 +2390,34 @@ static int qca_init_regulators(struct qca_power *qca,
>  	return 0;
>  }
>  
> +static void qca_serdev_put_pwrseq(void *data)
> +{
> +	pwrseq_put(data);
> +}
> +
> +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> +{
> +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> +	struct pwrseq_desc *pwrseq;
> +
> +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> +		return 0;
> +
> +	/* The pwrseq is looked up on the serdev controller (which holds the
> +	 * OF graph to the M.2 connector), but its lifetime must follow this
> +	 * serdev consumer device, not the controller. So acquire it with the
> +	 * non-devres pwrseq_get() and release it via a devres action bound to
> +	 * &serdev->dev instead of using devm_pwrseq_get(&serdev->ctrl->dev).
> +	 */
> +	pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
> +	if (IS_ERR(pwrseq))
> +		return PTR_ERR(pwrseq);

We really need to add devm_pwrseq_get().


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
