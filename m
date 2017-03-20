Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 20 Mar 2017 12:02:41 +0100
From: Robert Richter <robert.richter@cavium.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Add legacy firmware support for Cavium ThunderX
 host controller
Message-ID: <20170320110241.GG16822@rric.localdomain>
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
 <1489564155-3881-3-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1489564155-3881-3-git-send-email-tn@semihalf.com>
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
 Vadim.Lomovtsev@caviumnetworks.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 15.03.17 08:49:15, Tomasz Nowicki wrote:
> During early days of PCI quirks support ThunderX firmware did not provide
> PNP0c02 node with PCI configuration space and PEM-specific register ranges.
> This means that for legacy FW we are not reserving these resources and
> cannot gather PEM-specific resources for further PEM initialization.
> 
> In order to support already deployed legacy FW calculate PEM-specific ranges
> and provide resources reservation as fallback scenario into PEM driver when
> we could not gather PEM reg base from ACPI tables.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>

Works with old and new firmware.

Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>

-Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
