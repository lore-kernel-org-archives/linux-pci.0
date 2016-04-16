Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:57572 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbcDPHoP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 16 Apr 2016 03:44:15 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Duc Dang <dhdang@apm.com>, Feng Kan <fkan@apm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Mark Salter <msalter@redhat.com>, patches <patches@apm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Loc Ho <lho@apm.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH] pci: xgene: Add ECAM fixups
Date: Sat, 16 Apr 2016 09:43:40 +0200
Message-ID: <6597458.plyKBtcpp4@wuerfel>
In-Reply-To: <CADaLNDkCtUgFyX5tVgeM9grdHSQvpTHaq7qXk2WZ1tTbrP7OGA@mail.gmail.com>
References: <1455068984-22210-1-git-send-email-dhdang@apm.com> <2994764.UGKJE3zfLx@wuerfel> <CADaLNDkCtUgFyX5tVgeM9grdHSQvpTHaq7qXk2WZ1tTbrP7OGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 15 April 2016 14:30:56 Duc Dang wrote:
> On Wed, Feb 10, 2016 at 6:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 09 February 2016 17:49:44 Duc Dang wrote:
> >> X-Gene PCIe controller does not fully support ECAM.
> >> This patch adds required ECAM fixup to allow X-Gene
> >> PCIe controller to be functional in ACPI boot mode.
> >>
> >> This patch is based on the original work of
> >> Mark Salter <msalter@redhat.com> and depends on
> >> Tomasz's PCIe ACPI series:
> >> https://lkml.org/lkml/2016/2/4/646
> >>
> >> Signed-off-by: Duc Dang <dhdang@apm.com>
> >> ---
> >
> > This really has nothing to do with the PCI host device driver, please
> > keep it in a separate file in drivers/acpi/.
> 
> Hi Arnd,
> 
> With Tomasz latest PCIe ACPI series
> (https://lkml.org/lkml/2016/4/15/594), do you think it still better to
> keep the ACPI ECAM fixup code in a separate file in drivers/acpi
> directory?

Yes, I made the same comment for the cavium PCI workaround in that
series.

	Arnd
