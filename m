Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45923 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaA2U5H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 15:57:07 -0500
Received: by mail-ie0-f175.google.com with SMTP id ar20so2543350iec.6
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 12:57:06 -0800 (PST)
Date: Wed, 29 Jan 2014 13:56:58 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] PCI: msi: properly free memory on an error path
Message-ID: <20140129205658.GB16825@google.com>
References: <20140123184246.GA7461@google.com>
 <20140123193037.GA2605@kroah.com>
 <20140123200112.GA15503@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140123200112.GA15503@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 23, 2014 at 12:01:12PM -0800, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Coverity reported that I forgot to clean up some allocated memory on the
> error path in populate_msi_sysfs(), so this patch fixes that.
> 
> Thanks to Dave Jones for pointing out where the error was, I obviously
> can't read code this morning...
> 
> Fixes: 1c51b50c2995 ("PCI/MSI: Export MSI mode using attributes, not kobjects")
> Cc: Dave Jones <davej@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to my pci/msi branch, thanks!

> ---
>  drivers/pci/msi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 39dff3fe57af..6f0474ebe420 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -595,6 +595,7 @@ error_attrs:
>  		++count;
>  		msi_attr = msi_attrs[count];
>  	}
> +	kfree(msi_attrs);
>  	return ret;
>  }
>  
> -- 
> 1.8.5.1.163.gd7aced9
> 
