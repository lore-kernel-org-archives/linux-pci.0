Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A83F074A
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193216; cv=pass; b=C6aNGjt/oAJWx5jLW7Oeyr6QQcyWUJRk5dO9GtC8NqRUn6l8P2YBX28AuDgNpRvKDFrZHd1REXcJz+0yvMVK6kWmxMBMy0goJsgGqLEJDxEZUqo84DRacsPRHCpAaI1SBhC+Kk98lrTwp4CtXhW5uIGOwoGvngQa+or+A/CiTW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193216; c=relaxed/simple;
	bh=uCqDdKgSE05wWFAXOn24NCojvJkTjvFV4xaFhIaDAx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gv0Ivw3FyK3tU6/Zbr8Vp7+mUI/oVZ9127zTHyTFC6z/8+j6gyK95Q9Z40mEaA8rbivYg/9sXX9wpiO/NYxYugNFkte2GAR9dHSene5gMlUHhesKywnNI0YqsZ0OOImmzVZYMWwKvZvQU6vhpNE4Mzwta4cXemWMIxBDfKGLvqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7+5EgcK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TwLzV0hW; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7+5EgcK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TwLzV0hW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G837YG2123328
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=; b=d7+5EgcKohigk/Rr
	f50a0z/LZV72FFBzPnB6iROcFhInecWl+0+L0nY99Z41rukIuVSOycIuzUr8v6u1
	YzjXctSOPfKgBVAOxptCXH+HqIPNSsAgSdenpQm/tzJXy3Z1mQiyoNsvWNe8nHQY
	qy5rsaM3RL1ctlWQLte+ZhcU4mIkDF3clW0nMB+E8GgpBhPQbyffYyS9Od0w88w4
	4x91VBZjg2haPe8dxW5CjnJ29A/PJoExvtdKA9LKvcFb3XmtFjoioxot6lUajnLk
	r4i+E2BmY425n4WZEI6Zyx1MEPY/a+j7WCdKMeMa9TqBRbj8+KnLAAcMWUDu85Rv
	0PMEeg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex08jh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:13:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-904dac0f77fso104412406d6.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 02:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784193209; cv=none;
        d=google.com; s=arc-20260327;
        b=YFBtAmo8PNXlhO4MliRzCSyIk1IULMHg3UF9yO9XuQMtdvxksp/MK8dPEpsY8++aKN
         JhoZz4m8nES3r7g7qBS/aN8TLaAYvIOFSsUaJCuFhslAze07TExW/qIpJG902ymL/t39
         Tk9chv9kraAkHcXI04xdxmncv4n0q1OKL8smuuyD5VgJmJelCzZ65LAJUWSxBeQA9tEQ
         v6MaqfYR8X5pkQPgczVOf2Rx5l7LsWlDrWHv0N2s+RvU6F/bOUxFvdp5ZkwScmfZj/CX
         7xJY1eZ1stifa06kPMnDHgjeJbv4gAe/K/P9LE2EH3RDhGpd59Tuh335vqmJEladA5ny
         j/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        fh=MamPUx/+fcW50unk11CEsj8eTWtnm2ytwO5T9+cE8gc=;
        b=UekSmhqjgT7DrOS2Ja4MsXrD85HHI24KUB4D/DaecNyirdx9i/RGqPDzcIgCBVnXEx
         /9Ze/qtI67150RAy+y5wHw5cMOmL2EroEFEZDapcibiYlKyf9Rsgqr8ldluat8pvS/rh
         36wCDijmoMI9U9RW/xzMWk1sseAF5jmKxK1oGKdd3gjJs4xokDoRA7SoDXpUoTWsb1SZ
         aNFpUi0TFV70PjngzPVcNRHvAZltqlQF3Mhs4NWKem5+jH8n6ZTgIsR4YoFICwy6vSU5
         EXzs19ZLyasw6PCv6jxpos5zHjvGvhlq2DTBuUcBkUGKxkMySFVzbKRH8qNwM+DwC2Hr
         Dj9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784193209; x=1784798009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        b=TwLzV0hW33RYt8nI0/zpwTi7ztoge/roka6KcZ0Jcdz9gRd2W0DHuaLsVUVXZdz4fm
         LOZ0smBTI+KUX5b5koWhpGqvy5jO14cE+INR+8QkJUYK5ujgKWhnulvLTp9IhdcXdj4V
         +a0h2sg33nJu1QJuQDW/bT9U1uej3ZaTLCjbV9runbis7DrI6v7WSmXs15Cc0vtupRbt
         PAaTzIlB0Q0RFJ4l+rnZcOb59NkdFkXe8p0VAjhH+AbtEdRsKkERuFRvcZxt4mVpk8Q2
         XapZGn3a3bgZ9+xnIlzdHyk2uTmuY4LmQiAHPGj3z93FRJDT8pHnvpD3iAtWfIEH+WG3
         Qgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784193209; x=1784798009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        b=e0M0sV7yLMc9CmGJ4zuqTk/Ij9cFX633Y4dgcJKMhZubRxKSaRf7eH/Fo7xmK3otpH
         4U+Gr/Vtzkzt/BByF9bywU7Moo4rQ2dOp9vwnlibh7zE2HRWUWaiYo4MrfT4+6pFV2op
         kDWbaewC8jINp7aZYVjrtynZLiagKCNAjYZxltVjfwf2NO2ifBA/AGHbi3GjfG+6G+Yh
         fxk9b/IGIPa+XKpRvmFV9cZaq5HBTIAI+wDpRz/jYlUntggIqED+hxfnwQhcNxVmhNnt
         psI7KPsaClmlE7TkjXjzlCFyqbilGOmSTY+zCKCZKSDFUbl1TOtGvrn5+16/OfbhbiQ4
         8RvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9VmjkT6s9jLlr4LUE+4XRX2Xoado8bSpSOVc7JyJ7UHSQTCDqoLFT7aYZi6tZiyBqc15x76cyY/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+52fCVSXAC8afGsWyO9ijIO9PWSO+BO+MkHBN3eDggnfzPTd2
	Jj7cJCgobaCXwFDWVA/V+aiO+UvxtohZLd8VGFsc20PONVaMKyzy44wv3Xi5pp09TiG8WhcIWQR
	PC8DpX/J1C8YuE5IdR+NY1Y0r5sMSXoLx+6Ir7tqAl7venBjlHY+jKJECE0bXw6xQUqxPhm++5C
	bK7Ip/O/c1/4keIawNJHpJwS37G+JdtekJhNAZMA==
