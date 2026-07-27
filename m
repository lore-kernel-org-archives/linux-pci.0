Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F142D76A
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194562; cv=pass; b=T0G9nvQTgA91TuE4KtZWNUxidbAUWvRl5IRAtsYw2E6c00ILVeA14oCgFhY7eoL+sMs7hmzfdAqO683C/agquHm9M7zzQixpZ7AOkUkH2YFmkXL2Vc8D4JIsGKV1xvpeqLJ51T0fReQHebPaXgE6+GC8lx/VyaVK9VoghA87wbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194562; c=relaxed/simple;
	bh=x2YfyQuuYptbEm86xUEJU9QONiWzDVBm4tEBFRHih5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtlPrPp6ADC/ET+UEdW4RqvKMOUARzBmAjC0/CHyugvVoO4HIdzCLr+gGsgyVTfUo47LwlUOfv/l2Dfbcdw4+cRanigQNj0BHV+YJEED5BBCLLkANu3R4a8e5Hu9df6nSOMrbHOcVy7lasQT4ieDP+Mc0NKP0pYchvALQ8Fo9gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEXWFnpr; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEXWFnpr"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso2363745a91.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 16:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785194560; cv=none;
        d=google.com; s=arc-20260327;
        b=nuFoti174YB25BLJbtaBmzXzUEhHngTKVSVxBy49YVHPa7aLQ98QVgHX3DtMHTGgr7
         rdshyT/ivleeQ2Fb0Hw+mNzABcuOaZyv93o0xuiqcLt0lbIf2ukBVHNyttHyHJOzxHbw
         zKdXdHUysFS2CP88sexD2pCeRl7/SnIkZnz3dZBif56LxUzvxf1HKK/ffT5DJlYFtQjg
         g74+IkRtRfjeo8DNbqvz6kHZM1M2gpqKCmtLjie89/twgtbrC0hNQfTn06IxyKub6PbG
         dOUzUmRDAba62tIlSM3IumWuZxWkc3wm9A2ukz4i8D61JBubRtCTeOqm4UNy4XOZocCC
         O6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aH9fxD7OeNQpvbALLCFcfoa0nXkldfT8Qxn7YBj/IBU=;
        fh=2FGVOuhFZIfDJORN+e7p/Nvp21tYp7Yq2Y7wCeTN1Zg=;
        b=lFLv3pD7YcgEbmGflZXzGFBIYuXOervEorApjQoV5vggPHJsfb1t/hYeCJSG85eHEq
         YTVJzKNFqI5jycR6H599ARfnMTyiNdURdOJgB+FzHqkMVHRheFwWCZs28IhLlz/F1N/I
         jPrQEkYCb4cMV8DiD1sGBHM8ER4AayB0lqW3x3smWHGRPnmmxgqaAqtpBGU2aWYwD+fR
         sHBE1wzqPAOSr6D6JFxGaux9Kfwj4zh8AjnrHxsvddc54bKruGVcHXPebeoDN8y6KWTA
         lZ6R/WTiEhdPmg+EBsqkGpep8/5oG38rSGvGaml0B/T0SUnPOXf2sEgblma/TfjuZnCF
         ELvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785194560; x=1785799360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aH9fxD7OeNQpvbALLCFcfoa0nXkldfT8Qxn7YBj/IBU=;
        b=NEXWFnprkB3n+HTEybyyO043edD2Ldzqzz/FKPFolA/66oNACtuIEg/Y2OnUTBEx0Q
         37z68PeLTdCP1YnF1DukeMeF7F23ysGiB3gCo2F0SldGOCpcGh0TCSrT/IbuJQriNSU2
         ypB5HBtPcfzdFJMkNW03+8LIIPh5mqXaBxIJ7FOJkGUN2Bva6Ccm9t1GMdOWvq4TwDVl
         6CetUp4DdGXd8mbSIvIJjUTE88iXgB2cTozgZOozWo47YyzKzTxv3Sg1OVEFMOQ2w5zQ
         9LtoijvBiJA8mExVG8dzY1qwBPUlGZWSHcZd6A6aQzcR26nXgIY4hzEdV1sgcp+YNLGe
         CKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194560; x=1785799360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aH9fxD7OeNQpvbALLCFcfoa0nXkldfT8Qxn7YBj/IBU=;
        b=ptDBE+I03kpJkFrgWaglAMg4kZwqHpMiOF4y09YkNi9REzVojRDr6844iDvtxme3F9
         r30FQBbmE0/HXvcbXIOlWAQnoz3KUe/v/KFmEMTFPdulySH+FrkFT62o5OVcaO/6JaiE
         n19e/RzlNDjy2D0mBTfHS6IQNVyV+mvUipgpmC85ywxVmNw9D2zhdYMJfTbz5Fknobpf
         0gnCZXb6HmdfLDKlBukbyi66uR6YNfbabrBLovgI/zNXYQexWexbstiIlFmasgSlkcj0
         8CInXYuOPs7PaYnY+lJOfsLG9KhUcVUJhbLTA/es0CdYTeQAvWNIDez2/dA7FYxZXRW4
         +Tcw==
