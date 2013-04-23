Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46901 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346Ab3DWBtc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Apr 2013 21:49:32 -0400
Message-ID: <1366681750.2886.10.camel@pasglop>
Subject: Re: [PATCH] PowerNV/PCI: Fix NULL PCI controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 23 Apr 2013 11:49:10 +1000
In-Reply-To: <1366681602.1654.8.camel@localhost.localdomain>
References: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
	 <1366612577.2723.21.camel@pasglop> <5174E9C3.6080203@linux.vnet.ibm.com>
	 <1366617867.2723.23.camel@pasglop> <5175067F.3030307@linux.vnet.ibm.com>
	 <CAErSpo4Y0zkWDsyJi47awtz67oWO4Qj+J4mDA3B0cfaYx_v_VQ@mail.gmail.com>
	 <1366681602.1654.8.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-04-22 at 21:46 -0400, Mike Qiu wrote:
> 
> So I suggest either use my patch or remove that check code.
> If the second case, I will write v2 patch to remove that check code.
> I don't know what's to go for next step, it depends on the
> maintainer :)

Please do.

Cheers,
Ben.


