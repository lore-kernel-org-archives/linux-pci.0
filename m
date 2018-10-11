Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020C5C677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA8D2148C
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 17:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgItvqyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA8D2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeJLAgg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbeJLAgg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 20:36:36 -0400
Received: from localhost (unknown [204.56.7.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CE420658;
        Thu, 11 Oct 2018 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539277708;
        bh=ooz6EiZFaopD8x81zDYV/3xblYqjSWudeeOY+Z7Lu9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgItvqySkNWk/tYE9o3faUgY93OtpcarPc+eUNVvXry6jkoiL60l+Gz7crNVi+swn
         DzCTHkD2GLTsH35P6vIAZPkTjGUITM9YS4dhJ6HAlZYrd3ruARqh2Qowe3pMh/BoxT
         OtuX39ZseWAgNhoJ5/SZqtxstE5TIxAIDi16C7tU=
Date:   Thu, 11 Oct 2018 12:08:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI/AER: Covertly inject errors with ftrace hooks
Message-ID: <20181011170826.GR5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181011165207.12782-1-keith.busch@intel.com>
 <20181011165207.12782-4-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011165207.12782-4-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 10:52:07AM -0600, Keith Busch wrote:
> The aer_inject module had been intercepting config requests by overwriting
> the config accessor operations in the pci_bus ops.  This has several
> issues.
> 
> First, the module was tracking kernel objects unbeknownst to the drivers
> that own them.  The kernel may free those devices, leaving the AER inject
> module holding stale references and no way to know that happened.
> 
> Second, the PCI enumeration has child devices inherit pci_bus ops from
> the parent bus.  Since errors may lead to link resets that trigger
> re-enumeration, the child devices would inherit operations that don't
> know about the devices using them, causing kernel crashes.
> 
> Finally, CONFIG_PCI_LOCKLESS_CONFIG doesn't block accessing the pci_bus
> ops, so it's racing with potential in-flight config requests.
> 
> This patch uses a different error injection approach leveraging ftrace
> to thunk the config space functions.  If the kernel and architecture
> are capable, the ftrace hook will overwrite the processor's function
> call address with the address of the error injecting function. This way
> doesn't modify or track driver structures, fixing the issues with the
> current method.
> 
> If either the kernel config or platform arch do not support the necessary
> ftrace capabilities, the aer_inject module will fallback to the older
> way so that it may continue to be used as before.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/pcie/aer_inject.c | 218 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 189 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 726987f8d53c..4825fa465b60 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c

> +static int aer_inj_legacy_read(struct pci_bus *bus, unsigned int devfn,
> +			       int where, int size, u32 *val)
> +{
> +	struct pci_ops *ops, *my_ops;
> +	int rv;
> +
> +	ops = __find_pci_bus_ops(bus);
> +	if (!ops)
> +		return -1;
> +
> +	my_ops = bus->ops;
> +	bus->ops = ops;
> +	rv = ops->read(bus, devfn, where, size, val);
> +	bus->ops = my_ops;
> +
> +	return rv;
> +}
> +
> +static int aer_inj_legacy_write(struct pci_bus *bus, unsigned int devfn,
> +				int where, int size, u32 val)
> +{
> +	struct pci_ops *ops, *my_ops;
> +	int rv;
> +
> +	ops = __find_pci_bus_ops(bus);
> +	if (!ops)
> +		return -1;
> +
> +	my_ops = bus->ops;
> +	bus->ops = ops;
> +	rv = ops->write(bus, devfn, where, size, val);
> +	bus->ops = my_ops;
> +
> +	return rv;
> +}

Is there any chance you could split this into two (or more) patches?

The part above looks like pretty straightforward code movement without
any functional change.  It would be nice to get that part out of the way,
then have a smaller patch that adds the fancy ftrace stuff.

>  static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
>  			       int where, int size, u32 *val)
>  {
>  	u32 *sim;
>  	struct aer_error *err;
>  	unsigned long flags;
> -	struct pci_ops *ops;
> -	struct pci_ops *my_ops;
>  	int domain;
>  	int rv;
>  
> @@ -204,18 +244,7 @@ static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
>  		return 0;
>  	}
>  out:
> -	ops = __find_pci_bus_ops(bus);
> -	/*
> -	 * pci_lock must already be held, so we can directly
> -	 * manipulate bus->ops.  Many config access functions,
> -	 * including pci_generic_config_read() require the original
> -	 * bus->ops be installed to function, so temporarily put them
> -	 * back.
> -	 */
> -	my_ops = bus->ops;
> -	bus->ops = ops;
> -	rv = ops->read(bus, devfn, where, size, val);
> -	bus->ops = my_ops;
> +	rv = aer_inj_legacy_read(bus, devfn, where, size, val);
>  	spin_unlock_irqrestore(&inject_lock, flags);
>  	return rv;
>  }
> @@ -227,8 +256,6 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
>  	struct aer_error *err;
>  	unsigned long flags;
>  	int rw1cs;
> -	struct pci_ops *ops;
> -	struct pci_ops *my_ops;
>  	int domain;
>  	int rv;
>  
> @@ -252,18 +279,7 @@ static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
>  		return 0;
>  	}
>  out:
> -	ops = __find_pci_bus_ops(bus);
> -	/*
> -	 * pci_lock must already be held, so we can directly
> -	 * manipulate bus->ops.  Many config access functions,
> -	 * including pci_generic_config_write() require the original
> -	 * bus->ops be installed to function, so temporarily put them
> -	 * back.
> -	 */
> -	my_ops = bus->ops;
> -	bus->ops = ops;
> -	rv = ops->write(bus, devfn, where, size, val);
> -	bus->ops = my_ops;
> +	rv = aer_inj_legacy_write(bus, devfn, where, size, val);
>  	spin_unlock_irqrestore(&inject_lock, flags);
>  	return rv;
>  }
