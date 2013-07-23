Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:45885 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933104Ab3GWQGr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 12:06:47 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so11551083oag.40
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 09:06:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL-B5D03ki8NHsM6EuESTH2K-Eh+XyFHNXPDYwgDq+oagDjtMQ@mail.gmail.com>
References: <CAL-B5D03ki8NHsM6EuESTH2K-Eh+XyFHNXPDYwgDq+oagDjtMQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 23 Jul 2013 10:06:26 -0600
Message-ID: <CAErSpo7TexM5-7Z=8H+B5=49-GzoKd_prn=LbMFZWV9rpdn__A@mail.gmail.com>
Subject: Re: Linux Plumbers ACPI/PM, PCI Microconference
To: Myron Stowe <myron.stowe@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	virtualization@lists.linux-foundation.org,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 16, 2013 at 8:21 PM, Myron Stowe <myron.stowe@gmail.com> wrote:
> Linux Plumbers has approved an ACPI/PM, PCI microconference. The
> overview page is here:
>
> http://wiki.linuxplumbersconf.org/2013:pci_subsystem
>
> We would like to start receiving volunteers for presenting topics of
> interest.  There is a lot of activity in these subsystems so please
> respond by submitting presentation or discussion proposals that you
> would be willing to cover for consideration.  You should also feel
> free to submit ideas as proposals that others could cover.

Somebody else privately suggested these ARM/PCI topics:

> -> how it's been cleaned up to be more common across arm-32 machines
> -> dependencies on dtb
> -> future use/dependency(s) on ACPI
> -> hotplug support issues (if any; acpi (host-bridge) vs <whatever ARM uses> ?)

and I'm interested in those as well.  There seems to be a lot of
activity in that area.  In addition, I'm interested in ARM IOMMU
support.  I see drivers/iommu/arm-smmu.c, but it's brand-new and I
haven't looked at it at all.

Bjorn
