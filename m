Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6E390224;
	Fri, 28 Aug 2026 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936996; cv=fail; b=qE7oAf3sDM3X5CA2fWXW9esRiaVWv+7fsmkj5/cZdfiPduZfqQPpUXRC1X4M17713jtzRkR6JCiz0EqmxnXgC8Yky6mHD3EdFcyAC4F29lY7IRjYzRIkVuSqDf5gntozmTsQ2/P6ZUFk6qdwfst9wOcDnTH6o2AjN6exqg46q1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936996; c=relaxed/simple;
	bh=4OjD8cWyEVaY81CHdGfg8o+Jg/orKfLvuwnIyFai9TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTaRvAnRsQsmRoU0OoI0gck1+hie7nY9MxWE0ksMLZ2ENySS4KhLYwzM2SNxCUqujpXJ6bv2AFiJ8kh/OrRIBIJpkMZF7wtAh6HoqSYb9ji+WzaAe57e3rwLquooSXBc5lmUToKxpWP/bZQOPrLvv1t7hMozYPdcE2zQnQyzky8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BXmlGBzo; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BXmlGBzo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJb6eIAuy9lwhr+xvkzrU0Lt61VuiLYCDDeqqf+SPuVrFdKQZ/b94XsLXqygqvadGlD7IXoEaxr89y/jF/dIIwjAyRfPpK/zDzg1jrUoFwU4sW/9zSufuCe237MSH1ne/Am9E9j7x5og/7Ns4yeXtutSqWN6hTzD0L9hDQC8vz3B4JZ2DASt0N5kTWmgn8d1+Qhh5J0+WHBIrNwWVJPNKPpVXLArJfy1cJxZbEWvFn40uPt7aeVfDyiAV7duAlIjm2ZftcyhUx/2QTJZORhHByaxakLhSsnSDNiMmq/vh1m2w3L/nuUNLy70Rroea5AOylwz/VWD0deF40dYVLNE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5dJnge9eCXb8OPOQNyQvj07IXbo4EY7e0C8JjIYkjs=;
 b=JX98UC3a3wTg3OhvomFlZG/6luPpe8XnZuDxb+aeFXApOriqJ7LGrXYCrwo7EyavJ2Gf8KIK+3TmID/gUw+m/Srg6x6ZJNdGLDcJah4ooAl/6Cklu+wIZeW4ZeFSXZkNIk7j3Zemwsp3yvnfgYRl12lLxDBc1WjIlbKfg/ZLalqlR+P6vLVampXYNF5Kg5qynsPqE4ouGDDtSiJgZfGjOMUYiKXfCLmwetMONTVyNNYOp1Y9WIoOy3zj0Epn5nb2igTs7auEMqHLqfZQ4Ii4gngSAsIy6lYsODJJTv0GLE2qkDk1e4CR9srz2x7ovc1/n8cnacX8RFjALR8k0JPPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5dJnge9eCXb8OPOQNyQvj07IXbo4EY7e0C8JjIYkjs=;
 b=BXmlGBzouBY3PqD4BiDTs7dh4Qir3ETumSLnxNmCdJA+01iLKmjNjhJh2RdArxV4bOSWalCfl9oDu0o9LQPwxGDDNW8Nf1u2eSPcdyi9IZWNB2YUI1snPiFMDpiL/NtFiPzUq3BRw/Y1dTPN2WxA80PCi4LWRos3QE3vV3I7sA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7951.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:09:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:09:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 4/5] PCI: endpoint: pci-epf-vntb: Export endpoint DMA channels
