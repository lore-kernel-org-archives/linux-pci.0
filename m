Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08EE38F251
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415666; cv=pass; b=YVRN/oVe1pxeoTjke5JIG17k/AsmKLG/xM38AuNoD3o/B/U4ZRryn41FzTTZ6YFwV4WkETWmxSA76yfjmQR+bmbLfApzwQ2hufWwEz3MfMfq5qXSz3gmqQPTSwuiq9Jaa5nupc2mb+Pa4I+/sfIHjWax/7TBhBDia9vWw5qFhh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415666; c=relaxed/simple;
	bh=tId6bX+sfVblETA9h7jW1T52GCPIi9+Oqbw/3POIA/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fl/UtEbXp+ikycydi16WMekzFDt0xf6XghzuB5kgJZ8LZARcgeLWuc+CQbLy+MkR/DunrutSsLM5hJYvRiSPTIbVjysG91P30PkxzGlML1IbdL6Xbqo6tHpepxL9p5/6Y348s1HPjUOEZnaf5lzbb5igfePnM5Nle6n2LPfOH/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k2CayWgQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bRQsKiBS; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k2CayWgQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bRQsKiBS"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6678E74i3004730
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 09:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pu/T3O5IFYIVcL/NKBgCksHrYTwl+ICEoKPHOSRHwDI=; b=k2CayWgQ9+eFsDZN
	dLJAaNE/s5IHgx3dicq5hpFCeEUpvXrRFa43+MSueA137TE5WdAt9yIPM1hHIv6W
	PYx/ScLFu4fQ4GAy5NV/NSeQ5ybHlBrMjxtd5OAlJRAy6svBwmZpjqaZKialOVOC
	OFDLQnj+0mIJKYU40Cp/j73wr6BmMzERSCC4k3kw+LJZoYpukHaoNXFcp73lVMHN
	jDByRKHPfOnsUpUh3t9nTBir8FYZinQ12/71lYvN2Qp7PICF1Y1TOzpadp+X7cdq
	vJET/n5FqtrqWGccj4jNDvCWv6YXJGJZ7jXk5yI8kq5iLsPAedV8MmoTQYDOpD1a
	1Y/IEA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su715uf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 09:14:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91ed0e140c5so728231385a.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 02:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783415662; cv=none;
        d=google.com; s=arc-20260327;
        b=eBnPKhaodbVpRNHp6AjyACCnhED8/vPcLaoepm3Z/B5l1a6x47KzNiRyr5GqoJXurX
         FHveszUpoiyx2H4177vzNaHVyUIWW3kfnXC2o7Art1lxTT8RVtdvc6xxnABq9eMalJbd
         PshEu5e41nGE3Td//R6c0+fog0EZou0IgwUcklGqxytERk3DS+qM+E3n6LJpNektmOcj
         UytxCuB3mMXlQmthNwtwaA2BIZvEMk77nKveknXvz6KspSpXjQ6y3p0Flcsr4oVf6i1b
         bEe1h3s/tgVJIajVephqIdxyZnPgq8io5zJ3/zQf9J83QDTi/DP4RdvCgBumYs6tRY+1
         MzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pu/T3O5IFYIVcL/NKBgCksHrYTwl+ICEoKPHOSRHwDI=;
        fh=M18a9vcB1ow2aSc3RDPyd1PFOdKT3hC5JOmXUh7KhlA=;
        b=Kb/ChbL9NLXvt6zlYlWGKkrrXS50Ap9Q1w3aoVAkMAap+P2/zOPZTfUsYOU5YcpMwB
         TukcTh3EaiKe93JDb62R5yt8O8JMaSwQ5IfFyFbHtWg+pNnko0cYMJci1+IAUMr5/UAm
         ohrekFWlSJJIhL16hfthnIOswlYP/GseLtl3FU9r6xUpdbHW0bL7onuTDHzvA62pECjr
         jbIiQpfa8kzzD5KqEFNE07LAwxoMG3GeYQ6Y9j4cuGLA8u9PfdmNKM1WpwCcJZ1o1Njr
         3aOIK+a/Bxqcojm0JgrutHxb51vR+7MWCH5PUyaizuN7x9Y7B3DPYXlwL/AKHee1bhf3
         iKtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783415662; x=1784020462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu/T3O5IFYIVcL/NKBgCksHrYTwl+ICEoKPHOSRHwDI=;
        b=bRQsKiBS5xGF01cbFrmL+CU9JHe1A0cM9jSj49rAB9mh8aLD7ZSSENZ+wRHojAs7Qu
         1fX4UDDoNScN9T1cTiXO87mOCjmiPKLI0vt/1vNszSnxbSVzWWzV3QKX80PBfuMmNJef
         8R2HYI4IKW9qNSgEuOxwV2wPXqZyDAbRApJEUwKnwlcXf91HSXWb+B6NeXXPzECQwBeI
         aNOKCUL00B/K9NeBWnL42AlKgPQTyXuNXzDR4Nr3ZBy/jKR0HUQK3J3lUHYI3cCcn/n0
         9KXi5zuiMiWRkNqfbaG0gInpQPlx5PX8l90BWh6u2khS0CqRRtxaFuoi7+H4toK3lTOU
         fDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415662; x=1784020462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pu/T3O5IFYIVcL/NKBgCksHrYTwl+ICEoKPHOSRHwDI=;
        b=AXKdRVMRaCmbUS6mV7/SMx4eaqxx7YMsV5cPnwQ4MgONpZBbTiePscFfIAWUWnwKiJ
         6H8/v1yKBLYVaAEZropltrRfcD60vAmXNPzJoII/dNxrde0A8vRPqFPRTNhnpFynGCkR
         mcB5G/SPQEqK/wg8XDtZPmLhLhR/LLDjy+CDIKWH/VJfUY5v5ORA4818mkI7HRjSU1aP
         /WGzB6vmlBGD1CuK01Flm9nJ8OHKcLBmW1MFfp3/IybOu/mE7g6F3kG29xN2e+c48xhW
         v28bKCqYJsVvLvS8jSxdojDnK3evYmUcNCQp6s1qvlTB9cdhBVBrE8KlrccUHY95xrin
         Sdcg==
