Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40320 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbaIVUnZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 16:43:25 -0400
Received: by mail-ie0-f174.google.com with SMTP id rd18so2961499iec.19
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2014 13:43:24 -0700 (PDT)
Date: Mon, 22 Sep 2014 14:43:22 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] PCI: mvebu: Fix uninitialized variable in
 mvebu_get_tgt_attr()
Message-ID: <20140922204322.GG1880@google.com>
References: <1410969507-13692-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410969507-13692-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 17, 2014 at 05:58:27PM +0200, Thomas Petazzoni wrote:
> Geert Uytterhoeven reported a warning when building pci-mvebu:
> 
> drivers/pci/host/pci-mvebu.c: In function 'mvebu_get_tgt_attr':
> drivers/pci/host/pci-mvebu.c:887:39: warning: 'rtype' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (slot == PCI_SLOT(devfn) && type == rtype) {
>                                        ^
> 
> And indeed, the code of mvebu_get_tgt_attr() may lead to the usage of
> rtype when being uninitialized, even though it would only happen if we
> had entries other than I/O space and 32 bits memory space.
> 
> This commit fixes that by simply skipping the current DT range being
> considered, if it doesn't match the resource type we're looking for.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This patch is a different solution than the one proposed by Geert. It
> (hopefully) matches the discussion we had with Bjorn and Arnd.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to pci/host-mvebu for v3.18, thanks!  Oh, and I added a stable tag
for v3.12+, since mvebu_get_tgt_attr() appeared in v3.12.

> ---
>  drivers/pci/host/pci-mvebu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index a8c6f1a..b1315e1 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -873,7 +873,7 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>  	rangesz = pna + na + ns;
>  	nranges = rlen / sizeof(__be32) / rangesz;
>  
> -	for (i = 0; i < nranges; i++) {
> +	for (i = 0; i < nranges; i++, range += rangesz) {
>  		u32 flags = of_read_number(range, 1);
>  		u32 slot = of_read_number(range + 1, 1);
>  		u64 cpuaddr = of_read_number(range + na, pna);
> @@ -883,14 +883,14 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>  			rtype = IORESOURCE_IO;
>  		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
>  			rtype = IORESOURCE_MEM;
> +		else
> +			continue;
>  
>  		if (slot == PCI_SLOT(devfn) && type == rtype) {
>  			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
>  			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
>  			return 0;
>  		}
> -
> -		range += rangesz;
>  	}
>  
>  	return -ENOENT;
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
