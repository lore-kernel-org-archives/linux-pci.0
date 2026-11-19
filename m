Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120052;
	b=nFw1RnwUKm7hyaS20AIHkfQQdPc3Tpw3hqhBNnhHp8DvAuz/mgAw2y9QdTqbcEqQGDcT
	 Z70GzyVLl26LF8jk+0PnUKsFS1/aObahQ+KAG016y1h0TGdh6GkuY7VtWwEuFoRJjE7Di
	 qFL47AJtztCqg8rS02KQeL+ldt5HHXj22Bh4s+aqQQhMt+I/Q0oD5V83PfI1fbj16Z1aM
	 6dxazwAfLTituCHnnGZnlZ1qFfO8ImiemrQLuQIIcY5RJfH5pOROGmrwDqX+ysfA2jFUP
	 snw5r2BkuIhVSC+xgxwF6a/gy7H7pLiF7Mxi8dLO5wpX5l/FlNjP6ZIIl0Vc6rgbG4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120052;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=J3iIWmupWS8eOedtx4PiRDVgHjj/rmn7e58hHa/p6Zs=;
	b=u6Y/sJFO1InWpELp6bLCjfglzjx8NSUwExiuIXLTjQFoNa4jGRnNCiWG8mBYyaPg9XRS
	 DuUMVt5LT/UDVqZ6t1MkQVfnapcT39Dg9YfZA6ks2q29PhoLGgtYFUM3ZRW6VxSFjGLKp
	 FN1CzD/4el+Tdh+MZIzVCR/7fsOjQlOjFHkrA8eftsfQNiayXKBkF4Iqb7SN2Lx3pSBSQ
	 p6Rafq1wQk3IwcuPwlvRl2mk0R0Hr//yw7w/P3qO6mk44/XZHsbsFedsKxJz5l6fYUk42
	 uVmqqaZH3I8dpdIhZuGEJp5MQPUpNg4bdTiqqVcJv9YckHCWdvLRonQO2WmgGkv3fWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J2xgb1M7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.65
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AC606A325;
	Thu, 19 Nov 2026 20:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 236AC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J2xgb1M7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WP8b9ktBxe1jC5Tv575Ql4okkAAkeSktDPOvJ93jQ6HeAQiqt4qAOpFKmVpNd2Q+PLNh9xRB93MXEsnfSjMVpQc2obAvAlGDOpwhdEgzV63zTBs6D7QiA1Hfsrpf/EAXykYtXHOVP9iWzh8tTPjbBoohvsQ1wxIq3RjcKybfKf5V+xSrusnoQbnO6lnV/ezInGak2M/gb26P3aEQbYnCsscK+JTqwqiHDpxbo5Sn/sCqj6YHQgC3V4I4YYgyw1J8Wg3SLmnuxgyBlOkyrvw56sNeEW3bmTOZ9xwyuc+vOcv1dXYmr0x/Dh4Kwpd3uzxo3kXp7RFNR18ZyKJ0Q+TkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3iIWmupWS8eOedtx4PiRDVgHjj/rmn7e58hHa/p6Zs=;
 b=yEZ7MRAuoNHm1CRJ+FZJ6MdJmQmiv+sWpQSjmOtVMvpR/f2IJZgwV7iKNPxK2dAkGleMnB0ha2nCshcO1gKHiDw0K4NL8IJBRMPJLL9tMNumTVW7dWl9Ib81dJcgAtWutQt8h4+F/WP29tdTfepVi6gc88R0XvhO5YPgIe7BzkvWgl/CC5y/+kMbuOPeQfZus2LlqXHU49hWij0tyiFNfZqwVDSrVRt5/afNAeFC2hXjsBuZUg4b1YK0Tu+JCoVoELpGbchCL0TnJC3zJS7TwCXFE1pG7cZyXKt/2sf/GoszzldhzZTEbWwB3/y0uNpC13h9j4phVWZkYcNRgwv++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3iIWmupWS8eOedtx4PiRDVgHjj/rmn7e58hHa/p6Zs=;
 b=J2xgb1M7Jox6TlCf+6fCiCFmQ7NbQf3ox0rjcQQt9rXdWr2DhQ62g2JZ7gCHnFFM8iJ9Fg67qYzEKTIAerKu7q291SqaxwIVTtI6i+aLwsLBDwFKidAue/dphCnjoRpE4iEQl9WJPueUe5p4lBU4dlLHn0UvvUrBiiGd6zGFlfM=
