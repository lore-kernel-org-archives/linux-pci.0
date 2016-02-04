Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:53098 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbcBDLOO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 06:14:14 -0500
Subject: Re: [PATCH v7 2/2] add new platform driver for PCI RC
To: Bjorn Helgaas <helgaas@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1454349430.git.jpinto@synopsys.com>
 <10b29adcdb0a31eb8f8071b271da267e44ad8a04.1454349430.git.jpinto@synopsys.com>
 <8223655.W63T0XOVm1@wuerfel> <20160203180514.GA10879@localhost>
 <56B242F0.6040704@synopsys.com> <20160203183844.GC10879@localhost>
CC: Arnd Bergmann <arnd@arndb.de>, <Vineet.Gupta1@synopsys.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B33278.3000408@synopsys.com>
Date: Thu, 4 Feb 2016 11:14:00 +0000
MIME-Version: 1.0
In-Reply-To: <20160203183844.GC10879@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2/3/2016 6:38 PM, Bjorn Helgaas wrote:
> On Wed, Feb 03, 2016 at 06:12:00PM +0000, Joao Pinto wrote:
>> Hi Bjorn,
>>
>> Are these tasks enough?
>>
>> - replace mdelay() for msleep()
>> - remove synopsys_pcie_irq_handler()
> 
> Above are fine with me.

Ok, I'll to that.

Thanks.
