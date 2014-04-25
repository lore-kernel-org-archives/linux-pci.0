Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:32935 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaDYS0t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Apr 2014 14:26:49 -0400
Received: by mail-pb0-f44.google.com with SMTP id jt11so1764421pbb.17
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2014 11:26:49 -0700 (PDT)
Date: Fri, 25 Apr 2014 12:26:45 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Update my email address
Message-ID: <20140425182645.GJ32246@google.com>
References: <1398184077.7767.27.camel@deadeye.wl.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398184077.7767.27.camel@deadeye.wl.decadent.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 22, 2014 at 05:27:57PM +0100, Ben Hutchings wrote:
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied to pci/misc.  I cherry-picked it to for-linus, so I'll include it
if/when I have other updates for v3.15.

> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index a3c5a66..88cdd02 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -117,7 +117,7 @@ Description:
>  
>  What:		/sys/bus/pci/devices/.../vpd
>  Date:		February 2008
> -Contact:	Ben Hutchings <bhutchings@solarflare.com>
> +Contact:	Ben Hutchings <bwh@kernel.org>
>  Description:
>  		A file named vpd in a device directory will be a
>  		binary file containing the Vital Product Data for the
> 
> -- 
> Ben Hutchings
> Beware of programmers who carry screwdrivers. - Leonard Brandwein


