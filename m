Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:39728 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755558Ab3LHU7l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2013 15:59:41 -0500
Message-ID: <1386536377.31845.77.camel@joe-AO722>
Subject: Re: [PATCH 1/2] PCI, AER: Add a TLP header print helper
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lance Ortiz <lance.ortiz@hp.com>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pci@vger.kernel.org
Date: Sun, 08 Dec 2013 12:59:37 -0800
In-Reply-To: <1386515571-23252-1-git-send-email-bp@alien8.de>
References: <1386515571-23252-1-git-send-email-bp@alien8.de>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2013-12-08 at 16:12 +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... and call it instead of duplicating the large printk format
> statement.
[]
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
[]
> @@ -124,6 +124,21 @@ static const char *aer_agent_string[] = {

> +static void __print_tlp_header(struct pci_dev *dev,
> +			       struct aer_header_log_regs *t)
> +{
> +	unsigned char *tlp = (unsigned char *)&t;
> +
> +	dev_err(&dev->dev, "  TLP Header:"
> +		" %02x%02x%02x%02x %02x%02x%02x%02x"
> +		" %02x%02x%02x%02x %02x%02x%02x%02x\n",
> +		*(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
> +		*(tlp + 7), *(tlp + 6), *(tlp + 5), *(tlp + 4),
> +		*(tlp + 11), *(tlp + 10), *(tlp + 9),
> +		*(tlp + 8), *(tlp + 15), *(tlp + 14),
> +		*(tlp + 13), *(tlp + 12));
> +}

Hey again Borislav:

Come to think of it, given this struct:

include/linux/aer.h:struct aer_header_log_regs {
include/linux/aer.h-    unsigned int dw0;
include/linux/aer.h-    unsigned int dw1;
include/linux/aer.h-    unsigned int dw2;
include/linux/aer.h-    unsigned int dw3;
include/linux/aer.h-};

this would be a lot more readable as:

static void __print_tlp_header(struct pci_dev *dev,
			       struct aer_header_log_regs *t)
{
	dev_err(&dev->dev, "  TLP Header: %08x %08x %08x %08x\n",
		tlp->dw0, tlp->dw1, tlp->dw2, tlp->dw3);
}

though if the desire really is to show le output,
maybe these should use:

	dev_err(&dev->dev, "  TLP Header: %08x %08x %08x %08x\n",
		cpu_to_le32(tlp->dw0), cpu_to_le32(tlp->dw1),
		cpu_to_le32(tlp->dw2), cpu_to_le32(tlp->dw3));


