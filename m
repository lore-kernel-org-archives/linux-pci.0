Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20306 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445Ab3FZDCT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 25 Jun 2013 23:02:19 -0400
Message-ID: <1372215737.30572.484.camel@ul30vt.home>
Subject: Re: Current open PCI defects
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Tue, 25 Jun 2013 21:02:17 -0600
In-Reply-To: <20130626025001.GA25384@google.com>
References: <20130626025001.GA25384@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-06-25 at 20:50 -0600, Bjorn Helgaas wrote:
> Here's a list of the current PCI defects open in https://bugzilla.kernel.org
> 
> Hint: maintainers really like it when people take the initiative to
> resolve open issues.
> 
> Regressions (8 total):
> 
>   15388	After suspend to ram, laptop doesn't connect to the wired network. Sky2 error. Marvell 88E8036
>   41622	[REGRESSION][BISECTED] Notebook crashes upon detecting the PCI subsystem with kernels >= 2.6.24-rc7
>   42606	PCI I/O range not assigned under newer kernels
>   44881	pci_find_upstream_pcie_bridge() warning

http://www.spinics.net/lists/linux-pci/msg23262.html

