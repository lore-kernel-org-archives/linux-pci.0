Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:33136 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbcBQEgr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2016 23:36:47 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
	Wed, 17 Feb 2016 14:36:44 +1000
Subject: Re: [PATCH v8 33/45] powerpc/powernv: Simplify pnv_eeh_reset()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-34-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, aik@ozlabs.ru,
	linux-pci@vger.kernel.org, grant.likely@linaro.org,
	robherring2@gmail.com, bhelgaas@google.com, dja@axtens.net
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-ID: <56C3F89F.4070505@au1.ibm.com>
Date: Wed, 17 Feb 2016 15:35:43 +1100
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-34-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 17/02/16 14:44, Gavin Shan wrote:
> This drops unnecessary nested if statements in pnv_eeh_reset() to
> improve the code readability. After the changes, the unused local
> variable "ret" is dropped as well. No logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

This looks good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited

