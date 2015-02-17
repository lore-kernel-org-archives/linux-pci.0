Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:47369 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbBQVpP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Feb 2015 16:45:15 -0500
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <stewart@linux.vnet.ibm.com>;
	Tue, 17 Feb 2015 14:45:15 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5F85CC40003
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 14:36:23 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1HLjLLa48037928
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 14:45:30 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1HLicZU006444
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2015 14:44:39 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v2 0/7] powerpc/powernv: Unified PCI slot reset and hotplug
In-Reply-To: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Wed, 18 Feb 2015 08:44:19 +1100
Message-ID: <m3vbj0gqmk.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> The patchset was built based on patchset "powerpc/powernv: Simplify EEH
> implementation", which can be found from:
>
> https://patchwork.ozlabs.org/patch/439956/
>
> The patchset corresponds to skiboot changes, which manages PCI slots
> in a unified way: OPAL APIs used to do slot reset, power management,
> presence status retrival. The patchset shouldn't be merged before
> the OPAL firmware counterpart is merged:
>
> https://patchwork.ozlabs.org/patch/440463/

But this patchset will work with old OPAL, right? We're not breaking
compatibility with newer kernels (with this patchset) and older
firmware?

