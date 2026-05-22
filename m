Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9842189D
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466285; cv=pass; b=KJlylHpc8Dh6lqtyqZkrYYNzkFFTToPw+pRygEOWo/V1yO8Bc3mg60+P6qNm29EYEfXqszbDUsudalaNDRJDQOJHuBEFtlytjkBXq4kbp5bz9WbpTc3gCVh6ljaR4mohye9UFUy82Uappr+yFtSIcuWjTZZ98MreERHd6uXFOGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466285; c=relaxed/simple;
	bh=bLtI2OBA5rafdql0eae6MY8/XGVx80bBush8lA9uIPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3CmK8x4gfCYLuOF+iaz71F7hHCTtp360rLDH3JWfDcKrbNzhNWhP3uJ8Pffia1/usJGvqEhNTj61x19C5BseUes4m+3H2vXu0X1lxBhjnr5ylgXObOPm7tvwy0iYl9O9n/nwdrTf/DFqQDGW91OBdrHb5Sz22OVGI6+5RB7oaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C8UL5tlt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ab7yDX+7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C8UL5tlt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ab7yDX+7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MAIjIc1800770
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 16:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=; b=C8UL5tltXnXU+6nX
	jHhbbZeMbZja0B7v1zrospoXn2ug1pL3ImgZciQ7OI7Py4ei7tviaRBOQVb6TZ1r
	7I6Sb5E4UsdKg2h7pRgaEEj5/YV1kwv/Wjp+ceh6enYt2BxwvxAwubUsJLS51Ohc
	d5cBl0XI2mFp9IWXX0Kfda9Zl5qiwh42eMTwIE5X1jsDKzWDHLF8Zb5SGuy7KHhE
	yiAXYXtAXMz/bAsnEaIqUKCqh12KIGXxeMogYcgjahBO5eTLbxD6Ss+r2P1FRlzy
	8oLVz+bFkGxYTiKaz1mHJxjjo40BRWgU2Am9jF3DdDh2Uc8jvHTiiiE5YVNpqxGQ
	SlI3zQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g1dj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 16:11:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914b9dee344so137587885a.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 09:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779466281; cv=none;
        d=google.com; s=arc-20240605;
        b=bAx1EY0ts3XhECubtCGaAE4XRWQjOJc//IjCdREBntK6zXQT7XPb1+eEXwJrG9QOSn
         0lK8S8Ur/PVcFWSUom4xQ5ICr4Gcy0rPY3EvCckMO2HohORf101sIWMVEWPYUqMHZdzy
         FjD/GQM4ZoR/IWJoxvB5j6MjhXktjrr/3WLxyObiV1VcsZx6eoAm3xjsgxpc94PNBMJC
         Jm103l1FolhcdGGWm1qFA37Ce3va1bJlnTgCrYoUqYJy0Ajqha5GxBekPVRe8g7XBdlU
         dRsGwXQnYZ4N5s2RiuRUcKlS2/VTS0RTt3UUIKODLeevWNS78B+a5bhVE4iIpfwhqXYw
         XNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        fh=UTPFcMhc7XCfOxn1mBj7T8SRZrzCpOMULY6FFh9nlv8=;
        b=NzKVs3EOR29mCap9czjsQYIOP5xp5kaT+Paww9y6F13O/3ApAgpI5Z22KDFTayDDlF
         vjbO4gswpXMW/1Q6yXIYtPuqfkxasDuqA5AH/To6TxkVNXkewd1KqgBpWIOPPCdH1fjI
         qGcgSWN7ktQjDmoOPj12Md5Dp0AqyatIl0vLSPVNXXYmy4MuwaG9XqaMVLNZiaXWGKJ6
         C50DkraHbppSq+NsT8kBuSonX1mgPH83RaiBB5GclM+UMkSYzaauGdjyruXqPtCEJ9QJ
         YNziD/ZK7T+C5MKPsug5EjeEm+V3OMN/BEFYKDZB+YubpE+VIQ+wLA9BkSoJ/1fI+Uw/
         inrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779466281; x=1780071081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        b=ab7yDX+7wHyPQLuGi1en5pfbfQfl59c9deiCGFVI1FJDD/Nv/TMXhY+nMl2GjWOEBS
         tvLp+pUuuQa3E/W/Sym0mij+VVP9qVZL2bCsTA5iCizlh6cuiRqlpYgvPgIYvJiB1nkk
         lhyIeAOpdXHMxlbPFInMFsXW9mzOQgptTHJJDyJaCXk4F+4UUjX3oGCGtdMqUeTZNnSQ
         zjsAWoyZeTh9dboFkNypurPhcyML/Be8CWgYZVmUTyPOSSVx0MvRrcgrV9sIczJzkGGw
         ClFYASUKNyqw8A1NYTCI3HJZMTK/l3oTsSSqFWlDqMuOaVbUfmqcRdidoZMrN24lige9
         TYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466281; x=1780071081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lu1niHMrECx4L7qZONZo2E7wZ8eqqnrUPVegshXdyA=;
        b=C9RiMz7ymdDYz4g3LWPoIsI4NPe7p9WOtbV6ZqIlmlIXIaIFbpkvP9+DlpymRuIuen
         aS7cYGiTQLyoYUFr1jc3zd2op+eTG66C4d1hRODw35ytFuKxOVWMORWQAUhsS9PRt+JU
         SZJKjI5krsfwL2Mc+n8+kbJLrYy4c46CvI7AeET72zkwkhWkerBZ3miORAYUdnPJ/TY7
         zeP99noffmpEBVd506e6hPYYiLvUbUvzdM8jdA666UQX7fUliQBrfugcaF3jjbAL0Ijm
         PH18jspVanM24MXukL3D0BYjuiOpcEBVVMZ2VyM0E8080HtU0y32N54VNqVvM7cjHxDG
         B4DQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VBrDvtKrTsx8vVO/xKwxkHtDqJUub136lI/DNjWaXOZe+gh2wg7iRpz+yI9vpjo0IqYl8HOS6cYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznjClj8nvj2BbzTAtK7Npz6+FPWG6nHun7stJSc+nWgi0KERaU
	0xqkCfdBQzqLlWXUZpJ9VrrUJwd8hQMZnuqFpi9Bn4R/zBtxxaMf0IZbQhePGrVd84BVgRhbhw1
	VNXZ1N9q6t9+XsWAX/cfUgQpCzU2fD5UZY0NbslVy1ZIOSN2ZYjkcAWmRpssXOD6zXhZFiNykEf
	Xgr8l3O6UpOshJOH2MWKN/Do7q2O+JwWoF440MJQ==
