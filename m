Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED737BE75
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235739; cv=pass; b=nR1Cdjm/9tO1YXmj5cOQo3vMHvj7YNpP9tZSLtII3ai9oVx6TIPgUjRq0RU6eG/isYDYj26v9wy0RY4DoE/0/gmUyIOYbvb87neefYuMVvgLgO9g4n5MNgjPTz0DhMtJZO3QXfO/gnBPv+yrbS0KpuzWb0h3kFk5fCPf4iZF0qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235739; c=relaxed/simple;
	bh=fqXxS073g/HG3jwynWPnSnuQsshEPXpSPP604bpZEK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjZICHH6vlmG9d509LzfoAaCnsb2E/ByeqB8AKmPsNMD0x1STd4EAZliiLvnegDmL3t8b1DsZQX0OEnEj7LHdwr7L0XNytgxo71+U4XHNyWwIBWEFm6xgv45CydJ+QtMwM+98zN+lRuoi6Yutfb/jjfbnxAt7gHjv6Y7zFWz5SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Eqe/RXl5; arc=pass smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Eqe/RXl5"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-506c00df428so25015821cf.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 15:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235737; x=1772840537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/FABFCfkU9zC4sZduSbPBcYNRUHGz8YpUTlMz82Am8=;
        b=Gr6VhE6uOK4dHOZr/2fzNDEQak7gssU9LRwQ0sm4Zc4EQWrgbJDTAwzmULmC17aAfo
         e4wJmJnZbbSASxYpVcflQEHE2emfwsozk/48VCu8H8Sw17UFRQ2ZBTfKJ7Ahp5KaT6M2
         spwUoqnWiKzf5czlqsaXoUsjIJEseepzdrhedMKC+h4HKCiKFXifEa6+Z7xW/k0gvhCC
         r20yPXh22c4KzpCuMsDtRqGQu+BvhrdeTUoaAsVctbKihTWtX2dJZ6FjH9UO4lGAnvSr
         eH7FQQF6IDy3FtWEQhswYJp2Ffegnj8VhbOftZTGIrVFWawojReK4q8zc3ejv2bH3vZO
         ox8Q==
X-Gm-Message-State: AOJu0YyrgJZk5lb50/7vjJ4KX06nEeRhWixY3vW/Femhb3ZvjAEn6bOH
	MQvH4uXkf+YfJ1wHRpWNCtP9rjgXBSMZ95AhkxkXGQzDAEStWZ1jEXb34Vp0GWT5pjVOlAZmW5f
	A4C8W3MuRdzisYONIZFVp6ffLmT/lRkiBfV/9/mBzzg9ympSvQRpcurch4ZUXEWCMBHakED60rK
	L0RfBHT9cpwNt5Nfb/1oEBVGoup9Zr/UBMMEQkmG5e37Bwt5gmApPOclgAYUU7buyT8DMfLGjNU
	k1WgPS7pxntkrxH
X-Gm-Gg: ATEYQzzBTg4AXa5eDMO5wRVSKnVD/08eMTGDUw1AxrnCyfOLq8eS0UR2Obp/oViqmvK
	VQYb0v1htJ66BU3Qt+pmpZaoIUzXnOwMBI5ypo9n/ZJ4dNWWRkuI3zt47JjBEaGSIJjGTID8WzD
	mM0fRQYlxZ2ZW62ufbWuTWOz+RE4taDSqMoR1Q5wdelfHYeIWa4E5ZniaMtSxK5keNXU/IwR9OS
	IJQ7KsbHsxsndfxm5K1BG3Rn3Aa2I7+3GBQzxuu9P1B1kqO9rdfYEo7DtJscnX99OdKOyQAtaYS
	djQjqbWIjtvvFll0aN/wi2YNtJ62aNsw7ukWveow3GzVR+JEuXgvBAceDAc1l3FHT0ecpDeYNas
	1RzXYzv5l9FIKoKXFsudNuicv+p+wEgmyn0zl2qACr8IkxnwTIuSrPE3ERfi6rmGlIVuEhDqrCM
	a1JcYLVyMB8dwjsIZ/1Leox4Uxs6zeYnLC6M1qO0dbXD9x/s8kMK1KKQi8oH0m
