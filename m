Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAFGCpxwmuEKdc6FF=OmQz8tEipbcO+PjkwmywXLtY5=UxSeKvg@mail.gmail.com>
References: <20170515062745.70082-1-songxiaowei@hisilicon.com>
 <201705151738.ls8RIrFp%fengguang.wu@intel.com>
 <CAFGCpxwmuEKdc6FF=OmQz8tEipbcO+PjkwmywXLtY5=UxSeKvg@mail.gmail.com>
From: Guodong Xu <guodong.xu@linaro.org>
Date: Mon, 15 May 2017 17:37:43 +0800
Message-ID: <CAFGCpxwiBky85WPiusic_UOtMq2VtaG2XC0VG2Hrgz7jtBScUQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: hi3660: add pcie node
To: kbuild test robot <lkp@intel.com>, "xuwei (O)" <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 devicetree@vger.kernel.org, Duc Dang <dhdang@apm.com>,
 Arnd Bergmann <arnd@arndb.de>, Wangbinghui <wangbinghui@hisilicon.com>,
 jingoohan1@gmail.com, Suzhuangluan <suzhuangluan@hisilicon.com>,
 Niklas Cassel <niklas.cassel@axis.com>, linux-pci@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Kishon <kishon@ti.com>, keith.busch@intel.com, kbuild-all@01.org,
 "liudongdong \(C\)" <liudongdong3@huawei.com>,
 Song Xiaowei <songxiaowei@hisilicon.com>, Bjorn Helgaas <bhelgaas@google.com>,
 tn@semihalf.com, "Chenfeng \(puck\)" <puck.chen@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This PCIe node has dependencies on &crg_ctrl and &gpio11. However,
both of them are not appearing in mainline kernel tree yet. Sorry
about that. But I do have a plan to send all dts related changes to
maillist within this week, no later than this Wed (17/May). Would it
be possible you maintainers review this patch in parallel?

+Device tree maintainers.

-Guodong

>
> On Mon, May 15, 2017 at 5:18 PM, kbuild test robot <lkp@intel.com> wrote:
>>
>> Hi Song,
>>
>> [auto build test ERROR on pci/next]
>> [also build test ERROR on v4.12-rc1 next-20170515]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Song-Xiaowei/arm64-dts-hi3660-add-pcie-node/20170515-144035
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
>> config: arm64-defconfig (attached as .config)
>> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm64
>>
>> All errors (new ones prefixed by >>):
>>
>> >> Error: arch/arm64/boot/dts/hisilicon/hi3660.dtsi:180.24-25 syntax error
>>    FATAL ERROR: Unable to parse input tree
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
