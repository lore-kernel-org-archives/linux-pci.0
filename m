Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D01EB5E1
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967436; cv=pass; b=OqYzgCRTfO+gV6slH55whbVk+XKCTqzIU0PMqcx3WIgLFutUP1Z0HChUCF35HEqcmLs9sS2T8T/xri8xeI8u+6d5w0KRE/jKRnTGmsOPn8MgYS3fq1m6jotfPUy2Rtoc0o66wZD3MRfB3toJz2FcHkPg+vKEpTGtHHtK7Ky8zIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967436; c=relaxed/simple;
	bh=elVVRfK1LsoT5rqDw7kQMhatrByH9FXqXiNlOlih740=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJ6DlfP6HwNQGBeszjcrITDgC2CQ/JfKNdxOohvheQI9z/4QTtw2omixRgl4HSs163Zos2/pWnFH9tyRs9V18VoGdxFnQEnoyrKySfNZGGkyorzaRx53jHqQ4gv19z1vHwAzU+dkTzQK0v+JXbnfdx/FFpGLqmDgwD0a86bLSkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UyxusLJp; arc=pass smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UyxusLJp"
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-5674689e507so2528897e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 13:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771967432; x=1772572232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDWJucdoUfy9BMkP3+pz5hUeYcqXSeuUH00YgRisRKQ=;
        b=bFedzKnobA+XSros9ERl7v/ybtnOzcbNQwCvGnSNOhm3myNM0fx1nB+a56hMD3vktd
         UYCuCjFyS9fMgFbiV7TpyV+1muG7oAxffFzuGWN7fjJ1GXmzZtTyeYwD4OzvwBKTiF09
         ZSYbyMCBaHij3K/7WnAFfT2+3YGCAfNNLPvvajQ/nX3YV0l/uwDeNcGdghpMHo9Ma4N4
         AjzQWMiE77VViTfRjKVgEAzXbZqStfxcv2iQPJd5U7EIxz2lNQzRnMoBMkyIDs4yHixb
         G+2Gp141E+hdF41yQu9xUv4cQFf9Lf770HSYFmdUOdOpKTOfUUCfaU8EpNCRzMWkTiAN
         mRtQ==
X-Gm-Message-State: AOJu0YztZK0Eh4n1XwdTQB217U4Y33bwEEmCBudKXM37H8hVsWwdNkaO
	21maFA3o7DhQZvrLm++lVf047U8/rjEdxzlZvTjPHN3+HiMGr7EnawaXGuBHUvrTjOK6RGxTfEi
	hHox4nlfSc4SDJqnS/qM1NqOTBrC8zbXBgPxTuYd0kSfiiYAEUTT7KuX+E5oCHU/e2mGxMPoEDx
	nRprdgByQkT1gpS87aADL9wtnQUbgPjQAZ1Wczuz8DvsXvUlXgbkb4OHfS+zN5oxoVurqB2mAUK
	8Ue3yiV2ybiyNr7
X-Gm-Gg: ATEYQzxjjfUzkf5DCn3uP3EwHB4EGAOkwu5QYqL1M95VL93RdFw7GP1WuXATETs9/uw
	Dlr4YgXYPZAg6m8caO1XqkmYiilhwSUii5DGO6UGY5Zc9Fqp4M1zhvItWo2zHG24XnZZ/ftYi4D
	rsMrb6N8bPDjnvlI0MA76Up5FGigNWPiA2f8uEDV7Ya/C38BHiLbArtBts662Qv7noHrJIGWg0N
	OCqaJVxxvT8YdL96/j+abNTbUhrUJYbqpabpqoj9GINLHHOOGrKTUfRvnCb/2VmMZFolwgUUyGU
	X8CuGDH51rdqIeSTWLfBm6CaqAoOrPnqrI8WnaPAShGDGNM8M0D2jVKABHERSnM2pCTg8YaGyza
	/JvxTBzUFLiWjLayiPUNGInJFdnV2Jnkk0AAqcjDva83QSK+Odocm8CC1PVdTNEJzR0r00Xn69m
	fvaNIJcAzQ/j7QIWj+BnHFbDEZdBZL0LS6bUH+cr/MvOdDKZgV32QVZnyoXsGz
