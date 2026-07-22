Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22934A794
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784729023; cv=pass; b=Vn8vs9QUHCz5mr0wEwFc9pHW7Ymr8dE+n7xfBGAu5hQuFNBlOlF6WjFcJ8eta/+gAdFrX4aNoDOvuITfFukILNS3JO1LoGJjPdOL3eGjY0btibI+hUva2oUf2DrG+MPSXn3lC+rbVvLnErh/z2c0oOXlt2woUfhU3+z6s2BgH9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784729023; c=relaxed/simple;
	bh=9BXUcoy3CAeMSxcvCAPOfPkEc4i39QOOqpzCKSbVSoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR4tyBts77od6cRN3MmAsKkdSZvrjaRjCqfklPO1KT5CQ467DelBnd4FBTdUnLzqs/ie5hPh2jYGKPnYTfPdADAwaXjIyOJwaRzXtfcjZ5Luc08Uz+Id7jiwiRFVbXFHnr1SYdGHCxTe4shH2wB7C+tGpzmKqeywj9DSHp1yYrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dYm9xBcG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+EiTHEq; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYm9xBcG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+EiTHEq"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MDWOF92029976
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 14:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=; b=dYm9xBcG8kVwxrky
	/bur/aKqjVfS0RYCmkdMA92gzwoWHtMB3+dfmWF+0449iVJo6Xzt9+OPidVPjQwR
	qlOQeL1+aD7HFoOYHVZyHd7hBddQ2rCN+q7Kt1qcXMrd8JCH575c4AOpqrPv4W64
	+55Wxx5YEYiccsjZPZY8jUh43n/nPAR5HzVnmP1Lsv2rm5zHKem2qAjSGZXFxGgB
	3m44lcZ8bLTTt48tdRhi5Cg0tiNh6hIvh3W8fxtn5BzbcWdq06cxx22SOtorBN+c
	dd1EH/t3dHT95y5qhRVQ1FcTwQDJs/485WRooEDavLzNJlFwGnWI1pfqrb6dF1GQ
	nyu6kQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr839x8u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 14:03:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e53b8a302so2041362585a.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 07:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784729020; cv=none;
        d=google.com; s=arc-20260327;
        b=l7Yyn2o1hoqBNHtQgZYp8HeDmIQqFki2LMzvOtlNH7yfE0RC/xIGb6pKCZm5C1leZp
         5oUdQC9NSmwi6ZKCCapAhiv1CwoBh9GRSj5LKKAzXvl5PGI77OhTIbnoH+vjm+MFZGEY
         aV6m49bkaP+mcknBd+/8b90KPheOZo0mMoHjkDRn9Bah+n61sw4JOUh3KIVzrvdXN+xo
         xVrK5YnPZGNhhgUOY+HUWbk4pVwLpmj54KwO5ijDXpoDDEI62K86STRcGpB7LDxVUTw5
         ow4s7eIFVMbf16I/eVksYOWxC2bEtWGBwz5O9Qowk8Y55kTcQXL0wL+RFl082HN/f3yF
         5taQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        fh=br+sHN3dmaz5qGG0lofV2svvOs6JvqGw57Fb4Dowyy8=;
        b=HJjo63BmvyUb6AeFwcNBmMgsBCXugem77F4MH4ZlAjMkuX1Q+Y0bocntr3ZD6gj39g
         BBJIKTGTAVwYHabJxx/b5GrmHypuppYOA1xXjMm4fAfPPEgONFa4vdSC/cvFFN5O6VAJ
         pvbSKJYYgplKyXossf5CoMlsWnC+ilwKO1GwKMx+wuN0T02zaxAI2cGAPBbcEZuM1Cly
         G0T03Kn5f4n1jd9SS5JgLBMA4EmygmIiDRF9SKW+yfwQB6UZPy1uKaYTCStvlapFn3Fz
         1yyzCYZZK0FkPp6TbCJ+WVGgi8nrHBsewabCU07nGAFz7VLX2M1He60fenGwFHasaNod
         NDPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784729020; x=1785333820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        b=K+EiTHEq4bGq7B7wQS2xXTUsD2Rziwlc9qlY3WyQvkUfo+C1Crki3AmQZXcb2NB08X
         ANh76zXyUEv+6N7WC3umVwG8TpUlyBxQt4bGmt4l2E6QzJTdTKfyxiHRxjoyBi2/dJQJ
         g0eE2c+L6k0/Yo2xJrqn2mUmORUorktWR2eUCulwODL1ERiYNGga99DTSP94f0eCopCj
         OCUdQDBPHVhPfO600Hbvcy3Iq2CJafpxl4XMgQJk4BkPxknJ0serTF+m9Tu04INsWHdN
         M6zk6cNCSwf8nxKjtdJhI69XA40gas3Orfvsiygxjac0W78iyA30D8zza8SMq+vRW39/
         tjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784729020; x=1785333820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRFQr63ZSylPso/HNP+U2b8fPiMqqyDzBwofu8YbHAM=;
        b=HIKQ3K7B+v9t4yT35BHR9L+MhA+pZYWClhCwoCtt06nMEaOlwzxZjWYJ8Gd/Mu2jaJ
         XRU1MeEuA081UJ2lgJunuTUSSdXqwmykEc/eMi7nSSJeh2nEiikWap2YN8dFeDrrwC9P
         PHAk1pfQwQmFV32NKgWpsAnIG0HqKng86okYvISATh8Tz9BQBJjO+ARCQ9QUnIEjH8n8
         56QsQfxM+S4xKXLaH9vzlXOCpdHkpVMckHwCbx9tOVexGnNbbwIxx6+s6EAUF2Z6pVbS
         6/Wr4Bv28/cNIleZoiZGg1b72YJXlyl5Em2eyGlniDSzDBF2i3VY1+fKJvJufoQibmT0
         Rwpg==
