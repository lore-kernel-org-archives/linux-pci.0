Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5242DFE1
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212778; cv=pass; b=hc5pgxT9VBhLL3xqtmZl4IdeaH+kJGgOHhCRsQQYW66v1+gHLrUpwCkZicOcL0PIp56GE0E33c+Fpxql6ZrvzwuhdBNR1sDV0Waie8T2/OLC/C6oEXnfgUYYhf0bARxk4BCwcf/OSOQs8xKXN2EoaQUqDGHZQgXmwES2n9aUJ1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212778; c=relaxed/simple;
	bh=MI5SUop3+QY0mD89Z+NyEFaZyPBX7OVxFq+lelU0rmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0TZ1GgzQ9S4MZkXbpRYqYxBwShwIPr/Dy1jFnWo7+MtbohAA521nzjbGrV8GPgXq0FDAjOqGokgGz2Ht1CTRd4DTx1g9zvj7CBqfCwiW4um14uWakqdUnEHV/QbLXFGzcrVpS28tMRdROMdvIf7O9scW8RtKX49/MFh6vzwcjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GrYVGtIs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HHY3Y+Ig; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GrYVGtIs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HHY3Y+Ig"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJrmT2838003
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RRl03IZjAsNYxIotHn02N0jSTatIJUrV+AH8wvleql4=; b=GrYVGtIsEvyHOqUY
	SwwpHeeh58Trt0BLl2cmMf8OcwjeRFizAlSnU8lO47FCZz5guK9Gjmv63cFibOm0
	/A/U9b/crN8trnkvduFeT8nVvMmMwRROyNhHpPXTA+470TLMMt4I6huFkpuIjijl
	HXcMJlp5vT7myl2E/zaae9UKWmzFfbdkqjAb8EO/P3Tzu7xPYgFvk8XVi2QFNZX6
	dyV3cYUsqwGRUASU+TVKsAn0PcGEQaj50DiYR1qj8RZwHEEGuc+ocyHHTlxehjHr
	oVObvRbREPKL9opKhDfLXYnmKJpndQffSHtg3ybXabuW7hf4uJb8Jvh3oYLaPV6S
	Evwzag==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqmec8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:39:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ee2847cbd4so100445816d6.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 07:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784212774; cv=none;
        d=google.com; s=arc-20260327;
        b=DaviTajlIXDt/aHAlzHhwiGZipa9609szd7QSnv27haDmWxYaFKhSpn4633wfsrDM9
         /M2cfZEX2fNvjOBBgigBLh6uFVL982QdN0jzReh4IVVSeMC8RTYamfWFyd8rKuDx6EnT
         9KrrD16C3ZhIFiCxgeyyLEeZj0RjTm9DZ7/frqf028Kr2M5IioevQ5Tb7akgPgAJqjxX
         60REIJMTg1XrAywtAn3UOmTGvi6VbpNUMXW2qbp0QKWmlDGepAD0RkzTT/BrkY+P8OtQ
         GeZ0gxnFRBjKRC1CywQuU5OxPSp4Nu9CIOq7urSZcwYszjUJ9K3jvfyjsn6dutc23KlM
         1Asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RRl03IZjAsNYxIotHn02N0jSTatIJUrV+AH8wvleql4=;
        fh=gmY+Qb8oyeu8u4DI0dSrBHClndanbPQZyJLp8pwhiqc=;
        b=IoqSAXdVi9f4CrtoRObzMVhZBJNjKaJl5in9zPvkdJD+e3ixfLt7kOt7YF1YwYlRC0
         zBmDOVuf2us0vOdFncspBp8dQYGUYgNr6FaPKqjAJO079ZUXv5tnG1ShogB+rutBgz/C
         FfleAD8QZ9lzExnj0VZnQsmaZ8ST2m69+UCMGlDDhxyXjSTb5Ga+f+t6xooHykSMzNz/
         0V3AHF/N79TvaN/6IU2s0oPEFXa4FlIKKaNNLMmtyGxZ/nUraD66Jy8AU29xDW6aWmBx
         ZWtBsrlQ3SaPBKvoRZgGFGQm6jOAZ9ElgCqIStpZs0+BewrsHNEpA4WmCVLtNTrzabYl
         brJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784212774; x=1784817574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RRl03IZjAsNYxIotHn02N0jSTatIJUrV+AH8wvleql4=;
        b=HHY3Y+Ig08KPXaabyHzSafO1EZulB1jSwXhR+kF+Hcb8c2YFl3RaKuEZQtNlBacuaw
         RJKupGgJ/XtjzjTc36xkA5RWraR/wESXuodm8/rY73w0Rb44AKCIsqOFt1IzS7++zv2g
         9HbkpJJ+1EmFeupXQAd23oMyXuuOKtYVsc7f1CLwZ+hV9DK1r/3zMolUrKvVmIIuAW23
         i3+88r1dmt4uTCZB26eszNbMJ4QK0mHrYViYthwEAG8qWM3H3FZgdC7Z+HgJKt/QfPWe
         5F050feudGxvOVj7AF8tgSq4b34+tBAqOVqUg1WSeh4Q+RXkuMFnc/g5wJopYeLyatMJ
         q6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212774; x=1784817574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRl03IZjAsNYxIotHn02N0jSTatIJUrV+AH8wvleql4=;
        b=jMo32uW0S8hq7gKdOI+9LncStrrLWgtJUmM4kPPXP1JqMUIxeuXUHIe55yMqhCNls4
         T0QG+R/GkX4CLS4W7S2WIKM4Pj7CAHWtG9NLVEGAQtXyrPnqUmJV9Z0OCHL6R+9ATGBh
         8oWE9DrlUvLEjmTv+NNSlKOg5K1XkMlP7nHA3VTUsRHtT6PQjXlj++jPbV6Xkc4tFuwO
         E82Kzs7x4h/wL4ISf/+9lM/sHn3ws1OJmXw3rOM161uIIiwuEQ24JjwObVjJH4r/J9F1
         HiCZVzYSCaso9dmB0K+9hPxyOzcqeVLklG3neEYO8NrN8qlt6D78sYJ8sllIrO79yVPc
         WYxw==
