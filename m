Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6067262A
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499222; cv=pass; b=A57BS0v2mIPEYzmknaoVYTGE0HiGD3zcpDDv4uLznhg+LBMjRjGOkI0HL6C1wqrg4ft91iEovAp15+k/sCwDA37bzPatfzD1ZGGdPlTTPAztiDvU8//rE9g+X+3iAMzDVmYD7Gsyaw2GydEVCGV+hpXhZmFP+B06yY8j5YBSxJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499222; c=relaxed/simple;
	bh=YitgMh+IQkPfR+E6WK508D15GZUaOtQjW3Rav9uM5RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjFAVpqJ1M/D1K+Q53tU6i5zBAmq5vBa5JTe2urBoAe0Jr9iizKLWMqgzn+IcXjFtSqjNyX6+pimXMHFu47r6CKHBtCRvOpHYsU3ZYMdsvxU3sTLg/4tW5fnbbby7m6nCACDaf1dnHOEtT7wOrvWmSwqde2u0HVEkIICAkV9GkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+CsUiWs; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+CsUiWs"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d598f4c618so2587634a34.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 16:53:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772499220; cv=none;
        d=google.com; s=arc-20240605;
        b=LdvkQ8YdOI4ppIgB/WGWyHdwRAolZZgHIA6swUrNzdoJdmbTf9I5PeGYJd0gal0OuE
         gPOA1CvfuVmmp55YozwGVti5OMrstZ9ZecljAv3+TLerNzQDaJGIFZOunj9TBTtsnLV7
         nkxmznxe1WD1+YP+uLIZSZEvZ+XiGHBNBkb2lZ2Z3SUb+l1rLsdOMYDIWW/f/fJgu9OT
         wf7ZbEm2Omivyqh4MZm/t1qycaR404/Izack9AlmB/DBAqYr0pq7RmBTeX2QTcuenBSa
         OEesCty0QCcr3xg+gDYUJxTO3rXH7WNEs6r8bQqjplMcXp8VG4vjh7v6McfYJqGV0d12
         ejYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f+LVMNU+doEnp6Gr36km7mAQ+iRFTQfe7wiEDOjv1mw=;
        fh=OPaNsgNNCg2l85kL8eIyjF/HiURjcp4SHNLEqRTeY7o=;
        b=Gv1LHhcn8KRyhF0tquAHfKLngliu8VA7lkNd1/DfSPKtNhuPLNSNKYFfyFawkARTVa
         g15X986opqgnbhnqsM+bk7xnk4vmUGtPBhoQndfx4fgp3ectG7dCTe0KbR26zZVI/evc
         38JMxMNuHfZmpQVrp8goMW6qgkvAn/DX+uzNMlzp/abTc7xI7XD5Mv4mglW//XvgSgvH
         D93Eb1kjWC3ZA9ueJhnfA7hlkrZy8+PJlRgEX+IV73Mb5Rm3WagFeAYZhv7hqcA32nmt
         9eSAxT9gWG43errLvagG3rS3jKG8Ss2CKCtwZS0wmtZAIxrYN4MuOs0vdq5mhLITCvfG
         SMVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772499220; x=1773104020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+LVMNU+doEnp6Gr36km7mAQ+iRFTQfe7wiEDOjv1mw=;
        b=C+CsUiWsk22WT7a3BKBK7SjDzhJgt2aB6/GthIDn7fyXQ34LgceHV99lHve7zlZFOi
         wnbvr94o91cWYLL2S9iiWwDv8BvV0fLofTZZ3D1uKGExIvAB5vOPkxQnPhYd9ljOAqXz
         5CuKgWBh6vXIoFjpy0ByXr/qwto01zEGkpdjTnn+m0KTNVroDqEDUeFZbcwDLdBJf+KQ
         vJooVUND0Owg7Yi9rw15MSSqb5gadJPlrdsljiKsGJVJMqe9jTGcSJcoPx6Pp5aq9mdj
         lDySUi/unWMm4l+xwgQu1ajLlSt93pKzbuEdiTmYiG/SthwCRM8BnC8TzrEnw6vYyJqH
         Sz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772499220; x=1773104020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+LVMNU+doEnp6Gr36km7mAQ+iRFTQfe7wiEDOjv1mw=;
        b=D+1pfOABbofYUt1ZOrr9CpAyRSGAwDPF8ONrZ3/QPnEnNOJII/ExlwflFN/gTLtP6d
         lmnIY6l11r/i5m7IRr6mNJ1Ak8ihUM+3wZC9qXMq77JZ6O6QYNrvTXzLu568xExgGZ9x
         4LKW+bul304r1uKq/Nb4XmmUCltrKWifERSrScwnF2PAABDFfjCWcActFw5Q1Us0OcVA
         ZJtg4zsoHgZX2eMYQPqENv16c6hHSZuiEys0TxMve7kO3WsLIAhXXTutym19jW15byKV
         DiZCR/Spn1REGldyazalfeA11ZxPML4ZRR+Qnfv97GoH0UfIMvkonT/8BADYvMZXbKkX
         SrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyWFC/LqeAu/x/+KFp6YcTi0zDIGagirM32MrFJ3ULjFsMjNf/3XX6MUC0FeyJBNSzfZhIoDYZoqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwxV+mSLzHDr/6/647A7wzB0PlMQoJkkP1qRg7peyuCSqijbYr
	mwtSWZ5Oc1UgMlY2lwix6ajxaX4iHYa5rJR2nDsaKx2WsfM7bj14qu9TfHWwK6Wg1rgdkvSWXjJ
	D8Xr6Jb1zTRW2soWgEiunlrfwk9mi8OE1d6G6
