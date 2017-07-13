Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-4-git-send-email-dingtianhong@huawei.com>
 <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 13 Jul 2017 11:17:28 -0700
Message-ID: <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] net/cxgb4: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
To: Ding Tianhong <dingtianhong@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Asit K Mallick <asit.k.mallick@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 LinuxArm <linuxarm@huawei.com>, Ashok Raj <ashok.raj@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Ganesh Goudar <ganeshgr@chelsio.com>, Bob Shaw <Bob.Shaw@amd.com>,
 Casey Leedom <leedom@chelsio.com>,
 Patrick J Cramer <patrick.j.cramer@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Michael Werner <werner@chelsio.com>,
 linux-arm-kernel@lists.infradead.org, Amir Ancel <amira@mellanox.com>,
 Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, David Miller <davem@davemloft.net>,
 h <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 13, 2017 at 11:14 AM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Thu, Jul 13, 2017 at 7:21 AM, Ding Tianhong <dingtianhong@huawei.com> wrote:
>> From: Casey Leedom <leedom@chelsio.com>
>>
>> cxgb4 Ethernet driver now queries PCIe configuration space to determine
>> if it can send TLPs to it with the Relaxed Ordering Attribute set.
>>
>> Remove the enable_pcie_relaxed_ordering() to avoid enable PCIe Capability
>> Device Control[Relaxed Ordering Enable] at probe routine, to make sure
>> the driver will not send the Relaxed Ordering TLPs to the Root Complex which
>> could not deal the Relaxed Ordering TLPs.
>>
>> Signed-off-by: Casey Leedom <leedom@chelsio.com>
>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>
> Ding,
>
> You can probably just drop this patch. If I am understanding Casey
> correctly just the fact that the relaxed ordering enable bit is
> cleared in the configuration should be enough to do this for the
> device automatically.
>
> - Alex

Actually I take that back. I hadn't caught the most recent parts of
the thread. If this is good for Casey then this works for me.

- Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
