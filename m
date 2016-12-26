Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Jaehoon Chung'" <jh80.chung@samsung.com>,
 "'Pankaj Dubey'" <pankaj.dubey@samsung.com>,
 <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
References: <CGME20161223105411epcas1p3727f726e757ec6c6d7bff04a9af40077@epcas1p3.samsung.com>
 <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
 <e1f37a59-b633-7b9d-cc79-dbbb00a24cda@samsung.com>
In-Reply-To: <e1f37a59-b633-7b9d-cc79-dbbb00a24cda@samsung.com>
Subject: Re: [PATCH] PCI: exynos: refactor exynos pcie driver
Date: Mon, 26 Dec 2016 09:43:31 -0500
Message-ID: <000201d25f86$6ee20bd0$4ca62370$@gmail.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'CPGS' <cpgs@samsung.com>, 'Niyas Ahmed S T' <niyas.ahmed@samsung.com>,
 krzk@kernel.org, kgene@kernel.org, alim.akhtar@samsung.com,
 bhelgaas@google.com, sanath@samsung.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Jaehoon Chung wtote:
> 
> Hi Pankaj,
> 
> On 12/23/2016 07:56 PM, Pankaj Dubey wrote:
> > From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> >
> > Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
> > This patch does refactoring of Exynos PCIe driver to extend support
> > for other Exynos SoC.
> >
> > Following are the main changes done via this patch:
> > 1) It adds separate structs for memory, clock resources.
> > 2) It add exynos_pcie_ops struct which will allow us to support the
> > differences in resources in different Exynos SoC.
> 
> It's nice to me for reusing this file.
> but after considering too many times, i decided not to use this file.
> 
> I'm not sure what block base is..actually this pci-exynos.c is really
> black-box.
> (No one maintains this file, even Samsung didn't care.)
> Who is using this?
> If Someone can share the information about exynos5440, i can refactor
> everything.
> Otherwise, there are two solution..
> 
> One is "adding the new pci-exynos.c" likes pci-exynos5433.c

As Bjorn mentioned earlier, I agree with this option.

> Other is "refactor this file" under assuming the each register's usage.

But, if possible, I prefer this option.
I am not sure that it cannot make the code dirty.
Maybe, you need to discuss with hardware design engineers.

> 
> I want to use the PHY generic Framework for EXYNOS PCIe.
> 
> If you or other guys really want to use the pci-exynos.c for other exynos,
> I will rework with PHY generic framework. Then i will resend the my
> patches as V2.

When I submitted the pci-exynos.c, there was no PHY generic framework.
But, currently, using PHY generic framework is mandatory, as other PCIe host
driver did.
I think that we should use PHY generic framework for new SoCs.

> 
> One more thing..Does anyone know what the usage of block base is?
> Can i use that register as "syscon"?

'Block' is very specific registers for 5440.
Other Exynos SoCs do not use that registers.
Actually, it is not the same with 'syscon'.
But, you can assume 'block' as 'syscon'.

Best regards,
Jingoo Han

> 
> Best Regards,
> Jaehoon Chung
> 
[.....]



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
