Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44710 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2IEMlu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Sep 2012 08:41:50 -0400
Date: Wed, 5 Sep 2012 13:46:21 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg@redhat.com>
Cc: Don Dutile <ddutile@redhat.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-efi@vger.kernel.org,
	mfleming@intel.com, dwmw2@infradead.org, bhelgaas@google.com
Subject: Re: [PATCH V3 3/4] PCI: Add support for non-BAR ROMs
Message-ID: <20120905134621.73afe48a@pyramind.ukuu.org.uk>
In-Reply-To: <20120905022932.GA4087@srcf.ucam.org>
References: <1345739803-21017-1-git-send-email-mjg@redhat.com>
	<1345739803-21017-4-git-send-email-mjg@redhat.com>
	<5046B688.1070902@redhat.com>
	<20120905022932.GA4087@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 5 Sep 2012 03:29:32 +0100
Matthew Garrett <mjg@redhat.com> wrote:

> On Tue, Sep 04, 2012 at 10:18:48PM -0400, Don Dutile wrote:
> > >  	/*
> > >+	 * Some devices may provide ROMs via a source other than the BAR
> > >+	 */
> > >+	if (pdev->rom&&  pdev->romlen) {
> > >+		*size = pdev->romlen;
> > >+		return phys_to_virt((phys_addr_t)pdev->rom);
> >                        ^^^^^
> >                          ioremap_nocache() ? ... or is caching rom ok?
> 
> If it's appearing through this pathway then it's not actually in ROM, 
> the platform has pulled it out of somewhere else.

If that somewhere else is on the PCI bus then it should be a bus not a
virt translation surely ?
