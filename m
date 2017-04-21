Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 21 Apr 2017 13:34:54 +0200
From: Robert Richter <robert.richter@cavium.com>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH 1/1] PCI: Add MCFG quirk for 2nd node of Cavium ThunderX
 pass2.x host controller
Message-ID: <20170421113454.GR16981@rric.localdomain>
References: <1490789773-21506-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1490789773-21506-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo.Pieralisi@arm.com, Sunil.Goutham@cavium.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, linu.cherian@cavium.com, ddaney@caviumnetworks.com,
 geethasowjanya.akula@gmail.com, linux-acpi@vger.kernel.org, helgaas@kernel.org,
 Vadim.Lomovtsev@caviumnetworks.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 29.03.17 14:16:13, Tomasz Nowicki wrote:
> Currently SoCs pass2.x do not emulate EA headers for ACPI boot method at all.
> However, for pass2.x some devices (like EDAC) advertise incorrect base addresses
> in their BARs which results in driver probe failure during resource request.
> Since all problematic blocks are on 2nd NUMA node under domain 10 add necessary
> quirk entry to obtain BAR addresses correction using EA header emulation.
> 
> Fixes: 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller")
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> CC: stable@vger.kernel.org	# v4.10+

Acked-by: Robert Richter <rrichter@cavium.com>

Bjorn, please apply.

Thanks,

-Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
