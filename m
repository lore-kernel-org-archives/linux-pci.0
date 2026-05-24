Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1186230C606
	for <linux-pci@vger.kernel.org>; Sun, 24 May 2026 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779618972; cv=none; b=Eubt7i5ALMxC5b3Sigvu3HCNi3599qKfNXR/0m8HUZg2kMbHWO+x0lKbvqnOHg0sKIsSvYJLz3w2pfDspgQzOZXUHxwCVdkXPS//UMwDUb9xPzpfFARXxcC19efvIhovUbRrEYObN9l3g20bDWMwTZJmTNW9akSg3lHLbYb4mpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779618972; c=relaxed/simple;
	bh=+W1k58JBpvJmrhRivouQ82SbjAmlk6Yeva3tSpfthIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhl1bENLix46rIvahgbmIdICaLMMyeJfb6Tnwx4/nRjBJ7MrXy/24GzWSGjpqZpLImTx/IrtyFrMMhDI9V3m7rp9bASeQ/1s/MBT51xv+82N6EPQc2kTtq6/wKAdQ2FGKnuhs9oXpiSvzy4vNAONqK9u5mWb+3yciR1eX2gUViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YBaMnBO9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h7azXtik; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YBaMnBO9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h7azXtik"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O4tXCu379598
	for <linux-pci@vger.kernel.org>; Sun, 24 May 2026 10:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TL5YCAu4sH+fnNry4R/TvUCKep+v9hMJ+/m2KMh4fPo=; b=YBaMnBO9h7HfJ0jE
	UOUeV9LyRqaI0JG9SS+L0kXygDLIgjqh8mIDY2AskCV2oRrmVAx5v+FOPZk9Ufea
	c7ftwn66uALjMl6Tt3f/rdSeYOI9g+FsLjzC/p9AND4vOB9hWzth+YmzSi9XFXJg
	+hw1WL5R0Vn7Gv5vUf6PkqZOePRu0YMFR2cNSWZPTtj1iOykfGQYWEhCAgYqu4PC
	I5xUI928ebIvxm3o/s3dQwWOMwBRcwDX57Alf2WoVXSO58Y5DtJesEwp3SMus5iA
	09R5bAEx9m+LiTEgBk/OocwrL2/wieVYi43jQ6VKor5azjuDBeph0czLBvfEx2MT
	+BaQvw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmkcat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 24 May 2026 10:36:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516d4b3f3a1so52527711cf.1
        for <linux-pci@vger.kernel.org>; Sun, 24 May 2026 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779618968; x=1780223768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TL5YCAu4sH+fnNry4R/TvUCKep+v9hMJ+/m2KMh4fPo=;
        b=h7azXtiknPOO6BlLoB4hWU18D/9LJJsHT9UyuxNlH/ZVAbYOaKjNxtOF6SdX0oEa8W
         6OZxdpLAkHGjjNkrz4PZU8mbDIbPm95PqhgSFwNg3HB56gqvNHOaHJOClkBMNGfcDBdp
         dhRkkW2hm3dxGR5iHeUOiikRNgt2wjrp/z8DRG2lSoqhtBs1UuOqZAsZRslA/ajEGNu4
         hey/LfY7B4kBDv5W8+f8rI+A18p5JuRGUX0uky1MHyorveHLJ4RPX5Zg2WaLlLJjVo0x
         7avLPHazvz+jG3sI7By0jHE8yQmqXf/sxtlcr83yP0CuRvn6u29Tl3UkOaMpN9d6HUeb
         G0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779618968; x=1780223768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TL5YCAu4sH+fnNry4R/TvUCKep+v9hMJ+/m2KMh4fPo=;
        b=TftZdq8G0FzliY3YBZxdT/31/3l9hFC76n+a6UQ+UK3vAHB1Kh/aP4K+XcxNyELNFw
         wJAiWYn3ny6iTlb1ddRibOj5DFpQ+CBtq2ft7QSm/vSuRVNJ5alW8WMJAL6UvbrpUllH
         gt3/WiyKW0R1dmb2oR0ScbMzjR4Vn8EAmvBRTfckEfkX+b05xxt69FYK3khpwg2XZOAa
         InOThKRgKfRkq7+a6bYwbywXBii/mK+u5n7S+g7wCr+8sejMQj99S8e7v3HunNKPctCC
         cgoFXs0UzoJL9jxGp7wc4sNGLe3bXmYL/HbDudlA6X3cJOVXfr6TbI6PqWBKzDEGyB1w
         /24A==
