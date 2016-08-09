Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 9 Aug 2016 13:04:13 +0200
From: Robert Richter <robert.richter@cavium.com>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH V5 5/5] PCI: thunder-pem: Support quirky
 configuration space access for ACPI based PCI host controller
Message-ID: <20160809110413.GV22012@rric.localdomain>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-6-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <1470661541-26270-6-git-send-email-tn@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: gabriele.paoloni@huawei.com, rafael@kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com,
 andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com, jhugo@codeaurora.org,
 linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com,
 linux-acpi@vger.kernel.org, helgaas@kernel.org, liudongdong3@huawei.com,
 linux-pci@vger.kernel.org, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com,
 msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com,
 ard.biesheuvel@linaro.org, dhdang@apm.com, linux-kernel@vger.kernel.org,
 jeremy.linton@arm.com, hanjun.guo@linaro.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 08.08.16 15:05:41, Tomasz Nowicki wrote:
> Add infrastructure to support ThunderX PEM specific PCI configuration space
> access for ACPI based PCI host controller. This involves:
> 1. New initialization call thunder_pem_cfg_init() to create configuration
> space mapping based on hardcoded range addresses
> 2. thunder_pem_init() ACPI extension to obtain hardcoded addresses for
> PEM specific register ranges
> 3. New quirk entry (for common quirk array) which identifies platform and
> calls thunder_pem_cfg_init() from [1]
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Robert Richter <rrichter@cavium.com>

> ---
>  drivers/pci/host/mcfg-quirks.c     |  7 +++
>  drivers/pci/host/mcfg-quirks.h     |  4 ++
>  drivers/pci/host/pci-thunder-pem.c | 96 ++++++++++++++++++++++++++++++++------
>  3 files changed, 94 insertions(+), 13 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