X-Forwarded-Encrypted: i=1; AHgh+RqS++zWBQkZJ7Y6o4zriXwEaKETnemboKW0XzqYfQRHkyW0lUeusDrwL2vRGy7jg41L6hV7vm01zLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5cYc3HE3TEhHHAUIsDnkIcb9HnrLBefyfJ9XGuD/mzB8PefH
	zRpKsFTFT4wCH4y90mlnmxw2qsJF4lzskgeK+Q16FFvW/f2jMKe2uOzm89WhbOFKYJStPoyi6R2
	GhaO02n6b/Kv4WNGWR9ySPUSPGOgK8R8ULecfNQSd7YmhdzVD7ca5XGhDT/w=
X-Gm-Gg: AR+sD1122kAZJO6UepcbtHAbh+jUBfpSGxK3NzrquJLHEISfmc8OXw1dsigILou/XcI
	Bm9JqKw5jyJa5DWGx6puCrCRhMFjd5LePjnrofMR/KPcGQ6POipPFuwwKTu8AzQmUYpCYATq5e+
	wCpMA1IfzNka0wQa0PeHUuG7EeYB5D+ZTVCwOrKNpvb2MWjeOAZMMb9r9NpNIwuIPxbFUIb7j48
	qOPMk6frEXXx/CfusPUtHpCBWr0vOk91JHzvBDeXlJMDGl/Tpwch37scYYusw==
X-Received: by 2002:a17:90b:2487:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-38f6a030477mr10389a91.11.1785194559678; Mon, 27 Jul 2026
 16:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710212616.1351130-10-dmatlack@google.com> <20260727230740.GA1273350@bhelgaas>
In-Reply-To: <20260727230740.GA1273350@bhelgaas>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Jul 2026 16:22:12 -0700
X-Gm-Features: AUfX_myIRjJ65ll44x1imgmZse5x82nFT62Po-YqpjuwILzl8FbHo5wgsdHMnzc
Message-ID: <CALzav=dHdtHPKJVbtnc1BwzccKuGSPxKH9Gvpv1ZVw4z2-0txg@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] PCI: liveupdate: Inherit ARI Forwarding Enable
 on preserved bridges
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

