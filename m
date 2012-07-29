Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33353 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753021Ab2G2O7H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2012 10:59:07 -0400
Date: Sun, 29 Jul 2012 07:59:05 -0700
From: Greg KH <greg@kroah.com>
To: Shlomo Pongratz <shlomopongratz@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org
Subject: Re: Cabled PCIE device hotplug/hot-removal
Message-ID: <20120729145905.GC5945@kroah.com>
References: <CAHzK-V0XpkVJHgqWiWpYP1jx5DPX=voE0eymK+5FG-zhrJOwAQ@mail.gmail.com>
 <20120726170925.GA24751@kroah.com>
 <CAHzK-V0idPrHhf-YuC_HAxxxQABExW7mUUWN31f-ZpdnC8W+GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHzK-V0idPrHhf-YuC_HAxxxQABExW7mUUWN31f-ZpdnC8W+GA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 29, 2012 at 03:36:09PM +0300, Shlomo Pongratz wrote:
> On Thu, Jul 26, 2012 at 8:09 PM, Greg KH <greg@kroah.com> wrote:
> > On Thu, Jul 26, 2012 at 08:03:09PM +0300, Shlomo Pongratz wrote:
> >> Hi,
> >>
> >> I have a  PCIe device connected with cables to a host (kernel 3.5.0-rc7+).
> >> What are the handler I need to add to a driver in order to catch cable
> >> pull-out / push-in?
> >
> > You shouldn't need anything special, aren't you already getting probe
> > and disconnect callbacks when the device is discovered and removed?
> 
> When the device is loaded the probe is called
> When I "echo 1" to the remove sysfs entry the remove callback is called.
> But when I power down the card no callback is called.

Then I would blame your pci hotplug controller, that is its
responsibility.

> >> The pcisig presentation
> >> "http://www.pcisig.com/developers/main/training_materials/get_document?doc_id=f4ca40ec1721aa7fadd05e2903b0172c36656294"
> >> talks about PERST# detection for cabled PCIe hotplug.
> >>
> >> Does the kernel detect it?
> >>
> >> None of the pci_driver or pci_error_handlers callbacks were called
> >> when using powered down/up the device (electrically).
> >
> > Do you have the pciehp driver loaded properly when this happens?
> 
> My {dot}config includes it into the kernel, i.e.
> CONFIG_HOTPLUG_PCI_PCIE=y

And is it working properly?  Does your hardware support this (i.e. your
BIOS?)

greg k-h
