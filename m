Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: iproc: fix kernel crash if dev->of_node not defined
To: Ray Jui <ray.jui@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Abylay Ospan <aospan@netup.ru>, Bjorn Helgaas <bhelgaas@google.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <1484266817-6725-1-git-send-email-aospan@netup.ru>
 <6891f43f-25e7-1411-800e-97e6788f2f27@gmail.com>
 <e5301de6-9a6c-7deb-4ff7-ccd462c4381e@broadcom.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <6cfba8af-1e9b-cb43-4898-61d6fb8f12ca@broadcom.com>
Date: Thu, 12 Jan 2017 17:20:43 -0800
MIME-Version: 1.0
In-Reply-To: <e5301de6-9a6c-7deb-4ff7-ccd462c4381e@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 01/12/2017 04:48 PM, Ray Jui wrote:
> Hi Florian,
> 
> On 1/12/2017 4:22 PM, Florian Fainelli wrote:
>> On 01/12/2017 04:20 PM, Abylay Ospan wrote:
>>> pcie->dev->of_node not always defined (NULL) and can cause crash:
>>>
>>> [   19.053195] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000020
>>> [<c0b0370c>] (of_n_addr_cells) from [<c06599c4>]
>>> (iproc_pcie_setup+0x30c/0xce0)
>>>
>>> this patch adds sanity check to prevent crash.
>>
>> Humm, how can it not be defined based on your earlier comment that you
>> are using this on NSP which is Device Tree exclusively? I would agree if
>> this was seen on e.g: MIPS/BCMA (47xx).
> 
> I thought Abylay mentioned:
> 
> "Tested on Broadcom NorthStar machine ('Edgecore ECW7220-L') with two
> PCIe wifi
> adapters (b43 BCM4331 and ath10k QCA988X)."
> 
> That is a NorthStar device which is BCMA based?

Still, upstream Linux support for Northstar is Device Tree, and BCMA bus
should fill in of_nodes accordingly, if not, that's a bug that must be
fixed at the BCMA layer.

> 
>>
>>>
>>> Signed-off-by: Abylay Ospan <aospan@netup.ru>
>>> ---
>>>  drivers/pci/host/pcie-iproc.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>>> index 3ebc025..f2836a9 100644
>>> --- a/drivers/pci/host/pcie-iproc.c
>>> +++ b/drivers/pci/host/pcie-iproc.c
>>> @@ -952,6 +952,9 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
>>>  	const int na = 3, ns = 2;
>>>  	int rlen;
>>>  
>>> +	if (!node)
>>> +		return -ENOENT;
>>> +
>>>  	parser->node = node;
>>>  	parser->pna = of_n_addr_cells(node);
>>>  	parser->np = parser->pna + na + ns;
>>>
>>
>>


-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
