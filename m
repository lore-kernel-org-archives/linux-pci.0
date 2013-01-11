Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10843 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911Ab3AKKsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Jan 2013 05:48:05 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
References: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: dhowells@redhat.com, linux-pci@vger.kernel.org,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	x86@kernel.org
Subject: Re: [PATCH 0/5] PCI trivial cleanups
Date: Fri, 11 Jan 2013 10:47:52 +0000
Message-ID: <21164.1357901272@warthog.procyon.org.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <bhelgaas@google.com> wrote:

> These are trivial cleanups headed for v3.9.
> 
> ---
> 
> Bjorn Helgaas (5):
>       x86/PCI: Remove unused pci_root_bus
>       frv/PCI: Remove unused pci_root_bus
>       mn10300/PCI: Remove unused pci_root_bus
>       PCI: Use "unsigned long" for __pci_enable_device_flags to match ioport.h
>       PCI: Drop "__" prefix on __pci_enable_device_flags()

Feel free to add Acked-by: David Howells <dhowells@redhat.com> to all of them.
