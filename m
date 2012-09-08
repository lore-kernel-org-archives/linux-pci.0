Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51971 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750Ab2IHU7y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Sep 2012 16:59:54 -0400
Received: by lbbgj3 with SMTP id gj3so488818lbb.19
        for <linux-pci@vger.kernel.org>; Sat, 08 Sep 2012 13:59:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120908122717.GA24182@localhost>
References: <20120908122717.GA24182@localhost>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 8 Sep 2012 14:59:32 -0600
Message-ID: <CAErSpo4xE=nfPFUAVGF5mDfY7tDpzbztFXb=aCmgC2OgMCkRQQ@mail.gmail.com>
Subject: Re: [pci:next 76/77] WARNING: vmlinux.o(.text+0x17fdfe): Section
 mismatch in reference from the function pcibios_add_device() to the variable .init.data:boot_params
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks, I dropped pci/mjg-pci-roms-from-efi from my "next" branch for now.

On Sat, Sep 8, 2012 at 6:27 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> Hi Matthew,
>
> FYI, there are new compile warnings show up in
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> head:   97ac9d1f363964dec7fbb20cf3c2e88336b4d801
> commit: 86153d6c3a2ad02b89e10346b116e9ab2a81f1a7 [76/77] x86: Use PCI setup data
> config: i386-randconfig-m021 (attached as .config)
>
> All error/warnings:
>
>
> WARNING: vmlinux.o(.text+0x17fdfe): Section mismatch in reference from the function pcibios_add_device() to the variable .init.data:boot_params
> The function pcibios_add_device() references
> the variable __initdata boot_params.
> This is often because pcibios_add_device lacks a __initdata
> annotation or the annotation of boot_params is wrong.
>
> ---
> 0-DAY kernel build testing backend         Open Source Technology Centre
> Fengguang Wu <wfg@linux.intel.com>                     Intel Corporation
