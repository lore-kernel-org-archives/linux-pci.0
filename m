Return-Path: <decui@microsoft.com>
Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hadden Hoppert
	<haddenh@microsoft.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "Stephen
 Hemminger" <sthemmin@microsoft.com>
Subject: [PATCH 1/5] PCI: hv: use zero-length array in struct pci_packet
Date: Tue, 23 Aug 2016 04:45:51 +0000
Message-ID: <MWHPR03MB2669F8A36FED7F82306CF98CBFEB0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


And, rename struct pci_message's field "message_type" to "type.

This makes the code more readable.

No functionality change.

Cc: Jake Oshins <jakeo@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/pci/host/pci-hyperv.c | 42 ++++++++++++++++++++-------------------=
---
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 7e9b2de..78758e9 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -200,11 +200,11 @@ struct tran_int_desc {
  */
=20
 struct pci_message {
-	u32 message_type;
+	u32 type;
 } __packed;
=20
 struct pci_child_message {
-	u32 message_type;
+	struct pci_message message_type;
 	union win_slot_encoding wslot;
 } __packed;
=20
@@ -222,7 +222,8 @@ struct pci_packet {
 	void (*completion_func)(void *context, struct pci_response *resp,
 				int resp_packet_size);
 	void *compl_ctxt;
-	struct pci_message message;
+
+	struct pci_message message[0];
 };
=20
 /*
@@ -314,7 +315,7 @@ struct pci_dev_incoming {
 } __packed;
=20
 struct pci_eject_response {
-	u32 message_type;
+	struct pci_message message_type;
 	union win_slot_encoding wslot;
 	u32 status;
 } __packed;
@@ -694,13 +695,12 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev=
,
 	struct pci_delete_interrupt *int_pkt;
 	struct {
 		struct pci_packet pkt;
-		u8 buffer[sizeof(struct pci_delete_interrupt) -
-			  sizeof(struct pci_message)];
+		u8 buffer[sizeof(struct pci_delete_interrupt)];
 	} ctxt;
=20
 	memset(&ctxt, 0, sizeof(ctxt));
 	int_pkt =3D (struct pci_delete_interrupt *)&ctxt.pkt.message;
-	int_pkt->message_type.message_type =3D
+	int_pkt->message_type.type =3D
 		PCI_DELETE_INTERRUPT_MESSAGE;
 	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
 	int_pkt->int_desc =3D *int_desc;
@@ -845,8 +845,7 @@ static void hv_compose_msi_msg(struct irq_data *data, s=
truct msi_msg *msg)
 	struct cpumask *affinity;
 	struct {
 		struct pci_packet pkt;
-		u8 buffer[sizeof(struct pci_create_interrupt) -
-			  sizeof(struct pci_message)];
+		u8 buffer[sizeof(struct pci_create_interrupt)];
 	} ctxt;
 	int cpu;
 	int ret;
@@ -874,7 +873,7 @@ static void hv_compose_msi_msg(struct irq_data *data, s=
truct msi_msg *msg)
 	ctxt.pkt.completion_func =3D hv_pci_compose_compl;
 	ctxt.pkt.compl_ctxt =3D &comp;
 	int_pkt =3D (struct pci_create_interrupt *)&ctxt.pkt.message;
-	int_pkt->message_type.message_type =3D PCI_CREATE_INTERRUPT_MESSAGE;
+	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE;
 	int_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
 	int_pkt->int_desc.vector =3D cfg->vector;
 	int_pkt->int_desc.vector_count =3D 1;
@@ -1287,7 +1286,7 @@ static struct hv_pci_dev *new_pcichild_device(struct =
hv_pcibus_device *hbus,
 	pkt.init_packet.compl_ctxt =3D &comp_pkt;
 	pkt.init_packet.completion_func =3D q_resource_requirements;
 	res_req =3D (struct pci_child_message *)&pkt.init_packet.message;
-	res_req->message_type =3D PCI_QUERY_RESOURCE_REQUIREMENTS;
+	res_req->message_type.type =3D PCI_QUERY_RESOURCE_REQUIREMENTS;
 	res_req->wslot.slot =3D desc->win_slot.slot;
=20
 	ret =3D vmbus_sendpacket(hbus->hdev->channel, res_req,
@@ -1556,8 +1555,7 @@ static void hv_eject_device_work(struct work_struct *=
work)
 	int wslot;
 	struct {
 		struct pci_packet pkt;
-		u8 buffer[sizeof(struct pci_eject_response) -
-			  sizeof(struct pci_message)];
+		u8 buffer[sizeof(struct pci_eject_response)];
 	} ctxt;
=20
 	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
@@ -1583,7 +1581,7 @@ static void hv_eject_device_work(struct work_struct *=
work)
=20
 	memset(&ctxt, 0, sizeof(ctxt));
 	ejct_pkt =3D (struct pci_eject_response *)&ctxt.pkt.message;
-	ejct_pkt->message_type =3D PCI_EJECTION_COMPLETE;
+	ejct_pkt->message_type.type =3D PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot =3D hpdev->desc.win_slot.slot;
 	vmbus_sendpacket(hpdev->hbus->hdev->channel, ejct_pkt,
 			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
@@ -1685,7 +1683,7 @@ static void hv_pci_onchannelcallback(void *context)
 		case VM_PKT_DATA_INBAND:
=20
 			new_message =3D (struct pci_incoming_message *)buffer;
-			switch (new_message->message_type.message_type) {
+			switch (new_message->message_type.type) {
 			case PCI_BUS_RELATIONS:
=20
 				bus_rel =3D (struct pci_bus_relations *)buffer;
@@ -1716,7 +1714,7 @@ static void hv_pci_onchannelcallback(void *context)
 			default:
 				dev_warn(&hbus->hdev->device,
 					"Unimplemented protocol message %x\n",
-					new_message->message_type.message_type);
+					new_message->message_type.type);
 				break;
 			}
 			break;
@@ -1768,7 +1766,7 @@ static int hv_pci_protocol_negotiation(struct hv_devi=
ce *hdev)
 	pkt->completion_func =3D hv_pci_generic_compl;
 	pkt->compl_ctxt =3D &comp_pkt;
 	version_req =3D (struct pci_version_request *)&pkt->message;
-	version_req->message_type.message_type =3D PCI_QUERY_PROTOCOL_VERSION;
+	version_req->message_type.type =3D PCI_QUERY_PROTOCOL_VERSION;
 	version_req->protocol_version =3D PCI_PROTOCOL_VERSION_CURRENT;
=20
 	ret =3D vmbus_sendpacket(hdev->channel, version_req,
@@ -1969,7 +1967,7 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	pkt->completion_func =3D hv_pci_generic_compl;
 	pkt->compl_ctxt =3D &comp_pkt;
 	d0_entry =3D (struct pci_bus_d0_entry *)&pkt->message;
-	d0_entry->message_type.message_type =3D PCI_BUS_D0ENTRY;
+	d0_entry->message_type.type =3D PCI_BUS_D0ENTRY;
 	d0_entry->mmio_base =3D hbus->mem_config->start;
=20
 	ret =3D vmbus_sendpacket(hdev->channel, d0_entry, sizeof(*d0_entry),
@@ -2015,7 +2013,7 @@ static int hv_pci_query_relations(struct hv_device *h=
dev)
 		return -ENOTEMPTY;
=20
 	memset(&message, 0, sizeof(message));
-	message.message_type =3D PCI_QUERY_BUS_RELATIONS;
+	message.type =3D PCI_QUERY_BUS_RELATIONS;
=20
 	ret =3D vmbus_sendpacket(hdev->channel, &message, sizeof(message),
 			       0, VM_PKT_DATA_INBAND, 0);
@@ -2068,8 +2066,8 @@ static int hv_send_resources_allocated(struct hv_devi=
ce *hdev)
 		init_completion(&comp_pkt.host_event);
 		pkt->completion_func =3D hv_pci_generic_compl;
 		pkt->compl_ctxt =3D &comp_pkt;
-		pkt->message.message_type =3D PCI_RESOURCES_ASSIGNED;
 		res_assigned =3D (struct pci_resources_assigned *)&pkt->message;
+		res_assigned->message_type.type =3D PCI_RESOURCES_ASSIGNED;
 		res_assigned->wslot.slot =3D hpdev->desc.win_slot.slot;
=20
 		put_pcichild(hpdev, hv_pcidev_ref_by_slot);
@@ -2119,7 +2117,7 @@ static int hv_send_resources_released(struct hv_devic=
e *hdev)
 			continue;
=20
 		memset(&pkt, 0, sizeof(pkt));
-		pkt.message_type =3D PCI_RESOURCES_RELEASED;
+		pkt.message_type.type =3D PCI_RESOURCES_RELEASED;
 		pkt.wslot.slot =3D hpdev->desc.win_slot.slot;
=20
 		put_pcichild(hpdev, hv_pcidev_ref_by_slot);
@@ -2286,7 +2284,7 @@ static int hv_pci_remove(struct hv_device *hdev)
 	init_completion(&comp_pkt.host_event);
 	pkt.teardown_packet.completion_func =3D hv_pci_generic_compl;
 	pkt.teardown_packet.compl_ctxt =3D &comp_pkt;
-	pkt.teardown_packet.message.message_type =3D PCI_BUS_D0EXIT;
+	pkt.teardown_packet.message[0].type =3D PCI_BUS_D0EXIT;
=20
 	ret =3D vmbus_sendpacket(hdev->channel, &pkt.teardown_packet.message,
 			       sizeof(struct pci_message),
--=20
2.7.4
