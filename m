Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59368 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751733Ab3JHHco (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 03:32:44 -0400
Date: Tue, 8 Oct 2013 09:32:40 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Seungwon Jeon <tgih.jun@samsung.com>
Subject: Re: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link
 is up to enable hot plug
Message-ID: <20131008093240.15ec78ee@skate>
In-Reply-To: <CAErSpo6pvAQ9exEUsB0p8nmoqs0s5yzfYsstx7wh-2bqDtzBOQ@mail.gmail.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
	<CAErSpo6pvAQ9exEUsB0p8nmoqs0s5yzfYsstx7wh-2bqDtzBOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Mon, 7 Oct 2013 16:28:52 -0600, Bjorn Helgaas wrote:

> I see the following mvebu patches in patchwork:
> 
>   PCI: mvebu: Dynamically detect if the PEX link is up to enable hot plug

This one got my Acked-by, see <20131003144457.4131aea3@skate>.

>   PCI: mvebu - Support a bridge with no IO port window

This one has issues, as I reported to Jason Gunthorpe.

>   PCI: mvebu: add I/O access wrappers

I need to test this one.

Jason Cooper will confirm, but my understanding is that for the 3.13,
he wanted to merge all the pci-mvebu patches, because he already has
MSI related changes (that span PCI and irqchip drivers). Of course, if
you agree with this.

But indeed, this means that Jason C. should also take care of all other
pci-mvebu patches :)

Jason C, do not hesitate to ping me if you need testing/confirmation on
some pci-mvebu patches I might have overlooked.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
