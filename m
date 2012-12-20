Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56686 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2LTVUW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Dec 2012 16:20:22 -0500
Message-ID: <50D380E2.2000600@zytor.com>
Date: Thu, 20 Dec 2012 13:19:30 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Miller <davem@davemloft.net>,
	Tony Luck <tony.luck@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Jan Glauber <jang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [Update 2][PATCH] ACPI / PCI: Set root bridge ACPI handle in
 advance
References: <1558789.gX8cmBgyDV@vostro.rjw.lan> <4085861.TBmZVTPOvU@vostro.rjw.lan> <3596215.suSiEFiGH8@vostro.rjw.lan> <CAErSpo7NWHmSEJMuytUTziRTwUmnPHCVcD0zX7pKVmhQyv26sQ@mail.gmail.com>
In-Reply-To: <CAErSpo7NWHmSEJMuytUTziRTwUmnPHCVcD0zX7pKVmhQyv26sQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/20/2012 01:13 PM, Bjorn Helgaas wrote:
> 
> - Add "struct acpi_dev_node acpi_node" to struct pci_sysdata (x86) and
> struct pci_controller (ia64).  These are the only two arches that use
> ACPI.
> 

Currently.  There will be ARM platforms with ACPI soon, if there aren't
already.

	-hpa