X-Forwarded-Encrypted: i=1; AHgh+RpVk5L4u5bGIbkbqkx0nC8M1ODImWKkWbQMQtc2gbBjxLtOxA5tTMoP348mChS9UHJffVupVsbn+ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4AcIu0ZXGgAbM4XwQvPSQb+4OKiVvVXBiGp7/q9cFUJA6IG4n
	kAXi44GhE5MT24UOhL+Tk7wRaJS2QhuEayQeBBLwb7qw5A/1Xv+DyZExC5c2e5XL0J7FZw5EZyN
	h392v7GefZ/vhZf7pvI46q3yPuwTcs3YslelkePXDABrMVb/ZhR/aRcBzppJDw/tR8L9qnp8eVf
	CPEdT0WS5FIQNrGd/e2r6KZMSFL5G2BwT18jQVTQ==
X-Gm-Gg: AfdE7cnPqwy1HN9RamjafcGZzyforOQp1LWJXQ3J7emV6xd7WK1qS3OWACqg0g50sRu
	VhdO9MFPMhO99F7GLmmAvvH6RzU8S8G6vHFeN3nvar4oWAR3vxilMSsTR+hc2x4Mwhfgyu+0gLB
	k7rm0oDHnhugIWAz9yWO+OpwmY7MVTqO4u6W66fO1W3MK5j0xYpg74hcL4ZC7DyWYuv069hKBf8
	I8pCSKrFhrqy7kLfZIpVC25sJKQ/UjuKNnbHd8lHIqvYsjEDAUF1ksJYAE/r1YqW0D/I1/aGN4M
	P9+3iVVBUlo=
X-Received: by 2002:a05:620a:17ab:b0:92b:8c84:3e61 with SMTP id af79cd13be357-92ebb4b43aamr520579285a.3.1783415661793;
        Tue, 07 Jul 2026 02:14:21 -0700 (PDT)
X-Received: by 2002:a05:620a:17ab:b0:92b:8c84:3e61 with SMTP id
 af79cd13be357-92ebb4b43aamr520574385a.3.1783415661343; Tue, 07 Jul 2026
 02:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
 <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>
 <rxt4n6vuscu33mrw24af72lb3s6urqfpkhtia44yfo4j7wtu6o@3xp57owekrgj>
 <u5ieok3hgjcf74sxjdzv6xurmlbve46xa3imgfnom4hpjarmxa@fna5daqpyk3r>
 <zat6uuvh7jwfxajvqtif6d67osf6h5b2vxig3bmuch76btpdkj@bfxjj7kk5fjk>
 <ynhos7h4x3kbqbio2gkigoo5rqbwogrzihkylxv5pqjtqpqmnq@rlyjaiopx74a> <l4qycbmz2zaroe5rreuop4dx7ugfcx37hfaketvn43trdpaept@jyx65agqznq4>
