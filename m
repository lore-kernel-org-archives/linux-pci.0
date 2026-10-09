Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE84E433C
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564023; cv=pass; b=sGZYTH9XIeUAUgSQcbL90tZypNvzqYbd+j+ZzntAv4s5IRzvtyfOFbHWMn957Y9p+HS1w14fuMRfnJlfk8m9YrcE3l1R9w1djjiXLU1fV9YSv9L+sGGHmYaagemtWrE81PNZjGCgIxd/YK/IPt8Z0jejG4EFReupEN9M7/Xdef8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564023; c=relaxed/simple;
	bh=O8BZgU9vbT9VzKGigoj0YhIQo4ixHDL264tHQrF7gDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyktgCeJZ+fDQO+73tn4f+dG7ut2+U/iKc2CqDZvbJHFdTJgBbTNd6TRyZ1wTsK9VoZG/zTaM5Es7YEfRjnXz7gKpmLq3bsQqzee5e+0xItrOVPml5jFCdeNz2ajSdp5RLfPEgWhT3IRj6zY+baf7kAjBiyCbSxHTpXAuA6JyZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BzVoZ3gE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fBs2swyv; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzVoZ3gE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fBs2swyv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GbDXl2018462
	for <linux-pci@vger.kernel.org>; Fri, 9 Oct 2026 16:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	03cV0/SHCir8TBf41ccHk0p543FbvOFeT/DumSE7PMQ=; b=BzVoZ3gENy1gF6ye
	qYehjQ26tYEkKPZmjWraQwf4erIChnc9V+zoKmw5bLBu/exRPi7Q4fQrYx3ftdoI
	K41uJG5h4TUThUzDcLqOKWXAZRWXwdyxHqyKdtPeGgIVQxaUQwckq2o981X/uk2P
	QMvc/NRZdN2sNRQIqMu8j4KW6cwuGjwHBGdUi9xWWEK47GmlC/04OS94KmujDl68
	iH6EB+Ce1KfP0MgEASzew9nXIUkc2wFJsB/uRNB50GfOwmEsXqfgSgZ4/uku8L/w
	x3X6Yb+LnS4+2cNJR5+V/SpJgJwA4Wlr/PtgkwG7jY4hYmBeF3Rc2nYg0s4dRhAk
	35WfOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h71f1rqet-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 16:40:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ea9ea9d13so364279985a.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 09:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791564019; cv=none;
        d=google.com; s=arc-20260327;
        b=HLpuJOhhKwJg8z5+sETVQexIZnowFoftk22ZiQbvZtY9G98dKUg8pjebMD0izDfQfA
         XPD/kOfh3HeOYF+TwMs2Oja90R7WYoUibVuTmS7zE5q2iOEv2FktjF1Src+kEGyKwxXD
         j2k4SJ5Rvhq77nzL7lDNeRSHEHWrq4WK3pDokMvm5IyP2+qhIVJ+zzKqkJI5BkyrO3jn
         Hyn7CefLVZBPZb/ESSsn/GBPy+zzANE9nL1QctaXtgmYkXudX4CfZWIytWufpXcPsX+c
         Gn9xIZgy56kQav+7IqCr9+hwlY2ui0QKCAy6HW6nQkYn0QlsLr8t6fnuaad/wf6CnYu0
         DhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03cV0/SHCir8TBf41ccHk0p543FbvOFeT/DumSE7PMQ=;
        fh=4Z8g9AymjXrmhuv6Ax9MnOqsTRH+nXJdjUzrDAJzPYc=;
        b=LgYKKZyDkT8X3IWZAkgX4TreCKpS4delEkl5m3wuog8va/l4rrQrdHkk4CL+/NdJ5E
         6VKmqjkOj0MhY3qJMBlmmFmUjA/6Q9bEwcKLpObjuaNi3MkPBWksEeEgdpczF8g46gOZ
         MvdNeFATAtgum0SNnk34qvV8vDPjva1xxa6IbbOfg8sd8gGyZXKvxLpJ6MEC9bIsdzRe
         OCOkHJ8eeMBMxtb5iDd60AAfQDegJeXHkSmiV5QoFdXUN+uLpX9dTLCSf2q1iffG9kyk
         Mlz68JWHosvP9DsDWRN1S3XUzp9IrBTc1oJkywXG0hZH8FcNngZ1SbTSXSKUtzMlcHcc
         gZVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791564019; x=1792168819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03cV0/SHCir8TBf41ccHk0p543FbvOFeT/DumSE7PMQ=;
        b=fBs2swyvZBOfk2KVO5FEc04xYgLuhAZMmXCuuPsSJu9J0LoO1mXm+ZSW/ovI6u/zmD
         NeHYZrYGip/ndFzhL3P7Wh1nTOAjaRQ/aYrzrMpUBQMmHJYdekLLzFBkUQz1YO20dyLR
         ACK2jkA1gg8UJc1d0JFdFAKSYHui4ICO4aHWYjcqdvr35QdJlCji6o94e/Dl0oBizIeu
         2uJYW2swCJcxv4o+fi+prOewV1nTP/ErPYml8l26JmmvKLoTyhHmblZXuIMeDaRF+Aw+
         4wTM1HxkgegNyl7wZF5hU+0xHPKINBQr966bKVbFCD1M7tTfWIykR1iKPW8tjczMgdpF
         s+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564019; x=1792168819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03cV0/SHCir8TBf41ccHk0p543FbvOFeT/DumSE7PMQ=;
        b=A1a7/XpxTeib6NFV02Tv0/2Xem8v9mam+KXrTBAs4gyuWUnJyJ5rhuR7aHeMMoh0nu
         FvMEeff6exBYGMGA1z4GogweJgLWeGAatj/dNY1lGADgBkEC+zBC1RSV9tYVCuh8830V
         jIGECaCGjpQLUHmxCzzO6hqSg/iupcvjFXi88mHXEFuKI3xGBxIGuEC+Erjii/6acp+G
         DyoXspOh1NEvtf+6FAmptrgqHb9eWhrPzGFFkTeHeFNkP7BoW76rYEXy9seRMlRXGFQW
         HsbdQYACxpzszsh+j4a64lDWnq1/eN21/MbvxcvOdptndNuNyoPmedWnzP32FpFaWPyT
         28yQ==