X-Gm-Gg: Acq92OG8QnQiqJuLLLH5XCPw1o/OFLSiBKj9zURFO7CvLVGfSrVhLLhH+BIGvsSfmHB
	O+1lRRJrw0d+C+ygWGH34Yi3EQRD0rygrY5FZEtyUbSTUq8phk9lkY8LbvlfuEGQizS80qqa1Ig
	L1Uj+MMMe3JlevUMZyzVOM03G+ym9wmqzmU7/EMmngRCb3bxqe8DZ+5XGtpQPQtkQobRG4uvzAN
	hOA0gq91v7EiRoHPQmvveFB3tzjzn7eHHzwMvs=
X-Received: by 2002:a05:620a:1d0b:b0:90f:9cde:9788 with SMTP id af79cd13be357-914b48d6853mr675638085a.5.1779466280693;
        Fri, 22 May 2026 09:11:20 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0b:b0:90f:9cde:9788 with SMTP id
 af79cd13be357-914b48d6853mr675629485a.5.1779466280032; Fri, 22 May 2026
 09:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com> <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
In-Reply-To: <cx3pbr47tsy5mnag73oopkodnx4jgoiipz5pzrp4uze7mk4fgg@zogzww23ueni>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 22 May 2026 18:11:08 +0200
X-Gm-Features: AVHnY4KZcbVzn920hjyxYOpqLudIDkA1KQq_MhbagXA8SoEUbTo3JjxoNdQTHfM
Message-ID: <CAFEp6-3_NuWwF=gthfJyqeHMivGnfF0xpsTXT-xGW7pgFs+j3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: nY8TW0gW-HqRz4OQImLv0aFmBeaE3NVk
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a108029 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=O2y7hZ9sxHz_cEH75X4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: nY8TW0gW-HqRz4OQImLv0aFmBeaE3NVk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE2MSBTYWx0ZWRfX09HnJ5uhCS+/
 rFlxvvGxRryTzEiDKXSxyrCxWPT0WI8NLlk7hU73ED6WwKlXk2AH7D1+aJnIG4IV0Adw9AuHzME
 NcMg/7xZBDSHWsDsCyBKVuzcxlKb2XFIDVkMhuSt1OWIRB236LfQFa/d2K/FEcG7zY+YP69VlWU
 fapj+ID5Ib0mzxZrJuhzyzu9SDR0ymRPy75SoE8F5bdCZoST89e338w0+F/ICmi4C3m/ToiaZcn
 pQTeV9MlT08ZkKAAMmUZ+JEEd4i0LlcCJnx06AM8C5zKKZYco5aDoruI1YKE9DInMz/VJWSkkSh
 4F1+H8SeXpa8xsJJYJgau2LjZ/aOt9qlse7wNqN1QpJUaAxMUtpSDA/6qOqyU08oOB2dGfmfUut
 8/jjWgH6EAVTC3UZ8/GukXNBzVjigAHNFSOwoYDH+sRpq0rNUbbcJ7umRHHVxDcN2OtbWjtrj+h
 Aokv1s3L3IHtiFnzXdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220161

