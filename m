Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Casey Leedom <leedom@chelsio.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, Ding Tianhong
 <dingtianhong@huawei.com>
Subject: Re: [PATCH v7 3/3] net/cxgb4: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
Date: Fri, 14 Jul 2017 00:00:07 +0000
Message-ID: <MWHPR12MB16004FB4E5A3DFB5B8D87876C8AC0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-4-git-send-email-dingtianhong@huawei.com>
 <CAKgT0UcBFBk9T7g0Dh-rHY6Z+6-4=5jsUWHbLcSMc+ohdTz=CA@mail.gmail.com>,
 <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
In-Reply-To: <CAKgT0Uf8Tg6AFthXt-bJrdNHCqJ3MfzduR1yCMMsjLYoEFXb-w@mail.gmail.com>
MIME-Version: 1.0
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
 Bjorn Helgaas <helgaas@kernel.org>, Jeff
 Kirsher <jeffrey.t.kirsher@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Ganesh GR <ganeshgr@chelsio.com>, Bob Shaw <Bob.Shaw@amd.com>,
 Patrick J Cramer <patrick.j.cramer@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Michael Werner <werner@chelsio.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Amir Ancel <amira@mellanox.com>, Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>,
 Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, David Miller <davem@davemloft.net>,
 h <l.stach@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-1"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[[ Sorry for the Double Send: I forgot to switch to Plain Text.  Have I men=
tioned how much I hate modern Web-based email agents? :-) -- Casey ]]

=A0 Yeah, I think this works  for now.=A0 We'll stumble over what to do whe=
n we want to mix upstream  TLPs without Relaxed Ordering Attributes directe=
d at problematic Root  Complexes, and Peer-to-Peer TLPs with Relaxed Orderi=
ng Attributes ... or vice versa depending on which target PCIe Device has  =
issues with Relaxed Ordering.

=A0 Thanks for all the work!

Casey    =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
