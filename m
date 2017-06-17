Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:37037 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751962AbdFQQRF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Jun 2017 12:17:05 -0400
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-3-logang@deltatee.com> <20170617051145.GD6040@kroah.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <04e01458-e57b-a328-d4ff-c1fbb8664bb1@deltatee.com>
Date: Sat, 17 Jun 2017 10:16:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170617051145.GD6040@kroah.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC PATCH 02/13] switchtec: export class symbol for use in upper
 layer driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/06/17 11:11 PM, Greg Kroah-Hartman wrote:
> EXPORT_SYMBOL_GPL()?
> 
> And do you really have to move from a dynamic class to a static one?  I
> know it will work just the same, but I hate seeing static structures
> that have reference counts on them :)

I'll change both for v1. I didn't really need a static one. I just saw
an example of some other user of class_interface which and it seemed
appropriate.

Logan
