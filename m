Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 20 Mar 2017 11:49:46 +0100
From: Robert Richter <rric@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI: Use Cavium assigned hardware ID for ThunderX
 host controller
Message-ID: <20170320104946.GL4906@rric.localdomain>
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
 <1489564155-3881-2-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1489564155-3881-2-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo.Pieralisi@arm.com, Sunil.Goutham@cavium.com, rafael@kernel.org,
 Tomasz Nowicki <tn@semihalf.com>, linu.cherian@cavium.com,
 linux-pci@vger.kernel.org, ddaney@caviumnetworks.com,
 geethasowjanya.akula@gmail.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, Vadim.Lomovtsev@caviumnetworks.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 15.03.17 08:49:14, Tomasz Nowicki wrote:
> "CAV" is the only PNP/ACPI hardware ID vendor prefix assigned to Cavium
> so fix this as it should be from day one.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

there is no firmware with 'THRX0002', so tagging this as
stable. Tested with latest firmware.

Fixes: 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host controller")
Cc: <stable@vger.kernel.org> # v4.10
Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>

Please apply.

Thanks,

-Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
