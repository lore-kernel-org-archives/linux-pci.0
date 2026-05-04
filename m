Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171ED22A4EE
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923125; cv=none; b=NQo20cAlENWnceR6waxdgJGO/a7AVQWJqAPC66XJFEor5jCKIIxlsMXbkthfWyXZ6i9m4mc3++xZs8qcXYMUq57O9yagw1YFsG0UOt2d/k3G8ir9yT18BljLhtA7rUIz/LKT0zODk87oTsf21e2mSndLdUqWq+b08NLCYIC9pJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923125; c=relaxed/simple;
	bh=EfYYKiKTPvMaOhSyqrgwYz9Ahx78+U0+7ZiwjLgRGUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTGgIuTuh1pA5j1fgiUTmJbSIx8k1YNqcaPqq/OEueCvKqblCAOD2O3qBMH/jfPJU38W4heh7qqGGePrDET09PWulu7y5KMLQO89VJUFo4yitTR3Zo4KcnkmcM89eNM0z0goCNztRPRfmZXN3kLQT17AfUigccbGvJPunLIntEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUWr8563; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUWr8563"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9889FC2BCC4
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777923124;
	bh=EfYYKiKTPvMaOhSyqrgwYz9Ahx78+U0+7ZiwjLgRGUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IUWr85633eJXSKuKD+d2i/YbPo4Rk+6WWIZjUN1DpdI3SV8Inwfup+/l95ZBVECc5
	 mImC6WATCo0voBFCwWlPoDc6zLIVM3iuUPmHgSy4ZvER5X6RHgapj3tvtPyub6wHL7
	 e7NZ9d7OCzLEwNC15FKO2DbZie3iCl3u/ibXFj60ZEbnLMWBiyDFhHG4QSItYuLSls
	 JoZz2PRH9FZvt+kkfx2jHHDaRB8pY/yShsuni+iRM1JM8SGbhXfyIPjljdDHRqAQ4W
	 CtyXckvsyRIjC07mbs/wD9a9omI+xN6vDK1xOGt0ZBnSph21TbNt25V8SU6QTxC29P
	 1nIxDvXz6gK6Q==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a877510541so1096988e87.2
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 12:32:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mNqS9TqsBIJK4LitEOI88yrTScUavrXX2MfeeU0cUunswYc9XQFgUlatejwUGmLos64y75zwyXHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq4j9Z8+KivEcu/rFjbsfZOZz/L/7w0RISOAeg3L5OABX1aHlm
	oT5svP3ERYKNvmbx1tbZQkOGGO/s+6kzy7VxLp678eUDJImU874ybXXgC/Rq9WwrdeYDdD6cwde
	MiqPCKFpiIFDU4VajF7Uj4RcSIkm62Yc=
X-Received: by 2002:a05:6512:2253:b0:5a3:e7f3:1e17 with SMTP id
 2adb3069b0e04-5a87f1ea40bmr82704e87.32.1777923122948; Mon, 04 May 2026
 12:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afhPkLynt7vS793r@wunner.de> <20260504170941.GA648635@bhelgaas>
In-Reply-To: <20260504170941.GA648635@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 May 2026 21:31:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g3f8_7v-8W0SAbn_8vmKUJgpDbgyYMSjv03QjXJ8bCHQ@mail.gmail.com>
X-Gm-Features: AVHnY4JVxZ-1gM7Q1n5FAe474ER8rGfL5asG9eGNbmtZy0CgmCYmYhOwPozDCGA
Message-ID: <CAJZ5v0g3f8_7v-8W0SAbn_8vmKUJgpDbgyYMSjv03QjXJ8bCHQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Drop unnecessary retries when restoring BARs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, sashiko-bot@kernel.org, linux-pci@vger.kernel.org, 
	sashiko@lists.linux.dev, Marco Nenciarini <mnencia@kcore.it>, 
	Michal Winiarski <michal.winiarski@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Eric Chanudet <echanude@redhat.com>, 
	Jean Guyader <jean.guyader@gmail.com>, Alex Williamson <alex@shazbot.org>, Sinan Kaya <okaya@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 7:09=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+cc Mario]
>
> On Mon, May 04, 2026 at 09:49:36AM +0200, Lukas Wunner wrote:
> > On Sun, May 03, 2026 at 01:51:08PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue(s) to consider:
> > > - [High] Removing the read-back and retry loop for BAR restoration in
> > > `pci_restore_state()` introduces a risk of silent regressions for
> > > hardware resuming from non-FLR resets (such as D3hot to D0 transition=
s
> > > or custom driver resets). The commit incorrectly assumes the 60s dela=
y
> > > from `pci_dev_wait()` covers all usages, but standard PM resume paths
> > > only delay for 10ms (`PCI_PM_D3_WAIT`) before calling `pci_restore_st=
ate()`.
> > > Historically, hardware that needed slightly longer to accept
> > > configuration writes relied on the 10x 1ms retry loop to successfully
> > > restore BARs. By removing both the retry and the read-back verificati=
on,
> > > BAR writes to slow devices will be silently dropped, leaving hardware
> > > unconfigured and causing MMIO accesses to result in IOMMU faults or
> > > kernel crashes.
> >
> > Hallucination alert:
> >
> > PCI_PM_D3_WAIT does not exist, it was renamed to PCI_PM_D3HOT_WAIT
> > six years ago by commit 3789af9a13e5, which went into v5.10.
> >
> > The macro is used in:
> >
> > pci_pm_resume_noirq()
> >   pci_pm_default_resume_early()
> >     pci_pm_power_up_and_verify_state()
> >       pci_power_up()
> >         pci_dev_d3_sleep()
> >
> > However before pci_power_up() calls pci_dev_d3_sleep(), it reads
> > the PMCSR register and errors out if config space is inaccessible.
> >
> > Hence when pci_restore_state() is invoked a bit later, config space
> > can be assumed to be accessible.
>
> I don't quite follow this.  In this path, pci_power_up() changes a
> device from some low-power state to D0.  If the device was in D3hot or
> D3cold, we must delay at least 10ms before any access to it (PCIe
> r7.0, sec 5.9).

D3hot and D3cold are different in this respect, so using "or" here is
inaccurate and confusing.

Accessing the config space of a device in D3hot is entirely correct
and doesn't require any delay.

Accessing the config space of a device in D3cold is questionable
because the device may not be accessible, but then the host bridge
should just fail the access.

The 10 ms delay is after attempting to program the device into D0 from
D3hot (or the other way around) and it is observed as required.

> pci_power_up() doesn't do any delay before the PMCSR read.

It assumes that platform_pci_set_power_state() has run and either it
has succeeded or the config space is not accessible which is when
PCI_POSSIBLE_ERROR() will trigger.  Unfortunately, there is no
canonical way to verify that power has been restored to the device
other than attempting to access it.

> That part seems like a pre-existing issue even before this patch.

I beg to differ.

> If the PMCSR read returns PCI_POSSIBLE_ERROR(), pci_power_up() does
> complain "Unable to change power state ... to D0" and return -EIO, but
> pci_pm_power_up_and_verify_state() doesn't look at it,

In fact, pci_update_current_state() changes the power state to D3cold
if the config space is not accessible.

> and pci_pm_default_resume_early() continues on to pci_restore_state(), so
> it looks to me like we could try to restore state to an inaccessible
> device.

So the pci_restore_state() call could be avoided if the power state of
the device was D3cold, but then the question is how much of a problem
that is in practice.

> We do call pci_dev_wait() in pci_pm_reset(), which does a D3hot -> D0
> transition; shouldn't we do the same in pci_power_up()?

It would be good to make them consistent, but maybe the other way around?
