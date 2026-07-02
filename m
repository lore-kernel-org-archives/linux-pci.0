Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B303A0B1C
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994496; cv=none; b=XeEgL78qjAYxPe6AwP9DWemgyuEbFdXF0Xd+PY4vunuGlJTa+sIBzMApUjVEMr3Da6ZEy2aWIGPQtK4ZY/593uC+G9CH3Jgvt6rnSwV+3kk7O47zlLqyZaiXz84/2ZtsYFTY6V9FU14DIU629cWBVWd7hjyHOfy7ZtF/POpT2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994496; c=relaxed/simple;
	bh=3mmx+/0sXAdWT+pakhHyX3kTBrQwKkeYxwkz9M2nEYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJdyRPtyAxwXApQz7KsZACvgXb+O1GxkDkKERhuiuPtI94mpdMwLCPJSpOQjcK/rA/hTdQswMeO/pTbEBKX9HUFbsuuUYd3BvkmGwI4IQ/SbSJd48uE3T7dwT+Qave2pIgF1HWQvb8u9snJtCkURAduv0HkfQRSXAxGXqeaawCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eklqlkdk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGc+VJ8C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eklqlkdk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGc+VJ8C"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662AeWGh3485718
	for <linux-pci@vger.kernel.org>; Thu, 2 Jul 2026 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zm20ylCeMzuZiz3s/y5e/wk5
	Pyn0IY6ZLPEKM9fU5YE=; b=EklqlkdkxONpR0ssH8uNTgSBlMOWyb7qIXEVdKze
	tOTnf/GGrpmP7faX6K6FJMtJhVhsazQRM07+nFw6XnY5Rp8voe1/WC5w67qG41AU
	Ye2T3Og026cHn0LN4YASci+ZjzTJzTIN0h/1Y9/CXuzP/KYTyHgOu4RnGwsh5ZLi
	ZpVY+YZBRfxVTcBRBGDbDg8TKFVdt7oWbjiFq5jBFS9U2MSHTbK9354u+6HThI81
	WJJDl1e7PkeWHdvMDYFJxsp3h5L9lsCiMHv7264ucXy3LAXmyWTHY1R1xkOPkcb2
	RdC89JYeALQJvpOBxrfQsdyTSywoKJHoTXo4yYc9E66RbA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h98hm8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 12:14:54 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-966c4d68d91so344931241.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994493; x=1783599293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm20ylCeMzuZiz3s/y5e/wk5Pyn0IY6ZLPEKM9fU5YE=;
        b=kGc+VJ8C/QhXZ9xObaTi8QGSmoncLciXvujqqSoqLXJ86DYu8HudvaV90wntNvGQ6B
         EoC6CEHdTcq0nznU+OkEmts9dDaF6AAFyWmwwSlaD+7QMDA5pcD3qR55T14LJdUkp/g1
         6dlt6EmEAPBk5aDkAXtZbZKEs0BGbnr/PrjHamh/Y/CqUzIjHoOAOfdWNKu1Fj4VJ+c5
         8UXMfZQ6EGFGLefCjtPfup8jQvve0n+uWGrrwIjlf/lt5gPIYXpwQQLvtjtT0+3iS8g0
         ri2FbRfsDCWq4hLsVxJ5lCqaYgsvNkHzXVojnPGfrtL8uIlNgicQ6xvmnhsddGTc/GFG
         7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994493; x=1783599293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm20ylCeMzuZiz3s/y5e/wk5Pyn0IY6ZLPEKM9fU5YE=;
        b=CR/PR+pQa71/u2ou1Mgtyyrmu60xeTqfZ9OOzeXKBkJIzdNVsugOt0J9rF/ywJmdgR
         XCIyi9ZHiDeGAT9091NmSd3EZ1sfGoV6gH3V5K/DGy8q+GGGHss/zYeiBxi5q4ivHtme
         BKWhJgrqx6fjqohX0jjloRbOJKpI5rhcYCEpEcgb9RAh02PufuTwssUtQZuSAA2ePZd4
         eh60NL8E1cqneBjPLxpWkc0HCKWz3PUVbAAxJ8U7Xk8RtBTmhVVUIV6EWLOFm0Z9zKHx
         BhPVziVNEkq6CdYsv/G0eA3xDHhf91jwpjHgCwRL4YeuQl+LT5JElUPlmZdXv+6lmc55
         +knQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCy7L5a9+W5CD/AJnwKrw9G5cRtziJkYfIMdh3xnvGtXsw02qiuP8XLAZAw2csff5boAqZKoRJTCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwisuYhjSeO9b/CfogE8PjpttbU1u+AGDc+BzeuMkY6hZ8J8aQs
	ADnoKSg3ztQj5Pjdg4BcrLK/6RsCtvN6rl1xkbMGaw3WmotMAtGAO6ZOA6Bg0VOqZXpwXTetVoH
	22wgL7thU9hvTv5RdESNhNdhvemCajHmmfxzn56FSYIwaLbRVPUo3UemN98e/cmA=
X-Gm-Gg: AfdE7ckjNmBQAWjfwLz2koh1Kn684TWfqy6DcNDF51GQs2Xylqj4a8r/41T/Yjyhoxu
	nxTGbcDW+cIoTehmipLHv0h2D9hrHF99Fmdk6EgzmPAeXjPjuMuKSw2GEVJQ+CCqi8FQKZVTz0H
	aY+LRs602qlAjX38ZHLTXg98XBPxw2GhPODGAhMe7cK9V4JKhHznXDgTsjNHGSm8HbXLc4mZt0S
	6/Gr+nn+pFLtfqZe7Qnioeu8AUSnS3HqbEczhgOOdOx0wAt34DyTgQqH+LQH/JmQul42An8Yi13
	BlT54yzRcWYMZse4NMVYrpf6uBQ5lM3YWLpaZrpVWuScKUIS0Ia8T1daciKF9ZpRyNNN33dbk8W
	Z6Peq+n6EovqCT/EnwYq43qfuqx9VN49s9rN4X1cfL8xOhFI6QaVdMCeAmGpkYRDDB975PBWXFk
	AxgqbQSyY6X30WG1IM3UlIFSSd
