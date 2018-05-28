Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v4 4/8] PCI: Replace dev_node parameter of
 of_pci_get_host_bridge_resources with device
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
 <a74db976-d330-80b9-939e-dd164a20c8c3@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <eb9b477a-33c9-db45-9e62-101e3606e8ff@siemens.com>
Date: Mon, 28 May 2018 12:46:35 +0200
MIME-Version: 1.0
In-Reply-To: <a74db976-d330-80b9-939e-dd164a20c8c3@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-28 12:00, Vladimir Zapolskiy wrote:
> Hi Jan, Bjorn,
> 
> On 05/15/2018 12:07 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Another step towards a managed version of
>> of_pci_get_host_bridge_resources(): Feed in the underlying device,
>> rather than just the OF node. This will allow to use managed resource
>> allocation internally later on.
>>
>> CC: Jingoo Han <jingoohan1@gmail.com>
>> CC: Joao Pinto <Joao.Pinto@synopsys.com>
>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> [snip]
> 
>> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
>> index a6af62e0256d..61802e55a00c 100644
>> --- a/drivers/pci/host/pcie-altera.c
>> +++ b/drivers/pci/host/pcie-altera.c
>> @@ -488,11 +488,10 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
>>  {
>>  	int err, res_valid = 0;
>>  	struct device *dev = &pcie->pdev->dev;
>> -	struct device_node *np = dev->of_node;
>>  	struct resource_entry *win;
>>  
>> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
>> -					       NULL);
>> +	err = of_pci_get_host_bridge_resources(dev, 0, 0xff
>> +						    &pcie->resources, NULL);
>>  	if (err)
>>  		return err;
>>  
> 
> In case if it is an undiscovered issue, a comma was mistakenly removed,
> which will result it compilation error.
> 
> The problem is also found in pci/next , see commit 88e3909aa125.

Yes, that's known. We have a bisection breakage: The issue was fixed
again by patch 6 in that series.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
