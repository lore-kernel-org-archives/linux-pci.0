Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6603DDB07
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291562; cv=pass; b=d0esW26CLRmfntzhQppzQWwB2Wevon4BGTi0Sq6xXWzSDWvXiwVjbN1Izk7dfMvHoEVQBAs8vvgUo724yHQmMFqiOoNY7Vt0x/U+741R4fLB0c8qO3oNKmlq7r3sBqQzkywP7a6rQWbKRkn1PQ9txL7p1jkEhGU7ATqVZiFeoNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291562; c=relaxed/simple;
	bh=MPABVIseIAARqC0xTK2wPjOUE3zSSruLj96y+D7TprQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e07uxKARYrN4MJ0DDbvaOIbO0/m+df2GNqzfRXmMCCGy9BZCUUO08dXHbRIAf5PPjcpmQCQouio6+niMqXXETJofMgBLkYc+MrSx9j3vZajVOyyQ/+FiOuDNCl5Ab7nb0DfINeTsHiRTTXmU1dpIvvlTDv/KdtktSswGkCdT9Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQXyu1uE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h8b83URd; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQXyu1uE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h8b83URd"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCTRcA1885261
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1NaTFv12UGcSuXmAqV/BU6fGEBThcyQSKm65R3Df0vI=; b=fQXyu1uERHc0IDdS
	ahKg7bHNYPNjfLGUFhhkpH4pHfO08LCR62P/qdYTghFG/q+S5xnheedQ0Bw+/maa
	ZulIXUGTy2NOJEqKS2ruZKW1/QsPaWXZtTM8ibVefzdWcbdW1RyYTMQY4Q5VIzZK
	vU7Yz5QjabDn2H+/sA0qADDLgE5HCkJ815QOYJ9ipAJM9sc5nYI2ALh+6KyxaamN
	lnNFHfEDSRlrQQDQ1s7tyRE2Vl4iHPjij+03B5drpnfyiGsIBiiueLrmVY3zzAAD
	kTzeg9ucIBX4KjVV0pLqqnDdJHGKJH150ElVJ42f0UdVF8Fya6z1TDfR0yLJOG7d
	mfoZJQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfgnaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:32:39 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-486cc29e03bso10527045b6e.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 05:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784291559; cv=none;
        d=google.com; s=arc-20260327;
        b=nyDk117e1JNY3Jh9ebHyXBd5NKKyGzMRgiA6N9u6m9s+HnxPr0QpO5pX7TYvCUfgaY
         dBtOoNaIks0EeoAJn2McSDWSl7K8nguWv7tApL/E/Ca3LK1fSlKm+DfHR0GXSWiZMUXZ
         ZF0nkEJZTyqk/q2EPSGPpXgdK+vGmVYqSLekhqFMCyzfuodvrPyoeZkugEaBnJ95Lsb6
         7h9NUreiaHg4QKvpZNTRxoJNdq/ndv96qG2O71plaIyYD7cNKlK6/SEpEHEm6FLz6WcP
         S9FJM/J9muCTP1CM6rGECTE1I13w03vzNIOR1+x9VCYEBogoPeTNQ7jf8IME7ovC1z6F
         kB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1NaTFv12UGcSuXmAqV/BU6fGEBThcyQSKm65R3Df0vI=;
        fh=RiO8ZCfyFZnhBnYAKrXYs8dLlacf+jcbGjRHhDV0g5s=;
        b=BPtyY/xjC3ukqr0PacTo2MnU8l0C+7VVvpZm0ener59Sq0lRyAroGqr+I/MTslSVhW
         hIjhM6CAqVAcCd9yfW4rVRqbv50ogFVmqxFU0TiVJNyXlhJ4dMngzCbL1bYAP6QsZNpC
         IXr2lbmjFQiV95GB2c9bIirBmXvpKNav0b+5L6Q7HTplgfVdw2WFGx402JUCA5wjhZL4
         29jTzshHxFRVNnaJzWM1UGYdhbBXd+05mk+pPp7aZrmclSSWzavaBDzo0AGMgc5L0pUI
         THF7qCsKE12VqpuxNDB9iw6lu+98lWmKt3DkMd5IYNcs1EIrlNhHWLGZPA4HKNxrarbT
         MbvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784291559; x=1784896359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1NaTFv12UGcSuXmAqV/BU6fGEBThcyQSKm65R3Df0vI=;
        b=h8b83URd+yVWtkKPgcK/1NuWxcaG6vDPCCMzS6d2UYPiQiXLsZRqOtQAGRRFjICf37
         jr6/I8CqFbVj9f4pUsIo8N9qYdJ6Qr+RIoZMY+Su00+80Mlloe0JsDt3wNqYOxYghW6n
         Zy5G3znOHPdzl6eHG50F1IhxlmE8sGO/HtMi6WJtTnexEJSvV9S3OiOASE9R9n/7oqdd
         VdUgWM8nH/NVbcLFAVU6yWk+rvSoYhVEd3HNtfoYiKaiN6OikkGK20WEkFK9b8VfB1Tg
         9pyQixvGoglvt7jAPw03eTyBVJHIXNSwp9Nf5M2yMp2XUNwXqni6OiHYGt9BxPOAkySa
         3a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784291559; x=1784896359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1NaTFv12UGcSuXmAqV/BU6fGEBThcyQSKm65R3Df0vI=;
        b=HbuA6taT5JLvjiTx+CMkjXsBByB3CV4qCi250HbbDyUgQjq/2K5jSRmnTGDOgZpnCz
         jt7jLGnUgfzTtfJ37B5lKNyKGeIYrl1YW/6GMLqCw91OBB2/VJMTnss/KXBN4yCXTWRA
         ZrIRG6+4ig1yOjygR3FBh1lmvp8YUufYolKeSShpEA5LgtFrJ2Ug3TzzyaaEUZ2UmnIT
         r+FSEiP93D0TGGq4aKAmaQhWx9p19ePiK3qLoitHG+0eIiSy44gsVt42TqH4gpIv1Z77
         LB/ldO0PZpHSt8kV/PiqwjUanqIP7c4kw/fQSUqQs98Q2e8NCkqbzdKJIu6LsoaQGSep
         zriQ==