In-Reply-To: <l4qycbmz2zaroe5rreuop4dx7ugfcx37hfaketvn43trdpaept@jyx65agqznq4>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:14:10 +0200
X-Gm-Features: AVVi8CduE2Nonq5P1YApvPwl-pxo6P4sEIM2US1PAw61u8B5ymQBuhJPdhfD7bE
Message-ID: <CAFEp6-0AA-hTy=3KaRNEJ+kF0otGLTGTujvWJqhT2dHDj94E4w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA4OSBTYWx0ZWRfXwX8ew3zylO/k
 tQ8IymxJ2HRkq+7qxQkFc5RWzOf7Xz9FwepbdG19U6cTiME/5pxvvMP7ZhKkfHzqSpM8k1GaKxh
 k5L5WZOuxhfczs61M69GFZxpZPS5ajeD8KB9+e4Kmpk9cq0pW6qeHeXZ1jlizIabxrNDRKgiZiU
 u2cxoybFdRLL546myHayRJLgMwhGF/hH4EjkDqyARR8Eg7xHI3K9MMjSPBfHhv+HdNuVym/EBoX
 fSILpkcwmLdcS2GTpsTeD0WAUR3uLaLaYDEYaRgdbulU3sjQ2OQGS/iDFLkVToIxD6JFKQWTjve
 PptLIDbRUE452UYDLz50NR2nui0m5Qyfn+US7Q0po5mZefEFmc1f7lRcY/PwRp8dfVytPKWto7U
 lY9tixYo2W6wgs8pX1Z5SOYLihd0AYJL+P4am0/pMd3BtG26tsij0ey1x7TFvVU7aKnj/9wrNNC
 vT2yMZR8Si96Uvtg6nw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA4OSBTYWx0ZWRfXyzFrNatEpvL0
 62BowUlLYTYr/T/G1GU6/RDfSyqK77T92nq5IUhjVlwXD5rVpcw68PADNnkgsJY7pnUFv1DXFnJ
 aD/w6pG5Z13UW8Of5oR1tjqPaLwwqiU=
X-Proofpoint-GUID: b34UGZig9wZHLFh7CoVjS1lGYiKcHG8w
X-Proofpoint-ORIG-GUID: b34UGZig9wZHLFh7CoVjS1lGYiKcHG8w
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cc36f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=CFFC92ghu-o7u9NOV88A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070089

On Mon, Jul 6, 2026 at 8:44=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Sat, Jul 04, 2026 at 03:11:13AM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jul 02, 2026 at 05:08:56PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, Jul 02, 2026 at 05:34:31PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Jul 02, 2026 at 04:17:43PM +0200, Manivannan Sadhasivam wro=
te:
> > > > > On Thu, Jul 02, 2026 at 03:14:49PM +0300, Dmitry Baryshkov wrote:
> > > > > > On Thu, Jul 02, 2026 at 12:46:15PM +0200, Loic Poulain wrote:
> > > > > > > For QCA2066 (and other QCA chips) on M.2 connectors, the UART=
 enable
