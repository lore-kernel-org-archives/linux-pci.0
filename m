Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 21 Mar 2017 12:43:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH 0/2] ThunderX external PCI fixes for legacy&new ACPI
 firmware
Message-ID: <20170321174325.GB13150@bhelgaas-glaptop.roam.corp.google.com>
References: <1489564155-3881-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1489564155-3881-1-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo.Pieralisi@arm.com, Sunil.Goutham@cavium.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, linu.cherian@cavium.com, ddaney@caviumnetworks.com,
 geethasowjanya.akula@gmail.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, Vadim.Lomovtsev@caviumnetworks.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 15, 2017 at 08:49:13AM +0100, Tomasz Nowicki wrote:
> This patch series update ThunderX PEM driver to be able to boot with legacy
> and new ACPI firmware:
> 1. New firmware uses registered Cavium harware ID "CAV", but kernel instead
>    uses "THRX". Fix kernel to use "CAV".
> 2. Legacy firmware misses PEM quirks information so for this case kernel
>    should not assume anything from FW and figure out PEM resources on its own.
> 
> Fix this all together in the following branch:
> git@github.com:semihalf-nowicki-tomasz/linux.git (thunderx-pci-legacy-fw-v1)
> 
> Tomasz Nowicki (2):
>   PCI: Use Cavium assigned hardware ID for ThunderX host controller
>   PCI: Add legacy firmware support for Cavium ThunderX host controller
> 
>  drivers/pci/host/pci-thunder-pem.c | 58 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 3 deletions(-)

Applied with Robert's acks to pci/host-thunder for v4.12, thanks!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
