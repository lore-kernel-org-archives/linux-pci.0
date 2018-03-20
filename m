Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751343AbeCTUOg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Mar 2018 16:14:36 -0400
Date: Tue, 20 Mar 2018 15:14:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Miller <davem@davemloft.net>
Cc: khalid.aziz@oracle.com, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, yinghai@kernel.org,
        linux-kernel@vger.kernel.org, david.ahern@oracle.com, linux@iam.tj,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        alex.williamson@redhat.com
Subject: Re: [PATCH v1 0/2] PCI: Sparc 64-bit resource fixups
Message-ID: <20180320201434.GB137590@bhelgaas-glaptop.roam.corp.google.com>
References: <20180319171140.GA52750@bhelgaas-glaptop.roam.corp.google.com>
 <20180319.142831.793002554436316260.davem@davemloft.net>
 <20180319193854.GI77194@bhelgaas-glaptop.roam.corp.google.com>
 <20180319.193341.105600714432834778.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180319.193341.105600714432834778.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:33:41PM -0400, David Miller wrote:
> From: Bjorn Helgaas <helgaas@kernel.org>
> Date: Mon, 19 Mar 2018 14:38:54 -0500
> 
> > I'd be happy to remove both.  But I wonder how X init works on
> > sparc.
> 
> It's been many years since I worked on this, but I think it
> mapped and used the PCI ROM resource for this.

Thanks, I posted a v2 series that removes the System ROM and Video ROM
areas completely.
