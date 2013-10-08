Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59883 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab3JHOmN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 10:42:13 -0400
Date: Tue, 8 Oct 2013 15:42:11 +0100
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Michal Simek <monstr@monstr.eu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC] Architecture independent pcibios?
Message-ID: <20131008144211.GA25231@e102652-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I am working on adding PCIe support for a new architecture and looking
at various existing implementations of pcibios functions I've realised
that some architectures share a lot of common code. As I don't like to
repeat the pattern again without any good reasons, I am wondering if
there is any appetite for carving out those common functions into
a generic place under drivers/pci/pcibios.c where they can be reused.

Things that I am specifically looking at are pcibios_{alloc,free}_controller,
pci_process_bridge_OF_ranges and anything that will make adding support
for PCI/PCIe in a new architecture easier. Candidates for promoting
to a generic place are the functions found in both powerpc and microblaze
as they seem to be mostly identical, they support DT bindings and are
64bits ready.

Any comments on why that is (possibly not) a great idea and on the chance
that a patch will get reviewed/accepted?

Best regards,
Liviu Dudau

ARM Ltd Linux Platforms engineer

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

