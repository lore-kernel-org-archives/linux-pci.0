Return-Path: <SRS0=wwcj=JG=intel.com=lkp@kernel.org>
Return-Path: <SRS0=wwcj=JG=intel.com=lkp@kernel.org>
Date: Wed, 20 Jun 2018 11:13:40 +0800
From: kbuild test robot <lkp@intel.com>
To: Rajat Jain <rajatja@google.com>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>,
	Oza Pawandeep <poza@codeaurora.org>,
	Keith Busch <keith.busch@intel.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Thomas Tai <thomas.tai@oracle.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
	Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com,
	helgaas@kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v3 4/5] PCI/AER: Add sysfs attributes for rootport
 cumulative stats
Message-ID: <201806201004.xjxc8kiz%fengguang.wu@intel.com>
References: <20180620011210.254601-4-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620011210.254601-4-rajatja@google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Rajat,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.18-rc1 next-20180619]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Rajat-Jain/PCI-AER-Define-and-allocate-aer_stats-structure-for-AER-capable-devices/20180620-091551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/pci/pcie/aer.c:689:6: sparse: symbol 'pci_rootport_aer_stats_incr' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
