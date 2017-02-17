Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 01/22] PCI: endpoint: Add EP core layer to enable EP
 controller and EP functions
To: Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-2-git-send-email-kishon@ti.com>
 <ece23395-7ebc-c9f3-bd9f-4f24e44d763a@synopsys.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58A6E05D.5010803@ti.com>
Date: Fri, 17 Feb 2017 17:07:01 +0530
MIME-Version: 1.0
In-Reply-To: <ece23395-7ebc-c9f3-bd9f-4f24e44d763a@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joao,

On Friday 17 February 2017 04:56 PM, Joao Pinto wrote:
> =

> Hi Kishon,
> =

> =C0s 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
>> Introduce a new EP core layer in order to support endpoint functions
>> in linux kernel. This comprises of EPC library
>> (Endpoint Controller Library) and EPF library (Endpoint
>> Function Library). EPC library implements functions that is specific
>> to an endpoint controller and EPF library implements functions
>> that is specific to an endpoint function.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/Makefile                    |    2 +
>>  drivers/pci/Kconfig                 |    1 +
>>  drivers/pci/endpoint/Kconfig        |   21 ++
>>  drivers/pci/endpoint/Makefile       |    6 +
>>  drivers/pci/endpoint/pci-epc-core.c |  548 ++++++++++++++++++++++++++++=
+++++++
>>  drivers/pci/endpoint/pci-epc-mem.c  |  143 +++++++++
>>  drivers/pci/endpoint/pci-epf-core.c |  347 ++++++++++++++++++++++
>>  include/linux/mod_devicetable.h     |   10 +
>>  include/linux/pci-epc.h             |  141 +++++++++
>>  include/linux/pci-epf.h             |  160 ++++++++++
>>  10 files changed, 1379 insertions(+)
>>  create mode 100644 drivers/pci/endpoint/Kconfig
>>  create mode 100644 drivers/pci/endpoint/Makefile
>>  create mode 100644 drivers/pci/endpoint/pci-epc-core.c
>>  create mode 100644 drivers/pci/endpoint/pci-epc-mem.c
>>  create mode 100644 drivers/pci/endpoint/pci-epf-core.c
>>  create mode 100644 include/linux/pci-epc.h
>>  create mode 100644 include/linux/pci-epf.h
>>
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index f521cb0..a300bb1 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -14,7 +14,9 @@ obj-$(CONFIG_GENERIC_PHY)	+=3D phy/
>>  obj-$(CONFIG_PINCTRL)		+=3D pinctrl/
>>  obj-$(CONFIG_GPIOLIB)		+=3D gpio/
>>  obj-y				+=3D pwm/
>> +
>>  obj-$(CONFIG_PCI)		+=3D pci/
>> +obj-$(CONFIG_PCI_ENDPOINT)	+=3D pci/endpoint/
>>  # PCI dwc controller drivers
>>  obj-y				+=3D pci/dwc/
> =

> Any special reason to include pci/endpoint and pci/dwc in drivers/Makefile
> instead of being inside pci/Makefile? pci/host is still inside pci/Makefi=
le.

CONFIG_PCI enables all the pcie host support. Endpoint support should be
enabled independent of the host support. Moving pci/endpoint inside
pci/Makefile will build endpoint support only if CONFIG_PCI is enabled. For=
 the
same reason kept pci/dwc in drivers/Makefile since dwc drivers can be used
either in host mode or device mode (or both).

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
