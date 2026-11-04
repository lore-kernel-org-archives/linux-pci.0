Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802303;
	b=2rYz+ulPCBr32IvOWXhhsiIDpCClqol11bFzGP9vliOdC5tvJFkuTZOuM2aRrVhsppJc
	 R9WjANAoQpoAcj9Zw6TA/fD8499aV36xh4OW7b9pIYrZi2dZiEY6ZVDj3bc8NUyyrs64e
	 95Zq4UgdZfoztUAVDttTnZhg7mMqTkwMG+z617nOFdX8Rn05uhVgDPLtoBy4AwfvJt7Fa
	 s2In4HioiQWXz547STWJn0eLdorO8jlri+8XYnwEOy9QQsTJL/XJgAIOPGDluIxVInGHQ
	 t4edauWDmSY8Hdqh3KO8ZYaDajgqoNflaaEgyeAlz8/tFOs0hSzBDhClMduioTDwEIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802303;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TvDBwQZo6/m82PHmQTlDUFZg6Jc+mwyR6EdZGMpMfhE=;
	b=1pUBLobm1i88gNDwBeHjAW/xSu50EPrTa4AZqD5CHZWYlRmvZxK6oRejlIzyhBKuvUNr
	 3tVUmIeVTrpsI9fN1byOgOMHNOa3DE8ObOD9+QPrTDZq/QnF7/1IDtJlz7ZtT6POcvdnR
	 sgiixFn0MWU3SPuaNhk1MKSp21JeVemEmpgQT0raaD3Xf3G3GGL8wyfp4wcmy1+LiTDaA
	 PfGlcvNnIH48bcned2+7oPyzd30h/2HPnC6CoXCJjugaxlVVFNjBA3w6uM9utqOily9/M
	 45FcbQ86fJncozw/j8oJ4gqzIjFpk7gGdNHfCOS2q2RVjl84bcRJVnWtr5gMxbhpghg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzidTxHN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB6606A32F
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzidTxHN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAA11F0093A
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 14:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802302;
	bh=TvDBwQZo6/m82PHmQTlDUFZg6Jc+mwyR6EdZGMpMfhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nzidTxHN45nMUeY/+EhDtWby3M3540v2pvHyNJPaSNgg7AC/5/wPzILWuUal+Wka7
	 WHuiievjTU3eQn8D2RQOSwK2J8l2ji1lC+cQHRCPCbsE1tm/POBmnlggSutqNjw0Pb
	 MkRCBH5IALFPXpNmTz82YFyYFcFFbAIAbt8E4KNqbMyFqLROCnnsVy/H2krQ7PNkP3
	 UaUJ0w9hy660b00bcKz3VJhT67hMlbKiPU5a1LgRitHphQCsIgfJ3YdqMLcnqit1rx
	 nVtsri3j0+fVhBEkSDHbxZVWbLe/ZWrW5bVbpNNUQaRERbJ1vGPwtIW03VNVQdCFls
	 tu62oMSyAAlOw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ac97e45a79so6523861fa.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 06:25:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwK7Tf01uQJP/y2rsIuKB6WRHn+Ne1fMv5FrPTPDqcQc5I3uyZ28aIfG82BMmX4gTspSSnPTK7ZU9E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9mexTtkrnZReglwJwR641nW+Hft8M7WKPnAIPY1ZIjAx4Fl4XI
	jon15JVrgYOUwhmD7orUMddtOFfDvgwpzsfPZrnncz/0z0TyJ44CvXBQ3YMWkad6NNA/1Iuft2F
	Y6FthDicW18OdnL1B8syVwL1je9ZRdEA=
X-Received: by 2002:a05:6512:3a94:b0:5bf:d54c:1f1d with SMTP id
 2adb3069b0e04-5bfd9599874mr5967891e87.52.1793802301013; Wed, 04 Nov 2026
 06:25:01 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 15:24:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jCDGUL3ZzbOaiN2V0qeyPDDZGXaGmhrJhYCOToEo8p3w@mail.gmail.com>
