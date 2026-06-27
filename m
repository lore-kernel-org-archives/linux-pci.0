Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B502F1FC7
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782575741; cv=pass; b=Z/xfGnYYgcIJDHWQXP8224NlaEDghlzS+VRqD/9L1Qrd8aB1lOLKkAeI9R9FK+EA5eUack2s/z904fdrzMsJqjHNi5vA8guQOlcCOt/+bNlLYekPN6J8MMfmc789vUFIIGDPbb3lsP2W23PUcn/SKZVd8Ete7C/q5ey3XpxU3cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782575741; c=relaxed/simple;
	bh=Eta+TUIGbaG2e48qBuqaA5DNLbA0Eb2xmiMKSqrEZGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqJJmPVDHrV9dYt7CkEt6CQUXD226DZSVyE4rTz2Yt8srwOAurFbWQhaR4oCfpIqGu6WJzSAPVZo0Tyg8hjqhEA1YGStrsSd7p4LOob0uu4G3/mTWNohl2PbNSyxFdvIJ+KPYaVoLiRNeYDg4PJo7fOGnEQhjYhsLYkln8kjCLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBuyKgtU; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBuyKgtU"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-96929eff169so570353241.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782575739; cv=none;
        d=google.com; s=arc-20260327;
        b=Ng6qr6XDTjfr80y+MvZaEkfHt+LkPV744w3aq9f86V7OK6jOQ4oRMf9MqlX7otGKUh
         35tGAGqL16ywS9k2ashl0RENR+ZZZpLbdVkh30cIvZg3yotTn3gdjymvsgLtM4dG/NJp
         bZcyHzw6eGAQKIBCkwZgea1YFzIGr3lyU8A6n4N9E2W2+4t6nWtvRUFAK8QZzTjDG7JE
         rbXKi8gnpqdURqUX7C2awjldaBApO2L3LowZj3HwPV+BJYh22oa4DYd9rkDa9ARf26m0
         iJd0yH+K7QJNMC7N3S+r3ua9qeibAtKedW7POw0qmfyCWTdvpeXYrNF7gpV6dvyG0+n+
         8gEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OvZIcL0AGkEIS6c9chxupiOaRaP3B+3XJlsdIM45N6s=;
        fh=4ZX1wZCaL7e1MWUq1KNWeijTToRyQO1lqVvnd9CHUzA=;
        b=UZmEuAgFSwhHEoPfBf1YV37ljCotj1Jc7iG8DGLWHyDd/uMogy5iYEjJPpmqvRD3in
         eYShpTQ/WghJQpCsV1+eRwFv02nOr+NwFu0b+xyWXtDMV1wCME4DomlERw1olRK6wUNt
         vy46p3TIhYlrdwevTNOGRom2wk2JY73HhSDW1h1SV97mTUQ+e07zjysgRynPZ8ozU3m2
         srmvlcIh8OVQJzYmI11J4RCeEM0kg9WhvFg2tzTOH2J2hUlDbXs/vGHcoZJD/yNft78E
         0WE5U44g3Tc5NyLT2iY4dnfuDuTCLiM4g9WNmPRiLdHtHwuKm67b0tmeVyelAws5gTtA
         OYrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782575739; x=1783180539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvZIcL0AGkEIS6c9chxupiOaRaP3B+3XJlsdIM45N6s=;
        b=gBuyKgtUuhkOjAaRdedzcpY/wzaqqe0/v/4vA6VQZUutLtYmVSvpboYaAhXDFTe570
         oGbP5iIVG05iIGiqJdLzI/USIKK1KMKYY6FYRz6Lr5y1H0UgXEZOjhyHgPkPNyUg+v5D
         5Q4LXkhOiXu/hOpoIOQZa6nUJngGE5uBVigekn1D0XW68x/mMW/E9tmQKZlxoreJ7e6+
         nkRi4X6S1nkmCGq3gqtKp3c+RVvzKWwTLeZb5dxIKARGDRmXJGAnvvDTNVAvc+9s+N+9
         EvLJoKxpqxOyOGCbnap4dHoPKdqPlOgwMCQoFvCHxeLqxCLNvsTo4RCwsOR+VYahldlR
         7vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782575739; x=1783180539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OvZIcL0AGkEIS6c9chxupiOaRaP3B+3XJlsdIM45N6s=;
        b=Q2jPvp6xTaQ7U/05mvg4jD+LPZg3YhMxoFUaxBqymaryTBZjI8CQIKAYP3LCUrrtXb
         scPDW15KBOzmWOWa6eCnigkp3RzVKubFrweFA3c+1dgOLkCw4vNq/ZuRYNmAg6hVcAj2
         kP3Ll6HcrKJlMANjENVbQcu0lwzYelkRzKvB15FR0bmfRtX46a+HQs2Yv5vFkAgmnIoU
         2dxqqdd0Zw7PnpadgEX4EJSe/l3a/xAsrVKCC8WAv8I55Q2BM0eSYpzgdA86Xh+pMsoE
         wKK3H3t6IP6ZMLNxCtqpQ4lNh7IUL5T0a8Bttb83WQHpAevXMW290zNKyNwQkN4O+ctw
         tDfg==
X-Forwarded-Encrypted: i=1; AHgh+RrGHUAn5AEqIDZY1fRjmxLp8fpbUCeDtUoSUecLNbzxqSHu5fOKRtxEz8Qz1GgCOdP3d5QV/qH5T38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFXirTvVj87GNaefjPCDuNCOCi7K2PnQ9SbRmluISTUV+6JFu
	CJmx6xdMeukWO7eP0kWNZIs+txuHJl7s/BhUQyXZuD1E/XLqpmUvjd88LIWlrUhgz0+dChlPylh
	4V4/czvz422xI5j5kHfEGFAn0P/wlkQlzGg==
