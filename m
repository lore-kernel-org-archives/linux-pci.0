Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC83BFE2B
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165721; cv=none; b=sNnqwqklsBUVLg5a0nV7Gf/HkOGbnvPl7h6KF4s9gP/Qa3QVDFv6iPDRHR6+sAX5/8j8bJiSJtu6qJg2PM2Sdt3HYG0CeAU8xAEgJwBI6CeEfvVkjs8Xjlml58wBiXjBa/b/GIzwXQroR5i4F6kebh5Jp4VfETcioi0CViqL0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165721; c=relaxed/simple;
	bh=sBoMTZxot/GUH7ltJZqbnKFUhlhK3zt+1l5cTgivvao=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sx3lTHPRt1QDG0agoo9dqvIE66xDRX4ULZ0oIIKxpa/Nni/iHFGcJ3+9pcwgG/rPaISxSZbv3T3WGMPMwzh3xbBC+MErpb2aNhqkCD9uRx3YSpQfJcfaEY6FMzv7w7htYYt2RYncgX2bvM7QKa8LJE6Mf6AKMVur7k0X2deqL8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoZqAsce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoZqAsce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66BCC2BCFA
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778165720;
	bh=sBoMTZxot/GUH7ltJZqbnKFUhlhK3zt+1l5cTgivvao=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=PoZqAsceOba+Tqbr9an0bHdgoUbWBFPi5NsLr5LxhkmRNbKeoIrV2x3jc1XN5cgbe
	 PfV/+Ki7m2qWr2bGIqAn9FfxuDsPj7vOHD8Nk2Zrgk6EUwmcyrYv5YdJYXUvl9jx9J
	 0A27K1MbOg5+IIqMXlvqpwlPb/1Ww/Gzq56FsvyERuwsxjYR7LuQJvTQ+eA0bO1RlY
	 XxPyf6p44e/8mwVJefgXManMBW49iWL5dQL3elQOqOdG1Ww+ng8NSKrWlbA0K2xYFN
	 8bqlswstnWkOgVFP4R9cOs3mJAJTI6MaDRlCQvJvv780HwDSg+K7qhqHqCtV+FDmKD
	 dtNaMuX3j8yyA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a877510541so928261e87.2
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 07:55:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9aIenfnd8Qr2A2lc4sVzEFugTozJikXw2cI6reSRe85PVO2xRgX/cBwQDTaWO3rwik0+QhTps85r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySWO+r/nzpHUqIJux7477BBJnm4UoWf99EcGb1mZc8C5+KkZXU
	omOIKnRjc0xioaAs4BiQv3dj1yA3Hg5VQF5Rh/UGIvVl1njau5sQnZAGW3E7UbZU4icejV5LbhT
	XBCZKzy1s2mTFIueDzCuxtOyVD8iCtqWcVWmJ+19Dmw==
X-Received: by 2002:a05:6512:3f1a:b0:5a3:cc81:eff3 with SMTP id
 2adb3069b0e04-5a887cdff2emr3195899e87.26.1778165719299; Thu, 07 May 2026
 07:55:19 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 09:55:16 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 7 May 2026 09:55:16 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <u65dquj6im54rc6w5apmq2a6mcpndvh3slcxbjh2bs5el7epw4@zjovdsjkm6ur>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-12-720d02545a64@oss.qualcomm.com>
 <klxyhlqwzl6dzk76lrhugxqdsv4hushphlfchuorcmvx5yja7q@pdmp3abepldg> <u65dquj6im54rc6w5apmq2a6mcpndvh3slcxbjh2bs5el7epw4@zjovdsjkm6ur>
Date: Thu, 7 May 2026 09:55:16 -0500
X-Gmail-Original-Message-ID: <CAMRc=MdvhMBpunaitGv7yv3sTqkTYviaeAJzphTS5dBUOFPpHw@mail.gmail.com>
X-Gm-Features: AVHnY4IsmCMvQGmDlHA5wh2Ec390AWskAmVhnqo9T8ZXKWT1l4nlrdNCQ_BYEec
Message-ID: <CAMRc=MdvhMBpunaitGv7yv3sTqkTYviaeAJzphTS5dBUOFPpHw@mail.gmail.com>
Subject: Re: [PATCH 12/12] Bluetooth: hci_qca: Fix the broken BT_EN GPIO
 detection for Qcom WCN devices
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Shuai Zhang <quic_shuaz@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Wei Deng <wei.deng@oss.qualcomm.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, stable+noautosel@kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 1:59=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
> >
> > This will break the case of WCN399x devices without the PMU in device
> > tree. There is no enable-gpios since BT is not controllable, but if
> > there is no PMU, then devm_pwrseq_get() will always return
> > -EPROBE_DEFER.
> >
>
> Hmm. I missed that the pwrseq returns -EPROBE_DEFER even if the client do=
esn't
> require power sequencing. It is because, it has no way to figure it out.
>
> But I think the client can parse the regulator phandle, reach the regulat=
or
> parent, then check for the '-pmu' suffix in the compatible to make sure t=
hat it
> has the power sequencing requirement. Then it can call devm_pwrseq_get() =
only if
> that check passes.
>

I'm wondering if we could maybe provide pwrseq_get_optional() that would on=
ly
really be optional with fw_devlink enabled (where we'd be able to ensure th=
e
provider is probed before the consumer thus be able to tell right away if t=
he
device is power-sequenced or not) while with fw_devlink disabled, it would
just behave like pwrseq_get() and return -EPROBE_DEFER?

Would it make sense?

Bart
