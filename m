Return-Path: <SRS0=6E4e=KR=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=6E4e=KR=h08.hostsharing.net=foo00@kernel.org>
Date: Thu, 2 Aug 2018 10:46:57 +0200
From: Lukas Wunner <lukas@wunner.de>
To: gokul cg <gokuljnpr@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
	linux-pci@vger.kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Differentiate between surprise and safe
 removal
Message-ID: <20180802084657.GA21267@wunner.de>
References: <dac488604766f3dcb948e702210ecc381c4f907b.1533015755.git.lukas@wunner.de>
 <20180801164358.GI2534@lahna.fi.intel.com>
 <20180801171512.GA28440@wunner.de>
 <20180802072036.GN2534@lahna.fi.intel.com>
 <CAFP4jM8AYG7hmkC_rYgXAfLoJmkJuW0e1UbgiayGrCPbb_yw8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFP4jM8AYG7hmkC_rYgXAfLoJmkJuW0e1UbgiayGrCPbb_yw8A@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 02, 2018 at 12:59:18PM +0530, gokul cg wrote:
> I am suspecting a possible race condition in the kernel between PCI driver
> and AER handling.
> 
> Because of the same kernel panic happens from worker thread which handles
> bottom half of aer irq.
> 
> I am seeing this issue when I suddenly power off PCI card which
> supports/enabled PCIE AER error reporting.
> 
> While powering off PCI device, AER driver will get AER IRQ for the device,
> from AER IRQ handler, it will cache AER error code and schedule worker
> thread to handle error.
> 
> The PCIe device will get removed from PCI tree before worker thread
> completes its task and kernel panic is  happening when worker thread tries
> to access PCI device's config space.
> 
> #5 [ffff88027469fc70] general_protection at ffffffff8176cdf2
>     [exception RIP: pci_bus_read_config_dword+100]
> #6 [ffff88027469fd50] pci_find_next_ext_capability at ffffffff81345d7b
> #7 [ffff88027469fd90] pci_find_ext_capability at ffffffff81347225
> #8 [ffff88027469fda0] get_device_error_info at ffffffff81356c4d
> #9 [ffff88027469fdd0] aer_isr at ffffffff81357a38
> #10 [ffff88027469fe28] process_one_work at ffffffff8105d4c0
> #11 [ffff88027469fe70] worker_thread at ffffffff8105e251
> #12 [ffff88027469fed0] kthread at ffffffff81064260
> #13 [ffff88027469ff50] ret_from_fork at ffffffff81773a38
> 
> I have tested it on kernel 3.10 . But from source i could see that this
> case is still relevant for latest Linux source .

I'm not really familiar with the AER driver, but the problem is
actually easy to spot:

find_source_device() walks the hierarchy and saves a pointer to
pci_dev's in an array.  That array is later traversed and the
pci_dev's are accessed.

The solution is to acquire a ref on each device in add_error_device():

-	e_info->dev[e_info->error_dev_num] = dev;
+	e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);

Then release the ref aer_process_err_devices() by calling pci_dev_put().

I believe there's an ongoing refactoring of the AER driver and the
issue may be addressed in the course of it, but as a quick fix for
an ancient v3.10 kernel, the above should do the trick.

HTH,

Lukas