X-Gm-Message-State: AOJu0Ywzbc4/1TPyGfMXm3tA1S9FBai8lvhLdWSGiViJ4WByz6u1Ibfr
	FQdsZB8G39VHQjNPRlxI+OQF8u7NxPK2m0hI02sOwCxezNCggGNrZ3OmgiLRO+9MAh7Oz9xjezZ
	ozi0ugyN88Zg/gGfZ6flFTlizqo7DxQb4xh5443qNsbma+7F/RBj+sk/ZSDGyssk1c2G5EIMyxv
	eRFN5TOymddkHtnBGurp+SpJ73VEjSvM6uma1leg==
X-Gm-Gg: AfdE7cm78x/XkLO0ihDYQGt98i7poGPYpTBR9c8fD+PmqC8hCiMnZGT0x8r6rqdo5a9
	IyBOXywbEt+ceZMGHICe/ScwlN34pIbLtsDPd2QNzAikd9MqcGZG1eTaRKxo58ggAcWBFMIW4MT
	mbZhpaUIYeJgM9bBJU6YXCFkYlAWQ1sT9aBHNDn0F5NZgSHPRcoJA+Ze6uvfydhqfVUta83dUVE
	lAcw+A22Sq/cjhf2b9uNfJf7AQHW8MvdkC73G7g1YQbvFNMhJREXKEL+RPdV6wCYyifrcJLZlxR
X-Received: by 2002:a05:6808:170b:b0:49a:7714:ed10 with SMTP id 5614622812f47-4a4d04fea31mr1048157b6e.32.1784291558989;
        Fri, 17 Jul 2026 05:32:38 -0700 (PDT)
X-Received: by 2002:a05:6808:170b:b0:49a:7714:ed10 with SMTP id
 5614622812f47-4a4d04fea31mr1048137b6e.32.1784291558532; Fri, 17 Jul 2026
 05:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
 <20260716-monza-wireless-v4-8-9b02e6f549d7@oss.qualcomm.com> <CAMRc=Mc3gt_uruVmUmqsOsvKX=52V4TBVC0hbo69KgjEGhch3A@mail.gmail.com>
In-Reply-To: <CAMRc=Mc3gt_uruVmUmqsOsvKX=52V4TBVC0hbo69KgjEGhch3A@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 14:32:27 +0200
X-Gm-Features: AUfX_mxkpI4yt4A36hrtr3osmFBxHBcaHoAN8sUcij4FaV2PIUA1eDj0SRabmkE
Message-ID: <CAFEp6-0HnYOboVWc3GUG5qMN_phP4ryJp=T=LgZs2ujyX1isMg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyNyBTYWx0ZWRfX/ykSITJ5E8T4
 phfjryeUr63rBwYjglK/iS8vcgrgKbrHO3VJ8grP3UWpgtWY46h546JglcfdkhEPg09HQQbMhOq
 AhgduDrfply+maO/tZ6x9C82DLKtQQZWyEmn+Rpm8V3Y7W52XdiskdTj38EEiNBHNFHq0Pi599t
 2XgN9PpFSB4Qq0e690FdXPHgEy8tPe67elpJetWBGDbSU53KnUMYGHYke3RWhoAXsSTFUYse+Up
 tfBBgp4rP1ghirfejO0VsA1ojDuM4C10leXl5YzNibC91Q1c8y4obb/wFjUXbC9l54h4Bx0ydTi
 bUBC8OibuU2gxbGpnlFvnjyr+0Eb/XfSYXVDLi32UfdOw+lF5HRE0o1flDOPZax/ybAVPZfEuRN
 y5MUKgbDUF5kl3vjunGY4qulgQuN/hdj5twmHZKImj2bOAekHxKV/L6KNz7he6vsiYiXZFOpAXi
 T3+uLu5R4JXafsr2miw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyNyBTYWx0ZWRfX0DBZ86E0jgpG
 kM/tEMxsGEUdEB7vH+Sx2Fww6LuqMbX97ewZ1RD14QtbfirkQq2JtikdH1TsuTxBp45hAyA5toL
 /zXqAgN+WdaSRVLYinBYb4yJt4IDNio=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a20e7 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8
 a=vEpM0QAct-e1nrr4oykA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: mfaKcUZa9nMFfo0KU0NLIB7eH_reGb5L
