Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:32988 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab3JIOa4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2013 10:30:56 -0400
Received: by mail-ie0-f170.google.com with SMTP id x13so2011718ief.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Oct 2013 07:30:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131009104553.GI25606@e102652-lin.cambridge.arm.com>
References: <20131008144211.GA25231@e102652-lin.cambridge.arm.com>
 <CAErSpo5=sUJDZGm+zHw+b1h_a1YYbaGBshAutAoPBZYUCRbYkw@mail.gmail.com>
 <525438F6.3090600@gmail.com> <1381264135.645.230.camel@pasglop>
 <20131009090923.GE25606@e102652-lin.cambridge.arm.com> <1381315068.4330.1.camel@pasglop>
 <20131009104553.GI25606@e102652-lin.cambridge.arm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Oct 2013 08:30:35 -0600
Message-ID: <CAErSpo6ujYmoOz4RMo3ATEJ+REMPiz6oR2pEUn=jW5GMDEB+Yw@mail.gmail.com>
Subject: Re: [RFC] Architecture independent pcibios?
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 9, 2013 at 4:45 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:

> Semantic question: what is the perceived difference between a pci_controller
> and a pci_host_bridge? Are they just historical naming artifacts of the
> same concept? (person A deciding to do a cleanup of the code and picks a
> new name in order not to upset the old APIs)

pci_controller is a typical name for the arch-dependent PCI host
bridge structure.  Some arches use different names, e.g.,
pci_sys_data, pci_hba_data, pci_channel, etc.

When I added support in the PCI core for host bridge address
translation, e.g., ACPI _TRA, I named the core structure
pci_host_bridge.

Some of the stuff in pci_controller and similar arch-dependent
structures could probably be moved into pci_host_bridge, given
appropriate PCI core interfaces to supply the information (or maybe
pcibios_*() functions the core could use to retrieve it).  But I doubt
we could completely remove the arch-dependent structures.

Bjorn
