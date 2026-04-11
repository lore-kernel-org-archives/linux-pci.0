Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C733030F
	for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2026 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775904045; cv=pass; b=aC8pIGef93et+06HHCDLFIiBQzI7uwH4+Kk33hefid+F8DRK9yteUOJpi0MvCJfYlyEIwWZLvbW1Y/pwVmTgDHMVHUGwIFMgbkgMV+i2sToU7JlqhjoZSlbFv5rmS+8Qyo/EZlvcInWZnLCHIKbgItJZnodkEjP0Jwz9IyzBZxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775904045; c=relaxed/simple;
	bh=oyynzTd3CHvuKUMUYUqZYFbKfdT+kOE3lzJVtCfiyUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCFa2f1CTztFrXnHKfBVbFXBgEHhxE0DXboonb3j5X53AvDfgvIOGkUnXSNojVWuXegUx7lGTpDhlIjCzOqY8eIqybQYM8flrQVOM3ohQEaIknv2CYQNmppSyRh72eZoXF2U51t1LvTqzrUAjEx9UWYXkZim26CQAdwSt1Ixl1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5n9eL0g; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5n9eL0g"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67011a751d2so2059784a12.2
        for <linux-pci@vger.kernel.org>; Sat, 11 Apr 2026 03:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775904042; cv=none;
        d=google.com; s=arc-20240605;
        b=H+PYl+RPgeocbmdyIdFDBOSMkG33zqLoYHHsZnnJ5/YDFCuE/Vok1e3fCUJxD7p8iD
         g9IJoNZlaq9X7LQS3ykV+XqMYCQ01kJIS4VQaCzyW+3MQiUKX8yX0UPYn8iMiExArbVq
         xr7zrr0YrOgGNU3V0Ikh7joTiE3urQ/M3+tqCpl39KD0+CLXjq0/hFubkLY+2seMb1Yj
         3n5aRBE7cyGaPPx6jq9c9aK01+noj9z9axfPolwNyIvvTq//MWKXEXQhMlS1z9yr27L3
         LUGBPYXCSci9/+KrAisVbmqaGyeetDW6uLZ+TFvta6SozxAF4BGIqbVjE98iJkuPji6t
         6vpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CsqzNkDnXitYu6WtxNz/ljnO1ZLIoc3+9EuFkHTOA9o=;
        fh=hiJbohMIjORvshtfEAoznnYufy/wj8FNldk4bpUyGNg=;
        b=LYbnWcXKS8IDjYg4noPIOxiGrzAgP7bEfaE/Sv70BpG8ZY/+NDNr9V5I+QMFs7Utku
         kS8z+TasiVqVT7vFSPIG1YD8AInN0Y5hq8bJiR6Ls/vYr0DvBRpfz5/n0cZi5SC5F4bA
         DkrjOvqoh3KLB9aIzplQCM6L2J795ap53GIRRlx8x/kGVPYOaHFxlnWlh3whv50V5FoT
         2axu+x05asFRIEhna68Xf3cCMBvWldc1BQliyhJidtQDuqk4BmXBPhok4jC/gXg/lQIO
         njUPvNalptbf2VIvnjtVNfDP3qwdl2KoUdXlQrlPmPhFs+b08c3H1A9i0ofyocU107zh
         IXpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775904042; x=1776508842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsqzNkDnXitYu6WtxNz/ljnO1ZLIoc3+9EuFkHTOA9o=;
        b=a5n9eL0gCaid/pKg5If553uHP6a3rtzd7ezPe5ES6U3tLqLnY7s1cdwM8g71V97jXw
         +1NNUeJ/x5YM+mjTQhO1f9PXuq1LcEBQJgKmq4RZdP758pzCCkM1y3ZcUSY9YDWdg+9T
         bHV1CwQXXvK9E1ELEbM7IjwWcUJtuFhvA9zARztsXJG8jp2TGQeyx0ed/QMkxK46Fl3i
         Sgyhxwc/K0zIPp6ISKhCL9cygzweZIv2iGxRQ6bKqOTZejpSfhttmi0A5Agjsy8nVyy8
         2oQUpG/dTaj4lUZQ0GCEOpAevXMWVjsYEcGIJgi9k3GEORAuEWXLXBqGUcDgi9OUIDHb
         AooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775904042; x=1776508842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CsqzNkDnXitYu6WtxNz/ljnO1ZLIoc3+9EuFkHTOA9o=;
        b=PHVkPpTGWIDe0tNxbXZyBHtgatlsHgpCTY6JINHbqKQpZqqFGqGG8PppGFTNQ/eBNt
         5HUF6Axz4y7m/9XlkX6RxiXKSlIAg5ZmroKJM1jrFlFR8Pj4mVKnbrZSeV3wVBGGkuhi
         jH+pQI4MBfvz4U3hMOejb0tHOzZbrz2GO0I+Cx4crlT8ukdOHQatAD0GVSqPUKtJ3y4w
         vO08bx6IjKd84JWOWbDFJKJh4cwIVXjrtn5COB5pw1Ip4+I83qcWwbl+u+z16xopbLTH
         Q5fWdZqJC7O1kuHuSPQLyhOBXOyMhaYB6eXNSa7pDInqBVvdX0hX+WsQMd+kAmuVkKQR
         k0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Yoy2mNfTn2fpP9chcJzHgDu8fNnEhqMmBdrebQ2A+m8QkVvNDR8044Qr8lrlvREfIXfEHmdHOTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtgsqAPArutPAgbrFmVSDZ3ZTPycEHpoqVILWbNMpiT9wAn37Y
	jDtw8sBZ9wFuFKUmg5PN6q88zpKNDqQR3YNMe7lXTMnHJMUu6fT79UQJvVRPtAuNNOkqbbrZ5MX
	spVD38nhkLYrYGVXEX7OgxcIYst1tIY4=
