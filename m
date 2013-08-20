Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52072 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378Ab3HTVXK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 Aug 2013 17:23:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: add hibernation hooks
Date: Tue, 20 Aug 2013 23:33:42 +0200
Message-ID: <3503956.Yk8myngYqt@vostro.rjw.lan>
In-Reply-To: <CAErSpo4qnDyQQt+sZi=1tj0PP+HUmLfMp4zQ2hdqjJ+mOcAzYA@mail.gmail.com>
References: <alpine.LFD.2.03.1308201637390.1566@linux.vnet.ibm.com> <CAErSpo4qnDyQQt+sZi=1tj0PP+HUmLfMp4zQ2hdqjJ+mOcAzYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 20, 2013 11:08:56 AM Bjorn Helgaas wrote:
> On Tue, Aug 20, 2013 at 8:41 AM, Sebastian Ott
> <sebott@linux.vnet.ibm.com> wrote:
> > Hello Bjorn,
> >
> > I'm currently trying to implement hibernate support for pci on s390. To access
> > the config space of a pci function on s390 the function has to be enabled first.
> > So I need some kind of callback to achieve this before the pci core or the device
> > driver tries to access the function after a resume from hibernate.
> >
> > Would you be OK with the following patch?
> 
> I think doing something like this is fine.

Well, since we seem to be doing everything using __weak functions in the PCI
land like in this patch, shouldn't we drop pci_platform_pm and use __weak
functions for that stuff too?

Rafael

