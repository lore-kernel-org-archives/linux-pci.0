Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:40319 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbaANGWX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2014 01:22:23 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 14 Jan 2014 16:22:21 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2A6CC3578056
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 17:22:18 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s0E63PnD38076642
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 17:03:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s0E6MG5E016470
	for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2014 17:22:17 +1100
Date: Tue, 14 Jan 2014 14:22:15 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, yinghai@kernel.org, bhelgaas@google.com,
	amirv@mellanox.com, jackm@dev.mellanox.co.il,
	ogerlitz@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: mlx4_core probe error after applying Yinghai's patch
Message-ID: <20140114062215.GA19345@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

All,

I am testing Yinghai's patch based on 3.13-rc1, after applying these four 
patches, there is an error during probe for mlx4_core.

Code base we did the test:
  $ git oneline -5
  298a335 PCI: Try best to allocate pref mmio 64bit above 4g
  b730e81 PCI: Try to allocate mem64 above 4G at first
  4e27325 PCI: Don't use 4G bus address directly in resource allocation
  ab6c20f PCI: pcibus address to resource converting take bus instead of dev
  6ce4eac Linux 3.13-rc1
  
Error log:
  mlx4_core 0003:05:00.0: Multiple PFs not yet supported.  Skipping PF.
  mlx4_core: probe of 0003:05:00.0 failed with error -22

My analysis:
  After careful investigation, I guess this error is not introduced by
  Yinghai's patch. This looks more like an error from device itself. Since
  this error really happens after applying Yinghai's patch(especially the last
  one 298a335), I would like to include Yinghai in this loop.

  In the attached file tree.txt, two charts show the resource allocated to
  this device before and after. The effect of Yinghai's patch will move the
  BAR#6 from a prefetchable window to a non-prefetchable window since it
  doesn't has 64-bit capatility. This should be fine to a device in my mind.
  (If not, please correct me) 

  In order to prove this is the root cause, Guo Chao did a hack so that this
  ROM BAR will be allocated from prefetchable window even with Yinghai's
  patch. The result shows after move the ROM from non-prefetchable window back
  to the prefetchable window, the error disappear.

Need your help:
  Yinghai & Bjorn, I think Yinghai's patch is fine to allocate a prefetchable
  resource from a non-prefetchable window. Please correct me, if not.

  Mellanox maintainers, from the code I didn't get any clue about why it
  reports there are several PFs. If any of you could take a look that would be
  very helpful.

Attached files:
  tree.txt                   The resource allocation result.
  iomem.3.13-rc1-nosriov     /proc/iomem of 3.13-rc1 without sriov cap
  iomem.yinghai4             /proc/iomem of 3.13-rc1 with Yinghai's patches
  lspci.txt                  lspci output
  lspci_mellanox.txt         lspci output for Mellanox device

If more information necessary, please let me know.

Thanks for your time and efforts in advance :-)

-- 
Richard Yang
Help you, Help me

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tree.txt"

Good Version: probe success
kernel version: 3.13-rc1
            
            Bus 0
        ---+---------
           | 0003:00:00.0
        +--++
        |   | BAR 14         0x3 d050 8e00 0000    48M
        |   |              - 0x3 d050 90ff ffff
        |   |
        |   | BAR 15         0x3 d050 8000 0000   224M
        |   | (pref)       - 0x3 d050 8dff ffff
        +--++
           | 
           | Bus 1
     ------+-----------
           | 0003:01:00.0     
        +--++          
        |   | BAR 14         0x3 d050 8e00 0000    40M         
        |   |              - 0x3 d050 907f ffff
        |   |          
        |   | BAR 15         0x3 d050 8000 0000   208M
        |   | (pref)       - 0x3 d050 8dff ffff
        +--++          
           |    Bus 2       
  ---------+---+---------
               |         
               |  0003:02:09.0       
            +--++        
            |   | BAR 14     0x3 d050 8f00 0000     8M       
            |   |          - 0x3 d050 8f7f ffff
            |   |        
            |   | BAR 15     0x3 d050 8000 0000   176M       
            |   | (pref)   - 0x3 d050 8bff ffff
            |   |        
            +-+-+        
              |  Bus 5        
         ----++-------   
             |  0003:05:00.0 (Mellanox)
           +-+-+
           |   | BAR 0       0x3 d050 8f00 0000     1M        
           |   | (64)      - 0x3 d050 8f0f ffff
           |   |         
           |   | BAR 2       0x3 d050 8000 0000   128M  
           |   | (64 pref) - 0x3 d050 87ff ffff
           |   |         
           |   | BAR 6       0x3 d050 8800 0000     1M        
           |   | (pref)    - 0x3 d050 880f ffff
           +---+         




Bad Version: probe failed
kernel version: 3.13-rc1 with 4 yinghai's patches
            
            Bus 0
        ---+---------
           | 0003:00:00.0
        +--++
        |   | BAR 14         0x3 d050 9400 0000    48M
        |   |              - 0x3 d050 96ff ffff
        |   |
        |   | BAR 15         0x3 d050 8000 0000   320M
        |   | (64 pref)    - 0x3 d050 93ff ffff
        +--++
           | 
           | Bus 1
     ------+-----------
           | 0003:01:00.0     
        +--++          
        |   | BAR 14         0x3 d050 9400 0000    40M         
        |   |              - 0x3 d050 967f ffff
        |   |          
        |   | BAR 15         0x3 d050 8000 0000   320M
        |   | (64 pref)    - 0x3 d050 93ff ffff
        +--++          
           |    Bus 2       
  ---------+---+---------
               |         
               |  0003:02:09.0       
            +--++        
            |   | BAR 14     0x3 d050 9500 0000     8M       
            |   |          - 0x3 d050 957f ffff
            |   |        
            |   | BAR 15     0x3 d050 8000 0000   256M       
            |   | (64 pref)- 0x3 d050 8fff ffff
            |   |        
            +-+-+        
              |  Bus 5        
         ----++-------   
             |  0003:05:00.0 (Mellanox)
           +-+-+
           |   | BAR 0       0x3 d050 9500 0000     1M        
           |   | (64)      - 0x3 d050 950f ffff
           |   |         
           |   | BAR 2       0x3 d050 8000 0000   128M  
           |   | (64 pref) - 0x3 d050 87ff ffff
           |   |         
           |   | BAR 6       0x3 d050 9510 0000     1M        
           |   | (pref)    - 0x3 d050 951f ffff
           +---+         

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iomem.3.13-rc1-nosriov"

