Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA353AFCE5
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220032; cv=none; b=aXDhUjVdqGbhAhlgORe8sykT9rLoN1RXl9PBTYIC0EBAbNQyRVcA0WMEkblXtlWcpkYw9r6YVsgO6QCp5H+9NHjR+zCZIniDgwpl93WMzPrq1l7KJpmOtdOffe3uvfwvsHiA0DK6LlDZmHt+JeZjEjLgB+GDtNEaLnB1ap3gHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220032; c=relaxed/simple;
	bh=GnMsOn2FxijKLEEE78xxFX8lsvMcvElNL6rjlxEfGZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiiTXXTpPiSLDl0B4VKbXgG291iRnaswwdgCgd/+epAXWMSnSEZ42XCl24fLLYtnfGSLxFTvW+0mKBcL2zQSbAQnIB5pq8HRKUfCDsTqL+BgFp55mA+992TqTcuZxd9aAmkqhWERwVuRKDsCuHonNZn2reAaL9nS7CksLDI0L/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgHwWiGU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgHwWiGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD751F000E9
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220019;
	bh=Ubb1ojwWucMPdKao8wXbeBk6fXEn7lIqP1RDM767QUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PgHwWiGU2NQKyzjc1qtgZznOknE2k1/n2ym2qgMEl9PNsckrnmd4IK7V2Wy2nuVy+
	 caasqhoT0G6cf0RhA+f4gBylMWksNKrCGMa/TR0nyiQVFkSGQHIpkflhsL/BpegY4F
	 zFgeoCuzI0Ej1qKUoy6naRhlr3zUgBo1EGE4TbHuF2Z6fAfqVvJQTxVNyzqJ+eUFQ0
	 smJUQNm4thq3cSm9c8Fx6V1UHdAOkYYCQVEyFOIeyTKXblbYbTZjxkT9f6W2PKpRBb
	 BbHHkhlK5bRqcgI2AyAuI/Fv4UWAEkxRMlecaU/7KFyqwXl6URf2WoVEL7ovtsQP5S
	 MY7jsvB2VMLtw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso6593078e87.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 09:40:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro8q03HutPEybwcUqyArZl2EMpllih4rwaHPQg6MDofa/cU+tyD2rluNO8ulZ7oWHVbA4J78lYGOXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtsuXRfcgBp34rvYonE3GLVZMZjeJeFdCHqrttlNS9XzCdCT9
	EENdbIGcYFdQAHiBrUFoZKddM+pelnFntkMMUJHE76sbnYMw4alyKxZeCnlrIEt5WaA3N05YFB2
	3TV3cyPP7EUUbUkYrwDOHfav9rWFXHEI=
X-Received: by 2002:a05:6512:3c87:b0:5ae:bf46:2acc with SMTP id
 2adb3069b0e04-5b159b92c1emr2765512e87.63.1784220018125; Thu, 16 Jul 2026
 09:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12935400.O9o76ZdvQC@rafael.j.wysocki> <3430928.44csPzL39Z@rafael.j.wysocki>
 <20260716141844.4A3171F000E9@smtp.kernel.org>
In-Reply-To: <20260716141844.4A3171F000E9@smtp.kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 16 Jul 2026 18:40:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ipEPY4WnckVWjHrAXK36WsQ4dy9PqskAU6Nfxj8315FQ@mail.gmail.com>
X-Gm-Features: AUfX_mzAyF749w4YSOeuZuyl-WftquA2PRFLDPKhrj9qEzVnxDMkmjuMIVVq5cM
Message-ID: <CAJZ5v0ipEPY4WnckVWjHrAXK36WsQ4dy9PqskAU6Nfxj8315FQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()
To: sashiko-reviews@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 4:18=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Use-after-free in acpi_get_pci_dev() due to unpinned acpi_device=
 pointer
> --
>
> --- Patch [2]: [PATCH v2 2/4] ACPI: PCI: Introduce acpi_dev_get_pci_dev()=
 ---
> commit 96691f509a95b92252e42efea5c07ebf2acebfd2
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> ACPI: PCI: Introduce acpi_dev_get_pci_dev()
>
> Some acpi_get_pci_dev() callers already have a struct ACPI device for
> which they want to get the struct pci_dev pointer of the associated
> PCI device. Add acpi_dev_get_pci_dev() to handle this and turn
> acpi_get_pci_dev() into a static inline helper.
>
> > diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> > index 402b97d121381..bff2ca035fcf3 100644
> > --- a/include/acpi/acpi_drivers.h
> > +++ b/include/acpi/acpi_drivers.h
> > @@ -59,14 +59,19 @@ int acpi_pci_link_free_irq(acpi_handle handle);
> [ ... ]
> > +static inline struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
> > +{
> > +     return acpi_dev_get_pci_dev(acpi_fetch_acpi_dev(handle));
> > +}
>
> [Severity: High]
> This is a pre-existing issue, but does this inline function expose a
> race condition with ACPI hot-remove?
>
> acpi_fetch_acpi_dev() returns an unpinned acpi_device pointer without
> incrementing its reference count. If a concurrent ACPI hot-remove event
> occurs immediately after the lookup, the device object could be destroyed
> and freed by the hotplug workqueue.
>
> When the dangling pointer is passed into acpi_dev_get_pci_dev(), it
> gets dereferenced here in drivers/acpi/pci_root.c:
>
> acpi_dev_get_pci_dev() {
>     ...
>     guard(mutex)(&adev->physical_node_lock);
>
> Could this be prevented by using acpi_get_acpi_dev() to acquire a referen=
ce
> before calling acpi_dev_get_pci_dev(), and then releasing it with
> acpi_dev_put()?

This just retains the previous behavior of the function in question
and after the 4th patch in the series, it is not a real issue for the
last 2 remaining callers.
