Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73839734B
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139126; cv=pass; b=WJUsYfIw9L295R4vI6YMqgfvboKAeeHZAL+idOLXjwrh0yFdkYAqhcCzIi9Ze7CS30LRbFARpwuk5ckq6NdwyptJEhUUHwn7qmWjkzqQQ/OLexjIL6BR97lAVP6QBcNY1SYat/QDMpNXZcLdlhOnXUtBP7eIwVdDtFs66VWnvHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139126; c=relaxed/simple;
	bh=Iq8Z3gsY+sGh1bpm3OsF4CiOccucJFzJwdvelyBxEj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+3P0eS4VI2HenpvrtMWdOu/AVd8lzjf4vKEiKJJY2npcsVtLrEwEQdU9EMs86b0DV6ryK+jD3vhGKctkWNDeStOc+FCSCGnm87hDuepDjwHxfjqh+gfas8A4KdXUIogRa/3CLUC7zlS70KS/mDT3yDNmyXYw7OV3D7bF3HmUBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NMQc2NHb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DeMT5K52; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NMQc2NHb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DeMT5K52"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G7aZJS1635415
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 08:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iq8Z3gsY+sGh1bpm3OsF4CiOccucJFzJwdvelyBxEj8=; b=NMQc2NHbmVHoBxFr
	uD5KqQWYTYkO0//DD0cLR21xMKAyTUFaFtjUhb2iHScRGHbQc35yjtRtQd6zkIsp
	6sAO1Hs5PMBcmkRO5LKlPd+tbiKH1ShucqXqdnqqA57zFo9dr/zxpiMnY/Cu5TL/
	nf0xAap3U7MZE1RMHNnoFsf8/VG9il/f+cyB+IAgSkew7NRZ7vIGOBJ6gp9G+DW2
	Vmf226P3zXJVGlMc/BGi1XeXwm85IBFGbulAeU9KfvFjF8J6c+ZXXA7D/IWE8tsU
	5kfnANBRL38SbR7H/hu0yvivOg/Nad0nh9U2VqoJfErfidsVQAD9scO8CIWpe1oa
	jZcXmQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r11nc1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 08:25:24 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-5384e381fbbso527476b6e.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 01:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792139123; cv=none;
        d=google.com; s=arc-20260327;
        b=ZWfeKtvgEeEzIWDMXAkDE/CmuKUsJ8lBMtJpa8qiF1fZNd6vNVBcda+fmU8O9Hfe2u
         0m/yJbCf0aagOqy5HALat4NuMDEPkN2Yq7izvryp+oWHxKeE1nQnYwgFnIPYKSyVHpRr
         B/TbEMHtuXg1Qvj37u8JBREGHaxAeZDiTSfhPPtqtaX61Se/j5MKb3ewjTkN4fjbW2g/
         Qg4VUeS3QfzLi00a8wvxV8Rw9vUHzewkFXpFkcdv4ffgNABMd1aXF09kZgEjD7aoGY4o
         39xe/0eTlL/ZGu8CPB6H47L4juaP3Ps3XF6HUm8hxnPcCt5naPtQC8JrP+WOR1L44MHo
         q11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iq8Z3gsY+sGh1bpm3OsF4CiOccucJFzJwdvelyBxEj8=;
        fh=dcKbuN+R7PsmjlS4H6wrlV3fkkYa2FZf4Q2xObRFxrE=;
        b=fBry2zBaIqWPwIXO86kG/5s84/KLSi6UX++JvarDmreHqaerp28a1tIhqNvIHUUrfy
         uuJdYNLKXYgR2rVyp8WLgBMgIbs1AIw21bkAatCyx0zK94BZyUgJIcO0hL+Ms3xZjlIZ
         qI8pQL8gQ4LF/poyU5V3CwXIrduFGRVzraINH1urViwm6TJ19bFYOgkUz8i6Yb8O843G
         4pbgTk1Zv+/5Vs+XW/EcZQccu5/lILVaS3Kyr9h8VCAG5b8e/w1A80xNQk01YoYW3fb8
         jrlN/zka8QfS4sdMxUbqSiIzxriTZfOeBWBRnu6FFM68WYQqDblbNUnT27pWr5VXzqns
         QRdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792139123; x=1792743923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iq8Z3gsY+sGh1bpm3OsF4CiOccucJFzJwdvelyBxEj8=;
        b=DeMT5K52h6InjDRHNV/J8+Th2QC3wJ7Pfzij4jaONXXO7xgv4cKIghQ+ChyxsoCOYr
         /3Dxfvv9VtB7aH3Yk6MMQ2cT2MlaZG+IM2JEEK9FbldZMSUes0vubt2oCaov19HAzUHX
         84ABKBq9Ve5nXOl+9SNm10d+WulO2ooLvmrHDAp/3hUwz14ByYCEY6u1zrLHdDv70G1W
         108r9Fak+BRrVxi8zPBEiJIoeMVOdmIf2+VP4pOHgjeKuz9tovyi98t+NzlGDFGtNBfI
         U4fbp5NMa1ux1KlXgK3lGpEEMTswqWhgf3ZDJKoheqg+kifbAIhIDVsgHSHuwXD6Qign
         c/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792139123; x=1792743923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iq8Z3gsY+sGh1bpm3OsF4CiOccucJFzJwdvelyBxEj8=;
        b=071QW2qMCxJuH4v0s5cBY/CHiCXWtFUWnsYVxeV6s+dFt7H5mXtK6XHtH0lyn7q+LW
         XzbrNLcIMp056HRw9XZ2HBWyFW1lA2yhOFVTB/wvNwLzQLCmq8iJhZvYcrUwQboL4aGr
         X0zTgN4I2re0Lb3Uo+S1MRAeHpW6YJogm3ey4QGClOr4w3Ddb0FoZRDjLyx3+Aywocog
         Br0zQmA2Zw/GfDfdGAgMbHSign+oEqbQlh9nA/CHVrELGsOoCZt9XCteJdE6Dvm7JW+f
         06sclLoOiu3GIN7yQXmWzBJ2mAiAtDU2t4IBC3fpTasawWer3HhicSYbTPsan65+oofj
         bVIg==
