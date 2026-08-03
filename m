Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62671384CE8
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785757674; cv=none; b=D9+2zUjGE5401/+Kk1cVyMfJXSZucKB9gxbNdbt6Z9OYrcU7l0h74+d1GJbEuumj/W0wHXHpn97M1ZwJ6AYrcOC9eqrM//qvjzP510KHoVyotqQknMpjRS6g9txhLnxz1DiABsC/ilJhUZrw+druxehSJFOw+95l5JXy4ZPYQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785757674; c=relaxed/simple;
	bh=rR6zMoyOSoeaPAY4QDUTfX/jBiGmMCpHYTxQwrfi974=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McFg4IjmoIZRY0AKtlvgWdcqzjmwwhFiF2VWjm+HHRC9J2b9aHEEsqKFbEz+RBpSzoNgXoHNlo6YP0p3st38nIQu+omNm6dZ+2gRhPCurPnQh6NCSofihbXBcZSnGQ2BUv0KbO90n9rYV4rxqTtTa71jsmib0EciIJ0l96T7yDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp9eCsda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp9eCsda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275B91F00A3A
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785757673;
	bh=DzlqIpKk/CHl4n1/5d741EN421iVp0C6MN5iWAjVrMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Sp9eCsdaLTycxJSgEeqwyVJ+WOwW7HXkCEhKRxe5+B/ZyI2dgwFuzTT56yL3iAE8v
	 RrWWUraLJnQy2qfRvDba7/FXBoyU7sGogVs1rvO7Q6l9z4vDnkfPHgdweFUXi1umuT
	 nM6O8DHbDGTd5BDTEveIvHJrV727T6EYcBGdtxEMz1w8q2SH+Bw/4mD/LIIm/7lbH5
	 QoRBOJMw+NEspxwP1EDjUeA+i2CRsSoL/6WOPMd+VKnV0lSObrnvLYziYeHJvFlL6m
	 OpUsUOAXfltoY+k5mvu2RFRr/sCsMwc8YlYk/Z7NPImFCb2S6czHViQA7Bu7QRVZtX
	 xqqE+Q0utbBLg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeba09900bso2242142e87.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 04:47:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqgh+nrU08bYBi95op1wTeoWhEoeZPG7cr6elRXblRjnpyXwnSJQDOz5sIfQ2x+9d1E6nEc+VI05Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgAZWBG9Czm+NLMx6ak+tnaOmErRgbOfeb61tK1ZYTfbmCpV+
	FjXTw+86yrFuWHpBHv8na9S3phlPFl2be4M2ucZYSFC0a0u6lwswvYjgKwV0e3/a+dDi4qT+9ZV
	UkJ4eOq6JEDf9y1WTIfml12Pt8kgYxAY=
X-Received: by 2002:a05:6512:2308:b0:5b2:d876:514a with SMTP id
 2adb3069b0e04-5b2e4f3e5c0mr1968070e87.26.1785757671599; Mon, 03 Aug 2026
 04:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731090820.493064-1-kazuma-kondo@nec.com> <20260731092147.B7C531F00A3F@smtp.kernel.org>
 <c8b237c8-6e2a-4648-99ea-a28fdd2404d4@nec.com>
