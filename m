Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1370542987.2209.18.camel@joe-AO722>
Subject: Re: [PATCH v2 4/6] PCI/ACPI: Move AER severity defines to aer.h
From: Joe Perches <joe@perches.com>
To: Betty Dall <betty.dall@hp.com>
Cc: rjw@sisk.pl, bhelgaas@google.com, gong.chen@linux.intel.com,
	greg.pearson@hp.com, ying.huang@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Date: Thu, 06 Jun 2013 11:23:07 -0700
In-Reply-To: <1370542251-27387-5-git-send-email-betty.dall@hp.com>
References: <1370542251-27387-1-git-send-email-betty.dall@hp.com>
	 <1370542251-27387-5-git-send-email-betty.dall@hp.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-06-06 at 12:10 -0600, Betty Dall wrote:
> The function aer_recover_queue() is a public interface and the
> severity argument uses #defines that are in the private header
> pci/pcie/aer/aerdrv.h.
> 
> This patch moves the #defines from pci/pcie/aer/aerdrv.h to 
> include/linux/aer.h.
[]
> diff --git a/include/linux/aer.h b/include/linux/aer.h
[]
> -extern void cper_print_aer(const char *prefix, struct pci_dev *dev,
> +void cper_print_aer(const char *prefix, struct pci_dev *dev,
>  			   int cper_severity, struct aer_capability_regs *aer);

Can you please also realign the arguments on subsequent
lines to the open parenthesis of the first line and reflow
then to 80 cols when appropriate?

> -extern void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
> +void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>  			      int severity);


