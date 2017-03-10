Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RESEND PATCH v3 5/7] PCI: dwc: all: Modify dbi accessors to
 access data of 4/2/1 bytes
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1489041545-15730-1-git-send-email-kishon@ti.com>
 <1489041545-15730-6-git-send-email-kishon@ti.com>
 <a56e462d-83ee-194f-1f9f-3f4c339cad46@axis.com> <58C29648.5020708@ti.com>
 <61f90a03-7164-8e79-f1c2-0ae48b5892a8@axis.com> <58C2A46D.2080907@ti.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <90b8c0de-e3e8-546f-9327-2e1a21376c88@axis.com>
Date: Fri, 10 Mar 2017 15:59:04 +0100
MIME-Version: 1.0
In-Reply-To: <58C2A46D.2080907@ti.com>
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

On 03/10/2017 02:04 PM, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Friday 10 March 2017 06:26 PM, Niklas Cassel wrote:
>> On 03/10/2017 01:04 PM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Thursday 09 March 2017 08:18 PM, Niklas Cassel wrote:
>>>> On 03/09/2017 07:39 AM, Kishon Vijay Abraham I wrote:
>>>>> Previously dbi accessors can be used to access data of size 4
>>>>> bytes. But there might be situations (like accessing
>>>>> MSI_MESSAGE_CONTROL in order to set/get the number of required
>>>>> MSI interrupts in EP mode) where dbi accessors must
>>>>> be used to access data of size 2. This is in preparation for
>>>>> adding endpoint mode support to designware driver.
>>>> Hello Kishon
>>>>
>>>> I don't really like the idea of adding an extra argument to every existing read/write.
>>>> Will not a read/write of length != 32 be quite uncommon compared to
>>>> a read/write of length == 32?
>>>>
>>>> How about adding some defines to pcie-designware.h:
>>>>
>>>> #define dw_pcie_writel_dbi(pci, base, reg, val) dw_pcie_write_dbi(pci, base, reg, 0x4, val)
>>>> #define dw_pcie_readl_dbi(pci, base, reg) dw_pcie_read_dbi(pci, base, reg, 0x4)
>>>>
>>>> That way we don't have to change every existing read/write.
>>>>
>>>>
>>>>
>>>> Is there a reason why we can't just do:
>>>>
>>>> vial = dw_pcie_readl_dbi(pci, base, MSI_MESSAGE_CONTROL);
>>> MSI_MESSAGE_CONTROL is 0x52 (MSI capability offset + 2). I'm not sure if we can
>>> do a readl that crosses the alignment boundary in all platforms. The other
>>> option is to readl from "MSI capability offset + 0" and extract the last 16
>>> bits. I felt this is more clear since we are interested only in the
>>> MSI_MESSAGE_CONTROL.
>>>
>>>> <shifting+masking the bits we need to get/set>
>>>> dw_pcie_writel_dbi(pci, base, MSI_MESSAGE_CONTROL, val);
>>>>
>>>> Or are we going to be doing read/writes of length != 32 so often that
>>>> you think that it's cleaner to have this abstraction?
>>> it's used mainly for accessing configuration space header fields. Even the pci
>>> core uses *pci_read_config_word* for accessing such fields.
>> I see. Adding an extra size argument is a good thing then,
>> since it's consistent with the pci generic code.
>>
>> However, I still think that having defines for writel/readl is a
>> good thing :)
> sure, having defines is fine. How about something like below (readl, readw: to
> differentiate 4byte and 2 byte access?)
>
> #define dw_pcie_readl_dbi(pci, base, reg) __dw_pcie_read_dbi(pci, base, reg, 0x4)
> #define dw_pcie_readw_dbi(pci, base, reg) __dw_pcie_read_dbi(pci, base, reg, 0x2)

Looks good to me.
But if we add readw, we might as well add readb :P


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
