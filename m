Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V6 3/5] OF: Add missing I/O range exception for
 indirect-IO devices
To: Rob Herring <robh@kernel.org>, "zhichang.yuan" <yuanzhichang@hisilicon.com>
References: <1485241525-201782-1-git-send-email-yuanzhichang@hisilicon.com>
 <1485241525-201782-4-git-send-email-yuanzhichang@hisilicon.com>
 <20170127220357.3lpavvyeymlhvlfg@rob-hp-laptop>
From: John Garry <john.garry@huawei.com>
Message-ID: <645d40d8-0db6-1737-88f4-fd839933b2ea@huawei.com>
Date: Mon, 30 Jan 2017 08:57:09 +0000
MIME-Version: 1.0
In-Reply-To: <20170127220357.3lpavvyeymlhvlfg@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, benh@kernel.crashing.org, gabriele.paoloni@huawei.com,
 rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 linuxarm@huawei.com, frowand.list@gmail.com, lorenzo.pieralisi@arm.com,
 arnd@arndb.de, xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 catalin.marinas@arm.com, devicetree@vger.kernel.org, minyard@acm.org,
 liviu.dudau@arm.com, zhichang.yuan02@gmail.com, zourongrong@gmail.com,
 bhelgaas@google.com, kantyzc@163.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, olof@lixom.net, brian.starkey@arm.com
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 27/01/2017 22:03, Rob Herring wrote:
> On Tue, Jan 24, 2017 at 03:05:23PM +0800, zhichang.yuan wrote:
>> There are some special ISA/LPC devices that work on a specific I/O range where
>> it is not correct to specify a 'ranges' property in DTS parent node as cpu
>> addresses translated from DTS node are only for memory space on some
>> architectures, such as Arm64. Without the parent 'ranges' property, current
>> of_translate_address() return an error.
>> Here we add special handlings for this case.
>> During the OF address translation, some checkings will be perfromed to
>> identify whether the device node is registered as indirect-IO. If yes, the I/O
>> translation will be done in a different way from that one of PCI MMIO.
>> In this way, the I/O 'reg' property of the special ISA/LPC devices will be
>> parsed correctly.
>>
>> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
>> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Shouldn't this be Reviewed-by?
>

The background is that Zhichang is following a sketch of a re-worked 
driver from Arnd, which Arnd gave Signed-off-by. But this patch does not 
follow it verbatim.

I think this patchset should be resent without Arnd's signature. Or Arnd 
may kindly review and say it's ok.

John

> Otherwise, looks fine to me.
>
> Acked-by: Rob Herring <robh@kernel.org>
>
>> ---
>>  drivers/of/address.c | 87 ++++++++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 71 insertions(+), 16 deletions(-)
>>
>
> .
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