X-Proofpoint-ORIG-GUID: mfaKcUZa9nMFfo0KU0NLIB7eH_reGb5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170127

Hi Bartosz,

On Fri, Jul 17, 2026 at 11:35=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Thu, 16 Jul 2026 18:18:25 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> > controlled by the W_DISABLE2# signal managed by the pcie-m2 power seque=
ncer
> > rather than a dedicated BT enable GPIO.
> >
> > When the serdev controller has an OF graph (indicating it is connected =
to
> > an M.2 connector), acquire the 'uart' pwrseq target from the connector'=
s
> > power sequencer and use it to control BT power instead of the bt-enable
> > GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
> >
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 41 +++++++++++++++++++++++++++++++------=
----
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 25c4387136245fca25e375951f960d7240116781..22f6185a946ef04c45e41b2=
b34126e3f58d603ca 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >                       /* Controller needs time to bootup. */
> >                       msleep(150);
> >               }
> > +
> > +             if (qcadev->bt_power.pwrseq)
> > +                     pwrseq_power_on(qcadev->bt_power.pwrseq);
> >       }
> >
> >       clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2387,6 +2390,28 @@ static int qca_init_regulators(struct qca_power =
*qca,
> >       return 0;
> >  }
> >
> > +static void qca_serdev_put_pwrseq(void *data)
> > +{
> > +     pwrseq_put(data);
> > +}
> > +
> > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> > +{
> > +     struct serdev_device *serdev =3D qcadev->serdev_hu.serdev;
> > +     struct pwrseq_desc *pwrseq;
> > +
> > +     if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > +             return 0;
> > +
> > +     pwrseq =3D pwrseq_get(&serdev->ctrl->dev, "uart");
>
> There's devm_pwrseq_get() you can use instead of scheduling your own acti=
on.

The reason is discussed here:
https://lore.kernel.org/all/20260716083141.GA4101439@google.com/

We want the lifetime of the pwrseq descriptor to be tied to the serdev
consumer device rather than the underlying serdev controller.
Maybe a short comment explaining this relationship would be helpful.

Regards,
Loic

>
> > +     if (IS_ERR(pwrseq))
> > +             return PTR_ERR(pwrseq);
> > +
> > +     qcadev->bt_power.pwrseq =3D pwrseq;
> > +
> > +     return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrs=
eq, pwrseq);
> > +}
> > +
> >  static int qca_serdev_probe(struct serdev_device *serdev)
> >  {
> >       struct qca_serdev *qcadev;
> > @@ -2417,6 +2442,10 @@ static int qca_serdev_probe(struct serdev_device=
 *serdev)
> >       else
> >               qcadev->btsoc_type =3D QCA_ROME;
> >
> > +     err =3D qca_serdev_get_m2_pwrseq(qcadev);
> > +     if (err)
> > +             return err;
> > +
> >       switch (qcadev->btsoc_type) {
> >       case QCA_WCN3950:
> >       case QCA_WCN3988:
> > @@ -2426,17 +2455,9 @@ static int qca_serdev_probe(struct serdev_device=
 *serdev)
> >       case QCA_WCN6750:
> >       case QCA_WCN6855:
> >       case QCA_WCN7850:
> > -             /*
> > -              * OF graph link is only present for BT devices attached =
through
> > -              * the M.2 Key E connector.
> > -              */
> > -             if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))=
 {
> > -                     qcadev->bt_power.pwrseq =3D devm_pwrseq_get(&serd=
ev->ctrl->dev,
> > -                                                               "uart")=
;
> > -                     if (IS_ERR(qcadev->bt_power.pwrseq))
> > -                             return PTR_ERR(qcadev->bt_power.pwrseq);
> > +             /* M.2 connector modules are powered by the pwrseq acquir=
ed above. */
> > +             if (qcadev->bt_power.pwrseq)
> >                       break;
> > -             }
> >
> >               if (!device_property_present(&serdev->dev, "enable-gpios"=
)) {
> >                       /*
> >
> > --
> > 2.34.1
> >
> >
>
> Bart
