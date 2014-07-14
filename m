Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37503 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631AbaGNDMY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 13 Jul 2014 23:12:24 -0400
Message-ID: <1405307520.9343.10.camel@pasglop>
Subject: Re: [RFC PATCH V3 06/17] ppc/pnv: allocate pe->iommu_table
 dynamically
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'Wei Yang'" <weiyang@linux.vnet.ibm.com>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
	"qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"yan@linux.vnet.ibm.com" <yan@linux.vnet.ibm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 14 Jul 2014 13:12:00 +1000
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <1402365399-5121-7-git-send-email-weiyang@linux.vnet.ibm.com>
	 <53A94DA8.6020206@ozlabs.ru> <20140625011211.GA5785@richard>
	 <53AA4C32.7060004@ozlabs.ru> <20140625052758.GA8873@richard>
	 <063D6719AE5E284EB5DD2968C1650D6D17264AD8@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-06-25 at 09:20 +0000, David Laight wrote:
> What are the sizes of the iommu table and the PE structure? 
> If the table is a round number of pages then you probably don't want
> to embed it inside the PE structure. 

The problem isn't the table itself but the struct iommu_table which
contains the pointer to the actual table and various other bits of
controlling state.

Cheers,
Ben.