X-Received: by 2002:ac8:7dd4:0:b0:4ee:1ec9:f947 with SMTP id d75a77b69052e-507527caa48mr60966861cf.3.1772235736635;
        Fri, 27 Feb 2026 15:42:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50744a78567sm8103811cf.6.2026.02.27.15.42.16
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 15:42:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-389f0d519f9so15879301fa.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 15:42:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772235735; cv=none;
        d=google.com; s=arc-20240605;
        b=ZPpK3ixP8YL46oLaRo+8X/CA2P+JY+uyXS69q80Au+JmPTqaQhQSS4zlWBhuRQ1fdy
         OJk+b9AA/GfohpF12FtKLmmJmbW3Rz9vD3jl81EgLRUn6cOUXZYi2J19XhKyeJk2nZHw
         ECc2BojXgSZjZmtItlHEkQHXEREZIL1UfGt5psPGAaNZkx3J3CgSwE5KSOyVYzlMuKGT
         4X5Zb8CyEhAb1P5/SEquyvstu3it487iUJ1MyIDDrHaHTje6QcNUeEYLWKweSHqCwD26
         RUMb/HFt6GTPfM6JOF3Zqc+vCL/KkL+6oq4mtYQYDMcgzpKSVo7BcO9dj3VHlCju4amQ
         laxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y/FABFCfkU9zC4sZduSbPBcYNRUHGz8YpUTlMz82Am8=;
        fh=7IlF+BoJet//4Naqb67Be76JSxT1NAv44cZQAn3GAFc=;
        b=axF9xWyqdg+g6If2VC0erQZrJDPeov9mQ6NCBiACQPVY5BZvJx/XIZMXQxlCrWqwzu
         J13V/YhNIphX5kgy2WttqYDH/+E1ytaR6kaUkY0fLKjLERE4OPZdOQAkURwGGQW2knd/
         tgbHA1M46OUyLX8FmQJbvMEp/Uqz6fZK3ArfHwglwtlJZ1Uh+RXXD0CGuIu5Qdqy5wVB
         oeRcoNaURp7Y2Ki6F9wj9tHXOs/zDmhhbeP2aiCdu1/+4V7jw1DqEu6lEpHyFHyHKt2U
         od4fRqVmyj5/l4qMxR7RjemlOd8KlDFnb/647QYM7rhDtNOC50yrdJc6rJMZyBYs2WXg
         XC0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772235735; x=1772840535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y/FABFCfkU9zC4sZduSbPBcYNRUHGz8YpUTlMz82Am8=;
        b=Eqe/RXl5VKQWdtGqKAQf/qbTE0Eq3EFIxiquFQUmGkt2B0c0rPgw5OGJfftmfVeNuM
         JYZqCBgrP7t/JR39OLBVUclTexiM/XnJCsej6pbkDSRzHIKgX42WZjK9AOjFybO4R2Lq
         LpRWqwbr+r5Azh70RaRaBQHt+Q3K3gmFvvWjU=
X-Received: by 2002:a05:651c:330:b0:389:f95d:cd85 with SMTP id 38308e7fff4ca-389ff13bb5cmr20864151fa.18.1772235734717;
        Fri, 27 Feb 2026 15:42:14 -0800 (PST)
X-Received: by 2002:a05:651c:330:b0:389:f95d:cd85 with SMTP id
 38308e7fff4ca-389ff13bb5cmr20864051fa.18.1772235734152; Fri, 27 Feb 2026
 15:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>
 <20260224230550.GA3754701@bhelgaas>
In-Reply-To: <20260224230550.GA3754701@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Fri, 27 Feb 2026 18:42:02 -0500
X-Gm-Features: AaiRm53R5GHQhD9GhtbNzLrSKc80-vr8FO-Gq63CpWQcyey-RQLjngSteD1V5t8
Message-ID: <CA+-6iNwD=bWUBrzVdgPSXw5kqT2SMQH6FqoDxW6gN9qbU=x56w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build time
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>, 
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000745b4e064bd6c9ea"