00000000-fffffffff : System RAM
1000000000-1fffffffff : System RAM
2000000000-27ffffffff : System RAM
2800000000-2fffffffff : System RAM
3d00080000000-3d000fffeffff : /pciex@3fffe40000000
3d01080000000-3d010fffeffff : /pciex@3fffe40100000
  3d01080000000-3d01081ffffff : PCI Bus 0001:01
    3d01080000000-3d010817fffff : PCI Bus 0001:02
      3d01080000000-3d010807fffff : PCI Bus 0001:03
        3d01080000000-3d01080003fff : 0001:03:00.0
          3d01080000000-3d01080003fff : lpfc
        3d01080004000-3d01080007fff : 0001:03:00.1
          3d01080004000-3d01080007fff : lpfc
        3d01080008000-3d01080008fff : 0001:03:00.0
          3d01080008000-3d01080008fff : lpfc
        3d01080009000-3d01080009fff : 0001:03:00.1
          3d01080009000-3d01080009fff : lpfc
      3d01080800000-3d01080ffffff : PCI Bus 0001:04
        3d01080800000-3d0108080ffff : 0001:04:00.0
          3d01080800000-3d0108080ffff : ipr
        3d01080810000-3d0108081ffff : 0001:04:00.0
          3d01080810000-3d0108081ffff : ipr
      3d01081000000-3d010817fffff : PCI Bus 0001:05
        3d01081000000-3d0108100ffff : 0001:05:00.0
          3d01081000000-3d0108100ffff : ipr
        3d01081010000-3d0108101ffff : 0001:05:00.0
          3d01081010000-3d0108101ffff : ipr
    3d01081800000-3d0108183ffff : 0001:01:00.0
  3d01082000000-3d010837fffff : PCI Bus 0001:01
    3d01082000000-3d010837fffff : PCI Bus 0001:02
      3d01082000000-3d010827fffff : PCI Bus 0001:03
        3d01082000000-3d0108203ffff : 0001:03:00.0
        3d01082040000-3d0108207ffff : 0001:03:00.1
      3d01082800000-3d01082ffffff : PCI Bus 0001:04
        3d01082800000-3d0108281ffff : 0001:04:00.0
      3d01083000000-3d010837fffff : PCI Bus 0001:05
        3d01083000000-3d0108301ffff : 0001:05:00.0
3d04080000000-3d040fffeffff : /pciex@3fffe40400000
  3d04080000000-3d040807fffff : PCI Bus 0002:01
    3d04080000000-3d0408007ffff : 0002:01:00.0
    3d04080080000-3d040800fffff : 0002:01:00.1
    3d04080100000-3d04080107fff : 0002:01:00.0
      3d04080100000-3d04080107fff : lpfc
    3d04080108000-3d0408010ffff : 0002:01:00.1
      3d04080108000-3d0408010ffff : lpfc
    3d04080110000-3d04080110fff : 0002:01:00.0
      3d04080110000-3d04080110fff : lpfc
3d05080000000-3d050fffeffff : /pciex@3fffe40500000
  3d05080000000-3d0508dffffff : PCI Bus 0003:01
    3d05080000000-3d0508dffffff : PCI Bus 0003:02
      3d05080000000-3d0508bffffff : PCI Bus 0003:05
        3d05080000000-3d05087ffffff : 0003:05:00.0
          3d05080000000-3d05087ffffff : mlx4_core
        3d05088000000-3d050880fffff : 0003:05:00.0
      3d0508c000000-3d0508c7fffff : PCI Bus 0003:04
        3d0508c000000-3d0508c01ffff : 0003:04:00.0
      3d0508c800000-3d0508cffffff : PCI Bus 0003:06
        3d0508c800000-3d0508c87ffff : 0003:06:00.0
        3d0508c880000-3d0508c8fffff : 0003:06:00.1
        3d0508c900000-3d0508c97ffff : 0003:06:00.2
        3d0508c980000-3d0508c9fffff : 0003:06:00.3
        3d0508ca00000-3d0508ca0ffff : 0003:06:00.0
          3d0508ca00000-3d0508ca0ffff : tg3
        3d0508ca10000-3d0508ca1ffff : 0003:06:00.0
          3d0508ca10000-3d0508ca1ffff : tg3
        3d0508ca20000-3d0508ca2ffff : 0003:06:00.0
          3d0508ca20000-3d0508ca2ffff : tg3
        3d0508ca30000-3d0508ca3ffff : 0003:06:00.1
          3d0508ca30000-3d0508ca3ffff : tg3
        3d0508ca40000-3d0508ca4ffff : 0003:06:00.1
          3d0508ca40000-3d0508ca4ffff : tg3
        3d0508ca50000-3d0508ca5ffff : 0003:06:00.1
          3d0508ca50000-3d0508ca5ffff : tg3
        3d0508ca60000-3d0508ca6ffff : 0003:06:00.2
          3d0508ca60000-3d0508ca6ffff : tg3
        3d0508ca70000-3d0508ca7ffff : 0003:06:00.2
          3d0508ca70000-3d0508ca7ffff : tg3
        3d0508ca80000-3d0508ca8ffff : 0003:06:00.2
          3d0508ca80000-3d0508ca8ffff : tg3
        3d0508ca90000-3d0508ca9ffff : 0003:06:00.3
          3d0508ca90000-3d0508ca9ffff : tg3
        3d0508caa0000-3d0508caaffff : 0003:06:00.3
          3d0508caa0000-3d0508caaffff : tg3
        3d0508cab0000-3d0508cabffff : 0003:06:00.3
          3d0508cab0000-3d0508cabffff : tg3
      3d0508d000000-3d0508d7fffff : PCI Bus 0003:07
        3d0508d000000-3d0508d07ffff : 0003:07:00.0
        3d0508d080000-3d0508d0fffff : 0003:07:00.1
        3d0508d100000-3d0508d17ffff : 0003:07:00.2
        3d0508d180000-3d0508d1fffff : 0003:07:00.3
        3d0508d200000-3d0508d20ffff : 0003:07:00.0
          3d0508d200000-3d0508d20ffff : tg3
        3d0508d210000-3d0508d21ffff : 0003:07:00.0
          3d0508d210000-3d0508d21ffff : tg3
        3d0508d220000-3d0508d22ffff : 0003:07:00.0
          3d0508d220000-3d0508d22ffff : tg3
        3d0508d230000-3d0508d23ffff : 0003:07:00.1
          3d0508d230000-3d0508d23ffff : tg3
        3d0508d240000-3d0508d24ffff : 0003:07:00.1
          3d0508d240000-3d0508d24ffff : tg3
        3d0508d250000-3d0508d25ffff : 0003:07:00.1
          3d0508d250000-3d0508d25ffff : tg3
        3d0508d260000-3d0508d26ffff : 0003:07:00.2
          3d0508d260000-3d0508d26ffff : tg3
        3d0508d270000-3d0508d27ffff : 0003:07:00.2
          3d0508d270000-3d0508d27ffff : tg3
        3d0508d280000-3d0508d28ffff : 0003:07:00.2
          3d0508d280000-3d0508d28ffff : tg3
        3d0508d290000-3d0508d29ffff : 0003:07:00.3
          3d0508d290000-3d0508d29ffff : tg3
        3d0508d2a0000-3d0508d2affff : 0003:07:00.3
          3d0508d2a0000-3d0508d2affff : tg3
        3d0508d2b0000-3d0508d2bffff : 0003:07:00.3
          3d0508d2b0000-3d0508d2bffff : tg3
  3d0508e000000-3d05090ffffff : PCI Bus 0003:01
    3d0508e000000-3d050907fffff : PCI Bus 0003:02
      3d0508e000000-3d0508e7fffff : PCI Bus 0003:03
        3d0508e000000-3d0508e00ffff : 0003:03:00.0
          3d0508e000000-3d0508e00ffff : xhci_hcd
        3d0508e010000-3d0508e011fff : 0003:03:00.0
      3d0508e800000-3d0508effffff : PCI Bus 0003:04
        3d0508e800000-3d0508e80ffff : 0003:04:00.0
          3d0508e800000-3d0508e80ffff : ipr
        3d0508e810000-3d0508e81ffff : 0003:04:00.0
          3d0508e810000-3d0508e81ffff : ipr
      3d0508f000000-3d0508f7fffff : PCI Bus 0003:05
        3d0508f000000-3d0508f0fffff : 0003:05:00.0
          3d0508f000000-3d0508f0fffff : mlx4_core
      3d0508f800000-3d0508fffffff : PCI Bus 0003:06
      3d05090000000-3d050907fffff : PCI Bus 0003:07
    3d05090800000-3d0509083ffff : 0003:01:00.0
