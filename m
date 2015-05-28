Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38434 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbbE1Uis (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2015 16:38:48 -0400
MIME-Version: 1.0
In-Reply-To: <2708462.WpN2O508C5@vostro.rjw.lan>
References: <2708462.WpN2O508C5@vostro.rjw.lan>
Date: Thu, 28 May 2015 22:38:47 +0200
Message-ID: <CAJZ5v0iCv=qwNOeLnOh+cRum=UmyUp48M-gc3LkU91U5hdPeBg@mail.gmail.com>
Subject: Re: [PATCH] Revert "PCI/PM: Remove pci_pm_complete()"
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 28, 2015 at 4:12 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Revert commit 84822b158fd3 "PCI/PM: Remove pci_pm_complete()" that
> removed the execution of the device driver's ->complete callback
> from the PCI bus type.
>
> That was a mistake, because those callbacks are not executed at all
> now even if present.
>
> Fixes: 84822b158fd3 "PCI/PM: Remove pci_pm_complete()"
> Cc: 3.13+ <stable@vger.kernel.org> # 3.13+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Scratch this, sorry.

The code is correct as is, because the bus type doesn't provide
->complete at all in which case the core will run the driver's
callback directly.

We'll probably need ->complete for PCI at one point, but then I'll
resubmit this one with a different changelog.

Thanks,
Rafael
