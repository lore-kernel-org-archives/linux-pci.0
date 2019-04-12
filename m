Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA5C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 20:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3357218A3
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 20:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555101899;
	bh=Biq4wZHz3l8IfnVeHK37c14u+vfea5duf/1hqwJaVGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WZ+llgFQAEhvROf5mNifiKBvTYtvbSgQfjCVBn6WO1RGDBhfRUF240HlvHS7y81BA
	 VM5xIzU90a0ulmilBI1TBxnsi+iU2Ph+aWVN0wK6bi6RNmBCNw2rgWTIXGacQufSmN
	 E/E7kr73F/6wjxQYMO9XbRFcz4GvOnIT+OmRg9jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDLUo6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfDLUo6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 16:44:58 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C3C20850;
        Fri, 12 Apr 2019 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555101897;
        bh=Biq4wZHz3l8IfnVeHK37c14u+vfea5duf/1hqwJaVGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upKlxoKqsrxhhr83CC9V5TdmzFrh7Z3/yex4vHm2rUSJ4Jlu5go0bVeIZ1ED9asyc
         WFXLxK8uLb1vZhzKnG6k56VZRfoEy7nNb/OSYEO6LztHz6F6UVdwEwWLGjMfCmvCI3
         g+O0txVs8xNsTGF4dN5+eDfrPUzlUDDj7+DKPSPg=
Date:   Fri, 12 Apr 2019 15:44:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Clean up resource_alignment parameter to not
 require static buffer
Message-ID: <20190412204456.GG141472@google.com>
References: <20190410210532.4538-1-logang@deltatee.com>
 <20190410210532.4538-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410210532.4538-3-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 03:05:32PM -0600, Logan Gunthorpe wrote:
> Clean up the 'resource_alignment' parameter code to use kstrdup
> in the initcall routine instead of a static buffer that wastes memory
> regardless of whether the feature is used. This allows us to drop
> 'COMMAND_LINE_SIZE' bytes (typically 256-4096 depending on architecture)
> of static data.
> 
> This is similar to what has been done for the 'disable_acs_redir'
> parameter.
> 
> This conversion also allows us to use RCU instead of the spinlock to
> deal with the concurrency issue which further reduces memory usage.

I'm unconvinced about this part.  Spinlocks are CS 101 material and
I'm a little hesitant to use a graduate-level technique like RCU in a
case where it doesn't really buy us much -- we don't need the
performance advantage and the size advantage seems minimal.  But I'm
an RCU ignoramus and maybe need to be educated.

> As part of the clean up we also squash pci_get_resource_alignment_param()
> into resource_alignment_show() and pci_set_resource_alignment_param()
> into resource_alignment_store() seeing these functions only had one
> caller and the show/store wrappers were needlessly thin.

Squashing makes sense and would be nice as a separate patch.

> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c | 89 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 53 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 766f5779db92..13767c2409ae 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5896,9 +5896,7 @@ resource_size_t __weak pcibios_default_alignment(void)
>  	return 0;
>  }
>  
> -#define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
> -static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
> -static DEFINE_SPINLOCK(resource_alignment_lock);
> +static const char __rcu *resource_alignment_param;
>  
>  /**
>   * pci_specified_resource_alignment - get resource alignment specified by user.
> @@ -5916,9 +5914,9 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  	const char *p;
>  	int ret;
>  
> -	spin_lock(&resource_alignment_lock);
> -	p = resource_alignment_param;
> -	if (!*p && !align)
> +	rcu_read_lock();
> +	p = rcu_dereference(resource_alignment_param);
> +	if (!p)
>  		goto out;
>  	if (pci_has_flag(PCI_PROBE_ONLY)) {
>  		align = 0;
> @@ -5956,7 +5954,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  		p++;
>  	}
>  out:
> -	spin_unlock(&resource_alignment_lock);
> +	rcu_read_unlock();
>  	return align;
>  }
>  
> @@ -6082,35 +6080,48 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
>  	}
>  }
>  
> -static ssize_t pci_set_resource_alignment_param(const char *buf, size_t count)
> +static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
>  {
> -	if (count > RESOURCE_ALIGNMENT_PARAM_SIZE - 1)
> -		count = RESOURCE_ALIGNMENT_PARAM_SIZE - 1;
> -	spin_lock(&resource_alignment_lock);
> -	strncpy(resource_alignment_param, buf, count);
> -	resource_alignment_param[count] = '\0';
> -	spin_unlock(&resource_alignment_lock);
> -	return count;
> -}
> +	const char *p;
> +	size_t count = 0;
>  
> -static ssize_t pci_get_resource_alignment_param(char *buf, size_t size)
> -{
> -	size_t count;
> -	spin_lock(&resource_alignment_lock);
> -	count = snprintf(buf, size, "%s", resource_alignment_param);
> -	spin_unlock(&resource_alignment_lock);
> -	return count;
> -}
> +	rcu_read_lock();
> +	p = rcu_dereference(resource_alignment_param);
> +	if (!p)
> +		goto out;
>  
> -static ssize_t resource_alignment_show(struct bus_type *bus, char *buf)
> -{
> -	return pci_get_resource_alignment_param(buf, PAGE_SIZE);
> +	count = snprintf(buf, PAGE_SIZE, "%s", p);
> +
> +	/*
> +	 * When set by the command line there will not be a
> +	 * line feed, which is ugly. So conditionally add it here.
> +	 */
> +	if (buf[count - 2] != '\n' && count < PAGE_SIZE - 1) {
> +		buf[count - 1] = '\n';
> +		buf[count++] = 0;
> +	}
> +
> +out:
> +	rcu_read_unlock();
> +
> +	return count;
>  }
>  
>  static ssize_t resource_alignment_store(struct bus_type *bus,
>  					const char *buf, size_t count)
>  {
> -	return pci_set_resource_alignment_param(buf, count);
> +	const char *p, *old;
> +
> +	p = kstrndup(buf, count, GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	old = rcu_dereference_protected(resource_alignment_param, 1);
> +	rcu_assign_pointer(resource_alignment_param, p);
> +	synchronize_rcu();
> +	kfree(old);
> +
> +	return count;
>  }
>  
>  static BUS_ATTR_RW(resource_alignment);
> @@ -6238,8 +6249,8 @@ static int __init pci_setup(char *str)
>  			} else if (!strncmp(str, "cbmemsize=", 10)) {
>  				pci_cardbus_mem_size = memparse(str + 10, &str);
>  			} else if (!strncmp(str, "resource_alignment=", 19)) {
> -				pci_set_resource_alignment_param(str + 19,
> -							strlen(str + 19));
> +				RCU_INIT_POINTER(resource_alignment_param,
> +						 str + 19);
>  			} else if (!strncmp(str, "ecrc=", 5)) {
>  				pcie_ecrc_get_policy(str + 5);
>  			} else if (!strncmp(str, "hpiosize=", 9)) {
> @@ -6275,15 +6286,21 @@ static int __init pci_setup(char *str)
>  early_param("pci", pci_setup);
>  
>  /*
> - * 'disable_acs_redir_param' is initialized in pci_setup(), above, to point
> - * to data in the __initdata section which will be freed after the init
> - * sequence is complete. We can't allocate memory in pci_setup() because some
> - * architectures do not have any memory allocation service available during
> - * an early_param() call. So we allocate memory and copy the variable here
> - * before the init section is freed.
> + * 'resource_alignment_param' and 'disable_acs_redir_param' are initialized
> + * in pci_setup(), above, to point to data in the __initdata section which
> + * will be freed after the init sequence is complete. We can't allocate memory
> + * in pci_setup() because some architectures do not have any memory allocation
> + * service available during an early_param() call. So we allocate memory and
> + * copy the variable here before the init section is freed.
>   */
>  static int __init pci_realloc_setup_params(void)
>  {
> +	const char *p;
> +
> +	p = rcu_dereference_protected(resource_alignment_param, 1);
> +	p = kstrdup(p, GFP_KERNEL);
> +	rcu_assign_pointer(resource_alignment_param, p);
> +
>  	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
>  
>  	return 0;
> -- 
> 2.20.1
> 
