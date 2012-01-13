Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58584 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308Ab2AMQlL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Jan 2012 11:41:11 -0500
Received: from /spool/local
	by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Fri, 13 Jan 2012 11:41:10 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q0DGddPc281660
	for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2012 11:39:40 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q0DGdaNY024289
	for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2012 14:39:39 -0200
Date: Sat, 14 Jan 2012 00:39:22 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: Try to assign required+option size at first
Message-ID: <20120113163922.GH7380@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1323247984-15281-1-git-send-email-yinghai@kernel.org>
 <1323247984-15281-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323247984-15281-3-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 07, 2011 at 12:53:01AM -0800, Yinghai Lu wrote:
> Found reassign can not find right range for one resource. even total range is enough.
> 
> bridge b1:02.0 will need 2M+3M
> bridge b1:03.0 will need 2M+3M
> 
> so bridge b0:00.0 will get assigned: 4M : [f8000000-f83fffff]
>    later is reassigned to 10M : [f8000000-f9ffffff]
> 
> b1:02.0 is assigned to 2M : [f8000000-f81fffff]
> b1:03.0 is assigned to 2M : [f8200000-f83fffff]
> 
> after that b1:03.0 get chance to be reassigned to [f8200000-f86fffff]
> but b1:02.0 will not have chance to expand, because b1:03.0 is using in middle one.
> 
> [  187.911401] pci 0000:b1:02.0: bridge window [mem 0x00100000-0x002fffff] to [bus b2-b2] add_size 300000
> [  187.920764] pci 0000:b1:03.0: bridge window [mem 0x00100000-0x002fffff] to [bus b3-b3] add_size 300000
> [  187.930129] pci 0000:b1:02.0: [mem 0x00100000-0x002fffff] get_res_add_size  add_size 300000
> [  187.938500] pci 0000:b1:03.0: [mem 0x00100000-0x002fffff] get_res_add_size  add_size 300000
> [  187.946857] pci 0000:b0:00.0: bridge window [mem 0x00100000-0x004fffff] to [bus b1-b3] add_size 600000
> [  187.956206] pci 0000:b0:00.0: BAR 14: assigned [mem 0xf8000000-0xf83fffff]
> [  187.963102] pci 0000:b0:00.0: BAR 15: assigned [mem 0xf5000000-0xf51fffff pref]
> [  187.970434] pci 0000:b0:00.0: BAR 14: reassigned [mem 0xf8000000-0xf89fffff]
> [  187.977497] pci 0000:b1:02.0: BAR 14: assigned [mem 0xf8000000-0xf81fffff]
> [  187.984383] pci 0000:b1:02.0: BAR 15: assigned [mem 0xf5000000-0xf50fffff pref]
> [  187.991695] pci 0000:b1:03.0: BAR 14: assigned [mem 0xf8200000-0xf83fffff]
> [  187.998576] pci 0000:b1:03.0: BAR 15: assigned [mem 0xf5100000-0xf51fffff pref]
> [  188.005888] pci 0000:b1:03.0: BAR 14: reassigned [mem 0xf8200000-0xf86fffff]
> [  188.012939] pci 0000:b1:02.0: BAR 14: can't assign mem (size 0x200000)
> [  188.019471] pci 0000:b1:02.0: failed to add 300000 to res=[mem 0xf8000000-0xf81fffff]
> [  188.027326] pci 0000:b2:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
> [  188.034071] pci 0000:b2:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bit]
> [  188.040795] pci 0000:b2:00.0: BAR 2: assigned [mem 0xf8000000-0xf80fffff 64bit]
> [  188.048119] pci 0000:b2:00.0: BAR 2: set to [mem 0xf8000000-0xf80fffff 64bit] (PCI address [0xf8000000-0xf80fffff])
> [  188.058550] pci 0000:b2:00.0: BAR 6: assigned [mem 0xf5000000-0xf50fffff pref]
> [  188.065802] pci 0000:b2:00.0: BAR 0: assigned [mem 0xf8100000-0xf8103fff 64bit]
> [  188.073125] pci 0000:b2:00.0: BAR 0: set to [mem 0xf8100000-0xf8103fff 64bit] (PCI address [0xf8100000-0xf8103fff])
> [  188.083596] pci 0000:b2:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bit]
> [  188.090310] pci 0000:b2:00.0: BAR 9: can't assign mem (size 0x300000)
> [  188.096773] pci 0000:b2:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
> [  188.103479] pci 0000:b2:00.0: BAR 7: assigned [mem 0xf8104000-0xf810ffff 64bit]
> [  188.110801] pci 0000:b2:00.0: BAR 7: set to [mem 0xf8104000-0xf810ffff 64bit] (PCI address [0xf8104000-0xf810ffff])
> [  188.121256] pci 0000:b1:02.0: PCI bridge to [bus b2-b2]
> [  188.126512] pci 0000:b1:02.0:   bridge window [mem 0xf8000000-0xf81fffff]
> [  188.133328] pci 0000:b1:02.0:   bridge window [mem 0xf5000000-0xf50fffff pref]
> [  188.140608] pci 0000:b3:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
> [  188.147341] pci 0000:b3:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bit]
> [  188.154076] pci 0000:b3:00.0: BAR 2: assigned [mem 0xf8200000-0xf82fffff 64bit]
> [  188.161417] pci 0000:b3:00.0: BAR 2: set to [mem 0xf8200000-0xf82fffff 64bit] (PCI address [0xf8200000-0xf82fffff])
> [  188.171865] pci 0000:b3:00.0: BAR 6: assigned [mem 0xf5100000-0xf51fffff pref]
> [  188.179090] pci 0000:b3:00.0: BAR 0: assigned [mem 0xf8300000-0xf8303fff 64bit]
> [  188.186431] pci 0000:b3:00.0: BAR 0: set to [mem 0xf8300000-0xf8303fff 64bit] (PCI address [0xf8300000-0xf8303fff])
> [  188.196884] pci 0000:b3:00.0: reg 18c: [mem 0x00000000-0x000fffff 64bit]
> [  188.203591] pci 0000:b3:00.0: BAR 9: assigned [mem 0xf8400000-0xf86fffff 64bit]
> [  188.210909] pci 0000:b3:00.0: BAR 9: set to [mem 0xf8400000-0xf86fffff 64bit] (PCI address [0xf8400000-0xf86fffff])
> [  188.221379] pci 0000:b3:00.0: reg 184: [mem 0x00000000-0x00003fff 64bit]
> [  188.228089] pci 0000:b3:00.0: BAR 7: assigned [mem 0xf8304000-0xf830ffff 64bit]
> [  188.235407] pci 0000:b3:00.0: BAR 7: set to [mem 0xf8304000-0xf830ffff 64bit] (PCI address [0xf8304000-0xf830ffff])
> [  188.245843] pci 0000:b1:03.0: PCI bridge to [bus b3-b3]
> [  188.251107] pci 0000:b1:03.0:   bridge window [mem 0xf8200000-0xf86fffff]
> [  188.257922] pci 0000:b1:03.0:   bridge window [mem 0xf5100000-0xf51fffff pref]
> [  188.265180] pci 0000:b0:00.0: PCI bridge to [bus b1-b3]
> [  188.270443] pci 0000:b0:00.0:   bridge window [mem 0xf8000000-0xf89fffff]
> [  188.277250] pci 0000:b0:00.0:   bridge window [mem 0xf5000000-0xf51fffff pref]
> [  188.284512] pcieport 0000:80:02.2: PCI bridge to [bus b0-bf]
> [  188.290184] pcieport 0000:80:02.2:   bridge window [io  0xa000-0xbfff]
> [  188.296735] pcieport 0000:80:02.2:   bridge window [mem 0xf8000000-0xf8ffffff]
> [  188.303963] pcieport 0000:80:02.2:   bridge window [mem 0xf5000000-0xf5ffffff 64bit pref]
> 
> b2:00.0 BAR 9 has not get assigned...
> 
> root cause:
> b1:02.0 can not be added more range, because b1:03.0 is just after it.
> not space between required ranges.
> 
> Solution:
> Try to assign required + optional all together at first, and if it fails, go with required then reassign path.

Yinghai,
	
	I am worried that this approach will resurface old bug
https://bugzilla.kernel.org/show_bug.cgi?id=15960
	
	With your approach; on a system with not enough resources to satisfy
all the devices, when you fail to allocate 'required+optional' in the first
round and fall back to assigning only the 'required' resources, you can get the
reassignment order wrong, thus not allocate resources to devices for which the
BIOS had originally allocated resources, and hence end up disabling the device.


RP

