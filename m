Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28832C282DA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 14:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30C7218AF
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcEz7N8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfAaOQF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:16:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50425 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfAaOQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 09:16:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so2685915wmd.0
        for <linux-pci@vger.kernel.org>; Thu, 31 Jan 2019 06:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QSwmO+7UtDMUl2h5bXPkoUcbj9z4wWNhNk0IkYYWEw=;
        b=hcEz7N8kKKaaS/V3KJhjoSjIwwPae2DwBzoJj0cdXpgjdjy8SHgN246zqrZN0GeUNS
         cKpuUL24AflhsXRTVKIq9KjwCO45KxHOHT8fNOkkBBYuxVKRlf0z7hdgF8z5hku7ehcA
         t4HoeDLXZDBlNG6pblaLZ+w37HtR8drwufDfZH55BQsvJgc2NITYf8Uo69yCF0LtDI+Z
         QR9ZlAGNLnT+mLM/WLGLaj1prDk1pE9kr+mS8ef0BbnMbjgvLrgCPM5p7Q2wyq1/sY+I
         BpRrXsFdbnc2eFOzlVR3yPXrL0AlMFJ74AQBNRbJvvF7EIBRh44G54Jt7u+Pwc/LYODe
         fq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QSwmO+7UtDMUl2h5bXPkoUcbj9z4wWNhNk0IkYYWEw=;
        b=sKWHRioGyUNkVHRjkSkC5XuIvnzODiX6lnv3INR0QIb51cRVnajGYtqfbYDPDPNeb8
         FXsQCQ1Z0iI5Ezve1iegGXFNQEp5N9LcmiDVu0NaCtamiKEiF+rj586r9DCB5dIONTvI
         vwx0Pt5XHCMLgN8UvsUxRjnn8fDoinLq0JqEduK67RAlmK8b/pFIpQwQOK0rkRqJsX2R
         cL3xlaAy0w0VeXa1VTrCB/ppBEndigTygfxf3sChQlGyUmf/Ax5tKvwObG6wFfWQrZVX
         inl0aGIuPR9X6p5uHR0+55Wd0HjgIjrDFmC8C/HZ9oIRxWTI1GC8ozyWaqhm/GMmlscT
         EYBg==
X-Gm-Message-State: AJcUukd1xu57BBQ9tiObhynRZrRYPDCk7lb7xOHEDY90e46D7RMEL4M4
        dFzymGq59JluaM4M+r7jF49QPXCwPbzxFT9a4UKV
X-Google-Smtp-Source: ALg8bN4YjEs8Nk5/Vz3sNiFpQVtBF6HkgDto10Wadwk2Huzt8gBIzAVS/ogE5Xap7DyHArj3MI9wvVXihXyQnt+MKrA=
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr29416104wma.76.1548944162606;
 Thu, 31 Jan 2019 06:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20190131134033.1ed0021d@canb.auug.org.au>
In-Reply-To: <20190131134033.1ed0021d@canb.auug.org.au>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 31 Jan 2019 08:15:50 -0600
Message-ID: <CAErSpo7y-PunYStmzvWvbfz-_CV0yoL2Pro3oC-+f47S3RPYAA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vhost tree with the pci tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 30, 2019 at 8:40 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the vhost tree got a conflict in:
>
>   drivers/pci/setup-bus.c
>
> between commit:
>
>   51c48b310183 ("PCI: Probe bridge window attributes once at enumeration-time")
>
> from the pci tree and commit:
>
>   955156f34e7d ("PCI: avoid bridge feature re-probing on hotplug")
>
> from the vhost tree.
>
> I fixed it up (hopefully - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

51c48b310183 and 955156f34e7d are both to solve the same problem, so I
think the best resolution is to drop 955156f34e7d from the vhost tree
completely.

The remaining wrinkle to work out is that we need a stable backport.
51c48b310183 is technically a little large for a stable backport, so I
want to have a solid justification for it.  As soon as I get a
kernel.org bugzilla with those details (who's affected by the
breakage, what the failure looks like, how to reproduce it, etc), I'll
add that URL and the stable tag.

Bjorn

> diff --cc drivers/pci/setup-bus.c
> index 1941bb0a6c13,d5c25d465d97..000000000000
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@@ -735,17 -735,50 +735,26 @@@ int pci_claim_bridge_resource(struct pc
>      base/limit registers must be read-only and read as 0. */
>   static void pci_bridge_check_ranges(struct pci_bus *bus)
>   {
>  -      u16 io;
>  -      u32 pmem;
>         struct pci_dev *bridge = bus->self;
>  -      struct resource *b_res;
>  -
>  -      b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
>  +      struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
>
> +       /*
> +        * Don't re-check after this was called once already:
> +        * important since bridge might be in use.
> +        * Note: this is only reliable because as per spec all PCI to PCI
> +        * bridges support memory unconditionally so IORESOURCE_MEM is set.
> +        */
> +       if (b_res[1].flags & IORESOURCE_MEM)
> +               return;
> +
>         b_res[1].flags |= IORESOURCE_MEM;
>
>  -      pci_read_config_word(bridge, PCI_IO_BASE, &io);
>  -      if (!io) {
>  -              pci_write_config_word(bridge, PCI_IO_BASE, 0xe0f0);
>  -              pci_read_config_word(bridge, PCI_IO_BASE, &io);
>  -              pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
>  -      }
>  -      if (io)
>  +      if (bridge->io_window)
>                 b_res[0].flags |= IORESOURCE_IO;
>
>  -      /*  DECchip 21050 pass 2 errata: the bridge may miss an address
>  -          disconnect boundary by one PCI data phase.
>  -          Workaround: do not use prefetching on this device. */
>  -      if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
>  -              return;
>  -
>  -      pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
>  -      if (!pmem) {
>  -              pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
>  -                                             0xffe0fff0);
>  -              pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
>  -              pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
>  -      }
>  -      if (pmem) {
>  +      if (bridge->pref_window) {
>                 b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
>  -              if ((pmem & PCI_PREF_RANGE_TYPE_MASK) ==
>  -                  PCI_PREF_RANGE_TYPE_64) {
>  +              if (bridge->pref_64_window) {
>                         b_res[2].flags |= IORESOURCE_MEM_64;
>                         b_res[2].flags |= PCI_PREF_RANGE_TYPE_64;
>                 }
