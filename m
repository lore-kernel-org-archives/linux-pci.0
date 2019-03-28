Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B3DC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6670206B8
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 12:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmBZWBK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfC1Mow (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:44:52 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52815 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Mow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 08:44:52 -0400
Received: by mail-it1-f196.google.com with SMTP id g17so5739783ita.2
        for <linux-pci@vger.kernel.org>; Thu, 28 Mar 2019 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4reyUhlpXuiaoca+p4hJqAGMU+o8V2MOi6LYWxDRno=;
        b=JmBZWBK9uIFMzQrMV1C2nmjfl7DhdNAuDTKzRyJqAiLGjrj9OWQkpnwXMY0y7konE8
         sY4Q2w5jDSv9FcSYOr8R5SZiLXTO/GRs1Mkvdj5h1mkEy+wZSle6oAP7QONKIxdzwgzw
         4lWDL4LgZB6HHUTCBsAGtmNOqV+vkg1XxlPzlmGGMfQAyGiSJcMYWcAxIxm+A7jlsZWC
         xsJ6bR6OUGUdLhKjfE5j+DdkvCN2wp64d9WpXk35mCmBtFXA0wUmEufA2HxSwN/M1bat
         EIhOZees2BQP6edFTTNUd1a7WnHPwKrG/N3NzRHxTcTOV/ToXZzd5b1CDTONC1lS6fhm
         6MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4reyUhlpXuiaoca+p4hJqAGMU+o8V2MOi6LYWxDRno=;
        b=oB/O2ANHS4z0FC1Rpy03SRixft8+HLB1FiegZAfOohrxCOZ5D5rSFgxC1FRGMxIKyL
         M86cuTMXr33F5zdgU4AGzGSDGUjY/VWFK3Pr/d+d9zEOpRWvKvhwtCVgDrMRrDjhJLw1
         EE9PvwE+Y/Ku7DyUHkHNpbpHzHS1YU9dBfuzVyC+5NzAsfyGQpOKEuHb1q/WldL3h0ho
         yWcOjZ00Hs49mw5EPJ8A+AK9EzE4fiu99mONi3Xc822+bV8UokAHqbs1ZwceHp+vspHi
         KQX8ra7R3ZSAB1CWLkJecqaaPDBJfNU+1Nqww4AMvVjDMDvh/qLDHtUhh/I1yYsA+Fhu
         1kJQ==
X-Gm-Message-State: APjAAAUk4x758CDebjkLc+XcePqCTbGtL/0n/RIKfBFw6aF99RGmOeOR
        zja9bpdC8jnFgzMTrz/1INztwOobLol9aV2IlHM=
X-Google-Smtp-Source: APXvYqxVpa8bPzejNuh7R40AVXnKiIDKZijujtNUGxyU9yATD27rd+6xCG+qCKGU9fUvrInIyBNTqOnSt3JPqm4cl/E=
X-Received: by 2002:a24:e4c6:: with SMTP id o189mr2377524ith.4.1553777091092;
 Thu, 28 Mar 2019 05:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190311115233.6514-1-s.miroshnichenko@yadro.com> <20190327141010.GB24180@google.com>
In-Reply-To: <20190327141010.GB24180@google.com>
From:   Oliver <oohall@gmail.com>
Date:   Thu, 28 Mar 2019 23:44:39 +1100
Message-ID: <CAOSf1CEKQpHGjEwSwJD3qruKHzQkvH5AWt9Y0eEHs0fAu-1eQw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] powerpc/powernv/pci: Make hotplug self-sufficient,
 independent of FW and DT
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci@vger.kernel.org,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell Currey <ruscur@russell.cc>, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 28, 2019 at 1:10 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Sergey,
>
> Since this doesn't touch drivers/pci, I assume powerpc folks will
> handle this series.  Let me know if otherwise.

I've been looking at it and reviewed the last spin. I'll have another
look next week.

> On Mon, Mar 11, 2019 at 02:52:25PM +0300, Sergey Miroshnichenko wrote:
> > This patchset allows switching from the pnv_php module to the standard
> > pciehp driver for PCIe hotplug functionality, if the platform supports it:
> > PowerNV working on on top of the skiboot with the "core/pci: Sync VFs and
> > the changes of bdfns between the firmware and the OS" [1] patch serie
> > applied.
>
> s/bdfns/BDFs/  Maybe?  I see this is a reference to another patch
>   series, but if it hasn't been merged yet, "BDFs" would be consistent
>   with "VFs" and give a hint that "bdfns" is not itself a word.
>
> s/serie/series/
>
> > The feature is activated by the "pci=realloc" command line argument.
>
> From a user point of view, it doesn't seem intuitive that
> "pci=realloc" also means "switch from pnv_php to pciehp".

I think he means something more along the lines of "allows pciehp to
be used instead of pnv_php." Currently pnv_php is the only way to
hotplug devices on PowerNV because of:

a) Legacy assumptions from pseries about PCI devices always having a
corresponding DT node,
b) Firmware being responsible for assigning bus numbers on PowerNV, and
c) Our root ports not implementing most of the PCIe slot capabilities.

There's no real reason why a) needs to be the case and part of this
series addresses that. It's a similar story for b) which is a
side-effect of supporting Power7 hardware which used a fixed mapping
between bus numbers and EEH error domains (PEs). Power8 and Power9 use
a different method for mapping devices to PEs so there's no real
reason to enforce the restriction on modern hardware. c) is still a
problem, but it's a non-issue for switch ports. Fixing a) is the only
real requirement to allow pciehp to be used, but IIRC Sergey is
interested in hotplugging entire racks of NVMe drives so he needs b)
fixed too.

