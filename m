Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp01.br.ibm.com ([32.104.18.85]:33204 "EHLO
	e24smtp01.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030206AbbKDMA1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 07:00:27 -0500
Received: from /spool/local
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 10:00:25 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id 397A43520079
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2015 06:59:08 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tA4C0mOT3760142
	for <linux-pci@vger.kernel.org>; Wed, 4 Nov 2015 10:00:49 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tA4C0GZ0010913
	for <linux-pci@vger.kernel.org>; Wed, 4 Nov 2015 10:00:18 -0200
Subject: Re: [PATCH] Enable MSI/MSI-X caps and disable MSI interrupts at PCI
 probe time - code move
To: bhelgaas@google.com
References: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
	mst@redhat.com, shangw@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5639F34F.5020402@linux.vnet.ibm.com>
Date: Wed, 4 Nov 2015 10:00:15 -0200
MIME-Version: 1.0
In-Reply-To: <1445437055-7017-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn, ping?

