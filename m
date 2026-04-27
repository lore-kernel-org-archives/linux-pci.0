Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B13A784A
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292425; cv=none; b=nq8KTb4aB02jWZZYeugd0hIQPxDjR7qqax4xmGipwVZDZY+ClrgQ+Jg44gfFUitC6USSEBEbBXslmHvkEaXxIRk3DQlFTdrBcHiAYxoowyIussQ+6hpT2qmUSV1cp5i0ygUma5pBHTMxxVyWd/vG9r1Y5v0UzX+gm39iu7MK34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292425; c=relaxed/simple;
	bh=mtUKxbTR/+hPm86uo3K5NfHxp6WiuoxLZjPnUAi69fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiQRttJgcDV2pzJy0Mq15z69FdUHi3HR9QyFZTcQQik4apMd6DzDSSxJpOnbzeg7Qj2YhZPEpbFZBsAZvbAAsL+XrT6gGueXRm/xFd0WSfBpa113asOktYSs+D0zS0GUTO2pQiRytc/lUaNF7M3QPZMo7W0cKDdVo9/JW5HaQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex4jWHGg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex4jWHGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A49C2BCB9
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777292425;
	bh=mtUKxbTR/+hPm86uo3K5NfHxp6WiuoxLZjPnUAi69fY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ex4jWHGga9Lr6OrqeECNSVyxYdWqno7jidS22H3IQ9aTxZFO0p3tVCtCOl0yw/jY+
	 WkU9vv1JIOYTFf5KfMjcGT4Wh8Tq9xlS4fMmOttvBo3jeoXF5NuIwlokeDFUPt+Snc
	 /quoXIYs3ADAFXCXsfy1n/BUHSX5Qk6hQBJWdxmqgCkNpcxc7oP5AMbkLJA5javd1x
	 7J1KY12RAivxrq8mmRteO/ej9DvvKnAEnq85G77LdgJvoh00HG/1Tq5oYVJqFGuzS2
	 xL1C7PuCbqEbOmdyDETaZJkPXTB+p2pTCWHMWxWlL8HgDVUzuG23cvel3ixmqG4DGR
	 xHPHQkfvGo+pA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3fcb2c718so8707282e87.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 05:20:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/S19TT6dzywH7uYBe1LaIMrM25Gv6NyDw+ozCOaMdkf3FQXCEZUxGdiDrOfTatp0u44MBzF09YrbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNufInx4RtZYJ9gEAY50pNrDu9thoA5u0VEfMDi8LvBEY3gzu9
	sl9U5cxBmvBlA4jfZdpRq5jnVnuemzFWRpm6QnesGJLiuPBtARSHAdQIsR8LPc5qIO2+v9saaHC
	RZcmdkd9Pqhw1o4bAz7hQMTN2hr25XLk=
X-Received: by 2002:a05:6512:1282:b0:5a4:6f5:6c4e with SMTP id
 2adb3069b0e04-5a4172d389fmr17160186e87.19.1777292423810; Mon, 27 Apr 2026
 05:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427035341.1425576-1-superm1@kernel.org>
In-Reply-To: <20260427035341.1425576-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Apr 2026 14:20:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jMBpXC5BxjdMgpg8tMKpS3Hf2MO_MGNtdS_S+s41jx+A@mail.gmail.com>
X-Gm-Features: AVHnY4IKYHDd9ijs1yd9zSMdTYJ07ye1RpvHHgMd-tlxpDW3LjKGPKTN06B0nEo
Message-ID: <CAJZ5v0jMBpXC5BxjdMgpg8tMKpS3Hf2MO_MGNtdS_S+s41jx+A@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improvements to PCI hibernate path
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 5:53=E2=80=AFAM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> A few cycles ago I sent out a kernel series for using the S4 paths when
> the system goes to S5.  Some parts of it got merged, and Rafael suggested
> to split the other parts into smaller pieces across multiple kernel cycle=
s
> to make bisecting easier.
>
> This fell into my backlog behind other things, so I wanted to try again
> this cycle for the PCI pieces. I have been carrying it, rebasing it and
> personally using it for a while now though.
>
> This series attempts to unify the PCI suspend and hibernate paths and to
> fix some things that I observed to be wrong with how I expect hibernate
> to work.
>
> It is based off 7.1-rc1 + Lukas' patch:
> "PCI: Stop setting cached power state to "unknown" on unbind"
>
> Mario Limonciello (AMD) (5):
>   PCI/PM: Disable device wakeups when halting or powering off system
>   PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
>   PCI/PM: Run bridge power up actions as part of restore phase
>   PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
>   PCI: Put PCIe bridges with downstream devices into D3 at hibernate
>
>  drivers/pci/pci-driver.c | 103 ++++++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 34 deletions(-)
>
> --

It would be good to CC this to linux-pm.