X-Forwarded-Encrypted: i=1; AHgh+Rrfcpx70Gxrl5N+lIKzZEMrnE87Eh8iphKBC+Lbg9DMLmkl3TFg5i92/Zwmk2MZOQbE5Rg7w4mCxEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzziUC6PjfngvCOu7uirVygZ4wMson6BGiljgYlWCazUFA/IPJP
	ClFvD0Z4OCH7XtNrMYA1n2S5+9HaiwnNP+5wfWMK4ezxinKQj5e9iZ6c+07U2bDq9wilMWC2uEZ
	b43OCbaHgAe7s+6MVPd3xTQPlS5K05h3NGZ8oH58BKxZNEu7ebm1nHfBgSZ4KGQ7Mg6w40/4xEm
	9M4PZsq5boS3p6I/GrO1y2uKLk+xqcvzSFBTmQmg==
X-Gm-Gg: AR+sD11Kvx7kb0DZCQmevxLJH+17eR1+r1XPzDbcB9f+Ju8BZq1UUl2RrhKCAZUUmgT
	IavLRZycc+nQx8Cs9HrLJlgiTZwiDQgM1Ck+38Du8zIUnIB5eDaUHFj4n+J0cS5SQfmeVwt6obB
	BWeSyPjV1kdz1bum2pl1TpX495o9GNJsTpb4AfBRUQbau2Xtp+3Db5Du9S1Vm9JzyWmWOtY2m9N
	WX2W9tb4IUvmsh/DnTsgAvYAx9OmBAOuCj0rV4FRWqOKMRy8NvlY6NyTR2Z9MyIdIGiY0yQ1ZE=
X-Received: by 2002:a05:620a:4514:b0:915:a953:4b9c with SMTP id af79cd13be357-930b3e9c3d7mr2246943885a.3.1784729020167;
        Wed, 22 Jul 2026 07:03:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4514:b0:915:a953:4b9c with SMTP id
 af79cd13be357-930b3e9c3d7mr2246936485a.3.1784729019587; Wed, 22 Jul 2026
 07:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
 <20260720-monza-wireless-v5-7-69ec6743543c@oss.qualcomm.com> <oha2k2z4gts52xjrmjsquqbhikbyfrequxuuwpqx4pjcdiwuqj@3u3wvmkeivkp>
