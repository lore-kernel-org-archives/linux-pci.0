Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52639 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752735AbdDRN4P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Apr 2017 09:56:15 -0400
Subject: Re: [stable-4.10: PATCH] xen: revert commits 72a9b186292 and
 da72ff5bfcb0
To: Greg KH <greg@kroah.com>
References: <20170413144949.4295-1-jgross@suse.com>
 <20170413162458.GA5676@kroah.com>
 <82b08730-4672-07aa-6c42-9d77ad4ac8ae@suse.com>
 <20170413165554.GA8378@kroah.com> <20170418135211.GA20659@kroah.com>
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
From: Juergen Gross <jgross@suse.com>
Message-ID: <2ab64334-d8cd-5594-112b-42c0bd7e4d2d@suse.com>
Date: Tue, 18 Apr 2017 15:56:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170418135211.GA20659@kroah.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18/04/17 15:52, Greg KH wrote:
> On Thu, Apr 13, 2017 at 06:55:54PM +0200, Greg KH wrote:
>> On Thu, Apr 13, 2017 at 06:28:33PM +0200, Juergen Gross wrote:
>>> On 13/04/17 18:24, Greg KH wrote:
>>>> On Thu, Apr 13, 2017 at 04:49:49PM +0200, Juergen Gross wrote:
>>>>> Revert commit 72a9b186292 ("xen: Remove event channel notification
>>>>> through Xen PCI platform device") as the original analysis was wrong
>>>>> that all the removed code isn't in use any more. As commit da72ff5bfcb0
>>>>> ("partially revert xen: Remove event channel notification through Xen
>>>>> PCI platform device") reverted already some parts of it revert this
>>>>> commit, too.
>>>>>
>>>>> It is still necessary for old Xen versions (< 4.0) and for being able
>>>>> to run the Linux kernel as dom0 in a nested Xen environment.
>>>>
>>>> Is there a commit in Linus's tree that matches this revert as well?
>>>
>>> Not yet. I'm working on it.
>>
>> I'd prefer to take the same exact commit please.  That way nothing
>> diverges here.
> 
> Especially as you are asking to revert patches that are already in
> releases and have been out for a while.  Always get fixes into Linus's
> tree first, and _then_ we can add them to stable releases.
> 
> I'm dropping this request, and the one for 4.9, from my stable "todo"
> list.

Okay. I'll come back when the revert is in Linus' tree.

Sorry for the noise,


Juergen
