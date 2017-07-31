Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbdGaU1E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 16:27:04 -0400
Date: Mon, 31 Jul 2017 15:27:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v3 12/16] switchtec_ntb: add link management
Message-ID: <20170731202700.GE9303@bhelgaas-glaptop.roam.corp.google.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725205753.4735-13-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 25, 2017 at 02:57:49PM -0600, Logan Gunthorpe wrote:
> switchtec_ntb checks for a link by looking at the shared memory
> window. If the magic number is correct and the otherside indicates
> their link is enabled then we take the link to be up.
> 
> Whenever we change our local link status we send a msg to the
> otherside to check whether it's up and change their status.

s/otherside/other side/ (twice)

> The current status is maintained in a flag so ntb_is_link_up
> can return quickly.
> 
> We utilize Switchtec's link status notifier to also check link changes
> when the switch notices a port changes state.
