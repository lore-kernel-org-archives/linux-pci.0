Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 11/37] PCI: dwc: Split pcie-designware.c into host and
 core files
To: Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-12-git-send-email-kishon@ti.com>
 <4a89fb45-af84-d660-5ef0-12227b141cda@synopsys.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <587C586C.6070003@ti.com>
Date: Mon, 16 Jan 2017 10:51:48 +0530
MIME-Version: 1.0
In-Reply-To: <4a89fb45-af84-d660-5ef0-12227b141cda@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Friday 13 January 2017 10:19 PM, Joao Pinto wrote:
> =C0s 10:26 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
>> Split pcie-designware.c into pcie-designware-host.c that contains
>> the host specific parts of the driver and pcie-designware.c that
>> contains the parts used by both host driver and endpoint driver.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/dwc/Makefile               |    2 +-
>>  drivers/pci/dwc/pcie-designware-host.c |  619 +++++++++++++++++++++++++=
+++++++
>>  drivers/pci/dwc/pcie-designware.c      |  613 +------------------------=
------
>>  drivers/pci/dwc/pcie-designware.h      |    8 +
>>  4 files changed, 634 insertions(+), 608 deletions(-)
>>  create mode 100644 drivers/pci/dwc/pcie-designware-host.c
>>
>> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
>> index 7d27c14..3b57e55 100644
>> --- a/drivers/pci/dwc/Makefile
>> +++ b/drivers/pci/dwc/Makefile
>> @@ -1,4 +1,4 @@
> =

> (snip...)
> =

>> -static void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>> -				      int type, u64 cpu_addr, u64 pci_addr,
>> -				      u32 size)
>> +void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>> +			       u64 cpu_addr, u64 pci_addr, u32 size)
>>  {
>>  	u32 retries, val;
>>  =

>> @@ -186,220 +151,6 @@ static void dw_pcie_prog_outbound_atu(struct dw_pc=
ie *pci, int index,
>>  	dev_err(pci->dev, "iATU is not being enabled\n");
>>  }
> =

> Kishon, iATU only makes sense in The Root Complex (host), so it should be=
 inside
> the pcie-designware-host.

That is not true. Outbound ATU should be programmed to access host side buf=
fers
and inbound ATU should be programmed for the host to access EP mem space.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
