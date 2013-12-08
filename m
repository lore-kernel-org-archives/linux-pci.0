Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:42437 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754768Ab3LHQF2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 8 Dec 2013 11:05:28 -0500
Message-ID: <1386518724.31845.66.camel@joe-AO722>
Subject: Re: [PATCH 1/2] PCI, AER: Add a TLP header print helper
From: Joe Perches <joe@perches.com>
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lance Ortiz <lance.ortiz@hp.com>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pci@vger.kernel.org
Date: Sun, 08 Dec 2013 08:05:24 -0800
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
> 
> No functionality change.

You do change the output.
Perhaps it'd be better to pass the header prefix too.

> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
[]
> @@ -124,6 +124,21 @@ static const char *aer_agent_string[] = {

> +static void __print_tlp_header(struct pci_dev *dev,
> +			       struct aer_header_log_regs *t)
> +{
> +	unsigned char *tlp = (unsigned char *)&t;
> +
> +	dev_err(&dev->dev, "  TLP Header:"

Always indents and emits "  TLP Header:"

> @@ -250,18 +256,10 @@ void cper_print_aer(struct pci_dev *dev, int cper_severity,
>  	if (aer_severity != AER_CORRECTABLE)
>  		dev_err(&dev->dev, "aer_uncor_severity: 0x%08x\n",
>  		       aer->uncor_severity);
> -	if (tlp_header_valid) {
> -		const unsigned char *tlp;
> -		tlp = (const unsigned char *)&aer->header_log;
> -		dev_err(&dev->dev, "aer_tlp_header:"

vs removing this "aer_tlp_header:"


