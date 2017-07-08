Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Casey Leedom <leedom@chelsio.com>
To: Ding Tianhong <dingtianhong@huawei.com>, "ashok.raj@intel.com"
 <ashok.raj@intel.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "Michael
 Werner" <werner@chelsio.com>, Ganesh GR <ganeshgr@chelsio.com>,
 "asit.k.mallick@intel.com" <asit.k.mallick@intel.com>,
 "patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>,
 "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
 "Bob.Shaw@amd.com" <Bob.Shaw@amd.com>, "l.stach@pengutronix.de"
 <l.stach@pengutronix.de>, "amira@mellanox.com" <amira@mellanox.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 "David.Laight@aculab.com" <David.Laight@aculab.com>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "alexander.duyck@gmail.com"
 <alexander.duyck@gmail.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/3] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
Date: Sat, 8 Jul 2017 00:30:12 +0000
Message-ID: <MWHPR12MB160006024D920ED58126048AC8AB0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <1498133721-21152-1-git-send-email-dingtianhong@huawei.com>,
 <MWHPR12MB160087E9E0B17F7A17609714C8AA0@MWHPR12MB1600.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB160087E9E0B17F7A17609714C8AA0@MWHPR12MB1600.namprd12.prod.outlook.com>
MIME-Version: 1.0
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

  By the way, it ~seems~ like the patch set confuses the idea of the PCIe Capability Device Control[Relaxed Ordering Enable] with the device's ability to handle incoming TLPs with the Relaxed Ordering Attribute set.  These are completely different things.  The PCIe Capability Device Control[Relaxed Ordering Enable] solely governs the ability of the device to _send_ TLPs with the Relaxed Ordering Attribute set.  It has nothing whatsoever to do with the handling of incoming TLPs with the Relaxed Ordering Attribute set.  In fact, there is any standard way to disable receipt processing of such TLPs.  That's kind of the whole point of the majority of the patch.  If there was a separate "Ignore Incoming Relaxed Ordering Attributes" then we'd mostly just have a quirk which would set that for problematic devices.

  Worse yet, if I'm reading the patch right, it _is_ turning off the PCIe Capability Device Control[Relaxed Ordering Enable] for the devices that we've identified with problematic receive handling.  Not only does this not solve the problem that we've been talking about, it actually almost certainly introduces a huge Graphics Performance Bug.  The Relaxed Ordering Attribute was originally developed for Graphics Device support in order to download textures, etc. to a graphics devices as fast as possible and only ensure ordering at points where needed.  For instance, as far as I know, the Intel Root Complexes that we've been talking about have no issues whatsoever in generating downstream TLPs with the Relaxed Ordering Attribute set.  By turning off the PCIe Capability Device Control[Relaxed Ordering Enable] on these Root Complexes, this patch prevents the generation of downstream TLPs with the Relaxed Ordering Attribute set targeted at devices like graphics adapters.

Casey
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
