Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00735E947
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558628; cv=pass; b=oF6kot6+BU5bCDOcXD/xtH3GK4A8/VEpZefb9Hag+3g1WRlhsQT0678E6LwD/k72kGIfAAxVrGuASPNtk0ZeBmaN605oyhi+Tq5RB8gH1IoNKSONKN9Fg9bBRtxZGRwFkpXTaL6SIezPydW0poft6VE0amGSwmPJNo8orKs4yTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558628; c=relaxed/simple;
	bh=O4BktEbyNrPmM6UZGrDQJAb05NE/1bPp+rV3az51mbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smbT0L8TuKUg7HkP1brnU6Bz3soMxLTzkKTlUCIEX7bW9PnKjqZWuM2E2BZM6fNKXU0yhTtUmL99pp3z9Z6Vf9YIpVnLffd50IY9lPtcWiqqRYFd69Bfd7FH1XABUgao/lv845pOkXQD44stlHUZ5CAI6XoRhHyw2Yz2uHQ9dHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dF1/vPlD; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF1/vPlD"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d4d8712b40so2812755a34.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 09:23:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772558626; cv=none;
        d=google.com; s=arc-20240605;
        b=Nbyal7y+bjiUkLztKMXUtIjtK+ys7JlgVy+PFow7/XMycHAKAjSSTbJAwsLerfCqjM
         TRvrZaYAHzL1lCjySknOfjGoFIoUgAtW9MEqbsMux6xOqeEdWA39G4ScqfZvgxuWzxRu
         Tdvs/zL2HmSu+Fgj473+oXW1EPvmM6JMwgBnL5bRBSYZh/iy3iKibdWin3aVSCj6kj/c
         Eysj7BpWQaXrzdhDIyWYynZBhHZliD7Rg4ZwPjnS5C9rpvhqNPegJra/WBVQp4q60++2
         ATSrw7hnTMJflhleLzWqELY+4eOzWuT2KC+0ElYSDfXAPY88MdEnU5GDPiAO7fM9vG/d
         cErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qnD3MaL7gJwETg0aDU8ScTo7+eABrgMEpUSHoSW3sbA=;
        fh=2s6BTDWViPRyH83C3HJ5fASgd1cfS+0iwZoXtb4bKhM=;
        b=kNIxQuNbIYfVKsMmUX2aern8kS4xhxjN6fc6w71qHejFYyeIeEN005E2MCNW6QI1MY
         RshaBH3rYL1BeaDbyYbDJRXeVn/uSaIdLKYBY5Tm6xYNwH2715Z6na22wgBNMrFcLyn6
         WYVKeYeI2FWZERAaE3vxChhfpWufBybKSxg8JfU1iLDpEayfcWadKdvLALamGkWdSqQ1
         VK6Alq5f3ARw2lvwHhqEHmsBiB3chjb+8wCMJDswSn3eOS7P6yx0gp3ltjuOAxqbjPPT
         /n3k11R520aJxLOTpEu5LW1Z0CSx6sDs1FJKmLC7H/v8ylxQp60qeyjOp+PELWayM1ny
         4Kqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772558626; x=1773163426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnD3MaL7gJwETg0aDU8ScTo7+eABrgMEpUSHoSW3sbA=;
        b=dF1/vPlDFKAfVjVyWQYWkzdZNyJC6lZBLL16D4ZCvLKLcu6kOrlcZZ24KnN+wUioSH
         h5/0te0e1HKR7r2RPYV3l6xRB0dpgAafEogySjjUYvI60/Akpy6KQxQpySZU20hU+uof
         spaA07nRXF4EzL7NbgOTVrSra+7IXHQ6b7CYzZiweH2vFKWRNDAwgX+IzB9WglSxARWe
         xjSB7VSx8mRweXXU8Le9dKLb4obhPoNviCBIGCMOJxrFbLxrEzFO7r3qAo/EoWSZAhUv
         Jq2w4KOwTiQ6IeRAlrz23ksaNLZoyu4URvudSjAmutMPraKwLv0IdvpW3UUTGyHLrdE4
         Jicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772558626; x=1773163426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qnD3MaL7gJwETg0aDU8ScTo7+eABrgMEpUSHoSW3sbA=;
        b=DpIe3Bxr8IkQhD2WJQrUFqEcx3VC7DrsH67tKMn6JAkd+JepDx+56er28jLlVAO94k
         P1nqanrWPmp4DhmrZTW4xONMMbh773ukA5KOY+ig1/XKJQ7716lcIm+t/4KY+ZmFAiax
         pO4dkZQst07GB+5aJmZEX7WwIBoB1Xq9hrwlEcN661m2IcFB1VDev9vZL3gaGcAVG82a
         5EmBYnmIyQB9yk6yimUv/dwURejyMK/4XITaNOHbrvZG2TzA0FZCz4TDI9jlHdTkVt4u
         27OMxrzewX1Y9MNDk8sPSnjoMQbjZQAXkktBIY8NepsIsABSl/rlmCyvoVxQwefxRL+m
         kU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVst4T4lujlomCtEJ20vd81j6YuGOzze7tiag2yX3F36QCdCKbDjhmBsKHAcfH32igj7OdVbD6xfpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WsCabaDV20p5E2utY/vHrVPq1xbTMPqUXHxKAFFExqoPycVx
	PnN47st15MLQR/zO3eTqGNo0m6SWZUZ+VQnl3z0yVKuJ1I/yPvJcq4ZO5PY5aCW3WX2+Ur8nQwy
	KdTOPTo3Msvve2xPKJnuMYxRdAs15lSA=
