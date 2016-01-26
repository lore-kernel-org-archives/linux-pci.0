Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46325 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932671AbcAZMtE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 07:49:04 -0500
Date: Tue, 26 Jan 2016 13:49:01 +0100
From: Borislav Petkov <bp@suse.de>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	john.ronciak@intel.com, tony.luck@intel.com,
	Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] PCI: aer_inject: Log actual error causes
Message-ID: <20160126124901.GE8475@pd.tnic>
References: <20160126095205.0e5923bd@endymion.delvare>
 <20160126101244.GB8475@pd.tnic>
 <1453811238.4772.124.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1453811238.4772.124.camel@chaos.site>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 01:27:18PM +0100, Jean Delvare wrote:
> But I'd say -EPERM is hardly better. The problem with -ENODEV is that it
> is already returned by this function for several other error causes.
> Also the aer-inject user-space tool will print the error message from
> the error code, and I don't think "No such device" is helpful in that
> case. What about -ENOTSUPP ("Operation not supported") or
> -EEPROTONOSUPPORT ("Protocol not supported")?

Makes sense.

> I can change it if nobody objects. I think the change can be included in
> this patch as it is quite related.

I'd do a separate patch but this is only my opinion. I guess that's
Bjorn's call.

> I'd rather ask, why printk? ;-) Using raw printk is considered bad and
> should be avoided whenever possible.

Hmm, interesting. Why?

> So says checkpatch.pl.

Please don't tell me you believe what checkpatch says.

> > Why not pr_err() and define pr_fmt to "aer_inject: " and then drop
> > that prefix from the messages?
> 
> Because I believe that including the device name in the error messages
> makes them more helpful to understand and diagnose the problem. If the
> device where we try to inject the error has a problem, it's PCI name
> will be included in the error message. If the error is with the root
> port, then we include the root port's PCI name. If I used pr_err()
> instead then the device information would be missing.

True, that's a good argument.

However, if you're doing aer injection, you already *know* the device
you're injecting too. Unless you want to inject in multiple devices and
then it is helpful.

So sure, dev_* sounds better as it gives more info about which device
fails, but then please convert the whole driver.

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
