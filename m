Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150721161446.GC21967@google.com>
References: <1481643.dA4ocqzitg@wuerfel> <cover.1436476099.git.dhdang@apm.com> <20150721161446.GC21967@google.com>
From: Duc Dang <dhdang@apm.com>
Date: Tue, 21 Jul 2015 11:11:45 -0700
Message-ID: <CADaLND=abMVVZrv-GPb5un_7yEDs5QNpL8zR44=6N_CdYDCzMA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] pci: xgene: Add multiple memory ranges support
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	patches <patches@apm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 21, 2015 at 9:14 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Jul 09, 2015 at 02:20:10PM -0700, Duc Dang wrote:
>> This patch set adds 1 large (up to 64GB) memory window for each PCIe
>> controller nodes in X-Gene device tree and fix PCIe controller driver
>> to handle multiple memory ranges correctly. These changes are required
>> to support PCIe devices that have huge BAR.
>>
>> v3 changes:
>>       1. Explicitly mention in change log that: Each PCIe node in dts
>>       will have 1 32-bit non-prefetchable memory window and 1 64-bit
>>       prefetchable memory window.
>>
>> v2 changes:
>>         1. Separate device-tree changes and driver changes into different
>>         patches
>>         2. Explicitly define new large window as 64-bit prefetchable in dts.
>>         3. Use IORESOURCE_PREFETCH flag to determine which PCIe controller
>>         register to be used to configure the memory ranges.
>>
>>  arch/arm64/boot/dts/apm/apm-storm.dtsi | 23 ++++++++++++++---------
>>  drivers/pci/host/pci-xgene.c           | 12 ++++++++++--
>>  2 files changed, 24 insertions(+), 11 deletions(-)
>
> Applied to pci/host-xgene for v4.3, with changelogs as follows, thanks!

Thanks a lot, Bjorn.

>
>
> commit 80bb3eda7475eb38b688d2e915c191ce6ad20df1
> Author: Duc Dang <dhdang@apm.com>
> Date:   Thu Jul 9 14:20:11 2015 -0700
>
>     arm64: dts: Add APM X-Gene PCIe 64-bit prefetchable window
>
>     Add a large window (up to 64GB) for X-Gene PCIe nodes to support devices
>     that require huge BARs.
>
>     Each X-Gene PCIe node will now have two memory windows: a 32-bit
>     non-prefetchable window and a 64-bit prefetchable window.
>
>     [bhelgaas: changelog]
>     Signed-off-by: Duc Dang <dhdang@apm.com>
>     Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> commit 8ef54f27f6f425fa8deedc237d99b9daf41d68d2
> Author: Duc Dang <dhdang@apm.com>
> Date:   Thu Jul 9 14:20:12 2015 -0700
>
>     PCI: xgene: Add support for a 64-bit prefetchable memory window
>
>     X-Gene PCIe controller has registers to support multiple memory ranges.
>
>     Add support for a 64-bit prefetchable memory window.
>
>     [bhelgaas: changelog]
>     Signed-off-by: Duc Dang <dhdang@apm.com>
>     Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>



-- 
Regards,
Duc Dang.
