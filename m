Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793270501;
	b=DCX2yspLY81gDpF2P2xl0DZCSmzpq1euQWos/3mbp0rc11Tw1AFRpL6H2JAJSAK29Lzz
	 x5vC4rDa3npjmr+p1wALVxkK73/nfzGeb0nM91hnyVzC3kNitTrmQwvB9tVffThQYp0eR
	 e3ITVo8oFaOrmok+uJuRKx6pDUkVp+cuZJ8P5C7EncoctYGGTgUbN0EOVR7ur/3WVLu8e
	 nTChVYcLv+xuoQZ++3qnaaf85f0ohb9f757TFH1bDXGtFCB9hnmZJWr/dpOverRvZCMk6
	 M6/yx3XJpI5iBZFJHKXG4MwdTCvRRnoHq7u0Q8eHFOTt7S+2U8tQ58p6yKA1c0z4eYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270501;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ThaS9L2WxGBV/+v02U6H4IYThEGoc9UFd91/APPVaNw=;
	b=HFhtUstbGm7gnzlzOKabILGxOvuHp0l+zE+4qBtrUSKELhLaVjnhMlqUDbI83rT33IHc
	 RZtlB+V46nbuqaeUkpVXiJuyR4YYLtoB2AzgGfIKW30+sGx8bAS3V/e3emXUaGuGLNtUX
	 P+s3MA12LOA+dTOWXvB18/9MMeJ+1j43FSyMFOkupPSBjFydEpNCVdkQ7boeIhuR/agBX
	 L2FCfmObOs7+jEQGaq6TGo0XBqLCskOvhkww5G0oNMdZm8r9rHK1uYujj83q9e+nFH1Py
	 diRKYwRgFGxCPExX+IAsPo3n4MHErMXWX1M+as77XSfdQCWPYV+QJOnugUalmSyeYgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Myn2m8EG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hqf4+1m7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF98606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 10:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF98606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Myn2m8EG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hqf4+1m7
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vEdP2912499
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 10:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ThaS9L2WxGBV/+v02U6H4IYThEGoc9UFd91/APPVaNw=; b=Myn2m8EGkFqQlWOl
	ppph9AkV6Uh35kNQRdqtE/fJ8QTBVUJbAvz4OYPS2kDD3D++gWxX9JEjHq5fXTPh
	jt8uDIXrx4TuAUEoMPiIKqmZ7t5ulBGj3lJVPixVKcQ562SIb7ho8bwgGW6Y3PaM
	NcTDR3zApnSCR43vyHFTBN0zg3+KJ8It59TEvMGRNt0nGeE5yK/LqRP6YDrH1xVV
	l/pbMp/ji/sYkeqWkL8WEwU5mes+uQxyOYg0nmM5k4kAD/3yaIDQjwVpGXC60q87
	a3AbyHFd5XOkdqDdniPVTCEUVfwtYBKN7/FjCip6zuvx6wSmKniYAZscdsfl6HlT
	Bl9c+g==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb2bjjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 10:41:34 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e4dso2935746b6e.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 03:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793270494; cv=none;
        d=google.com; s=arc-20260327;
        b=mJS6O/CeARXVSa5f0HPbdNrBa0QORthx4qWGwA5z/x9RTxlACsC63n3BRiigwzBc57
         ndLQQlX4Slkd2XK82PGa8Vb+5fKMBNIM0FSNPWgYKam3z25SnZaDQ+G/tmQRERQKlkaE
         dxhrvj2QZwbKyK6ie+V1dtDuHabaO4iInvbZv6IdnpllaK57EvnfOIFgEzfbJEdcY7jp
         xNqFuLPjSxhksfhFgtDUk9GdlVddaggX1DHOtotvu78dLU1w+klPV4bEHQVKOVHtb+G0
         ZSeVAZm1QnE257BlEQ8xLfi7S4IPWm6ULTI8hsvnlLuII3bC7bjYEl3AWjYDIR1dZ4zF
         qpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ThaS9L2WxGBV/+v02U6H4IYThEGoc9UFd91/APPVaNw=;
        fh=++dm+nuXcs6/qTlbfYOBe+cRX40fJ7rbhSdprJyuJ2I=;
        b=ARHOvCMClMWo2f0NDx//staI7ORfD2DZJtrPWj7sIquec4dz4Z9TeXZMOPdLg54yeX
         9znhmDK+ohHVE4EaL6rmIXrqzcitBkayMLEwSnBrYIEiFKjJAkYDdOJl/Zg/fezNRlFX
         0YgUbYlzS3lvy1Ec15J8rCOhB9L2cp6sz2tzIH/j1W80DlavlngE6gsVUPe0m7vh+Cvp
         dOyfSguhbjMCjIk9P5ZPEqI4ADUcZinXWlAEjUXKNdtvT/d4Mnwi0mU8jW8q4wQ6/PWy
         gj69bSkBHSkHlrC82AoBrJS+56abbrN5Ei8l+jzLFsnh2uS3/H+evDnncolCCEOZkYmZ
         9kDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793270494; x=1793875294; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThaS9L2WxGBV/+v02U6H4IYThEGoc9UFd91/APPVaNw=;
        b=hqf4+1m7A6yCngJQVVscBjOao8q6JeKmPx46M2ss9NlRUgBBOx8gd8fbBVcUxyA64H
         hAjsmx2oUwpeWIYlE4LlYYYPuSK5byQGKLouMuIfYSENJPyzVXR1Z99/J49BQg2MEvHC
         LfdorDsEX0bebsIUvUgbFn8tnwiu+X0Jl6oWjq1Mi4142QAShE5bznrUkfg/JjVIQAl3
         697jSw9khNM0+wbDJQ5X2F8mEx6lh9/9MD1BFRGgsAoMWKJft/Ie/nNDfO1VHFeCAAhA
         1h3/DC2Ikky5b82oqKLLTvuPjSdKCLSdU1yANK4+SU22RR3OI0pTpQd/TtyDpabRRWui
         tDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270494; x=1793875294;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThaS9L2WxGBV/+v02U6H4IYThEGoc9UFd91/APPVaNw=;
        b=igpsl0N17vuZFJA/+PUh/PgYcokh802y5eLxaxhmILt/7SzoMyzSrCww30Ab/WiCLO
         yWRl8sMUOgkYvfC5N7BXda/VO7H4VRIJwx+8qNCL3IHaomAxNh3NmqASVx5sSjavHhCP
         3hMkQu7D12ki6FtXL3vZIiyMCj/EFuoDShodnNpoJBEXPDpuq2i3xL/V9lWkNmcCMb1Q
         B5lIxW+Dq56rwuyWkm6t8UCwaZcFNrZxwRUtj4dC8Uw1cOL0XQZF5n1eIZXkqiyn7nK8
         riv4YbljjJjfkRsAnA78hXyd8DVYtOwCLv0w4aQ98eqJIW24nJM4coDkduX6gYvRjeOB
         l58g==
