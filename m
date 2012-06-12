Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47893 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751758Ab2FLP2Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jun 2012 11:28:24 -0400
Received: by lahd3 with SMTP id d3so3603557lah.19
        for <linux-pci@vger.kernel.org>; Tue, 12 Jun 2012 08:28:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4fd6b2f9.DIqCg1uo2Kq4VZd4%wfg@linux.intel.com>
References: <4fd6b2f9.DIqCg1uo2Kq4VZd4%wfg@linux.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 12 Jun 2012 09:28:03 -0600
Message-ID: <CAErSpo4J6e=uXwSoh1P_wME5DeetRsBzm=En5C94E+Usu8ce2w@mail.gmail.com>
Subject: =?windows-1252?Q?Re=3A_include=2Flinux=2Fpci=2Eh=3A1495=3A2=3A_error=3A_implicit_decl?=
	=?windows-1252?Q?aration_of_function_=91pci=5Fdev=5Fget=92_=5B=2DWerror=3Dimplicit=2Dfunc?=
	=?windows-1252?Q?tion=2Ddeclaration=5D?=
To: wfg@linux.intel.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 11, 2012 at 9:09 PM,  <wfg@linux.intel.com> wrote:
> FYI, kernel build failed on
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> head:   0c358c16f8154ef47df749e60186f3c835869b0b
> commit: 470bc5b483f573f3bec802afc32109463e8c99c8 [45/60] PCI: add PCI DMA source ID quirk
> config: i386-allnoconfig (attached as .config)
>
> All related error/warning messages are:
>
> include/linux/pci.h: In function ‘pci_get_dma_source’:
> include/linux/pci.h:1495:2: error: implicit declaration of function ‘pci_dev_get’ [-Werror=implicit-function-declaration]

I folded in Alex's fix for this.  Will appear in "next" later today.
Thanks for the report!
