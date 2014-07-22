Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56519 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaGVEvI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Jul 2014 00:51:08 -0400
Message-ID: <53CDEDBA.4070509@infradead.org>
Date: Mon, 21 Jul 2014 21:51:06 -0700
From: Randy Dunlap <rdunlap@infradead.org>
MIME-Version: 1.0
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
CC: bhelgaas@google.com, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] Fix build warnings in aer.h
References: <1405498124-11519-1-git-send-email-qiudayu@linux.vnet.ibm.com>
In-Reply-To: <1405498124-11519-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/16/2014 01:08 AM, Mike Qiu wrote:
> build log:
> 

When CONFIG_PCIEAER is not enabled:

> In file included from include/ras/ras_event.h:11:0,
>                  from drivers/ras/ras.c:13:
> include/linux/aer.h:42:129: warning: ‘struct pci_dev’
> declared inside parameter list [enabled by default]
> 
> include/linux/aer.h:42:129: warning: its scope is only
> this definition or declaration, which is probably not
> what you want [enabled by default]
> 
> include/linux/aer.h:46:130: warning: ‘struct pci_dev’
> declared inside parameter list [enabled by default]
> 
> include/linux/aer.h:50:136: warning: ‘struct pci_dev’
> declared inside parameter list [enabled by default]
> 
> include/linux/aer.h:57:14: warning: ‘struct pci_dev’
> declared inside parameter list [enabled by default]
> 
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  include/linux/aer.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4dbaa70..c826d1c 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -11,6 +11,8 @@
>  #define AER_FATAL			1
>  #define AER_CORRECTABLE			2
>  
> +struct pci_dev;
> +
>  struct aer_header_log_regs {
>  	unsigned int dw0;
>  	unsigned int dw1;
> 


-- 
~Randy
