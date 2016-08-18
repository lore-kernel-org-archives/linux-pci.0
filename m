Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754190AbcHSBGO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:06:14 -0400
Date: Thu, 18 Aug 2016 17:38:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Zhang <wzhang@fb.com>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 1/3] pcie: Don't search capabilities on removed devices
Message-ID: <20160818223806.GS27353@localhost>
References: <1470683667-28418-1-git-send-email-keith.busch@intel.com>
 <1470683667-28418-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470683667-28418-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Mon, Aug 08, 2016 at 01:14:25PM -0600, Keith Busch wrote:
> This patch returns immediately if trying to find a pcie capability
> on a removed device, as seen with an all 1's completion from config
> read. Previously this function would iterate the maximum 480 times to
> search for a capability at position 0xffc. There is never a case where
> we'd expect all 1's to a successful config read on a capability register,
> so this is a safe criteria to check before bailing on the device.

I'm nothing if not pedantic, so I think we're talking about reading
PCIe Extended Capability Headers (PCIe r3.0, sec 7.9.3), and I don't
think the spec 100% guarantees that the following is invalid:

  PCIe Extended Capability ID == 0xffff
  Capability Version == 0xf
  Next Capability Offset = 0xfff

It's true that capabilities must be DWORD aligned and the low two bits
of the Next Capability Offset are currently reserved and must be
implemented as 00b, which is not quite the same as saying they will
*always* be zero for all devices, because the spec does explicitly
allow for future uses.

I don't see that Capability ID 0xffff is actually reserved, but sec
7.9.2 does hint at that for capabilities in a RCRB.

So I guess I agree that a 0xffffffff value is unlikely enough that we
can consider it invalid :)

> While accessing a removed device shouldn't be fatal, it's doesn't
> accomplish anything. Instead, the code was testing completion synthesis
> capabilities which is observed to cause distruption to normal operations.

I didn't quite parse this last sentence.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aab9d51..e884608 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -331,7 +331,7 @@ int pci_find_next_ext_capability(struct pci_dev *dev, int start, int cap)
>  	if (header == 0)
>  		return 0;
>  
> -	while (ttl-- > 0) {
> +	while (ttl-- > 0 && header != -1) {

I would prefer to do this check right after the
pci_read_config_dword() instead of putting it in the loop control, and
I'd write the "-1" as 0xffffffff.  That way it's more obviously an
error condition.

I know that means duplicating the check, which is sort of a bummer.
Wonder if it's possible to restructure the loop so we only need one
pci_read_config_dword() call?

I'm not sure "ttl" is the most natural way of controlling the loop.
The spec merely requires these headers to be at offsets between
0x100 and 0xffc (or maybe even 0xff8 if capabilities must have data).

>  		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
>  			return pos;
>  
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