X-Gm-Features: AclHuK-zbzu2M6-J6vtZBI53zXXr4jA2ZGo354i2EqRYCxNRIruPVfgUbCGRoOY
Message-ID: <CAJZ5v0jCDGUL3ZzbOaiN2V0qeyPDDZGXaGmhrJhYCOToEo8p3w@mail.gmail.com>
Subject: Re: [PATCH v5] PCI/PME: Resume Catlow Lake Root Ports on PME with PME
 Status clear
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Lukas Wunner <lukas@wunner.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 8:31=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
> Status register when they generate a PME for their own hotplug event.
> The PME interrupt itself is delivered.  PMEs from devices below the Root
> Port are reported correctly.
>
> PME and hotplug share the same interrupt.  When a hotplug Root Port
> runtime suspends to D3hot, pciehp disables hotplug interrupts and relies
> on PME to resume the Port.  On a hot-add the Port signals PME, but Root
> Status stays clear.  pcie_pme_irq() then returns IRQ_NONE.  pciehp_isr()
> also returns IRQ_NONE because hotplug interrupts are disabled.  The Port
> stays in D3hot and the new device is never enumerated.
>
> Mark the affected Root Ports with a new PCI_DEV_FLAGS_PME_UNRELIABLE
> flag.  If such a Port interrupts while not in D0 and PME Status is
> clear, pcie_pme_irq() resumes the Port.  pciehp re-enables hotplug
> interrupts on runtime resume, and pciehp_check_presence() finds the new
> device.  pciehp itself is unchanged.
>
> The workaround only applies to quirked Ports that are not in D0.  AER,
> DPC and bandwidth notification also share the interrupt and stay enabled
> in D3hot.  If one of them fires while a quirked Port is in D3hot, the
> Port is resumed without need and runtime suspends again later.
>
> This affects all steppings of the Catlow Lake PCH.  A public erratum is
> not available yet.
>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://lore.kernel.org/linux-pci/ara-_IPXV_i90if1@wunner.de/
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Makes sense to me.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> Changes since v4:
>  * Moved the workaround from pciehp to the PME driver (Lukas). pciehp
>    now keeps clearing HPIE on suspend as before (Bjorn).
>  * Noted in the commit log and in pcie_pme_irq() that PME and hotplug
>    share the same interrupt (Bjorn).
>  * Dropped the PME Requester ID reference, since the code doesn't use
>    it (Bjorn).
>  * Dropped the "D3hot to D0 transitions" wording (Bjorn).
>  * Updated the quirk comment and message for the PME driver approach.
>  * Dropped Reviewed-by from Lukas since the approach changed.
>  * The v4 approach in pciehp also fixes the issue on Catlow Lake. I am
>    happy to go back to it if that is preferred.
>
> Changes since v3:
>  * Moved quirk from drivers/pci/quirks.c to arch/x86/pci/fixup.c (Lukas)
>  * Renamed function to intel_pcie_pme_unreliable for x86-specific context=
.
>  * Added Reviewed-by tag from Lukas
>
> Changes since v2:
>  * Switched from pm_runtime_disable() to PCI_DEV_FLAGS_PME_UNRELIABLE
>    flag approach to avoid power regression (feedback from Rafael and Luka=
s)
>  * Keep hotplug interrupts (HPIE) enabled during D3hot instead of
>    preventing D3hot entry entirely
>  * Port still enters D3hot for power savings; testing confirms no impact
>    on PC6 package C-state residency
>  * Modified pciehp to check pme_is_broken() before disabling/enabling
>    hotplug interrupts during suspend/resume
>  * Made quirk comment generic to cover both PME notification and status
>    update issues, with Catlow Lake specifics documented separately
>
> Changes since v1:
>  * Removed hack in hotplug driver and disabled runtime PM on affected por=
ts.
>  * Fixed the commit log and comments accordingly.
>
> v4: https://lore.kernel.org/linux-pci/20260323223056.3119060-1-sathyanara=
yanan.kuppuswamy@linux.intel.com/
> v3: https://lore.kernel.org/linux-pci/20260316220807.2433661-1-sathyanara=
yanan.kuppuswamy@linux.intel.com/
> v2: https://lore.kernel.org/linux-pci/20260213231428.613164-1-sathyanaray=
anan.kuppuswamy@linux.intel.com/
> v1: https://lore.kernel.org/linux-pci/20260210172231.1465275-1-sathyanara=
yanan.kuppuswamy@linux.intel.com/
>
>  arch/x86/pci/fixup.c   | 46 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/pme.c | 24 +++++++++++++++++++++-
>  include/linux/pci.h    |  2 ++
>  3 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 795d81c7a4de..eb3703e1cdbe 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1180,3 +1180,49 @@ static void quirk_tuxeo_rp_d3(struct pci_dev *pdev=
)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1502, quirk_tuxeo_rp_d3);
>  #endif /* CONFIG_SUSPEND */
> +
> +/*
> + * Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
> + * Status register for a PME they generate for their own hotplug events,
> + * although the PME interrupt is delivered.  PMEs from devices below the
> + * Port are reported correctly.
> + *
> + * pciehp disables hotplug interrupts when the Port runtime suspends and
> + * relies on PME to resume it.  With PME Status clear, pcie_pme_irq()
> + * ignores the interrupt, the Port stays in D3hot and the hot-add is
> + * lost.  Mark these Ports so that the PME driver resumes them instead.
> + */
> +static void intel_pcie_pme_unreliable(struct pci_dev *dev)
> +{
> +       dev->dev_flags |=3D PCI_DEV_FLAGS_PME_UNRELIABLE;
> +       pci_info(dev, "PME status unreliable, resuming port on PME interr=
upt in D3hot\n");
> +}
> +/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, intel_pcie_pme_unre=
liable);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, intel_pcie_pme_unre=
liable);
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 4996cc4789f3..56c22e416788 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -276,11 +276,33 @@ static irqreturn_t pcie_pme_irq(int irq, void *cont=
ext)
>         spin_lock_irqsave(&data->lock, flags);
>         pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
>
> -       if (PCI_POSSIBLE_ERROR(rtsta) || !(rtsta & PCI_EXP_RTSTA_PME)) {
> +       if (PCI_POSSIBLE_ERROR(rtsta)) {
>                 spin_unlock_irqrestore(&data->lock, flags);
>                 return IRQ_NONE;
>         }
>
> +       if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> +               spin_unlock_irqrestore(&data->lock, flags);
> +
> +               /*
> +                * Some Root Ports don't set PME Status for a PME they
> +                * generate for their own hotplug events.  PME shares its
> +                * interrupt with hotplug and the other Port services, so
> +                * only do this while the Port is not in D0.  Then PME is
> +                * the only interrupt it can signal for such events, so
> +                * resume it and let pciehp pick up the event.
> +                */
> +               if ((port->dev_flags & PCI_DEV_FLAGS_PME_UNRELIABLE) &&
> +                   port->current_state !=3D PCI_D0) {
> +                       pci_dbg(port, "PME Status clear in %s, resuming P=
ort\n",
> +                               pci_power_name(port->current_state));
> +                       pci_wakeup_event(port);
> +                       pm_request_resume(&port->dev);
> +                       return IRQ_HANDLED;
> +               }
> +               return IRQ_NONE;
> +       }
> +
>         pcie_pme_interrupt_enable(port, false);
>         spin_unlock_irqrestore(&data->lock, flags);
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96..d3915a3d59b9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -266,6 +266,8 @@ enum pci_dev_flags {
>          * integrated with the downstream devices and doesn't use real PC=
I.
>          */
>         PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIAS =3D (__force pci_dev_flags_t) (=
1 << 14),
> +       /* Root Port does not set PME Status for its own hotplug PMEs */
> +       PCI_DEV_FLAGS_PME_UNRELIABLE =3D (__force pci_dev_flags_t) (1 << =
15),
>  };
>
>  enum pci_irq_reroute_variant {
> --
> 2.43.0
>