Received: from DS1PR04CA0004.namprd04.prod.outlook.com (2603:10b6:8:44f::19)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 20:27:20 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:8:44f:cafe::1b) by DS1PR04CA0004.outlook.office365.com
 (2603:10b6:8:44f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 20:27:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:27:19 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:27:18 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 19/44] dmaengine: sdxi: validate and copy key ioctl payloads
Date: Thu, 19 Nov 2026 14:22:55 -0600
Message-ID: <20261119202321.1734355-20-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f09d0f-a6bd-4896-57e7-08df467b82af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|23010399003|10067099003|261022075727099003|261026121527099003|56012099006|261026140227099003|261026130827099003|11063799006|261022105027099003|261022115727099003|261021130227099003|261009223027099003|261021135927099003|261021123027099003|261021133027099003|261021121427099003|261022113327099003|261026135527099003|261102123227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q2svd8uN3e6eTVPG3Ik5d7YviupGYnVJBBgjr6yM0nsLQy3W0Q9U12/boOhYO9X7SJU9W/X6lDWxkO6DP8VmLBxa+67vGHcchPmDjAFjrYf79BaFJMmvc9CytwjrXxgUzxh51DAFB9L/Cp7HPIFuJj/h3D+FD/u7VRuA9+iEolEskdWPIbgOxR5AJHUkMqjPvfjYX2/7m74cmy3gRYEVbL5FW0qITSgBk4vm9Un/teHJOdjZYVEsei9q2VUB+tUDKmnFQUVqk0wrsuQ8zLrotZEvMLfLSp9iwezIRF09jTT4CDxFTNgbxHiOrHFCXAjMiVrwYNunFn9PZnvgDZ/WeP6OdraMS+tBt5QXyM0lvwIHd4/dHi8ljLqbStru2XSX1z9PJ3lrzdZFwb3QDALGDb8PNDnBgkOHojOyDW7x8ueXuhNyt+rJOYFtnGWDXXYJ9JDeyp/tNSj9Lue+VXI9SESQRwg3nJbOFxhT2WICpZkbMd6jbAIweGTLz9WZC/D0rgCNlGefbTWl6545dMi3y5eN9LrwbBeIW2w3AhISFyaH8cQs0y14FqdyfU8gGPxdkEpasi3S+S9dlDL8gEJn8z+XwVR32J4z/qv0HQ351dQrNnI+i6sIIZM7X47R/GmBtoGK9Z8Q3Y7riohkV6A7VCXIJYkGr4+g30F4BpMEnBgPFvYjK0YP6Ead4+drPBTBkocAFGMnwQLiRR2UPL3QJA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(23010399003)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(261026140227099003)(261026130827099003)(11063799006)(261022105027099003)(261022115727099003)(261021130227099003)(261009223027099003)(261021135927099003)(261021123027099003)(261021133027099003)(261021121427099003)(261022113327099003)(261026135527099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k4PlCHFWaPJ01APFDRgVG7mqewhmO5w8RSF4nWLKe6eKFCu7M3RnH47zBIrbjQMvtKoMDjopk34Mt5cojRCGh75pAAVkv4RD75tRhGuuirQYrQiCBU6AAlo9tZdiJBW3fCNHm4UwnQr3O9Yu4ldnaSJ5jLwS7S/vdTeRUtrNfCVV9hZZ7fa+33QMQC9WqBLazL6pNV3Z/iOy+V2mkbqDYgaI7nMgzKQf5fTjg63RBs2nvo0R6IQXWcyGKImjKAWjmlpsiE/ojzIe+wCx1a6ool3r5R1HKBfdsZKZY3AmKnMdtKQCfaW+Y528SY88UlZp/kkVt8xkHOHvxV5oQS3XyB9F625KUKzowuF8Q3ZEm1w+aJYoGx3YJz9J1hnx1aJPz8J1V7iTLXGSIbW7/Zd8RDllOejFhl73kOIP3Pqw/CqLw4O8lzfQW2VJgNa0hEw0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:27:19.6792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f09d0f-a6bd-4896-57e7-08df467b82af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635

Size variable-length key bitmap and entry payloads from their fixed
UAPI headers, validate table bounds before allocation, and copy only
the bytes described by the shared AKey/RKey ABI. Key handlers, which
will be introduced later, remain unsupported in this patch.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/ioctl.c | 161 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index 70dcde916c82..682b0b074f38 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -615,17 +615,85 @@ static bool sdxi_ioctl_has_trailing_payload(unsigned int cmd)
 	       cmd == SDXI_GET_AKEYS || cmd == SDXI_SET_AKEYS;
 }
 