X-Gm-Gg: ATEYQzyplq4HsJte2uQDzLoVuU/Ou5JnGXrH5PhH9BAAALk3GO1BSPyNySvU2UkGH45
	dTAJ+nFHgSigdrZNIDuwP8W9h1e93E6h57xLeA6Gh88bK94f35wfr+r05ZiK+/oPHG9mFlrTiHl
	e7B62uDThZXkkpLH1KSIz3pxpYCVRev6TL4AwKSruOCMlrU5GlPzHRePWDdFyjR3rnDiOd58SLN
	TPNAtxsofJqVHJjT7kNPwkjjieGR+UBx9OX4rBS4p6fO1JdgC/zv3RsbJCgSmeG546wbGGVJ6zx
	PqvttkS/
X-Received: by 2002:a05:6830:380b:b0:7c7:55e3:9117 with SMTP id
 46e09a7af769-7d591bc1e3cmr10891486a34.22.1772558626387; Tue, 03 Mar 2026
 09:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7C2SC_2k6+dvBTRoV1_trpPEF5h+k9KDOapTwcb90+=BUatw@mail.gmail.com>
 <20260302235100.GA4037767@bhelgaas> <CAN7C2SAcJp8nAhbRT9OyLeT2YsvmX=+Y4qhBZR_WQ3aDqNHywA@mail.gmail.com>
 <8d5cdf11-b5ba-2b10-c2ba-76d4aedb5197@linux.intel.com> <CAN7C2SAzfTTiViekA7kkYo2At+qYVSv-y22DyJC5RtdrfLYWjw@mail.gmail.com>
 <ltyufyd2mwqvduccjijrtpudbv7enh3shtyzbvjuz2ctypqy2p@j35crt53ylkk>
In-Reply-To: <ltyufyd2mwqvduccjijrtpudbv7enh3shtyzbvjuz2ctypqy2p@j35crt53ylkk>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 4 Mar 2026 01:23:35 +0800
X-Gm-Features: AaiRm531qBSVg2ztCKX_pDwhIse72M2E_C3tcdoPvDNlktAmietNJ7SBaC2x4VU
Message-ID: <CAN7C2SA-Kyi7gdVwmnoNd68Af6NC2AxVZDKp9H=3U_asWO6zeQ@mail.gmail.com>
Subject: Re: [BUG] PCIe Stall on USB_PCI=y with SoCFPGA Root Port
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, mathias.nyman@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:04=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Tue, Mar 03, 2026 at 09:34:59PM +0800, Sune Brian wrote:
> > On Tue, Mar 3, 2026 at 9:06=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Tue, 3 Mar 2026, Sune Brian wrote:
> > >
> > > > On Tue, Mar 3, 2026 at 7:51=E2=80=AFAM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> > > > >
> > > > > [+to Joyce, pcie-altera.c maintainer]
> > > > >
> > > > > On Sat, Feb 28, 2026 at 11:05:17PM +0800, Sune Brian wrote:
> > > > > > Dear PCI maintainers,
> > > > > >
> > > > > > Root Port: Cyclone V HPS Root Port PCIe
> > > > > > Endpoint: uPD720202 Card
> > > > > > Kernel version: 6.12.33-g3234b1ed8956-dirty
> > > > >
> > > > > v6.12 is fairly old; can you reproduce a problem with v6.19 or
> > > > > v7.0-rc1?
> > > >
> > > > Had tried 6.19 same situation USB_PCI=3Dy simply repeatable hang.
> > > > No message shown or tells what happened.
> > >
> > > Hi,
> > >
> >
> > Hi all,
> >
> > After a hard working day to repeatedly check and check.
> > I finally got it to work.
> >
> > The reason why it is not working in the first place is caused by
> > INTEL-Altera PCIe driver having some registers shadowing bugs.
> > Neither NVMe nor WIFI card had unraveled the inherent issue.
> > While the USB slot card successfully triggered the inherent bug.
> >
> > So the hang and stall is triggered by wrong register mapping under
> > the PCIe driver not USB_PCI flag.
> >
>

Hi Mani,

> Could you please post the fix so that others can also benefit?

I can't as I just simply masked the register area via dts
that possibly introduce the wrong shadowing memory read write location.

TBH, I don't even know if my theory behind this is 100% correct or not.
I am really relying on people that are software-based to fix it.
The major issue here is from Altera driver as long as the sw engineer invol=
ved
dont fix this. I had no idea what the proper way was.

Let me explain the issue here maybe you could also check:

1) Cyclone V socfpga PCIe root port is based on hard IP.
2) The dts and connection design is basically very monotone not much you ca=
n
change.

Follow posts:
https://forum.rocketboards.org/t/solved-nvme-pcie-storage-on-arria10
https://forum.rocketboards.org/t/altera-pcie-driver-issue-with-ssd-devices

They propose a memory reserved that is not actually fixing the issue.
As we can see the 0x0 to 0x10000 is always the issue place.

3) Based on such, having me think this simply collided  with the CRA
although the base bus and address don't share but the dts itself uses the
same node.

Hence either it is introduced under the RTL design as this address is messe=
d up.
Or it is the driver's node messed up.

Unless there is full confirmation from Altera sides this is not an easy fix=
.

The solution I had applied is simply masked the possible 0x0-0x10000 and
dont touch the hazard area.
By such this simply remove the needs for reserved memory and also RTL
code modification or hack.

Thanks,
Brian

>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
