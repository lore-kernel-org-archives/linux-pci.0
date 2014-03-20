Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:41435 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755381AbaCTRc3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Mar 2014 13:32:29 -0400
Message-ID: <532B2628.5080305@codethink.co.uk>
Date: Thu, 20 Mar 2014 18:32:24 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
MIME-Version: 1.0
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@arm.linux.org.uk>,
	linux-sh@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Magnus Damm <damm@opensource.se>,
	Ben Dooks <ben-linux@fluff.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: DMABOUNCE in pci-rcar
References: <201402241200.21944.arnd@arndb.de> <5527822.QYtFYiIpiW@wuerfel> <532B137B.7010900@codethink.co.uk> <4884083.IuNl44Y6XD@wuerfel> <532B2485.6010005@codethink.co.uk> <20140320173106.GA19395@obsidianresearch.com>
In-Reply-To: <20140320173106.GA19395@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/03/14 18:31, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2014 at 06:25:25PM +0100, Ben Dooks wrote:
>> So doing:
>>
>> static void pci_rcar_fixup(struct pci_dev *dev)
>> {
>> 	if (dev->bus->ops == &rcar_pci_ops) {
>> 		dev_info(&dev->dev, "applying new dma mask\n");
>> 		dev->dma_mask = DMA_BIT_MASK(31);
>> 	}
>> }
>>
>> DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_rcar_fixup);
>>
>> Did not work for me :(
>
> Seems like it should work, do you have CONFIG_PCI_QUIRKS turned on?

Yes, see the print happening, just still PCI OHCI dies horribly.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
