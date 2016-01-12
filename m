Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Jan 2016 18:08:29 +0000
From: Keith Busch <keith.busch@intel.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
	x86@kernel.org, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8] x86/PCI: Initial commit for new VMD device driver
Message-ID: <20160112180829.GB28857@localhost.localdomain>
References: <1452616119-11450-2-git-send-email-keith.busch@intel.com>
 <201601130151.Y87x1uES%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201601130151.Y87x1uES%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 13, 2016 at 01:40:33AM +0800, kbuild test robot wrote:
> [auto build test ERROR on tip/x86/core]

Looks a reason to repost the entire series, or maybe I should have
replied to the existing thread with the dependencies.


> url:    https://github.com/0day-ci/linux/commits/Keith-Busch/x86-PCI-Initial-commit-for-new-VMD-device-driver/20160113-003207
> config: x86_64-allmodconfig (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/x86/pci/vmd.c:85:20: error: field 'dma_domain' has incomplete type
>      struct dma_domain dma_domain;
