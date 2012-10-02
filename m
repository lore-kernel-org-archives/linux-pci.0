Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51373 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755209Ab2JBRrO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 13:47:14 -0400
Date: Tue, 2 Oct 2012 10:47:12 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/10] device: add drivers_autoprobe in struct device
Message-ID: <20121002174712.GA11843@kroah.com>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
 <1349159588-15029-2-git-send-email-yinghai@kernel.org>
 <20121002133303.GA502@kroah.com>
 <CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQVCFs8cgFoU2rb=a8MWCzBcfRT6iNh7UchV8q6Bg6XzGQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 02, 2012 at 10:39:25AM -0700, Yinghai Lu wrote:
> On Tue, Oct 2, 2012 at 6:33 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Oct 01, 2012 at 11:32:59PM -0700, Yinghai Lu wrote:
> >> To use to control the delay attach driver for specific device.
> >>
> >> Will use bus notifier to toggle this bits when needed.
> >>
> >> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > Without a whole lot more context as to why you want this change, no,
> > sorry, I'll not accept it.
> 
> Sorry, I should put you on the to list for the whole patchset.
> 
> Those patches address Bjorn's request:
> 1. kill acpi_pci_root_start in drivers/acpi/pci_root.c
> 2. register pci device to device as soon as possible, so for_each_pci_device
>    could be used early before pci_bus_add_devices.
> 
> please check change log patch2-4.

Sorry, I still don't see what is so special about PCI that they have to
do something different here.  What am I missing?

greg k-h
