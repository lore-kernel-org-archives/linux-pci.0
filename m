Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60334 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489AbcFJPfz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 11:35:55 -0400
Date: Fri, 10 Jun 2016 10:35:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: hv: fix a couple of issues in
 hv_pci_onchannelcallback()
Message-ID: <20160610153551.GD19309@localhost>
References: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
 <87ziqt8d0y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ziqt8d0y.fsf@vitty.brq.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 10, 2016 at 02:05:33PM +0200, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
> > kmemleak helped me to identify a memory leak in hv_pci_onchannelcallback()
> > and while fixing it I stumbled upon an unrelated issue(s) there.
> >
> > Vitaly Kuznetsov (2):
> >   PCI: hv: don't leak buffer in hv_pci_onchannelcallback()
> >   PCI: hv: handle all pending messages in hv_pci_onchannelcallback()
> >
> 
> Bjorn,
> 
> sorry for the ping but with both patches acked by Jake is there anything
> else required for this series to get merged? It would be nice to have
> these fixes in 4.7 but even knowing that they're queued for 4.8 is OK.

Nothing else required, but I'm glad you mentioned that these should go
in v4.7.  By default I merge things to -next, which would be for v4.8
right now.

Bjorn
