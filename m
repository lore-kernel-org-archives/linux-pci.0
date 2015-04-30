Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:60100 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbbD3HzJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2015 03:55:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Pavel Fedin <p.fedin@samsung.com>
Cc: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>,
	'Jayachandran C' <jchandra@broadcom.com>,
	'Will Deacon' <Will.Deacon@arm.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, 'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'Sergey Dyasly' <s.dyasly@samsung.com>
Subject: Re: [RFC PATCH 1/2] PCI: generic: remove dependency on hw_pci
Date: Thu, 30 Apr 2015 09:55 +0200
Message-ID: <2123326.va7nY6tTq7@wuerfel>
In-Reply-To: <"00b001d08310$82022b40$860681c0$@fedin"@samsung.com>
References: <1430307599-20536-1-git-send-email-jchandra@broadcom.com> <20150429174356.GA20947@red-moon> <"00b001d08310$82022b40$860681c0$@fedin"@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 30 April 2015 09:40:10 Pavel Fedin wrote:
> > The other bit missing is MSI handling, that should still be implemented.
> 
>  Hello! I decided to have a voice here.
>  I am currently working on a virtualization project, and i have made some
> experimental additions to PCI-Generic code which enable PCI-X support. I
> wanted to upstream this, but as far as i can see, you are refactoring
> everything here.
>  Personally i think that pci_common_init_dev() is a good thing and it should
> not be removed. Even more, perhaps it needs to be expanded with PCI-X
> support. My current code adds a piece very similar to
> mvebu_pcie_msi_enable(), which reads "msi-parent" property and then calls
> of_pci_find_msi_chip_by_node().
>  MVEBU driver then fills in hw.msi_ctrl with the obtained pointer and calls
> pci_common_init(), which is the same as pci_common_init_dev(NULL, hw). My
> modified Generic driver now does the same. So, the question is - may be we
> should extract "msi-parent" handling from MVEBU and move it into
> pci_common_init_dev() ?
>  Just IMHO copy-pasting this function over and over again in all drivers is
> a bad idea.
> 
>  And one more. pci_common_init_dev() currently does not assign bus->msi,
> therefore IRQ domain operations do not work. I have fixed this too, but
> perhaps it's another story...

Hi Pavel,

There are a few problems with pci_common_init_dev() that we are solving
by not calling it:

- The interface is ARM specific, and not easily extended to other
  architectures that have requirements it does not handle today, and
  we definitely want to share host drivers between arm, arm64, mips
  and microblaze at least, probably most others in the long run.

- The lack of return code and error handling means it is not good for
  pci host drivers in loadable modules.

- The way that the interface registers multiple host bridges at the
  same time means that implementing that error handling is not possible
  without major changes.

The plan forward at this point is to move over all drivers in
drivers/pci/host to one of the architecture-independent interfaces.

There is a lot of work going on at the moment to improve those interfaces
to reduce code duplication and to make it as easy as possible to bring
up a PCI host controller though, and there are probably more things that
could be included there. 

	Arnd