X-Gm-Gg: ATEYQzy5jnFieQQwSeZ5vdmXnUWHYWmKgqHDbhER+tjxTJbo4XgdsR5n1RLvIZhhFZ3
	U44xud+2BvlEHQ1/F5kk8/OYzwH5fBnXHoq4yHwgXkuponjbxCtqv6hyhL/azt68c7wX8NsB3x1
	zF2kzJNZMuDbveVWMCkjY315i1O1WK1z6lPjKvsWxzG9M5nT29dquWGEn6DfGjrks4VU+Ln0Mxe
	R7yodfN94ByaBYEbRD0hrPrTV8UrFvKuxouv0JoreQk0S2B5et7sXZ9vYnDxDK1kNM70/ZRMLKP
	ofDMhP00
X-Received: by 2002:a05:6830:660e:b0:7d5:2c30:9fba with SMTP id
 46e09a7af769-7d591be4920mr9114436a34.24.1772499219775; Mon, 02 Mar 2026
 16:53:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7C2SC_2k6+dvBTRoV1_trpPEF5h+k9KDOapTwcb90+=BUatw@mail.gmail.com>
 <20260302235100.GA4037767@bhelgaas>
In-Reply-To: <20260302235100.GA4037767@bhelgaas>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 3 Mar 2026 08:53:28 +0800
X-Gm-Features: AaiRm50cERkMU7DMailb_8_rvIXVLRzTT6TOCWlbjIyKMameUx534CuDfe4bhbE
Message-ID: <CAN7C2SAcJp8nAhbRT9OyLeT2YsvmX=+Y4qhBZR_WQ3aDqNHywA@mail.gmail.com>
Subject: Re: [BUG] PCIe Stall on USB_PCI=y with SoCFPGA Root Port
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joyce Ooi <joyce.ooi@intel.com>, linux-pci@vger.kernel.org, ley.foon.tan@intel.com, 
	mathias.nyman@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 7:51=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> [+to Joyce, pcie-altera.c maintainer]
>
> On Sat, Feb 28, 2026 at 11:05:17PM +0800, Sune Brian wrote:
> > Dear PCI maintainers,
> >
> > Root Port: Cyclone V HPS Root Port PCIe
> > Endpoint: uPD720202 Card
> > Kernel version: 6.12.33-g3234b1ed8956-dirty
>
> v6.12 is fairly old; can you reproduce a problem with v6.19 or
> v7.0-rc1?

Had tried 6.19 same situation USB_PCI=3Dy simply repeatable hang.
No message shown or tells what happened.

>
> > Sanity confirmation of PCIe RP:
> > Both NVMe and Realtek WIFI cards are tested
> > and show no major issue with MSI/MSI-X enabled.
> >
> > Repeatable Result:
> > When uPD720202 card is applied onto the PCIe slot.
> > Either module or included driver could stall during kernel boot.
> > The stall can be resolved by setting USB_PCI=3Dn and
> > after boot under distro lspci -vvv can disable the card info [2].
> > All nosmi noaspm etc are tested and state the same stall.
> >
> > The root port info is shown in [1].
> > Based on the above behavior we had also tried to reflash the
> > ROM of the uPD720202 card and no difference was shown
> > on the stall issue.
> > The uPD720202 card is tested on another ARM 64 board and
> > shows no stall issue.
>
> Do you have any details about what the actual issue is?  I guess it's
> some kind of hang, but you don't know exactly where in the code it
> happens?

I can't have tried so many basic dmesg and possible runtime debug methods.
It just simply hangs or stalls.
Maybe more guidance on how to turn on more debug messages could help.

The best I can do to know what triggered is USB_PCI=3Dy.

Thanks,
Brian

>
> > With USB_PCI=3Dn it is sure this is driver issue between
> > pcie-altera.c & pcie-altera-msi.c
> >
> > Additional boot log [3] with USB_PCI=3Dn
> >
> > Thanks,
> > Brian
> >