Date: Sat, 29 Aug 2026 02:09:31 +0900
Message-ID: <20260828170932.2735807-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260828170932.2735807-1-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 15842fc9-0e8d-4d7b-a1ce-08df052726c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|7416014|1800799024|10067099003|6133799003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aJGYupU1JNqh6b4GDKU62fyaQf2Gvqz2fdSaFR2fIfwF6vzcGBgU/q8b5+px3YrbYGCmyl449Xtuy+LoT9HZfC6hCw3jpTbbUzayqHNhTUTt+k6wndZpt2+C5hHZkfw7wbINIh847vzOpplI4eXKX08JuHlmDoX2nfTBRdGh0FPuhFbVkaGsr5qmstrnuUOAAdQ+Az1ON1Rup84gSK0yO2xRTKVccAvJ6MffX0Ad6+QAxsf+oMWcUaXpkvq5dhgHMGs5TVJshBR+2rtRi3vx6lvxyGPAogARQeYESdFpxrms3J31yashPEOCqdI0HCgOeZaBaDXrWHftaECtM+ewc4Ho2qDu2d5nByMwTy3qbglXFybSoJfBvtaFcKp5UzM9oLzGiPsOp82z4kYl6NqyQld6G9KFpP513dBUsA//U5EJLM2+INLoXvFeON6AZEcFRwg5/qOwJWI0RuniLxfa+SuRL0OlWSo8FTQeHDkhXZljqISEG7ZWxZiRM+vievx9CRKAJk2CmaBuYaITQ1WCWPpvlOa6K59vdzjkxFgYf4XUMgi8z67vIyw5NfDtE/W99KvNjHo8KkWfnTOUGopwIbYFqOTPAIQEwmigDOmWZPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?372rkhfGViLwhXHgYkc0kOZZWHlZ8XOfacdKMT+Kbh0tWj2pKjhFWr8ni6e8?=
 =?us-ascii?Q?YmVN0frVyMOHVbbrJmOf4rDVTWLbZ8yBur7b2l4zwRfDToxiR1wTeG1O1A2v?=
 =?us-ascii?Q?60+FdO/e5VJRQgJVYLI7siiLzH4iTa4N48tAA7y3KdS7iw5m8XgrV3LIcQD/?=
 =?us-ascii?Q?UJFYiPTP7UqZxeas1pcluUtc5g9GB9oHNJ5CpgQD0oD6fRknZr03dWEvRwSQ?=
 =?us-ascii?Q?d8HbRCWPrxtzi0e2SEtR3N14/i+NcVOK+IKaJQSXLMlsLx7clSAtfPyz4RH9?=
 =?us-ascii?Q?peTrfBDrhAe6bE076tpdSTyDDqbczCziLETVYjHrwCbH4AIB1W1YjFTpv1uV?=
 =?us-ascii?Q?xpSbel4BmiJBCvMbf2vNyoh/uVYdxAmPmq7+ICXBlPME2qYPkWug49o9drJ9?=
 =?us-ascii?Q?Uasa9mMMTrB2g1cGFDgMiDeNMhxMzhddNa8KZKkK+seJKHYqt9GJtlNUrhiL?=
 =?us-ascii?Q?jTw0frir2AEQHCkFacrS6imQS5m+cSrA/ASJ6KM3y4wDBpvdQRFaJkhRkngy?=
 =?us-ascii?Q?Xb7l2rBIrE0alofqxovDW2kPMRbLDmwB3/7mH/8IC1qG+utxktl1de0B6+Hf?=
 =?us-ascii?Q?Edlic96OE/LRoPP9RuVmyUh2oSffqCQU3KrAehOyrL8xWqJgalsQ8w8wz8XO?=
 =?us-ascii?Q?Xr/vBwzQmOd/FkMjjIe+JVk4CoAyxjHnhk2umF10Tt9NS3U/S7YnRvoHfzIA?=
 =?us-ascii?Q?3dBn4XSoqsovJvxbeTmrfqPsaSWE++RMvcwclLOsb8ixwRF/zC/i6Tzo+HVz?=
 =?us-ascii?Q?of3PRJ+Tlm8QSIvW/g48KLlJgIkDbHbrJyIH0B7gS7vmpDvRPZCTh0tRWiSe?=
 =?us-ascii?Q?AkY4j8ESjGfqz1FSl+xloeHMkR4QuOXn360/BENBp4HURCZ+CicrHBXjGSQt?=
 =?us-ascii?Q?PQfVstVyRewBUmjVAqdYuvrQ6TNo+74HHR0VTKoq8vtHLpvTzKIFQfEQ1amh?=
 =?us-ascii?Q?iRB+szkHrypaWCdBtO9mDPIDolAtKIvfpItfPbTOQcbjCKHwVa1WC7Bhpwu5?=
 =?us-ascii?Q?goLKwyBD+Y+4TDYxoVILU5ulOqZGanx+HKijA4gCRqlt8Uj1TlzdqXfhqv6W?=
 =?us-ascii?Q?0rak/1k2Q4iLTDxaYiLBdfRv70e2os1T8XXG3WcvGnZrAeZexd+EzzZrDqOM?=
 =?us-ascii?Q?0KU1xvf9S+PIp+QJQHZnMMvJH1naKkvXnc3kaq23eDn77//Fbgr4ae62N6qx?=
 =?us-ascii?Q?eWXX2MmKPejA4cKYj1jokCU84Kx81gRoI7lsbXIYK3JEywy1o19WlgE5fsjv?=
 =?us-ascii?Q?TfNcEF8kBiJZ1K6U1vakRst4cqB3oyZWP8Kfrgf32tfKPfKsE1cAtg6ZRPst?=
 =?us-ascii?Q?iznBa6FK7X9wV27WREMOrptDTK1wru9xB7QwVISRouN/72UWOJWa7Qx8nqXu?=
 =?us-ascii?Q?JGvnLe+Fyh5Va0ooEffN7JDg0RpHsaV5Rc5YoqrngZCDBKYE7qWMrBQEt2Ru?=
 =?us-ascii?Q?EwZUvMh3Dw2RwBYtTuAGVTJQdxCyW95eZifWUxtZtv2qPSvtTm4h46QpNm+y?=
 =?us-ascii?Q?YGWwbI85gpZ69IYV3XDMajpJnG+CiR983knM26AZodzPst/74fs09hfLOIRE?=
 =?us-ascii?Q?1SD9E3vuO8FJvKYlzjLa3vloa6xoNXa97+6EzmjyU2iGlpMS8kn7lzeYvW/q?=
 =?us-ascii?Q?7DRrox7CnVNfdFXar+erCXFcdplNpK/FuUD1UCFyT3xS+yPsJcmAyQWDQ5z6?=
 =?us-ascii?Q?e3LixF+s+uG/R/uIU2x4eudv+4LTGPZXKCwh5LNLk87w3hMVwZDoOtYKYbIl?=
 =?us-ascii?Q?mYzN8ISarTkdNidAcsNxbEZPi1FMiIEC8LoWmEKX/TyyQ+eB0zHp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 15842fc9-0e8d-4d7b-a1ce-08df052726c9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:09:42.3122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJAXJ5BMU3rek6+0/zt30pqfxxw5HsMzHcU2dbVMlhxXxfgv3l8A/x/zs7nD00n/emOTJxmqiimxr8ynm/TagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7951

