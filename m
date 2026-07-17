Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21042A7A4
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299516; cv=pass; b=r7crey6VcYoRoWvA1nnxCnV1trQM5a7XEMsslSLJ9op8yRyFJkp4TPJoTsqxv8oWeGAigGATDTolZ4lvhT1nLPPpQD3kjv5dxY3ZTOdkD3ZCXZaLUFxF4KJjfBHZ6SlAn62xvl3JY4FrTR0zFPFGNLI7+5gi9XQM61aZc9pTYGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299516; c=relaxed/simple;
	bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6sIXdN94ALJejmUFKt+SjgmkMdDeAWCuwPDUYOOzW8aUmbOqKMWQHwKzoqTbf2vHv+jTjMAb3+9JbAigfuyEWokqGghCLMxqPPfF83nRkf2pDAEcbrN0NEnQgygRDWCpgLOmV+k55qrVkpicj/l8FidNRKVJMKsE0wXrewjaf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LgURRFqr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D68BI3dv; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LgURRFqr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D68BI3dv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7glj3123293
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 14:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=; b=LgURRFqrlyVMT+rN
	DOONXjUOuinpRQGIpUDcZfiDuF0qiWwRCHIJMhp4rmAHIIm+LPtl/yHwWBfv0OGv
	4ubsLPL/cMwo4MeQny3CEs/OfKd6V3c3H8dHjWXXTAJSK4w3v5oNLS6B1T0AjjRH
	hehaqU+4YcUg2NEh4TD2fLrzEItb9woYQ2O4cRddbgFJRhioqfE1WBY5buPNd0KC
	s24Vppribf8S2/UxeDXp8C4EwtkL6jfglBPs8yhrwysfm0wgJFYOT/CtR3+h6iv/
	XzOo9yOHLMjkkdIOKotPJfbrlMKPc/N0aZJAb44l8ptFUuxXIEjQPxPu9Kxw4d7B
	jmgf/Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6m7dw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 14:45:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e82060977so400337685a.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 07:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784299514; cv=none;
        d=google.com; s=arc-20260327;
        b=MuweUI21PZh65tJNytZj9DBSs6a6RTzwIzysKdsaIyr0bLmaQOvSJpUTibJTxf4lGG
         zcPgXGZvd9qOcdbEW7/5S4WtRqMLEVB5y0FsB8XLUVMM8icqXNfuBphPRPJuWwgGMxK5
         iqwZZtYwx0YHwXPKFXqjwr7ZuzpFTR5xDmzK8Ri1oX7li+P8umTTIeu/0GH77uT8DDoM
         vBE8bMSTsDTcoBJfEGYzurPcpBXkyMDaee4+Ts59FYUgLaVku3KIoCCei10iXDdRpe0Y
         Qdu+876iHvA2eHT2qNJAZLtrG9iIvI4Kl7RR6gEFJpX5cc5p5awht4M4sAqUpSYlIF7I
         Ig2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        fh=RiO8ZCfyFZnhBnYAKrXYs8dLlacf+jcbGjRHhDV0g5s=;
        b=HbEK4DF1qIfusV8D1JA8A/wZEYM63gCwl7KODMtzaopkkgJShmP/mK86LMSd3Ttly0
         wVhqRZ6evVP+Bed9SlT8qQLFzbpiZCDolBilD7jm989V9xjR5rAvJrcB5XlQHZX0X6Gj
         baYT3RG07V7inea8cwCXvsFOTvma6uJVTDBiGDmbIuQp8gMtFZdDJMuqbWqLA0KKzze1
         vYtER6XfaElm5itMn9RCw/hC4OyzLwq+AFRp18xLdaTxS97HsbPUQwVMLwzaH66/6eJN
         z1PZxkYly4Eg9FgvXQXa0gs3NORmjqluebs6ES8RsC12F/HGDX8iPnYLLl6UMpl4oIHq
         01sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299514; x=1784904314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        b=D68BI3dvWRmdAIR65e0X57xipBxSsWd3Hv4hH7Bof1XPMbWMtpV+ZYyptldiIWUX8y
         L+z2NQhVRwPPdiSzGenL0eSf+FGDN96uO06Rf5ZilDVGyxE09AYa5mWjPRytTByLnu58
         GlIXSk5DzFjA+tFtTjA1Hk7OVPRR0m1RqZBYXkadKTvHAu+Yedxozn/EtAAJyv4X4Pst
         Zga66iXSBuGTxAfAktmnF/1Ssb3oMJ8/bq7Gvz5TVJQV1HIYy32GL1R5TvQc4Cddi/DM
         Xb90bmlJoc8Rh4hz2kdO5MoilXFf/WkA9jYM+Mo193bWXV6Ar5gbyyhKfpbUFJ+hH56k
         9PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299514; x=1784904314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNzsOpMvx2fOI919kTiNEIxpFwaZQjVvzDd/rPsGLQc=;
        b=kLMJdBrTHD80lHiGnafhc8MqT5qIVM3VI3jJ0n8OxesBhGXFAAF3AjHYgPgnMPilzQ
         opMXmexf4FgEXWxxm8KeSjDkjwu0zgFLn8CpRrHUysA1cEt7LsHijLZraT/eVE3xK0bU
         lD2+FQ8MPUk0KdWKobPRPRfVSd8rhuBXR1GegAq+wOJz2ttAFPDrYyHq21o5QcKpAb2X
         oj5HrmeQ+ezKfolbsf7Vx/59vTJcs/yCFnIE5pg7t3cr4HxgtQDIs6n0hQTClD7V8EQp
         77fQM8f/5BNhBB75qupT65gvqul2tUV5M/WtPZBH6WfAlLijZiPjzoK6pgYAhyZY3GAM
         Gy3Q==
