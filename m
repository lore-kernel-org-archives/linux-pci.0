Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:46476 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbbCFSdy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 13:33:54 -0500
Received: by obcva2 with SMTP id va2so3792213obc.13
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2015 10:33:53 -0800 (PST)
Date: Fri, 6 Mar 2015 12:33:51 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Avoid info leak in __print_tlp_header
Message-ID: <20150306183351.GG20077@google.com>
References: <20150225225859.GB19236@pd.tnic>
 <1424940903-9147-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424940903-9147-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 26, 2015 at 09:55:03AM +0100, Rasmus Villemoes wrote:
> Commit fab4c256a58b ("PCI/AER: Add a TLP header print helper")
> introduced the helper function __print_tlp_header, but contrary to the
> intention, the behaviour did change: Since we're taking the address of
> the parameter t, the first 4 or 8 bytes printed will be the value of
> the pointer t itself, and the remaining 12 or 8 bytes will be
> who-knows-what (something from the stack).
> 
> We want to show the values of the four members of the struct
> aer_header_log_regs; that can be done without ugly and error-prone
> casts. On little-endian this should produce the same output as
> originally intended, and since no-one has complained about getting
> garbage output so far, I think big-endian should be ok too.
> 
> Fixes: fab4c256a58b ("PCI/AER: Add a TLP header print helper")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied with Borislav's ack to for-linus for v4.0, thanks!  Also added
stable tag.

> ---
> v2: Just print ->dwX as-is.
> 
>  drivers/pci/pcie/aer/aerdrv_errprint.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index c6849d9e86ce..167fe411ce2e 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -132,16 +132,8 @@ static const char *aer_agent_string[] = {
>  static void __print_tlp_header(struct pci_dev *dev,
>  			       struct aer_header_log_regs *t)
>  {
> -	unsigned char *tlp = (unsigned char *)&t;
> -
> -	dev_err(&dev->dev, "  TLP Header:"
> -		" %02x%02x%02x%02x %02x%02x%02x%02x"
> -		" %02x%02x%02x%02x %02x%02x%02x%02x\n",
> -		*(tlp + 3), *(tlp + 2), *(tlp + 1), *tlp,
> -		*(tlp + 7), *(tlp + 6), *(tlp + 5), *(tlp + 4),
> -		*(tlp + 11), *(tlp + 10), *(tlp + 9),
> -		*(tlp + 8), *(tlp + 15), *(tlp + 14),
> -		*(tlp + 13), *(tlp + 12));
> +	dev_err(&dev->dev, "  TLP Header: %08x %08x %08x %08x\n",
> +		t->dw0, t->dw1, t->dw2, t->dw3);
>  }
>  
>  static void __aer_print_error(struct pci_dev *dev,
> -- 
> 2.1.3
> 