In-Reply-To: <c8b237c8-6e2a-4648-99ea-a28fdd2404d4@nec.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 3 Aug 2026 13:47:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iNndQe9q4sK-4b6ZBH3ZRPTE+6eTiNQRwVdtazi=KvCQ@mail.gmail.com>
X-Gm-Features: AUfX_myRk7Gekei68no7tFcbq46xnbEP4Bry3lVldfBvsM9hq7F0OnmKBHKCY9o
Message-ID: <CAJZ5v0iNndQe9q4sK-4b6ZBH3ZRPTE+6eTiNQRwVdtazi=KvCQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
To: =?UTF-8?B?S09ORE8gS0FaVU1BKOi/keiXpCDlkoznnJ8p?= <kazuma-kondo@nec.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:05=E2=80=AFPM KONDO KAZUMA(=E8=BF=91=E8=97=A4=E3=
=80=80=E5=92=8C=E7=9C=9F)
<kazuma-kondo@nec.com> wrote:
>
> Hello,
>
> I received review comments from Sashiko:
> https://sashiko.dev/#/patchset/20260731090820.493064-1-kazuma-kondo@nec.c=
om?part=3D1
>
> On 2026/07/31 18:21, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Early return bypasses ASPM disablement for non-PCIe and CXL ho=
st bridges without _OSC, causing an undocumented functional change and pote=
ntial instability
> > --
> >
> > --- Patch [1]: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for no=
n-PCIe host bridges without _OSC ---
> > commit e68d29f653a1c34f8b7b08baaa548e2ff2d3663f
> > Author: KONDO KAZUMA( $B6aF#!!OB?? (B) <kazuma-kondo@nec.com>
> >
> > ACPI: PCI: Avoid misleading _OSC messages for non-PCIe host bridges wit=
hout _OSC
> >
> > This patch skips _OSC negotiation for non-PCIe host bridges that do not=
 define
> > an _OSC method before attempting to evaluate it. It aims to prevent mis=
leading
> > messages in the logs on some Intel servers where the OS appears to nego=
tiate
> > with the platform despite the lack of an _OSC method.
> >
> > Link: https://lore.kernel.org/linux-acpi/d0be949d-0e21-472e-a44b-cedb1d=
d8695d@nec.com/
> >
> >> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> >> index 4c06c3ffd0cbb..3a24d018436b4 100644
> >> --- a/drivers/acpi/pci_root.c
> >> +++ b/drivers/acpi/pci_root.c
> >> @@ -574,6 +574,12 @@ static void negotiate_os_control(struct acpi_pci_=
root *root, int *no_aspm)
> >>              return;
> >>      }
> >>
> >> +    /* _OSC is optional for PCI host bridges */
> >> +    if (!is_pcie(root) && !acpi_has_method(handle, "_OSC")) {
> >> +            dev_dbg(&device->dev, "_OSC: negotiation skipped (method =
not present for non-PCIe host bridge)\n");
> >> +            return;
> >> +    }
> >> +
> >
> > [Severity: High]
> > Does this early return unintentionally skip disabling ASPM for these ho=
st
> > bridges?
> >
> > The commit message states this change produces no functional issues and=
 only
> > removes misleading messages. However, before this patch, if the _OSC me=
thod
> > was missing, the function would proceed, fail the negotiation, and fall
> > through to the failure path where *no_aspm =3D 1 is unconditionally set=
.
> >
> > By returning early here, it looks like *no_aspm =3D 1 is completely byp=
assed
> > for legacy host bridges.
> >
> > Additionally, is_pcie() only checks for ACPI_BRIDGE_TYPE_PCIE. Could th=
is
> > cause CXL host bridges (ACPI_BRIDGE_TYPE_CXL) to evaluate to false here=
?
> > If a CXL bridge lacks an _OSC method, it would take this early return a=
nd skip
> > ASPM disablement entirely, which could leave ASPM enabled inappropriate=
ly
> > without firmware negotiation.
>
> I think Sashiko's review is reasonable. According to [1], unless the
> platform explicitly grants the OS control over ASPM via _OSC, the OS
> should not change the ASPM state configured by the platform.

Though ASPM only is a thing for PCIe, isn't it?

> Also, as described in [2], if CXL 1.1 hosts do not publish a CXL _OSC,
> the OS should fall back to the PCIe _OSC (just as acpi_pci_query_osc()
> does).
>
> So, negotiate_os_control() should skip _OSC negotiation only when a
> legacy PCI host bridge does not have _OSC. For example:
>
>         /* _OSC is optional for PCI host bridges */

The comment above is somewhat redundant IMO.

>         if (!is_pcie(root) && !is_cxl(root) &&
>             !acpi_has_method(handle, "_OSC")) {
>                 dev_dbg(&device->dev, "_OSC: negotiation skipped (method =
not present for legacy PCI host bridge)\n");

Please make the comment say "Skipping a non-PCIe root without _OSC" or simi=
lar.

>
>                 /*
>                  * Disable ASPM unless the OS has been granted control ov=
er it
>                  * via _OSC.
>                  */
>                 *no_aspm =3D 1;

So I agree that setting *no_aspm to 1 in this case is a good idea, but
the comment above is slightly misleading.

I would just make it say "No ASPM for non-PCI host bridges" or equivalent.

>                 return;
>         }
>
> If I have misunderstood anything, please let me know.
