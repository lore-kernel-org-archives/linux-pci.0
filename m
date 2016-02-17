Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:57238 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965104AbcBQETp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 23:19:45 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
	Wed, 17 Feb 2016 14:19:43 +1000
Subject: Re: [PATCH v8 03/45] powerpc/pci: Cleanup on struct
 pci_controller_ops
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-4-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, grant.likely@linaro.org,
	robherring2@gmail.com, bhelgaas@google.com, dja@axtens.net
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56C3F4A2.1010909@au1.ibm.com>
Date: Wed, 17 Feb 2016 15:18:42 +1100
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17/02/16 14:43, Gavin Shan wrote:
> Each PHB has one instance of "struct pci_controller_ops", which
> includes various callbacks called by PCI subsystem. In the definition
> of this struct, some callbacks have explicit names for its arguments,
> but the left don't have.
>
> This adds all explicit names of the arguments to the callbacks in
> "struct pci_controller_ops" so that the code looks consistent.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

