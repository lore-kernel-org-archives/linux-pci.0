Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BB396560;
	Wed, 12 Aug 2026 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510419; cv=fail; b=jsIvjrbS8TQrgHa92W/4GZtfAsjW6552fK7dpO7d3ve2AM5UtqXF+wrsbwDH8c0lz9a/UEFCEG1BU+Oc+jE14Pwk0LUDg6aUqSzpMZA16vWpz8+zSBQHLSw1YJV74e5dJGTrp8RQ8UGkmjIW4eMIDGn4lUN7rvTeCX3zv7rQbTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510419; c=relaxed/simple;
	bh=M/azG7+6ZstguPGmejjj7KFL8EPz8ifM9HKCKWiPZ88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nDe/iYDHJwr8PmrVHy8CPxOE/QW3wvC5PE1YzvZtxjYG7GRgROy46lZ4ZLiC1EH+pemEO5axM1IZlKlJg00/CQ9FDuTv62aeMjlrORDmAsQsXZg7KyazKLThY8bG3fWc6zNKxjcImeC2nWXqcSoxU5scqZ5f8AGPOvcvty4VQbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j3hbe/U3; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j3hbe/U3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgFJThYXmmCRFgws+CY0ygqjVKdDENTY9H9lSId6pHQzOnpqJCk68CInaxHeIh8FE3+hT9thUtDjdfpqMCpLiBzNtc0hCF5e4dRUFWzU6obkb2kVZ+1VsfCz9dBalTAue8HejeT95ZmcP7YPJ2tep3WsH+tUK9e0c6Ljv1eaOhpDy+gmDmTzyM9BrKNjI/G9KaJiCTR1OooptihwRk2zRzkqdmdjRoDSyjbuBZEFw71bnugDnYfbIUfkEuZt9IDdvYQqLQN1ox7nFX60MgHpGkIAOBa4in399+MJI2XrC9Uh174j0Lw2kTzQnoskThP02vZX43R7uex326ASmTbitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp8ZddPUxUdZI6uEPtjEGBJN/ROZGKYjzG0/x4gIuzs=;
 b=UuFbn5tDmDo1v4+kO9NLrvfEK2fQwPU1pPiq2I6xPrzHLexWx8tNrV4zZbDqWkhHEWwqfa75oMSe4bq2hOnPylqA21OBnVrtyfc+vV/fYSbN3ojqK9oaETZuQPBGWqhOuFKZnNvFt+TeKpIEUmW0aRM02COrk594Jw1dWuaV3r6v4Xb3hs/OC3JFKA7VVeRAgnvJP+jvUbuAkKW/wSq9TqnZuabeiuEklmH8AHKa9YmhOVT/eOhYs+DaEUch6i5fHC1JltKY/fjaO4U/1U7jtZRmUJBRIiCeO+I1jEMWb3RoSCBY/3aREa0SSkullhh/EiRvthJ9FD179vV9NB9NHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp8ZddPUxUdZI6uEPtjEGBJN/ROZGKYjzG0/x4gIuzs=;
 b=j3hbe/U3cgqeI27xfrKxSLHL1FJJWqPbFN4R6aHMotpqQAu+r8PcW21bIJUivzrv+sixGJKzYYV0YbMukN7EwmiqLNUJ7ZdJFP9WeC+89n2LQBP5C63VywlP4MKXeNgcVvqko3xOG4wmynUIeuuIXwAoYj2qvPbFAjAtZu6ks2yEY7ffWFRYlZKcqFdVJgUc3mizwu9zF9Yxd4xEJko7J6+PRwXh2768L376czhrZ2/GxOqBFchWYBivD1TaiWKCWyg4vGcpyC6R1l5QMU00O18zeUY5yvWQYPahVgCVjOn0e00Go6Kg5iwnhAfHCNQNMQEdoaLgIUWi7UZFGo/8YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 04:53:30 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 04:53:29 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	skhawaja@google.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: [RFC PATCH 2/5] PCI: Add pci_reset_bus_cond() for a caller-gated slot or bus reset