> > > > > > > is controlled by the W_DISABLE2# signal managed by the pcie-m=
2 power
> > > > > > > sequencer rather than a dedicated BT enable GPIO.
> > > > > > >
> > > > > > > When the serdev controller has an OF graph (indicating it is =
connected
> > > > > > > to an M.2 connector), acquire the 'uart' pwrseq target from t=
he
> > > > > > > connector's power sequencer and use it to control BT power in=
stead of
> > > > > > > the bt-enable GPIO.
> > > > > > >
> > > > > > > Also allocate bt_power unconditionally for all SOC types sinc=
e the
> > > > > >
> > > > > > Can we just fold it into the main struct?
> > > > > >
> > > > > > > pwrseq path is independent of the SOC type switch.
> > > > > > >
> > > > > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >  drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++---=
------------------
> > > > > > >  1 file changed, 43 insertions(+), 38 deletions(-)
> > > > > > > @@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct =
qca_power *qca,
> > > > > > >     return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +/*
> > > > > > > + * Acquire the M.2 connector power sequencer.
> > > > > > > + *
> > > > > > > + * An OF graph link on the serdev controller is only present=
 when the BT
> > > > > > > + * device is attached through an M.2 Key E connector. In tha=
t case the UART
> > > > > > > + * enable (W_DISABLE2#) is driven by the pcie-m2 power seque=
ncer instead of a
> > > > > > > + * dedicated BT enable GPIO, so grab the "uart" pwrseq targe=
t from it.
> > > > > > > + *
> > > > > > > + * Returns 0 if no M.2 connector is present (nothing to do),=
 a negative errno
> > > > > > > + * on error, otherwise 0 with qcadev->bt_power->pwrseq popul=
ated.
> > > > > > > + */
> > > > > > > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcade=
v, bool *bt_en_available)
> > > > > > > +{
> > > > > > > +   struct serdev_device *serdev =3D qcadev->serdev_hu.serdev=
;
> > > > > > > +   struct device *dev;
> > > > > > > +
> > > > > > > +   if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev))=
)
> > > > > > > +           return 0;
> > > > > > > +
> > > > > > > +   qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&serdev->ctr=
l->dev, "uart");
> > > > > > > +   if (IS_ERR(qcadev->bt_power->pwrseq))
> > > > > > > +           return PTR_ERR(qcadev->bt_power->pwrseq);
> > > > > > > +
> > > > > > > +   dev =3D pwrseq_to_device(qcadev->bt_power->pwrseq);
> > > > > > > +   *bt_en_available =3D device_property_present(dev, "w-disa=
ble2-gpios");
> > > > > >
> > > > > > I think here you are looking into the exact details of the othe=
r of the
> > > > > > graph. There might be other devices on that side, while the cod=
e now
> > > > > > assumes M.2. Or, consider having an M.2 controller which handle=
s
> > > > > > W_DISABLE2# internally rather than through the GPIO.
> > > > > >
> > > > >
> > > > > This code only deals with M.2 connector in specific, so I'm not s=
ure why we need
> > > > > to worry about *other* kind of devices. Let's worry about them wh=
en they show up
> > > > > (with graph interface ofc).
> > > >
> > > > I don't think we want to go through the drivers using M.2 connector=
s in
> > > > such a case. In the end, the contract should be that there is a pow=
er
> > > > sequencer on the other side of the graph, but the specifics of the
> > > > connector should be abstracted out. Do you know, if in the x86 worl=
d the
> > > > W_DISABLE2# is a GPIO or is controleed by the hub.
> > > >
> > >
> > > I tried to abstract out, but Bartosz didn't want pwrctrl APIs to do t=
hat level
> > > of abstraction as pwrctrl APIs should be generic and should not be bi=
nd to a
> > > specific connector and exposing its internals.
> > >
> > > That's why we ended up having pwrctrl core exposing the 'struct dev' =
using
> > > pwrseq_to_device() and letting the consumer extracting whatever infor=
mation it
> > > needs.
> >
> > Do we have other ways to control M.2? For example on the x86 systems,
> > are those signals controlled via GPIOs (or GPIO-like registers) or are
> > they controlled separately by something like M.2 controller? Or do you
> > have an idea about other non-x86 systems?
> >
>
> Thre is no OS-visible M.2 power control in ACPI systems. ACPI defines PRx
> objects to control power to the PCI devices based on the D-state and the =
OS just
> evaluates the _ON/_OFF methods of the respective objects.
>
> So this API is not going to be useful on non-DT systems where the BT_EN G=
PIO
> handling is abstracted away. And also on platforms where BT_EN is not con=
trolled
> by GPIOs. But I haven't seen DT platforms handling BT_EN (or W_DISABLE2#)
> signal in a non-GPIO way.
>
> I too prefer an API to query whether the connector supports BT_EN or not,=
 but
> I'm not sure how to come up with a generic pwrseq API which also satisfie=
s the
> requirement. If you have any suggestions, please let me know!
>
> FWIW, I tried adding pwrseq_is_fixed() API [1] earlier, which was turned =
down by
> Bartosz.

So, I'll submit a new version incorporating Dmitry's request to fold
bt_power into the main structure.
However, what should we do about the powerseq point? Should we keep it as i=
t is?

Regards,
Loic
