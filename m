Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 8 Nov 2016 13:17:02 +0800
From: kbuild test robot <lkp@intel.com>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
Message-ID: <201611081319.MFXrz420%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, gabriele.paoloni@huawei.com, benh@kernel.crashing.org,
 will.deacon@arm.com, linuxarm@huawei.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org,
 liviu.dudau@arm.com, john.garry@huawei.com, olof@lixom.net, robh+dt@kernel.org,
 bhelgaas@google.com, kantyzc@163.com, zhichang.yuan02@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 kbuild-all@01.org, zourongrong@gmail.com
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi zhichang.yuan,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.9-rc4 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/ARM64-LPC-legacy-ISA-I-O-support/20161108-114742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: mips-ath25_defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   In file included from arch/mips/pci/pci.c:18:0:
>> include/linux/pci.h:2113:25: error: expected identifier or '(' before numeric constant
    #define PCIBIOS_MIN_IO  0
                            ^
>> arch/mips/pci/pci.c:34:15: note: in expansion of macro 'PCIBIOS_MIN_IO'
    unsigned long PCIBIOS_MIN_IO;
                  ^~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:6:0,
                    from include/linux/kernel.h:6,
                    from include/asm-generic/bug.h:13,
                    from arch/mips/include/asm/bug.h:41,
                    from include/linux/bug.h:4,
                    from arch/mips/pci/pci.c:11:
>> include/linux/pci.h:2113:25: error: expected identifier or '(' before numeric constant
    #define PCIBIOS_MIN_IO  0
                            ^
   include/linux/export.h:57:21: note: in definition of macro '___EXPORT_SYMBOL'
     extern typeof(sym) sym;     \
                        ^~~
>> arch/mips/pci/pci.c:326:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(PCIBIOS_MIN_IO);
    ^~~~~~~~~~~~~
   arch/mips/pci/pci.c:326:15: note: in expansion of macro 'PCIBIOS_MIN_IO'
    EXPORT_SYMBOL(PCIBIOS_MIN_IO);
                  ^~~~~~~~~~~~~~
>> include/linux/export.h:66:21: error: lvalue required as unary '&' operand
     = { (unsigned long)&sym, __kstrtab_##sym }
                        ^
>> include/linux/export.h:94:25: note: in expansion of macro '___EXPORT_SYMBOL'
    #define __EXPORT_SYMBOL ___EXPORT_SYMBOL
                            ^~~~~~~~~~~~~~~~
   include/linux/export.h:98:2: note: in expansion of macro '__EXPORT_SYMBOL'
     __EXPORT_SYMBOL(sym, "")
     ^~~~~~~~~~~~~~~
>> arch/mips/pci/pci.c:326:1: note: in expansion of macro 'EXPORT_SYMBOL'
    EXPORT_SYMBOL(PCIBIOS_MIN_IO);
    ^~~~~~~~~~~~~

vim +2113 include/linux/pci.h

  2107	
  2108	/*
  2109	 * define this macro here to refrain from compilation error for some
  2110	 * platforms. Please keep this macro at the end of this header file.
  2111	 */
  2112	#ifndef PCIBIOS_MIN_IO
> 2113	#define PCIBIOS_MIN_IO		0
  2114	#endif
  2115	
  2116	#endif /* LINUX_PCI_H */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--J/dobhs11T7y2rNN--
