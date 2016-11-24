Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 24 Nov 2016 10:06:13 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Singleton <davsingl@cisco.com>
cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Steve Shih <sshih@cisco.com>,
        xe-kernel@external.cisco.com, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] pcie: aer: aerdrv: PCIe AER workaround and handling for
 ASR1K platforms.
In-Reply-To: <20161124041904.17393-1-davsingl@cisco.com>
Message-ID: <alpine.DEB.2.20.1611240951150.3434@nanos>
References: <20161124041904.17393-1-davsingl@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 23 Nov 2016, David Singleton wrote:
> --- /dev/null
> +++ b/arch/x86/platform/asr1k/asr1k_aer.c
> @@ -0,0 +1,165 @@
> +/*
> + * Cisco ASR1K platform PCIe AER support

Please move this into drivers/platform/x86/asrik/ or into a proper space in
drivers/pci/

This is pure driver space and has nothing architecture platform specific in
it.

Please sort the proper location out with Bjorn (PCI) and Darren (platform/x86)

> + *
> + * Copyright (c) 2015 by cisco Systems, Inc.
> + */
> +
> +#include <linux/pci.h>
> +#include <../../../drivers/pci/pcie/aer/aerdrv.h>

WTF?

If you need to share a header file between files in different directories,
what's wrong with moving the file to a proper place in include/* ?

Lack of taste and laziness are the only reasons I can come up with,

Thanks,

	tglx