On Mon, Jul 27, 2026 at 4:07=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 09:26:12PM +0000, David Matlack wrote:
> > Inherit the ARI Forwarding Enable on preserved bridges and update
> > pci_dev->ari_enabled accordingly during a Live Update. This ensures tha=
t
> > the preserved devices on the bridge's secondary bus can be identified
> > with the same expanded 8-bit function number after a Live Update.
> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c | 18 ++++++++++++++++++
> >  drivers/pci/liveupdate.h |  6 ++++++
> >  drivers/pci/pci.c        |  8 +++++++-
> >  3 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index a95bfe5eff77..74a11e520f0d 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -128,6 +128,10 @@
> >   *    way after Live Update and ensures that IOMMU groups do not chang=
e. Note
> >   *    that a device will use its inherited ACS flags for the lifetime =
of its
> >   *    struct pci_dev (i.e. even after pci_liveupdate_finish()).
> > + *
> > + *  * The PCI core inherits ARI Forwarding Enable on all bridges with =
downstream
> > + *    preserved devices to ensure that all preserved devices on the br=
idge's
> > + *    secondary bus are addressable after the Live Update.
> >   */
> >
> >  #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
> > @@ -816,6 +820,20 @@ int pci_liveupdate_enable_acs(struct pci_dev *dev)
> >       return 0;
> >  }
> >
> > +int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > +{
> > +     u16 val;
> > +
> > +     guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +     if (!dev->liveupdate.incoming)
> > +             return -EINVAL;
> > +
> > +     pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &val);
> > +     dev->ari_enabled =3D !!(val & PCI_EXP_DEVCTL2_ARI);
> > +     return 0;
> > +}
>
> I'm guessing we're going to see a lot of this pattern, so it will
> eventually become familiar, but it's not familiar yet ;)  This doesn't
> "configure" anything (I do understand that avoiding configuration in
> the new kernel is really the main point of liveupdate).
>
> Maybe a comment is the solution.  Or maybe a rename to
> "pci_liveupdate_ari_preserved" or something?  That would have to
> reverse the sense of return values, but I think something like this in
> the callers would read better:
>
>   if (pci_liveupdate_ari_preserved(dev))
>     return;
>
> or maybe:
>
>   if (pci_liveupdate_preserve_ari(dev))
>     return;

I do think a better naming and return value convention is needed.

Perhaps "adopt" or "inherit" as the verb? i.e. "adopt/inherit the
state of the device established by the previous kernel"

if (pci_liveupdate_adopt_ari(dev))
  return;

or

if (pci_liveupdate_inherit_ari(dev))
  return?

>
> >  /**
> >   * pci_liveupdate_is_incoming() - Check if a device is incoming-preser=
ved
> >   * @dev: The PCI device to check
> > diff --git a/drivers/pci/liveupdate.h b/drivers/pci/liveupdate.h
> > index 4e8a01bcb4bb..6f21ec50927b 100644
> > --- a/drivers/pci/liveupdate.h
> > +++ b/drivers/pci/liveupdate.h
> > @@ -18,6 +18,7 @@ bool pci_liveupdate_scan_bridge_begin(struct pci_bus =
*bus, struct pci_dev *dev,
> >  void pci_liveupdate_scan_bridge_end(struct pci_dev *dev, int pass);
> >  void pci_liveupdate_init_acs(struct pci_dev *dev);
> >  int pci_liveupdate_enable_acs(struct pci_dev *dev);
> > +int pci_liveupdate_configure_ari(struct pci_dev *dev);
> >  #else
> >  static inline void pci_liveupdate_setup_device(struct pci_dev *dev)
> >  {
> > @@ -46,6 +47,11 @@ static inline int pci_liveupdate_enable_acs(struct p=
ci_dev *dev)
> >  {
> >       return -EINVAL;
> >  }
> > +
> > +static inline int pci_liveupdate_configure_ari(struct pci_dev *dev)
> > +{
> > +     return -EINVAL;
> > +}
> >  #endif
> >
> >  #endif /* DRIVERS_PCI_LIVEUPDATE_H */
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 739ecaab2e76..e0c133b66a35 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3528,7 +3528,7 @@ void pci_configure_ari(struct pci_dev *dev)
> >       u32 cap;
> >       struct pci_dev *bridge;
> >
> > -     if (pcie_ari_disabled || !pci_is_pcie(dev) || dev->devfn)
> > +     if (!pci_is_pcie(dev) || dev->devfn)
> >               return;
> >
> >       bridge =3D dev->bus->self;
> > @@ -3539,6 +3539,12 @@ void pci_configure_ari(struct pci_dev *dev)
> >       if (!(cap & PCI_EXP_DEVCAP2_ARI))
> >               return;
> >
> > +     if (!pci_liveupdate_configure_ari(bridge))
> > +             return;
> > +
> > +     if (pcie_ari_disabled)
> > +             return;
> > +
> >       if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
> >               pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> >                                        PCI_EXP_DEVCTL2_ARI);
> > --
> > 2.55.0.795.g602f6c329a-goog
> >