An RC may use endpoint-local DMA read channels to transfer data directly
to an endpoint DMA address once both sides agree to use them. Unrolled
eDMA has direction-wide control, so reserve the complete read direction
and route its interrupts to the RC when use_dma is enabled.

Describe the controller and per-channel descriptor memory in a private
control-region extension.

Two configfs attributes 'use_dma' and 'dma_bar' (corresponding to
BAR_DMA) are added. The DMA export remains disabled unless 'use_dma' is
explicitly set to 1.

Keep resources already assigned to a BAR in place, and map the rest
through 'dma_bar'. It uses an unused BAR by default, but can instead
follow an existing MW range. Control and doorbell BARs cannot be shared.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Completely rework v1 patches 8-10: drop the EPC delegation hooks and
    generic pci-ep-dma helper, and keep the export within pci-epf-vntb.
    https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/
  - Rework PCI DMA EPF v7 patch 9 into this implementation.
    https://lore.kernel.org/r/20260813063757.3131865-10-den@valinux.co.jp/
  - Keep BAR-backed channel descriptors in place instead of remapping them
    through dma_bar.
  - Reserve channels by static IDs and configure their interrupt routing
    through dma_slave_config. (Frank)
    https://lore.kernel.org/r/ao2nHoCwfTEEiFSr@SMW015318/

 Documentation/PCI/endpoint/pci-vntb-howto.rst |  23 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 660 +++++++++++++++++-
 2 files changed, 660 insertions(+), 23 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 3679f5c30254..90e0cdea9a1d 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -90,9 +90,9 @@ of the function device and is populated with the following NTB specific
 attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-	ctrl_bar  db_count  mw1_bar  mw2_bar  mw3_bar  mw4_bar	spad_count
-	db_bar	  mw1	    mw2      mw3      mw4      num_mws	vbus_number
-	vntb_vid  vntb_pid
+	ctrl_bar  dma_bar  mw2      mw3_bar  num_mws     vbus_number
+	db_bar    mw1      mw2_bar  mw4      spad_count  vntb_pid
+	db_count  mw1_bar  mw3      mw4_bar  use_dma     vntb_vid
 
 A sample configuration for NTB function is given below::
 
@@ -105,6 +105,23 @@ By default, each construct is assigned a BAR, as needed and in order.
 Should a specific BAR setup be required by the platform, BAR may be assigned
 to each construct using the related ``XYZ_bar`` entry.
 
+To export DMA channels, enable the feature before binding the function::
+
+	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/use_dma
+
+This currently supports the unrolled DesignWare eDMA layout. If any DMA
+resource has no fixed BAR assignment, the EPC must support subrange and
+dynamic inbound mappings.
+
+When ``use_dma`` is enabled, ``dma_bar`` selects the BAR used for such DMA
+resources. It defaults to an unused BAR.
+With a separate DMA BAR, an older ``ntb_hw_epf`` peer can ignore the extension
+and continue using legacy NTB. A peer that understands the extension treats the
+advertised DMA type as required and fails probe if its support is unavailable.
+Setting ``dma_bar`` to an MW BAR appends the DMA resources after the MW range.
+This requires an updated peer because older peers treat the whole BAR as an MW.
+The control and doorbell BARs cannot be shared.
+
 A sample configuration for virtual NTB driver for virtual PCI bus::
 
 	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index d12d134ce553..142799f64fe1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -39,8 +39,12 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dma/edma.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 
 #include <linux/pci-ep-msi.h>
@@ -56,6 +60,8 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define COMMAND_TEARDOWN_MW		4
 #define COMMAND_LINK_UP			5
 #define COMMAND_LINK_DOWN		6
+#define COMMAND_CONFIGURE_DMA		7
+#define COMMAND_TEARDOWN_DMA		8
 
 #define COMMAND_STATUS_OK		1
 #define COMMAND_STATUS_ERROR		2
@@ -69,6 +75,10 @@ static struct workqueue_struct *kpcintb_workqueue;
 #define MSIX_ENABLE			BIT(16)
 #define MAX_MW				4
 
+#define EPF_NTB_DMA_MAGIC		0x414d444e /* "NDMA": NTB DMA */
+#define EPF_NTB_DMA_REVISION		1
+#define EPF_NTB_DMA_TYPE_DW_EDMA	1
+
 /* Limit per-work execution to avoid monopolizing kworker on doorbell storms. */
 #define VNTB_PEER_DB_WORK_BUDGET	5
 
@@ -79,6 +89,7 @@ enum epf_ntb_bar {
 	BAR_MW2,
 	BAR_MW3,
 	BAR_MW4,
+	BAR_DMA,
 	VNTB_BAR_NUM,
 };
 