X-Forwarded-Encrypted: i=1; AKwUvBxWlcU9lK1umT/YjY0IB2EF0VUTZtl76YT2cUKONCrYo6cDD7aZ4EM/o118MxMPrkaqMjTuUjku5OY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0vSTIB8c+kaJfRx6KZ0egpVjp8cU0U4qtJMYBI6JlDVGwJ9hu
	3VhhhqFn/okQ9+VbN3QgmlEj3C0CbuYa2gCqAecUfgTh221KHv576hlyHdpKEdjGdejCQe8kca9
	kSSMVbPKoTtCbKF3wI456PAQgylsHLYPd1YIsUn88/+FdTR+Ib2YTARGdpJKF2VyVDZETeYCZ3O
	6B87IIgKMtr5ZGkCa3Fu/P/aI0jdoC4gVDbgYpQQ==
X-Gm-Gg: AYBFou1IM8lQi7g2a3CiWfx3jM/0bi3BXRWb74MhBVLwuncuSlBFooWIVsjoE1PnPJ5
	B6Z/BcpZKsoN46oSNe7qlOsiB644xhnfGWVsN4+POWSWrKhPtYJyo0NcH3xHTgS6su25hxnHirJ
	1NPXnObX0zW75K52Rt6GF3zLbzGW+7b95gMvnwl24JgMQzyQxFRQvODNC3vA==
X-Received: by 2002:a05:6808:238c:b0:4f5:4ce8:7e92 with SMTP id 5614622812f47-50c57a6c3a4mr18345501b6e.48.1792139123367;
        Fri, 16 Oct 2026 01:25:23 -0700 (PDT)
X-Received: by 2002:a05:6808:238c:b0:4f5:4ce8:7e92 with SMTP id
 5614622812f47-50c57a6c3a4mr18345487b6e.48.1792139122886; Fri, 16 Oct 2026
 01:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-pcie-ep-rpm-fix-v1-1-855d56cce43b@oss.qualcomm.com>
 <20260925103254.EC98B1F000FF@smtp.kernel.org> <179213121447.63727.13789617751814530058.b4-reply@b4>
