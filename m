Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <6891f43f-25e7-1411-800e-97e6788f2f27@gmail.com>
References: <1484266817-6725-1-git-send-email-aospan@netup.ru>
 <6891f43f-25e7-1411-800e-97e6788f2f27@gmail.com>
From: Abylay Ospan <aospan@netup.ru>
Date: Fri, 13 Jan 2017 00:58:44 -0500
Message-ID: <CAK3bHNV-JjJh_xp9VW_9rgD138bdqfN9EAMqFSZ_jfM+NWWUcA@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: fix kernel crash if dev->of_node not defined
To: Florian Fainelli <f.fainelli@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

FYI,

here is my tree (based on linux-next):
https://github.com/aospan/linux-next-bcm4708-edgecore-ecw7220-l/commits/master

last patches adding defconfig and dts I'm using for this device. This
files are draft yet.

2017-01-12 19:22 GMT-05:00 Florian Fainelli <f.fainelli@gmail.com>:
> On 01/12/2017 04:20 PM, Abylay Ospan wrote:
>> pcie->dev->of_node not always defined (NULL) and can cause crash:
>>
>> [   19.053195] Unable to handle kernel NULL pointer dereference at
>> virtual address 00000020
>> [<c0b0370c>] (of_n_addr_cells) from [<c06599c4>]
>> (iproc_pcie_setup+0x30c/0xce0)
>>
>> this patch adds sanity check to prevent crash.
>
> Humm, how can it not be defined based on your earlier comment that you
> are using this on NSP which is Device Tree exclusively? I would agree if
> this was seen on e.g: MIPS/BCMA (47xx).
>
>>
>> Signed-off-by: Abylay Ospan <aospan@netup.ru>
>> ---
>>  drivers/pci/host/pcie-iproc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> index 3ebc025..f2836a9 100644
>> --- a/drivers/pci/host/pcie-iproc.c
>> +++ b/drivers/pci/host/pcie-iproc.c
>> @@ -952,6 +952,9 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
>>       const int na = 3, ns = 2;
>>       int rlen;
>>
>> +     if (!node)
>> +             return -ENOENT;
>> +
>>       parser->node = node;
>>       parser->pna = of_n_addr_cells(node);
>>       parser->np = parser->pna + na + ns;
>>
>
>
> --
> Florian



-- 
Abylay Ospan,
NetUP Inc.
http://www.netup.tv

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
