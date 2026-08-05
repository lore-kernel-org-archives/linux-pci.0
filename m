Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D2768EA
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890551; cv=pass; b=XXl/D5mv3AKMZtaafioa9XlGIPb/s3lH53zoPe0ECsMJjZBAMPwNKUXkTQVikbOz+OXjExuRqHu7VOKg1KHcRK26b4IH08qfi9HOCYyOx8+IYA11buGUDvKgfpTzhwa6hIhB++K+yWYUXuDOpghg30vFBUahJcWas58W2NOekkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890551; c=relaxed/simple;
	bh=hROq7CiC5JPsDATrpjzdjLmqG19Lhm6AqmIFcAkuAYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lym8j8Q/jVjf5lXyDRBMT5cxGa8gH7kjn6DgHVesdLuJG+ghgP4MB983oJLz1EJa/HYiV7mKontGLjoiAeJHvQzBXDCd1Q5G/wMdyF+KRZeUUyfj8P6QoQLLwN6WUvjEa575g4ALZgBl8QDXQK6BbA7wharDKDqcHy+jO3EIdeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3I57TFb; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3I57TFb"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-526f963372aso2708671cf.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 17:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785890549; cv=none;
        d=google.com; s=arc-20260327;
        b=OsGvPsiOgohLOHGqMlSVkr2AdCpyeUtI/MWg41P3F88Pt/olfWaRdUFgrk10uGW1AO
         6sycqIuEgS5tNksmgkMn6Me6ycoE1/BFpWkbIyaxWRJf4HUUMFvtVG3TFHZfNgaKuLdH
         BVol/NRcC2vlLozz9Z76xhLuiDQxySD4bjCORABQ/LQ0aGap6CPOphrXIsic/qrkx5oK
         KH+euEY7xXtFw5mEClti35xuEd0MpZ8Plj1zK4zF6zaXqub2KgDSEBV3rjaIwKPAwSdt
         AOMi+pw0RRTLFne8FroiWxZzm5TZF2R9t+V6LY1ByBLsaGJmXDLT11SkwLwkqk4qP8P2
         Ac5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EBErenl0PKIUTYIJwGdAQi6pU7uJpHdyknBzcAbqpF0=;
        fh=sWVlw3RLk6sntwslibTjgnhQpRLFNkdfeigx4mss8RY=;
        b=SKUdZIAXIPumybnnoUUeRiYYTjN5yI+McB4ge/B0DK17Qmc+RzZW3xmfp/GfCD4d7V
         7uQV8C5QlhFxKlzd5hULiVhqlP6h8x9HMDhtuwlCsyqJScCtTDx+TsvCxXUPWTk6Ul9J
         5RfqANvgXJ7LnKEmaXZXJ/WNn2iGDxRtbwUapNQ8zqfIN+db1w8UMNldwehZaNyJp4BF
         eXDtupuj/3yMGJ9vXL1/HBu83YJgJsHESeEcERjL6Ip4N48hR386bZYesCS94uj8p/Rq
         VAgm8MCGhlcdbOLoGzOQAu7l5JPLWiTaHjaQDymC1Vu9FR7QJ/etZfg7Os0BfPSa0Bx5
         jglQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785890549; x=1786495349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EBErenl0PKIUTYIJwGdAQi6pU7uJpHdyknBzcAbqpF0=;
        b=S3I57TFb+a8UhmGqH2j1zO4tfwXbA0gBHJb3HyUd92S5c7kx6y/sTaaKKGleDrUNJk
         XyljxUOx37sfycJHnsUQ7cz75SuMXaMoYwWqeCrGTM+fhdCqHusfDJjH9qfB/KBDc8IY
         CATadaB94s24XDCKYUPe0AtR/+GxjCtNQg7F+xrcPaBa7EI7k0Fx/fuVY25YgxRUpVug
         iyoENy06ripYvkxedm8bNlYKjeSPB3QVqsU1Vtzv7l+KvxK5YNJDAdT6ODbL6NmxsaWx
         zfWehnHcyYE3NDAx/j6DPjFdeGMhrrnb4kVU9L2mt/k9C554o6h5GwL4FJDxoHoMisx6
         zzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785890549; x=1786495349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EBErenl0PKIUTYIJwGdAQi6pU7uJpHdyknBzcAbqpF0=;
        b=lcH6eIblnk3BlqX29hMMeni9EWzPVzOIouoRF+uWCKT6Mw9mIoAUwjfPKqig8zV+fQ
         /M4HQC499/M49wYez27QhFIVw0yPDZRsXd76dN6fvaO70Sz71vS7iZIcrugU7T3pl30g
         oqKk1B5WZ20MHxn3kpx+Hflh9OQ4Jo/SDk3lqi+1ntwXdgRh+3PLhBhmPqRp0nu8Bm1C
         Z/xyTbdeKm+PhulC64x5QWXOamC3yhlM/g5/MJgJtVLuN3ymVTmkM9z80/XVd90OXG8D
         tAKOZr/7diZZeUgUm0wLVvDfHkdTXaGtCcA3evO/Egjsggtw2EDeEtULlqdmOJkedHiR
         i03Q==
