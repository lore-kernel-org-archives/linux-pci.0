Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58662 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785AbcBBUEf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Feb 2016 15:04:35 -0500
Date: Tue, 2 Feb 2016 14:04:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] Synopsys driver updated in Maintainers
Message-ID: <20160202200431.GA11954@localhost>
References: <eb5a3237d868dba88c0bdbe3862e14890b4adf05.1454434674.git.jpinto@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eb5a3237d868dba88c0bdbe3862e14890b4adf05.1454434674.git.jpinto@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 02, 2016 at 05:39:16PM +0000, Joao Pinto wrote:
> Driver name changed but not updated in MAINTAINERS.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d2e4506..caba688 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8234,8 +8234,8 @@ PCI DRIVER FOR SYNOPSYS PROTOTYPING DEVICE
>  M:	Joao Pinto <jpinto@synopsys.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
> -F:	drivers/pci/host/pcie-snpsdev.c
> +F:	Documentation/devicetree/bindings/pci/pcie-synopsys.txt
> +F:	drivers/pci/host/pcie-synopsys.c
>  
>  PCMCIA SUBSYSTEM
>  P:	Linux PCMCIA Team

I folded this fix into the original commit, thanks!

Bjorn