3d20080000000-3d200fffeffff : /pciex@3fffe42000000
3d21080000000-3d210fffeffff : /pciex@3fffe42100000
  3d21080000000-3d210807fffff : PCI Bus 0005:01
    3d21080000000-3d21080003fff : 0005:01:00.0
      3d21080000000-3d21080003fff : lpfc
    3d21080004000-3d21080007fff : 0005:01:00.1
      3d21080004000-3d21080007fff : lpfc
    3d21080008000-3d21080008fff : 0005:01:00.0
      3d21080008000-3d21080008fff : lpfc
    3d21080009000-3d21080009fff : 0005:01:00.1
      3d21080009000-3d21080009fff : lpfc
  3d21080800000-3d21080ffffff : PCI Bus 0005:01
    3d21080800000-3d2108083ffff : 0005:01:00.0
    3d21080840000-3d2108087ffff : 0005:01:00.1
3d24080000000-3d240fffeffff : /pciex@3fffe42400000
  3d24080000000-3d240807fffff : PCI Bus 0006:01
    3d24080000000-3d2408007ffff : 0006:01:00.0
    3d24080080000-3d240800fffff : 0006:01:00.1
    3d24080100000-3d2408017ffff : 0006:01:00.2
    3d24080180000-3d240801fffff : 0006:01:00.3
    3d24080200000-3d2408027ffff : 0006:01:00.4
    3d24080280000-3d240802fffff : 0006:01:00.5
    3d24080300000-3d24080307fff : 0006:01:00.0
      3d24080300000-3d24080307fff : be2net
    3d24080308000-3d2408030ffff : 0006:01:00.1
      3d24080308000-3d2408030ffff : be2net
    3d24080310000-3d24080317fff : 0006:01:00.2
      3d24080310000-3d24080317fff : be2net
    3d24080318000-3d2408031ffff : 0006:01:00.3
      3d24080318000-3d2408031ffff : be2net
    3d24080320000-3d24080327fff : 0006:01:00.4
      3d24080320000-3d24080327fff : lpfc
    3d24080328000-3d2408032ffff : 0006:01:00.5
      3d24080328000-3d2408032ffff : lpfc
    3d24080330000-3d24080330fff : 0006:01:00.0
      3d24080330000-3d24080330fff : be2net
3d25080000000-3d250fffeffff : /pciex@3fffe42500000
  3d25080000000-3d250807fffff : PCI Bus 0007:01
    3d25080000000-3d2508003ffff : 0007:01:00.0
      3d25080000000-3d2508003ffff : ipr
  3d25080800000-3d25081ffffff : PCI Bus 0007:01
    3d25080800000-3d2508081ffff : 0007:01:00.0
    3d25081000000-3d25081ffffff : 0007:01:00.0
      3d25081000000-3d25081ffffff : ipr
