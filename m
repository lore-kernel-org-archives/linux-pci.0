Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E53290B0
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302593; cv=none; b=CZv3xLM7A37Wkq9C25c0vbAAKlJD2CrsQssep+AwKYMUcGRHEk6LLwKq9r0Ok7S6MktWZOVg5SUV8a1dX3hW7+21PQFxQUHv+qTg8v76/W79x2Gx5otjx34+wA4Hp39ykAaH504p8AlBH56L11gpwRaIpt05wFndE13vmpVkjCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302593; c=relaxed/simple;
	bh=3HJAquWF75BxKql2IERtTQ1Mt3V2pgjzAYWmMFuVzhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKBHsjEJjv6njNFit1a9UZZUJPjwuS/PpaoNUBRTrpNYNm8ednMhSiDQHltxP6U80EIA0Is6bXCnGnMNFEAIK9aa485fpOYZBHaiJJy1n83O1XKoxCwnzb2UnsOzRtkAAspJz2r4Y22CwtuT1CrJmZ95kwiBtZW3tTxiOKghmYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAgf3vyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAgf3vyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04448C2BCB5
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302593;
	bh=3HJAquWF75BxKql2IERtTQ1Mt3V2pgjzAYWmMFuVzhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lAgf3vyHdO5bDjdl856sin3Z8Th7PzPW8jOMsKz8+UxMJ1ukBelDaE3VlGKyBP03x
	 ogIWyiBLoK85h1XywbjX01Q/oEh/AgbD7L/Rn68hxHndCFHglltFunScAYyT/iNLUA
	 jmDTkM9e32Vh24ATrcJ8JUWxWoynkqQUyXrro68PT6vNsrBY5q8LSVek/2w7IKoCMP
	 +iupGZGWLXG8HdbKtvMADO6Bf3nnRqDXkX1uNj+GyRbKXCnjsb9yHbacrC216sIj2A
	 dJmytBJoH19dVK40BGGpbrVUBJOKWNTBYK0DtqyQK2URO29ZAuxJP3EBasycC2eVKT
	 GEOPYdschTfRw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a62f43b76aso4796220e87.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 08:09:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+4v+nKNbleUbm8bDUT4YXDZrnqcQU5zDt+jvDcsYkh735/40O7DATkZNPWHfWJw/iaMIdas+DPqZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZdgRFTanjYLO+DFjW3tGkAoBJzkoGp0ivkGI3CrRbwrys0Nv
	unX5tZR0zoB+lo/E1n+b7gj0U2dpWGzo5E7GYmiuRWQ/ZfiZqeOO0aTvUKa/EHDKWw2jGLLqRRd
	23H7I0v8bsWAz89iXqlrgzYDHRIKsQkc=
X-Received: by 2002:a05:6512:3095:b0:5a3:fd0e:ce6f with SMTP id
 2adb3069b0e04-5a4172de2fdmr15563177e87.23.1777302591414; Mon, 27 Apr 2026
 08:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427035341.1425576-1-superm1@kernel.org> <CAJZ5v0jMBpXC5BxjdMgpg8tMKpS3Hf2MO_MGNtdS_S+s41jx+A@mail.gmail.com>
 <ca274454-b58b-4837-a3fd-14ef30c24510@kernel.org>
In-Reply-To: <ca274454-b58b-4837-a3fd-14ef30c24510@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Apr 2026 17:09:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0haau7219McDX8d1KhS_ig_nPDVNEV-w0HWMe_nMCjkpg@mail.gmail.com>
X-Gm-Features: AVHnY4JhRW-xCPF9OWt7F-_Fif0sxFvV8_89EcXgbTHIG6hBGampOS3GCVCQfD0
Message-ID: <CAJZ5v0haau7219McDX8d1KhS_ig_nPDVNEV-w0HWMe_nMCjkpg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improvements to PCI hibernate path
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 4:14=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 4/27/26 07:20, Rafael J. Wysocki wrote:
> > On Mon, Apr 27, 2026 at 5:53=E2=80=AFAM Mario Limonciello (AMD)
> > <superm1@kernel.org> wrote:
> >>
> >> A few cycles ago I sent out a kernel series for using the S4 paths whe=
n
> >> the system goes to S5.  Some parts of it got merged, and Rafael sugges=
ted
> >> to split the other parts into smaller pieces across multiple kernel cy=
cles
> >> to make bisecting easier.
> >>
> >> This fell into my backlog behind other things, so I wanted to try agai=
n
> >> this cycle for the PCI pieces. I have been carrying it, rebasing it an=
d
> >> personally using it for a while now though.
> >>
> >> This series attempts to unify the PCI suspend and hibernate paths and =
to
> >> fix some things that I observed to be wrong with how I expect hibernat=
e
> >> to work.
> >>
> >> It is based off 7.1-rc1 + Lukas' patch:
> >> "PCI: Stop setting cached power state to "unknown" on unbind"
> >>
> >> Mario Limonciello (AMD) (5):
> >>    PCI/PM: Disable device wakeups when halting or powering off system
> >>    PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
> >>    PCI/PM: Run bridge power up actions as part of restore phase
> >>    PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
> >>    PCI: Put PCIe bridges with downstream devices into D3 at hibernate
> >>
> >>   drivers/pci/pci-driver.c | 103 ++++++++++++++++++++++++++-----------=
--
> >>   1 file changed, 69 insertions(+), 34 deletions(-)
> >>
> >> --
> >
> > It would be good to CC this to linux-pm.
>
> Sure thing - if there is a need for a v2, I will include linux-pm in CC.

The thing is, you may not know if there's a need for a v2 without resending=
.