X-Forwarded-Encrypted: i=1; AHgh+RqofIlaDf6HOTQGshjozqG7JtvqsNZh5nbMnWJ/3PkJOjPE6TjEmmaXn67+0Z/IJ6vBA5V/JTbRZX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4evz5kNQrmBYTUUFGqgUsg1QEoEQpkhkGmjTJF26pvxyOHTtJ
	O09xQE9cBmwnxNo3XT3nBnmHtib/yPuQSBFhxaPwQEN1rwy8TVUJLjw9nEyVIO11nRtZp7QJyWz
	43Nl+hTZZvezF/Wrf5zixpU172Yl688A=
X-Gm-Gg: AR+sD10j5jH7AZQbzvsAv4kBRtphWSmVIvGfwfyd5QWvZC5QFZXlNCjKDoWCxVLCQ3Q
	XLDZkN3BoeFHND7L/OUF3vTR9o87WyJo9AZdWpsChyGIgS3nEuCHGbqoS0Hzbfvf6DLbzMCg+LI
	yfCrZxNxzVF44UCFNStLktgiCHLJiD2BsHF+5ghyrRtRt7SLhae/KAFNn3V+gzDF/29zBkYySoN
	flWeS9FU5q61bctRGP7gDhCqHKWq6rfOXDrK+RrPJI4cw3qjgbDVDX/pfSOaQ4r9m6iYXvd9i/4
	shhY13n2254wYRoUnei/bh5zXN+TIOT9UJxvIGl2tJqYUtWSwMCgn/Gl
X-Received: by 2002:a05:622a:4cc9:b0:528:2c84:eab0 with SMTP id
 d75a77b69052e-52ce618ca62mr36317771cf.33.1785890548216; Tue, 04 Aug 2026
 17:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803203459.10680-1-derekjohn.clark@gmail.com>
 <CAJZ5v0h78CSSORe_td1gp0n5DDWXN4zcnuXJsz247KYxgs-mdg@mail.gmail.com> <CAJZ5v0iY-SjCG3hdqggbchBA1DrYw04ARyNuzoyO67NF0dt2Ww@mail.gmail.com>
