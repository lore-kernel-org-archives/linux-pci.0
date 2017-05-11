Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 May 2017 14:20:34 +0200
From: Greg KH <greg@kroah.com>
To: Juergen Gross <jgross@suse.com>
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien.grall@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Anthony Liguori <aliguori@amazon.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [stable-4.11: PATCH] xen: revert commits 72a9b186292 and
 da72ff5bfcb0
Message-ID: <20170511122034.GC31947@kroah.com>
References: <20170508061247.19339-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170508061247.19339-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 08, 2017 at 08:12:47AM +0200, Juergen Gross wrote:
> Revert commit 72a9b186292 ("xen: Remove event channel notification
> through Xen PCI platform device") as the original analysis was wrong
> that all the removed code isn't in use any more. As commit da72ff5bfcb0
> ("partially revert xen: Remove event channel notification through Xen
> PCI platform device") reverted already some parts of it revert this
> commit, too.
> 
> It is still necessary for old Xen versions (< 4.0) and for being able
> to run the Linux kernel as dom0 in a nested Xen environment.
> 
> This is a backport of upstream commit 84d582d236dc1f9085e741affc72e9ba061a67c2

Now applied, thanks.

greg k-h
