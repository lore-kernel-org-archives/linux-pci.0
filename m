Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21006 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933044Ab3HGNaA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Aug 2013 09:30:00 -0400
Date: Wed, 7 Aug 2013 16:29:20 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Myron Stowe <mstowe@redhat.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] acpi, acpi_pci_irq_enable must return an error if ACPI
 cannot map an IRQ.
Message-ID: <20130807132920.GA27208@xps8300>
References: <1373900260-1599-1-git-send-email-prarit@redhat.com>
 <20130805140416.GA3882@xps8300>
 <52010A40.1040409@redhat.com>
 <86005101.W2j5ifU8yA@vostro.rjw.lan>
 <52023FE6.9010503@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52023FE6.9010503@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wed, Aug 07, 2013 at 08:39:02AM -0400, Prarit Bhargava wrote:
> On 08/06/2013 06:44 PM, Rafael J. Wysocki wrote:
> > In the meantime I've dropped that commit from linux-next as it caused the xHCI
> > breakage to happen.
> 
> Thanks Rafael.
> 
> Heikki, I tested your patch and found that it solves my problem.  Sorry for the
> breakage :(
> 
> Can you add a
> 
> Tested-by: Prarit Bhargava <prarit@redhat.com>
> 
> to your patch?

Well, it would be more clear to me if you send new version of the
patch that combines the two, since Rafael dropped the original.

Thanks,

-- 
heikki
