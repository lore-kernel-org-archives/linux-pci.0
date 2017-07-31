Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbdGaUZa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 16:25:30 -0400
Date: Mon, 31 Jul 2017 15:25:27 -0500
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
Subject: Re: [PATCH v3 09/16] switchtec_ntb: initialize hardware for memory
 windows
Message-ID: <20170731202527.GC9303@bhelgaas-glaptop.roam.corp.google.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725205753.4735-10-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 25, 2017 at 02:57:46PM -0600, Logan Gunthorpe wrote:
> Add the code to initialize the memory windows in the hardware.
> This includes setting up the requester ID table, and figuring out
> which bar corresponds to which memory window. (Seeing the switch
> can be configured with any number of bars.)

s/bar/BAR/ (twice)

> Also, seeing the device doesn't have hardware for scratchpads or
> determining the link status, we create a shared memory window that has
> these features. A magic number with a version copmonent will be used

s/copmonent/component/

> to determine if the otherside's driver is actually up.

s/otherside/other side/

> The shared memory window also informs the other side of the
> size and count of the local memory windows.