X-Gm-Gg: AfdE7ckDsYso9p+MJXBNviGr6bCPxra9AwTJ80tOoeArr1Eol2aEQPdwoAW7njta0Vq
	to1rJf+9Kp4bPKspIGT9ioYhrOS4IOAOK4k+O/XRP+kQyD0L97WVpk99YdpDcqgjq3lIcgkk0aV
	BzRhN6OVKrOhwZ/JLql7Y3ugrUe/R9b70qt9GkeXUKmjmf7QNOsHaQIJkqMLp8LQZlUdEh+1wdf
	/eJbQp8YI/aWKQFFusTrpLuEHuTVfnUm9lL2IV3Ycm51aUD7e4yztmXixC8G6rrKy7Ko6Q61w==
X-Received: by 2002:a05:6102:641b:b0:737:29c:d30d with SMTP id
 ada2fe7eead31-737029cdb8cmr429085137.10.1782575738809; Sat, 27 Jun 2026
 08:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com>
 <0538faed-ffc8-4ade-906b-5e3ee7bfae4a@oss.qualcomm.com> <CAH-zrttRYZd9yJsSzUBVLs6tZyguifJ+3eZ+j0q3N7C5k-yuwg@mail.gmail.com>
 <hgawzx4gdd6e2lam5fk5qvnbvi3xqranhenkpdqkp5fizalonr@ez623pzimpxi>
In-Reply-To: <hgawzx4gdd6e2lam5fk5qvnbvi3xqranhenkpdqkp5fizalonr@ez623pzimpxi>
From: Paul Guder <enyalios@gmail.com>
Date: Sat, 27 Jun 2026 10:55:27 -0500
X-Gm-Features: AVVi8CcIjuXrVYkR8veCqe0cpAxDEI_9xfGEKNZwLBdY8JE1g5d1Yx6dje9zAKQ
Message-ID: <CAH-zrtt=ZiKzm9ZdWBW_MtqWCfLC_B=uwsY=NTF_rkLG=s0+eA@mail.gmail.com>
Subject: Re: Wireless Regression
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you so much. Glad to hear this isn't an issue on 7.* kernels.

-paul

On Sat, Jun 27, 2026 at 2:38=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jun 26, 2026 at 08:08:10AM -0500, Paul Guder wrote:
> > Attached is the complete log.
> >
> > -paul
> >
> > On Fri, Jun 26, 2026 at 1:04=E2=80=AFAM Krishna Chaitanya Chundru
> > <krishna.chundru@oss.qualcomm.com> wrote:
> > >
> > >
> > >
> > > On 6/26/2026 6:19 AM, Paul Guder wrote:
> > > > Hello,
> > > >
> > > > I seem to have found a regression with the wireless on the thinkpad
> > > > x13s laptop which uses the qcom chipset. This commit seems to cause
> > > > the issue:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co=
mmit/?id=3Df176c47683bf
> > > >
> > > > Any kernel that has this fails to load the ath11k_pci module with t=
he
> > > > following errors in dmesg:
> > > >
> > > > [    7.298226] ath11k_pci 0006:01:00.0: BAR 0 [??? 0x00000000 flags
> > > > 0x20000000]: can't assign; bogus alignment
> > > > [    7.298232] ath11k_pci 0006:01:00.0: failed to assign pci resour=
ce: -22
> > > > [    7.298234] ath11k_pci 0006:01:00.0: failed to claim device: -22
> > > > [    7.298267] ath11k_pci 0006:01:00.0: probe with driver ath11k_pc=
i
> > > > failed with error -22
>
> I just reproduced the issue on my x13s with stable v6.18.35 kernel. The p=
roblem
> is the classic hotplug bridge resource allocation issue. When the bridge
> advertises itself as hotplug capable, and if there are no devices found d=
uring
> initial bus scan, PCI core allocates a conservative 2MB of non-pref bridg=
e
> window with 1MB of alignment.
>
> But when the device later shows up with 2MB of non-pref BAR requirement, =
kernel
> couldn't allocate the required 2MB with 2MB alignment from existing bridg=
e
> window and the enumeration fails with the above message.
>
> Before commit f176c47683bf, the bridge was not marked as hotplug capable.=
 So the
> PCI core never pre-allocated the bridge resources during initial bus scan=
. And
> later when the device showed up and the bus was rescanned, the resource g=
ot
> allocated based on the device requirements.
>
> To fix this issue, we have 3 solutions:
>
> 1. Simply revert the commit f176c47683bf from 6.18.35 stable kernel. This=
 commit
> is not causing any issue with recent kernels like 7.0, 7.1 because, on th=
ese
> kernels the pwrctrl core probe defers the PCIe controller until the endpo=
int
> driver gets probed. So this means, the bridge resource will only get allo=
cated
> when the endpoint is visible on the bus. This change was added to handle =
these
> kind of hotplug allocation issues. But since it is not a bug fix, we cann=
ot
> backport these changes.
>
> 2. Teach PCI core to allocate hotplug bridge's BAR window to be aligned t=
o its
> size if no device is found. But this fix is fragile since the default MMI=
O size
> used for a hotplug bridge is 2MB. So if the device requires > 2MB of BAR =
memory,
> even this will fail and the users have to resort to cmdline param like
> 'pci_hotplug_mmio_size'.
>
> 3. Allocate a big bridge window for the Root Port in BIOS and teach linux=
 to use
> it, like x86. While this is something we are evaluating for the future ch=
ipsets,
> it is not possible with current BIOS for the exisiting devices.
>
> So the only conceivable fix would be to revert the offending commit f176c=
47683bf
> from 6.18 and 6.12 kernels. Hence, I will submit the reverts.
>
> Thanks for reporting the issue.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
