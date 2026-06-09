Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4624968FB
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030469; cv=pass; b=okIaZ6mftFezbT0voEg/HWTQz5ySzX9746KCKPSWejckCBIt/EXhCfN93PKGI/NLVahXHr9+i/H2efvx6nC80mQRZQUxAC+Ho+6LUyGuztbL5P8pivdPWltInHTmBcKjLB4kLLd4JWPC8/vxyRQmjuQqV3m3umfzFMXLpxcSqQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030469; c=relaxed/simple;
	bh=dXGLi431l7+tBBr/wFP1O2Ys/PtUuKJInSX0D2b0rys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIVxl/WyFRhDhFAntbPSkzcjHXMPG3DgoQusLDFuUmR9V/OfMMtFdAMMCfbEQZB+dtPQCAJdQbFVSUm0e40AAH6rMwNYA0xwsgk0QmBCmKDYe01XM0vHrUgif3YdfFZlZq37QoR+POq2GZrfrphwGWhtx5DJ6h7CJ+pRTmqNAwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0L4IDFH; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0L4IDFH"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-137dd4cc208so3804083c88.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 11:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781030467; cv=none;
        d=google.com; s=arc-20240605;
        b=bRjlId0Ytw5KXYQa5DGKuj2u0T8cNqAg4cxPA3d9ZdQXTdrBTLGdZCRXq8DEd1QNV9
         hM1Jo3VAJN04gPTObFYi0xq2b7/arJJdrOWUPDnxbD576YltcC7ktL1nEXI8X2C8/z51
         z46DOkjLw0gRfD5P0NnbqLQQ2aM7DQrTUILS7RWxD3vqRS9mo7DrpZ1M7P0j4qwaMpTl
         cTmvinc2obe4l+mMZO5mWTqFj+FmUAImLaOb3HSmxVZMSdEsyOnOL1T+PdCE1wSt91qi
         /eukewu2zGbjHA5aRrLkZLkvckOvy0VXtHWAUjZiQuJDUyyR1VSsXoDPVLEgARKEyEQb
         jb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rp2AVHnvaLdz2Pq3FiqBKoQWbYzwYe73io7ef1uKgPQ=;
        fh=vSubIA/qPoG9TfI4HzTU8gtfBe93saYM795NzW7SSdU=;
        b=CQqX9nN12yOjPT+Wz7aVAxftPVg0kKaeK47AKMtGqkct+Au09y88UBtWrrzlXuOYk9
         kOl3SrRrmTCJ83u47hZ6lJoRTWMxpQTldjz1a0a3wGnQZWSmNaMnGq5+Q5/X+XH3IPwa
         Z6PsIU2qq9C8Jfnrr9mTMRtiEaDMJFE4a3Z2Hx4tvYogL0g71Y6yzOOcWA6f77LVgVIv
         hmRk7hP5hT86596K0MMR+YEmx+WGI2ZHF1ToE93MH6+AROwTVird7RYdjnmqb0eCRYY2
         9xEjXPEhL9t2bcndVsjdrbc4d4+J/cX7diR3OQ2WB965ZJn+eJKH370W3NDSv7EPCenn
         IbPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781030467; x=1781635267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rp2AVHnvaLdz2Pq3FiqBKoQWbYzwYe73io7ef1uKgPQ=;
        b=H0L4IDFHJn7p9izEmb0m3v+xqccfgHShqsBa9rSr5Xo6VBHgKnUKM1dNtnh6x8ySP9
         5m0kgoQRXd7GpUl4u19Vwdc/McaOJ1Yn8luGzK6uHGiIhn6wvIPFrzR98HZA/77/+4ui
         fQHIFFc8YNm67IS4YSr77e0zi+kDGZtdlDeRZR3pOvFoG7JLZYydDJ7LVkzjb2ZPI56O
         9yH5PuyDsvUt4SI+zunlUaR4Q3pX4UKFoa/OSUEM2sdRUFRNh0Lvp0YZJxo5koeeRt1V
         XLxcJZrKNL3JMDsWciu3zhPpO5WjiDLgnQ+TNhiiLYYT5p0DbcT5Lvfd7/aW8opNJ2QS
         7hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030467; x=1781635267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rp2AVHnvaLdz2Pq3FiqBKoQWbYzwYe73io7ef1uKgPQ=;
        b=aiRj3HQBb/Ziaf06Bc19703Vyq46+cLGwxMLcMR/ShlbrPQKOl4IGkpzP3i5V+o6UO
         fvv/KN2K6FpAXGmUlG2Opkjanld1VoWK68KIWzLhamm4OspqZ+x5IOuAlIDVRnNgA21C
         IXuoUfAugiLz6pV95mo7EpJ8TeZPB/426lr3y00Gc1Gm1xCkLKHVjvIuQR9wo+dkS/r/
         VSGCrYr4vNwCku3N3fw5/t1qzYLh7+08MmdZdXQMGhL30eeqcA5+xQChg2WEHrSonVZJ
         kQWP2xdxwZenX1Lki8DkTqErX6ZhxTNqUxnTFmWbgWmnQFAvL+UuG47h/ruGj8vGRqTv
         tA/w==
X-Forwarded-Encrypted: i=1; AFNElJ+bJqxkqP1eiQoRYy5hy+7eEWLhE1f5al8Y0tSCFhKXWZzoC/E3/6vsP1E5Ku7Sp1XGe3gz11TfYHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCg06f4qi7DAmNptQkSMpVICug5DiGt7EWgOdSqNz/p9zhVrxz
	e5IWTKBbbc22kRmJtv866gO7aXevKIxG8GEa1qD6AWb9ZfU6aFNVpiuxDu53hgRD6S75ZU4dp/2
	kE2uzZb7JkdS085ZEHe+7/3pzIXE/2feoQWF8QMfH
