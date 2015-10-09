Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1444407602.17726.8.camel@oracle.com>
Subject: Re: [PATCH v7 07/60] PCI: kill wrong quirk about M7101
From: Khalid Aziz <khalid.aziz@oracle.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Meelis Roos <mroos@linux.ee>
Date: Fri, 09 Oct 2015 10:20:02 -0600
In-Reply-To: <1444340359-8011-8-git-send-email-yinghai@kernel.org>
References: <1444340359-8011-1-git-send-email-yinghai@kernel.org>
	 <1444340359-8011-8-git-send-email-yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-10-08 at 14:38 -0700, Yinghai Lu wrote:
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


Tested on sparc platforms

Tested-by: Khalid Aziz <khalid.aziz@oracle.com> 