In-Reply-To: <oha2k2z4gts52xjrmjsquqbhikbyfrequxuuwpqx4pjcdiwuqj@3u3wvmkeivkp>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 16:03:28 +0200
X-Gm-Features: AUfX_mzfczekzqEbUNlANz527n61RHWYJ2fg8CBXx6C2Qs9MbAYmlEYmPQ31HQs
Message-ID: <CAFEp6-2_ah4D2ZvkvwN2hYaJ9adYT7i3Rr9WPMLUXtzk984Htg@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
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
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: nPhzc_74uR4-nGTFq2LUDFSo3QRIzPcI
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a60cdbd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=Z-KoOJIlDxAInEDke3kA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: nPhzc_74uR4-nGTFq2LUDFSo3QRIzPcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX7kgVZnUubaU+
 mhpvZPzwIDYXzk1wQ503BDtFnX+qrYMcV6GwDS8cth0teUWNkJePyF8UVKSYkfd8sg6dA5sY4+w
 K0oPye29ye8rXHJPVnDGos1wvHYE+u+D+8pbdy5DtGpeY51RfR4Zg1DkkeeAbcFFcxNZpUKtVHL
 yGkraQNek7G+8iz2HhDhlKvTNUP4P+oPGmJ9p7Emd8cJ7IfAaO4s1Vev8/92Z28+vU40d+xjpnU
 fBMbwCidYjHpbOh8q/4+WmjQU+kiDufgl7lUqFHjVqB8VFNSONtG0EPt6OfZQjxUjDTNnYiRh+P
 6S/i0+ByikfkMTpssNiiaoWsKVgydTSg5sgycDKOVlbd7GmCl5W5SkLwUB1ibhj2Hfqe2NiZP8X
 Pvz53mM3WaCfE6L5AvWC+PdbKa4bsFUHkB3DWqrEMBAkpRQ0chmAPc9CarvACE0ThFK5U9hw6MK
 /1MVHUWvA3jYLoSQsUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzNyBTYWx0ZWRfX0PAqyRoWnJgt
 GpXlyvARWIzer/Rd3/ltBvqxMGuox2Q3JNXMl6LMOYHR9oeqgg0bsg+z/JBL0ERqRZykakWFYBL
 /HuSZtWX+FhU3ObL2TaDeVoBTrjrJws=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220137

On Wed, Jul 22, 2026 at 3:19=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Mon, Jul 20, 2026 at 10:04:09AM +0200, Loic Poulain wrote:
> > 'bt_power' is allocated dynamically only for a subset of SOC types, usi=
ng a
> > switch on the SOC type that mirrors the one that follows it. This is ab=
out
> > to become pointless as the power sequencer path (used by M.2 modules) i=
s
> > independent of the SOC type and needs 'bt_power' populated for any type=
.
> >
> > Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> > allocating it separately. This drops the extra allocation and its dedic=
ated
> > SOC-type switch, and removes the need for NULL checks on the pointer.
> >
> > No functional change intended.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++---------------------=
--------
> >  1 file changed, 26 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 81fa41915363ce577ad7c6f25fe1b0a69536d462..7e4cb03d3db0722e5f9fa2e=
7a5a9a0894bf4f18c 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -226,7 +226,7 @@ struct qca_serdev {
> >       struct gpio_desc *sw_ctrl;
> >       struct clk       *susclk;
> >       enum qca_btsoc_type btsoc_type;
> > -     struct qca_power *bt_power;
> > +     struct qca_power bt_power;
>
> Can we drop it completely, putting necessary fields directly to
> qca_serdev?

qca_power groups the power-related resources together which makes some
sense I think. I don't mind moving the fields into struct qca_serdev,
and that's a straightforward change, but I'd prefer to address that in
a follow-up cleanup rather than here, unless you see it as a
requirement for this series.

Regards,
Loic