X-Forwarded-Encrypted: i=1; AHgh+RqG3MSiCB5WiLLTsxDBQ7JjwRWq+bgbKMHB4LkG1PUHuAtNiIwJNa5LWaiG4g+psvx67BmlII7EsFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZ0NkXSDglOPKvAP+WPP641xWabeonKoBh93VZdD2E3XrrvsR
	dZMNK+zeHeS5OiAvzUQRrZaRg4JGUUboZUCUMMGGUcnybzG4AbnszrylyAAbCwiyXnpZfVXYARf
	MM2q3i9O690zlzTI0SxIRqP0Tu651vdLRDDNIpBqmEhfEkSSVwb/HEeiryqO1iMm/kHSMbN6Vgg
	5lDrxD3pLV0yixbBuLVN9NGg+DVBbi461YZ+4m6g==
X-Gm-Gg: AfdE7ckVpi6FFQSMu+ilMndrWcSG2CQJkNIeO8AAGOZwiRFb+EslXiMrmIB0weRkjTV
	jyjPPEO4wfKf+Ds3tXHj9Bp5Nz8mEXD+Y/C5m7cX7PuZjSxeYNuxt9tuUl1XfvpeGMu6YcEUNur
	3F1QCRRa/4BcGu3m8pzsnpLXaiiukCV89XMcXn93H2fAW42hVzzNdBJffHi7K6J+4pKRcOP5gzj
	K84obR+A5/YmXEGKPCttpfwKu0fTPMalj9piNz7MB0CaQ9Tukp/icJCXPTadQjbRFKGcIzGiIyu
X-Received: by 2002:a05:6214:1c43:b0:8f1:c359:43cf with SMTP id 6a1803df08f44-9074c827546mr132528636d6.39.1784212774229;
        Thu, 16 Jul 2026 07:39:34 -0700 (PDT)
X-Received: by 2002:a05:6214:1c43:b0:8f1:c359:43cf with SMTP id
 6a1803df08f44-9074c827546mr132528196d6.39.1784212773660; Thu, 16 Jul 2026
 07:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-3-46253587af64@oss.qualcomm.com>
 <CAMRc=MckiTUBCF+UvmFi-ceLpjWW71LXTTHDiY+s5Qn7NCbD6Q@mail.gmail.com> <di2rdanp4hgmflhcrenjbohr3rzzmk6v7m3w7tjffe3it2mjla@46vkm2qat27c>
