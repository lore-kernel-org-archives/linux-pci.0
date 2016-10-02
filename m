Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
References: <1473855354-150093-1-git-send-email-yuanzhichang@hisilicon.com>
 <5140357.dcW9ibtZJ6@wuerfel> <57D963C4.4010406@hisilicon.com>
 <5869118.UilSPY9Sai@wuerfel>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <2af4f2d8-e3a4-fa00-e700-60af70bf4560@jonmasters.org>
Date: Sun, 2 Oct 2016 15:03:58 -0700
MIME-Version: 1.0
In-Reply-To: <5869118.UilSPY9Sai@wuerfel>
Subject: Re: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 gabriele.paoloni@huawei.com, minyard@acm.org, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, john.garry@huawei.com, will.deacon@arm.com,
 linux-kernel@vger.kernel.org, "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 linuxarm@huawei.com, xuwei5@hisilicon.com, linux-serial@vger.kernel.org,
 benh@kernel.crashing.org, zourongrong@gmail.com, liviu.dudau@arm.com,
 kantyzc@163.com, zhichang.yuan02@gmail.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 09/14/2016 02:32 PM, Arnd Bergmann wrote:
> On Wednesday, September 14, 2016 10:50:44 PM CEST zhichang.yuan wrote:

>> And there are probably multiple child devices under LPC, the global arm64_extio_ops only can cover one PIO range. It is fortunate only ipmi driver can not support I/O
>> operation registering, serial driver has serial_in/serial_out to
>> be registered. So, only the PIO range for ipmi device is stored
>> in arm64_extio_ops and the indirect-IO
>> works well for ipmi device.
> 
> You should not do that in the serial driver, please just use the
> normal 8250 driver that works fine once you handle the entire
> port range.

Just for the record, Arnd has the right idea. There is only one type of
UART permitted by SBSA (PL011). We carved out an exception for a design
that was already in flight and allowed it to be 16550. That other design
was then corrected in future generations to be PL011 as we required it
to be. Then there's the Hip06. I've given feedback elsewhere about the
need for there to be (at most) two types of UART in the wild. This "LPC"
stuff needs cleaning up (feedback given elsewhere already on that), but
we won't be adding a third serial driver into the mix in order to make
it work. There will be standard ARM servers. There will not be the
kinda-sorta-standard. Thanks.

Jon.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
