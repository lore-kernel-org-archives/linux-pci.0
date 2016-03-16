Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp05.br.ibm.com ([32.104.18.26]:53010 "EHLO
	e24smtp05.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934605AbcCPOSl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2016 10:18:41 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Wed, 16 Mar 2016 11:18:39 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id 2FB1A1DC006F
	for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2016 10:18:32 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2GDGJ5r3604498
	for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2016 10:16:19 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2GEIZi0024795
	for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2016 11:18:36 -0300
Subject: Re: [PATCH v2] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1458082481-29916-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160316011715.GA4071@gwshan>
Cc: mikey@neuling.org, linux-pci@vger.kernel.org, paulus@samba.org,
	imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
	bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56E96B3B.50600@linux.vnet.ibm.com>
Date: Wed, 16 Mar 2016 11:18:35 -0300
MIME-Version: 1.0
In-Reply-To: <20160316011715.GA4071@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks very much for the comments Gavin! I agree with all of them, will 
rework the patch and send a new version.

Cheers,


Guilherme