+static bool sdxi_key_list_cmd(unsigned int cmd)
+{
+	return cmd == SDXI_GET_RKEY_LIST || cmd == SDXI_GET_AKEY_LIST;
+}
+
+static bool sdxi_key_entries_cmd(unsigned int cmd)
+{
+	return cmd == SDXI_GET_RKEYS || cmd == SDXI_SET_RKEYS ||
+	       cmd == SDXI_GET_AKEYS || cmd == SDXI_SET_AKEYS;
+}
+
+static u32 sdxi_key_table_entries(unsigned int cmd, struct sdxi_file *sf)
+{
+	if (cmd == SDXI_GET_RKEY_LIST || cmd == SDXI_GET_RKEYS ||
+	    cmd == SDXI_SET_RKEYS)
+		return sf->process->sdxi->rkey_entries;
+
+	if (!sf->cxt || !sf->cxt->akey_table)
+		return 0;
+	return ARRAY_SIZE(sf->cxt->akey_table->entry);
+}
+
+static int sdxi_key_ioctl_sizes(unsigned int cmd, struct sdxi_file *sf,
+				const void *header, size_t header_size,
+				size_t *copyin_size, size_t *copyout_size,
+				size_t *allocation_size)
+{
+	size_t payload_size;
+	u32 nentries;
+	u32 nkeys;
+
+	nentries = sdxi_key_table_entries(cmd, sf);
+
+	if (sdxi_key_list_cmd(cmd)) {
+		const struct sdxi_key_list_args *args = header;
+		size_t required = DIV_ROUND_UP(nentries, 8);
+
+		*copyin_size = header_size;
+		*copyout_size = header_size + min_t(size_t, args->buf_size,
+						    required);
+		*allocation_size = *copyout_size;
+		return 0;
+	}
+
+	if (cmd == SDXI_GET_RKEYS || cmd == SDXI_GET_AKEYS)
+		nkeys = ((const struct sdxi_get_keys_args *)header)->nkeys;
+	else
+		nkeys = ((const struct sdxi_set_keys_args *)header)->nkeys;
+
+	if (nkeys > min_t(u32, nentries, 4096))
+		return -EINVAL;
+	if (check_mul_overflow((size_t)nkeys, sizeof(struct sdxi_key_entry),
+			       &payload_size) ||
+	    check_add_overflow(header_size, payload_size, allocation_size))
+		return -EOVERFLOW;
+
+	*copyin_size = *allocation_size;
+	if (cmd == SDXI_GET_RKEYS || cmd == SDXI_GET_AKEYS)
+		*copyout_size = *allocation_size;
+	else
+		*copyout_size = header_size;
+	return 0;
+}
+
 static long sdxi_ioctl_live(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
 	const struct sdxi_ioctl_desc *desc;
 	struct sdxi_file *sf = file->private_data;
+	size_t copyout_size;
+	size_t copyin_size;
 	unsigned int canonical_size;
 	unsigned int user_size;
-	unsigned int size;
+	size_t size;
 	unsigned int nr;
 	char stack_data[128];
 	void *data = stack_data;
+	bool header_copied = false;
+	bool variable;
 	bool allowed;
 	int ret;
 
@@ -666,32 +734,69 @@ static long sdxi_ioctl_live(struct file *file, unsigned int cmd,
 
 	canonical_size = _IOC_SIZE(desc->cmd);
 	user_size = _IOC_SIZE(cmd);
-	size = max(canonical_size, user_size);
-	if (size > PAGE_SIZE)
+	copyin_size = (_IOC_DIR(cmd) & _IOC_WRITE) ? user_size : 0;
+	copyout_size = (_IOC_DIR(cmd) & _IOC_READ) ? user_size : 0;
+	size = max_t(size_t, canonical_size, user_size);
+
+	variable = sdxi_key_list_cmd(desc->cmd) ||
+		   sdxi_key_entries_cmd(desc->cmd);
+	if (variable) {
+		if (user_size < canonical_size)
+			return -EINVAL;
+		if (canonical_size > sizeof(stack_data))
+			return -E2BIG;
+		if (copy_from_user(stack_data, (void __user *)arg,
+				   canonical_size))
+			return -EFAULT;
+		header_copied = true;
+		ret = sdxi_key_ioctl_sizes(desc->cmd, sf, stack_data,
+					   canonical_size, &copyin_size,
+					   &copyout_size, &size);
+		if (ret)
+			return ret;
+	}
+
+	if (size > SZ_1M)
 		return -E2BIG;
 
 	if (size > sizeof(stack_data)) {
 		data = kzalloc(size, GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
-	} else {
+	} else if (!header_copied) {
 		memset(data, 0, size);
+	} else if (size > canonical_size) {
+		memset(data + canonical_size, 0, size - canonical_size);
 	}
 
-	if ((_IOC_DIR(cmd) & _IOC_WRITE) &&
-	    copy_from_user(data, (void __user *)arg, user_size)) {
-		ret = -EFAULT;
-		goto out;
+	if (_IOC_DIR(cmd) & _IOC_WRITE) {
+		if (header_copied) {
+			if (data != stack_data)
+				memcpy(data, stack_data, canonical_size);
+			if (copyin_size > canonical_size &&
+			    copy_from_user(data + canonical_size,
+					   (void __user *)(arg + canonical_size),
+					   copyin_size - canonical_size)) {
+				ret = -EFAULT;
+				goto out;
+			}
+		} else if (copy_from_user(data, (void __user *)arg,
+					  copyin_size)) {
+			ret = -EFAULT;
+			goto out;
+		}
 	}
 
 	ret = desc->func(file, sf, data);
 
+	if (ret == -ENOSPC && sdxi_key_list_cmd(desc->cmd))
+		copyout_size = canonical_size;
 	if ((_IOC_DIR(cmd) & _IOC_READ) && user_size > canonical_size &&
 	    !sdxi_ioctl_has_trailing_payload(desc->cmd))
 		memset((u8 *)data + canonical_size, 0,
 		       user_size - canonical_size);
 	if ((_IOC_DIR(cmd) & _IOC_READ) &&
-	    copy_to_user((void __user *)arg, data, user_size))
+	    copy_to_user((void __user *)arg, data, copyout_size))
 		ret = -EFAULT;
 
 out:
@@ -716,7 +821,7 @@ static long sdxi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
-static int sdxi_mmap(struct file *file, struct vm_area_struct *vma)
+static int sdxi_mmap_live(struct file *file, struct vm_area_struct *vma)
 {
 	struct sdxi_file *sf = file->private_data;
 	struct sdxi_cxt *cxt;
@@ -781,7 +886,24 @@ static int sdxi_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
-static __poll_t sdxi_cxt_poll(struct file *file, poll_table *wait)
+static int sdxi_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct sdxi_file *sf = file->private_data;
+	struct sdxi_dev *sdxi;
+	int ret;
+
+	if (!sf || !sf->process)
+		return -EINVAL;
+	sdxi = sf->process->sdxi;
+
+	if (!down_read_trylock(&sdxi->state_lock))
+		return -EAGAIN;
+	ret = sdxi->online ? sdxi_mmap_live(file, vma) : -ENODEV;
+	up_read(&sdxi->state_lock);
+	return ret;
+}
+
+static __poll_t sdxi_cxt_poll_live(struct file *file, poll_table *wait)
 {
 	struct sdxi_file *sf = file->private_data;
 	struct sdxi_cxt *cxt;
@@ -805,6 +927,23 @@ static __poll_t sdxi_cxt_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
+static __poll_t sdxi_cxt_poll(struct file *file, poll_table *wait)
+{
+	struct sdxi_file *sf = file->private_data;
+	struct sdxi_dev *sdxi;
+	__poll_t mask;
+
+	if (!sf || !sf->process)
+		return EPOLLERR | EPOLLHUP;
+	sdxi = sf->process->sdxi;
+
+	down_read(&sdxi->state_lock);
+	mask = sdxi->online ? sdxi_cxt_poll_live(file, wait) :
+			      EPOLLERR | EPOLLHUP;
+	up_read(&sdxi->state_lock);
+	return mask;
+}
+
 static int sdxi_open(struct inode *inode, struct file *file)
 {
 	struct sdxi_dev *sdxi;
-- 
2.56.1