@@ -91,6 +102,30 @@ enum epf_irq_slot {
 #define MIN_DB_COUNT			(EPF_IRQ_DB_START + 1)
 #define MAX_DB_COUNT			32
 
+/* Private wire extension consumed by ntb_hw_epf. */
+struct epf_ntb_dma_region_ctrl {
+	u32 bar;
+	u32 offset;
+	u32 size;
+} __packed;
+
+struct epf_ntb_dma_chan_ctrl {
+	struct epf_ntb_dma_region_ctrl desc;
+	u32 desc_addr_lo;
+	u32 desc_addr_hi;
+} __packed;
+
+struct epf_ntb_dma_ctrl {
+	u32 magic;
+	u16 revision;
+	u16 length;
+	u32 type;
+	/* BAR range occupied by resources without a fixed BAR assignment. */
+	struct epf_ntb_dma_region_ctrl submap;
+	struct epf_ntb_dma_region_ctrl reg;
+	struct epf_ntb_dma_chan_ctrl chan[EDMA_MAX_RD_CH];
+} __packed;
+
 /*
  * +--------------------------------------------------+ Base
  * |                                                  |
@@ -129,8 +164,19 @@ struct epf_ntb_ctrl {
 	u32 db_entry_size;
 	u32 db_data[MAX_DB_COUNT];
 	u32 db_offset[MAX_DB_COUNT];
+	struct epf_ntb_dma_ctrl dma;
 } __packed;
 
+struct epf_ntb_dma {
+	struct mutex lock; /* Serialize DMA/MW BAR updates */
+	struct epf_ntb_dma_ctrl ctrl;
+	struct dma_chan *dchan[EDMA_MAX_RD_CH];
+	struct pci_epf_bar_submap submap[EDMA_MAX_RD_CH + 3];
+	struct pci_epf_bar_submap *reg_submap;
+	unsigned int num_submap;
+	u16 rd_ch_cnt;
+};
+
 struct epf_ntb {
 	struct ntb_dev ntb;
 	struct pci_epf *epf;
@@ -148,6 +194,7 @@ struct epf_ntb {
 	u16 vntb_vid;
 
 	bool linkup;
+	bool use_dma;
 
 	/*
 	 * True when doorbells are interrupt-driven (MSI or embedded), false
@@ -159,6 +206,7 @@ struct epf_ntb {
 	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
 
 	struct epf_ntb_ctrl *reg;
+	struct epf_ntb_dma *dma;
 
 	u32 *epf_db;
 
@@ -211,7 +259,8 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 {
 	int i;
 
-	for (i = 0; i < VNTB_BAR_NUM; i++) {
+	/* BAR_DMA is optional and may share an MW BAR. */
+	for (i = 0; i < BAR_DMA; i++) {
 		if (ntb->epf_ntb_bar[i] == barno)
 			return true;
 	}
@@ -219,6 +268,445 @@ static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
 	return false;
 }
 
+static u64 epf_ntb_dma_bar_offset(struct epf_ntb *ntb,
+				  enum pci_barno barno)
+{
+	unsigned int i;
+
+	for (i = 0; i < ntb->num_mws; i++)
+		if (ntb->epf_ntb_bar[BAR_MW1 + i] == barno)
+			return ntb->mws_size[i];
+
+	return 0;
+}
+
+static bool epf_ntb_dma_shares_bar(struct epf_ntb *ntb,
+				   enum pci_barno barno)
+{
+	return ntb->dma && ntb->dma->num_submap &&
+	       ntb->epf_ntb_bar[BAR_DMA] == barno;
+}
+
+static int
+epf_ntb_dma_resolve_bar(struct epf_ntb *ntb,
+			const struct pci_epc_features *features)
+{
+	enum pci_barno barno;
+
+	if (ntb->epf_ntb_bar[BAR_DMA] != NO_BAR) {
+		barno = ntb->epf_ntb_bar[BAR_DMA];
+		if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
+		    barno == ntb->epf_ntb_bar[BAR_DB])
+			return -EINVAL;
+		if (epf_ntb_dma_bar_offset(ntb, barno))
+			return 0;
+		if (epf_ntb_is_bar_used(ntb, barno) ||
+		    pci_epc_get_next_free_bar(features, barno) != barno)
+			return -EINVAL;
+		return 0;
+	}
+
+	barno = BAR_0;
+	while ((barno = pci_epc_get_next_free_bar(features, barno)) != NO_BAR) {
+		if (!epf_ntb_is_bar_used(ntb, barno)) {
+			ntb->epf_ntb_bar[BAR_DMA] = barno;
+			return 0;
+		}
+		barno++;
+	}
+
+	return -ENOENT;
+}
+
+struct epf_ntb_dma_filter {
+	struct device *dev;
+	int chan_id;
+};
+
+static bool epf_ntb_dma_filter(struct dma_chan *chan, void *data)
+{
+	struct epf_ntb_dma_filter *filter = data;
+
+	return chan->device->dev == filter->dev &&
+	       chan->chan_id == filter->chan_id;
+}
+
+static int epf_ntb_dma_add_region(struct epf_ntb_dma *dma,
+				  const struct pci_epc_aux_resource *resource,
+				  dma_addr_t target_addr,
+				  enum pci_barno barno, size_t align, u32 *next,
+				  struct epf_ntb_dma_region_ctrl *region,
+				  struct pci_epf_bar_submap **submap_out)
+{
+	struct pci_epf_bar_submap *submap;
+	resource_size_t delta, map_size, size;
+	dma_addr_t base;
+
+	if (!resource->size || resource->size > U32_MAX)
+		return -EINVAL;
+
+	region->size = resource->size;
+	if (resource->bar != NO_BAR) {
+		if (resource->bar < BAR_0 || resource->bar > BAR_5 ||
+		    resource->bar_offset > U32_MAX)
+			return -EINVAL;
+
+		region->bar = resource->bar;
+		region->offset = resource->bar_offset;
+		return 0;
+	}
+	submap = &dma->submap[dma->num_submap++];
+
+	base = ALIGN_DOWN(target_addr, align);
+	delta = target_addr - base;
+	if (check_add_overflow(delta, resource->size, &size))
+		return -EOVERFLOW;
+	map_size = ALIGN(size, align);
+	if (map_size < size)
+		return -EOVERFLOW;
+	if (map_size > U32_MAX - *next)
+		return -EOVERFLOW;
+
+	submap->phys_addr = base;
+	submap->size = map_size;
+	region->bar = barno;
+	region->offset = *next + delta;
+	*next += map_size;
+	if (submap_out)
+		*submap_out = submap;
+
+	return 0;
+}
+
+/* DW eDMA */
+
+static int epf_ntb_dw_edma_config_irq_mode(struct dma_chan *chan, enum dw_edma_ch_irq_mode mode)
+{
+	struct dma_slave_config config = {
+		.peripheral_config = &mode,
+		.peripheral_size = sizeof(mode),
+	};
+
+	return dmaengine_slave_config(chan, &config);
+}
+
+static int epf_ntb_dw_edma_claim(struct device *dev, int chan_id,
+				 struct dma_chan **dchan)
+{
+	struct epf_ntb_dma_filter filter = {
+		.dev = dev,
+		.chan_id = chan_id,
+	};
+	dma_cap_mask_t mask;
+	struct dma_chan *chan;
+	int ret;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	chan = dma_request_channel(mask, epf_ntb_dma_filter, &filter);
+	if (!chan)
+		return -EBUSY;
+
+	ret = epf_ntb_dw_edma_config_irq_mode(chan, DW_EDMA_CH_IRQ_REMOTE);
+	if (ret) {
+		dma_release_channel(chan);
+		return ret;
+	}
+
+	*dchan = chan;
+
+	return 0;
+}
+
+static void epf_ntb_dw_edma_release_channels(struct epf_ntb *ntb,
+					     struct epf_ntb_dma *dma,
+					     bool quiesce)
+{
+	unsigned int i;
+	int ret;
+
+	if (quiesce) {
+		/*
+		 * RC programming has stopped and this EPF owns the complete read
+		 * direction, so one termination quiesces the direction.
+		 */
+		ret = dmaengine_terminate_sync(dma->dchan[0]);
+		if (ret)
+			dev_warn(&ntb->epf->dev,
+				 "failed to terminate remote DMA: %d\n", ret);
+	}
+
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		if (!dma->dchan[i])
+			continue;
+
+		dma_release_channel(dma->dchan[i]);
+	}
+}
+
+static const struct pci_epc_aux_resource *
+epf_ntb_dw_edma_find_desc(const struct pci_epc_aux_resource *resources,
+			  unsigned int count, u16 chan_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++)
+		if (resources[i].type == PCI_EPC_AUX_DMA_DESC_MEM &&
+		    resources[i].u.dma_desc.chan_id == chan_id)
+			return &resources[i];
+
+	return NULL;
+}
+
+static int
+epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
+			const struct pci_epc_aux_resource *ctrl,
+			const struct pci_epc_aux_resource *resources,
+			unsigned int count)
+{
+	const struct pci_epc_features *features;
+	const struct pci_epc_aux_resource *desc[EDMA_MAX_RD_CH];
+	struct device *dma_dev;
+	bool needs_submap;
+	u64 offset;
+	unsigned int i;
+	size_t align;
+	u32 next = 0;
+	int ret;
+
+	if (ctrl->u.dma_ctrl.reg_layout_data != EDMA_MF_EDMA_UNROLL)
+		return -EOPNOTSUPP;
+	if (ctrl->u.dma_ctrl.ep_to_rc_ch_cnt > EDMA_MAX_WR_CH ||
+	    !ctrl->u.dma_ctrl.rc_to_ep_ch_cnt ||
+	    ctrl->u.dma_ctrl.rc_to_ep_ch_cnt > EDMA_MAX_RD_CH)
+		return -EINVAL;
+
+	struct epf_ntb_dma *dma __free(kfree) =
+		kzalloc(sizeof(*dma), GFP_KERNEL);
+	if (!dma)
+		return -ENOMEM;
+
+	mutex_init(&dma->lock);
+	dma->rd_ch_cnt = ctrl->u.dma_ctrl.rc_to_ep_ch_cnt;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	if (!features)
+		return -EOPNOTSUPP;
+
+	align = features->align ?: 1;
+	if (!is_power_of_2(align))
+		return -EINVAL;
+
+	needs_submap = ctrl->bar == NO_BAR;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+
+		desc[i] = epf_ntb_dw_edma_find_desc(resources, count, chan_id);
+		if (!desc[i])
+			return -EINVAL;
+		needs_submap |= desc[i]->bar == NO_BAR;
+	}
+	if (needs_submap) {
+		if (!features->subrange_mapping ||
+		    !features->dynamic_inbound_mapping)
+			return -EOPNOTSUPP;
+		ret = epf_ntb_dma_resolve_bar(ntb, features);
+		if (ret)
+			return ret;
+
+		offset = epf_ntb_dma_bar_offset(ntb,
+						ntb->epf_ntb_bar[BAR_DMA]);
+		if (offset > U32_MAX)
+			return -EOVERFLOW;
+		dma->ctrl.submap.offset = offset;
+		next = offset;
+		if (next) {
+			dma->submap[0].size = next;
+			dma->num_submap = 1;
+		}
+	}
+
+	dma->ctrl.magic = EPF_NTB_DMA_MAGIC;
+	dma->ctrl.revision = EPF_NTB_DMA_REVISION;
+	dma->ctrl.type = EPF_NTB_DMA_TYPE_DW_EDMA;
+	dma->ctrl.submap.bar = U32_MAX;
+	dma->ctrl.length = offsetof(struct epf_ntb_dma_ctrl,
+				    chan[dma->rd_ch_cnt]);
+
+	ret = epf_ntb_dma_add_region(dma, ctrl, ctrl->phys_addr,
+				     ntb->epf_ntb_bar[BAR_DMA],
+				     align, &next, &dma->ctrl.reg,
+				     &dma->reg_submap);
+	if (ret)
+		return ret;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		struct epf_ntb_dma_chan_ctrl *chan = &dma->ctrl.chan[i];
+		dma_addr_t dma_addr = desc[i]->u.dma_desc.dma_addr;
+
+		ret = epf_ntb_dma_add_region(dma, desc[i], dma_addr,
+					     ntb->epf_ntb_bar[BAR_DMA],
+					     align, &next,
+					     &chan->desc, NULL);
+		if (ret)
+			return ret;
+		chan->desc_addr_lo = lower_32_bits(dma_addr);
+		chan->desc_addr_hi = upper_32_bits(dma_addr);
+	}
+	if (dma->num_submap) {
+		dma->ctrl.submap.bar = ntb->epf_ntb_bar[BAR_DMA];
+		dma->ctrl.submap.size = next - dma->ctrl.submap.offset;
+	}
+
+	dma_dev = ntb->epf->epc->dev.parent;
+	for (i = 0; i < dma->rd_ch_cnt; i++) {
+		u16 chan_id = ctrl->u.dma_ctrl.ep_to_rc_ch_cnt + i;
+
+		ret = epf_ntb_dw_edma_claim(dma_dev, chan_id, &dma->dchan[i]);
+		if (ret)
+			goto err_release;
+	}
+
+	if (dma->reg_submap) {
+		dma->reg_submap->phys_addr =
+			dma_map_resource(dma_dev, dma->reg_submap->phys_addr,
+					 dma->reg_submap->size,
+					 DMA_BIDIRECTIONAL, 0);
+		if (dma_mapping_error(dma_dev, dma->reg_submap->phys_addr)) {
+			ret = -EIO;
+			goto err_release;
+		}
+	}
+
+	ntb->dma = no_free_ptr(dma);
+	return 0;
+
+err_release:
+	epf_ntb_dw_edma_release_channels(ntb, dma, false);
+	return ret;
+}
+
+/* Common endpoint DMA */
+
+static int epf_ntb_dma_collect(struct epf_ntb *ntb)
+{
+	const struct pci_epc_aux_resource *ctrl = NULL;
+	unsigned int i;
+	int count, ret;
+
+	if (!ntb->use_dma)
+		return 0;
+
+	count = pci_epc_get_aux_resources_count(ntb->epf->epc,
+						ntb->epf->func_no,
+						ntb->epf->vfunc_no);
+	if (count <= 0)
+		return count ?: -ENODEV;
+
+	struct pci_epc_aux_resource *resources __free(kfree) =
+		kcalloc(count, sizeof(*resources), GFP_KERNEL);
+	if (!resources)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no, resources, count);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		if (resources[i].type != PCI_EPC_AUX_DMA_CTRL_MMIO)
+			continue;
+		if (ctrl)
+			return -EINVAL;
+		ctrl = &resources[i];
+	}
+	if (!ctrl)
+		return -ENODEV;
+
+	switch (ctrl->u.dma_ctrl.reg_layout) {
+	case PCI_EPC_AUX_DMA_REG_LAYOUT_DW_EDMA:
+		return epf_ntb_dw_edma_collect(ntb, ctrl, resources, count);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void epf_ntb_dma_release(struct epf_ntb *ntb, bool quiesce)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct device *dev;
+
+	if (!dma)
+		return;
+
+	switch (dma->ctrl.type) {
+	case EPF_NTB_DMA_TYPE_DW_EDMA:
+		epf_ntb_dw_edma_release_channels(ntb, dma, quiesce);
+		break;
+	}
+	dev = ntb->epf->epc->dev.parent;
+	if (dma->reg_submap)
+		dma_unmap_resource(dev, dma->reg_submap->phys_addr,
+				   dma->reg_submap->size, DMA_BIDIRECTIONAL, 0);
+	kfree(dma);
+	ntb->dma = NULL;
+}
+
+static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, dma_addr_t addr,
+				      bool submapped)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	dma_addr_t old_addr;
+	bool old_submapped;
+	int restore, ret;
+
+	lockdep_assert_held(&dma->lock);
+
+	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+	old_submapped = bar->num_submap;
+	if (dma->ctrl.submap.offset) {
+		old_addr = dma->submap[0].phys_addr;
+		dma->submap[0].phys_addr = addr;
+	}
+	bar->submap = submapped ? dma->submap : NULL;
+	bar->num_submap = submapped ? dma->num_submap : 0;
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, bar);
+	if (!ret)
+		return 0;
+
+	if (dma->ctrl.submap.offset)
+		dma->submap[0].phys_addr = old_addr;
+	bar->submap = old_submapped ? dma->submap : NULL;
+	bar->num_submap = old_submapped ? dma->num_submap : 0;
+	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+				  ntb->epf->vfunc_no, bar);
+	if (restore)
+		dev_warn(&ntb->epf->dev,
+			 "failed to restore DMA/MW BAR mapping: %d\n", restore);
+
+	return ret;
+}
+
+static int epf_ntb_dma_set_active(struct epf_ntb *ntb, bool active)
+{
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+
+	if (!dma || !dma->num_submap)
+		return 0;
+
+	guard(mutex)(&dma->lock);
+
+	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
+	if (!!bar->num_submap == active)
+		return 0;
+
+	return epf_ntb_dma_set_bar_locked(ntb, bar->phys_addr, active);
+}
+
 /**
  * epf_ntb_configure_mw() - Configure the Outbound Address Space for VHOST
  *   to access the memory window of HOST
@@ -339,6 +827,14 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
 		epf_ntb_teardown_mw(ntb, argument);
 		ctrl->command_status = COMMAND_STATUS_OK;
 		break;
+	case COMMAND_CONFIGURE_DMA:
+		ret = epf_ntb_dma_set_active(ntb, true);
+		ctrl->command_status = ret ? COMMAND_STATUS_ERROR : COMMAND_STATUS_OK;
+		break;
+	case COMMAND_TEARDOWN_DMA:
+		ret = epf_ntb_dma_set_active(ntb, false);
+		ctrl->command_status = ret ? COMMAND_STATUS_ERROR : COMMAND_STATUS_OK;
+		break;
 	case COMMAND_LINK_UP:
 		ntb->linkup = true;
 		ret = epf_ntb_link_up(ntb, true);
@@ -459,9 +955,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  *   region
  * @ntb: NTB device that facilitates communication between HOST and VHOST
  *
- * Allocate the Local Memory mentioned in the above diagram. The size of
- * CONFIG REGION is sizeof(struct epf_ntb_ctrl) and size of SCRATCHPAD REGION
- * is obtained from "spad-count" configfs entry.
+ * Allocate the control and scratchpad regions, omitting the optional DMA
+ * extension when no channels are exported.
  *
  * Returns: Zero for success, or an error code in case of failure
  */
