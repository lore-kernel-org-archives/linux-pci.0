Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969556AbeCSTsR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Mar 2018 15:48:17 -0400
Date: Mon, 19 Mar 2018 14:48:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Benedikt Spranger <b.spranger@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Otavio Pontes <otavio.pontes@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 0/7] jailhouse: Enhance secondary Jailhouse guest
 support /wrt PCI
Message-ID: <20180319194813.GJ77194@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1520408357.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1520408357.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 07, 2018 at 08:39:11AM +0100, Jan Kiszka wrote:
> Basic x86 support [1] for running Linux as secondary Jailhouse [2] guest
> is currently pending in the tip tree. This builds on top and enhances
> the PCI support for x86 and also ARM guests (ARM[64] does not require
> platform patches and works already).
> ...

Hi Jan,

What tree do you plan to merge this through?  I was sort of assuming
x86, since the main point of jailhouse is not PCI, but I do notice
most of the changes here are PCI-related, so thought I should make
sure you're not waiting on me.

> Jan Kiszka (6):
>   jailhouse: Provide detection for non-x86 systems
>   PCI: Scan all functions when running over Jailhouse
>   x86: Align x86_64 PCI_MMCONFIG with 32-bit variant
>   x86: Consolidate PCI_MMCONFIG configs
>   x86/jailhouse: Allow to use PCI_MMCONFIG without ACPI
>   MAINTAINERS: Add entry for Jailhouse
> 
> Otavio Pontes (1):
>   x86/jailhouse: Enable PCI mmconfig access in inmates
> 
>  Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
>  MAINTAINERS                                     |  7 +++++++
>  arch/x86/Kconfig                                | 12 +++++++-----
>  arch/x86/include/asm/jailhouse_para.h           |  2 +-
>  arch/x86/include/asm/pci_x86.h                  |  2 ++
>  arch/x86/kernel/Makefile                        |  2 +-
>  arch/x86/kernel/cpu/amd.c                       |  2 +-
>  arch/x86/kernel/jailhouse.c                     |  8 ++++++++
>  arch/x86/pci/legacy.c                           |  4 +++-
>  arch/x86/pci/mmconfig-shared.c                  |  4 ++--
>  drivers/pci/probe.c                             | 22 +++++++++++++++++++---
>  include/linux/hypervisor.h                      | 17 +++++++++++++++--
>  12 files changed, 74 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/jailhouse.txt
> 
> -- 
> 2.13.6
> 
