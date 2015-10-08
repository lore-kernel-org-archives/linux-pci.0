Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp01.br.ibm.com ([32.104.18.85]:53901 "EHLO
	e24smtp01.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934148AbbJHQFo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 12:05:44 -0400
Received: from /spool/local
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Thu, 8 Oct 2015 13:05:41 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8BDD81DC007E
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2015 12:04:34 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t98G3s7n10355128
	for <linux-pci@vger.kernel.org>; Thu, 8 Oct 2015 13:03:54 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t98G5ZEr013169
	for <linux-pci@vger.kernel.org>; Thu, 8 Oct 2015 13:05:36 -0300
Subject: Re: [PATCH v2 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI
 probe time in OF case
To: Bjorn Helgaas <bhelgaas@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>
References: <1439932430-13375-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1439932077-11427-3-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1440010450-4549-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20150903175624.GI829@google.com> <55EA2678.5030801@linux.vnet.ibm.com>
 <20150906173838-mutt-send-email-mst@redhat.com>
 <1441595823.12945.4.camel@ellerman.id.au> <20150915161821.GB25767@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
	paulus@samba.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"David S. Miller" <davem@davemloft.net>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5616944F.6090608@linux.vnet.ibm.com>
Date: Thu, 8 Oct 2015 13:05:35 -0300
MIME-Version: 1.0
In-Reply-To: <20150915161821.GB25767@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/15/2015 01:18 PM, Bjorn Helgaas wrote:
> We could also argue that when CONFIG_PCI_MSI=n, dev->msi[x]_cap should not
> even exist, so we could catch that a build-time instead of run-time.  My
> personal opinion is that it's not a big deal, and the existing code that
> includes dev->msi[x]_cap and initializes it even when CONFIG_PCI_MSI=n
> allows some useful code sharing.

Nice Bjorn, so let's follow your idea regarding moving the code of MSI 
capabilities initialization to allow some code sharing. It's good option 
specially since it avoids the same problem (MSI capabilities not 
found)to occur in SPARC arch too.

Sorry for my delay in response, soon I'll send the patch to the list.

Cheers,


Guilherme

