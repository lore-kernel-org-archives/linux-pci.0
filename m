Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: Re: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
Date: Thu, 30 Mar 2017 22:31:10 +0200
Message-ID: <1908501.jAQQKvjW4f@aspire.rjw.lan>
In-Reply-To: <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, benh@kernel.crashing.org, gabriele.paoloni@huawei.com,
 rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 linuxarm@huawei.com, frowand.list@gmail.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, xuwei5@hisilicon.com, linux-acpi@vger.kernel.org,
 catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org,
 john.garry@huawei.com, zourongrong@gmail.com, robh+dt@kernel.org,
 bhelgaas@google.com, kantyzc@163.com, zhichang.yuan02@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, March 30, 2017 11:26:58 PM zhichang.yuan wrote:
> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access I/O
> with some special host-local I/O ports known on x86. To access the I/O
> peripherals, an indirect-IO mechanism is introduced to mapped the host-local
> I/O to system logical/fake PIO similar the PCI MMIO on architectures where no
> separate I/O space exists. Just as PCI MMIO, the host I/O range should be
> registered before probing the downstream devices and set up the I/O mapping.
> But current ACPI bus probing doesn't support these indirect-IO hosts/devices.
> 
> This patch introdueces a new ACPI handler for this device category. Through the
> handler attach callback, the indirect-IO hosts I/O registration is done and
> all peripherals' I/O resources are translated into logic/fake PIO before
> starting the enumeration.

Can you explain to me briefly what exactly this code is expected to be doing?

Thanks,
Rafael


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
