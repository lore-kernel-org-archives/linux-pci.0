Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:58675 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbcEZBAX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 May 2016 21:00:23 -0400
Message-ID: <1464224420.31009.0.camel@ellerman.id.au>
Subject: Re: [v4] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, linux-pci@vger.kernel.org,
	gwshan@linux.vnet.ibm.com, paulus@samba.org, imunsie@au1.ibm.com,
	andrew.donnellan@au1.ibm.com, bhelgaas@google.com
Date: Thu, 26 May 2016 11:00:20 +1000
In-Reply-To: <201605251303.u4PCx7bK033656@mx0a-001b2d01.pphosted.com>
References: <3qWdQC0MVDz9s9Y@ozlabs.org>
	 <56F9255A.1040900@linux.vnet.ibm.com>
	 <1464155117.8573.2.camel@ellerman.id.au>
	 <201605251303.u4PCx7bK033656@mx0a-001b2d01.pphosted.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-05-25 at 10:03 -0300, Guilherme G. Piccoli wrote:
> On 05/25/2016 02:45 AM, Michael Ellerman wrote:
> > 
> > Yeah please increase the bitmap size to 65536. It will only take 8KB of memory,
> > which is negligible.
> 
> Well, since I sent a v6 and you replied there too, I guess we can 
> continue our iterations there - mostly suggestions (all except one) you 
> gave here were implemented in v6.

Yeah sorry, I'm very behind on email :)

cheers

