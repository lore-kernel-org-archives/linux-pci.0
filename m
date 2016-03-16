Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45451 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051AbcCPUnk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Mar 2016 16:43:40 -0400
Subject: Re: Need Help for How to write PCIe driver code
To: Prakash Kumar <prakash@cupolatechnology.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1139972788.98406.7686afab-169a-45f9-a3b8-d83acec2ad75.open-xchange@webmail.cupolatechnology.com>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <56E9C57B.6030600@ti.com>
Date: Wed, 16 Mar 2016 16:43:39 -0400
MIME-Version: 1.0
In-Reply-To: <1139972788.98406.7686afab-169a-45f9-a3b8-d83acec2ad75.open-xchange@webmail.cupolatechnology.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/15/2016 02:26 AM, Prakash Kumar wrote:
> Hi murli,

Murali not Murli :)

> 
> My name is prakash from cupola technology Bangalore ,India. currently i am trying to write the code of pcie driver for keystone II processor, so I need a sample code which describe the steps with APIs to write the driver code for keystone.
> 
> My setup is :
> 
> 1. I have a TI66AK2E02 MAC-K2 processor having PCIe connected to EDMA3 and DDR3 memory.
> 
> 2. I have another FPGAXC6SLX25T CSG324-2 xilinx chip ,which has PCIe connected to SRAM inside chip .
> 
> Now i have write the PCIe driver code which can transfer the data from DDR3 memory to SRAM (data transfer handled by EDMA3 )and vice-versa. 
> 
Checkout at Documentation/PCI/pci.txt for a quick intro. Could use PCI mailing list (linux-pci@vger.kernel.org) for help as well as
this is not a  keystone specific question. For Keystone specific question, please use the e2e forum at ti.com.

Murali
>  
> 
> With Best Regards,
> 
> Prakash Kumar
> 
> Cupola Technology Pvt Ltd
> 
>  Cell :+91 9738328394 | Skype: prakash.kumar995 
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
