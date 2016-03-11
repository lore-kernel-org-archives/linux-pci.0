Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp01.br.ibm.com ([32.104.18.85]:33385 "EHLO
	e24smtp01.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbcCKNaC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2016 08:30:02 -0500
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Fri, 11 Mar 2016 10:30:00 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp02.br.ibm.com (Postfix) with ESMTP id E60361DC006F
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 08:29:50 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2BCTRSc5964088
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 09:29:27 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2BDTsUA010208
	for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2016 08:29:55 -0500
Subject: Re: [PATCH] powerpc/pci: Reuse PHB number on pci_controller add if
 available
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1457633505-19857-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1457633505-19857-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1457645698.24238.76.camel@kernel.crashing.org>
 <20160310231823.GA5270@gwshan>
 <1457693533.24238.99.camel@kernel.crashing.org>
 <20160311131419.GA7911@gwshan>
Cc: mikey@neuling.org, paulus@samba.org, imunsie@au1.ibm.com,
	andrew.donnellan@au1.ibm.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56E2C852.40508@linux.vnet.ibm.com>
Date: Fri, 11 Mar 2016 10:29:54 -0300
MIME-Version: 1.0
In-Reply-To: <20160311131419.GA7911@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/11/2016 10:14 AM, Gavin Shan wrote:
> Yeah, the BUID is PHB's identifier, but we only need the low 16-bits
> as its base is 0x800000020000000ULL in QEMU or pHyp. I think other platforms
> (like freescale's) still need dynamically allocated domain number, which
> could be managed by a bitmap.

Thanks very much for the suggestions Benjamin and Gavin.
Will improve the patch and send a v2.

Cheers,


Guilherme