In-Reply-To: <di2rdanp4hgmflhcrenjbohr3rzzmk6v7m3w7tjffe3it2mjla@46vkm2qat27c>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 16:39:22 +0200
X-Gm-Features: AUfX_mxGOq4GAd5hXTX54KiGy8KRki9Hj7QmS8oktY8QY3gnpg6uCPZO4R8AD1w
Message-ID: <CAFEp6-2CEN4pe8Nv+TWn=s4NbP_zmbSdX98Q7CT4OQtt40MWEA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] power: sequencing: Add pwrseq_power_is_controllable()
 API
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58ed27 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=uEaeBTmxnCVX52V7pUoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfXxibthUgOGJMp
 zrtjhP0+3AvmVa+rKo3ZdBxKE4M2tlkBe7sMtkMn7GpKYieqvyMUxcf89c9iqLPf9Huelr7ZpEi
 N/ACy8SzQtmpmZ0acNS9u2RFSeWplt0=
X-Proofpoint-ORIG-GUID: -8HjCqJuu9dbQ7JkVw3Z9iPyWPuEyheO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfX8TZ9zTDRkliX
 bvHIhj6gVdjr0YZzviR6DCRa17aofkkmEelhR9Xe36607MB5Ljo/vJVoOiZe2SVDm4fK94nK5Pr
 HBugr5bhbf/Y4cHxMXGQzxub8QhZsTePXlZk2/FeD1O92PwCQmyMzBvQpdDIt15OSI5xEAHyzR0
 E5RZmqnGTRfKnfcdPAerZ7ZpsM34hnXnl//p7VHIOWNy/8tCJofTRH1dTHfZ2/9/q7kqvUzbsoq
 eGTuMXsAzWgK2PyHRhK57rr8/m0bUY28JqVFmsamYe4zIAb4wQOxR1MuCRh1kQGM2DHwZBN26Aw
 9JAtVqkqynCp/yICCWXNGAdqLA0VcSoTrP/rKW4c69pRyMKhYiUyFY1JaC47voSqwxzLzqV0WK8
 t+vsM0vNgWlPH6ZTFzSp1rNcYT75fulBWnzITXBNdO2wwdjQQ4m/QiFE896w/s21DpMUvDt1L58
 f10rLCRfzMb2lNlTOPA==
X-Proofpoint-GUID: -8HjCqJuu9dbQ7JkVw3Z9iPyWPuEyheO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160150

On Thu, Jul 16, 2026 at 4:22=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jul 10, 2026 at 06:13:55AM -0700, Bartosz Golaszewski wrote:
> > On Fri, 10 Jul 2026 11:57:29 +0200, Loic Poulain
> > <loic.poulain@oss.qualcomm.com> said:
> > > On some boards a power sequencing target has no host-controllable ena=
ble
> > > for its function, for instance when the enable line is not wired up t=
o a
> > > GPIO and is hardwired to an always-on level. The pcie-m2 "uart" targe=
t is
> > > one such example: when the M.2 connector does not route the W_DISABLE=
2#
> > > signal to a host GPIO, its enable/disable are no-ops and the host can=
not
> > > gate the Bluetooth function at all or exclusively.
> > >
> > > Add a generic pwrseq_power_is_controllable() helper. It reports wheth=
er the
> > > target's final unit provides a host-controllable dedicated power actu=
ator.
> > > The unit can implement a new optional per-unit is_controllable() call=
back,
> > > reporting whether that actuator is effective on this instance (for ex=
ample
> > > depending on GPIO presence). If the unit does not provide the callbac=
k, it
> > > is assumed to be controllable.
> > >
> > > Note this only describes the target's own enable actuator. It does no=
t
> > > imply that a power-off reaches an electrical OFF state as a target ma=
y
> > > have multiple consumers. Also, this does not restrict consumers from
> > > calling pwrseq_power_off() either, which remains valid to drop a vote
> > > on shared unit resources/dependencies.
> > >
> >
> > Thanks. In general it looks good, though I would extend the last paragr=
aph by
> > mentioning that the fact that the target's final unit doesn't guarantee=
 power
> > control for the host, doesn't mean that the power is not controlled for=
 its
