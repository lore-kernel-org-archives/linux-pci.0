Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:50434 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbcDGCKG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2016 22:10:06 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <imunsie@au1.ibm.com>;
	Thu, 7 Apr 2016 12:10:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0A0A82CE805E
	for <linux-pci@vger.kernel.org>; Thu,  7 Apr 2016 12:09:54 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3729j0X4981052
	for <linux-pci@vger.kernel.org>; Thu, 7 Apr 2016 12:09:53 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u37296Bh016455
	for <linux-pci@vger.kernel.org>; Thu, 7 Apr 2016 12:09:07 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: mikey <mikey@neuling.org>,
	Michael C Hollinger <mchollin@us.ibm.com>,
	Frederic Barrat <frederic.barrat@fr.ibm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
	gwshan <gwshan@linux.vnet.ibm.com>,
	Manoj Kumar <kumarmn@us.ibm.com>, paulus <paulus@samba.org>,
	"andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
	bhelgaas <bhelgaas@google.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4] powerpc/pci: Assign fixed PHB number based on device-tree properties
In-reply-to: <570584EF.1010904@linux.vnet.ibm.com>
References: <1458337746-20337-1-git-send-email-gpiccoli@linux.vnet.ibm.com> <1459971134-sup-6269@x230.ozlabs.ibm.com> <570584EF.1010904@linux.vnet.ibm.com>
Date: Wed, 06 Apr 2016 21:08:03 -0500
Message-Id: <1459994859-sup-3399@x230.ozlabs.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Excerpts from Guilherme G. Piccoli's message of 2016-04-06 16:51:43 -0500:
> And in the case a virtual PHB grabs the bitmap before, we just need to 
> add Michael's suggested check and fallback to bitmap PHB numbering in 
> this case.
> 
> Do you think this is enough to avoid issues with cxl'a virtual PHBs?

Yep, that should be fine :)

Cheers,
-Ian

