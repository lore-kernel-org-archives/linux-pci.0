Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Casey Leedom' <leedom@chelsio.com>, "Raj, Ashok" <ashok.raj@intel.com>
Subject: RE: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
Date: Mon, 7 Aug 2017 09:04:19 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD004C785@AcuExch.aculab.com>
References: <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home>
 <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <75213fca-4522-2297-3cb8-338e643d3552@huawei.com>
 <CAKgT0UcqdRCwDDxD=22Q_jLuqz8KVHwH1-V45Aq-1WzQw=agcA@mail.gmail.com>
 <14218972-553d-eb60-0207-460ac7f4b064@huawei.com>
 <MWHPR12MB1600A6986E4AD13D302F2DC9C8B00@MWHPR12MB1600.namprd12.prod.outlook.com>
 <20170803083153.GB4883@otc-nc-03>
 <MWHPR12MB1600400EC7DEE92E4A3ADC5BC8B60@MWHPR12MB1600.namprd12.prod.outlook.com>,
 <20170804202141.GA39054@otc-nc-03>
 <MWHPR12MB160086C4B4FA8F3B2EC1D5F9C8B60@MWHPR12MB1600.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB160086C4B4FA8F3B2EC1D5F9C8B60@MWHPR12MB1600.namprd12.prod.outlook.com>
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
 Alexander Duyck <alexander.duyck@gmail.com>, Sinan Kaya <okaya@codeaurora.org>,
 "amira@mellanox.com" <amira@mellanox.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 Ding Tianhong <dingtianhong@huawei.com>, Ganesh GR <ganeshgr@chelsio.com>,
 "Bob.Shaw@amd.com" <Bob.Shaw@amd.com>,
 "patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Michael
 Werner <werner@chelsio.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Casey Leedom
> Sent: 04 August 2017 21:49
...
> Whenever our Hardware Designers implement new functionality in our hardware,
> they almost always put in A. several "knobs" which can control fundamental
> parameters of the new Hardware Feature, and B.  a mechanism of completely
> disabling it if necessary.  This stems from the incredibly long Design ->
> Deployment cyle for Hardware (as opposed to the edit->compile->run cycle for s!

Indeed, I'd also expect there to be an undocumented flag to turn
it on (broken) in earlier parts to allow testing.

	David


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
