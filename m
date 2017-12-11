Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752361AbdLKRRx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Dec 2017 12:17:53 -0500
Date: Mon, 11 Dec 2017 11:17:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: Re: Oops on 4.15-rc[123] on shutdown/reboot
Message-ID: <20171211171751.GB16032@bhelgaas-glaptop.roam.corp.google.com>
References: <1d802670-2d50-dd05-1205-561b0c025845@googlemail.com>
 <32fa4f94-8f36-0321-81fd-f9ccb91c2a1f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <32fa4f94-8f36-0321-81fd-f9ccb91c2a1f@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Mon, Dec 11, 2017 at 11:29:50AM -0500, Sinan Kaya wrote:
> Hi Chris,
> 
> > 
> > I'm more than happy to provide additional diagnostics and test proposed fixes. As a starter for ten, I've attached the
> > output from 'lspci -v'. If, however, you need to see the backtrace, I'll need some advice on how to capture that.
> >
> 
> Can you open a bugzilla and also share the boot log?
> 
> There must be something unique about your system.

Can you attach "lspci -vv" output (as root) to the bugzilla, too?
