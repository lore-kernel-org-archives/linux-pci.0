Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8558C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 01:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA43214C6
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 01:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545097949;
	bh=rjjvVdFBYOMMQNdmFAwDkCpHhYY4LpmKw73t/Gktycg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=djrfoqFnWfaGGxFGwUDcjgOT+we8EAJTICbb7ctr1oEWTMjLXXx+szTiMu1Kzg59k
	 o0MVddhwnFyxhxPdLQsvt7y4YP79j4GEpXIYZYuJDuaBpMwubIa/AocMdfDXaM+qEP
	 dQ25SBahX2tkuBdvJmp3+s4I7qu4huEZ/bLqwrsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeLRBw2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 20:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:44032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeLRBw2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 20:52:28 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC5D214C6
        for <linux-pci@vger.kernel.org>; Tue, 18 Dec 2018 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545097947;
        bh=rjjvVdFBYOMMQNdmFAwDkCpHhYY4LpmKw73t/Gktycg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tc0FBJPtsJbpZThao10IkX0CLI0tCzlDP/MiCQV0zZ7O+C1VLeYD2A1e7cGUlBgiJ
         jzKAzShvHq/Wz3WmZ7uldCh7JT7tsq99lc12kPfsa/m7Mz0bBAOcWlcgkqQn+TTIlp
         CnXcghztbjSVGcd3xwdY1evnBZGPrJ8+OqvUYrDc=
Received: by mail-oi1-f180.google.com with SMTP id h25so737690oig.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Dec 2018 17:52:27 -0800 (PST)
X-Gm-Message-State: AA+aEWb6LZ519OUWpbAw9w4Fi5cER980qP32o1A4DdTAlr17fWrR+Qyf
        JbozVZovM0od3oUN4MclKwkPZBkjYovoQm/nIcs=
X-Google-Smtp-Source: AFSGD/Xj+6d70BxX4Fx2p4hJBZprVH+Z8O1EaxG85r0rvo5A6lr7lkGtWrdhmb77u7NAkAQdS51t1dtrES2FMt8DEhk=
X-Received: by 2002:aca:3403:: with SMTP id b3mr6480475oia.242.1545097946937;
 Mon, 17 Dec 2018 17:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20181201204137.1786-1-okaya@kernel.org> <20181217192721.GA28981@google.com>
In-Reply-To: <20181217192721.GA28981@google.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 18 Dec 2018 02:52:16 +0100
X-Gmail-Original-Message-ID: <CAK9iUCMFMFT0ZTaf4pnRDUFZW3cbGnCoq0xCM-or0Xm91Nvggg@mail.gmail.com>
Message-ID: <CAK9iUCMFMFT0ZTaf4pnRDUFZW3cbGnCoq0xCM-or0Xm91Nvggg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PCI: Stub out read/write/raw/find functions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 8:27 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Dec 01, 2018 at 08:41:35PM +0000, Sinan Kaya wrote:
> > Need stub functions in order to be able to compile ACPI without PCI
> > support.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
>
> I can't tell where this series is since I only got the pieces that
> touch PCI and the version numbers and n/n numbers don't make much
> sense then, so apologies if I'm responding to an obsolete patch.

Yes, this is an older version of the patch series for removing coupling between
ACPI and PCI.

>
> > ---
> >  include/linux/pci.h | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 11c71c4ecf75..15407f469d41 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -682,10 +682,22 @@ struct pci_ops {
> >   * ACPI needs to be able to access PCI config space before we've done a
> >   * PCI bus scan and created pci_bus structures.
> >   */
> > +#ifdef CONFIG_PCI
> >  int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
> >                int reg, int len, u32 *val);
> >  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
> >                 int reg, int len, u32 val);
> > +#else
> > +static inline int raw_pci_read(unsigned int domain, unsigned int bus,
> > +                            unsigned int devfn, int reg, int len, u32 *val)
> > +{
> > +     *val = 0;
> > +     return -EINVAL;
>
> Why do you return 0 here?  If a PCI config access fails, you usually
> get ~0.
>
> > +}
> > +static inline int raw_pci_write(unsigned int domain, unsigned int bus,
> > +                             unsigned int devfn, int reg, int len, u32 val)
> > +{ return -EINVAL; }
> > +#endif
> >
> >  #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> >  typedef u64 pci_bus_addr_t;
> > @@ -1599,7 +1611,27 @@ pci_release_mem_regions(struct pci_dev *pdev)
> >  }
> >
> >  #else /* CONFIG_PCI is not enabled */
> > +static inline int pci_bus_read_config_byte(struct pci_bus *bus,
> > +             unsigned int devfn, int where, u8 *val)
> > +{ return -EINVAL; }
>
> Should these set *val as well?  To ~0 (or 0) to match above, I assume?
>
> > +static inline int pci_bus_read_config_word(struct pci_bus *bus,
> > +             unsigned int devfn, int where, u16 *val)
> > +{ return -EINVAL; }
> > +static inline int pci_bus_read_config_dword(struct pci_bus *bus,
> > +             unsigned int devfn, int where, u32 *val)
> > +{ return -EINVAL; }
> > +static inline int pci_bus_write_config_byte(struct pci_bus *bus,
> > +             unsigned int devfn, int where, u8 val)
> > +{ return -EINVAL; }
> > +static inline int pci_bus_write_config_word(struct pci_bus *bus,
> > +             unsigned int devfn, int where, u16 val)
> > +{ return -EINVAL; }
> > +static inline int pci_bus_write_config_dword(struct pci_bus *bus,
> > +             unsigned int devfn, int where, u32 val)
> > +{ return -EINVAL; }
> > +static inline struct pci_bus *pci_find_bus(int domain, int busnr)
> > +{ return NULL; }
> >  static inline void pci_set_flags(int flags) { }
> >  static inline void pci_add_flags(int flags) { }
> >  static inline void pci_clear_flags(int flags) { }
> > --
> > 2.19.0
> >
