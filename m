Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250F370ACA
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182795; cv=pass; b=jn61QbkmfVCmnzVTqueTK1uzq4mvPbEqLGRwnAhRiI7Ale7sAvnPw4GTg7G2qwWG2h0FlukKFpznxYXRwedhTx+ip/ru+EwzEtTz3h9jDMA9pdWRgnaflwpxInIVyzaKzakj42WKCQYzvmrF9mAo/fLYtX272t79VACogW8xUOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182795; c=relaxed/simple;
	bh=6apOgnwFS+LCUfaanOnBGAzYOkwuFRkixEqeP45hgM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txXMqhfwQrC5JtJLizxkOyavnK6vIT9CXEyP9EDxkZJ5U8vMDitzg/IQ8qJ2MiBIHqZaNj6JJZY4qxPrWfvzeKeGZCBv06Jxrh+yhMlnrwVvgMX1WeavlNH4UM9hVoCgDbwEmZFqDl6cm29ZOsVwN3tX3iXYVnmMc2sCTgWkhuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agAk9l42; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agAk9l42"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso2163694a12.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 13:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785182793; cv=none;
        d=google.com; s=arc-20260327;
        b=DJlanRpRnxAmxQnxRp1fU0hBSE2z7lv5+urDetp4U6vHDTS0Zhv8uXswizUhvf4Nev
         SjLqKhXp/qt5AQG/7+9276CRwL1JMBrXWCqr/XUSOh77jSXxKvAWNYawWsGNam09ppT4
         bNXcMarcSAU+6LFyeeqyhOcNFwe9bCYepRfZXSrgH8FTDne3Y2f4qI94LcEmb2Pjdb3Y
         m6XJONr6SVnL8eP7p9aVMdicnd4nyfQKJD+dQh88SidywXOvjnsVNEuQHySF2W/tppCU
         LgrX3pqc8bMKm4JwUdNF4413wUmv4hyjQtby9pwDxUB4t8ONzltdYRBFUqkuIbF54moZ
         i2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WT3D5aoPs392vdVyfO0XAxS3rqs8yFAgGjz3WyPghwM=;
        fh=lnPZ9AEPwddCxrvbMo3GG4ZIstcP5zmmp4ci87wvO7Y=;
        b=LTkGNNaZxnamYCioUvLUcUq16AsfRvRsp0FmB5YHa70nudM9tc2uTyH4RIWtEwsTDq
         fwuW/IU5h5ZVIJ9OF60tDlGiAygztz+4Tmfbp/qYIjozDWnOe56UOC16tTH810n19v1U
         nIXlA9alyZei39v7ZsWTolpAmGTikmEZDjnsONequ+S/QvO8M8dm6svyTW7ymqDVXiVq
         hYBUkw0j40ta3aMWSpNzI+8SVoMRF47o06kmgwfm3A/vcZv134r6AvsH+Et+7AqTctQD
         Ir8Xy6QHtPOnjOISpOdsHlIfSdpkYt/wzqN31oly6KyRlptfAsrTaspTVpTdU2kZNBhu
         JtoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785182793; x=1785787593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WT3D5aoPs392vdVyfO0XAxS3rqs8yFAgGjz3WyPghwM=;
        b=agAk9l42+Xun1Kr1OkJdXs7lFnXZTj2ve7r5VzEm7uwQwstZv8DEyE0bkxKU99yapM
         dTLq3Q2uAb+SE0sJtlRLab/d13ovpKJaiih8QzBZ16Qln8jpgkB3cvY81R8cBMWtDTG/
         P4lVQJggBIdUxZUWnXBNIKWaXghmsHbMKV3aZ48sVjpd7XY/iEoxXGOdvvP6lPYYiv8Q
         Pdlv+6Osqe3ChiCUwNQTy5ZxgP01uKV0zMwxlgILiWoXL4CSqDgAbYgiPms+k8M08r1F
         3YrGWgpzJa/UPuM+om3skihiOpCDPbzqV3/JgvLEct67sgVfLNNVsZvAaGmyZ4l5T+jQ
         4ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785182793; x=1785787593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WT3D5aoPs392vdVyfO0XAxS3rqs8yFAgGjz3WyPghwM=;
        b=G5jbV3T+lvLYtWPvEs5KrUISLkHQ1m1o1IYSwkxmJNPKbVa4UjNwwYtGIHrdk20fE2
         N2fVo3z9oDToRJTxPfsz0jhHVqUMKZ98WFSaQGzPOrLHhNYGtYfxI79uJJj5qMdo9tid
         HrCabYQi+WIYH2ITNpviA5K4uhZGpXWnC7MXYQBKvToCwI9RDzD6sZ5VxaNfODi3Nxuq
         0MuPV6nPM3X1XZP8ad2DpcdUpSQjfDzrOEvJim7HsLveh1gbBP6wt+abyxWCCZHp2KrO
         x8RjqS7HzFpnxjaSUzhRLJgcCBDRiAPRZTIxiyPS9gfDaXjJoVEIlsff5CYkDPAlbOvN
         yBgg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0M02FQ3ctR9oLGt03Kyu+ibwzAtTk0BI/RDfXh2vOgwGXivpTeLnxIPLpX4Qh97JeoLYHJLEpbHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8wKMvw4BEu9zwellCKxL9ngLQHVEy06yRONwDQSzYpvdskMs
	7Xqp4yX/Uzm7DEzfGo+XAEprEbJfdUX+Atahrs3dDmJTI3S39GEfTuBbjYIEUlp0KkYY5LR6Vk5
	EqMaKPk5QAtFHkB+JEeWjmd4D+U22dAWrju9GAsvC