Date: Tue, 11 Aug 2026 22:53:20 -0600
Message-ID: <20260812045325.2733631-3-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812045325.2733631-1-alex.williamson@nvidia.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::25) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f0e514-e79f-4405-e1ec-08def82da706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sgqVu4k7sf4rkI4R11Z4fGYdomE9eC55rDK4fIEuo4LJP7AMki/8xcChVJDuStpBc9/c070EMgHp3P0D/IMLwYkF6KzB+bZ4iL7P2RxrSizh7+uWG91wS58BSrjLck3yQxqZ7zHJDlePUuK/yoxL7OllSUVwOYDVcFThgW2NZ9SIQK0Odcb+FkeZZ1ufzjmzlumuJ3h5KR9TPM7IoxWLAHz+lQJ6KFFBlQV7ZIMCD8RmkHhkZANI8mkPo48XaEeFeL0qwdZorF08GDJ81vLUO8Hd0ZEjcv380o5TuXyvN3L2tYkcEd5uoxpACiIZe/atCpKN+RI2Gf2d/KIJQ0F4X6nyqnMUbyrk14/zQqAT30mR4hEzhJKKMcbvmVC320StT4muQqro4KTAEk5whN8myEwaCZfK5T9F9Aqm+BCVg/XDYbxmRO/C2VkKyOH+EUwG9T1RRpOrdRqO7Sl4ivlvUGUllIhkwa/eKOpoJKj1HnOemc7fYK+WBKPHppkj/IkWPvht1mfYjTHXi9O+5Dhjn1nw2RT+Fo0C1Po8Dy789k6MCagAS2MGER0G3TLpWaOJNnMVw9t1ZNnTUigwXzC4no33mMs9DP8UqAwmyKz7mrWMM1tvpREpk0aOmO66M8+fr1+imi3ml72L/vbWAxGWbT+XCMCiwFYtNZ3C1xTetjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/oK8EQRyCyTSUnEjGC72sCx9rgjW55UIyay1FnaOwciUwWp0+PQT9gnf1nN?=
 =?us-ascii?Q?RykA30THsS4dn6Q6E2E0A4aT0JAcScXDRiG071W5zECOhj+8nsUU0CqiE2ks?=
 =?us-ascii?Q?jf1ZDb7JJMtiEJtYswmUyeZv6sZRXttWfHYRDXuzgB4fick59BAE47080xxA?=
 =?us-ascii?Q?9Yfrd7cHCpjMIKRsblCXU16uephXkk7BMDVbVFaweD+ZIqy4MpfEpdGBielQ?=
 =?us-ascii?Q?mTcCDQbYbcz9n5XFC8atjiCk9o708LEDdrB2+9ABEA7dHK/2sM6gdaMFG13N?=
 =?us-ascii?Q?3Hcdl0VLadGfkXdDue6yCgV8I1Nom/kQAhMNs1WsEcV6g1cG5eydgEE8Pbb6?=
 =?us-ascii?Q?d9fYRXdkTR9LD4UqGw6eXCEQXXuHe5+70pjsQwwyg8KRnSK15Y90/FRjE7nX?=
 =?us-ascii?Q?+67JLeIyZ1CyPfP333sIFY2eob/BOc9Dz5cBtgk7DwXiWU+s/fA3ERYmOSFp?=
 =?us-ascii?Q?cKGdBGiE8p0CbOArN1XwNOGj/tgiiPjq+DuK/mkRqJkdHkd/n3EdjkDUvasN?=
 =?us-ascii?Q?UOx0StOD8IVXqf+QNbM029FE5P0Fe34xcGo0cCQw54AiGV1yS3ALxjAsy2hB?=
 =?us-ascii?Q?B1bWD5Wp8B+Hc3rtJ+hgKePRWg3lLklPtLbAgmW22ETV4flm/onAyNVy7bSZ?=
 =?us-ascii?Q?ULdJZHiv/dyt1OEZwUJVEzg6cCQyHidIrAGWqvQZgbymxs+GvbLMwWepD8Fv?=
 =?us-ascii?Q?xZmY8VjGHZpWqCg0m2wph/Yskmlkwn/9Xr7sNHVDUcc76UQchejT20HBViYA?=
 =?us-ascii?Q?BTlc0ZHlPtMUb1T9vGrTlmcZ3Yu4RMHEpNXKq9QBj6vSQPAYJorK71HByAZ2?=
 =?us-ascii?Q?1eW9xm0gw+DqbZ2M48Nkn74F18aI+u6Gt7S1YpMsflC7pY/iZFPWdpzH5097?=
 =?us-ascii?Q?3FTYQXl3ffeYGiEq2iNz8OhyCKZlUKJIZzZ3KZ/SyjljCxJwShk7JQeN12jG?=
 =?us-ascii?Q?fgPtpdXHYXK4dvMoyFJI+u9Mk+o69lhAwegpzmezcf0EThRYpZAFBGwRXA6h?=
 =?us-ascii?Q?ruQBbxdocquUeeMQjWz2kBRzFV7bSY7LU8gBvJBFu8gcUjnR1ZuP2g8bhVma?=
 =?us-ascii?Q?KDk/HOLubOj4eHboAztOTLTuJQmebUO7102OwLbYaJ5vn3qDwe8/wUO/iQNB?=
 =?us-ascii?Q?QzusXiru+VteYbcsboUCkUjd+wUCjbi79SFTJUD5NiQwBSQGJW4fralGrYwu?=
 =?us-ascii?Q?QG87U2qEqSPzbQ0woOWanbIwqf53ekCY5Rep1d0OIW6mkzi37Tat1cmj7QzW?=
 =?us-ascii?Q?qNyLxwLjLWdCaGjgTQEctvgjKgu6ViLCVWuTLLrtLKJQe99fY4Y7KWm07FAg?=
 =?us-ascii?Q?fdETNLu5IAmlv0yuPrfSZyryhugb85MU3fwOjYsYU95UF69v1YaulZA9aYHa?=
 =?us-ascii?Q?nQNr8hvFIDun+j69UQMrZ4B4nwhMzibaQ01MAmdSsWDgyAUZtneByR9qAZjl?=
 =?us-ascii?Q?3JrC2PaLbv6RGYKkVK0w1Os5HSMuwtGEl/JDiQ+AH9JIA8aXOvsXHIGH1MOq?=
 =?us-ascii?Q?yrZo0gb7Rbetp5bCiXYxOTXxUJXWJbkS9ReaV4vsXQgenWCQCuu230NdUSxX?=
 =?us-ascii?Q?EPL/++gF86ushaoDWkf7/UZoFkrdWy3yZWvi9g7G70pt1xIJl5gmTpZ8w0Qs?=
 =?us-ascii?Q?CTt8YvZr7+NOkqCdBLKs1knlpHsJ8JnMNSoabCqPBu5Sj3T6LnFO0kMoMWEb?=
 =?us-ascii?Q?StlmA4Bv7FTeZ3VmeIu95AH809dlKV1L/ha7+rq5XJKfGbRwNrDxnuCEdJyq?=
 =?us-ascii?Q?LFSWKzTQjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f0e514-e79f-4405-e1ec-08def82da706
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 04:53:29.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwTK4hg6Al1XRgUcQBpEokr+XoXptxG85QZSddv6UUS2sr5+QAGwAeRwqkqm0/ZP/cQLenBk4n6FUQIt1bk1Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

