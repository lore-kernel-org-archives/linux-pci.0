Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751783AbdGETmU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jul 2017 15:42:20 -0400
Date: Wed, 5 Jul 2017 14:42:16 -0500
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
Subject: Re: [PATCH 13/16] switchtec_ntb: implement doorbell registers
Message-ID: <20170705194216.GB25063@bhelgaas-glaptop.roam.corp.google.com>
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-14-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629032648.3073-14-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 28, 2017 at 09:26:45PM -0600, Logan Gunthorpe wrote:
> Pretty straightforward implementation of doorbell registers.
> The shift and mask were setup in an earlier patch and this just hooks
> up the approprirate portion of the idb register as the local doorbells
> and the opposite portion of odb as the peer doorbells. The db mask is
> protected by a spinlock to avoid concurrent read-modify-write accesses.

s/approprirate/appropriate/
