Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] xen: Remove event channel notification
 through Xen PCI platform device
To: KarimAllah Ahmed <karahmed@amazon.de>,
        <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
References: <1472248536-2063-1-git-send-email-karahmed@amazon.de>
CC: Juergen Gross <jgross@suse.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        <linux-pci@vger.kernel.org>, <x86@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julien Grall <julien.grall@citrix.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        David Vrabel <david.vrabel@citrix.com>,
        "Anthony Liguori" <aliguori@amazon.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>
From: David Vrabel <david.vrabel@citrix.com>
Message-ID: <57EE7AB7.4020405@citrix.com>
Date: Fri, 30 Sep 2016 15:46:15 +0100
MIME-Version: 1.0
In-Reply-To: <1472248536-2063-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26/08/16 22:55, KarimAllah Ahmed wrote:
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

Applied to for-linus-4.9, thanks.

David
