Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847566;
	b=WWVOayUDLHa5V4+1z1bNqN5DzCch69yic7kAy44PPvzX2OSB89ULplxa7z2Zl7pYIXNg
	 rD9GTIK2leKvs6mp4oWAccT3aR0de+j+rXO+gZ1Zv9S5SAE3ERyUEzki6rBSykUN3Ao/d
	 C9qgUowhXU3V5YlW8ttI0rWeFC/YtycPIqN0wwZJYmhXbZZwk2vszi4UedeCGSX+VMWRp
	 fOPfNkoQ48EZSvNzvWD8u7+9XzzwtmjFg0xfgiKnoTY42MdGoxfnveieQqngUIpUn0wAW
	 uNaY3yEklQggrTMnCibmgQlcIGxQRlGbGy+YCBqj+XqiIcdhr8ttTYMWYbVP2aLX5rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uRx112H2Vi/wC2nTJxgIojxoar70KiA3HIwHfFiZZ3M=;
	b=hgnX6XaOw8uUw46INUNpH8UdTxD893yEbJ4uLSVXfstnCD3i+OPrp85s48ImI9TFuT+H
	 fkhtL2MPPRGgV0QnPp8UWuwpZbvbS29cN+PUjBIuKyXfYdx9EiZXoQndXKB81VOeSnbzB
	 jxDWQh3L8fvoEtkj/2tmMDH9501yoD+XefyMAOvASQR4dqjYYBngpzpT+QJxTEfdztXbj
	 tpHTNHWKb3Zdkiq5pUbQ4yIksdUQ1wzWMhTmzBS1JfeGlmnSYPSbaCNeLy/poXAJAsqdt
	 kTGk5rWdcLXBDym16tjKwjgIOAC0wXlRk2VaOQ/iyM7Kn+EyYbHmfucUGXD7noFiJnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lI0Cs7lw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05966606A323
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 16:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05966606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lI0Cs7lw
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c50a2efbe1dso587146266b.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 08:46:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794847564; cv=none;
        d=google.com; s=arc-20260327;
        b=cZ+BNIU2UvrfjrP1O4OCaE9x7+DmCP3z28rT1Y/xM/gdzrb73eSf7+hGklzdPFxCoh
         ioV6PXKdghey6MldXoALLuuxVw0tXLxMqfS5xbDTWrxUgR6WtLijQveEcnJV47JNIzpK
         OSXtiOyM+QnO80v5oWj82klqd2ppvqobfK26xZ7cV2TFSR30vhySDkAb+K7WOgtQRp4m
         ci8ZEPm1+WYTYlIw8Cm1etZq39/BVgGErfhatVOPETnILXn5lrl3Sre/QTIyn+m4PUoe
         vbzxPwCi9zFRag+PJ7IDg+UQ1+Aqk52/kbsExog1uH/bXLakAhxSMRVUOo0Hto0v23PI
         d35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uRx112H2Vi/wC2nTJxgIojxoar70KiA3HIwHfFiZZ3M=;
        fh=+KdMHjfjLHJ5S9FOeoiitPe0AsAFNqlL4xOtCav17fk=;
        b=F+SCY+WeB+XVv1k3i8upBQCJh4bCtiuINICSLbn3tnDAh5H8FBKrv8fJWZGC1ynSf+
         xKR9vWoIexIika0DMSxFRGonLJL6SkM/1VAcscmCHHxmEAIpEuYhTD4Arfd05ZKLsC8D
         P5P+lv2QS5vtEo9js01WIO8aP9lZ4sXIpnPOVv9/l1uRd4LuRCPWtqI6zPyf+XYgLmMV
         GiQx+qXsdeb+K4uXvL08v3LQFQA0dTiEIANfeK83o0TpK8eB4gUgoipB5GIkfnN4AG5W
         vpul/g8TWF9UT2XSmK02F45YE6Q217UHrcymio+3SedD/FlTSFueRWk9feELjfGWBR0T
         PUQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794847564; x=1795452364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uRx112H2Vi/wC2nTJxgIojxoar70KiA3HIwHfFiZZ3M=;
        b=lI0Cs7lw34shuZu+TXVsC1heBq13ajUejoM8zrjtRGUIcFIkn6ckIcMtCD5SHslIhU
         DegAUND4pUx2SZ38i2W2dqZu03y0oEwKYp2LHD2Pu/lEIKtNgwro+5OKfOwiLl9Lvhx6
         N/0ZVMD5ih/TzHBzc+5heCZ1CSOHaNznRiEJsMm3Cl3H6VgrGzUPbrHVMYb6EyyiAJIS
         2GqsePXkKSc6UbynzvtHYn5eBMYugxp782hHnck6/PkmwM0oGfSWDCz9b+diBKixfh57
         KlA2QQg/yaqKIEdMnVkLvYwkrBxu71jNHvLKdzi9UG1Stv9p0IaiEButyL+yewlKqEkf
         MuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847564; x=1795452364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRx112H2Vi/wC2nTJxgIojxoar70KiA3HIwHfFiZZ3M=;
        b=FEESbXq2TOXIN9+ekCw5eMueKJh97wibJEl1ckTESxcwx4oIPCrjlPYFJotj0GqcKq
         +CFSwauw82hU2cxQcZr2/YMoceVm3SPDqFy3Nygd83salYSoQbschgxuwOwsDfxPAfwG
         KR/j5R1kuoEbh7z4Jr0D6/YyJ4rvQtg7nybMj4gmYqdczC3fF6r4ixW0eJu3+Kx0gpsV
         RNa9bGvJD/662UZIZoyr5Rn7/jjdBHCJoMXKLyvIU/uRv4vPapzXKLD00RtgZ3Ot4bE2
         vG0EbcTOgU/w/LpbibAHP0nUx7bYy7ZsTonOQdeAAiSEBaUOZdaEAzNKjayemy5ApCMc
         I5Jw==
