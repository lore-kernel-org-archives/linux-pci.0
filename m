Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54517 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3LCBPJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2013 20:15:09 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Joe Perches' <joe@perches.com>,
	'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
 <003b01ceefb6$bca43ed0$35ecbc70$%han@samsung.com>
 <1386028330.15309.13.camel@joe-AO722>
In-reply-to: <1386028330.15309.13.camel@joe-AO722>
Subject: Re: [PATCH 38/39] PCI: remove DEFINE_PCI_DEVICE_TABLE macro
Date: Tue, 03 Dec 2013 10:15:06 +0900
Message-id: <003e01ceefc5$1a6f9880$4f4ec980$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 03, 2013 8:52 AM, Joe Perches wrote:
> On Tue, 2013-12-03 at 08:32 +0900, Jingoo Han wrote:
> > Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
> > is not preferred. Also, the definition of DEFINE_PCI_DEVICE_TABLE
> > macro is removed.
> 
> These sorts of treewide conversions are almost never
> applied wholesale.
> 
> This patch is not appropriate until there are no more
> uses of DEFINE_PCI_DEVICE_TABLE in Linus' tree.
> 
> Just marking the function as deprecated in the
> documentation and the pci.h file is probably good
> enough for now.
> 
> see:  http://lkml.org/lkml/2013/12/2/400

Actually, I want to remove all DEFINE_PCI_DEVICE_TABLEs from the
next 3.14-rc1 kernel, by merging all patches through Greg's tree.

Greg,
How about you?

Best regards,
Jingoo Han

