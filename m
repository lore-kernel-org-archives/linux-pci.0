Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:56741 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538Ab3FYVUo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 17:20:44 -0400
Received: by mail-oa0-f45.google.com with SMTP id j1so13819873oag.4
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2013 14:20:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130621102526.GG12441@manwe>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-10-git-send-email-thomas.petazzoni@free-electrons.com> <20130621102526.GG12441@manwe>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Jun 2013 15:20:23 -0600
Message-ID: <CAErSpo69OCYMA8ub8rZ8FfPimmpjHzE3WZ5RFt=HrototyHRSA@mail.gmail.com>
Subject: Re: [PATCHv3 09/11] pci: mvebu: add support for MSI
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 21, 2013 at 4:25 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Jun 19, 2013 at 06:56:17PM +0200, Thomas Petazzoni wrote:
>> This commit adds support for Message Signaled Interrupts in the
>> Marvell PCIe host controller. The work is very simple: it simply gets
>> a reference to the msi_chip associated to the PCIe controller thanks
>> to the msi-parent DT property, and stores this reference in the
>> pci_bus structure. This is enough to let the Linux PCI core use the
>> functions of msi_chip to setup and teardown MSIs.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  drivers/pci/host/pci-mvebu.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>
> Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this through arm-soc or some other non-PCI tree.

Bjorn
