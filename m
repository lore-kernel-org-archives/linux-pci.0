Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42707 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab2GaW2h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2012 18:28:37 -0400
Received: by yhmm54 with SMTP id m54so6672693yhm.19
        for <linux-pci@vger.kernel.org>; Tue, 31 Jul 2012 15:28:36 -0700 (PDT)
Date: Tue, 31 Jul 2012 15:28:32 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jon Mason <jon.mason@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC v2 2/2] net: Add support for NTB virtual ethernet device
Message-ID: <20120731222832.GC19134@kroah.com>
References: <1343607994-32415-1-git-send-email-jon.mason@intel.com>
 <1343607994-32415-3-git-send-email-jon.mason@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343607994-32415-3-git-send-email-jon.mason@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 29, 2012 at 05:26:34PM -0700, Jon Mason wrote:
> A virtual ethernet device that uses the NTB transport API to send/receive data.
> 
> Signed-off-by: Jon Mason <jon.mason@intel.com>
> ---
>  drivers/net/Kconfig      |    4 +
>  drivers/net/Makefile     |    1 +
>  drivers/net/ntb_netdev.c |  417 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 422 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/ntb_netdev.c
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 0c2bd80..9bf8a71 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -178,6 +178,10 @@ config NETPOLL_TRAP
>  config NET_POLL_CONTROLLER
>  	def_bool NETPOLL
>  
> +config NTB_NETDEV
> +	tristate "Virtual Ethernet over NTB"
> +	depends on NTB

How will this module be auto-loaded by a distro?  You need some way to
detect this device on the "bus" right?  What is that method?  And why
isn't it hooked up to the "traditional" method the kernel uses to
determine this?

Don't expect distros to just always load this module, that's not going
to work, sorry.

greg k-h