X-Received: by 2002:a05:6122:1d53:b0:55f:c41f:e841 with SMTP id 71dfb90a1353d-568e4904ef1mr5293396e0c.19.1771967431919;
        Tue, 24 Feb 2026 13:10:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-568e5866a7fsm2001322e0c.4.2026.02.24.13.10.31
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2026 13:10:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-389e0db12cbso740631fa.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 13:10:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771967430; cv=none;
        d=google.com; s=arc-20240605;
        b=kQXuTP43g7EnHawwA54+iFFcwsasLgFn3GcishZXwePseJyObmqugvngPiEqTnh5Sb
         o6KMcTKklPmZQ26mSImC+RM5AnXufg5EJHLbcRmxTj/uLI5tBi5IEzSemvGD9qTr+Eur
         PkjDRiAbd1RIlCgMQIPyHIrM13E7Wc4bXeV61TVES255r7hBGyXZYZmxbuKukAtb8MwY
         y7oyk6tcXl2oUR3JT0oGPOsd0EOAVgUPpk7yQoam+xE6DWOPEze9DfjOzHRHOv8R+s1w
         sZSkertBX77UsyZc44ATTCeI/JMQcIYp3HffuEVBbzEShO+ERvIgqp65MwbCQgWyuday
         UMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UDWJucdoUfy9BMkP3+pz5hUeYcqXSeuUH00YgRisRKQ=;
        fh=7IlF+BoJet//4Naqb67Be76JSxT1NAv44cZQAn3GAFc=;
        b=bBfe0acvO1TEoJ/avRsHqJocwAq4EsQHMqRlb9wM+ME1wz+r9i2ILVsSPHPkSpJrMD
         bQbf6TrT2vnYPfpMbB+NKNXGu8bDAAzX6qFdMIFxK59wRc1CdKhD1ay4Nd0+NvDhCRQd
         TfCbCOLBVygprueiOnMDlhCsCVabcNRxsl32Nvp4Qd9wprdLzL6C3A7Gt5OYS4ct3qX6
         YS2QQ7bLQnMZPLHeP/ikMXFHt6GXNFWFyvLknjLdAgzLnMd6lhmDFzqEhncFOKdjYCPG
         mTnqrmBMdH86bYK6TnHYlv+3M+IA0j4H6IQIBtgQD41EuhsRuA0IMRs9XOpmFJszpW+G
         WSOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771967430; x=1772572230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UDWJucdoUfy9BMkP3+pz5hUeYcqXSeuUH00YgRisRKQ=;
        b=UyxusLJpYuLkxd/4DaA27C6U2Cp5C17ly/1AVq3tWmL/S1qJcJkCKpoCUGd9k9gDL1
         UMJedCljmDExYQQRNYhRhrOpgAzjaHwr/nwg7VUlCKAdexQEfcb1OjsqLcxQFwwbqEIh
         8OvijGvYyY9/ZLromEBCAcYYKH0O+I/EKsi6U=
X-Received: by 2002:a05:6512:33c6:b0:59d:f47c:100d with SMTP id 2adb3069b0e04-5a0ed9a833fmr4237684e87.24.1771967430103;
        Tue, 24 Feb 2026 13:10:30 -0800 (PST)
X-Received: by 2002:a05:6512:33c6:b0:59d:f47c:100d with SMTP id
 2adb3069b0e04-5a0ed9a833fmr4237672e87.24.1771967429505; Tue, 24 Feb 2026
 13:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200928194651.5393-2-james.quinlan@broadcom.com> <20260220221106.GA3552425@bhelgaas>
