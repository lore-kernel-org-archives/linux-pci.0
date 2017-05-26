Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: kbuild test robot <lkp@intel.com>
Subject: RE: [PATCH v9 6/7] LPC: Add the ACPI LPC support
Date: Fri, 26 May 2017 10:12:43 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A6CABE@FRAEML521-MBX.china.huawei.com>
References: <1495712248-5232-7-git-send-email-gabriele.paoloni@huawei.com>
 <201705261155.i7TAp44f%fengguang.wu@intel.com>
In-Reply-To: <201705261155.i7TAp44f%fengguang.wu@intel.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "minyard@acm.org" <minyard@acm.org>, John Garry <john.garry@huawei.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 "kbuild-all@01.org" <kbuild-all@01.org>, "olof@lixom.net" <olof@lixom.net>,
 "brian.starkey@arm.com" <brian.starkey@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[...]

> Hi zhichang.yuan,
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.12-rc2 next-20170525]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Gabriele-Paoloni/LPC-
> legacy-ISA-I-O-support/20170526-033719
> config: ia64-allmodconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 6.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=ia64
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `lpc_host_io_setup':
> >> hisi_lpc.c:(.text+0x252): undefined reference to
> `acpi_set_logic_pio_resource'
>    drivers/built-in.o: In function `acpi_scan_init':
>    (.init.text+0x6742): undefined reference to
> `acpi_indirectio_scan_init'

I believe the problem is in patch 4/7

config HISILICON_LPC
	bool "Support for ISA I/O space on Hisilicon Hip0X"
	depends on (ARM64 && ARCH_HISI) || COMPILE_TEST
                                         ^^^^^^^^^^^^

the COMPILE_TEST above allowing HISILICON_LPC also for other architectures. 
I think we can remove "|| COMPILE_TEST"...I will fix it in v10

Gab

+	select LOGIC_PIO
+	select INDIRECT_PIO
+	help
+	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
+	  on Hisilicon Hip0X SoC.

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
