Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:52514 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbKXVZj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2015 16:25:39 -0500
Received: from localhost
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Tue, 24 Nov 2015 19:25:37 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 90E583520066
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2015 16:25:30 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tAOLNbgI11731406
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2015 19:23:37 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tAOLPV98030745
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2015 19:25:32 -0200
Subject: Re: [PATCH] Enable MSI/MSI-X caps and disable MSI interrupts at PCI
 probe time - code move
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <5639F34F.5020402@linux.vnet.ibm.com> <20151124212341.GC17377@localhost>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	paulus@samba.org, benh@kernel.crashing.org, mst@redhat.com,
	shangw@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5654D5CA.4000607@linux.vnet.ibm.com>
Date: Tue, 24 Nov 2015 19:25:30 -0200
MIME-Version: 1.0
In-Reply-To: <20151124212341.GC17377@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/24/2015 07:23 PM, Bjorn Helgaas wrote:
> On Wed, Nov 04, 2015 at 10:00:15AM -0200, Guilherme G. Piccoli wrote:
>> Bjorn, ping?
>
> Sorry, Guilherme, this dropped off my radar, and I can't remember why.
> I'll take a look at it soon.
>
> Bjorn
>

Thanks very much Bjorn!
Sorry to bother, by the way.

Cheers,


Guilherme

