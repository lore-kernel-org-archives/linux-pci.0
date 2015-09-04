Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:48543 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933994AbbIDXRV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Sep 2015 19:17:21 -0400
Received: from /spool/local
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Fri, 4 Sep 2015 20:17:17 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 161921DC0084
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2015 19:16:13 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t84NHdVb4952126
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2015 20:17:40 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t84NHCIY000927
	for <linux-pci@vger.kernel.org>; Fri, 4 Sep 2015 20:17:14 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
 probe time in OF case
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20150903175624.GI829@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
	benh@kernel.crashing.org, paulus@samba.org, mst@redhat.com,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"David S. Miller" <davem@davemloft.net>
Message-ID: <55EA2678.5030801@linux.vnet.ibm.com>
Date: Fri, 4 Sep 2015 20:17:12 -0300
MIME-Version: 1.0
In-Reply-To: <20150903175624.GI829@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

> of_create_pci_dev() already has a lot of code that duplicates
> pci_setup_device(), and it's a shame to add more.  There's also a sparc
> version of of_create_pci_dev() that presumably has the same problem you're
> fixing for powerpc.

Thanks for the information!

> Michael originally called pci_msi_setup_pci_dev() from
> pci_init_capabilities() [1].  A subsequent patch moved the call
> to pci_setup_device() [2] because an early quirk (called from
> pci_setup_device()) used pci_msi_off(), which depended on
> pci_msi_setup_pci_dev().
>
> But we later removed pci_msi_off() completely, so I think we probably
> *could* call pci_msi_setup_pci_dev() from pci_init_capabilities().
>
> That would be much nicer because it makes more sense there, and it
> would do the right thing for powerpc and sparc because they both
> already use that path.
>
> Can you look into moving the call?

I might have misunderstood something here (sorry if it's the case), but 
moving the call to pci_init_capabilities() has the same practical 
implications than reverting my 2 commmits [1] [2] and Michael Tsirkin's 
commit [3], except when CONFIG_PCI_MSI is not set - in this case, moving 
the call would initialize MSI capabilities anyway, since 
pci_init_capabilities() executes even if CONFIG_PCI_MSI isn't set.

My question is: is necessary to initialize MSI capabilities even with 
CONFIG_PCI_MSI not set? In negative case, would be "cleaner" revert the 
3 commits, right?

On the other hand, if it's necessary to initialize MSI capabilities on 
devices anyway, we can change the call place.

Let me know your opinion, and I'm sorry if I misunderstood something here.

Cheers,


Guilherme Piccoli



[1] commit 22b6839b914b ("PCI: Make pci_msi_setup_pci_dev() non-static 
for use by arch code")

[2] commit 4d9aac397a5d ("powerpc/PCI: Disable MSI/MSI-X interrupts at 
PCI probe time in OF case")

[3] commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if 
kernel doesn't support MSI")

