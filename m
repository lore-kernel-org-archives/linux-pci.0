Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41543 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbbBYXJ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 18:09:29 -0500
Received: by iecrd18 with SMTP id rd18so9368136iec.8
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2015 15:09:29 -0800 (PST)
Date: Wed, 25 Feb 2015 17:09:25 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, linux-pci@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-alpha@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, Liviu Dudau <liviu@dudau.co.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 00/30] Refine PCI scan interfaces and make generic pci
 host bridge
Message-ID: <20150225230925.GQ6220@google.com>
References: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 21, 2015 at 08:29:55AM +0800, Yijing Wang wrote:
> v1->v2:
> 	Split pci_host_bridge_list into a new patch, remove .phb_probe_mode
> 	and rework powerpc .phb_of_scan_bus() for simpilicty suggested by
> 	Arnd. Refresh some patch description log, and add a new patch to fix
> 	build warning in ia64.
> 
> This series is based on Bjorn's pci-next branch.

Hi Yijing,

Would you mind rebasing this to v4.0-rc1?  It doesn't apply quite cleanly
any more.

Thanks,
  Bjorn