3ffff80020000-3ffff80020fff : CPU 0 [0x20] Interrupt Presentation
3ffff80021000-3ffff80021fff : CPU 1 [0x21] Interrupt Presentation
3ffff80022000-3ffff80022fff : CPU 2 [0x22] Interrupt Presentation
3ffff80023000-3ffff80023fff : CPU 3 [0x23] Interrupt Presentation
3ffff80024000-3ffff80024fff : CPU 4 [0x24] Interrupt Presentation
3ffff80025000-3ffff80025fff : CPU 5 [0x25] Interrupt Presentation
3ffff80026000-3ffff80026fff : CPU 6 [0x26] Interrupt Presentation
3ffff80027000-3ffff80027fff : CPU 7 [0x27] Interrupt Presentation
3ffff80028000-3ffff80028fff : CPU 8 [0x28] Interrupt Presentation
3ffff80029000-3ffff80029fff : CPU 9 [0x29] Interrupt Presentation
3ffff8002a000-3ffff8002afff : CPU 10 [0x2a] Interrupt Presentation
3ffff8002b000-3ffff8002bfff : CPU 11 [0x2b] Interrupt Presentation
3ffff8002c000-3ffff8002cfff : CPU 12 [0x2c] Interrupt Presentation
3ffff8002d000-3ffff8002dfff : CPU 13 [0x2d] Interrupt Presentation
3ffff8002e000-3ffff8002efff : CPU 14 [0x2e] Interrupt Presentation
3ffff8002f000-3ffff8002ffff : CPU 15 [0x2f] Interrupt Presentation
3ffff80060000-3ffff80060fff : CPU 16 [0x60] Interrupt Presentation
3ffff80061000-3ffff80061fff : CPU 17 [0x61] Interrupt Presentation
3ffff80062000-3ffff80062fff : CPU 18 [0x62] Interrupt Presentation
3ffff80063000-3ffff80063fff : CPU 19 [0x63] Interrupt Presentation
3ffff80064000-3ffff80064fff : CPU 20 [0x64] Interrupt Presentation
3ffff80065000-3ffff80065fff : CPU 21 [0x65] Interrupt Presentation
3ffff80066000-3ffff80066fff : CPU 22 [0x66] Interrupt Presentation
3ffff80067000-3ffff80067fff : CPU 23 [0x67] Interrupt Presentation
3ffff80070000-3ffff80070fff : CPU 24 [0x70] Interrupt Presentation
3ffff80071000-3ffff80071fff : CPU 25 [0x71] Interrupt Presentation
3ffff80072000-3ffff80072fff : CPU 26 [0x72] Interrupt Presentation
3ffff80073000-3ffff80073fff : CPU 27 [0x73] Interrupt Presentation
3ffff80074000-3ffff80074fff : CPU 28 [0x74] Interrupt Presentation
3ffff80075000-3ffff80075fff : CPU 29 [0x75] Interrupt Presentation
3ffff80076000-3ffff80076fff : CPU 30 [0x76] Interrupt Presentation
3ffff80077000-3ffff80077fff : CPU 31 [0x77] Interrupt Presentation
3ffff80120000-3ffff80120fff : CPU 96 [0xa0] Interrupt Presentation
3ffff80121000-3ffff80121fff : CPU 97 [0xa1] Interrupt Presentation
3ffff80122000-3ffff80122fff : CPU 98 [0xa2] Interrupt Presentation
3ffff80123000-3ffff80123fff : CPU 99 [0xa3] Interrupt Presentation
3ffff80124000-3ffff80124fff : CPU 100 [0xa4] Interrupt Presentation
3ffff80125000-3ffff80125fff : CPU 101 [0xa5] Interrupt Presentation
3ffff80126000-3ffff80126fff : CPU 102 [0xa6] Interrupt Presentation
3ffff80127000-3ffff80127fff : CPU 103 [0xa7] Interrupt Presentation
3ffff80128000-3ffff80128fff : CPU 104 [0xa8] Interrupt Presentation
3ffff80129000-3ffff80129fff : CPU 105 [0xa9] Interrupt Presentation
3ffff8012a000-3ffff8012afff : CPU 106 [0xaa] Interrupt Presentation
3ffff8012b000-3ffff8012bfff : CPU 107 [0xab] Interrupt Presentation
3ffff8012c000-3ffff8012cfff : CPU 108 [0xac] Interrupt Presentation
3ffff8012d000-3ffff8012dfff : CPU 109 [0xad] Interrupt Presentation
3ffff8012e000-3ffff8012efff : CPU 110 [0xae] Interrupt Presentation
3ffff8012f000-3ffff8012ffff : CPU 111 [0xaf] Interrupt Presentation
3ffff80168000-3ffff80168fff : CPU 112 [0xe8] Interrupt Presentation
3ffff80169000-3ffff80169fff : CPU 113 [0xe9] Interrupt Presentation
3ffff8016a000-3ffff8016afff : CPU 114 [0xea] Interrupt Presentation
3ffff8016b000-3ffff8016bfff : CPU 115 [0xeb] Interrupt Presentation
3ffff8016c000-3ffff8016cfff : CPU 116 [0xec] Interrupt Presentation
3ffff8016d000-3ffff8016dfff : CPU 117 [0xed] Interrupt Presentation
3ffff8016e000-3ffff8016efff : CPU 118 [0xee] Interrupt Presentation
3ffff8016f000-3ffff8016ffff : CPU 119 [0xef] Interrupt Presentation
3ffff80170000-3ffff80170fff : CPU 120 [0xf0] Interrupt Presentation
3ffff80171000-3ffff80171fff : CPU 121 [0xf1] Interrupt Presentation
3ffff80172000-3ffff80172fff : CPU 122 [0xf2] Interrupt Presentation
3ffff80173000-3ffff80173fff : CPU 123 [0xf3] Interrupt Presentation
3ffff80174000-3ffff80174fff : CPU 124 [0xf4] Interrupt Presentation
3ffff80175000-3ffff80175fff : CPU 125 [0xf5] Interrupt Presentation
3ffff80176000-3ffff80176fff : CPU 126 [0xf6] Interrupt Presentation
3ffff80177000-3ffff80177fff : CPU 127 [0xf7] Interrupt Presentation
3ffff80820000-3ffff80820fff : CPU 32 [0x820] Interrupt Presentation
3ffff80821000-3ffff80821fff : CPU 33 [0x821] Interrupt Presentation
3ffff80822000-3ffff80822fff : CPU 34 [0x822] Interrupt Presentation
3ffff80823000-3ffff80823fff : CPU 35 [0x823] Interrupt Presentation
3ffff80824000-3ffff80824fff : CPU 36 [0x824] Interrupt Presentation
3ffff80825000-3ffff80825fff : CPU 37 [0x825] Interrupt Presentation
3ffff80826000-3ffff80826fff : CPU 38 [0x826] Interrupt Presentation
3ffff80827000-3ffff80827fff : CPU 39 [0x827] Interrupt Presentation
3ffff80860000-3ffff80860fff : CPU 40 [0x860] Interrupt Presentation
3ffff80861000-3ffff80861fff : CPU 41 [0x861] Interrupt Presentation
3ffff80862000-3ffff80862fff : CPU 42 [0x862] Interrupt Presentation
3ffff80863000-3ffff80863fff : CPU 43 [0x863] Interrupt Presentation
3ffff80864000-3ffff80864fff : CPU 44 [0x864] Interrupt Presentation
3ffff80865000-3ffff80865fff : CPU 45 [0x865] Interrupt Presentation
3ffff80866000-3ffff80866fff : CPU 46 [0x866] Interrupt Presentation
3ffff80867000-3ffff80867fff : CPU 47 [0x867] Interrupt Presentation
3ffff80868000-3ffff80868fff : CPU 48 [0x868] Interrupt Presentation
3ffff80869000-3ffff80869fff : CPU 49 [0x869] Interrupt Presentation
3ffff8086a000-3ffff8086afff : CPU 50 [0x86a] Interrupt Presentation
3ffff8086b000-3ffff8086bfff : CPU 51 [0x86b] Interrupt Presentation
3ffff8086c000-3ffff8086cfff : CPU 52 [0x86c] Interrupt Presentation
3ffff8086d000-3ffff8086dfff : CPU 53 [0x86d] Interrupt Presentation
3ffff8086e000-3ffff8086efff : CPU 54 [0x86e] Interrupt Presentation
3ffff8086f000-3ffff8086ffff : CPU 55 [0x86f] Interrupt Presentation
3ffff80870000-3ffff80870fff : CPU 56 [0x870] Interrupt Presentation
3ffff80871000-3ffff80871fff : CPU 57 [0x871] Interrupt Presentation
3ffff80872000-3ffff80872fff : CPU 58 [0x872] Interrupt Presentation
3ffff80873000-3ffff80873fff : CPU 59 [0x873] Interrupt Presentation
3ffff80874000-3ffff80874fff : CPU 60 [0x874] Interrupt Presentation
3ffff80875000-3ffff80875fff : CPU 61 [0x875] Interrupt Presentation
3ffff80876000-3ffff80876fff : CPU 62 [0x876] Interrupt Presentation
3ffff80877000-3ffff80877fff : CPU 63 [0x877] Interrupt Presentation
3ffff80928000-3ffff80928fff : CPU 64 [0x8a8] Interrupt Presentation
3ffff80929000-3ffff80929fff : CPU 65 [0x8a9] Interrupt Presentation
3ffff8092a000-3ffff8092afff : CPU 66 [0x8aa] Interrupt Presentation
3ffff8092b000-3ffff8092bfff : CPU 67 [0x8ab] Interrupt Presentation
3ffff8092c000-3ffff8092cfff : CPU 68 [0x8ac] Interrupt Presentation
3ffff8092d000-3ffff8092dfff : CPU 69 [0x8ad] Interrupt Presentation
3ffff8092e000-3ffff8092efff : CPU 70 [0x8ae] Interrupt Presentation
3ffff8092f000-3ffff8092ffff : CPU 71 [0x8af] Interrupt Presentation
3ffff80930000-3ffff80930fff : CPU 72 [0x8b0] Interrupt Presentation
3ffff80931000-3ffff80931fff : CPU 73 [0x8b1] Interrupt Presentation
3ffff80932000-3ffff80932fff : CPU 74 [0x8b2] Interrupt Presentation
3ffff80933000-3ffff80933fff : CPU 75 [0x8b3] Interrupt Presentation
3ffff80934000-3ffff80934fff : CPU 76 [0x8b4] Interrupt Presentation
3ffff80935000-3ffff80935fff : CPU 77 [0x8b5] Interrupt Presentation
3ffff80936000-3ffff80936fff : CPU 78 [0x8b6] Interrupt Presentation
3ffff80937000-3ffff80937fff : CPU 79 [0x8b7] Interrupt Presentation
3ffff80960000-3ffff80960fff : CPU 80 [0x8e0] Interrupt Presentation
3ffff80961000-3ffff80961fff : CPU 81 [0x8e1] Interrupt Presentation
3ffff80962000-3ffff80962fff : CPU 82 [0x8e2] Interrupt Presentation
3ffff80963000-3ffff80963fff : CPU 83 [0x8e3] Interrupt Presentation
3ffff80964000-3ffff80964fff : CPU 84 [0x8e4] Interrupt Presentation
3ffff80965000-3ffff80965fff : CPU 85 [0x8e5] Interrupt Presentation
3ffff80966000-3ffff80966fff : CPU 86 [0x8e6] Interrupt Presentation
3ffff80967000-3ffff80967fff : CPU 87 [0x8e7] Interrupt Presentation
3ffff80970000-3ffff80970fff : CPU 88 [0x8f0] Interrupt Presentation
3ffff80971000-3ffff80971fff : CPU 89 [0x8f1] Interrupt Presentation
3ffff80972000-3ffff80972fff : CPU 90 [0x8f2] Interrupt Presentation
3ffff80973000-3ffff80973fff : CPU 91 [0x8f3] Interrupt Presentation
3ffff80974000-3ffff80974fff : CPU 92 [0x8f4] Interrupt Presentation
3ffff80975000-3ffff80975fff : CPU 93 [0x8f5] Interrupt Presentation
3ffff80976000-3ffff80976fff : CPU 94 [0x8f6] Interrupt Presentation
3ffff80977000-3ffff80977fff : CPU 95 [0x8f7] Interrupt Presentation

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iomem.yinghai4"

