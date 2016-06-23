Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <62140.117.114.135.40.1466678343.squirrel@mprc.pku.edu.cn>
In-Reply-To: <20160622230746.GI25485@localhost>
References: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465383890-13538-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20160622230746.GI25485@localhost>
Date: Thu, 23 Jun 2016 18:39:03 +0800 (CST)
Subject: Re: [PATCH v3 4/4] ARM/PCI: remove arch specific
 pcibios_enable_device()
From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
To: "Bjorn Helgaas" <helgaas@kernel.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Reply-To: gxt@mprc.pku.edu.cn
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 David Daney <david.daney@cavium.com>, linux-pci@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Yinghai Lu <yinghai@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> [+cc Guan]
>
> On Wed, Jun 08, 2016 at 12:04:50PM +0100, Lorenzo Pieralisi wrote:
>> The arm pcibios_enable_device() implementation exists solely
>> to prevent enabling PCI resources on PCI_PROBE_ONLY systems, since
>> on those systems the PCI resources are currently not claimed (ie
>> inserted in the PCI resource tree - which means their parent
>> pointer is not correctly set-up) therefore they can not be enabled
>> since this would trigger PCI set-ups failures.
>>
>> After removing the pci=firmware command line option in:
>>
>> commit 903589ca7165 ("ARM: 8554/1: kernel: pci: remove pci=firmware
>> command line parameter handling")
>
> 903589ca7165 removed "pci=firmware" from ARM and from
> Documentation/kernel-parameters.txt (where it was documented as
> ARM-specific).
>
> I think unicore32 copied that code from arm, so unicore32 is one of
> the few remaining arches that can set PCI_PROBE_ONLY.  I suspect this
> was just copied from arm and may not be necessary on unicore32.
>
> Guan, can you confirm that PCI_PROBE_ONLY is necessary on unicore32,
> or that it can be removed?
>

Yes, this code was copied from arm, and it's not necessary.
It can be removed safely.

Guan Xuetao


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
