Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59786 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933490Ab3HGWyZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Aug 2013 18:54:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <mstowe@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] acpi, acpi_pci_irq_enable must return an error if ACPI cannot map an IRQ.
Date: Thu, 08 Aug 2013 01:04:43 +0200
Message-ID: <5376601.QRmnHTQosN@vostro.rjw.lan>
In-Reply-To: <20130807132920.GA27208@xps8300>
References: <1373900260-1599-1-git-send-email-prarit@redhat.com> <52023FE6.9010503@redhat.com> <20130807132920.GA27208@xps8300>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 07, 2013 04:29:20 PM Heikki Krogerus wrote:
> Hi,
> 
> On Wed, Aug 07, 2013 at 08:39:02AM -0400, Prarit Bhargava wrote:
> > On 08/06/2013 06:44 PM, Rafael J. Wysocki wrote:
> > > In the meantime I've dropped that commit from linux-next as it caused the xHCI
> > > breakage to happen.
> > 
> > Thanks Rafael.
> > 
> > Heikki, I tested your patch and found that it solves my problem.  Sorry for the
> > breakage :(
> > 
> > Can you add a
> > 
> > Tested-by: Prarit Bhargava <prarit@redhat.com>
> > 
> > to your patch?
> 
> Well, it would be more clear to me if you send new version of the
> patch that combines the two, since Rafael dropped the original.

Well, could you please rebase your patch on top of the Linus' tree and resend
it?

Rafael

