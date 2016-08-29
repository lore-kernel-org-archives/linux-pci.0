Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:37984 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbcH2Ra4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2016 13:30:56 -0400
Subject: Re: [PATCH] xen: Remove event channel notification through Xen PCI
 platform device
To: KarimAllah Ahmed <karahmed@amazon.de>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <1472248536-2063-1-git-send-email-karahmed@amazon.de>
Cc: David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
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
        linux-pci@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <28aa68f6-7115-bc34-54a5-38d1995f157d@oracle.com>
Date: Mon, 29 Aug 2016 13:29:09 -0400
MIME-Version: 1.0
In-Reply-To: <1472248536-2063-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/26/2016 05:55 PM, KarimAllah Ahmed wrote:
> Ever since commit 254d1a3f02eb ("xen/pv-on-hvm kexec: shutdown watches
> from old kernel") using the INTx interrupt from Xen PCI platform device for
> event channel notification would just lockup the guest during bootup.
> postcore_initcall now calls xs_reset_watches which will eventually try to read
> a value from XenStore and will get stuck on read_reply at XenBus forever since
> the platform driver is not probed yet and its INTx interrupt handler is not
> registered yet. That means that the guest can not be notified at this moment of
> any pending event channels and none of the per-event handlers will ever be
> invoked (including the XenStore one) and the reply will never be picked up by
> the kernel.
>
> The exact stack where things get stuck during xenbus_init:
>
> -xenbus_init
>  -xs_init
>   -xs_reset_watches
>    -xenbus_scanf
>     -xenbus_read
>      -xs_single
>       -xs_single
>        -xs_talkv
>
> Vector callbacks have always been the favourite event notification mechanism
> since their introduction in commit 38e20b07efd5 ("x86/xen: event channels
> delivery on HVM.") and the vector callback feature has always been advertised
> for quite some time by Xen that's why INTx was broken for several years now
> without impacting anyone.
>
> Luckily this also means that event channel notification through INTx is
> basically dead-code which can be safely removed without impacting anybody since
> it has been effectively disabled for more than 4 years with nobody complaining
> about it (at least as far as I'm aware of).
>
> This commit removes event channel notification through Xen PCI platform device.
>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Juergen Gross <jgross@suse.com>
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
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>