X-Gm-Gg: AR+sD13ubfyrzyNccHmQpkgpnqE8TtXQr8HNcZwakQv6FORNKPrbBFE1hsmJMpvR7/m
	S3UkuuQV9tBJPh/sL2jyQUwM+pwB0+gpmFGKw7H93FDuRpm0r0hVSdblBIs3OkcV9yYhhRAvVWu
	ewHqt6R7J0LAQJwUu8WzDqkZxiqJ8t04wGO4+knRgXm4rsxRMOzKvHHIOka4o3iyskAHLcdl5eV
	/N+zr9udIfFMFWuKglQ0Gdko+HAArEAfcworldor3AidyqLOTkzG3TEM0ZpLA==
X-Received: by 2002:a05:6300:670d:b0:3b4:5c70:ca3e with SMTP id
 adf61e73a8af0-3c6c7cc8bd0mr999176637.25.1785182792364; Mon, 27 Jul 2026
 13:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALzav=cRhFW+zNX6xCnhjJXXDHgyhOxuoX26FG2Ve8+wMccypg@mail.gmail.com>
 <20260727192701.GA1250952@bhelgaas>
In-Reply-To: <20260727192701.GA1250952@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Jul 2026 13:06:04 -0700
X-Gm-Features: AUfX_mxd_Oq9PiU6WIdCESXtBp_uYjHaNiC_kTE5jOYjh-Uu0garCTxaVZ4f-sk
Message-ID: <CALzav=d1u5fuOgodeGKiFKPhMOx5xrdvgOeNqWfj-C7ZRG-EdQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI core
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 12:27=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Mon, Jul 27, 2026 at 10:40:52AM -0700, David Matlack wrote:
> > On Thu, Jul 23, 2026 at 3:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, Jul 10, 2026 at 09:26:04PM +0000, David Matlack wrote:
> > > > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to ena=
ble
> > > > it to participate in the preservation of PCI devices across Live Up=
date.
> > > > Essentially, this commit enables the PCI core to allocate a struct
> > > > (struct pci_ser) and preserve it across a Live Update whenever at l=
east
> > > > one device is preserved.
> > > > ...
> > >
> > > > +#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> > >
> > > Is KBUILD_BASENAME buying us something important here?  Just from
> > > code-reading perspective, it's more work because without some digging
> > > I don't know what it will end up looking like in a dmesg log.
> > >
> > > > +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args=
)
> > > > +{
> > > > +     struct pci_flb_outgoing *outgoing =3D args->obj;
> > > > +
> > > > +     WARN_ON(outgoing->ser->nr_devices);
> > > > +     kho_block_set_destroy(&outgoing->block_set);
> > > > +     kho_unpreserve_free(outgoing->ser);
> > > > +     kfree(outgoing);
> > > > +     pr_debug("Unpreserved struct pci_ser\n");
> > >
> > > If this pr_debug() is useful, maybe it should include an address and
> > > there should be a corresponding pr_debug() on the preserve side so we
> > > could find things in a crashdump?
> > >
> > > > +int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh=
)
> > > > +{
> > > > +     pr_debug("Registering file handler \"%s\"\n", fh->compatible)=
;
> > >
> > > Is fh->compatible enough to identify a driver?
> >
> > Not necessarily. VFIO could theoretically have one file handler that
> > handles all the vfio-pci variant drivers. But I suspect we'll end up
> > with 1 fh per driver in practice.
> >
> > Are you thinking about how we can ensure devices are bound to
> > compatible drivers after Live Update?
>
> No, I don't understand enough to worry about things like that.  I'm
> just wondering if there's enough info in the message to be useful,
> since fh->compatible is the only text that's variable.  Same reason I
> asked about the "Unpreserved struct pci_ser" message above.  E.g., if
> a user reports these messages, will we need more information to debug
> it, or is the message itself enough?

Ah ok. From that perspective, I think this be sufficient to confirm
that VFIO has registered it's file handler for devices bound to
vfio-pci, which is all this log needs to do IMO.