X-Gm-Gg: AeBDieuc3zLz/FWyhFT3pElx1cfp/ixVlfzcUnIa0mtgqxW8w3oEIKbxv9KXnqJF/f0
	hRLotmYx+o9+euMjFxhDDB6ChTzMszA0hwZBZ+uiSbv+udrKiK0AxikEya2QTCII7hH2yKjQEb3
	rGZlYAnehEGxpYLktlLtXyZguxfMCLWjdL/OJl4beRkfUq4Sv3U6kwlHOB+XWtq4Y7b0eRVPi+m
	XwZYDyPCQTidBRsPCQnoW5nHkdlte9lqegMq93JGVnmwgz/T5gAeubJGxwuXYcEIullOKqcsWv8
	7XeyAk8/aXnKjgnu1rdCnEvhsLSAd33WSjQ5Nl84ZqMvRnkyeg==
X-Received: by 2002:a17:907:1b1b:b0:b9d:3c22:b2c8 with SMTP id
 a640c23a62f3a-b9d724f0c56mr414074566b.1.1775904041152; Sat, 11 Apr 2026
 03:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411080148.471335-1-kwilczynski@kernel.org>
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Apr 2026 12:40:29 +0200
X-Gm-Features: AQROBzBL0ISJ1oDzmS1WdKnfmR7mJ-8b5qly2wKGmSLW0OsznpAbrTTOYjF1FCI
Message-ID: <CA+=Fv5Q1tZQwnanw99NbvzT-QenfYz7vUdY02_TuPqHX32ZAiA@mail.gmail.com>
Subject: Re: [PATCH v4 00/24] PCI: Convert all dynamic sysfs attributes to static
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Matt Turner <mattst88@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Christophe Leroy <chleroy@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Dexuan Cui <decui@microsoft.com>, 
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Lukas Wunner <lukas@wunner.de>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Saurabh Singh Sengar <ssengar@microsoft.com>, Shuan He <heshuan@bytedance.com>, 
	Srivatsa Bhat <srivatsabhat@microsoft.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 10:01=E2=80=AFAM Krzysztof Wilczy=C5=84ski
