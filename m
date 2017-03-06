Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 03/22] PCI: endpoint: Introduce configfs entry for
 configuring EP functions
To: Christoph Hellwig <hch@infradead.org>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-4-git-send-email-kishon@ti.com>
 <20170217170459.GA15276@infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58BD2EC3.4030604@ti.com>
Date: Mon, 6 Mar 2017 15:11:23 +0530
MIME-Version: 1.0
In-Reply-To: <20170217170459.GA15276@infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 linux-doc@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 17 February 2017 10:34 PM, Christoph Hellwig wrote:
> On Fri, Feb 17, 2017 at 03:20:23PM +0530, Kishon Vijay Abraham I wrote:
>> Introduce a new configfs entry to configure the EP function (like
>> configuring the standard configuration header entries) and to
>> bind the EP function with EP controller.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/endpoint/Kconfig      |   14 +-
>>  drivers/pci/endpoint/Makefile     |    1 +
>>  drivers/pci/endpoint/pci-ep-cfs.c |  427 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 440 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/pci/endpoint/pci-ep-cfs.c
>>
>> diff --git a/drivers/pci/endpoint/Kconfig b/drivers/pci/endpoint/Kconfig
>> index 7eb1c79..8470f0b 100644
>> --- a/drivers/pci/endpoint/Kconfig
>> +++ b/drivers/pci/endpoint/Kconfig
>> @@ -6,7 +6,6 @@ menu "PCI Endpoint"
>>  
>>  config PCI_ENDPOINT
>>  	bool "PCI Endpoint Support"
>> -	select CONFIGFS_FS
>>  	help
>>  	   Enable this configuration option to support configurable PCI
>>  	   endpoint. This should be enabled if the platform has a PCI
>> @@ -14,8 +13,19 @@ config PCI_ENDPOINT
>>  
>>  	   Enabling this option will build the endpoint library, which
>>  	   includes endpoint controller library and endpoint function
>> -	   library.
>> +	   library. This will also enable the configfs entry required to
>> +	   configure the endpoint function and used to bind the
>> +	   function with a endpoint controller.
>>  
>>  	   If in doubt, say "N" to disable Endpoint support.
>>  
>> +config PCI_ENDPOINT_CONFIGFS
>> +	bool "PCI Endpoint Configfs Support"
>> +	depends on PCI_ENDPOINT
>> +	select CONFIGFS_FS
>> +	help
>> +	   This will enable the configfs entry that can be used to
>> +	   configure the endpoint function and used to bind the
>> +	   function with a endpoint controller.
>> +
>>  endmenu
>> diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
>> index dc1bc16..dd9163c 100644
>> --- a/drivers/pci/endpoint/Makefile
>> +++ b/drivers/pci/endpoint/Makefile
>> @@ -4,3 +4,4 @@
>>  
>>  obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
>>  					   pci-epc-mem.o
>> +obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
>> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
>> new file mode 100644
>> index 0000000..ed0f8c2
>> --- /dev/null
>> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
>> @@ -0,0 +1,427 @@
>> +/**
>> + * configfs to configure the PCI endpoint
>> + *
>> + * Copyright (C) 2017 Texas Instruments
>> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 of
>> + * the License as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/configfs.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/pci-epc.h>
>> +#include <linux/pci-epf.h>
>> +
>> +struct pci_epf_info {
>> +	struct config_group group;
>> +	struct list_head list;
>> +	struct pci_epf *epf;
>> +};
>> +
>> +struct pci_ep_info {
>> +	struct config_group group;
>> +	struct config_group pci_epf_group;
>> +	/* mutex to protect pci_epf list */
>> +	struct mutex lock;
>> +	struct list_head pci_epf;
>> +	const char *epc_name;
>> +	struct pci_epc *epc;
>> +};
>> +
>> +static inline struct pci_epf_info *to_pci_epf_info(struct config_item *item)
>> +{
>> +	return container_of(to_config_group(item), struct pci_epf_info, group);
>> +}
>> +
>> +static inline struct pci_ep_info *to_pci_ep_info(struct config_item *item)
>> +{
>> +	return container_of(to_config_group(item), struct pci_ep_info, group);
>> +}
>> +
>> +#define PCI_EPF_HEADER_R(_name)						       \
>> +static ssize_t pci_epf_##_name##_show(struct config_item *item,	char *page)    \
>> +{									       \
>> +	struct pci_epf *epf = to_pci_epf_info(item)->epf;		       \
>> +	if (!epf->header) {						       \
>> +		WARN_ON_ONCE("epf device not bound to function driver\n");     \
> 
> WARN_ON_ONCE takes a string to evaluate as argument, not a message
> 
>> +		return 0;					
> 
> and if we return 0 here the callers will retry because that is
> interpreted as a short read.  The code should be something like:
> 
> 	if (WARN_ON_ONCE(!epf->header))
> 		return -EINVAL;
> 
>> +	if (!epf->header) {						       \
>> +		WARN_ON_ONCE("epf device not bound to function driver\n");     \
>> +		return 0;						       \
>> +	}								       \
> 
> Same here, and a couple more instances down below.

sure, fixed it now.

Thanks
Kishon

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
