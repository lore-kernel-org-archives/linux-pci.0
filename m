Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:38918 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbbJ0Bca (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2015 21:32:30 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
	Tue, 27 Oct 2015 11:32:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9DEE02CE8057
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 12:32:26 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9R1W4Jq11403444
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 12:32:12 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9R1VqpZ021000
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 12:31:53 +1100
Message-ID: <562ED40E.1050007@au1.ibm.com>
Date: Tue, 27 Oct 2015 12:31:58 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru
CC: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V10 01/12] PCI/IOV: Rename and export virtfn_add/virtfn_remove
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com> <1445829362-2738-2-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445829362-2738-2-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26/10/15 14:15, Wei Yang wrote:
> During EEH recovery, hotplug is applied to the devices which don't
> have drivers or their drivers don't support EEH. However, the hotplug,
> which was implemented based on PCI bus, can't be applied to VF directly.
>
> The patch renames virtn_{add,remove}() and exports them so that they
> can be used in PCI hotplug during EEH recovery.
>
> [gwshan: changelog]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

