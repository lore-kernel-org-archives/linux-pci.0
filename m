Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:59873 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756059Ab1LCNgS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Dec 2011 08:36:18 -0500
Date: Sat, 3 Dec 2011 13:36:10 +0000
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: James Bottomley <jbottomley@parallels.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci: fix ats compile failure
Message-ID: <20111203133610.48610122@jbarnes-x220>
In-Reply-To: <1322594422.11875.47.camel@dabdike.int.hansenpartnership.com>
References: <1322594422.11875.47.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 29 Nov 2011 19:20:23 +0000
James Bottomley <jbottomley@parallels.com> wrote:

> I get this compile failure on parisc:
> 
> drivers/pci/ats.c: In function 'ats_alloc_one':
> drivers/pci/ats.c:29: error: implicit declaration of function
> 'kzalloc' drivers/pci/ats.c:29: warning: assignment makes pointer
> from integer without a cast drivers/pci/ats.c: In function
> 'ats_free_one': drivers/pci/ats.c:45: error: implicit declaration of
> function 'kfree'
> 
> Because ats.c is missing linux/slab.h as an include.  This patch
> fixes it
> 
> Signed-off-by: James Bottomley <JBottomley@Parallels.com>
> 
> ---
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 7ec56fb..b0dd08e 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/pci-ats.h>
>  #include <linux/pci.h>
> +#include <linux/slab.h>
>  
>  #include "pci.h"

Thanks James, I'll queue it up.

Jesse