<kwilczynski@kernel.org> wrote:
>
> Hello,
>
> This series converts every dynamically allocated PCI sysfs attribute to
> a static const definition.  After the full series, pci_sysfs_init() and
> sysfs_initialized are gone, and every sysfs file is created by the
> driver model at device_add() time.
>
> Currently, the PCI resource files (resourceN, resourceN_wc) and the
> legacy bus files (legacy_io, legacy_mem) are created dynamically
> from two unsynchronised paths:
>
> Path A: late_initcall
>
>   pci_sysfs_init                        (late_initcall)
>     sysfs_initialized =3D 1
>     for_each_pci_dev
>       pci_create_sysfs_dev_files
>         sysfs_create_bin_file           (resourceN, resourceN_wc)
>     pci_find_next_bus
>       pci_create_legacy_files
>         sysfs_create_bin_file           (legacy_io, legacy_mem)
>
> Path B: device registration / hotplug
>
>   pci_bus_add_devices
>     pci_bus_add_device
>       pci_create_sysfs_dev_files
>         if (!sysfs_initialized) return  <- only guard
>         sysfs_create_bin_file           (resourceN, resourceN_wc)
>
> On most ACPI systems this does not race because PCI enumeration
> completes at subsys_initcall time, before pci_sysfs_init() runs:
>
>   subsys_initcall (level 4):
>     acpi_pci_root_add
>       pci_bus_add_device
>         pci_create_sysfs_dev_files
>           if (!sysfs_initialized)          <- not yet set
>             return -EACCES
>
>   late_initcall (level 7):
>     pci_sysfs_init
>       sysfs_initialized =3D 1
>       for_each_pci_dev
>         pci_create_sysfs_dev_files         <- creates the files, no race
>
> On Devicetree platforms the host controller is a platform driver that
> probes via the driver model, often on a workqueue, and overlaps with the
> late_initcall:
>
>   CPU 0 (late_initcall)                CPU 1 (driver probe)
>   ---------------------------          ----------------------------
>   pci_sysfs_init()
>     sysfs_initialized =3D 1
>     for_each_pci_dev(pdev)             pci_bus_add_device(pdev)
>       pci_create_sysfs_dev_files()       pci_create_sysfs_dev_files()
>         sysfs_create_bin_file()            sysfs_create_bin_file()
>                                              -> "duplicate filename"
>
> The same happens on ACPI when probing is asynchronous (hv_pci on
> Azure, RISC-V with ACPI).
>
> The duplicate causes sysfs_create_bin_file() to fail with -EEXIST.
> pci_create_resource_files() then calls pci_remove_resource_files() in
> its error unwind, tearing down files the other thread created and
> still references through pdev->res_attr[].  This has caused kernel
> panics on i.MX6 and boot failures on other platforms.
>
> Several different fixes have been proposed over the years: reordering
> the sysfs_initialized assignment, adding locks, checking
> pci_dev_is_added(), setting pdev->res_attr[] to NULL after kfree
> (which only prevents a double-free on the teardown path, not the
> error unwind removing the other thread's files).  None would address the
> root cause.
>
> This has been reported a few times:
>
>   - https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@byte=
dance.com/
>   - https://lore.kernel.org/linux-pci/b51519d6-ce45-4b6d-8135-c70169bd110=
e@h-partners.com/
>   - https://lore.kernel.org/linux-pci/1702093576-30405-1-git-send-email-s=
sengar@linux.microsoft.com/
>   - https://lore.kernel.org/linux-pci/SY0P300MB04687548090B73E40AF97D8897=
B82@SY0P300MB0468.AUSP300.PROD.OUTLOOK.COM/
>   - https://lore.kernel.org/linux-pci/20230105174736.GA1154719@bhelgaas/
>   - https://lore.kernel.org/linux-pci/m3eebg9puj.fsf@t19.piap.pl/
>   - https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pal=
i/
>   - https://lore.kernel.org/linux-pci/1366196798-15929-1-git-send-email-a=
rtem.savkov@gmail.com/
>   - https://bugzilla.kernel.org/show_bug.cgi?id=3D215515
>   - https://bugzilla.kernel.org/show_bug.cgi?id=3D216888
>
> With static attributes the driver model creates sysfs entries once per
> device at device_add() time, under the device lock, eliminating the
> late_initcall iteration and the race along with it.
>
>         Krzysztof
>
> ---
> Changes in v4:
>   https://lore.kernel.org/linux-pci/20260410055040.39233-1-kwilczynski@ke=
rnel.org/
>
>    - Added new Reviewed-by tags.
>    - Added pci_resource_is_io() and pci_resource_is_mem() helpers
>      for resource type checks, replacing the open-coded bitwise
>      flag tests in pci_mmap_resource(), pci_resource_io(), and
>      Alpha's pci_mmap_resource(), as per Ilpo J=C3=A4rvinen's
>      suggestion.
>    - Split the __pci_mmap_fits() cleanup into two patches.  An
>      overflow fix for zero-length BARs, which now includes a
>      Fixes: tag referencing the original Alpha PCI sysfs commit,
>      and the WARN macro removal is a separate cleanup as per Ilpo
>      J=C3=A4rvinen's suggestion.
>    - Added a missing Fixes: tag to the Alpha lockdown check,
>      referencing the commit that added the check to the generic
>      path but missed Alpha's implementation.
>    - Added PCI_LEGACY_IO_SIZE and PCI_LEGACY_MEM_SIZE macros to
>      replace the raw literals used for legacy address space sizes.
>      These are used in both Alpha's pci_mmap_legacy_page_range()
>      and the static legacy attribute definitions, as per Ilpo
>      J=C3=A4rvinen's suggestion.
>    - Replaced sysfs_update_groups() in the BAR resize path with
>      sysfs_remove_groups() before the resize and sysfs_create_groups()
>      after, restoring the original teardown before BAR resize
>      ordering.  This was reported by Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40=
kernel.org?part=3D7
>    - Defined pci_dev_resource_attr_groups as a NULL macro when
>      HAVE_PCI_MMAP and ARCH_GENERIC_PCI_MMAP_RESOURCE are both
>      absent, so the resize path compiles unconditionally without
>      #ifdef guards in the function body.  This was reported by
>      Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40=
kernel.org?part=3D7
>    - Moved the pci_legacy_has_sparse() prototype into the patch
>      that introduces the function, alongside the existing
>      pci_adjust_legacy_attr() declaration, to fix a bisection
>      issue where Alpha would warn on -Wmissing-prototypes.
>      This was reported by Sashiko, see:
>      https://sashiko.dev/#/patchset/20260410055040.39233-1-kwilczynski%40=
kernel.org?part=3D18
>
> Changes in v3:
>   https://lore.kernel.org/linux-pci/20210910202623.2293708-1-kw@linux.com=
/
>
>   - Updated for modern kernel releases and expanded scope.  The
>     v2 only covered the generic resource files.  This version
>     also converts Alpha's sparse/dense resource files and the
>     legacy bus attributes, removing pci_sysfs_init() entirely.
>   - Split the single macro definition into three distinct ones
>     (per I/O, UC, and WC), to make sure that each carries only
>     the callbacks its resource type needs.
>   - Updated to use the new .bin_size callback, as the attributes
>     are const, to replace using a->size directly, which was not
>     ideal.  This required changes to pci_llseek_resource(), to
>     ensure that it would work for device and bus-level attributes.
>   - Updated the __resource_resize_store() to include CAP_SYS_ADMIN
>     capabilities check.
>   - Added the security_locked_down() check to Alpha's
>     pci_mmap_resource(), to align with other architectures.
>
> Changes in v2:
>   https://lore.kernel.org/linux-pci/20210825212255.878043-1-kw@linux.com/
>
>   - Refactored code so that the macros, helpers and internal
>     functions can be used to correctly leverage the read(),
>     write() and mmap() callbacks rather than to use the
>     .is_bin_visible() callback to set up sysfs objects
>     internals as this is not supported.
>   - Refactored some if-statements to check for a resource
>     flag first, and then call either arch_can_pci_mmap_io()
>     or arch_can_pci_mmap_wc(), plus store result of testing
>     for IORESOURCE_MEM and IORESOURCE_PREFETCH flags into
>     a boolean variable, as per Bjorn Helgaas' suggestion.
>   - Renamed pci_read_resource_io() and pci_write_resource_io()
>     callbacks so that these are not specifically tied to I/O
>     BARs read() and write() operations also as per Bjorn
>     Helgaas' suggestion.
>   - Updated style for code handling bitwise operations to
>     match the style that is preferred as per Bjorn Helgaas'
>     suggestion.
>   - Updated commit messages adding more details about the
>     implementation as requested by Bjorn Helgaas.
>
> Krzysztof Wilczy=C5=84ski (24):
>   PCI/sysfs: Use PCI resource accessor macros
>   PCI: Add pci_resource_is_io() and pci_resource_is_mem() helpers
>   PCI/sysfs: Only allow supported resource types in I/O and MMIO helpers
>   PCI/sysfs: Use BAR length in pci_llseek_resource() when attr->size is
>     zero
>   PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
>   PCI/sysfs: Add static PCI resource attribute macros
>   PCI/sysfs: Convert PCI resource files to static attributes
>   PCI/sysfs: Convert __resource_resize_store() to use static attributes
>   PCI/sysfs: Add stubs for pci_{create,remove}_sysfs_dev_files()
>   PCI/sysfs: Limit pci_sysfs_init() late_initcall compile scope
>   alpha/PCI: Add security_locked_down() check to pci_mmap_resource()
>   alpha/PCI: Use BAR index in sysfs attr->private instead of resource
>     pointer
>   alpha/PCI: Use PCI resource accessor macros
>   alpha/PCI: Clean up pci_mmap_resource()
>   alpha/PCI: Fix __pci_mmap_fits() overflow for zero-length BARs
>   alpha/PCI: Remove WARN from __pci_mmap_fits()
>   alpha/PCI: Add static PCI resource attribute macros
>   alpha/PCI: Convert resource files to static attributes
>   PCI/sysfs: Remove pci_{create,remove}_sysfs_dev_files()
>   PCI: Add macros for legacy I/O and memory address space sizes
>   alpha/PCI: Compute legacy size in pci_mmap_legacy_page_range()
>   PCI/sysfs: Add __weak pci_legacy_has_sparse() helper
>   PCI/sysfs: Convert legacy I/O and memory attributes to static
>     definitions
>   PCI/sysfs: Remove pci_create_legacy_files() and pci_sysfs_init()
>
>  arch/alpha/include/asm/pci.h   |  13 +-
>  arch/alpha/kernel/pci-sysfs.c  | 373 +++++++++++----------
>  arch/powerpc/include/asm/pci.h |   2 -
>  drivers/pci/bus.c              |   1 -
>  drivers/pci/pci-sysfs.c        | 575 +++++++++++++++++++--------------
>  drivers/pci/pci.h              |  16 +-
>  drivers/pci/probe.c            |   6 -
>  drivers/pci/remove.c           |   3 -
>  include/linux/pci.h            |  39 ++-
>  9 files changed, 578 insertions(+), 450 deletions(-)
>

Hi ,

Applied the series on an Alpha UP2000+, built and booted
successfully. PCI enumeration and device initialization looked
normal, I saw no relevant sysfs/PCI warnings in dmesg, and PCI
sysfs resource files for tested devices looked sane.

From the Alpha side, this looks good to me.

Tested-by: Magnus Lindholm <linmag7@gmail.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