00000000-fffffffff : System RAM
1000000000-1fffffffff : System RAM
2000000000-27ffffffff : System RAM
2800000000-2fffffffff : System RAM
3d00080000000-3d000fffeffff : /pciex@3fffe40000000
3d01080000000-3d010fffeffff : /pciex@3fffe40100000
  3d01080000000-3d01081ffffff : PCI Bus 0001:01
    3d01080000000-3d010817fffff : PCI Bus 0001:02
      3d01080000000-3d010807fffff : PCI Bus 0001:03
        3d01080000000-3d0108003ffff : 0001:03:00.0
        3d01080040000-3d0108007ffff : 0001:03:00.1
        3d01080080000-3d01080083fff : 0001:03:00.0
          3d01080080000-3d01080083fff : lpfc
        3d01080084000-3d01080087fff : 0001:03:00.1
          3d01080084000-3d01080087fff : lpfc
        3d01080088000-3d01080088fff : 0001:03:00.0
          3d01080088000-3d01080088fff : lpfc
        3d01080089000-3d01080089fff : 0001:03:00.1
          3d01080089000-3d01080089fff : lpfc
      3d01080800000-3d01080ffffff : PCI Bus 0001:04
        3d01080800000-3d0108081ffff : 0001:04:00.0
        3d01080820000-3d0108082ffff : 0001:04:00.0
          3d01080820000-3d0108082ffff : ipr
        3d01080830000-3d0108083ffff : 0001:04:00.0
          3d01080830000-3d0108083ffff : ipr
      3d01081000000-3d010817fffff : PCI Bus 0001:05
        3d01081000000-3d0108101ffff : 0001:05:00.0
        3d01081020000-3d0108102ffff : 0001:05:00.0
          3d01081020000-3d0108102ffff : ipr
        3d01081030000-3d0108103ffff : 0001:05:00.0
          3d01081030000-3d0108103ffff : ipr
    3d01081800000-3d0108183ffff : 0001:01:00.0
  3d01082000000-3d010837fffff : PCI Bus 0001:01
    3d01082000000-3d010837fffff : PCI Bus 0001:02
      3d01082000000-3d010827fffff : PCI Bus 0001:03
      3d01082800000-3d01082ffffff : PCI Bus 0001:04
      3d01083000000-3d010837fffff : PCI Bus 0001:05
3d04080000000-3d040fffeffff : /pciex@3fffe40400000
  3d04080000000-3d040807fffff : PCI Bus 0002:01
    3d04080000000-3d0408007ffff : 0002:01:00.0
    3d04080080000-3d040800fffff : 0002:01:00.1
  3d04080800000-3d04080ffffff : PCI Bus 0002:01
    3d04080800000-3d04080807fff : 0002:01:00.0
      3d04080800000-3d04080807fff : lpfc
    3d04080808000-3d0408080ffff : 0002:01:00.1
      3d04080808000-3d0408080ffff : lpfc
    3d04080810000-3d04080810fff : 0002:01:00.0
      3d04080810000-3d04080810fff : lpfc
3d05080000000-3d050fffeffff : /pciex@3fffe40500000
  3d05080000000-3d05093ffffff : PCI Bus 0003:01
    3d05080000000-3d05093ffffff : PCI Bus 0003:02
      3d05080000000-3d0508fffffff : PCI Bus 0003:05
        3d05080000000-3d05087ffffff : 0003:05:00.0
      3d05090000000-3d050907fffff : PCI Bus 0003:04
      3d05090800000-3d05090ffffff : PCI Bus 0003:06
        3d05090800000-3d0509080ffff : 0003:06:00.0
          3d05090800000-3d0509080ffff : tg3
        3d05090810000-3d0509081ffff : 0003:06:00.0
          3d05090810000-3d0509081ffff : tg3
        3d05090820000-3d0509082ffff : 0003:06:00.0
          3d05090820000-3d0509082ffff : tg3
        3d05090830000-3d0509083ffff : 0003:06:00.1
          3d05090830000-3d0509083ffff : tg3
        3d05090840000-3d0509084ffff : 0003:06:00.1
          3d05090840000-3d0509084ffff : tg3
        3d05090850000-3d0509085ffff : 0003:06:00.1
          3d05090850000-3d0509085ffff : tg3
        3d05090860000-3d0509086ffff : 0003:06:00.2
          3d05090860000-3d0509086ffff : tg3
        3d05090870000-3d0509087ffff : 0003:06:00.2
          3d05090870000-3d0509087ffff : tg3
        3d05090880000-3d0509088ffff : 0003:06:00.2
          3d05090880000-3d0509088ffff : tg3
        3d05090890000-3d0509089ffff : 0003:06:00.3
          3d05090890000-3d0509089ffff : tg3
        3d050908a0000-3d050908affff : 0003:06:00.3
          3d050908a0000-3d050908affff : tg3
        3d050908b0000-3d050908bffff : 0003:06:00.3
          3d050908b0000-3d050908bffff : tg3
      3d05091000000-3d050917fffff : PCI Bus 0003:07
        3d05091000000-3d0509100ffff : 0003:07:00.0
          3d05091000000-3d0509100ffff : tg3
        3d05091010000-3d0509101ffff : 0003:07:00.0
          3d05091010000-3d0509101ffff : tg3
        3d05091020000-3d0509102ffff : 0003:07:00.0
          3d05091020000-3d0509102ffff : tg3
        3d05091030000-3d0509103ffff : 0003:07:00.1
          3d05091030000-3d0509103ffff : tg3
        3d05091040000-3d0509104ffff : 0003:07:00.1
          3d05091040000-3d0509104ffff : tg3
        3d05091050000-3d0509105ffff : 0003:07:00.1
          3d05091050000-3d0509105ffff : tg3
        3d05091060000-3d0509106ffff : 0003:07:00.2
          3d05091060000-3d0509106ffff : tg3
        3d05091070000-3d0509107ffff : 0003:07:00.2
          3d05091070000-3d0509107ffff : tg3
        3d05091080000-3d0509108ffff : 0003:07:00.2
          3d05091080000-3d0509108ffff : tg3
        3d05091090000-3d0509109ffff : 0003:07:00.3
          3d05091090000-3d0509109ffff : tg3
        3d050910a0000-3d050910affff : 0003:07:00.3
          3d050910a0000-3d050910affff : tg3
        3d050910b0000-3d050910bffff : 0003:07:00.3
          3d050910b0000-3d050910bffff : tg3
  3d05094000000-3d05096ffffff : PCI Bus 0003:01
    3d05094000000-3d050967fffff : PCI Bus 0003:02
      3d05094000000-3d050947fffff : PCI Bus 0003:03
        3d05094000000-3d0509400ffff : 0003:03:00.0
          3d05094000000-3d0509400ffff : xhci_hcd
        3d05094010000-3d05094011fff : 0003:03:00.0
      3d05094800000-3d05094ffffff : PCI Bus 0003:04
        3d05094800000-3d0509481ffff : 0003:04:00.0
        3d05094820000-3d0509482ffff : 0003:04:00.0
          3d05094820000-3d0509482ffff : ipr
        3d05094830000-3d0509483ffff : 0003:04:00.0
          3d05094830000-3d0509483ffff : ipr
      3d05095000000-3d050957fffff : PCI Bus 0003:05
        3d05095000000-3d050950fffff : 0003:05:00.0
        3d05095100000-3d050951fffff : 0003:05:00.0
      3d05095800000-3d05095ffffff : PCI Bus 0003:06
        3d05095800000-3d0509587ffff : 0003:06:00.0
        3d05095880000-3d050958fffff : 0003:06:00.1
        3d05095900000-3d0509597ffff : 0003:06:00.2
        3d05095980000-3d050959fffff : 0003:06:00.3
      3d05096000000-3d050967fffff : PCI Bus 0003:07
        3d05096000000-3d0509607ffff : 0003:07:00.0
        3d05096080000-3d050960fffff : 0003:07:00.1
        3d05096100000-3d0509617ffff : 0003:07:00.2
        3d05096180000-3d050961fffff : 0003:07:00.3
    3d05096800000-3d0509683ffff : 0003:01:00.0
