Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1951AC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC002085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 17:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC002085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeJLBRU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:17:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:26293 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeJLBRU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 21:17:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 10:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="78055880"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2018 10:48:16 -0700
Date:   Thu, 11 Oct 2018 11:45:16 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI/AER: Covertly inject errors with ftrace hooks
Message-ID: <20181011174516.GE11034@localhost.localdomain>
References: <20181011165207.12782-1-keith.busch@intel.com>
 <20181011165207.12782-4-keith.busch@intel.com>
 <20181011170826.GR5906@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011170826.GR5906@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 11, 2018 at 12:08:26PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 11, 2018 at 10:52:07AM -0600, Keith Busch wrote:
> > The aer_inject module had been intercepting config requests by overwriting
> > the config accessor operations in the pci_bus ops.  This has several
> > issues.
> > 
> > First, the module was tracking kernel objects unbeknownst to the drivers
> > that own them.  The kernel may free those devices, leaving the AER inject
> > module holding stale references and no way to know that happened.
> > 
> > Second, the PCI enumeration has child devices inherit pci_bus ops from
> > the parent bus.  Since errors may lead to link resets that trigger
> > re-enumeration, the child devices would inherit operations that don't
> > know about the devices using them, causing kernel crashes.
> > 
> > Finally, CONFIG_PCI_LOCKLESS_CONFIG doesn't block accessing the pci_bus
> > ops, so it's racing with potential in-flight config requests.
> > 
> > This patch uses a different error injection approach leveraging ftrace
> > to thunk the config space functions.  If the kernel and architecture
> > are capable, the ftrace hook will overwrite the processor's function
> > call address with the address of the error injecting function. This way
> > doesn't modify or track driver structures, fixing the issues with the
> > current method.
> > 
> > If either the kernel config or platform arch do not support the necessary
> > ftrace capabilities, the aer_inject module will fallback to the older
> > way so that it may continue to be used as before.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > ---
> >  drivers/pci/pcie/aer_inject.c | 218 ++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 189 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> > index 726987f8d53c..4825fa465b60 100644
> > --- a/drivers/pci/pcie/aer_inject.c
> > +++ b/drivers/pci/pcie/aer_inject.c
> 
> > +static int aer_inj_legacy_read(struct pci_bus *bus, unsigned int devfn,
> > +			       int where, int size, u32 *val)
> > +{
> > +	struct pci_ops *ops, *my_ops;
> > +	int rv;
> > +
> > +	ops = __find_pci_bus_ops(bus);
> > +	if (!ops)
> > +		return -1;
> > +
> > +	my_ops = bus->ops;
> > +	bus->ops = ops;
> > +	rv = ops->read(bus, devfn, where, size, val);
> > +	bus->ops = my_ops;
> > +
> > +	return rv;
> > +}
> > +
> > +static int aer_inj_legacy_write(struct pci_bus *bus, unsigned int devfn,
> > +				int where, int size, u32 val)
> > +{
> > +	struct pci_ops *ops, *my_ops;
> > +	int rv;
> > +
> > +	ops = __find_pci_bus_ops(bus);
> > +	if (!ops)
> > +		return -1;
> > +
> > +	my_ops = bus->ops;
> > +	bus->ops = ops;
> > +	rv = ops->write(bus, devfn, where, size, val);
> > +	bus->ops = my_ops;
> > +
> > +	return rv;
> > +}
> 
> Is there any chance you could split this into two (or more) patches?
> 
> The part above looks like pretty straightforward code movement without
> any functional change.  It would be nice to get that part out of the way,
> then have a smaller patch that adds the fancy ftrace stuff.

No problem, will do.
