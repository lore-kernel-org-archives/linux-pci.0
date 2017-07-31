Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751375AbdGaU0J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jul 2017 16:26:09 -0400
Date: Mon, 31 Jul 2017 15:26:06 -0500
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
Subject: Re: [PATCH v3 10/16] switchtec_ntb: initialize hardware for
 doorbells and messages
Message-ID: <20170731202606.GD9303@bhelgaas-glaptop.roam.corp.google.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-11-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725205753.4735-11-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 25, 2017 at 02:57:47PM -0600, Logan Gunthorpe wrote:
> Set up some hardware registers and creates interrupt service routines
> for the doorbells and messages.
> 
> There are 64 doorbells in the switch that are shared between all
> partitions. The upper 4 doorbells are also shared with the messages
> and are there for not used. Thus, this provides 28 doorbells for each

s/there for/therefore/

> partition.
