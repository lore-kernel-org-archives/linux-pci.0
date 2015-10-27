Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:49447 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbbJ0FIG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2015 01:08:06 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
	Tue, 27 Oct 2015 15:08:03 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id CD3262CE8052
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 16:07:59 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9R57bfw25952454
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 16:07:46 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9R57Q4g005714
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2015 16:07:27 +1100
Message-ID: <562F0696.4030404@au1.ibm.com>
Date: Tue, 27 Oct 2015 16:07:34 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru
CC: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V10 02/12] PCI: Add pcibios_bus_add_device() weak function
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com> <1445829362-2738-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445829362-2738-3-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26/10/15 14:15, Wei Yang wrote:
> This patch adds a weak function pcibios_bus_add_device() for arch dependent
> code could do proper setup. For example, powerpc could setup EEH related
> resources.
>
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

