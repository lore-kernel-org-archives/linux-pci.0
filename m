Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdFQFMI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2017 01:12:08 -0400
Date: Sat, 17 Jun 2017 07:11:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 01/13] switchtec: move structure definitions into a
 common header
Message-ID: <20170617051158.GE6040@kroah.com>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615203729.9009-2-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 02:37:17PM -0600, Logan Gunthorpe wrote:
> Create the switchtec.h header in include/linux with hardware defines
> and the switchtec_dev structure moved directly from switchtec.c.
> This is a prep patch for created an NTB driver for switchtec.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