X-Forwarded-Encrypted: i=1; AKwUvByf0p2bHV7KIdwYpHpkB2lPuIxfEPCUzYME7EiU+DB4oTqhdGpTF7gpsbzowity4N/Bk6uWl6rTs2w=@vger.kernel.org
X-Gm-Message-State: AFuF++mNfYL2YZ0unXZHqzgZzPlCS0K1/7tX0cAjxz5ZL8mqH1MBG4zE
	64Hcs4qT+xoStdkcMyfIwL3t3ow5vCJfWok/hk7cvYkK1gOmw7CHD1DBLCuScKWMC9PnUVNE9c0
	mece8GVf1iJlJmLnw36rSqTWlh3ZmeCYbgogrbsvA0k8P/GVIiVjzLP3JKDDhF5KwX5JPCzmMmV
	55c8tW2YASsqgTdk29UJkuUuNuV7+5MhOJbmdMJpRF24s972YTfF0Atw==
X-Gm-Gg: AYBFou0lIiB3c3xSdXTHkAm3MvSbUtybnPo7ImIc9Hkv78Zfy1skKIa5BzE5+7AxC4e
	YveigAqwxe1wkJezJRSeTeJ7HLuhSFPa6Q6oXYr9nzmHUVg8KxWyz0m/UX+6BQL1c2K/fMGeKl5
	OoIZD7oE+KDkfA9WaHIDgRemmZehNF+zkr4o1LAji6fci8NtmIqDzS/QOKJvHMOlBpvS/XpN9bE
	UOUN4QU9x0RTSg/9mVqcYAby1d1orGbmbGjSWpvWvfT0dyo7uHXCav5GsMaqLeapM+aLpFgkiC+
X-Received: by 2002:a05:620a:269a:b0:939:13a7:70f0 with SMTP id af79cd13be357-93ebd0c260amr388805485a.5.1791564018693;
        Fri, 09 Oct 2026 09:40:18 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-93ebd0c260amr388800385a.5.1791564018141; Fri, 09 Oct 2026
 09:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-5-5a6de7662dcb@oss.qualcomm.com> <bc7730e4-8b47-4c2b-84ef-277749f2aab8@packett.cool>
