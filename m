Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48664 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933136AbcFQRo4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 17 Jun 2016 13:44:56 -0400
Date: Fri, 17 Jun 2016 12:44:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>
Subject: Re: [PATCH 0/2] PCI: hv: fix a couple of issues in
 hv_pci_onchannelcallback()
Message-ID: <20160617174451.GA1977@localhost>
References: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
 <20160610235336.GA16462@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160610235336.GA16462@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 10, 2016 at 06:53:36PM -0500, Bjorn Helgaas wrote:
> On Mon, May 30, 2016 at 04:17:57PM +0200, Vitaly Kuznetsov wrote:
> > kmemleak helped me to identify a memory leak in hv_pci_onchannelcallback()
> > and while fixing it I stumbled upon an unrelated issue(s) there.
> > 
> > Vitaly Kuznetsov (2):
> >   PCI: hv: don't leak buffer in hv_pci_onchannelcallback()
> >   PCI: hv: handle all pending messages in hv_pci_onchannelcallback()
> 
> I applied both to for-linus for v4.7 with Jake's acks, thanks, Vitaly.

Somehow I must have been thinking these were fixes for things we
merged or broke during the v4.7 merge window, but that doesn't look
like the case.  So I'm going to merge these for v4.8 instead, on the
theory that the v4.7-rc cycles are primarily for stabilization.

Bjorn
