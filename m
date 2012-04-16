Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35955 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2DPQCo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 12:02:44 -0400
Received: by dake40 with SMTP id e40so7099736dak.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Apr 2012 09:02:44 -0700 (PDT)
Subject: pci_check_type2() help.
From: Onkar N Mahajan <kernzap@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 16 Apr 2012 21:32:40 +0530
Message-ID: <1334592160.26350.13.camel@oc4748611672.ibm.com>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello list, 

I am trying to understand the PCI functionality in Linux kernel. 
What is the best way to start to understanding this - where to start 
in the kernel code ? Books ? Manuals ? 

I started reading the code - where I am stuck in this function -
pci_check_type2() ; Wherein I am not able to get from where these values
0xCFB,0xCF8,0xCFA are arrived at ? I guess these are port numbers , but 
in which manuals can I find this all information. 

linux/arch/x86/pci/init.c: 
static int __init pci_check_type2(void)
{
    unsigned long flags;
    int works = 0;

    local_irq_save(flags);

    outb(0x00, 0xCFB);
    outb(0x00, 0xCF8);
    outb(0x00, 0xCFA);
    if (inb(0xCF8) == 0x00 && inb(0xCFA) == 0x00 &&
        pci_sanity_check(&pci_direct_conf2)) {
        works = 1;
    }

    local_irq_restore(flags);

    return works;
}


Please help me figuring out right manuals for this. 


-- Onkar




