Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170302120546.GB17277@red-moon>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
 <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
 <20170302120546.GB17277@red-moon>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 Mar 2017 14:50:00 +0200
Message-ID: <CAHp75VfoZTr5L3z5_SXW58W2Ate5nCWSzP8hAA051fVwizSjag@mail.gmail.com>
Subject: Re: [PATCH 07/20] PCI: implement Devres interface to map PCI config
 space
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tejun Heo <tj@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Linux-Arch <linux-arch@vger.kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Jonathan Corbet <corbet@lwn.net>, Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 2, 2017 at 2:05 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Mar 02, 2017 at 01:54:42AM +0200, Andy Shevchenko wrote:
>> On Mon, Feb 27, 2017 at 5:14 PM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:

+Cc: Tejun, who is initial author of PCI managed resources implementation.

> I thought about that and did not do it because here we are remapping
> resources that are _not_ PCI bus resources (ie it is not PCI BARs we
> are remapping), keeping the devm_* prefix would be more consistent
> to the typical device drivers remapping functions pattern (ie a
> typical PCI host controller driver would mix devm_ and pcim_ calls
> which is a bit hard to parse), that was my rationale.
>
> I am not too fussed about that either way, I am happy to update it to
> pcim_* though, it is Bjorn/Arnd's decision.

I would vote for pcim_*() variant.

>> 2. If you may notice there is no separate pcim_*map*() stuff, they are
>> dynamically adapting to the case.
>
> I do not understand what you mean here I would ask you to elaborate
> a bit more please so that I can do something about it.

Oh, sorry, there are two examples currently, i.e.
pci_enable_msi()/pci_enable_msix() and pci_request_region*() which has
no "m" in the name, but are managed on release by pcim_release().
Some developers consider this as a bad idea, but so far no patch has
been sent to introduce pcim_*() variants of those.

So, regarding to your stuff, I would stick with "pcim" prefix.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
