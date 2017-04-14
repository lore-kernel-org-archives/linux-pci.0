Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39082 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbdDNN73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2017 09:59:29 -0400
Subject: Re: [stable-4.9: PATCH] xen: revert commit 72a9b186292
To: Greg KH <greg@kroah.com>, Juergen Gross <jgross@suse.com>
References: <20170413130653.5183-1-jgross@suse.com>
 <20170414091720.GB6372@kroah.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <d17d56ce-4ea2-abef-a20d-f7e31a9a06bf@oracle.com>
Date: Fri, 14 Apr 2017 09:58:54 -0400
MIME-Version: 1.0
In-Reply-To: <20170414091720.GB6372@kroah.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/14/2017 05:17 AM, Greg KH wrote:
> On Thu, Apr 13, 2017 at 03:06:53PM +0200, Juergen Gross wrote:
>> Revert commit 72a9b186292 ("xen: Remove event channel notification
>> through Xen PCI platform device") as the original analysis was wrong
>> that all the removed code isn't in use any more.
>>
>> It is still necessary for old Xen versions (< 4.0) and for being able
>> to run the Linux kernel as dom0 in a nested Xen environment.
> What is the commit id of this revert in Linus's tree?

It hasn't been reverted in Linus tree yet --- there were some changes in
Xen code in 4.11 that make the revert not a mechanical operation and we
are somewhat hesitant to have a patch this late in the release cycle.

-boris