--000000000000745b4e064bd6c9ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 6:05=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Feb 24, 2026 at 04:10:17PM -0500, Jim Quinlan wrote:
> > On Fri, Feb 20, 2026 at 5:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> > > > The Kconfig is modified so that the pcie_bus_config setting can be =
done at
> > > > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  =
The
> > > > pci_bus_config setting may still be overridden by the bootline para=
m.
> > > >
> > > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > >
> > > We merged this as b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRR=
S
> > > strategy"), which appeared in v5.10.
> > >
> > > In retrospect, I think this might have been a mistake because it
> > > forces a build-time configuration for something that may not be known
> > > at build time and can be set via command-line parameter.
> >
> > I don't see much difference between setting the default at build time
> > versus setting it via the boot command line --  both methods are
> > performed before runtime and make assumptions.
>
> True.  I don't like baking unnecessary decisions into the kernel
> binary.  This one seems useful for a point product but at the cost of
> a small burden on everybody who builds a kernel.
>
> > > But I can't find any discussion about it.  Did you have a use case
> > > where command line parameters weren't usable?
> >
> > Yes.  We have a Cable Modem (CM) customer who can update their Linux
> > version but cannot update their boot loader or its default bootline.
> > FWIW, they only want the option to set pcie_bus_config to
> > PCIE_BUS_SAFE via the .config.
> >
> > > If there's a platform that requires one of these settings, maybe
> > > there's a way to do that programmatically in the host bridge driver
> > > rather than using a Kconfig symbol.
> >
> > It's a CM product which uses a particular Wifi chip.  Recognizing this
> > scenario would have the RC trying to grab the EP's vendor-id (and
> > possibly more info), and that seems awkward at best.
>
> I assume a closed product like a CM doesn't run a plain vanilla
> upstream kernel, so removing the Kconfig option would mean carrying a
> one-line patch to set pcie_bus_config.  There's some trade-off between
> carrying a source patch and tracking Kconfig requirements, but I don't
> know where that would be in your case.

Our goal is to run a plain vanilla kernel with -- if needed -- BRCM
modules, but we've got a ways to go.
>
>
> Could this be decided in pcie-brcmstb.c based on DT or something
> similar?  I guess you said it only applies to CMs with a particular
> WiFi chip, so maybe that's not visible in DT.  But I wonder why it's
> specific to the WiFi -- I would think the important thing is that it's
> a closed system and every closed system would want PCIE_BUS_SAFE.
We only needed it for a specific Wifi chip with a CM board.  All other
boards were fine with the default action.

Going forward, there are a number of ways for them to handle this if
the CONFIG_PCIE_BUS_*  choices are dropped.  One is to use the DT
bootargs with "pci=3Dpcie_bus_safe".  Another is to use
CONFIG_CMDLINE/CMDLINE_FORCE to carry the same param.  And also what
you have suggested above.

If you are just going to modify upstream only, there should be no problem.
If you are going to call this a "Fix" and backport to all of the past
stable versions down to 5.10, there may be some havoc when this
particular product pulls in the fixes.  I've given a heads-up to my CM
colleague, but this info may fall through the cracks.

Regards,
Jim Quinlan
Broadcom CM/STB