3d20080000000-3d200fffeffff : /pciex@3fffe42000000
3d21080000000-3d210fffeffff : /pciex@3fffe42100000
  3d21080000000-3d210807fffff : PCI Bus 0005:01
    3d21080000000-3d2108003ffff : 0005:01:00.0
    3d21080040000-3d2108007ffff : 0005:01:00.1
    3d21080080000-3d21080083fff : 0005:01:00.0
      3d21080080000-3d21080083fff : lpfc
    3d21080084000-3d21080087fff : 0005:01:00.1
      3d21080084000-3d21080087fff : lpfc
    3d21080088000-3d21080088fff : 0005:01:00.0
      3d21080088000-3d21080088fff : lpfc
    3d21080089000-3d21080089fff : 0005:01:00.1
      3d21080089000-3d21080089fff : lpfc
3d24080000000-3d240fffeffff : /pciex@3fffe42400000
  3d24080000000-3d240807fffff : PCI Bus 0006:01
    3d24080000000-3d2408007ffff : 0006:01:00.0
    3d24080080000-3d240800fffff : 0006:01:00.1
    3d24080100000-3d2408017ffff : 0006:01:00.2
    3d24080180000-3d240801fffff : 0006:01:00.3
    3d24080200000-3d2408027ffff : 0006:01:00.4
    3d24080280000-3d240802fffff : 0006:01:00.5
  3d24080800000-3d24080ffffff : PCI Bus 0006:01
    3d24080800000-3d24080807fff : 0006:01:00.0
      3d24080800000-3d24080807fff : be2net
    3d24080808000-3d2408080ffff : 0006:01:00.1
      3d24080808000-3d2408080ffff : be2net
    3d24080810000-3d24080817fff : 0006:01:00.2
      3d24080810000-3d24080817fff : be2net
    3d24080818000-3d2408081ffff : 0006:01:00.3
      3d24080818000-3d2408081ffff : be2net
    3d24080820000-3d24080827fff : 0006:01:00.4
      3d24080820000-3d24080827fff : lpfc
    3d24080828000-3d2408082ffff : 0006:01:00.5
      3d24080828000-3d2408082ffff : lpfc
    3d24080830000-3d24080830fff : 0006:01:00.0
      3d24080830000-3d24080830fff : be2net
3d25080000000-3d250fffeffff : /pciex@3fffe42500000
  3d25080000000-3d25080ffffff : PCI Bus 0007:01
    3d25080000000-3d25080ffffff : 0007:01:00.0
      3d25080000000-3d25080ffffff : ipr
  3d25081000000-3d250817fffff : PCI Bus 0007:01
    3d25081000000-3d2508103ffff : 0007:01:00.0
      3d25081000000-3d2508103ffff : ipr
    3d25081040000-3d2508105ffff : 0007:01:00.0
