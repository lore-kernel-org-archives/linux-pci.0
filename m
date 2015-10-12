Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 12 Oct 2015 22:46:42 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Yinghai Lu <yinghai@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 07/60] PCI: kill wrong quirk about M7101
In-Reply-To: <1444340359-8011-8-git-send-email-yinghai@kernel.org>
Message-ID: <alpine.LRH.2.20.1510122243190.7065@math.ut.ee>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org> <1444340359-8011-8-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Meelis reported that qla2000 driver does not get loaded on one sparc system.
> 
> schizo f00732d0: PCI host bridge to bus 0001:00
> pci_bus 0001:00: root bus resource [io  0x7fe01000000-0x7fe01ffffff] (bus address [0x0000-0xffffff])
> pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
> pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
> pci 0001:00:07.0: can't claim BAR 0 [io  0x7fe01000000-0x7fe0100ffff]: address conflict with 0001:00:06.0 [io  0x7fe01000600-0x7fe0100061f]
> 
> So the quirk for M7101 claim the io range early.
> 
> According to spec with M7101 in M1543 page 103/104,
> 	http://www.versalogic.com/Support/Downloads/pdf/ali1543.pdf
> 0xe0, and 0xe2 do not include address info for acpi/smb.
> 
> Kill wrong quirk about them.
> 
> Link: http://kodu.ut.ee/~mroos/dm/dm.v240
> Link: http://kodu.ut.ee/~mroos/dm/dm.sb100
> Reported-by: Meelis Roos <mroos@linux.ee>
> Cc: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

I tested it on Sub Blade 100 on top of 4.3-rc5 without your other 
patchset. The quirk messages are gone but now there are even more BAR 
allocation messages:

http://kodu.ut.ee/~mroos/dm/dm.sb100+quirkpatch

Does your for-pci-v4.4-next patchset in your git repo already contain 
that? On V240 it seemed to be applied in your git.

-- 
Meelis Roos (mroos@linux.ee)