>
>
> > > > ---
> > > >  drivers/pci/Kconfig | 56 +++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  drivers/pci/pci.c   | 12 ++++++++++
> > > >  2 files changed, 68 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > > > index 4bef5c2bae9f..15ce948858fb 100644
> > > > --- a/drivers/pci/Kconfig
> > > > +++ b/drivers/pci/Kconfig
> > > > @@ -187,6 +187,62 @@ config PCI_HYPERV
> > > >         The PCI device frontend driver allows the kernel to import =
arbitrary
> > > >         PCI devices from a PCI backend to support PCI driver domain=
s.
> > > >
> > > > +choice
> > > > +     prompt "PCIE default bus config setting"
> > > > +     default PCIE_BUS_DEFAULT
> > > > +     depends on PCI
> > > > +     help
> > > > +       One of the following choices will set the pci_bus_config at
> > > > +       compile time.  The choices offered are the same as those of=
fered
> > > > +       for the bootline parameter 'pci'; i.e. 'pci=3Dpcie_bus_tune=
_off',
> > > > +       'pci=3Dpcie_bus_safe', 'pci=3Dpcie_bus_perf', and 'pci=3Dpc=
ie_bus_peer2peer'.
> > > > +       This is a compile-time setting and is still be overridden b=
y the
> > > > +       above bootline parameters, if present.  If unsure, chose PC=
IE_BUS_DEFAULT.
> > > > +
> > > > +config PCIE_BUS_TUNE_OFF
> > > > +     bool "Tune Off"
> > > > +     depends on PCI
> > > > +     help
> > > > +       Use the BIOS defaults; doesn't touch MPS at all.  This is t=
he same
> > > > +       as booting with 'pci=3Dpcie_bus_tune_off'.
> > > > +
> > > > +config PCIE_BUS_DEFAULT
> > > > +     bool "Default"
> > > > +     depends on PCI
> > > > +     help
> > > > +       Default choice; ensures that the MPS matches upstream bridg=
e.
> > > > +
> > > > +config PCIE_BUS_SAFE
> > > > +     bool "Safe"
> > > > +     depends on PCI
> > > > +     help
> > > > +       Use largest MPS that boot-time devices support.  If you hav=
e a
> > > > +       closed system with no possibility of adding new devices,
> > > > +       this will use the largest MPS that's supported by all devic=
es.
> > > > +       This is the same as booting with 'pci=3Dpcie_bus_safe'.
> > > > +
> > > > +config PCIE_BUS_PERFORMANCE
> > > > +     bool "Performance"
> > > > +     depends on PCI
> > > > +     help
> > > > +       Use MPS and MRRS for best performance.  This setting ensure=
s
> > > > +       that a given device's MPS is no larger than its parent MPS,
> > > > +       which allows us to keep all switches/bridges to the max MPS=
 supported