3ffff80020000-3ffff80020fff : CPU 0 [0x20] Interrupt Presentation
3ffff80021000-3ffff80021fff : CPU 1 [0x21] Interrupt Presentation
3ffff80022000-3ffff80022fff : CPU 2 [0x22] Interrupt Presentation
3ffff80023000-3ffff80023fff : CPU 3 [0x23] Interrupt Presentation
3ffff80024000-3ffff80024fff : CPU 4 [0x24] Interrupt Presentation
3ffff80025000-3ffff80025fff : CPU 5 [0x25] Interrupt Presentation
3ffff80026000-3ffff80026fff : CPU 6 [0x26] Interrupt Presentation
3ffff80027000-3ffff80027fff : CPU 7 [0x27] Interrupt Presentation
3ffff80028000-3ffff80028fff : CPU 8 [0x28] Interrupt Presentation
3ffff80029000-3ffff80029fff : CPU 9 [0x29] Interrupt Presentation
3ffff8002a000-3ffff8002afff : CPU 10 [0x2a] Interrupt Presentation
3ffff8002b000-3ffff8002bfff : CPU 11 [0x2b] Interrupt Presentation
3ffff8002c000-3ffff8002cfff : CPU 12 [0x2c] Interrupt Presentation
3ffff8002d000-3ffff8002dfff : CPU 13 [0x2d] Interrupt Presentation
3ffff8002e000-3ffff8002efff : CPU 14 [0x2e] Interrupt Presentation
3ffff8002f000-3ffff8002ffff : CPU 15 [0x2f] Interrupt Presentation
3ffff80060000-3ffff80060fff : CPU 16 [0x60] Interrupt Presentation
3ffff80061000-3ffff80061fff : CPU 17 [0x61] Interrupt Presentation
3ffff80062000-3ffff80062fff : CPU 18 [0x62] Interrupt Presentation
3ffff80063000-3ffff80063fff : CPU 19 [0x63] Interrupt Presentation
3ffff80064000-3ffff80064fff : CPU 20 [0x64] Interrupt Presentation
3ffff80065000-3ffff80065fff : CPU 21 [0x65] Interrupt Presentation
3ffff80066000-3ffff80066fff : CPU 22 [0x66] Interrupt Presentation
3ffff80067000-3ffff80067fff : CPU 23 [0x67] Interrupt Presentation
3ffff80070000-3ffff80070fff : CPU 24 [0x70] Interrupt Presentation
3ffff80071000-3ffff80071fff : CPU 25 [0x71] Interrupt Presentation
3ffff80072000-3ffff80072fff : CPU 26 [0x72] Interrupt Presentation
3ffff80073000-3ffff80073fff : CPU 27 [0x73] Interrupt Presentation
3ffff80074000-3ffff80074fff : CPU 28 [0x74] Interrupt Presentation
3ffff80075000-3ffff80075fff : CPU 29 [0x75] Interrupt Presentation
3ffff80076000-3ffff80076fff : CPU 30 [0x76] Interrupt Presentation
3ffff80077000-3ffff80077fff : CPU 31 [0x77] Interrupt Presentation
3ffff80120000-3ffff80120fff : CPU 96 [0xa0] Interrupt Presentation
3ffff80121000-3ffff80121fff : CPU 97 [0xa1] Interrupt Presentation
3ffff80122000-3ffff80122fff : CPU 98 [0xa2] Interrupt Presentation
3ffff80123000-3ffff80123fff : CPU 99 [0xa3] Interrupt Presentation
3ffff80124000-3ffff80124fff : CPU 100 [0xa4] Interrupt Presentation
3ffff80125000-3ffff80125fff : CPU 101 [0xa5] Interrupt Presentation
3ffff80126000-3ffff80126fff : CPU 102 [0xa6] Interrupt Presentation
3ffff80127000-3ffff80127fff : CPU 103 [0xa7] Interrupt Presentation
3ffff80128000-3ffff80128fff : CPU 104 [0xa8] Interrupt Presentation
3ffff80129000-3ffff80129fff : CPU 105 [0xa9] Interrupt Presentation
3ffff8012a000-3ffff8012afff : CPU 106 [0xaa] Interrupt Presentation
3ffff8012b000-3ffff8012bfff : CPU 107 [0xab] Interrupt Presentation
3ffff8012c000-3ffff8012cfff : CPU 108 [0xac] Interrupt Presentation
3ffff8012d000-3ffff8012dfff : CPU 109 [0xad] Interrupt Presentation
3ffff8012e000-3ffff8012efff : CPU 110 [0xae] Interrupt Presentation
3ffff8012f000-3ffff8012ffff : CPU 111 [0xaf] Interrupt Presentation
3ffff80168000-3ffff80168fff : CPU 112 [0xe8] Interrupt Presentation
3ffff80169000-3ffff80169fff : CPU 113 [0xe9] Interrupt Presentation
3ffff8016a000-3ffff8016afff : CPU 114 [0xea] Interrupt Presentation
3ffff8016b000-3ffff8016bfff : CPU 115 [0xeb] Interrupt Presentation
3ffff8016c000-3ffff8016cfff : CPU 116 [0xec] Interrupt Presentation
3ffff8016d000-3ffff8016dfff : CPU 117 [0xed] Interrupt Presentation
3ffff8016e000-3ffff8016efff : CPU 118 [0xee] Interrupt Presentation
3ffff8016f000-3ffff8016ffff : CPU 119 [0xef] Interrupt Presentation
3ffff80170000-3ffff80170fff : CPU 120 [0xf0] Interrupt Presentation
3ffff80171000-3ffff80171fff : CPU 121 [0xf1] Interrupt Presentation
3ffff80172000-3ffff80172fff : CPU 122 [0xf2] Interrupt Presentation
3ffff80173000-3ffff80173fff : CPU 123 [0xf3] Interrupt Presentation
3ffff80174000-3ffff80174fff : CPU 124 [0xf4] Interrupt Presentation
3ffff80175000-3ffff80175fff : CPU 125 [0xf5] Interrupt Presentation
3ffff80176000-3ffff80176fff : CPU 126 [0xf6] Interrupt Presentation
3ffff80177000-3ffff80177fff : CPU 127 [0xf7] Interrupt Presentation
3ffff80820000-3ffff80820fff : CPU 32 [0x820] Interrupt Presentation
3ffff80821000-3ffff80821fff : CPU 33 [0x821] Interrupt Presentation
3ffff80822000-3ffff80822fff : CPU 34 [0x822] Interrupt Presentation
3ffff80823000-3ffff80823fff : CPU 35 [0x823] Interrupt Presentation
3ffff80824000-3ffff80824fff : CPU 36 [0x824] Interrupt Presentation
3ffff80825000-3ffff80825fff : CPU 37 [0x825] Interrupt Presentation
3ffff80826000-3ffff80826fff : CPU 38 [0x826] Interrupt Presentation
3ffff80827000-3ffff80827fff : CPU 39 [0x827] Interrupt Presentation
3ffff80860000-3ffff80860fff : CPU 40 [0x860] Interrupt Presentation
3ffff80861000-3ffff80861fff : CPU 41 [0x861] Interrupt Presentation
3ffff80862000-3ffff80862fff : CPU 42 [0x862] Interrupt Presentation
3ffff80863000-3ffff80863fff : CPU 43 [0x863] Interrupt Presentation
3ffff80864000-3ffff80864fff : CPU 44 [0x864] Interrupt Presentation
3ffff80865000-3ffff80865fff : CPU 45 [0x865] Interrupt Presentation
3ffff80866000-3ffff80866fff : CPU 46 [0x866] Interrupt Presentation
3ffff80867000-3ffff80867fff : CPU 47 [0x867] Interrupt Presentation
3ffff80868000-3ffff80868fff : CPU 48 [0x868] Interrupt Presentation
3ffff80869000-3ffff80869fff : CPU 49 [0x869] Interrupt Presentation
3ffff8086a000-3ffff8086afff : CPU 50 [0x86a] Interrupt Presentation
3ffff8086b000-3ffff8086bfff : CPU 51 [0x86b] Interrupt Presentation
3ffff8086c000-3ffff8086cfff : CPU 52 [0x86c] Interrupt Presentation
3ffff8086d000-3ffff8086dfff : CPU 53 [0x86d] Interrupt Presentation
3ffff8086e000-3ffff8086efff : CPU 54 [0x86e] Interrupt Presentation
3ffff8086f000-3ffff8086ffff : CPU 55 [0x86f] Interrupt Presentation
3ffff80870000-3ffff80870fff : CPU 56 [0x870] Interrupt Presentation
3ffff80871000-3ffff80871fff : CPU 57 [0x871] Interrupt Presentation
3ffff80872000-3ffff80872fff : CPU 58 [0x872] Interrupt Presentation
3ffff80873000-3ffff80873fff : CPU 59 [0x873] Interrupt Presentation
3ffff80874000-3ffff80874fff : CPU 60 [0x874] Interrupt Presentation
3ffff80875000-3ffff80875fff : CPU 61 [0x875] Interrupt Presentation
3ffff80876000-3ffff80876fff : CPU 62 [0x876] Interrupt Presentation
3ffff80877000-3ffff80877fff : CPU 63 [0x877] Interrupt Presentation
3ffff80928000-3ffff80928fff : CPU 64 [0x8a8] Interrupt Presentation
3ffff80929000-3ffff80929fff : CPU 65 [0x8a9] Interrupt Presentation
3ffff8092a000-3ffff8092afff : CPU 66 [0x8aa] Interrupt Presentation
3ffff8092b000-3ffff8092bfff : CPU 67 [0x8ab] Interrupt Presentation
3ffff8092c000-3ffff8092cfff : CPU 68 [0x8ac] Interrupt Presentation
3ffff8092d000-3ffff8092dfff : CPU 69 [0x8ad] Interrupt Presentation
3ffff8092e000-3ffff8092efff : CPU 70 [0x8ae] Interrupt Presentation
3ffff8092f000-3ffff8092ffff : CPU 71 [0x8af] Interrupt Presentation
3ffff80930000-3ffff80930fff : CPU 72 [0x8b0] Interrupt Presentation
3ffff80931000-3ffff80931fff : CPU 73 [0x8b1] Interrupt Presentation
3ffff80932000-3ffff80932fff : CPU 74 [0x8b2] Interrupt Presentation
3ffff80933000-3ffff80933fff : CPU 75 [0x8b3] Interrupt Presentation
3ffff80934000-3ffff80934fff : CPU 76 [0x8b4] Interrupt Presentation
3ffff80935000-3ffff80935fff : CPU 77 [0x8b5] Interrupt Presentation
3ffff80936000-3ffff80936fff : CPU 78 [0x8b6] Interrupt Presentation
3ffff80937000-3ffff80937fff : CPU 79 [0x8b7] Interrupt Presentation
3ffff80960000-3ffff80960fff : CPU 80 [0x8e0] Interrupt Presentation
3ffff80961000-3ffff80961fff : CPU 81 [0x8e1] Interrupt Presentation
3ffff80962000-3ffff80962fff : CPU 82 [0x8e2] Interrupt Presentation
3ffff80963000-3ffff80963fff : CPU 83 [0x8e3] Interrupt Presentation
3ffff80964000-3ffff80964fff : CPU 84 [0x8e4] Interrupt Presentation
3ffff80965000-3ffff80965fff : CPU 85 [0x8e5] Interrupt Presentation
3ffff80966000-3ffff80966fff : CPU 86 [0x8e6] Interrupt Presentation
3ffff80967000-3ffff80967fff : CPU 87 [0x8e7] Interrupt Presentation
3ffff80970000-3ffff80970fff : CPU 88 [0x8f0] Interrupt Presentation
3ffff80971000-3ffff80971fff : CPU 89 [0x8f1] Interrupt Presentation
3ffff80972000-3ffff80972fff : CPU 90 [0x8f2] Interrupt Presentation
3ffff80973000-3ffff80973fff : CPU 91 [0x8f3] Interrupt Presentation
3ffff80974000-3ffff80974fff : CPU 92 [0x8f4] Interrupt Presentation
3ffff80975000-3ffff80975fff : CPU 93 [0x8f5] Interrupt Presentation
3ffff80976000-3ffff80976fff : CPU 94 [0x8f6] Interrupt Presentation
3ffff80977000-3ffff80977fff : CPU 95 [0x8f7] Interrupt Presentation

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