pci_reset_bus() locks every device affected by a slot or bus reset,
performs the reset, and unlocks the devices, all internally.  A caller
has no way to evaluate what the reset would actually touch.

Add pci_reset_bus_cond(), which takes a callback invoked on each
affected device once they are all locked.  A nonzero return value from
the callback aborts the reset and the value is returned to the caller.
This allows, for instance, the caller to validate that SR-IOV is not
enabled on any affected device under device_lock, where the value is
known stable across the reset.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/pci/pci.c   | 97 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/pci.h |  3 ++
 2 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b40b00c0c0c9..06728137c407 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5567,9 +5567,36 @@ int pci_probe_reset_slot(struct pci_slot *slot)
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
 
+/* Call @cb on every device a slot or bus reset affects, stopping on error. */
+static int pci_walk_reset_check(struct pci_bus *bus, struct pci_slot *slot,
+				int (*cb)(struct pci_dev *dev, void *data),
+				void *data)
+{
+	struct pci_dev *dev;
+	int rc;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
+		rc = cb(dev, data);
+		if (rc)
+			return rc;
+		if (dev->subordinate) {
+			rc = pci_walk_reset_check(dev->subordinate,
+						  NULL, cb, data);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * pci_try_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
+ * @check: optional per-device callback that can abort the reset
+ * @data: opaque argument for @check
  *
  * A PCI bus may host multiple slots, each slot may support a reset mechanism
  * independent of other slots.  For instance, some slots may support slot power
@@ -5582,7 +5609,9 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
-static int pci_try_reset_slot(struct pci_slot *slot)
+static int pci_try_reset_slot(struct pci_slot *slot,
+			      int (*check)(struct pci_dev *dev, void *data),
+			      void *data)
 {
 	int rc;
 
@@ -5591,10 +5620,14 @@ static int pci_try_reset_slot(struct pci_slot *slot)
 		return rc;
 
 	if (pci_slot_trylock(slot)) {
-		pci_slot_save_and_disable_locked(slot);
-		might_sleep();
-		rc = pci_reset_hotplug_slot(slot->hotplug, PCI_RESET_DO_RESET);
-		pci_slot_restore_locked(slot);
+		rc = check ? pci_walk_reset_check(slot->bus, slot, check, data) : 0;
+		if (!rc) {
+			pci_slot_save_and_disable_locked(slot);
+			might_sleep();
+			rc = pci_reset_hotplug_slot(slot->hotplug,
+						    PCI_RESET_DO_RESET);
+			pci_slot_restore_locked(slot);
+		}
 		pci_slot_unlock(slot);
 	} else
 		rc = -EAGAIN;
@@ -5626,10 +5659,14 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
 /**
  * pci_try_reset_bus - Try to reset a PCI bus
  * @bus: top level PCI bus to reset
+ * @check: optional per-device callback that can abort the reset
+ * @data: opaque argument for @check
  *
  * Same as above except return -EAGAIN if the bus cannot be locked
  */
-static int pci_try_reset_bus(struct pci_bus *bus)
+static int pci_try_reset_bus(struct pci_bus *bus,
+			     int (*check)(struct pci_dev *dev, void *data),
+			     void *data)
 {
 	int rc;
 
@@ -5638,10 +5675,13 @@ static int pci_try_reset_bus(struct pci_bus *bus)
 		return rc;
 
 	if (pci_bus_trylock(bus)) {
-		pci_bus_save_and_disable_locked(bus);
-		might_sleep();
-		rc = pci_bridge_secondary_bus_reset(bus->self);
-		pci_bus_restore_locked(bus);
+		rc = check ? pci_walk_reset_check(bus, NULL, check, data) : 0;
+		if (!rc) {
+			pci_bus_save_and_disable_locked(bus);
+			might_sleep();
+			rc = pci_bridge_secondary_bus_reset(bus->self);
+			pci_bus_restore_locked(bus);
+		}
 		pci_bus_unlock(bus);
 	} else
 		rc = -EAGAIN;
@@ -5680,7 +5720,7 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
 
 	list_for_each_entry(slot, &bus->slots, list) {
 		if (restore)
-			ret = pci_try_reset_slot(slot);
+			ret = pci_try_reset_slot(slot, NULL, NULL);
 		else
 			ret = pci_slot_reset(slot, PCI_RESET_DO_RESET);
 
@@ -5694,7 +5734,7 @@ static int pci_reset_bridge(struct pci_dev *bridge, bool restore)
 	mutex_unlock(&pci_slot_mutex);
 
 	if (restore)
-		return pci_try_reset_bus(bus);
+		return pci_try_reset_bus(bus, NULL, NULL);
 	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
 }
 
@@ -5724,16 +5764,43 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
+/**
+ * pci_reset_bus_cond - conditionally reset the slot or bus containing a device
+ * @pdev: top level PCI device to reset via slot/bus
+ * @check: optional callback invoked on each affected device before the reset
+ * @data: opaque argument passed to @check
+ *
+ * Reset the slot or bus containing @pdev.  Once the entire physical bus/slot
+ * hierarchy is locked, @check (if not NULL) is called on each of those locked
+ * devices.  A nonzero return aborts the reset and is returned to the caller,
+ * otherwise the reset proceeds.
+ *
+ * NB. @check runs with the full set of device_locks noted above held; callbacks
+ * must take these locking semantics into account.  Use NULL to perform an
+ * unconditional reset.
+ *
+ * Return: 0 on success, -ENOTTY if @pdev is not resettable, -EAGAIN if the
+ * devices cannot be locked, or the value returned by @check.
+ */
+int pci_reset_bus_cond(struct pci_dev *pdev,
+		       int (*check)(struct pci_dev *dev, void *data),
+		       void *data)
+{
+	return !pci_probe_reset_slot(pdev->slot) ?
+		pci_try_reset_slot(pdev->slot, check, data) :
+		pci_try_reset_bus(pdev->bus, check, data);
+}
+EXPORT_SYMBOL_GPL(pci_reset_bus_cond);
+
 /**
  * pci_reset_bus - Try to reset a PCI bus
  * @pdev: top level PCI device to reset via slot/bus
  *
- * Same as above except return -EAGAIN if the bus cannot be locked
+ * Same as above without the conditional check.
  */
 int pci_reset_bus(struct pci_dev *pdev)
 {
-	return (!pci_probe_reset_slot(pdev->slot)) ?
-	    pci_try_reset_slot(pdev->slot) : pci_try_reset_bus(pdev->bus);
+	return pci_reset_bus_cond(pdev, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(pci_reset_bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..ab41a49f4eb7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1480,6 +1480,9 @@ int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
 int pci_reset_bus(struct pci_dev *dev);
+int pci_reset_bus_cond(struct pci_dev *pdev,
+		       int (*check)(struct pci_dev *dev, void *data),
+		       void *data);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
-- 
2.53.0