X-Forwarded-Encrypted: i=1; AKwUvBzMO4HhGIuKhapTQRnhgRzluO4HZGTPETLIokcWIKg4VERAyJnybA6apdHwHDqTj/2Z/PzGa+ojTfQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLShI7AGTQfa0A+FBTWgNZxcAMxWsna8SfxcQ3N6NRG/CHGA9R
	H4BsjX9daMld0BWfOM2j6dZlEi8OnninVf7OdofZg50868UWxYa7n4ojvNiJnyQFVhf4ggtFRYu
	QCzrlfY91uHIUmG92MGRpYIU+RDZnSE/jiuAy6LkUUsfDLP3BJRc8VhjQa9UTHNQHZ3bcvIp1zj
	RXztsaCLmlO5d+aM2PqAvnEH5g6M8rw1x/PMKoWngdX4L36bGL
X-Gm-Gg: AYBFou2QrdM2OA3TfJyjJ+Bpyvk1augrXh7Piag+NahvKVyukuczQGFBc/boKcyVeK8
	sco5oAGThCBugQpH9jCw0KTgy4IP3lNrXeEptO+hJlKbYfiWk56KTVL9b8BXcmR5aw62km83Os0
	KAMCGoDexYa2j2Ri3hnb99NUsTEWj948+WuI5YATsY3AyzrywYdw70B0OxWP4=
X-Received: by 2002:a05:6808:3c47:b0:4e8:d530:daf6 with SMTP id 5614622812f47-563827879ebmr3577169b6e.26.1793270493909;
        Thu, 29 Oct 2026 03:41:33 -0700 (PDT)
X-Received: by 2002:a05:6808:3c47:b0:4e8:d530:daf6 with SMTP id
 5614622812f47-563827879ebmr3577164b6e.26.1793270493505; Thu, 29 Oct 2026
 03:41:33 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
 <20261016-pcie-controller-reset-v1-1-51779736cf12@oss.qualcomm.com>
 <sashiko-outbox-174374@kernel.org> <179311790152.16692.4133912456520918774.b4-reply@b4>
