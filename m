Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35775 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966109Ab3DQShb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Apr 2013 14:37:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Changes for v3.10 merge window
Date: Wed, 17 Apr 2013 20:45:23 +0200
Message-ID: <170788625.1RAzAFj9Rt@vostro.rjw.lan>
In-Reply-To: <CAErSpo44LzWjne=0G+4tMiFmHd0x=b6Rfd7K_PWZo+yZmFihsg@mail.gmail.com>
References: <20130416171732.GA6356@google.com> <1825980.1C7UKqDGj6@vostro.rjw.lan> <CAErSpo44LzWjne=0G+4tMiFmHd0x=b6Rfd7K_PWZo+yZmFihsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 17, 2013 10:47:51 AM Bjorn Helgaas wrote:
> On Wed, Apr 17, 2013 at 10:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, April 16, 2013 11:17:32 AM Bjorn Helgaas wrote:
> >> Below are the patches currently in my "next" branch, planned for
> >> release in v3.10.  If I'm missing something important, let me know.
> >
> > Well, you said you took the "PCI / PM: Make pci_pme_active() ignore devices
> > without PME support" patch for v3.10, but it is not listed below.
> 
> Yep, I just merged it 30 seconds ago :)  I was waiting to make sure
> you didn't want the "Fix fallback to PCI_D0"  patch in v3.9.  Thanks
> for the reminder.

No problem and thanks!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