In-Reply-To: <179213121447.63727.13789617751814530058.b4-reply@b4>
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 13:55:09 +0530
X-Gm-Features: AclHuK8m4tAAXjLUvVUKmZo-NlAix7-61WcjDcYjmd4-fIRQLamokUamIQKnbCU
Message-ID: <CAMyL0qMRk32yT6kGH+AggGYAN1mGCWkR_gzuuBdJ_XB7AarNdQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: qcom-ep: Clear runtime PM error after
 pm_runtime_resume_and_get() fails
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ONlprvZ4kqS3keAq7BICa1bqYB3FoLZ5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzMyBTYWx0ZWRfX6hINL8X+zaIl
 hUszZmIxS30SJSsu+oVMDGmVpjkj80fn752uNYUeF6aRJN2uV3Ik+MZdH+0QbEKDdfroLJwoNFh
 upzz3p/vvHzdSZMrt9ieb0Jt/6gmFnY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzMyBTYWx0ZWRfX/HMiygoIyvsU
 mvrAcB88GIbGV8wTUMkky19FjsaFCkM0zpUegjf6xLQVXqP7PYyNVvgGOzp/KNZifbpMgkXLv0Q
 PuEPVSccbQTamlQxiU1dfOaYD8GqjtUc9nBnNTLDsS9UDrYVA60Msyi068CybnyeKjhu+2/7DDD
 AFClxsQrNGgoJ76+JzqQCLAifWPY7ssPmA3+dRFqX4JvnhKAwDUqS3fAwd04khNNied0Q+9djBS
 tJIWvePudxdRe9Q9WsVSaXuiUvx4QB1/cbtBHm4fg4NdWXTsaV6xbRWgZjNrCBTxyasyBQinFfQ
 BnK9thzA3iFqDcwvoVC0ItlExtzAPLi3+2dbXnCK4PH5B+WMVkex5S4CNfncrEevmsEv2tWMe4+
 nE+ubH665iU3WNq5CzTyRJAjwjjXh6GayULnrvP4OH2PF3v5dZSPpjCwCc6QnOgbhh9S9fKenzS
 ELlhHE7wfiQwUZEzz2A==
X-Proofpoint-GUID: ONlprvZ4kqS3keAq7BICa1bqYB3FoLZ5
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad1df74 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=vol8GUgx4u-2tnQQBp0A:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160033

On Fri, Oct 16, 2026 at 11:43=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> On 2026-09-25 10:32 +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] pm: ineffective pm_runtime_set_suspended() due to false runt=
ime_error assumption
> > --
> >
> > commit 3d108ba33ceb10b064e31ea4a0bb76a46a7b974e
> > Author: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> >
> > PCI: qcom-ep: Clear runtime PM error after pm_runtime_resume_and_get() =
fails
> >
> > This patch attempts to fix a runtime PM recovery issue in the Qualcomm =
PCIe
> > endpoint driver. It adds a call to pm_runtime_set_suspended() on the er=
ror
> > path of pm_runtime_resume_and_get() in qcom_pcie_perst_deassert() to re=
set
> > the runtime PM state and allow future resume attempts.
> >
> > > pm_runtime_resume_and_get() sets dev->power.runtime_error when a runt=
ime
> > > resume fails. As a result, subsequent runtime PM resume requests fail
> > > immediately until the error state is cleared.
> >
> > Is this description accurate?
> >
> > Looking at the PM core in drivers/base/power/runtime.c, rpm_resume() do=
es not
> > set dev->power.runtime_error upon failure. Instead, it merely updates
> > runtime_status to RPM_SUSPENDED. It appears only rpm_suspend() sets
> > runtime_error when a suspend operation fails.
> >
>
> This is accurate. pm_runtime_resume_and_get() failure is not setting
> 'runtime_error' flag. But if this flag is set, then further pm_runtime_re=
sume*()
> attempts will be blocked by the PM core.
>
> So the issue this patch trying to fix is valid, but the fix is somewhere =
else.
>
> - Mani

Thanks for the review.
Yes, this issue was recently addressed in the runtime pm driver itself.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/base/power/runtime.c?id=3Deef1d74bf88f120f4f63a83a5201fcda67bf3b52
So, we can drop this patch.

Thanks,
Mrinmay
>