@@ -481,7 +976,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
 	spad_count = ntb->spad_count;
 
-	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
+	ctrl_size = ntb->dma ? sizeof(struct epf_ntb_ctrl) :
+			       offsetof(struct epf_ntb_ctrl, dma);
+	ctrl_size = ALIGN(ctrl_size, sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
 	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
@@ -507,6 +1004,9 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 		ntb->reg->db_offset[i] = 0;
 	}
 
+	if (ntb->dma)
+		ctrl->dma = ntb->dma->ctrl;
+
 	return 0;
 }
 
@@ -738,6 +1238,46 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
 
+static int epf_ntb_dma_bar_init(struct epf_ntb *ntb)
+{
+	const struct pci_epc_features *features;
+	struct epf_ntb_dma *dma = ntb->dma;
+	struct pci_epf_bar *bar;
+	enum pci_barno barno;
+	u32 mapped_size;
+	int ret;
+
+	features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no,
+					ntb->epf->vfunc_no);
+	if (!features)
+		return -EOPNOTSUPP;
+
+	barno = ntb->epf_ntb_bar[BAR_DMA];
+	mapped_size = dma->ctrl.submap.offset + dma->ctrl.submap.size;
+	if (!pci_epf_alloc_space(ntb->epf, mapped_size, barno, features,
+				 PRIMARY_INTERFACE))
+		return -ENOMEM;
+
+	bar = &ntb->epf->bar[barno];
+	if (bar->size > U32_MAX)
+		return -EOVERFLOW;
+
+	if (dma->ctrl.submap.offset)
+		dma->submap[0].phys_addr = bar->phys_addr;
+	if (mapped_size < bar->size)
+		dma->submap[dma->num_submap++] = (struct pci_epf_bar_submap) {
+			.phys_addr = bar->phys_addr + mapped_size,
+			.size = bar->size - mapped_size,
+		};
+
+	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
+			      ntb->epf->vfunc_no, bar);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /**
  * epf_ntb_db_bar_clear() - Clear doorbell BAR and free memory
  *   allocated in peer's outbound address space
@@ -776,16 +1316,27 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	struct device *dev = &ntb->epf->dev;
+	bool dma_bar_set = false;
+	enum pci_barno barno;
+	u64 size;
 	int ret = 0;
 	int i;
-	u64 size;
-	enum pci_barno barno;
-	struct device *dev = &ntb->epf->dev;
 
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
 
+		if (epf_ntb_dma_shares_bar(ntb, barno)) {
+			ret = epf_ntb_dma_bar_init(ntb);
+			if (ret) {
+				dev_err(dev, "DMA/MW BAR set failed\n");
+				goto err_alloc_mem;
+			}
+			dma_bar_set = true;
+			goto alloc_vpci_mw;
+		}
+
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
 		ntb->epf->bar[barno].addr = NULL;
@@ -803,6 +1354,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 			goto err_alloc_mem;
 		}
 
+alloc_vpci_mw:
 		/* Allocate EPC outbound memory windows to vpci vntb device */
 		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
 							      &ntb->vpci_mw_phy[i],
