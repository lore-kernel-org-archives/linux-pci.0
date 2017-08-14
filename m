Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Casey Leedom <leedom@chelsio.com>
To: "Raj, Ashok" <ashok.raj@intel.com>, Ding Tianhong <dingtianhong@huawei.com>
Subject: Re: [PATCH v10 3/5] PCI: Disable Relaxed Ordering Attributes for AMD
 A1100
Date: Mon, 14 Aug 2017 18:07:51 +0000
Message-ID: <MWHPR12MB1600654CA840BC47AFC06127C88C0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <1502725499-11276-1-git-send-email-dingtianhong@huawei.com>
 <1502725499-11276-4-git-send-email-dingtianhong@huawei.com>,
 <20170814171937.GA52656@otc-nc-03>
In-Reply-To: <20170814171937.GA52656@otc-nc-03>
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
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Ganesh GR <ganeshgr@chelsio.com>, "Bob.Shaw@amd.com" <Bob.Shaw@amd.com>,
 "patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

| From: Raj, Ashok <ashok.raj@intel.com>
| Sent: Monday, August 14, 2017 10:19 AM
| =A0   =

| On Mon, Aug 14, 2017 at 11:44:57PM +0800, Ding Tianhong wrote:
| > Casey reported that the AMD ARM A1100 SoC has a bug in its PCIe
| > Root Port where Upstream Transaction Layer Packets with the Relaxed
| > Ordering Attribute clear are allowed to bypass earlier TLPs with
| > Relaxed Ordering set, it would cause Data Corruption, so we need
| > to disable Relaxed Ordering Attribute when Upstream TLPs to the
| > Root Port.
| > =

| > Signed-off-by: Casey Leedom <leedom@chelsio.com>
| > Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
| > Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
| > Acked-by: Ashok Raj <ashok.raj@intel.com>
| =

| I can't ack this patch :-).. must be someone from AMD. Please remove my
| signature from this.

  You can go ahead and leave my name on since I'm the person who found and =
diagnosed the problem (with help from others inside Chelsio).

  If anyone on the Linux PCI List knows anyone at AMD who'd be willing to r=
espond it would be great, but as I noted earlier, I think that AMD has effe=
ctively abandoned the A1100 ("Seattle") ARM SoC, so I doubt if we'll get an=
yone from AMD to even comment now.

Casey
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
