Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50707 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaAGPpG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2014 10:45:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Tanmay Inamdar <tinamdar@apm.com>, devicetree@vger.kernel.org,
	Jon Masters <jcm@redhat.com>, linux-doc@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	patches <patches@apm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Landley <rob@landley.net>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 3/3] dt-bindings: pci: xgene pcie device tree bindings
Date: Tue, 07 Jan 2014 16:44:30 +0100
Message-ID: <4687115.Uo6IImEscY@wuerfel>
In-Reply-To: <201401071635.02006.arnd@arndb.de>
References: <1387785725-24262-1-git-send-email-tinamdar@apm.com> <CACoXjc=h8W=9jx4d2Y+F9hmgQsuMTgG4080jZGbtddv10OgtMA@mail.gmail.com> <201401071635.02006.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 07 January 2014 16:35:01 Arnd Bergmann wrote:
> > >> +SoC specific DT Entry:
> > >> +     pcie0: pcie@1f2b0000 {
> > >> +             status = "disabled";
> > >> +             device_type = "pci";
> > >> +             compatible = "xgene,pcie";
> > >> +             #interrupt-cells = <1>;
> > >> +             #size-cells = <2>;
> > >> +             #address-cells = >;
> > >> +             reg = < 0x00 0x1f2b0000 0x0 0x00010000>;
> > >> +             ranges = <0x02000000 0x0 0x00000000 0xe0 0x00000000 0x0 0x10000000 /* mem*/
> > >
> > >
> > > Also, do you support no prefetchable memory?
> > 
> > HW has either IO or Memory regions for mapping device's memory space.
> > There is no separate prefetchable memory space.
> 
> Are you sure the memory is non-prefetchable then? I would have expected
> 0x42000000 rather than 0x02000000, but I could be misremembering it.

Nevermind. I just checked and you are right: if you only have
one memory range, it has to be non-prefetchable.

	Arnd
