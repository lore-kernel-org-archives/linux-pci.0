Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:37996
	"EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932190AbcBZHtv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Feb 2016 02:49:51 -0500
Subject: Re: [PATCH v3 6/6] PCI: xilinx: Allow build on MIPS platforms
To: Bjorn Helgaas <helgaas@kernel.org>,
	Paul Burton <paul.burton@imgtec.com>
References: <1454602213-967-1-git-send-email-paul.burton@imgtec.com>
 <1454602213-967-7-git-send-email-paul.burton@imgtec.com>
 <CAL_JsqLRMiJ-0j_PrXSKqf6MrRfyqbDGaiaiEn4rAoFaCNgtKQ@mail.gmail.com>
 <20160204175325.GB31145@NP-P-BURTON> <20160225154326.GE8120@localhost>
CC: Rob Herring <robh@kernel.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Bharat Kumar Gogada <bharatku@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"Ley Foon Tan" <lftan@altera.com>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	"Scott Branden" <sbranden@broadcom.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Duc Dang <dhdang@apm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ray Jui <rjui@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <56D00390.7030600@xilinx.com>
Date: Fri, 26 Feb 2016 08:49:36 +0100
MIME-Version: 1.0
In-Reply-To: <20160225154326.GE8120@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25.2.2016 16:43, Bjorn Helgaas wrote:
> On Thu, Feb 04, 2016 at 05:53:25PM +0000, Paul Burton wrote:
>> On Thu, Feb 04, 2016 at 11:46:28AM -0600, Rob Herring wrote:
>>> On Thu, Feb 4, 2016 at 10:10 AM, Paul Burton <paul.burton@imgtec.com> wrote:
>>>> Allow the xilinx-pcie driver to be built on MIPS platforms. This will be
>>>> used on the MIPS Boston board.
>>>>
>>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> - Split out from Boston patchset.
>>>>
>>>> Changes in v2: None
>>>>
>>>>  drivers/pci/host/Kconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>>>> index 75a6054..0aee193 100644
>>>> --- a/drivers/pci/host/Kconfig
>>>> +++ b/drivers/pci/host/Kconfig
>>>> @@ -81,7 +81,7 @@ config PCI_KEYSTONE
>>>>
>>>>  config PCIE_XILINX
>>>>         bool "Xilinx AXI PCIe host bridge support"
>>>> -       depends on ARCH_ZYNQ
>>>> +       depends on ARCH_ZYNQ || MIPS
>>>
>>> Why don't you just remove the dependency? Then it gets better build coverage.
>>>
>>> Rob
>>
>> That seems like a call best made by whomever has to maintain this - if
>> that's the preferred way to go I'm fine with it.
> 
> I'm in favor of removing the dependency if possible.  I guess Michal
> would be the person to ack that.

Not a problem to remove dependency on archs. There is pending support
for Microblaze anyway.

Thanks,
Michal

