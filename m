Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:61902 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbaDYRVu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 13:21:50 -0400
Received: by mail-pa0-f51.google.com with SMTP id fb1so2742981pad.24
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2014 10:21:50 -0700 (PDT)
Date: Fri, 25 Apr 2014 11:21:45 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Dave Airlie <airlied@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Coverity CID 142811: pci_set_vga_state() operands don't affect
 result
Message-ID: <20140425172145.GC32246@google.com>
References: <CAErSpo6JNDFiV6tmDKKDdnod+skBHx6T-+JGvjCRRLsL98h_uQ@mail.gmail.com>
 <20140404154744.GA8549@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140404154744.GA8549@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 04, 2014 at 09:47:44AM -0600, Bjorn Helgaas wrote:
> On Thu, Apr 03, 2014 at 02:43:05PM -0600, Bjorn Helgaas wrote:
> > Coverity complains about this in drivers/pci/pci.c:
> > 
> > CID 142811 (#1 of 1): Operands don't affect result (CONSTANT_EXPRESSION_RESULT)
> > result_independent_of_operands: flags & (2U /* 1 << 1 */) &
> > (command_bits & 4294967292U /* ~(1 | 2) */) is always 0 regardless of
> > the values of its operands. This occurs as the logical operand of if.
> > 
> > 4128        WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) &
> > (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
> > 
> > This is a result of 3448a19da479 "vgaarb: use bridges to control VGA
> > routing where possible."
> > 
> > I wonder if that middle "&" was intended to be "&&"?
> 
> I propose the following patch for this.  Unless there's objection, I'll
> queue this for v3.16.  I took the liberty of interpreting your email
> responses as acks.
> 
> 
> PCI: Fix incorrect vgaarb conditional in WARN_ON()
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 3448a19da479 "vgaarb: use bridges to control VGA routing where possible"
> added the "flags & PCI_VGA_STATE_CHANGE_DECODES" condition to an existing
> WARN_ON(), but used bitwise AND (&) instead of logical AND (&&), so the
> condition is never true.  Replace with logical AND.
> 
> Found by Coverity (CID 142811).
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Yinghai Lu <yinghai@kernel.org>
> Acked-by: David Airlie <airlied@redhat.com>

I applied this to pci/misc for v3.16.

I didn't mark it for stable because the only effect of backporting it would
be to cause warnings in some new cases, without actually fixing any
problems.

> ---
>  drivers/pci/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7325d43bf030..39012831867e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4125,7 +4125,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	u16 cmd;
>  	int rc;
>  
> -	WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) & (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
> +	WARN_ON((flags & PCI_VGA_STATE_CHANGE_DECODES) && (command_bits & ~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY)));
>  
>  	/* ARCH specific VGA enables */
>  	rc = pci_set_vga_state_arch(dev, decode, command_bits, flags);
