Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RESEND PATCH v3 4/7] PCI: dwc: all: Modify dbi accessors to take
 dbi_base as argument
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1489041545-15730-1-git-send-email-kishon@ti.com>
 <1489041545-15730-5-git-send-email-kishon@ti.com>
 <4e13580d-2625-5eed-bcbc-2ffd7493b073@axis.com>
 <595fab62-fb7a-888a-f898-7b59030585f1@axis.com> <58C28FCC.4070100@ti.com>
 <d920d892-af48-b94f-6eb7-e9e0ff5d40c0@axis.com> <58C2A28C.60703@ti.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <6d667068-81af-5ce4-3d94-c5aa987632a4@axis.com>
Date: Fri, 10 Mar 2017 16:47:12 +0100
MIME-Version: 1.0
In-Reply-To: <58C2A28C.60703@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, nsekhar@ti.com,
 Jesper Nilsson <jespern@axis.com>, Zhou Wang <wangzhou1@hisilicon.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 03/10/2017 01:56 PM, Kishon Vijay Abraham I wrote:
> Hi Niklas,
>
> On Friday 10 March 2017 06:01 PM, Niklas Cassel wrote:
>> On 03/10/2017 12:36 PM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Thursday 09 March 2017 08:35 PM, Niklas Cassel wrote:
>>>> On 03/09/2017 03:48 PM, Niklas Cassel wrote:
>>>>> On 03/09/2017 07:39 AM, Kishon Vijay Abraham I wrote:
>>>>>> dwc has 2 dbi address space labeled dbics and dbics2. The existing
>>>>>> helper to access dbi address space can access only dbics. However
>>>>>> dbics2 has to be accessed for programming the BAR registers in the
>>>>>> case of EP mode. This is in preparation for adding EP mode support
>>>>>> to dwc driver.
>>>>> Hello Kishon
>>>>>
>>>>> I don't really like the idea of adding an extra argument to every existing read/write.
>>>>> Will not a read/write using dbi2 be quite uncommon compared to a read/write
>>>>> using dbi?
>>>>>
>>>>> How about something like this:
>>>>>
>>>>> void __dw_pcie_writel(struct dw_pcie *pci, void __iomem *base, u32 reg, u32 val)
>>>>> {
>>>>>     if (pci->ops->writel_dbi)
>>>>>         pci->ops->writel_dbi(pci, base, reg, val);
>>>>>     else
>>>>>         writel(val, base + reg);
>>>>> }
>>>>>
>>>>> #define dw_pcie_writel_dbi(pci, reg, val) __dw_pcie_writel(pci, pci->dbi_base, reg, val)
>>>>> #define dw_pcie_writel_dbi2(pci, reg, val) __dw_pcie_writel(pci, pci->dbi_base2, reg, val)
>>>> Perhaps make dw_pcie_writel_dbi2 a function rather than a define,
>>>> so we can return an error if pci->dbi_base2 == NULL.
>>> Should we return an error? We don't return error for dbi_base either. I think
>>> it should be sufficient to return errors while populating dbi_base or
>>> dbi_base2. Otherwise it's a bug and should result in abort. Joao?
>> Sorry for previous empty email.
>>
>>
>> What I meant to write:
>>
>> Right now we do error checking for dbi_base in platform specific code
>> and in pcie-designware-host.c:dw_pcie_host_init.
> it's been done in dw_pcie_host_init not as an error checking but since it's
> *optional* for certain platforms to populate dbi_base (i.e where dbi_base is
> mapped to configuration space), host_init takes care of assigning dbi_base to
> configuration space address.

What I'm afraid of is that we might get a NULL ptr dereference
when using dw_pcie_writel_dbi2, if platform specific code has
not populated dbi_base2.

Having a NULL check in generic code is just a fail safe if some
platform specific code failed to NULL check.

The code in dw_pcie_host_init might have been written just
to populate dbi_base when dbi is mapped to config space,
but the end result is that if platform specific code did not
populate dbi_base (and did not populate pp->cfg),
we will return -ENOMEM.
Which means that we can never get a NULL ptr dereference
when using dw_pcie_writel_dbi.

It might be a good idea to have a NULL check in generic code,
just as a fail safe, also for dw_pcie_ep_init.
That way we know that we will not get a NULL ptr dereference
when using dw_pcie_writel_dbi2.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
