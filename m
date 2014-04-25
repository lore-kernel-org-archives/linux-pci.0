Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64328 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbaDYRCj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 13:02:39 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so3327732pdj.22
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2014 10:02:38 -0700 (PDT)
Date: Fri, 25 Apr 2014 11:02:34 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Coverity CIDs 138749, 138750: cnb20le_res() unintended sign
 extension
Message-ID: <20140425170234.GB32246@google.com>
References: <CAErSpo7uQtRXcxC-9oAS8PJ6Vi3H8Z1fVB2wQR-uxGjyoLDkCQ@mail.gmail.com>
 <20140404154023.GA5367@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140404154023.GA5367@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 04, 2014 at 09:40:23AM -0600, Bjorn Helgaas wrote:
> On Thu, Apr 03, 2014 at 02:56:26PM -0600, Bjorn Helgaas wrote:
> > Coverity complains about unintended sign extension in cnb20le_res() in
> > arch/x86/pci/broadcom_bus.c here:
> > 
> > 60        word1 = read_pci_config_16(bus, slot, func, 0xc4);
> >  61        word2 = read_pci_config_16(bus, slot, func, 0xc6);
> >  62        if (word1 != word2) {
> > 
> > CID 138749 (#1 of 2): Unintended sign extension (SIGN_EXTENSION)
> > sign_extension: Suspicious implicit sign extension: word1 with type
> > unsigned short (16 bits, unsigned) is promoted in (word1 << 16) | 0 to
> > type int (32 bits, signed), then sign-extended to type unsigned long
> > long (64 bits, unsigned). If (word1 << 16) | 0 is greater than
> > 0x7FFFFFFF, the upper bits of the result will all be 1.
> >  63                res.start = (word1 << 16) | 0x0000;
> >     CID 138750: Unintended sign extension (SIGN_EXTENSION) [select issue]
> 
> I propose the following patch for this.  Unless there's objection, I'll
> queue this for v3.16.
> 
> 
> x86/PCI: Fix Broadcom CNB20LE unintended sign extension
> 
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> In the expression "word1 << 16", word1 starts as u16, but is promoted to
> a signed int, then sign-extended to resource_size_t, which is probably
> not what was intended.  Cast to resource_size_t to avoid the sign
> extension.
> 
> Found by Coverity (CID 138749, 138750).
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this to pci/resource for v3.16.

> ---
>  arch/x86/pci/broadcom_bus.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/broadcom_bus.c b/arch/x86/pci/broadcom_bus.c
> index 614392ced7d6..bb461cfd01ab 100644
> --- a/arch/x86/pci/broadcom_bus.c
> +++ b/arch/x86/pci/broadcom_bus.c
> @@ -60,8 +60,8 @@ static void __init cnb20le_res(u8 bus, u8 slot, u8 func)
>  	word1 = read_pci_config_16(bus, slot, func, 0xc4);
>  	word2 = read_pci_config_16(bus, slot, func, 0xc6);
>  	if (word1 != word2) {
> -		res.start = (word1 << 16) | 0x0000;
> -		res.end   = (word2 << 16) | 0xffff;
> +		res.start = ((resource_size_t) word1 << 16) | 0x0000;
> +		res.end   = ((resource_size_t) word2 << 16) | 0xffff;
>  		res.flags = IORESOURCE_MEM | IORESOURCE_PREFETCH;
>  		update_res(info, res.start, res.end, res.flags, 0);
>  	}
