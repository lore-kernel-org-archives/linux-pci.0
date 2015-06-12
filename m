Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1434098643.2271.141.camel@x220>
Subject: Re: [PATCH 6/6] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
From: Paul Bolle <pebolle@tiscali.nl>
To: jakeo@microsoft.com
Cc: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	mebersol@microsoft.com, haiyangz@microsoft.com
Date: Fri, 12 Jun 2015 10:44:03 +0200
In-Reply-To: <1434039747-44535-7-git-send-email-jakeo@microsoft.com>
References: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
	 <1434039747-44535-7-git-send-email-jakeo@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Greg has already asked you to resend. So here follow a few remarks to
take into account for that resend.

On Thu, 2015-06-11 at 16:22 +0000, jakeo@microsoft.com wrote:

> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
 
> +config HYPERV_VPCI
> +        tristate "Hyper-V PCI Frontend"
> +        depends on PCI && X86 && HYPERV
> +        select PCI_HV

That symbol doesn't exist and is not added in this series, right? If so,
scripts/checkkconsymbols.py could have told you that.

> +        default y

Are you sure?

> +        help
> +          The PCI device frontend driver allows the kernel to import arbitrary
> +          PCI devices from a PCI backend to support PCI driver domains.

> --- /dev/null
> +++ b/drivers/pci/host/hv_pcifront.c

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more

This states the license is GPL v2.

> +EXPORT_SYMBOL(hv_read_config_block);

> +EXPORT_SYMBOL(hv_write_config_block);

> +EXPORT_SYMBOL(hv_register_block_invalidate);

I couldn't spot any users of these exports. Actually, I couldn't even
spot any users of these three functions. Why were they added?

> +MODULE_LICENSE("GPL");

This states, according to include/linux/module.h, that the license is
GPL v2 or later. So I think either the comment at the top of this file
or the ident used in the MODULE_LICENSE() macro needs to change.

Thanks,


Paul Bolle

