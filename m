Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Casey Leedom <leedom@chelsio.com>
To: "Raj, Ashok" <ashok.raj@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v9 1/4] PCI: Add new PCIe Fabric End Node flag,
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING
Date: Wed, 9 Aug 2017 16:46:07 +0000
Message-ID: <MWHPR12MB1600E9D94E74E1DECC192097C88B0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
 <1501917313-9812-2-git-send-email-dingtianhong@huawei.com>
 <20170808232200.GO16580@bhelgaas-glaptop.roam.corp.google.com>,
 <20170809155841.GA8675@otc-nc-03>
In-Reply-To: <20170809155841.GA8675@otc-nc-03>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 "asit.k.mallick@intel.com" <asit.k.mallick@intel.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
 "amira@mellanox.com" <amira@mellanox.com>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Ganesh GR <ganeshgr@chelsio.com>, "Bob.Shaw@amd.com" <Bob.Shaw@amd.com>,
 "patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>,
 Ding Tianhong <dingtianhong@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Michael Werner <werner@chelsio.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "David.Laight@aculab.com" <David.Laight@aculab.com>,
 "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

| From: Raj, Ashok <ashok.raj@intel.com>
| Sent: Wednesday, August 9, 2017 8:58 AM
| ...
| As Casey pointed out in an earlier thread, we choose the heavy hammer
| approach because there are some that can lead to data-corruption as opposed
| to perf degradation.

Careful.  As far as I'm aware, there is no Data Corruption problem
whatsoever with Intel Root Ports and processing of Transaction Layer Packets
with and without the Relaxed Ordering Attribute set.

The only issue which we've discovered with relatively recent Intel Root Port
implementations and the use of the Relaxed Ordering Attribute is a
performance issue.  To the best of our ability to analyze the PCIe traces,
it appeared that the Intel Root Complex delayed returning Link Flow Control
Credits resulting in lowered performance (total bandwidth).  When we used
Relaxed Ordering for Ingress Packet Data delivery on a 100Gb/s Ethernet
link with 1500-byte MTU, we were pegged at ~75Gb/s.  Once we disabled
Relaxed Ordering, we were able to deliver Ingress Packet Data to Host Memory
at the full link rate.

Casey

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
