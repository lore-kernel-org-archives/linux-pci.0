Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:46088 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbaGaQkQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jul 2014 12:40:16 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Thu, 31 Jul 2014 22:10:13 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 679ACE0CBC
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2014 14:20:05 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s6V8mWXX9240666
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2014 14:18:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s6V8mBsn028862
	for <linux-pci@vger.kernel.org>; Thu, 31 Jul 2014 14:18:11 +0530
Date: Thu, 31 Jul 2014 16:48:06 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Reset failed bridge resources in PCI realloc
Message-ID: <20140731084806.GA3433@yanx>
References: <1406707207-13152-1-git-send-email-yan@linux.vnet.ibm.com>
 <CAE9FiQVkGcqFQ7e22Ekg7t-gWrQ9FdtadbVCASTGqU20FPE50g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVkGcqFQ7e22Ekg7t-gWrQ9FdtadbVCASTGqU20FPE50g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 30, 2014 at 12:59:35PM -0700, Yinghai Lu wrote:
> On Wed, Jul 30, 2014 at 1:00 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> >         * However, in pbus_size_mem() we call calculate_memsize() to
> >           calculate the final size. calculate_memsize() never shrinks
> >           window, i.e. if old size is larger than newly sized result,
> >           old size will be honored. Unfortunately, the old size at this
> >           time is the sum of both normal BARs and SR-IOV BARs when doing
> >           realloc.
> >
> 
> that checking about old_size is added by:
> 
> | commit d65245c3297ac63abc51a976d92f45f2195d2854
> | Author: Yinghai Lu <yinghai@kernel.org>
> | Date:   Fri Jan 22 01:02:23 2010 -0800
> |
> |    PCI: don't shrink bridge resources
> |
> |    When clearing leaf bridge resources, trying to get a big enough one, we
> |    could shrink the bridge if there is no resource under it.  Confirm
> |    against the old resource side to make sure we're increasing the
> |    allocation.
> 
> so to make both cases ok, may need to check if there is any children devices
> on the dev->subordinate. Please check attached.
> 

Works well on one of the machines. Thanks.

Guo Chao

> Thanks
> 
> Yinghai
> 
> 
> ---
>  drivers/pci/setup-bus.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -1622,8 +1622,11 @@ again:
>          res->start = fail_res->start;
>          res->end = fail_res->end;
>          res->flags = fail_res->flags;
> -        if (fail_res->dev->subordinate)
> +        if (fail_res->dev->subordinate) {
>              res->flags = 0;
> +            if (!list_empty(&fail_res->dev->subordinate->devices))
> +                res->start = res->end = 0;
> +        }
>      }
>      free_list(&fail_head);
> 
> @@ -1688,8 +1691,11 @@ again:
>          res->start = fail_res->start;
>          res->end = fail_res->end;
>          res->flags = fail_res->flags;
> -        if (fail_res->dev->subordinate)
> +        if (fail_res->dev->subordinate) {
>              res->flags = 0;
> +            if (!list_empty(&fail_res->dev->subordinate->devices))
> +                res->start = res->end = 0;
> +        }
>      }
>      free_list(&fail_head);

> ---
>  drivers/pci/setup-bus.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/pci/setup-bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/setup-bus.c
> +++ linux-2.6/drivers/pci/setup-bus.c
> @@ -1622,8 +1622,11 @@ again:
>  		res->start = fail_res->start;
>  		res->end = fail_res->end;
>  		res->flags = fail_res->flags;
> -		if (fail_res->dev->subordinate)
> +		if (fail_res->dev->subordinate) {
>  			res->flags = 0;
> +			if (!list_empty(&fail_res->dev->subordinate->devices))
> +				res->start = res->end = 0;
> +		}
>  	}
>  	free_list(&fail_head);
>  
> @@ -1688,8 +1691,11 @@ again:
>  		res->start = fail_res->start;
>  		res->end = fail_res->end;
>  		res->flags = fail_res->flags;
> -		if (fail_res->dev->subordinate)
> +		if (fail_res->dev->subordinate) {
>  			res->flags = 0;
> +			if (!list_empty(&fail_res->dev->subordinate->devices))
> +				res->start = res->end = 0;
> +		}
>  	}
>  	free_list(&fail_head);
>  

