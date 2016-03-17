Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:40502 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030209AbcCQKrx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2016 06:47:53 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Thu, 17 Mar 2016 20:47:50 +1000
Subject: Re: [RFC PATCH v4 0/7] vfio-pci: Allow to mmap sub-page MMIO BARs and
 MSI-X table
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1457336918-3893-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <56E93ACC.7080403@linux.vnet.ibm.com> <20160316141013.GA21809@localhost>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
	aik@ozlabs.ru, alex.williamson@redhat.com,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	nikunj@linux.vnet.ibm.com
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <56EA8B14.4070808@linux.vnet.ibm.com>
Date: Thu, 17 Mar 2016 18:46:44 +0800
MIME-Version: 1.0
In-Reply-To: <20160316141013.GA21809@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/3/16 22:10, Bjorn Helgaas wrote:
> On Wed, Mar 16, 2016 at 06:51:56PM +0800, Yongji Xie wrote:
>> Ping.
> This is mainly VFIO stuff, and Alex had some security concerns, so I'm
> not going to spend much time looking at this until he's satisfied.
>
> When I do, I'll be looking hard at the resource_alignment kernel
> parameter.  I'm opposed to kernel parameters in general because
> they're very difficult for users to use correctly, and they lead to
> kernel code paths that are rarely tested and hard to maintain.  So
> I'll be looking for an excuse to reject changes in that area.
>
> The changelog for 2/7 says it "replaces IORESOURCE_STARTALIGN with
> IORESOURCE_WINDOW."  But even a glance at the patch itself shows that
> IORESOURCE_WINDOW is *added* to some places, and it doesn't *replace*
> IORESOURCE_STARTALIGN.

There is a problem with my statement. I mean we can use
IORESOURCE_WINDOW to identify bridge resources instead of
IORESOURCE_STARTALIGN here.

> The changelog for 4/7 says:
>
>    This is because vfio will not allow to passthrough one BAR's mmio
>    page which may be shared with other BARs.  To solve this performance
>    issue ...
>
> with no mention at all of the actual *reason* vfio doesn't allow that
> passthrough.  If I understand correctly, that reason has to do with
> security, so your justification must be much stronger than "solving a
> performance issue."

OK. I will try to make my justification become stronger.

Thanks,
Yongji Xie