In-Reply-To: <20260220221106.GA3552425@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Tue, 24 Feb 2026 16:10:17 -0500
X-Gm-Features: AaiRm51D-NQUaTrqsM8O8awPCdzmE1fTYI6dgi9Q7qoLI220Sp9oF5_6K8TmXUY
Message-ID: <CA+-6iNzJM=C+Byb+wnmPYdJcYoTT7N-XwE3o2OpJzmcJrtOc8A@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/1] PCI: pcie_bus_config can be set at build time
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>, 
	Hans Zhang <18255117159@163.com>, Niklas Cassel <cassel@kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000040d0d8064b9851a6"

--00000000000040d0d8064b9851a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 5:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Hans, Niklas]
>
> On Mon, Sep 28, 2020 at 03:46:51PM -0400, Jim Quinlan wrote:
> > The Kconfig is modified so that the pcie_bus_config setting can be done=
 at
> > build time in the same manner as the CONFIG_PCIEASPM_XXXX choice.  The
> > pci_bus_config setting may still be overridden by the bootline param.
> >
> > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
>
> We merged this as b0e85c3c8554 ("PCI: Add Kconfig options for MPS/MRRS
> strategy"), which appeared in v5.10.
>
> In retrospect, I think this might have been a mistake because it
> forces a build-time configuration for something that may not be known
> at build time and can be set via command-line parameter.

Hi Bjorn,

I don't see much difference between setting the default at build time
versus setting it via the boot command line --  both methods are
performed before runtime and make assumptions.

>
> But I can't find any discussion about it.  Did you have a use case
> where command line parameters weren't usable?

Yes.  We have a Cable Modem (CM) customer who can update their Linux
version but cannot update their boot loader or its default bootline.
FWIW, they only want the option to set pcie_bus_config to
PCIE_BUS_SAFE via the .config.

>
> If there's a platform that requires one of these settings, maybe
> there's a way to do that programmatically in the host bridge driver
> rather than using a Kconfig symbol.

It's a CM product which uses a particular Wifi chip.  Recognizing this
scenario would have the RC trying to grab the EP's vendor-id (and
possibly more info) , and that seems awkward at best.

Regards,
Jim Quinlan
Broadcom STB/CM

