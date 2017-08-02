Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Casey Leedom <leedom@chelsio.com>
To: Ding Tianhong <dingtianhong@huawei.com>, Alexander Duyck
 <alexander.duyck@gmail.com>
Subject: Re: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
Date: Wed, 2 Aug 2017 17:53:52 +0000
Message-ID: <MWHPR12MB1600A6986E4AD13D302F2DC9C8B00@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
 <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
 <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home>
 <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <75213fca-4522-2297-3cb8-338e643d3552@huawei.com>
 <CAKgT0UcqdRCwDDxD=22Q_jLuqz8KVHwH1-V45Aq-1WzQw=agcA@mail.gmail.com>,
 <14218972-553d-eb60-0207-460ac7f4b064@huawei.com>
In-Reply-To: <14218972-553d-eb60-0207-460ac7f4b064@huawei.com>
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
 "linuxarm@huawei.com" <linuxarm@huawei.com>, Sinan Kaya <okaya@codeaurora.org>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>,
 "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Ganesh GR <ganeshgr@chelsio.com>, "Bob.Shaw@amd.com" <Bob.Shaw@amd.com>,
 "patrick.j.cramer@intel.com" <patrick.j.cramer@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Michael Werner <werner@chelsio.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "amira@mellanox.com" <amira@mellanox.com>,
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

=A0 Okay, here you go.=A0 As you can tell, it's almost a trivial copy of the
cxgb4 patch.
=A0
=A0 By the way, I realized that we have yet another hole which is likely not
to be fixable.=A0 If we're dealing with a problematic Root Complex, and we
instantiate Virtual Functions and attach them to a Virtual Machine along
with an NVMe device which can deal with Relaxed Ordering TLPs, the VF driver
in the VM will be able to tell that it shouldn't attempt to send RO TLPs to
the RC because it will see the state of its own PCIe Capability Device
Control[Relaxed Ordering Enable] (a copy of the setting in the VF's
corresponding PF), but it won't be able to change that and send non-RO TLPs
to the RC, and RO TLPs to the NVMe device.=A0 Oh well.

=A0 I sure wish that the Intel guys would pop up with a hidden register cha=
nge
for these problematic Intel RCs that perform poorly with RO TLPs.=A0 Their
silence has been frustrating.

Casey

----------

cxgb4vf Ethernet driver now queries PCIe configuration space to determine if
it can send TLPs to it with the Relaxed Ordering Attribute set.

diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h b/drivers/net/e=
thernet/chelsio/cxgb4vf/adapter.h
index 109bc63..08c6ddb 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/adapter.h
@@ -408,6 +408,7 @@ enum { /* adapter flags */
 	USING_MSI          =3D (1UL << 1),
 	USING_MSIX         =3D (1UL << 2),
 	QUEUES_BOUND       =3D (1UL << 3),
+	ROOT_NO_RELAXED_ORDERING =3D (1UL << 4),
 };
 =

 /*
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/=
net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index ac7a150..59e7639 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -2888,6 +2888,24 @@ static int cxgb4vf_pci_probe(struct pci_dev *pdev,
 	 */
 	adapter->name =3D pci_name(pdev);
 	adapter->msg_enable =3D DFLT_MSG_ENABLE;
+
+	/* If possible, we use PCIe Relaxed Ordering Attribute to deliver
+	 * Ingress Packet Data to Free List Buffers in order to allow for
+	 * chipset performance optimizations between the Root Complex and
+	 * Memory Controllers.  (Messages to the associated Ingress Queue
+	 * notifying new Packet Placement in the Free Lists Buffers will be
+	 * send without the Relaxed Ordering Attribute thus guaranteeing that
+	 * all preceding PCIe Transaction Layer Packets will be processed
+	 * first.)  But some Root Complexes have various issues with Upstream
+	 * Transaction Layer Packets with the Relaxed Ordering Attribute set.
+	 * The PCIe devices which under the Root Complexes will be cleared the
+	 * Relaxed Ordering bit in the configuration space, So we check our
+	 * PCIe configuration space to see if it's flagged with advice against
+	 * using Relaxed Ordering.
+	 */
+	if (!pcie_relaxed_ordering_supported(pdev))
+		adapter->flags |=3D ROOT_NO_RELAXED_ORDERING;
+
 	err =3D adap_init0(adapter);
 	if (err)
 		goto err_unmap_bar;
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c b/drivers/net/ether=
net/chelsio/cxgb4vf/sge.c
index e37dde2..05498e7 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2205,6 +2205,7 @@ int t4vf_sge_alloc_rxq(struct adapter *adapter, struc=
t sge_rspq *rspq,
 	struct port_info *pi =3D netdev_priv(dev);
 	struct fw_iq_cmd cmd, rpl;
 	int ret, iqandst, flsz =3D 0;
+	int relaxed =3D !(adapter->flags & ROOT_NO_RELAXED_ORDERING);
 =

 	/*
 	 * If we're using MSI interrupts and we're not initializing the
@@ -2300,6 +2301,8 @@ int t4vf_sge_alloc_rxq(struct adapter *adapter, struc=
t sge_rspq *rspq,
 			cpu_to_be32(
 				FW_IQ_CMD_FL0HOSTFCMODE_V(SGE_HOSTFCMODE_NONE) |
 				FW_IQ_CMD_FL0PACKEN_F |
+				FW_IQ_CMD_FL0FETCHRO_V(relaxed) |
+				FW_IQ_CMD_FL0DATARO_V(relaxed) |
 				FW_IQ_CMD_FL0PADEN_F);
 =

 		/* In T6, for egress queue type FL there is internal overhead

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