In-Reply-To: <CAJZ5v0iY-SjCG3hdqggbchBA1DrYw04ARyNuzoyO67NF0dt2Ww@mail.gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 4 Aug 2026 17:42:17 -0700
X-Gm-Features: AUfX_mzXjOBFymAjv__F_-spSIDhui44c-22NM2c7rts6N8P-VdcblU9vHlQeSU
Message-ID: <CAFqHKT=4znAiut6LyaR2uWRGVTRGB4YZkWog+Fo0r_ukyq9H-Q@mail.gmail.com>
Subject: Re: [PATCH] acpi: pci_root: Add quirks table for _OSC support
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:08=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Aug 4, 2026 at 2:46=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Mon, Aug 3, 2026 at 10:35=E2=80=AFPM Derek J. Clark
> > <derekjohn.clark@gmail.com> wrote:
> > >
> > > The MSI Claw A8 hard-locks on resume from s2idle whenever an SD/MMC
> > > card is present in the RTS525A card reader (10ec:525a, PCI ID). This
> > > issue is not present on the Lenovo Legion Go with the same card reade=
r.
> > > The primary difference is that the Claw A8 withholds LTR and DPC whil=
e
> > > granting ASPM control to the OS, leading to a split ownership. The is=
sue
> > > can be mitigated by passing pcie_asmp=3Doff, but quirking on the pci_=
dev
> >
> > You mean pcie_aspm=3Doff I suppose.
> >

Hi Rafael,

Indeed, that was a typo.

> > > in pci/quirks has no effect.
> > >
> > > Attempted quirks included use of pci_disable_link_state(),
> > > dev->link_state =3D NULL, manually zeroing aspm_l0s_support/aspm_l1_s=
upport
> > > via DECLARE_PCI_FIXUP_FINAL, and pcie_aspm_remove_cap() on
> > > DECLARE_PCI_FIXUP_HEADER. Only by disabling ASPM on the root hub is t=
he
> > > system able to resume successfully.
> >
> > So if there is a clash between the firmware and the OS, the question
> > is why it only happens during system resume and only for this specific
> > device in this specific configuration.
> >
> > If disabling ASPM globally makes the symptom go away, it certainly is
> > related to ASPM, but it is kind of hard to say what exactly the
> > relationship is at this point.
>
> Besides, does disabling ASPM globally affect what happens to LTR and
> DPC?  I think so.
>
> If that is the case, maybe the suspend-resume code paths skip LTR and
> DPC if ASPM is disabled and they do something to those capabilities
> otherwise?  LTR and DPC generally should not be touched by the system
> suspend-resume paths if native_ltr and native_dpc are zero,
> respectively.

I'll be up-front that _OSC handling isn't in my wheelhouse of things I
have troubleshot before. After reviewing your feedback I
re-investigated my assumptions to get a better handle on exactly what
the mechanism was that was resolved by the quirk and found some
interesting results. The LTR/DPC asymmetry and ASPM disablement were
masking the real root cause of the failure. Upon looking at my dmesg
again I noted that the quirk caused _OSC negotiation to alter the
PCIeHotPlug control state.

Normal boot:
Aug 04 14:33:12 clawa8 kernel: acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
Aug 04 14:33:12 clawa8 kernel: acpi PNP0A08:00: _OSC: platform does
not support [SHPCHotplug AER LTR DPC]
Aug 04 14:33:12 clawa8 kernel: acpi PNP0A08:00: _OSC: OS now controls
[PCIeHotplug PME PCIeCapability]

Quirked boot:
Aug 04 14:37:48 clawa8 kernel: acpi PNP0A08:00: PCI Root Bridge
[0000:00] _OSC quirk: stripping support 0x00000006 (MSI Claw A8 BZ2EM)
Aug 04 14:37:48 clawa8 kernel: acpi PNP0A08:00: _OSC: OS supports
[ExtendedConfig Segments MSI EDR HPX-Type3]
Aug 04 14:37:48 clawa8 kernel: acpi PNP0A08:00: _OSC: not requesting
OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]

I then tested pcie_ports=3Dcompat and also was able to resume. After a
bit of back and forth I found that using pci/quirks.c and setting
native_pcie_hotplug =3D false on the root bridge in a HEADER quirk, I
was able to resolve this issue more cleanlyl. Given that, I'll be
sending a different patch to resolve this once I've more thoroughly
tested it to see if I can isolate it to the device itself and/or root
hub. Considering the possible performance hit you described, I think
that is a better path.

Thanks,
Derek
