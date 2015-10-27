Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:44982 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbJ0FJV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 01:09:21 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
	Tue, 27 Oct 2015 15:09:18 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7AF97357805A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 16:09:16 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9R598pk27852984
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 16:09:16 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9R58hgv007820
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 16:08:44 +1100
Message-ID: <562F050F.5050405@au1.ibm.com>
Date: Tue, 27 Oct 2015 16:01:03 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru
CC: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V10 03/12] powerpc/pci: Cache VF index in pci_dn
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com> <1445829362-2738-4-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445829362-2738-4-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26/10/15 14:15, Wei Yang wrote:
> The patch caches the VF index in pci_dn, which can be used to calculate
> VF's bus, device and function number. Those information helps to locate
> the VF's PCI device instance when doing hotplug during EEH recovery if
> necessary.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