@@ -810,17 +1362,20 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 		if (!ntb->vpci_mw_addr[i]) {
 			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
-			goto err_set_bar;
+			i++;
+			goto err_alloc_mem;
+		}
+	}
+	if (ntb->dma && ntb->dma->num_submap && !dma_bar_set) {
+		ret = epf_ntb_dma_bar_init(ntb);
+		if (ret) {
+			dev_err(dev, "DMA BAR set failed\n");
+			goto err_alloc_mem;
 		}
 	}
 
-	return ret;
+	return 0;
 
-err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
 err_alloc_mem:
 	epf_ntb_mw_bar_clear(ntb, i);
 	return ret;
@@ -833,20 +1388,43 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
+	bool bar_cleared[BAR_5 + 1] = {};
 	enum pci_barno barno;
 	int i;
 
 	for (i = 0; i < num_mws; i++) {
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
-		pci_epc_clear_bar(ntb->epf->epc,
-				  ntb->epf->func_no,
-				  ntb->epf->vfunc_no,
-				  &ntb->epf->bar[barno]);
+		if (!bar_cleared[barno]) {
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
+			bar_cleared[barno] = true;
+		}
+
+		if (!ntb->vpci_mw_addr[i])
+			continue;
 
 		pci_epc_mem_free_addr(ntb->epf->epc,
 				      ntb->vpci_mw_phy[i],
 				      ntb->vpci_mw_addr[i],
 				      ntb->mws_size[i]);
+		ntb->vpci_mw_addr[i] = NULL;
+	}
+
+	if (ntb->dma && ntb->dma->num_submap) {
+		barno = ntb->epf_ntb_bar[BAR_DMA];
+		if (!ntb->epf->bar[barno].addr)
+			return;
+
+		ntb->epf->bar[barno].submap = NULL;
+		ntb->epf->bar[barno].num_submap = 0;
+		if (!bar_cleared[barno])
+			pci_epc_clear_bar(ntb->epf->epc, ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
+		pci_epf_free_space(ntb->epf, ntb->epf->bar[barno].addr, barno,
+				   PRIMARY_INTERFACE);
 	}
 }
 
