Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45211 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751612AbdDNJRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2017 05:17:30 -0400
Date: Fri, 14 Apr 2017 11:17:20 +0200
From: Greg KH <greg@kroah.com>
To: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Julien Grall <julien.grall@citrix.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [stable-4.9: PATCH] xen: revert commit 72a9b186292
Message-ID: <20170414091720.GB6372@kroah.com>
References: <20170413130653.5183-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170413130653.5183-1-jgross@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 13, 2017 at 03:06:53PM +0200, Juergen Gross wrote:
> Revert commit 72a9b186292 ("xen: Remove event channel notification
> through Xen PCI platform device") as the original analysis was wrong
> that all the removed code isn't in use any more.
> 
> It is still necessary for old Xen versions (< 4.0) and for being able
> to run the Linux kernel as dom0 in a nested Xen environment.

What is the commit id of this revert in Linus's tree?

thanks,

greg k-h
