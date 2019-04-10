Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D792C10F14
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 23:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0615120674
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 23:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554937746;
	bh=5kMn9Q2IlsLj3RyfZToYiqc1eTQJxy4xWKrdbuQ5UtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1eLVc6KsPucGxtkCoy2qmbnXNe4igj2dIjEbAFiVPZ9PlX6HW9nfRQzzh5kmSpNes
	 Ddr4qr1LAIlPMpJxu+sCslAJjiBb5EwC8x+300fG02PWaGc4LKy7u5hgSMDLaDFjcr
	 qAqH9R/TakopQp6kIvp4i6abA+IIGO1KzPP/iLNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfDJXI7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfDJXI6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 19:08:58 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB8420850;
        Wed, 10 Apr 2019 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554937737;
        bh=5kMn9Q2IlsLj3RyfZToYiqc1eTQJxy4xWKrdbuQ5UtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hXArNhAhOvz5G15mQjTs6R1Qcgt7VxDj12gyNaDnxrpgTOpqLeiUs19f+jrTzek2N
         rVwcZJkApWf+czA7BeKWoF0iqIDwrKos1bMbZybd1RCZCMiA2NzQJnI4cGUEIJtUhI
         YEwKWJR0rNSdFHPQ+4g6oebfHDJgZg5iBVAvCPlA=
Date:   Wed, 10 Apr 2019 18:08:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v2 2/2] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20190410230855.GN256045@google.com>
References: <cover.1553027719.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <4818f4dfa41bddc3968da4717c453897d4ad5717.1553027719.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190410184124.GF256045@google.com>
 <dc4e2bcf-44c9-1ffb-ab4f-75c04340b8dd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4e2bcf-44c9-1ffb-ab4f-75c04340b8dd@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 03:12:05PM -0700, sathyanarayanan kuppuswamy wrote:
> On 4/10/19 11:41 AM, Bjorn Helgaas wrote:
> > On Tue, Mar 19, 2019 at 01:47:29PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > As per PCI firmware specification v3.2 ECN
> > > (https://members.pcisig.com/wg/PCI-SIG/document/12614), when firmware
> > > owns Downstream Port Containment (DPC), its expected to use the "Error
> > > Disconnect Recover" (EDR) notification to alert OSPM of a DPC event and
> > > if OS supports EDR, its expected to handle the software state invalidation
> > > and port recovery in OS and let firmware know the recovery status via _OST
> > > ACPI call.
> > > 
> > > Since EDR is a hybrid service, DPC service shall be enabled in OS even
> > > if AER is not natively enabled in OS.

> > > +	bool			native_dpc;
> > This is going to be way too confusing with a "native_dpc" in both the
> > struct pci_host_bridge and the struct dpc_dev.
> Any suggestions? what about native_mode ?

"native_mode" is different but doesn't contain any additional
information.  I haven't worked out what this new symbol actually does;
if it's related to EDR, maybe that could be incorporated somehow?

> > > +		/* Register ACPI notifier for EDR event */
> > "Register handler for System events, one of which is the EDR event"?
> In our case, we only handle EDR event. So I just explicitly mentioned it.

Right.  As a courtesy to the reader, I think it's worth making
the comment match the code, i.e., you can't pass an event type to
acpi_install_notify_handler(), so obviously the handler will be called
for *all* System events.  By saying "one of which is the EDR event",
you give the reader a hint that the handler will have to filter out
the others.

The reason I noticed this is because I read "Register notifier for EDR
event" and wondered to myself "Hmmm, how does this work?  I don't see
anything passed to acpi_install_notify_handler() that would identify
an EDR event."

> > > +	/*
> > > +	 * If EDR support is enabled in OS, then even if AER is not handled in
> > > +	 * OS, DPC service can be enabled.
> > > +	 */
> > >   	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> > > -	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
> > > -	    (pcie_ports_native || host->native_dpc))
> > > +	    ((IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc) ||
> > > +	    (pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
> > > +	    (pcie_ports_native || host->native_dpc))))
> > Holy cow, I think I'll have to schedule an hour sometime to figure
> > out what's going on here :)
> Please check the previous patch in this series for details related to
> host->native_dpc.

Yeah, I'm just saying that conditional is starting to look pretty
gnarly.  Possibly there's nothing to do about it.

Bjorn