> > > > +       by their parent and eventually the PHB.  This is the same a=
s
> > > > +       booting with 'pci=3Dpcie_bus_perf'.
> > > > +
> > > > +config PCIE_BUS_PEER2PEER
> > > > +     bool "Peer2peer"
> > > > +     depends on PCI
> > > > +     help
> > > > +       Set MPS =3D 128 for all devices.  MPS configuration effecte=
d by
> > > > +       the other options could cause the MPS on one root port to b=
e
> > > > +       different than that of the MPS on another.  Simply making t=
he system
> > > > +       wide MPS be set to the smallest possible value (128B) solve=
s
> > > > +       this issue.  This is the same as booting with 'pci=3Dpcie_b=
us_peer2peer'.
> > > > +
> > > > +endchoice
> > > > +
> > > >  source "drivers/pci/hotplug/Kconfig"
> > > >  source "drivers/pci/controller/Kconfig"
> > > >  source "drivers/pci/endpoint/Kconfig"
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index e39c5499770f..dfb52ed4a931 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size =3D D=
EFAULT_HOTPLUG_MMIO_PREF_SIZE;
> > > >  #define DEFAULT_HOTPLUG_BUS_SIZE     1
> > > >  unsigned long pci_hotplug_bus_size =3D DEFAULT_HOTPLUG_BUS_SIZE;
> > > >
> > > > +
> > > > +/* PCIE bus config, can be overridden by bootline param */
> > > > +#ifdef CONFIG_PCIE_BUS_TUNE_OFF
> > > > +enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_TUNE_OFF;
> > > > +#elif defined CONFIG_PCIE_BUS_SAFE
> > > > +enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_SAFE;
> > > > +#elif defined CONFIG_PCIE_BUS_PERFORMANCE
> > > > +enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_PERFORMANC=
E;
> > > > +#elif defined CONFIG_PCIE_BUS_PEER2PEER
> > > > +enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_PEER2PEER;
> > > > +#else
> > > >  enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_DEFAULT;
> > > > +#endif
> > > >
> > > >  /*
> > > >   * The default CLS is used if arch didn't set CLS explicitly and n=
ot
> > > > --
> > > > 2.17.1
> > > >
> > >
> > >
>
>

--000000000000745b4e064bd6c9ea
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P6nIShznyqOL2EoCa0IXujxvXUo0pANFYsDhrCVF5JOVPeEL3Y2m+4flRtOI+YlRQoepb+TEVdkY
/g1rlWG7GIYrtHxrFFRvn2/Iqqpv/x5kzJgoTYFOyTTGlXIqGkKTqCWFrN09kJWzhhmxhxtJprJs
KveDLF8yhHSbqmXfKTkT+CIrynXXDro+80qXEXC8CM9W9d+2lDDM+hWTlC6Pt/ikMYf/ZB4K2Nr8
VFruDYGZfAHhh9/lqK3SpS2Z/8cB88K62U+Eb1yNAgMBAAGjggHeMIIB2jAOBgNVHQ8BAf8EBAMC
BaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMwRgYIKwYBBQUHMAKGOmh0dHA6Ly9z
ZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZzbWltZWNhMjAyMy5jcnQwOQYIKwYB
BQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMzBlBgNV
HSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisGAQQBoDIKAwIwNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wQQYDVR0fBDowODA2oDSg
MoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCUGA1Ud
EQQeMByBGmphbWVzLnF1aW5sYW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQiuRLoBkhIaas+1j3yf23P
ffVFcjANBgkqhkiG9w0BAQsFAAOCAgEAp1y0fznw9Uo7UzExANVpYjj+OG1c3C7MhWOvAd7LvfPX
BSFisMaabop5Pyfc/sWzb/jCNfVkkDW5Ij2mzpUsUca2qpILoFhOUT9b0d+nc48MCZ4/Wj6vX5QJ
i9VdYeuv3DYASZsQdH8iYnV5X5YCYo1AO/pyW+M4gG022Nsji9+3A9zkx8JRPDIXkPaDLrzcGD9L
rEVIYnnSK9b/4VHzITVgEmSsUTAIzOD6M6TzgrSoJZFmKNMXlAqo+m1nlNyJkM4OyOvaDx5y+2hA
mp4tzD9gJNU9TzQpQRZFz53+c8BkCpzvcHqT8lMluRlCrIYWqaSOUDHX9HPYvzbtO4iYV+irMdGN
2PBz6Wtfaoi1xTfFSKK9ON1mvxACK+E4B5gycSoZcOBADTbGXLDMqiygl7Wz0oooAPqZpUnaD1nc
x/pX7N8Ff6YK+iN3vVah34vLkE1CMFyDQMtyTCzQPW+7XCTxCL9ML3LBAF+eNAtKpPOsrGIdRHy5
6oQr+2ZquSMvWj447q4v3sk1LHs7ata+sP8/kmcPKn3WPXQ/4xMevqFVyv2VIFrBK9ZnOZ//fz8R
7SjJ7t2kOITvbWcMkizMc33S9hfmYiXaVTjIi89NiO3EXCJouYShpptgGNG6mpYHcddnfdKiILOS
06KlKNuHO4IpRmaGrzcDjsUQQSn8amMxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwHM7pH5w7o7Qb7yXUwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIDg6
cKZYWyC3kuFVbQ8vL+3K2NoJdtnC7NmSPyLhxOy7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDIyNzIzNDIxNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHTzGcNL1D2Eg/ojKM6wF/asvcVqgnPJ/l/KquDc
Vu5VWOTr8RzoqxyGSprU1DtrrYVP5oFt/GzFnTxrIs8lAJYKxOHIhmTbVG5+0Sa1/MJrV4tfx1Qz
e1lIJhr/A7fxijC5ucfTrm5BzYlGgShIBiOINDj5d9QeEW//4ippqLBtM73XOro5ByKq2vCOwUua
Q9lTYI+x/poo+lBgmZyjeohspPcS+o/HrEDorYit3cd9iaDbeoIeU3QdI22Pr0FNs02eNdSC16A1
EqJEOljFzLAYz3ragbF4wS03IEVDEw8v682YdYoWpvoLxVnmRWcO0/0BO9dnOEXI4y8zUh0/XfQ=
--000000000000745b4e064bd6c9ea--