In-Reply-To: <bc7730e4-8b47-4c2b-84ef-277749f2aab8@packett.cool>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 18:40:06 +0200
X-Gm-Features: AclHuK9ldJgKtc_xURMW1e6eF51wDo8WFdbnPxmGKItG6GLqTwM1Bp8vW5CtXNc
Message-ID: <CAFEp6-3Mt-CCJEz=RAJUh6pxH-Ssgkqfx3QQfyzvS9HwzFp9QQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Val Packett <val@packett.cool>
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
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: vUxNV6FYowEoNYUjAQpcta80V2xAJ4BI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX2sCJdgkaypLp
 tE4TZOoe3py9/KiBSsQ/KzoV7x2T4pM56jc3nj/RmcnXHwBwsvsDYf2P+8CZAVsmjWmMMzdZbkg
 35zx2zEdpaPRCLPDuHRPzR8w64Ibykg=
X-Proofpoint-ORIG-GUID: vUxNV6FYowEoNYUjAQpcta80V2xAJ4BI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX1bvnPoUNZYO9
 edrU4bbmIGYBLg5xD+XJoGW5KU7d0GBYxrBVc9OxdpNPjX9V7WZJucC6kZ2i+s92c3CWxSQYmny
 SqpT4p0abzNWH7W7Ve9FYnkWLG+M0P8bQYMk4NqQZNbbqtaOufvBUAFWPrTQir9Au+kFwGNKAT+
 y4IQ2uMr8/Sw+lZKfMRDs5U1w4HaGN8mg3Ho9WowBYTeXnMXkYCYyz1wuGSt3GNOnpNE2n9z9hd
 rrUdVfclhK5Dba1eper6vs8RUL6g1WA3yCRU6eME3jiAG8xFkwvPBlt4RbDiAHHQNKWOdHX8tsL
 woxK87mq8n2jMWxp7Iqd/Wa/hqa08tjTdGbOU23Lyz8WFdRgbICA/8jktH0bNh4Y5/Vf9Uskat7
 rzxL5xcT2u1mOre5iqgr1gvekQA1acrWvcFA1vjTcG8v7ZliHLUyIUi8lFDMHJvRkLwZI8ctZpe
 ik+ZIYBCvu4KBP232rw==
X-Authority-Analysis: v=2.4 cv=YIUKWhGx c=1 sm=1 tr=0 ts=6ac918f3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Zz9X-WFLHu0qX2yPYA4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066

Hi Val,

On Thu, Oct 8, 2026 at 12:58=E2=80=AFAM Val Packett <val@packett.cool> wrot=
e:
>
>
> On 10/5/26 9:21 AM, Loic Poulain wrote:
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
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >   drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++-=
---------
> >   1 file changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 1d27ff98034ba99d0783e48db5c605f3b31117ea..b6ec1a57248e2cf4bd13889=
8ffc5cad45b1b4a8b 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1875,6 +1875,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >                       /* Controller needs time to bootup. */
> >                       msleep(150);
> >               }
> > +
> > +             if (qcadev->bt_power.pwrseq)
> > +                     pwrseq_power_on(qcadev->bt_power.pwrseq);
> >       }
> >
> >       clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2396,6 +2399,34 @@ static int qca_init_regulators(struct qca_power =
*qca,
> >       return 0;
> >   }
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
> Seems like of_graph_is_present does *not* return false for the existing
> (non-connector) setup which is currently used in all the laptop device
> trees..

If I understand the issue correctly, this can only occur when a UART
'port' is left unconnected, in which case the failure is legitimate.
The laptop device trees should be fixed accordingly, either by
connecting the port to the corresponding M.2 device or by using the
usual Bluetooth UART child-node approach. I don't see this issue in
mainline.

Regards,
Loic


> > +
> > +     /* The pwrseq is looked up on the serdev controller (which holds =
the
> > +      * OF graph to the M.2 connector), but its lifetime must follow t=
his
> > +      * serdev consumer device, not the controller. So acquire it with=
 the
> > +      * non-devres pwrseq_get() and release it via a devres action bou=
nd to
> > +      * &serdev->dev instead of using devm_pwrseq_get(&serdev->ctrl->d=
ev).
> > +      */
> > +     pwrseq =3D pwrseq_get(&serdev->ctrl->dev, "uart");
> > +     if (IS_ERR(pwrseq))
> > +             return PTR_ERR(pwrseq);
> > [..]
>
> So this returns EPROBE_DEFER and bluetooth gets deferred forever :(
>
> ~val
>
