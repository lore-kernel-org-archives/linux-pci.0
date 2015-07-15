Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:46890 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbbGOBqd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 21:46:33 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 15 Jul 2015 11:46:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7CD8F2BB0055
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 11:46:28 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6F1kJgC32899300
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 11:46:28 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6F1jtBj031264
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2015 11:45:55 +1000
Date: Wed, 15 Jul 2015 09:45:38 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI: Remove useless redundant code
Message-ID: <20150715014538.GB6525@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150714220118.21427.99172.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150714220118.21427.99172.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 14, 2015 at 05:01:18PM -0500, Bjorn Helgaas wrote:
>Remove redundant code from __pci_bus_find_cap_start().  No functional
>change.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Wei Yang <weiyang@linux.vnet.ibm.com>

>---
> drivers/pci/pci.c |    2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 29b5605..359b954 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -195,8 +195,6 @@ static int __pci_bus_find_cap_start(struct pci_bus *bus,
> 		return PCI_CAPABILITY_LIST;
> 	case PCI_HEADER_TYPE_CARDBUS:
> 		return PCI_CB_CAPABILITY_LIST;
>-	default:
>-		return 0;
> 	}
>
> 	return 0;

-- 
Richard Yang
Help you, Help me

