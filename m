Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34667 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbbGOB5F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 21:57:05 -0400
MIME-Version: 1.0
In-Reply-To: <20150714223537.GQ24416@google.com>
References: <1436300428-21163-1-git-send-email-yinghai@kernel.org>
	<1436300428-21163-36-git-send-email-yinghai@kernel.org>
	<20150714223537.GQ24416@google.com>
Date: Tue, 14 Jul 2015 18:57:03 -0700
Message-ID: <CAE9FiQWhFA3BCY0-oEUBrAU9SMycJZofpGQip3RQVt3UBAvwCw@mail.gmail.com>
Subject: Re: [PATCH 35/42] x86, boot, PCI: Convert SETUP_PCI data to list
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 14, 2015 at 3:35 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index 16ace12..32d4f21 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>
>> +struct firmware_setup_pci_entry {
>> +     struct list_head list;
>> +     uint16_t vendor;
>> +     uint16_t devid;
>> +     uint64_t pcilen;
>
> Is there a reason to use uint16_t and uint64_t instead of u16 and u64?

keep them same as arch/x86/include/asm/pci.h::pci_setup_rom.

and we have that from:

commit dd5fc854de5fd37adfcef8a366cd21a55aa01d3d
Author: Matthew Garrett <mjg@redhat.com>
Date:   Wed Dec 5 14:33:26 2012 -0700

    EFI: Stash ROMs if they're not in the PCI BAR

    EFI provides support for providing PCI ROMs via means other than the ROM
    BAR. This support vanishes after we've exited boot services, so add support
    for stashing copies of the ROMs in setup_data if they're not otherwise
    available.

    Signed-off-by: Matthew Garrett <mjg@redhat.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Tested-by: Seth Forshee <seth.forshee@canonical.com>

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index 6e41b93..dba7805 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -171,4 +171,16 @@ cpumask_of_pcibus(const struct pci_bus *bus)
 }
 #endif

+struct pci_setup_rom {
+       struct setup_data data;
+       uint16_t vendor;
+       uint16_t devid;
+       uint64_t pcilen;
+       unsigned long segment;
+       unsigned long bus;
+       unsigned long device;
+       unsigned long function;
+       uint8_t romdata[0];
+};
+
 #endif /* _ASM_X86_PCI_H */