>
> > ---
> >  drivers/pci/Kconfig | 56 +++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.c   | 12 ++++++++++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 4bef5c2bae9f..15ce948858fb 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -187,6 +187,62 @@ config PCI_HYPERV
> >         The PCI device frontend driver allows the kernel to import arbi=
trary
> >         PCI devices from a PCI backend to support PCI driver domains.
> >
> > +choice
> > +     prompt "PCIE default bus config setting"
> > +     default PCIE_BUS_DEFAULT
> > +     depends on PCI
> > +     help
> > +       One of the following choices will set the pci_bus_config at
> > +       compile time.  The choices offered are the same as those offere=
d
> > +       for the bootline parameter 'pci'; i.e. 'pci=3Dpcie_bus_tune_off=
',
> > +       'pci=3Dpcie_bus_safe', 'pci=3Dpcie_bus_perf', and 'pci=3Dpcie_b=
us_peer2peer'.
> > +       This is a compile-time setting and is still be overridden by th=
e
> > +       above bootline parameters, if present.  If unsure, chose PCIE_B=
US_DEFAULT.
> > +
> > +config PCIE_BUS_TUNE_OFF
> > +     bool "Tune Off"
> > +     depends on PCI
> > +     help
> > +       Use the BIOS defaults; doesn't touch MPS at all.  This is the s=
ame
> > +       as booting with 'pci=3Dpcie_bus_tune_off'.
> > +
> > +config PCIE_BUS_DEFAULT
> > +     bool "Default"
> > +     depends on PCI
> > +     help
> > +       Default choice; ensures that the MPS matches upstream bridge.
> > +
> > +config PCIE_BUS_SAFE
> > +     bool "Safe"
> > +     depends on PCI
> > +     help
> > +       Use largest MPS that boot-time devices support.  If you have a
> > +       closed system with no possibility of adding new devices,
> > +       this will use the largest MPS that's supported by all devices.
> > +       This is the same as booting with 'pci=3Dpcie_bus_safe'.
> > +
> > +config PCIE_BUS_PERFORMANCE
> > +     bool "Performance"
> > +     depends on PCI
> > +     help
> > +       Use MPS and MRRS for best performance.  This setting ensures
> > +       that a given device's MPS is no larger than its parent MPS,
> > +       which allows us to keep all switches/bridges to the max MPS sup=
ported
> > +       by their parent and eventually the PHB.  This is the same as
> > +       booting with 'pci=3Dpcie_bus_perf'.
> > +
> > +config PCIE_BUS_PEER2PEER
> > +     bool "Peer2peer"
> > +     depends on PCI
> > +     help
> > +       Set MPS =3D 128 for all devices.  MPS configuration effected by
> > +       the other options could cause the MPS on one root port to be
> > +       different than that of the MPS on another.  Simply making the s=
ystem
> > +       wide MPS be set to the smallest possible value (128B) solves
> > +       this issue.  This is the same as booting with 'pci=3Dpcie_bus_p=
eer2peer'.
> > +
> > +endchoice
> > +
> >  source "drivers/pci/hotplug/Kconfig"
> >  source "drivers/pci/controller/Kconfig"
> >  source "drivers/pci/endpoint/Kconfig"
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e39c5499770f..dfb52ed4a931 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -101,7 +101,19 @@ unsigned long pci_hotplug_mmio_pref_size =3D DEFAU=
LT_HOTPLUG_MMIO_PREF_SIZE;
> >  #define DEFAULT_HOTPLUG_BUS_SIZE     1
> >  unsigned long pci_hotplug_bus_size =3D DEFAULT_HOTPLUG_BUS_SIZE;
> >
> > +
> > +/* PCIE bus config, can be overridden by bootline param */
> > +#ifdef CONFIG_PCIE_BUS_TUNE_OFF
> > +enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_TUNE_OFF;
> > +#elif defined CONFIG_PCIE_BUS_SAFE
> > +enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_SAFE;
> > +#elif defined CONFIG_PCIE_BUS_PERFORMANCE
> > +enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_PERFORMANCE;
> > +#elif defined CONFIG_PCIE_BUS_PEER2PEER
> > +enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_PEER2PEER;
> > +#else
> >  enum pcie_bus_config_types pcie_bus_config =3D PCIE_BUS_DEFAULT;
> > +#endif
> >
> >  /*
> >   * The default CLS is used if arch didn't set CLS explicitly and not
> > --
> > 2.17.1
> >
>
>

--00000000000040d0d8064b9851a6
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
QSAyMDIzAgwHM7pH5w7o7Qb7yXUwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBiV
wQkF3kLB1C4+1YeoPCpxUl3yqkYpRQQWWSac4rhJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDIyNDIxMTAzMFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAD+0k3Ii/tFI9qQS+G7rknPQ+ahdLAlPet/gswEx
JzdOw6KhfVGyi5Jf5ojFDPFhD4XwcIz59nUiWrW9/Mz38i3yWIgOlzhV59AVJfgYD0Ox4kYrvYWF
DhxHCrfQwNrpcJugwqrLB80GZsA/FEos3D9kgvjmBY0XgO78IHf6DymfzysqJ7YDpD1o2ySBBbdG
lRoyyipIJ5ALyCcBC4z1b7Pyvi58W4RX8mBJ6ghXWtuV0d/T9RZC6Q7H5Ql4kg88OevExzK4YhHG
L44fqHG7KUPNMGF8D7asLKGncdIYLT+mRdAJ6oerINuCfB64qVV2/BepVcCin5GfaWdnDUQDC+Y=
--00000000000040d0d8064b9851a6--