X-Forwarded-Encrypted: i=1; AFNElJ8oNjNMWVDquDPd95Swl8uq6NZuv9snDR+DVOvt/IshtLFgXFXqynrPW1Bx+VR6AM5UUZ6iWIVif/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJbauDHIFxye+eEHEn6HWp3sIdEV5R1l1m6S4hPmD7iSCIRAYC
	1gf666t+6Lw5OI+ReU++cNBeuzbQgIMW/2Xc337ehCmJ/RkjK2jkjzZdvrDl0/yXeLnGmrmrvvf
	fFbgbAhbyRqMRdaOA1oyVbt1re/tAiQQ/vaOlSKXFyBsxpUQH+0cO6Mj6P0ZvzCY=
X-Gm-Gg: Acq92OGd1RXNJ9Afp4rZstXQZyxskEw70ofZ2vaPpL0jrGjgUBVdCqUDCruyII6LbTy
	k/a6/46rH+0Py77seRfbUOB+YIZtWRDjwnFzVJrLFUN6bf5CPovEETkoqM+GpqymNUxgh/IvvXk
	y12UklEFvprFicr7HlUJ8yvM+r4kwgvh4iasxmRC/dXyhr/EiGZ0W5mFsVZzivM5mit8fSfn5Xe
	Euum7VApzT4NAriuVaj197E/IvSRbbBqKubVaI5rqAgiEYhWMYFMKPKYf6Cs2uYbHSShXt8NtMw
	Q0rcHZUAiRXaFmaXyLgiBGyaEhWeo2XkFLeRim1VAKMWX5sTGTC6Nyh5JFagPfmAoS8b8Ev24ze
	mG3oB6n6/VHuMoxXxpwdGc1LqjCwIaQM+2dgwj7zT8IUx2uvB0X0T7b09ia8EBcQutw+XEnNa5n
	T0sohoMn5Rhj90ihYZAfqGLQ0kwBxbogaxvqY=
X-Received: by 2002:a05:622a:d01:b0:50f:be4f:465d with SMTP id d75a77b69052e-516d44096aemr112265701cf.46.1779618968330;
        Sun, 24 May 2026 03:36:08 -0700 (PDT)
X-Received: by 2002:a05:622a:d01:b0:50f:be4f:465d with SMTP id d75a77b69052e-516d44096aemr112265571cf.46.1779618967906;
        Sun, 24 May 2026 03:36:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dca02dd6sm16266821fa.1.2026.05.24.03.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 03:36:06 -0700 (PDT)
Date: Sun, 24 May 2026 13:36:04 +0300
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
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
Message-ID: <hpcitldndtwoejbfsxy4e3f6flurmklepyzdpvbm56233dmwn7@eyvf6pycny5c>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com>
 <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
 <CAFEp6-3_NuWwF=gthfJyqeHMivGnfF0xpsTXT-xGW7pgFs+j3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEp6-3_NuWwF=gthfJyqeHMivGnfF0xpsTXT-xGW7pgFs+j3Q@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDEwNyBTYWx0ZWRfX6E5yCsEgefjX
 nHPjA7mVE8HHmDmfSVgrAYa8GtK4NYBZbZnQWNUCIyIa7qgCegIykEcgowf1/mbk4QZtCIO8+KQ
 GZRlT0s+WMlqT742wylFrhgFerJM2OW24A0q4yu9RxmjzIKVMveXCP2DIJlLVOGzCVldrRqKi9y
 MrTYf6q4hvLOT3EaN7scI1lXBD/iihw8M9JYRFxG4Feb2wq8dki9GU6soNoRQsrlHpQWrq2A770
 cfMGFiet3G+U6gban2sOshwbulR+AiYiIfkgB8IJ2+9XQf8eFHgjpIrw7sxfP7Akyg0mCRlfTYY
 qcHYos89swwJU6qiPyQ9AWEdHj2u2PqYj7vVwmvEchXquSRlvHMSjdoRxmYgFjhn8CP5pdGDHvz
 QwV6izP7Af/TloQywXtBoiPFr+y1l+KA/tWJwWMWZ5642zuRgNK8ko3T7nWvHtTElnqBhWl5upa
 yEi/PkejITCGdYhFv5Q==
