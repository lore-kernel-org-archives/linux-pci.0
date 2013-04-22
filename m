Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48065 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab3DVIGc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Apr 2013 04:06:32 -0400
Message-ID: <1366617867.2723.23.camel@pasglop>
Subject: Re: [PATCH] PowerNV/PCI: Fix NULL PCI controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, tglx@linutronix.de
Date: Mon, 22 Apr 2013 18:04:27 +1000
In-Reply-To: <5174E9C3.6080203@linux.vnet.ibm.com>
References: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
	 <1366612577.2723.21.camel@pasglop> <5174E9C3.6080203@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-04-22 at 15:41 +0800, Mike Qiu wrote:
> Anyway, I think it's better to remove the check code as it is useless,
> as it
> will shows that this "NULL" pci_controller pointer may happen...

Ok. It *might* still be worth adding a BUG_ON then in pci_bus_to_host()
itself ... no big deal either way.

Cheers,
Ben.