X-Gm-Gg: AfdE7cklKZbi4oabuTPr9/SDcmpfUCg74tbdEna1ERjN3xE+SY2dt7ucc2Us/37ifJ0
	EZvH+tV81PYDZglWen4VFrD6Kxh7Sf2BXyHyBbXehVhVVGBDBWEUrvLDKisrDo7x89ujsyARWxw
	rQSiT5qnmzSTaDYAAftegAqS7MPZMBLnEF4AqVWei3JBSbKuqMrX+qmuoC15DizS2ea1fHm35is
	2XAA7JTwDRGyXFQgzmFL0SMGJuypYCstKt2A2EJlFhrdxHYYxvFHc7c4fdu8ma30smbtsd7IMBi
X-Received: by 2002:a05:6214:428d:b0:8ea:fb8c:2e0a with SMTP id 6a1803df08f44-9074c766c6cmr114860266d6.28.1784193209381;
        Thu, 16 Jul 2026 02:13:29 -0700 (PDT)
X-Received: by 2002:a05:6214:428d:b0:8ea:fb8c:2e0a with SMTP id
 6a1803df08f44-9074c766c6cmr114859886d6.28.1784193208701; Thu, 16 Jul 2026
 02:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-8-46253587af64@oss.qualcomm.com> <20260716083141.GA4101439@google.com>
In-Reply-To: <20260716083141.GA4101439@google.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:13:15 +0200
X-Gm-Features: AUfX_mz2l-ruyrBEqJdkcXUQ_DW7F-Cm1EuP-VtmhPBeabFSDhnP6vsS9Wv2wFM
Message-ID: <CAFEp6-0UJyekA7zE74=CgneqvxDbea0Xw+u8O14bpcHX8Yb57w@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Chen-Yu Tsai <wenst@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a58a0ba cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UD6jFWV5_MqAamJTNaQA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: cHjh6NaV0CSRHbM394el4y_ZOoMdTODZ
X-Proofpoint-GUID: cHjh6NaV0CSRHbM394el4y_ZOoMdTODZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfX6y+jJBaKGrRO
 8cnM/rzBeEDNg1uNpoWLoNKr94DMNlX866EH/N2I+qcApu0vUq4ZGhOUahw+FhE/g1BxHCkysOt
 xYRa4mFvSQqo6qZ3NtInb6Nl0RMGjwM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfXxHYA0NTHEAxe
 Q8Q2NW6uAdX9q+Qc/Xf8l4Wg7Bg2EtbhwbadHe29ICV4nxNuxrou7/zUziVNEilz5fY9g5fIz5s
 HSEljChbxfoQ3F42aPP07RC52hlSYgEsTqzlJhq3vy/1SHS1Q2l6p36ligUfPS62AHcyXjmKwMW
 VOWn4AbL0Wb/IZtSvxbSwuhOLzNcpB6oi9OlZ0vafPQn0O0pg5lxKuyR/XkAl/47f3LCb7EtHGT
 Kd7d5TSgFMbl5phj0MUvNCP1CSk5E5icPsBVhSxHT52FPNZWlyOPBhSdkNdxjv00AfMMcUdFmaS
 S3lhZNDPhgIPl6ofvVonBXqSJLjKO0euDI9kduDur3g0j2NW8rs/nMc8yyXD1Vom0P42KFq45s/
 LAmz5oe4yKUV3/7CMq7LPCBZitfIdNNxrImFVzZowiv9M6FC/tA/f4Hfc8xGA5dsU0CV2bDqDsE
 iZ+SvhpL1ULd9zBgwUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160094

Hi ChenYu,

On Thu, Jul 16, 2026 at 10:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 11:57:34AM +0200, Loic Poulain wrote:
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
> >  drivers/bluetooth/hci_qca.c | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 24dc5bf6d192be7e1d500df6bdf36e6184f9eaf7..f6529d359ffbd97f8a3c4c0=
593680ab200215b36 100644
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
> > @@ -2387,6 +2390,20 @@ static int qca_init_regulators(struct qca_power =
*qca,
> >       return 0;
> >  }
> >
> > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> > +{
> > +     struct serdev_device *serdev =3D qcadev->serdev_hu.serdev;
> > +
> > +     if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > +             return 0;
> > +
> > +     qcadev->bt_power.pwrseq =3D devm_pwrseq_get(&serdev->ctrl->dev, "=
uart");
>
> Note that this ultimately ties the lifecycle of the returned pwrseq
> descriptor to the uart, which is probably not what you want.
>
> I ended up manually doing pwrseq_get() with devm_add_action_or_reset()
> so that the descriptor is released when the serdev driver is unbound.
> This was for the Realtek driver. I haven't sent patches yet.

Thanks for pointing this out. I'll fix it in v4 via devm/action.

Regards,
Loic