On Wed, May 20, 2026 at 2:33=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Wed, May 20, 2026 at 01:01:43PM +0200, Loic Poulain wrote:
> > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> > is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> > sequencer rather than a dedicated BT enable GPIO.
> >
> > When the serdev controller has an OF graph (indicating it is connected
> > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > connector's power sequencer and use it to control BT power instead of
> > the bt-enable GPIO.
> >
> > Also allocate bt_power unconditionally for all SOC types since the
> > pwrseq path is independent of the SOC type switch.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5=
d670fa2758d3268d0 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >                       /* Controller needs time to bootup. */
> >                       msleep(150);
> >               }
> > +
> > +             if (qcadev->bt_power && qcadev->bt_power->pwrseq)
> > +                     pwrseq_power_on(qcadev->bt_power->pwrseq);
> >       }
> >
> >       clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device=
 *serdev)
> >       else
> >               qcadev->btsoc_type =3D QCA_ROME;
> >
> > -     switch (qcadev->btsoc_type) {
> > -     case QCA_QCA6390:
> > -     case QCA_WCN3950:
> > -     case QCA_WCN3988:
> > -     case QCA_WCN3990:
> > -     case QCA_WCN3991:
> > -     case QCA_WCN3998:
> > -     case QCA_WCN6750:
> > -     case QCA_WCN6855:
> > -     case QCA_WCN7850:
> > -             qcadev->bt_power =3D devm_kzalloc(&serdev->dev,
> > -                                             sizeof(struct qca_power),
> > -                                             GFP_KERNEL);
> > -             if (!qcadev->bt_power)
> > -                     return -ENOMEM;
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > +     qcadev->bt_power =3D devm_kzalloc(&serdev->dev, sizeof(struct qca=
_power), GFP_KERNEL);
> > +     if (!qcadev->bt_power)
> > +             return -ENOMEM;
>
> This builds bt_power for all devices even though it wasn't the case
> beforehand. As such, you can drop all further `if (qcadev->bt_power)`
> checks in the driver. But, you also need to check that this won't break
> support for other (older) chips.

Ok, I will do, and double check.

>
> >
> >       switch (qcadev->btsoc_type) {
> >       case QCA_WCN3950:
> > @@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device=
 *serdev)
> >                       return PTR_ERR(qcadev->bt_en);
> >               }
> >
> > -             if (!qcadev->bt_en)
> > +             if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))=
 {
>
> And this breaks support for pwrseq for non-M.2 BT devices. There is no
> OF graph in such a case.

Not sure why, here we handle OF graph as an optional pwrseq provider,
but still support legacy enablement.

>
> > +                     qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&ser=
dev->ctrl->dev, "uart");
> > +                     if (IS_ERR(qcadev->bt_power->pwrseq))
> > +                             return PTR_ERR(qcadev->bt_power->pwrseq);
> > +             }
> > +
> > +             if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
> >                       bt_en_available =3D false;
> >
> >               qcadev->susclk =3D devm_clk_get_optional_enabled_with_rat=
e(
> >
> > --
> > 2.34.1
> >
>
> --
> With best wishes
> Dmitry
