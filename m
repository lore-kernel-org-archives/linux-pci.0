Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1451236894.1098.5.camel@perches.com>
Subject: Re: [PATCH] drivers:pci Fix all whitespace issues
From: Joe Perches <joe@perches.com>
To: Bogicevic Sasa <brutallesale@gmail.com>, bhelgaas@google.com
Cc: Richard.Zhu@freescale.com, l.stach@pengutronix.de,
	rjw@rjwysocki.net, lenb@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Date: Sun, 27 Dec 2015 09:21:34 -0800
In-Reply-To: <1451234408-42250-1-git-send-email-brutallesale@gmail.com>
References: <1451234408-42250-1-git-send-email-brutallesale@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2015-12-27 at 08:40 -0800, Bogicevic Sasa wrote:
> This patch fixes all whitespace issues( missing or needed whitespace) in
> all files in drivers/pci folder. Code is compiled with allyesconfig
> before and after code changes and objects are recorded and checked with
> objdiff and they are not changed after this commit.
[]
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
[]
> @@ -25,9 +25,9 @@ DEFINE_RAW_SPINLOCK(pci_lock);
>  #define PCI_word_BAD (pos & 1)
>  #define PCI_dword_BAD (pos & 3)
>  
> -#define PCI_OP_READ(size,type,len) \
> +#define PCI_OP_READ(size, type, len) \
>  int pci_bus_read_config_##size \
> -	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
> +	(struct pci_bus *bus, unsigned int devfn, int pos, type * value)	\
>  {									\
>  	int res;							\
>  	unsigned long flags;						\
> @@ -40,7 +40,7 @@ int pci_bus_read_config_##size \
>  	return res;							\
>  }

When the first entry I look at is improper, I wonder
about the rest.

Was this done with checkpatch --types=spacing --fix ?

If so, because checkpatch is brainless, you need to
visually verify each change.

This "type" use is a macro argument indicating
what actual c90 type is being used in a function.

The original code is nominally correct, but checkpatch
doesn't know that "type" is not a variable.
