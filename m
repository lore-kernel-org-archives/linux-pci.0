Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54912 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758331Ab2IGWmZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 18:42:25 -0400
Received: by lagy9 with SMTP id y9so55139lag.19
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2012 15:42:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120907163313.614852012@vyatta.com>
References: <20120907163313.614852012@vyatta.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 7 Sep 2012 15:42:03 -0700
Message-ID: <CAErSpo6T=vQnP2u6KP0+sDvT5=iQs1UFjpOLub+9y=B2k_MRgQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] PCI error handler const
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Linas Vepstas <linasvepstas@gmail.com>, linux-pci@vger.kernel.org,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 7, 2012 at 9:33 AM, Stephen Hemminger <shemminger@vyatta.com> wrote:
> This is a trivial patch to make PCI error handler function
> tables const. Split into pieces so that core changes are first.

I put all four of these on this branch:

http://git.kernel.org/?p=linux/kernel/git/helgaas/pci.git;a=shortlog;h=refs/heads/pci/stephen-const

If the netdev and scsi folks approve, I can handle them all through my PCI tree.

Bjorn