X-Proofpoint-ORIG-GUID: Xgy5cbEhDB0vmKeXTQv-pAqe5xokMWYC
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a12d499 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=xdS1LbVOcY12UDyNXlwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Xgy5cbEhDB0vmKeXTQv-pAqe5xokMWYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240107

On Fri, May 22, 2026 at 06:11:08PM +0200, Loic Poulain wrote:
> On Wed, May 20, 2026 at 2:33 PM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >
> > On Wed, May 20, 2026 at 01:01:43PM +0200, Loic Poulain wrote:
> > > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> > > is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> > > sequencer rather than a dedicated BT enable GPIO.
> > >
> > > When the serdev controller has an OF graph (indicating it is connected
> > > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > > connector's power sequencer and use it to control BT power instead of
> > > the bt-enable GPIO.
> > >
> > > Also allocate bt_power unconditionally for all SOC types since the
> > > pwrseq path is independent of the SOC type switch.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> > >  drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
> > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5d670fa2758d3268d0 100644
> > > --- a/drivers/bluetooth/hci_qca.c
> > > +++ b/drivers/bluetooth/hci_qca.c
> > > @@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
> > >                       /* Controller needs time to bootup. */
> > >                       msleep(150);
> > >               }
> > > +
> > > +             if (qcadev->bt_power && qcadev->bt_power->pwrseq)
> > > +                     pwrseq_power_on(qcadev->bt_power->pwrseq);
> > >       }
> > >
> > >       clear_bit(QCA_BT_OFF, &qca->flags);
> > > @@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> > >       else
> > >               qcadev->btsoc_type = QCA_ROME;
> > >
> > > -     switch (qcadev->btsoc_type) {
> > > -     case QCA_QCA6390:
> > > -     case QCA_WCN3950:
> > > -     case QCA_WCN3988:
> > > -     case QCA_WCN3990:
> > > -     case QCA_WCN3991:
> > > -     case QCA_WCN3998:
> > > -     case QCA_WCN6750:
> > > -     case QCA_WCN6855:
> > > -     case QCA_WCN7850:
> > > -             qcadev->bt_power = devm_kzalloc(&serdev->dev,
> > > -                                             sizeof(struct qca_power),
> > > -                                             GFP_KERNEL);
> > > -             if (!qcadev->bt_power)
> > > -                     return -ENOMEM;
> > > -             break;
> > > -     default:
> > > -             break;
> > > -     }
> > > +     qcadev->bt_power = devm_kzalloc(&serdev->dev, sizeof(struct qca_power), GFP_KERNEL);
> > > +     if (!qcadev->bt_power)
> > > +             return -ENOMEM;
> >
> > This builds bt_power for all devices even though it wasn't the case
> > beforehand. As such, you can drop all further `if (qcadev->bt_power)`
> > checks in the driver. But, you also need to check that this won't break
> > support for other (older) chips.
> 
> Ok, I will do, and double check.
> 
> >
> > >
> > >       switch (qcadev->btsoc_type) {
> > >       case QCA_WCN3950:
> > > @@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
> > >                       return PTR_ERR(qcadev->bt_en);
> > >               }
> > >
> > > -             if (!qcadev->bt_en)
> > > +             if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> >
> > And this breaks support for pwrseq for non-M.2 BT devices. There is no
> > OF graph in such a case.
> 
> Not sure why, here we handle OF graph as an optional pwrseq provider,
> but still support legacy enablement.

What about the case when pwrseq is supposed to be used (via the PMU)?
There is no OF graph in such a case. Please check that your changes
don't break e.g. RB1.

> > > +                     qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> > > +                     if (IS_ERR(qcadev->bt_power->pwrseq))
> > > +                             return PTR_ERR(qcadev->bt_power->pwrseq);
> > > +             }
> > > +
> > > +             if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
> > >                       bt_en_available = false;
> > >
> > >               qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
> > >

-- 
With best wishes
Dmitry
