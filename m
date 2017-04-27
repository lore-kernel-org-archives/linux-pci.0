Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Casey Leedom <leedom@chelsio.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next 1/4] ixgbe: sparc: rename the
 ARCH_WANT_RELAX_ORDER to IXGBE_ALLOW_RELAXED_ORDER
Date: Thu, 27 Apr 2017 19:00:27 +0000
Message-ID: <MWHPR12MB1600F53E6E09C9B3F99D255EC8100@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <20170401.112603.1991545644693496714.davem@davemloft.net>
 <42428725-89f1-1508-4e3d-723e087b3bbb@huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E205199C0@FRAEML521-MBX.china.huawei.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD3C52@AcuExch.aculab.com>
 <DB5PR05MB138288172B04713EB0C1DB55D3190@DB5PR05MB1382.eurprd05.prod.outlook.com>
 <a2239141-a185-1bb8-0abd-7a05b9fde015@huawei.com>
 <CAKgT0Uc4L=GgYbpO-Fm9OfN+_fLypbDP1c+X4T_ta90ecQiyGQ@mail.gmail.com>,
 <20170427171938.GA10705@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170427171938.GA10705@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Amir Ancel <amira@mellanox.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Ding Tianhong <dingtianhong@huawei.com>, Will
 Deacon <will.deacon@arm.com>, LinuxArm <linuxarm@huawei.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 David Laight <David.Laight@aculab.com>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

  Thanks for adding me to the Cc list Bjorn.  Hopefully my message will make
it out to the netdev and linux-pci lists -- I'm not currently subscribed to
them.  I've explicitly marked this message to be sent in plain text but
modern email agents suck with respect to this. (sigh) I have officially
become a curmudgeon. 

  So, officially, Relaxed Ordering should be a Semantic Noop as far as PCIe
transfers are concerned, as long as you don't care what order the PCIe
Transaction Layer Packets are processed in by the target PCIe Fabric End
Point.

  Basically, if you have some number of back-to-back PCIe TLPs between two
Fabric End Points {A} -> {B} which have the Relaxed Ordering Attribute set,
the End Point {B} receiving these RO TLPs may process them in any order it
likes.  When a TLP without Relaxed Ordering is sent {A} -> {B}, all
preceding TLPs with Relaxed Ordering set must be processed by {B} prior to
processing the TLP without Relaxed Ordering set.  In this sense, a TLP
without Relaxed Ordering set is something akin to a "memory barrier".

  All of this is covered in Section 2.4.1 of the PCIe 3.0 Specification (PCI
Express(r) Base Specification Revision 3.0 November 10, 2010).

  The advantage of using Relaxed Ordering (which is heavily used when
sending data to Graphics Cards as I understand it), is that the PCIe
Endpoint can potentially optimize the processing order of RO TLPs with
things like a local multi-channel Memory Controller in order to achieve the
highest transfer bandwidth possible.

  However, we have discovered at least two PCIe 3.0 Root Complex
implementations which have problems with TLPs directed at them with the
Relaxed Ordering Attribute set and I'm in the process of working up a Linux
Kernel PCI "Quirk" to allow those PCIe End Points to be marked as "not being
advisable to send RO TLPs to".  These problems range from "mere" Performance
Problems to outright Data Corruption.  I'm working with the vendors of these
...  "problematic" Root Complex implementations and hope to have this patch
submitted to the linux-pci list by tomorrow.

  By the way, it's important to note that just because, say, a Root Complex
has problems with RO TLPs directed at it, that doesn't mean that you want to
avoid all use of Relaxed Ordering within the PCIe Fabric.  For instance,
with the vendor whose Root Complex has a Performance Problem with RO TLPs
directed at it, it's perfectly reasonable -- and desired -- to use Relaxed
Ordering in Peer-to-Peer traffic.  Say for instance, with an NVMe <->
Ethernet application.

Casey

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