@@ -877,7 +1455,8 @@ static int epf_ntb_find_bar(struct epf_ntb *ntb,
 		 * Verify if the BAR found is not already assigned
 		 * through the provided configuration
 		 */
-		if (!epf_ntb_is_bar_used(ntb, barno))
+		if ((!ntb->use_dma || ntb->epf_ntb_bar[BAR_DMA] != barno) &&
+		    !epf_ntb_is_bar_used(ntb, barno))
 			ntb->epf_ntb_bar[bar] = barno;
 
 		barno += 1;
@@ -1191,10 +1770,28 @@ static ssize_t epf_ntb_db_count_store(struct config_item *item,
 	return len;
 }
 
+static ssize_t epf_ntb_use_dma_store(struct config_item *item,
+				     const char *page, size_t len)
+{
+	struct config_group *group = to_config_group(item);
+	struct epf_ntb *ntb = to_epf_ntb(group);
+	int ret;
+
+	if (epf_ntb_epc_attached(ntb))
+		return -EOPNOTSUPP;
+
+	ret = kstrtobool(page, &ntb->use_dma);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
 EPF_NTB_R(spad_count)
 EPF_NTB_W(spad_count)
 EPF_NTB_R(db_count)
 EPF_NTB_R(num_mws)
+EPF_NTB_R(use_dma)
 EPF_NTB_R(vbus_number)
 EPF_NTB_W(vbus_number)
 EPF_NTB_R(vntb_pid)
@@ -1221,10 +1818,14 @@ EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
 EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
+EPF_NTB_BAR_R(dma_bar, BAR_DMA)
+EPF_NTB_BAR_W(dma_bar, BAR_DMA)
 
 CONFIGFS_ATTR(epf_ntb_, spad_count);
 CONFIGFS_ATTR(epf_ntb_, db_count);
 CONFIGFS_ATTR(epf_ntb_, num_mws);
+CONFIGFS_ATTR(epf_ntb_, use_dma);
+CONFIGFS_ATTR(epf_ntb_, dma_bar);
 CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
@@ -1243,6 +1844,8 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_spad_count,
 	&epf_ntb_attr_db_count,
 	&epf_ntb_attr_num_mws,
+	&epf_ntb_attr_use_dma,
+	&epf_ntb_attr_dma_bar,
 	&epf_ntb_attr_mw1,
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
@@ -1423,6 +2026,15 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	dev = &ntb->ntb.dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
+	if (epf_ntb_dma_shares_bar(ntb, barno)) {
+		if (size != ntb->mws_size[idx])
+			return -EINVAL;
+
+		guard(mutex)(&ntb->dma->lock);
+
+		return epf_ntb_dma_set_bar_locked(ntb, addr, true);
+	}
+
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
@@ -1743,6 +2355,12 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		return ret;
 	}
 
+	ret = epf_ntb_dma_collect(ntb);
+	if (ret) {
+		dev_err(dev, "Failed to prepare NTB DMA export\n");
+		return ret;
+	}
+
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to allocate BAR memory\n");
@@ -1779,6 +2397,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	epf_ntb_epc_cleanup(ntb);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb, false);
 
 	return ret;
 }
@@ -1795,6 +2414,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
+	epf_ntb_dma_release(ntb, true);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }
-- 
2.51.0