X-Gm-Gg: Acq92OGSpD22PQTr31WkhfaxIL1VWiFlxwBC0itFFqjyBwWVDG8mu+26Nl9CsQ3Rbnr
	iswwfR4HESxl4+k/gMlOj6HrQ6Ky/+oNaG6yjCdrayD8EDGUp41EB5WIGTbr595C1iFlzTzW0uP
	8KZQSzJJE+qMa3g6btwh3HnKZOhiZD+GqAyBk9p6OeOSw0x9Shj1O75mYFtzwKcN3Q0SGoOoq52
	9hDvUM0uhAtKD7L6Ku/Cf434T/0wCE5kMwVFJZjNQQGJ8UT/cGjx/b1dlLYebodtEhvI2ZWXZ5i
	smUNbIc6n9oMMRkGAVd8b9UQ1ral
X-Received: by 2002:a05:7022:327:b0:133:39b9:9720 with SMTP id
 a92af1059eb24-13807d7f8a8mr10097032c88.16.1781030466370; Tue, 09 Jun 2026
 11:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522202410.3104264-1-dmatlack@google.com> <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com> <aic6mdiZ0qUJpFca@google.com> <aihLTgs1Y49OXQaV@google.com>
In-Reply-To: <aihLTgs1Y49OXQaV@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 9 Jun 2026 11:40:39 -0700
X-Gm-Features: AVVi8CfFJIkIzWoDM1n34NzkGcY8xgKn7goqY8e0r212_RJvyRI4sWlWr6KLrxY
Message-ID: <CALzav=dagHvcS8kbTti5rmMoks9DXuCpO3AjptkQ8z_PdG9JyQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
To: Pranjal Shrivastava <praan@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 10:20=E2=80=AFAM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Mon, Jun 08, 2026 at 09:56:41PM +0000, David Matlack wrote:
> > On 2026-06-07 08:37 PM, Pranjal Shrivastava wrote:
> > > On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > > > Inherit Access Control Services (ACS) flags on all incoming preserv=
ed
> > > > devices (endpoints and upstream bridges) during a Live Update.
> > > >
> > > > Inheriting ACS flags avoids changing routing rules while memory
> > > > transactions are in flight from preserved devices. This is also str=
ictly
> > > > necessary to ensure that IOMMU group assignments do not change acro=
ss
> > > > a Live Update for preserved devices, as changing ACS configurations=
 can
> > > > split or merge IOMMU groups.
> > > >
> > > > Cache the inherited ACS controls established by the previous kernel=
 in
> > > > struct pci_dev so that ACS controls do not change after a reset
> > > > (pci_restore_state() calls pci_enable_acs()).
> > > >
> > > > To simplify ACS inheritance, reject preserving any devices that req=
uire
> > > > quirks to enable ACS as those quirks would also have to take Live U=
pdate
> > > > into account.
> > > >
> > > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > > ---
> > > >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++=
++++
> > > >  drivers/pci/liveupdate.h       | 11 ++++++
> > > >  drivers/pci/pci.c              |  5 +++
> > > >  drivers/pci/pci.h              |  5 +++
> > > >  drivers/pci/quirks.c           |  7 ++++
> > > >  include/linux/pci_liveupdate.h |  6 +++
> > > >  6 files changed, 102 insertions(+)
> > > >
> > >
> > > [...]
> > >
> > > >
> > > > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > > > +{
> > > > + guard(rwsem_read)(&pci_liveupdate.rwsem);
> > > > +
> > > > + if (!dev->acs_cap || !dev->liveupdate.incoming)
> > > > +         return;
> > > > +
> > > > + pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->live=
update.acs_ctrl);
> > >
> > > I might be thinking out loud here, but as an attacker, this motivates=
 me
> > > to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register acr=
oss
> > > a liveupdate to fool the incoming kernel. If the FW feeds a 0, it sil=
ently
> > > strips ACS protections.
> > >
> > > Should we also serialize ACS state in ser somehow to ensure we aren't
> > > fooled by something like this?
> >
> > What does "EP FW" mean?
>
> I was referring to the Endpoint Firmware (basically any SW running on
> a downstream device)
>
> >
> > Does such an attacker even need Live Update to attack the system? It
> > seems like such an attacker could route TLPs in whatever malicious way
> > they want regardless of Live Update.
> >
>
> I agree that compromised PCIe devices are a menace anyway. But I was
> talking about the potential window opened up by Live Update here,
> suppose we have Device A & B assigned to 2 different VMs (implying they
> are in separate IOMMU groups because the switch set ACS_RR =3D 1).
>
> Now, the attacker has an opportunity with Liveupdate, since the devices
> are already assigned, if *somehow* it flips a bit like ACS_RR, the
> incoming kernel might see both the devices in the same IOMMU group.
> Who detects this case and what happens if this happens if the devices
> are kept assigned to these VMs?

I suspect that would be caught during the restore of the iommufds to
which those devices are attached.

The kernel would attempt to restore each device into a separate domain
(since that's how they were preserved before the Live Update) but that
will fail because they are in the same group now. Even if one of the
devices was not preserved, that will still cause a failure when a user
tries to start using that device (e.g. to try to attach it to a
different VM).
