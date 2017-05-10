Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170510131722.GA29556@collabora.com>
References: <20170508150224.GA7458@collabora.com>
 <CAOMZO5DjFxAus3B03Om0xoqxKuY2TkbcjCY1YEUK9s_R8C_DNA@mail.gmail.com>
 <20170509063439.GC9791@collabora.com>
 <CAOMZO5CXjb7LVT5ByP1RqgBPkkfRn7PcRPmW3hos=UNXGnok=A@mail.gmail.com>
 <20170510131722.GA29556@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 May 2017 10:27:58 -0300
Message-ID: <CAOMZO5CwtT=Zz8+CrT2TA5W7YHFRnDKgthRyChvUpF+f_QsYcQ@mail.gmail.com>
Subject: Re: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
To: Peter Senna Tschudin <peter.senna@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Richard Zhu <hongxing.zhu@nxp.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Jingoo Han <jingoohan1@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 10, 2017 at 10:17 AM, Peter Senna Tschudin
<peter.senna@collabora.com> wrote:
> On Tue, May 09, 2017 at 07:21:24AM -0300, Fabio Estevam wrote:
>> Hi Peter,
>>
>> On Tue, May 9, 2017 at 3:34 AM, Peter Senna Tschudin
>> <peter.senna@collabora.com> wrote:
>>
>> > Something that ocurred to me is that u-boot is initializing the PCI, and
>> > the PCI networkd cards.  Ideally this should not affect anything, but
>> > can this be related to the issue?
>>
>> Yes, in order to narrow things down: please boot 4.11 without PCI
>> support in U-Boot.
>
> Yes, removing the PCI code from u-boot makes 4.11 to boot. But latest
> next still hangs.

Ok, good. At least we see the same behaviour now.

We still need a fix for the mx6q hang on systems with PCI switch for
linux/next or 4.12-rc1.

>> The problem is that mx6q does not have a way to properly reset the PCI block.
>>
>> On the board I tested there is no PCI support in U-Boot.
>>
>> Maybe we need the following approach in U-Boot as Lucas did for Barebox:
>> https://git.pengutronix.de/cgit/barebox/commit/?id=f1da98da2760c21487bbba8f7fb957c843a22896
>
> Maybe we do need, but the kernel is working on v4.10 for our use case,
> and it is not working any longer on v4.11. What is the way to continue
> from here?

There is no other way other than fixing U-Boot on this case.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