X-Forwarded-Encrypted: i=1; AL+hErG0f4tMlB+pqMs8BeDzCJ7Y6KtAKZ+jKTXSNfH0rZzslqUG+s99GdAAoGQF8wz3f2EytCEddPdMP7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ly5bF3EzYC5VSskDlwoZlCCwwxVnQ6VDOi8lYOkN2YEkQ3Ifm
	f3e/trO+p90TsvLJ2W6wHI21+Js/qagI2bf2z9JmH1EamzTEm5T2b2v8VcmUXE4dl+5GKaubFOg
	clj/BngR7xB4WrdnRhTA7UeLUKIt2GL4DzZlaQZgN
X-Gm-Gg: AYBFou228ZVoAGECi6DcKhvnu4IsugsIpG5jwYomcoy1MqDpmUktwNDlj9gvDT2iFlD
	oijAmqwjCOunouba7qDHKQLkUuqYCXO+HwxMUojugo/3GpkZ1LlJjMmEfLDs6LKn4EMDATn98Hr
	4vIu9UIMV8FHMhnSZl/6RTxHyp72pttTkODFeViFrgArL1lzWnIYK9dV2hS2GQvNS4iIBZDGria
	9a6qmWgMYcN6RHgE5FkNSFafs/Jxz7bhyYFaUho/bmcufkUCnhYsfIEARcncjhnAFbqBlLpV3QB
	AZRHL1sEkK7mJcUjBKI8xsIYvzA4foATvqXdxsnu/VdWDocfHWZUfzXMloVBPGjFkF6nqwdWQif
	O0A6noNiM2csW8FvnOJQMPzvZbsBKsBe5gOCivA==
X-Received: by 2002:a17:906:c14e:b0:c34:83c0:b92b with SMTP id
 a640c23a62f3a-c509631747amr801733166b.23.1794847563720; Mon, 16 Nov 2026
 08:46:03 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013162529.1928093-1-dmatlack@google.com> <autxCZPJ9yiE2ucq@google.com>
 <aut0H65XKAHUqPR9@google.com>
In-Reply-To: <aut0H65XKAHUqPR9@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Nov 2026 08:45:36 -0800
X-Gm-Features: AclHuK91dkLFtARHO_doZgjfYRJFT_5pDlpQ_hxt-2ez4dAgAMEfCzexcKbTDgA
Message-ID: <CALzav=dp8HvdK=9cAkGfbsJAeckyU3_y7rCRM22R7+AmTTtxMQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] PCI: liveupdate: PCI core support for Live Update
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 10:06=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-11-04 01:00 PM, Pasha Tatashin wrote:
> > On 10-13 16:25, David Matlack wrote:
> > > v10:
> > >  - Save and restore the ACS Egress Control Vector along with the ACS
> > >    Control register, sizing the save buffer from the HwInit Egress
> > >    Control Vector Size field (Alex) and drop Bjorn's R-b tag
> > >  - Make CONFIG_PCI_LIVEUPDATE depend on 64BIT from the first patch
> > >    rather than adding the dependency later in the series (Pratyush,
> > >    Mike)
> > >  - Reword kernel-doc comments to read better in the HTML docs and
> > >    spell out "reference count" (Mike)
> > >  - Replace the version number at the start of struct pci_ser with
> > >    required_flags and optional_flags, and record the size of struct
> > >    pci_dev_ser, so that the PCI FLB ABI can be extended (LPC BoF)
> >
> > Hi Bjorn,
> >
> > I am planning to target this series for the 7.5 merge window through th=
e
> > liveupdate tree, as we previously agreed. However, there are still 6
> > patches that lack an Acked-by from you. I believe you might have
> > reviewed some of them before, but the tags were lost during subsequent
> > refactoring. Could you please take another look at the following to mak=
e
> > sure everything is in order for us to merge the series:
> >
> > PCI: liveupdate: Set up FLB handler for the PCI core
> > PCI: liveupdate: Track incoming preserved PCI devices
> > PCI: liveupdate: Document driver binding responsibilities
> > PCI: liveupdate: Auto-preserve upstream bridges across Live Update
> > PCI: Save and restore the ACS Control register and Egress Control Vecto=
r
> > PCI: liveupdate: Adopt ACS controls in incoming preserved devices
>
> Thanks Pasha. One more for Bjorn's list:
>
>   [06/13] PCI: liveupdate: Preserve bus numbers during Live Update
>           https://lore.kernel.org/linux-pci/20261013162529.1928093-7-dmat=
lack@google.com/
>
> Bjorn's Reviewed-by on it was dropped in v9 when it changed materially
> (albeit based on his feedback).
>
> Alex, could you also take a look at the two ACS patches? 08 includes the
> Egress Control Vector save/restore you asked for in v9.
>
>   [08/13] PCI: Save and restore the ACS Control register and Egress Contr=
ol Vector
>           https://lore.kernel.org/linux-pci/20261013162529.1928093-9-dmat=
lack@google.com/
>   [09/13] PCI: liveupdate: Adopt ACS controls in incoming preserved devic=
es
>           https://lore.kernel.org/linux-pci/20261013162529.1928093-10-dma=
tlack@google.com/

Bjorn and Alex, these 2 patches still need your R-b or A-b tags, and
then this series will be all ready for 7.5.