X-Received: by 2002:a05:6122:8b12:b0:59f:8ddb:2fc1 with SMTP id 71dfb90a1353d-5bddf5bae25mr1989778e0c.7.1782994493319;
        Thu, 02 Jul 2026 05:14:53 -0700 (PDT)
X-Received: by 2002:a05:6122:8b12:b0:59f:8ddb:2fc1 with SMTP id 71dfb90a1353d-5bddf5bae25mr1989761e0c.7.1782994492816;
        Thu, 02 Jul 2026 05:14:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89eb6ffsm650658e87.83.2026.07.02.05.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:14:51 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:14:49 +0300
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
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Message-ID: <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: AKe5QvGY0vBszLlbEtft_Q7AEsbyk6gG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX2htaaKdSsRch
 Dif2J5U5YEPG6Zdt3c0FJ+AbUuv7uwdhYLoGNGJSY8cn5pNULV7bZ5/sF4NdzG0n+9KK5wRyjCr
 NVqBVU4Rmd2bDYskDvwVfSllptI4dKwOvYc36iHEWNlDALA6Rjamh9QD95l7+Kj6LkNS77Vok2d
 PdrfACDlOnh/es7zBAk10KSVqeyQPoGngZ7zM57OXyntkj3lGMFLv8zP/CEG77vMDjI/kh8V/Nn
 RrBGLBdKjNbd8CUAmVlzPUwSpED/57oLrGYOb+YD9/0hWASZzjMiG3qbFXWvX4XD4pdiH0OP3UI
 5v+1txVCfomwB5n9MPYQf9xfg6JWVtm51wh6rsR1TIMPBmw4ZU3sdiKzfOt/zM3zbX1tgamXE1L
 /7pH3OeSLkUY8QwWUj2VBKVOUfgVzAdiYfiX8FbxTNjT+3Tt2tRi6W+xcNobpe8AvpiUl7U7rUQ
 H2pyWK4xI+mmURzlQ2g==
X-Proofpoint-GUID: AKe5QvGY0vBszLlbEtft_Q7AEsbyk6gG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX4HEskSLw0Nm2
 cVXr2dvtJIQrvhTTkqdU0M33gkps12GqQclxW36KVx322JqU5uvL8NUUKwBmzakwK08438nzxMu
 kSsDDIFUEsWPa1aOn+S2GbzxZ4fLRGk=
X-Authority-Analysis: v=2.4 cv=bdFbluPB c=1 sm=1 tr=0 ts=6a46563e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=GH4E13IOXdwHnVtn7D4A:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020128

On Thu, Jul 02, 2026 at 12:46:15PM +0200, Loic Poulain wrote:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> sequencer rather than a dedicated BT enable GPIO.
> 
> When the serdev controller has an OF graph (indicating it is connected
> to an M.2 connector), acquire the 'uart' pwrseq target from the
> connector's power sequencer and use it to control BT power instead of
> the bt-enable GPIO.
> 
> Also allocate bt_power unconditionally for all SOC types since the

Can we just fold it into the main struct?

> pwrseq path is independent of the SOC type switch.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e09debdb00a1b8e74ccd5de6147e240e533b4594..b04593a96e14ac9e87ae76fa00eda308e81dea25 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power->pwrseq)
> +			pwrseq_power_on(qcadev->bt_power->pwrseq);
>  	}
>  
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2256,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
>  		break;
>  	}
>  
> -	if (power && power->pwrseq) {
> +	if (power->pwrseq) {
>  		pwrseq_power_off(power->pwrseq);
>  		set_bit(QCA_BT_OFF, &qca->flags);
>  		return;
> @@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct qca_power *qca,
>  	return 0;
>  }
>  
> +/*
> + * Acquire the M.2 connector power sequencer.
> + *
> + * An OF graph link on the serdev controller is only present when the BT
> + * device is attached through an M.2 Key E connector. In that case the UART
> + * enable (W_DISABLE2#) is driven by the pcie-m2 power sequencer instead of a
> + * dedicated BT enable GPIO, so grab the "uart" pwrseq target from it.
> + *
> + * Returns 0 if no M.2 connector is present (nothing to do), a negative errno
> + * on error, otherwise 0 with qcadev->bt_power->pwrseq populated.
> + */
> +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev, bool *bt_en_available)
> +{
> +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> +	struct device *dev;
> +
> +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> +		return 0;
> +
> +	qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> +	if (IS_ERR(qcadev->bt_power->pwrseq))
> +		return PTR_ERR(qcadev->bt_power->pwrseq);
> +
> +	dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
> +	*bt_en_available = device_property_present(dev, "w-disable2-gpios");

I think here you are looking into the exact details of the other of the
graph. There might be other devices on that side, while the code now
assumes M.2. Or, consider having an M.2 controller which handles
W_DISABLE2# internally rather than through the GPIO.

> +
> +	return 0;
> +}
> +
>  static int qca_serdev_probe(struct serdev_device *serdev)
>  {
>  	struct qca_serdev *qcadev;

-- 
With best wishes
Dmitry