X-Gm-Message-State: AOJu0YxbHYnVt6nx0IkWC/SsCCwI4VaKbYCqj2GfJqVRPpXBmc0c5DML
	s9oG4jBdrgRIGrkiW6oUcXFLL5sGBK8himj8eFXDDkdf+fSBt7yZkChfHThQdFVtjrd1IpF5NjW
	0TVWgTr9AahyuPTXy9wce0JNWW8Wlje8iht5YmU/CS3PZHFMw7a0rKtcCuK0QL2Pjwg3Ghp9tVV
	MABtPMLxeaP2rw9m3t+M81Xnoi1O8/D4pi4gl38w==
X-Gm-Gg: AfdE7ckoXEMriCyto53LOp/E0+Nr53ihbHFU+PrtKkL447gGAhIbq9YdOCHFwYVQilC
	D/Rj2XJR7DiO7bJ2n18UmVd3zxnvPEfVtLNLfJZPoDDwqsiB8Pog0s1rP5Y3nkhs4/m39Hxp2f3
	cTZJhL5QWtywOMqjYrkrA1m6E1PNU6rdtgxTjjiMxx/IoqHdZpxzzQoZqXD1RAoEREr/oiDEMBv
	UZZZfLy3mklE6Ln2bvjgdUshFNM4QT6+WvLWWI9unom43RRbQKy5gdgPtjDdp4w2NIs6zgTq1MA
X-Received: by 2002:a05:620a:6914:b0:927:efb0:3ad1 with SMTP id af79cd13be357-930b4929a49mr284921085a.26.1784299513661;
        Fri, 17 Jul 2026 07:45:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6914:b0:927:efb0:3ad1 with SMTP id
 af79cd13be357-930b4929a49mr284915985a.26.1784299513132; Fri, 17 Jul 2026
 07:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
 <20260716-monza-wireless-v4-3-9b02e6f549d7@oss.qualcomm.com> <CAMRc=Md8mLgYRsLd-KhwVV8X9AcYbHf--RB_pf0xFBP_P_DvCQ@mail.gmail.com>
