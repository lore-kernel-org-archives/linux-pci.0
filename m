Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45035 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750932AbdEERzs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2017 13:55:48 -0400
Date: Fri, 5 May 2017 10:55:27 -0700
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
Message-ID: <20170505175527.GG11379@kroah.com>
References: <007284c8-0c55-f8d9-b4a9-8bdb1daa4732@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <007284c8-0c55-f8d9-b4a9-8bdb1daa4732@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 05, 2017 at 09:59:15AM +0200, Juergen Gross wrote:
> Revert commit 72a9b186292 ("xen: Remove event channel notification
> through Xen PCI platform device") as the original analysis was wrong
> that all the removed code isn't in use any more.
> 
> It is still necessary for old Xen versions (< 4.0) and for being able
> to run the Linux kernel as dom0 in a nested Xen environment.
> 
> Upstream commit is 84d582d236dc1f9085e741affc72e9ba061a67c2.
> 
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Julien Grall <julien.grall@citrix.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Ross Lagerwall <ross.lagerwall@citrix.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: Anthony Liguori <aliguori@amazon.com>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> Please apply to stable-4.9.y
> ---
>  arch/x86/include/asm/xen/events.h | 11 +++++++
>  arch/x86/pci/xen.c                |  2 +-
>  arch/x86/xen/enlighten.c          | 21 +++++++++----
>  arch/x86/xen/smp.c                |  2 ++
>  arch/x86/xen/time.c               |  5 +++
>  drivers/xen/events/events_base.c  | 26 ++++++++++------
>  drivers/xen/platform-pci.c        | 64
> +++++++++++++++++++++++++++++++++++++++

Yup, also linewrapped :(
