Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:51835 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbcCKNPR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2016 08:15:17 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 11 Mar 2016 23:15:14 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id A78C52CE8054
	for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2016 00:15:10 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u2BDF2Q843909324
	for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2016 00:15:10 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u2BDEa69032112
	for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2016 00:14:37 +1100
Date: Sat, 12 Mar 2016 00:14:19 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	mpe@ellerman.id.au, paulus@samba.org, imunsie@au1.ibm.com,
	mikey@neuling.org, andrew.donnellan@au1.ibm.com,
	bhelgaas@google.com
Subject: Re: [PATCH] powerpc/pci: Reuse PHB number on pci_controller add if
 available
Message-ID: <20160311131419.GA7911@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1457633505-19857-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1457633505-19857-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1457645698.24238.76.camel@kernel.crashing.org>
 <20160310231823.GA5270@gwshan>
 <1457693533.24238.99.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1457693533.24238.99.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 11, 2016 at 09:52:13PM +1100, Benjamin Herrenschmidt wrote:
>On Fri, 2016-03-11 at 10:18 +1100, Gavin Shan wrote:
>> However, PowerKVM guest doesn't have it. I guess it's a problem,
>> right?
>
>What is the number we use for the TCE h-calls ? I think it's from the
>first part of the dma window property no ?
>

Yeah, the BUID is PHB's identifier, but we only need the low 16-bits
as its base is 0x800000020000000ULL in QEMU or pHyp. I think other platforms
(like freescale's) still need dynamically allocated domain number, which
could be managed by a bitmap.

Thanks,
Gavin

>Cheers,
>Ben.
> 

