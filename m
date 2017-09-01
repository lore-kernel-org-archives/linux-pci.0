Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdIAPCh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2017 11:02:37 -0400
Date: Fri, 1 Sep 2017 17:02:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI Express gen 4.0 linux support
Message-ID: <20170901150240.GA30459@kroah.com>
References: <DM5PR1201MB2488D6B1322227EE0A06E8C8A0920@DM5PR1201MB2488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DM5PR1201MB2488D6B1322227EE0A06E8C8A0920@DM5PR1201MB2488.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 01, 2017 at 11:50:12AM +0000, Shah, Nehal-bakulchandra wrote:
> Hi All,
> 
> 
> I would like to know that is for PCI Express gen 4.0 supported in linux ? or any discussion/patches are underway for the same?

What specifically does the kernel need to provide for 4.0 that it does
not already handle?  Usually new versions of the PCIe spec are all at
the BIOS and hardware level, not at the kernel level, right?

And have you tried the latest kernel release on this type of hardware
and had problems?  If so, what were the results?

thanks,

greg k-h
