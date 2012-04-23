Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:52091 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751638Ab2DWQOu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 Apr 2012 12:14:50 -0400
Message-ID: <4F958019.1020009@xenotime.net>
Date: Mon, 23 Apr 2012 09:15:21 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
MIME-Version: 1.0
To: Onkar N Mahajan <kernzap@gmail.com>
CC: linux-pci <linux-pci@vger.kernel.org>
Subject: Re: meaning of macros PCI_PROBE_CONF1|2
References: <1335164030.12240.4.camel@oc4748611672.ibm.com>
In-Reply-To: <1335164030.12240.4.camel@oc4748611672.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/22/2012 11:53 PM, Onkar N Mahajan wrote:

> I was searching for the meaning of Macros - PCI_PROBE_NOEARLY,
> PCI_PROBE_MMCONF, PCI_PROBE_CONF1 and PCI_PROBE_CONF2 , these are
> defined in linux/arch/x86/include/asm/pci_x86.h. I tried Googling 
> but found nothing but browser cross-references. 


These values are just bit flags that control which type(s) of
PCI probing are going to be used.  They are used to set values
in the variable

unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
				PCI_PROBE_MMCONF;

in arch/x86/pci/common.c.  This file also has code that parses the
kernel's boot command line to check if PCI probing control options
are used on it.  If so, the 'pci_probe' variable is updated according
to the options on the command line.  Some command-line options also
depend on various Kconfig options being enabled.


> Please help me with some hints to start with. 



-- 
~Randy
