Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 3/6] PCI: Introduce devm_of_pci_get_host_bridge_resources
To: Bjorn Helgaas <helgaas@kernel.org>
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <e387d04ea235c9a4879a897bb730adc383a96635.1524582822.git.jan.kiszka@siemens.com>
 <20180427222427.GB73638@bhelgaas-glaptop.roam.corp.google.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <869a8ad9-dd2f-8462-c0c4-2d8a62d74185@siemens.com>
Date: Sat, 28 Apr 2018 09:28:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180427222427.GB73638@bhelgaas-glaptop.roam.corp.google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-04-28 00:24, Bjorn Helgaas wrote:
> On Tue, Apr 24, 2018 at 05:13:39PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> of_pci_get_host_bridge_resources allocates the resource structures it
>> fills dynamically, but none of its callers care to release them so far.
>> Rather than requiring everyone to do this explicitly, introduce a
>> managed version of that service. This differs API-wise only in taking a
>> reference to the associated device, rather than to the device tree node.
>>
>> As of_pci_get_host_bridge_resources is an exported interface, we cannot
>> simply drop it at this point. After converting all in-tree users to the
>> new API, we could phase out the unmanaged one over some grace period.
> 
> It looks like it might be possible to split this into three or four
> patches:
> 
>   1) Factor __of_pci_get_host_bridge_resources() out of
>      of_pci_get_host_bridge_resources()
> 
>   2) Add struct device * argument
> 
>   3) Convert pr_info() to dev_info()
> 
>   4) Add devm_of_pci_get_host_bridge_resources()

Will do. I'm even considering

5) mark of_pci_get_host_bridge_resources() __deprecated, due to the leak
   and no remaining in-tree user - what do you think?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