In-Reply-To: <179311790152.16692.4133912456520918774.b4-reply@b4>
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 16:11:20 +0530
X-Gm-Features: AclHuK_wpYH4bUz72glh_V0oi32sEHasbbBJkx6tUqhqw7AanKcWYHCSLl2xaA0
Message-ID: <CAMyL0qMF6Ty0D+cM7Ccb_Nxpg7_vhpTV+xwErii63uOBOhS44A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: qcom: Implement .reset_root_port() for
 firmware-managed controllers
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae322de cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RCz438OWDAAgn383P5EA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: arLg7CAoANiHOpb38Vz9Df9X9OTToXbZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MSBTYWx0ZWRfX4fNd67Pnyf7+
 3iB/Ho1lnzRcUYNcknCHdRoiFNKiwUuKp1P5itj+x4Jcw12B1VJSKYBKf1TXHzzEzTaFhoFJalE
 uMmc/iy6eBzMhsMZHv5ghyN78Aoqxx0=
X-Proofpoint-GUID: arLg7CAoANiHOpb38Vz9Df9X9OTToXbZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MSBTYWx0ZWRfX/mOntsZlD8y8
 Q5w0cyY4ZIiCiQHnKtN57gSaTaEugf+QwuwZaiMQJagChHYy6RuXVqcHtxCkDiPCehPp9j/hBP4
 LIf3lUaCYwrgkh7wgqkEkws7zOSUSMLdC6dUSqDnc1Lt+yjyZaiU1w82IMcEnLvhP8BmkATYVT8
 ialXFa39W5BiJMCAT2XhLnYfPetm96iPKSdU/TiELTo6XAL8k2RCWQfG6+AQL8Fte/vX6Dt7zO5
 9Sv2EG4ETY0xG6z49zlPDbNhigEYidMRpoBOE/HsIkEFPRk9ghs4oLG6RkSPGJE/WguOcAl8Rcp
 rub2EvoUd23AA2nps6OwAgHo9R2eQ9GAoysYnotvenEAVVpJxg/NGXk2eI/IurJJd95NUJYux8n
 X+ueYyoNmJKCsVKJjCMPp8FJWjdfK1sZAS2gpJ3q1gBcDy3889rpwNBOvdyDTLx7Z8Liob7xaMK
 5x1jmX+Rg/RO/bEryUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290041

On Tue, Oct 27, 2026 at 9:48=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> On 2026-10-16 13:13 +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 5 potential is=
sue(s) to consider:
> > - [High] pci: qcom_pcie_fw_reset_root_port fails unconditionally if CON=
FIG_PM_SLEEP=3Dn
> > - [High] pci: qcom: MMIO crash due to PM state corruption via pm_runtim=
e_force_suspend()
>
> These two seems to be valid.
>
> > - [High] pci/ecam: memory corruption due to cfg->win assignment on 32-b=
it
>
> This is not applicable as all Firmware managed platforms are 64bit.
>
> > - [Medium] pm: async pm_runtime_put() races with pm_runtime_disable() o=
n probe error path
>
> Pre-existing and should be fixed separately.
>
> > - [Medium] pci: dwc: lockless dw_pcie_msi_init() races with IRQ mask up=
dates
>
> Looks like a false positive.
>
> - Mani

Thanks Mani for the review.

For MMIO crash due to PM state corruption via pm_runtime_force_suspend() po=
int:

I agree there is a small window between the suspend and resume calls where
a concurrent config space access could potentially cause an invalid access.

I investigated replacing the force suspend/resume sequence with a normal
runtime PM suspend/resume cycle. However, pm_runtime_put_sync() cannot be
used here because the PCI bus (pci0000:00) remains a child of the controlle=
r,
causing runtime PM to reject the suspend request due to child accounting
(child_count !=3D 0). As a result, the runtime suspend callback is never in=
voked.

For root port recovery, the controller must be power-cycled regardless of t=
he
presence of child devices because the error being recovered is at the contr=
oller
level. Therefore, I think a mechanism that bypasses the normal runtime PM c=
hild
dependency checks appears to be required here.

Could you please suggest a preferred mechanism for triggering the controlle=
r
power-cycle in this scenario?

Thanks,
Mrinmay
>