> > dependencies. This is what you basically said but it may not be clear t=
o
> > someone new to this API what a "vote on shared unit resources" exactly =
means.
> >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> > >  drivers/power/sequencing/core.c | 39 +++++++++++++++++++++++++++++++=
++++++++
> > >  include/linux/pwrseq/consumer.h |  7 +++++++
> > >  include/linux/pwrseq/provider.h |  9 +++++++++
> > >  3 files changed, 55 insertions(+)
> > >
> > > diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequenci=
ng/core.c
> > > index 02f42da915985339d3de507fc36dd158b0035a99..35df55312a71e9dfd3f24=
a8199b539746466af36 100644
> > > --- a/drivers/power/sequencing/core.c
> > > +++ b/drivers/power/sequencing/core.c
> > > @@ -72,6 +72,8 @@ static DECLARE_RWSEM(pwrseq_sem);
> > >   *          this unit.
> > >   * @disable: Callback running the part of the power-off sequence pro=
vided
> > >   *           by this unit.
> > > + * @is_controllable: Optional callback reporting whether this unit's
> > > + *                   enable/disable actually control power.
> > >   * @enable_count: Current number of users that enabled this unit. Ma=
y be the
> > >   *                consumer of the power sequencer or other units tha=
t depend
> > >   *                on this one.
> > > @@ -83,6 +85,7 @@ struct pwrseq_unit {
> > >     struct list_head deps;
> > >     pwrseq_power_state_func enable;
> > >     pwrseq_power_state_func disable;
> > > +   pwrseq_is_controllable_func is_controllable;
> >
> > Is there any reason not to put it in struct pwrseq_target? That would a=
void
> > needless duplication of NULL pointers across all units, right?
> >
> > >     unsigned int enable_count;
> > >  };
> > >
> > > @@ -104,6 +107,7 @@ static struct pwrseq_unit *pwrseq_unit_new(const =
struct pwrseq_unit_data *data)
> > >     INIT_LIST_HEAD(&unit->deps);
> > >     unit->enable =3D data->enable;
> > >     unit->disable =3D data->disable;
> > > +   unit->is_controllable =3D data->is_controllable;
> > >
> > >     return unit;
> > >  }
> > > @@ -991,6 +995,41 @@ struct device *pwrseq_to_device(struct pwrseq_de=
sc *desc)
> > >  }
> > >  EXPORT_SYMBOL_GPL(pwrseq_to_device);
> > >
> > > +/**
> > > + * pwrseq_power_is_controllable() - Check whether the target provide=
s a
> > > + *                                  host-controllable power actuator=
.
> > > + * @desc: Descriptor referencing the power sequencer.
> > > + *
> > > + * Some power sequencing targets provide no host-controllable enable=
 for their
> > > + * function on a given board, for instance when the enable line is n=
ot wired up
> > > + * and is instead hardwired to an always-on level. For such targets =
a call to
> > > + * pwrseq_power_off() is still allowed, so that the consumer can dro=
p its vote
> > > + * on the (possibly shared) resources, but the host cannot gate the =
function
> > > + * on its own.
> > > + *
> > > + * Returns:
> > > + * True if the target provides a host-controllable power actuator, f=
alse
> > > + * otherwise. Also returns false if @desc is NULL.
> > > + */
> > > +bool pwrseq_power_is_controllable(struct pwrseq_desc *desc)
> >
> > I think, we should call it simply pwrseq_is_controllable(). I was think=
ing
> > about pwrseq_target_is_controllable() but it's redundant: a pwrseq hand=
le is
> > already associated with a concrete target. When you say "power" it sugg=
ests
> > a concrete thing that's "controllable" but it may be a ragulator, it ma=
y be
> > a GPIO or reset. I'd just go with pwrseq_is_controllable().
> >
>
> But what does pwrseq_is_controllable() mean to the clients? What is
> controllable? pwrseq itself is controllable? If so, then what does
> pwrseq_power_{on/off} provide?
>
> pwrseq_power_is_controllable() also suffers from the same ambiguity. The =
goal
> of this API is to tell the clients whether a specific GPIO or some signal=
 is
> available that enables/disables the radio on the device. But that is not =
same as
> controlling power to the sequencer, which is controlled by the regulator.

By "controllable" it means: can the host toggle this target's own
power by itself to gate the function? Or is it out of the host's
direct control, which doesn't imply pwrseq_power_off() has no
'influence' on the power state.

> But TBH, I don't have any suggestion for the generic API name :/

Well, unless we come up with a better description/naming, I'll stick
with Bartosz's proposed name for now, and we can revisit the naming
later if a better one comes up.

Regards,
Loic