I don't think passing pci=realloc is the best way to handle enabling
bus number re-assignments. Fundamentally being able to re-assign bus
numbers depends on the system/firmware supporting it so I think it
would make more sense for firmware to advertise the capability in the
DT and have the kernel enable it automatically when it can. That said,
it's worth pointing out that everyone's favourite init system will use
the bus number in it's "persistent" network device names so changing
the bus number assignment policy can cause a bit of grief. Making it a
per-PHB flag might help there.

> The only direct effect of "pci=realloc" is to set pci_realloc_enable.
> I haven't read the patches, but is there really something in
> arch/powerpc/ that does something different based on
> pci_realloc_enable?

I don't think we use that flag at all. Patch 8/8 of this series adds a
pcibios_setup() hook that sets the PCI_REASSIGN_ALL_BUS flag when
pci=realloc is in the command line. I need to have a closer look into
what that actually does though.





> > The goal is ability to hotplug bridges full of devices in the future. The
> > "Movable BARs" [2] is a platform-independent part of our work in this. The
> > final part will be movable bus numbers to support inserting a bridge in the
> > middle of an existing PCIe tree.
> >
> > Tested on POWER8 PowerNV+PHB3 ppc64le (our Vesnin server) with:
> >  - the pciehp driver active;
> >  - the pnv_php driver disabled;
> >  - The "pci=realloc" argument is passed;
> >  - surprise hotplug of an NVME disk works;
> >  - controlled hotplug of a network card with SR-IOV works;
> >  - activating of SR-IOV on a network card works;
> >  - [with extra patches] manually initiated (via sysfs) rescan has found
> >    and turned on a hotplugged bridge;
> >  - Without "pci=realloc" works just as before.
> >
> > Changes since v4:
> >  - Fixed failing build when EEH is disabled in a kernel config;
> >  - Unfreeze the bus on EEH_IO_ERROR_VALUE(size), not only 0xffffffff;
> >  - Replaced the 0xff magic constant with phb->ioda.reserved_pe_idx;
> >  - Renamed create_pdn() -> pci_create_pdn_from_dev();
> >  - Renamed add_one_dev_pci_data(..., vf_index, ...) -> pci_alloc_pdn();
> >  - Renamed add_dev_pci_data() -> pci_create_vf_pdns();
> >  - Renamed remove_dev_pci_data() -> pci_destroy_vf_pdns();
> >  - Removed the patch fixing uninitialized IOMMU group - now it is fixed in
> >    commit 8f5b27347e88 ("powerpc/powernv/sriov: Register IOMMU groups for
> >    VFs")
> >
> > Changes since v3 [3]:
> >  - Subject changed;
> >  - Don't disable EEH during rescan anymore - instead just unfreeze the
> >    target buses deliberately;
> >  - Add synchronization with the firmware when changing the PCIe topology;
> >  - Fixed for VFs;
> >  - Code cleanup.
> >
> > Changes since v2:
> >  - Don't reassign bus numbers on PowerNV by default (to retain the default
> >    behavior), but only when pci=realloc is passed;
> >  - Less code affected;
> >  - pci_add_device_node_info is refactored with add_one_dev_pci_data;
> >  - Minor code cleanup.
> >
> > Changes since v1:
> >  - Fixed build for ppc64le and ppc64be when CONFIG_PCI_IOV is disabled;
> >  - Fixed build for ppc64e when CONFIG_EEH is disabled;
> >  - Fixed code style warnings.
> >
> > [1] https://lists.ozlabs.org/pipermail/skiboot/2019-March/013571.html
> > [2] https://www.spinics.net/lists/linux-pci/msg79995.html
> > [3] https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-September/178053.html
> >
> > Sergey Miroshnichenko (8):
> >   powerpc/pci: Access PCI config space directly w/o pci_dn
> >   powerpc/powernv/pci: Suppress an EEH error when reading an empty slot
> >   powerpc/pci: Create pci_dn on demand
> >   powerpc/pci: Reduce code duplication in pci_add_device_node_info
> >   powerpc/pci/IOV: Add support for runtime enabling the VFs
> >   powerpc/pci: Don't rely on DT is the PCI_REASSIGN_ALL_BUS is set
> >   powerpc/powernv/pci: Hook up the writes to PCI_SECONDARY_BUS register
> >   powerpc/powernv/pci: Enable reassigning the bus numbers
> >
> >  arch/powerpc/include/asm/pci-bridge.h        |   4 +-
> >  arch/powerpc/include/asm/ppc-pci.h           |   1 +
> >  arch/powerpc/kernel/pci_dn.c                 | 170 ++++++++++-----
> >  arch/powerpc/kernel/rtas_pci.c               |  97 ++++++---
> >  arch/powerpc/platforms/powernv/eeh-powernv.c |   2 +-
> >  arch/powerpc/platforms/powernv/pci-ioda.c    |   4 +-
> >  arch/powerpc/platforms/powernv/pci.c         | 205 +++++++++++++++++--
> >  arch/powerpc/platforms/pseries/pci.c         |   4 +-
> >  8 files changed, 379 insertions(+), 108 deletions(-)
> >
> > --
> > 2.20.1
> >
