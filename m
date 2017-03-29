Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [GIT PULL] PCI: Support for configurable PCI endpoint
To: Niklas Cassel <niklas.cassel@axis.com>, Bjorn Helgaas
 <bhelgaas@google.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, <linux-pci@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
References: <20170327094520.3129-1-kishon@ti.com>
 <0cfe5acf-332c-00c9-e5d5-1403c4e80ebe@axis.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <99ae043b-35fd-0723-c8a7-e2625a862c6d@ti.com>
Date: Wed, 29 Mar 2017 17:40:37 +0530
MIME-Version: 1.0
In-Reply-To: <0cfe5acf-332c-00c9-e5d5-1403c4e80ebe@axis.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, nsekhar@ti.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Niklas,

On Wednesday 29 March 2017 05:12 PM, Niklas Cassel wrote:
> On 03/27/2017 11:44 AM, Kishon Vijay Abraham I wrote:
>> Hi Bjorn,
>>
>> Please find the pull request for PCI endpoint support below. I've
>> also included all the history here.
>>
>> Changes from v4:
>> *) add #syscon-cells property and used of_parse_phandle_with_args
>>    to perform a configuration in syscon module (as suggested by
>>    Rob Herring)
>> *) Remove unnecessary white space.
>>
>> Changes from v3:
>> *) fixed a typo and adapted to https://lkml.org/lkml/2017/3/13/562.
>>
>> Changes from v2:
>> *) changed the configfs structure as suggested by Christoph Hellwig. With
>>    this change the framework creates configfs entry for EP function driver
>>    and EP controller. Previously these entries have to be created by the
>>    the user. (Haven't changed the epc core or epf core except for invoking
>>    configfs APIs to create entries for EP function driver and EP controller.
>>    That's mostly because the EP function device can still be created by
>>    directly invoking the epf core API without using configfs).
>> *) Now the user has to use configfs entry 'start' to start the link.
>>    This was previously done by the function driver. However in the case of
>>    multi function EP, the function driver shouldn't start the link.
>>
>> Changes from v1:
>> *) The preparation patches for adding EP support is removed and is sent
>>    separately
>> *) Added device ID for DRA74x/DRA72x and used it instead of
>>    using "PCI_ANY_ID"
>> *) Added userguide for PCI endpoint test function
>>
>> Major Improvements from RFC:
>>  *) support multi-function devices (hw supported not virtual)
>>  *) Access host side buffers
>>  *) Raise MSI interrupts
>>  *) Add user space program to use the host side PCI driver
>>  *) Adapt all other users of designware to use the new design (only
>>     compile tested. Since I have only dra7xx boards, the new design
>>     has only been tested in dra7xx. I'd require the help of others
>>     to test the platforms they have access to).
>>
>> This series has been developed over 4.11-rc1 + [1]
>> [1] -> https://lkml.org/lkml/2017/3/13/562
>>
>> Let me know if this has to be re-based to some of your branch.
>>
>> Thanks
>> Kishon
>>
>> The following changes since commit 623e87fec8ab7867fb51b3079196bd10718a60ce:
>>
>>   PCI: dwc: dra7xx: Push request_irq call to the bottom of probe (2017-03-22 20:35:30 +0530)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git tags/pci-endpoint-for-4.12
>>
>> for you to fetch changes up to e98bf80074be4654faae42fe0f5a622a776b6fdd:
>>
>>   ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP (2017-03-27 15:08:22 +0530)
>>
>> ----------------------------------------------------------------
> 
> FWIW:
> I've tested Kishon's tag pci-endpoint-for-4.12
> and PCIe on artpec6 SoC is still working fine.

Thanks for testing it.
> 
> I also included the DRA7xx PCIe driver in my
> kernel so that pcie-designware-ep.c gets built.
> 
> My only worry is that the code in pcie-designware-ep.c
> is not compile tested if DRA7xx is not selected
> (as it is the only driver using PCIE_DW_EP at
> the moment).

yeah, we should plan to include COMPILE_TEST in all pci drivers but I guess
there is some problem with non-ARM builds [1]. As Bjorn mentioned in the
thread, we could add #ifdef ARM and then include COMPILE_TEST.

Thanks
Kishon

[1] -> http://www.spinics.net/lists/linux-pci/msg58134.html

Thanks
Kishon
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