In-Reply-To: <CAMRc=Md8mLgYRsLd-KhwVV8X9AcYbHf--RB_pf0xFBP_P_DvCQ@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 16:45:00 +0200
X-Gm-Features: AUfX_mxmtgHrdkc082wiMIxBxijXxJxzFJEhJ2gZz60O6dCpV0Wr6tzd5_cVl7k
Message-ID: <CAFEp6-2pbYXFTuozcg51+dQ_mKin05o-GqThyJLBjquFs91RQg@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] power: sequencing: Add pwrseq_is_controllable() API
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX1nG5K23QmINf
 2Vk8PGRnUBzdjIRW2AteRvIHpN33kxG33/r/kBjq1PXvfFdrY7hisSzryOM8DWMUlKHVJcM2sDt
 xpzVX4cKrwHG3B74jue/sC7qb9kr8agFWFiZIzeYcNuOTTGCZKbSzv9xtub5lGD6zeD1BszT3fx
 kyNJwrsQZ5vqhFPXB018DmcR6outfMZy1/qdLCv0cKwRNLGXj1P4/CUaOe3yAfhUAjglyt/D+Fw
 a297b5onCXYTBO4ju2KmyI5Q3usD5tDHyADI5kGP2dxDThyISt+/3DuHJYXNvQOpzgxQgF9uHOp
 FckB1ez38wGJiyxlB11P1B5P7/tguzSJPIkGCd9ZOj2/NAVuqQym9PL2BeeJU60N+j/N0QstXj2
 SuphoewQ/s5stakNn4m8HgSmcn9Rej8AvUukRHcRZY3xnPg5/gR09cyT6B3i0SCk8PLLoDFm/ND
 +c34VcuFoGHWH2EpJTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfXxNC79AL95uqY
 wbYdoHQiDMU1YgZcfJJ8foR5jAJMVkvLS+EutQk3C7X/NuYB06iP7T5QfrVKhovRalUp6M+MJeT
 OqwdsNOvqykEtSlOAI4Ot8BVoAu71H0=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a5a3ffa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LMDkYzAWLNq1XrXRUzQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Z6JLNqENkR2EgUvKfYFT7EdicXncYfFb
X-Proofpoint-ORIG-GUID: Z6JLNqENkR2EgUvKfYFT7EdicXncYfFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

Hi Bartosz,

On Fri, Jul 17, 2026 at 11:29=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Thu, 16 Jul 2026 18:18:20 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > On some boards a power sequencing target has no host-controllable enabl=
e
> > for its function, for instance when the enable line is not wired up to =
a
> > GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target =
is
> > one such example: when the M.2 connector does not route the W_DISABLE2#
> > signal to a host GPIO, its enable/disable are no-ops and the consumer
> > cannot gate the Bluetooth function at all or exclusively.
> >
> > Add a generic pwrseq_is_controllable() helper. It reports whether the
> > target's final unit provides a host-controllable dedicated power actuat=
or.
> > The target can implement a new optional is_controllable() callback,
> > reporting whether that actuator is effective on this target (for exampl=
e
> > depending on GPIO presence). If the target does not provide the callbac=
k,
> > it is assumed to be controllable.
> >
> > Note this only describes the target's own enable actuator. It does not
> > imply that a power-off reaches an electrical OFF state, since a target =
may
> > have multiple consumers. It also does not mean that power is uncontroll=
ed
> > for the target's dependencies: those may still be gated on their own. A=
nd
> > it does not restrict consumers from calling pwrseq_power_off() either,
> > which remains valid to drop this consumer's vote on the (possibly share=
d)
> > resources and dependencies of the target.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
>
> Thanks, this looks good to me now. This series is a bit all over the plac=
e,
> what is the merge strategy?

Since the entire series ultimately depends/touch on the pwrseq topic,
the simplest approach may be to take it all through your pwrseq
branch, with the possible exception of the DTS patches (through
Bjorn)?

Regards,
Loic
