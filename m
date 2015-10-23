Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 23 Oct 2015 18:47:46 +0800
From: kbuild test robot <lkp@intel.com>
To: Hannes Reinecke <hare@suse.de>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] pci: Update VPD size with correct length
Message-ID: <201510231810.RlZ52VfY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445591396-95395-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Hannes,

[auto build test WARNING on pci/next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Hannes-Reinecke/pci-Update-VPD-size-with-correct-length/20151023-171224
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/access.c:499:1: sparse: symbol 'pci_vpd_pci22_size' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