0000:00:00.0 PCI bridge: IBM Device 03dc
0001:00:00.0 PCI bridge: IBM Device 03dc
0001:01:00.0 PCI bridge: PLX Technology, Inc. PEX 8732 32-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch (rev ca)
0001:02:01.0 PCI bridge: PLX Technology, Inc. PEX 8732 32-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch (rev ca)
0001:02:08.0 PCI bridge: PLX Technology, Inc. PEX 8732 32-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch (rev ca)
0001:02:09.0 PCI bridge: PLX Technology, Inc. PEX 8732 32-lane, 8-Port PCI Express Gen 3 (8.0 GT/s) Switch (rev ca)
0001:03:00.0 Fibre Channel: Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter (rev 03)
0001:03:00.1 Fibre Channel: Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter (rev 03)
0001:04:00.0 RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) (rev 01)
0001:05:00.0 RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) (rev 01)
0002:00:00.0 PCI bridge: IBM Device 03dc
0002:01:00.0 Fibre Channel: Emulex Corporation Lancer-X: LightPulse Fibre Channel Host Adapter (rev 10)
0002:01:00.1 Fibre Channel: Emulex Corporation Lancer-X: LightPulse Fibre Channel Host Adapter (rev 10)
0003:00:00.0 PCI bridge: IBM Device 03dc
0003:01:00.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:01.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:08.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:09.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:10.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:02:11.0 PCI bridge: PLX Technology, Inc. Device 8748 (rev ca)
0003:03:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 3.0 xHCI Host Controller (rev 02)
0003:04:00.0 RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) (rev 01)
0003:05:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
0003:06:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:06:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:06:00.2 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:06:00.3 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:07:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:07:00.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:07:00.2 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0003:07:00.3 Ethernet controller: Broadcom Corporation NetXtreme BCM5719 Gigabit Ethernet PCIe (rev 01)
0004:00:00.0 PCI bridge: IBM Device 03dc
0005:00:00.0 PCI bridge: IBM Device 03dc
0005:01:00.0 Fibre Channel: Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter (rev 03)
0005:01:00.1 Fibre Channel: Emulex Corporation Saturn-X: LightPulse Fibre Channel Host Adapter (rev 03)
0006:00:00.0 PCI bridge: IBM Device 03dc
0006:01:00.0 Ethernet controller: Emulex Corporation OneConnect NIC (Lancer) (rev 10)
0006:01:00.1 Ethernet controller: Emulex Corporation OneConnect NIC (Lancer) (rev 10)
0006:01:00.2 Ethernet controller: Emulex Corporation OneConnect NIC (Lancer) (rev 10)
0006:01:00.3 Ethernet controller: Emulex Corporation OneConnect NIC (Lancer) (rev 10)
0006:01:00.4 Fibre Channel: Emulex Corporation OneConnect FCoE Initiator (Lancer) (rev 10)
0006:01:00.5 Fibre Channel: Emulex Corporation OneConnect FCoE Initiator (Lancer) (rev 10)
0007:00:00.0 PCI bridge: IBM Device 03dc
0007:01:00.0 RAID bus controller: IBM Obsidian-E PCI-E SCSI controller (rev 01)

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci_mellanox.txt"

0003:05:00.0 Network controller: Mellanox Technologies MT27500 Family [ConnectX-3]
	Subsystem: Mellanox Technologies Device 0061
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 510
	Region 0: Memory at 3d05081000000 (64-bit, non-prefetchable) [size=1M]
	Region 2: Memory at 3d05083800000 (64-bit, prefetchable) [size=8M]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Vital Product Data
		Product Name: CX353A - ConnectX-3 QSFP
		Read-only fields:
			[PN] Part number: 00W0038              
			[EC] Engineering changes: A1
			[SN] Serial number: 00W0038YK502000070P     
			[V0] Vendor specific: PCIe Gen3 x8    
			[RV] Reserved: checksum good, 0 byte(s) reserved
		Read/write fields:
			[V1] Vendor specific: N/A   
			[YA] Asset tag: N/A                     
			[RW] Read-write area: 105 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 253 byte(s) free
			[RW] Read-write area: 252 byte(s) free
		End
	Capabilities: [9c] MSI-X: Enable+ Count=128 Masked-
		Vector table: BAR=0 offset=0007c000
		PBA: BAR=0 offset=0007d000
	Capabilities: [60] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #8, Speed 8GT/s, Width x8, ASPM L0s, Latency L0 unlimited, L1 unlimited
			ClockPM- Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x8, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [148 v1] Device Serial Number 00-02-c9-03-00-15-a7-30
	Capabilities: [18c v1] #19
	Kernel driver in use: mlx4_core


--Qxx1br4bt0+wmkIi--

