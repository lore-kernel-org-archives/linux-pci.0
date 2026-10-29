Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285873;
	b=Mw72iivG2y7mMvKEU/cV18YKK8ky7mdWDQ7oWoq4EI7TEogLzrihKY7zNpXzodvjrkio
	 raZ0YULXwd83b8YFM1WpatMWZwD6o7WTWk+yvU/g8K1fqBVIDJ+MisKeW6AwOW+b/fWPg
	 GDNMHPNGd7rSoxhzgnfdWBgQY4Sc3SrxgO+hw5CgHj7UdSqQnp+zbCWiBQGLQ7mF8hFbN
	 neio1wAl1xjueYORgPnBYuYHxTWDNJjcooTYz3z1069TvIOJQCMyKEE2nv9XqiTV2py2h
	 TkF+d0e1sxGoCQF8oWYfwdiRUThabgUMjA90ohXPzjWekQ6lNL0idbN+lAbrD+4W+Vg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285873;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TLm1L6t/D+2n5NFKuuliyfb/Mgu2tvjLXe9IO6JmKI8=;
	b=YkwyUx98p8jrR2KZC9D9j2Ss5TsfmTf/eHlwxEr0qE83KG1uG0N/NZ8NpY1lTKcUxkNF
	 jUhn2lojK/NTO0shEsB4/0gdLmre7+e6IJ3qq2Y7iAqjKAZoShhqOeDFKh07H2EmND+Am
	 trPIKmCFJn9Le4uS8naDdT9ASTNlC4qdwBt8PYEfXlkTsOg2AWxSfNz4APUxF5nIFKhBw
	 As7kMyUl8l+FBC9smq+27gpkCtFH28sjR1vigvqKuF+oHbAEA70FOXGUDY5fKcFOBbiSn
	 i0uZowG8QuTJk8V5aeLUHIWBaIj4xA0ofPyIXm+7sKtrW5n4Y4VAfjrtAd6aIBeIzRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=egQaqsiz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.40
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288760A262F;
	Thu, 29 Oct 2026 14:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E288760A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=egQaqsiz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IExhMUsV2jkVznDzSgzKOWP7EcVCJIy0G3am4EFJAGT37b7lLboKt8DLzIUn/8PVlQGLDdAFhN08mmbiHSmWNh7+MUkme6EzWD2L+TxIG3JTqBO6JiKQqz2J2Zlp4yY0iUV2ryb1kviqVcM6WGeWCR43dRStHSNApYvpAZ10nKVEfb5Jvva8yeUYuFkPajwhfpOHBLbc3SKC8JhdS4K5dga8NgUM1zS+n96Yl13iCS7913to/5atmJ+X7EMEtKbGSNF7Merxa18N4Cf2oYQlGuO8Mqu62r/R4fMSi0YHY7zWhePk7G26OAjB+z0aPgqhCH2kFbiKGtlGKR6RASZnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLm1L6t/D+2n5NFKuuliyfb/Mgu2tvjLXe9IO6JmKI8=;
 b=AI+XRv7D/ANE5RkYECLL8C11LM12AabbEOVYbp6d5Kw6/aiKVwLqoTZQwTFbrRjoSZKLcEqPzCEKrsXGfbH/ZFNw2eYSiHA4gCH5KDIxKj7q0csRyWVGDLn1FQiOYD+Tl5skXewX+WTCXvziMJsb9Fzs462abwQgTy7R1GEAl/U7FOk5i6rnQsr5tQSizYg/7hthf7l8LHQqaHF6AKVQaVi59Dty/e8ukBmCnlae8997uLDoDGVJw+h2tsNt5DL8gIM0AvxYWiX4j3EijdoNnNPFZGk+Ul8GaseSP1n8Dflcuf0fi0TugPVdyZvce6QmYvI1Cn2VfLvy9QtgXh1LGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLm1L6t/D+2n5NFKuuliyfb/Mgu2tvjLXe9IO6JmKI8=;
 b=egQaqsizopHSmTPARyWq0rpiH8T4oUgsb9i7HzPiKV2qdUlf8gJisubx+iMPYrcn0UEliTA84GTIaZIlJxvWNSNXB/O6zSQmd0cw+ynyM3Pqb5k4yLgMKe9d7XLaxPukSE4iPCX34tcNNV67RFgTVZtLEdJ8GVEv1p2m+g5onrub0IibTSdRzAVDD5xH4XzCgW/HYeol75MZj8jh6WgeyrMJ4YztYZ9HnbbLWzZ1v1dVBpheuUesncPqb8xBrPHdtgzvKNIwPG+ZSAItBUd8Epa3aAFpVHjEe8jKfPlZ/PRXANwOKF3rVHieC0yiwfd9C0IouPrx53rDdunNedgV9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by PH0PR12MB7792.namprd12.prod.outlook.com
 (2603:10b6:510:281::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 14:57:46 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 14:57:45 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v16 12/18] PCI/CXL: Add CXL Device Reset sequencing
Date: Thu, 29 Oct 2026 14:56:57 +0000
Message-ID: <20261029145703.2185231-13-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029145703.2185231-1-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:510:23d::11) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: feb0ed7b-5817-49ca-9f3d-08df35ccfd6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|921020|11063799006|5023799004|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|10067099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	a+kJ7hIMZqP3FKC9PsDWHj0zuTf0QWs2cYXnuUey/e5qXFyV0khNr5XMThBRNLoqyFft73pnzNmfbCmZ45jnG3fRCzZvFXdT2Imt7d7d1KRCJdl6IIymENpVaO1BJh8dWJBSCMpjK/+O7iWzvSG7Uc+pI5Jm6Al/omYqugq7L0BlbA4wagWOzLkEt76q7YGEdyXUcgwzXvudkc16njtExZKVJgnsnU8AtKwMUHL8ZOfLtL0RFqyWqTeEd3o7QkgzAIfDFgEZI4hpA8rV2ofHdVsa5tQZpK7icdzMKhlbQp9UlXSFO34g9rxcBjNf69VDjDGVVc4h7Q1JRN2xeyCCBKCGbG+aeoYOE1zVuENvQ28Hg26cUlBiFUSB5fIjBH12RhRWvmawpYm3eVoU6ZGuxHxqxb0MLcntcHddY4Pvdt8c8J4nEBEZ5dWgy9cqee7047eQzslqNfyFmexJmvs33eihDAKpvF5VTssqsuas5FeeVWx0WWiRmYaHeBaeDGQWqQB4p8/b9IULZ7LGzzkQNOtI3RiIDTDH9smbYkdVZxubkgULMqRNl19mz9nWUF8IRXfh4Obe6W0lBPSjHi6PmgXZFGZVRLHUGxMqnor49f6wJx1BNEc+1leAUqY3OCaggkJcdhJgfA6xA+oNQlMMeMNxvVtDOurifZbZVkH9I+vt9CvkXnjXxE2n2VqQU88chvgB0nB5Wck5OB4s787Cmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(921020)(11063799006)(5023799004)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBJIKso5MKebe2lFVTLkpiwWmlEa93HFLbT4KTekZUbBq0X9mdnv1OP2Ibj7?=
 =?us-ascii?Q?vrtNuZwjgGDGkCZx+rt7vzvvtFbA1pYS5PYJBcDcrsY4hCBC2OO6Z1lSDDS1?=
 =?us-ascii?Q?Ap7Yt9xkyaMo1vBtulGgoKgK7JIuTGunfqsY1Q/WPGnuK8qFKJkvl7LPe9RY?=
 =?us-ascii?Q?XABtL5EmLOCwALctAWOBbHQ47mC2ymkg5S7OzbUnsHlSc+6TyTwK4aDnH5ns?=
 =?us-ascii?Q?ff1235XDmwAJvHCvmJD5PE9UnfTv9Gc666PRPhUiwlax0X3dNhN3jq1nYMPA?=
 =?us-ascii?Q?s5SAHOBUj899h1G/vlc+ahzLO4jGKp/mZxOAyvvAKt+cTcfJzJ9dKk5ISqsl?=
 =?us-ascii?Q?bYgzBos64sNgccC4Gn//oBkuNm/FX9geo8ho6rPdpBnIjcqwXpyuD+nLfPbP?=
 =?us-ascii?Q?2R9Ui3JnvcOgl/7W1ao9Mi0ZAXvipkRGuRltWe6vTQF1xN+nOJ6t2aNtwc/J?=
 =?us-ascii?Q?enaaMfuaWlDZfVfrDWnI8X/AEtFz/55zFv4By+QiO+vuiv2x8HzpMxgpneeP?=
 =?us-ascii?Q?oMIAg6Wa3IBoITQRj/dbEP0gsot1ldZd9KB0ZQyyR/qj4UxD2rSbMOzNeCPV?=
 =?us-ascii?Q?RauVvj2BTbcGzg0uBHrZnsgSXg3nTiDBRj0bUKjyeMvWoOJYhcXM7Wra6f2j?=
 =?us-ascii?Q?LhyWmXjkCy4CeaB8XRToROB3IM8wCVO/cXVdlQpSG4D6lol6Pb0Y0fa6zPRR?=
 =?us-ascii?Q?VNhuqXMqFsuMJz5ZZ1JPEjUiCPtssT/7AR6r1xB6BOnCbBfq8hEbnGE+i7iM?=
 =?us-ascii?Q?ukfpI/w+0Abt0yiyNDpzyr9rGJ/kC/KdTXfAQFRjNC1fLmCb8JQ8LTxL9kGq?=
 =?us-ascii?Q?OQtH72OdUMHp2bpD6Fob+ay8NVAv1mUsZo0rcFhXgh4PNejq/Tj5Ny12rGrU?=
 =?us-ascii?Q?MadFuzwFZinXOzdxl0cqbpl/ezNdeX5zdHaAYcOAIwrV9x76lroEWVRyj/4P?=
 =?us-ascii?Q?8+FU/prbWEoY1SGZRAzBln4dnjGFVu6GJ+nV1wG4s9Pem3TQI9bd2Ja+fygI?=
 =?us-ascii?Q?vjtR9YNmDqHPLcbK2On/jtc4a+4KZ9RrkZUvJ+ez9I+T86fCv4oHnTrnUQYO?=
 =?us-ascii?Q?w2qB+4/GJTWriJ1a5nS/991XjC4qHfvWvTNQB55ZUSk94cS43VqTg0+WnJ9j?=
 =?us-ascii?Q?xdksz1Cvl+QpFTeEs+cf/LuonGkHZNbVbp5s/84YhQwE4PZrCHBjBqBXAvRy?=
 =?us-ascii?Q?aOJ7I+5BfEMDqNPQd2fybadKVZDOiTXl8z0J/6lJlq3HeMx5sYsWUBrp7k4f?=
 =?us-ascii?Q?hi1dBNjKkbW3aWkjzwIjnc1oI269M0eDiyFvo68JVSwn0b4vNaDzJAL1YB9o?=
 =?us-ascii?Q?rHWcJyxoDsg4ZErrG2az3+zgfgyG0UcBKTnmFX34no7NnLDGizwuhVix57tZ?=
 =?us-ascii?Q?Gj8KmdZ9wMrYXIvI88VIddNzArsaseJoDSPqSiVVWPzA+Jqqg+fbIjj3prB1?=
 =?us-ascii?Q?BhCfQETr6JH3m/pw+IkKrnOaGa/G5VxfQItaKzpiu2/8yTeyLDKVOocX13eH?=
 =?us-ascii?Q?M/VJ3hziCKmuKbhq3gdH9tsvGQkwAw46HQwWK5+PLmeBBQFFudvV8pXCkyPV?=
 =?us-ascii?Q?x8/xkoe4WRU97TmVwfyH9NpFe0hSZ/11UUVPyYhdAeo6zt//gtqDjxq9yOvv?=
 =?us-ascii?Q?Mdf1IskWmCq+4LFdczlGiIPFCAeb2GNPbkpZHtpPtbChCd3MwumIuMj7pK/5?=
 =?us-ascii?Q?lNvgENfivQSaPvKXjMNzc5HLeZLCxUQz3oBkz18ZmH1Jn77uz8ERtQvh2wQR?=
 =?us-ascii?Q?o0Jv0lnYlA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb0ed7b-5817-49ca-9f3d-08df35ccfd6f
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 14:57:45.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmKE2GSGENlwsizumzy3pDbe6XEISYh0wOxc/IOw3nhjLrNu625d5JgFRRQI0o5q7HEHucDXO0Rg718qlmxR3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
perform supported writeback, drain transactions, prepare the IOMMU,
initiate reset with Memory Clear enabled, and wait for completion.

Observe the 100 ms post-reset quiet period before polling Status2, and
treat an all-ones read as not ready. Treat Control2 command bits as
transient state, restore cache policy on exit, preserve the primary error,
and abort when IOMMU preparation fails.

Reuse Device DVSEC discovery from cache initialization and keep the
reset entry point declaration private to PCI core.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

---
Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=04f8f84816d724f8b47f4d47a77916ac37c63a49
---
 drivers/pci/cxl.c             | 245 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h             |   5 +
 include/uapi/linux/pci_regs.h |  12 ++
 3 files changed, 261 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
index b992f71d964a..bfc31f821d01 100644
--- a/drivers/pci/cxl.c
+++ b/drivers/pci/cxl.c
@@ -3,13 +3,17 @@
 /*
  * CXL reset support in the PCI core. Cache the HDM decoder state of a CXL
  * memory device at enumeration, so it can be restored after a reset without
- * a CXL driver. HDM register formats and programming live in drivers/cxl.
+ * a CXL driver, and implement CXL Device Reset. HDM register formats and
+ * programming live in drivers/cxl.
  */
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/iommu.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -219,3 +223,242 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
 {
 	cxl_hdm_cache_release(&pdev->hdm);
 }
+
+/*
+ * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
+ * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
+ * initiating CXL Reset, then limits software to CXL Status2 access until
+ * reset completion, timeout, or error.
+ */
+#define CXL_RESET_RRS_WAIT_MS 100
+#define CXL_RESET_STATUS_POLL_MS 20
+#define CXL_RESET_MAX_WAIT_MS 20000
+static const u32 cxl_reset_timeout_ms[] = {
+	10, 100, 1000, 10000, 100000,
+};
+
+/*
+ * CXL 4.0 section 9.6 permits using the device cache size to determine
+ * a timeout. Use a conservative fixed estimate of 100 ms.
+ */
+#define CXL_CACHE_WBI_TIMEOUT_US 100000
+#define CXL_CACHE_WBI_POLL_US 100
+
+#define CXL_RESET_CTRL2_CMD_MASK \
+	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
+
+static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec,
+				  u16 set, u16 clear)
+{
+	u16 ctrl2;
+	int rc;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl2))
+		return -ENODEV;
+
+	/*
+	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
+	 * that remains set in the value read back while updating persistent
+	 * Control2 state.
+	 */
+	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
+	ctrl2 &= ~clear;
+	ctrl2 |= set;
+
+	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+
+	return 0;
+}
+
+static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
+{
+	unsigned long deadline;
+	u16 status2;
+	int rc;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
+	if (rc)
+		return rc;
+
+	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
+	while (time_before(jiffies, deadline)) {
+		usleep_range(CXL_CACHE_WBI_POLL_US,
+			     CXL_CACHE_WBI_POLL_US * 2);
+
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (PCI_POSSIBLE_ERROR(status2))
+			return -ENODEV;
+		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
+			return 0;
+	}
+
+	pci_warn(pdev, "timed out waiting for CXL cache writeback and invalidate\n");
+	return -ETIMEDOUT;
+}
+
+static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
+	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
+		return rc;
+
+	return cxl_reset_wait_cache_wbi(pdev, dvsec);
+}
+
+static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvsec,
+					  u16 saved_ctrl2)
+{
+	int rc;
+
+	rc = cxl_reset_update_ctrl2(pdev, dvsec,
+				    saved_ctrl2 & PCI_DVSEC_CXL_DISABLE_CACHING,
+				    PCI_DVSEC_CXL_DISABLE_CACHING);
+	if (rc)
+		pci_err(pdev, "failed to restore CXL cache policy: %d\n", rc);
+
+	return rc;
+}
+
+static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	unsigned long deadline;
+	u32 timeout_ms;
+	u16 status2;
+	int idx, rc;
+
+	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
+	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
+		pci_warn(pdev,
+			 "unknown CXL reset timeout encoding %d; using %u ms\n",
+			 idx, CXL_RESET_MAX_WAIT_MS);
+		idx = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
+	}
+
+	/* Allow one retry after the mandatory 100 ms quiet period. */
+	timeout_ms = clamp_t(u32, cxl_reset_timeout_ms[idx],
+			     CXL_RESET_RRS_WAIT_MS + CXL_RESET_STATUS_POLL_MS,
+			     CXL_RESET_MAX_WAIT_MS);
+	pci_info(pdev, "CXL reset timeout: %u ms\n", timeout_ms);
+	msleep(CXL_RESET_RRS_WAIT_MS);
+	deadline = jiffies + msecs_to_jiffies(timeout_ms -
+					      CXL_RESET_RRS_WAIT_MS);
+
+	for (;;) {
+		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
+					  &status2);
+		if (rc)
+			return pcibios_err_to_errno(rc);
+		if (status2 != U16_MAX) {
+			if (status2 & PCI_DVSEC_CXL_RST_ERR)
+				return -EIO;
+			if (status2 & PCI_DVSEC_CXL_RST_DONE)
+				return 0;
+		}
+
+		if (time_after_eq(jiffies, deadline))
+			return -ETIMEDOUT;
+
+		msleep(CXL_RESET_STATUS_POLL_MS);
+	}
+}
+
+static int cxl_clear_memory(struct pci_dev *pdev, int dvsec, bool initiate)
+{
+	if (initiate)
+		return cxl_reset_update_ctrl2(pdev, dvsec,
+					      PCI_DVSEC_CXL_INIT_CXL_RST |
+					      PCI_DVSEC_CXL_RST_MEM_CLR_EN,
+					      0);
+
+	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
+				      PCI_DVSEC_CXL_RST_MEM_CLR_EN);
+}
+
+static int __cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	int rc, rc2;
+
+	if (!pci_wait_for_pending_transaction(pdev)) {
+		pci_err(pdev, "timed out waiting for pending transactions\n");
+		return -ETIMEDOUT;
+	}
+
+	rc = pci_dev_reset_iommu_prepare(pdev);
+	if (rc) {
+		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
+		return rc;
+	}
+
+	rc = cxl_clear_memory(pdev, dvsec, true);
+	if (!rc)
+		rc = cxl_reset_wait_done(pdev, dvsec, cap);
+
+	/* Always clear Memory Clear; successful cleanup must not hide reset failure. */
+	rc2 = cxl_clear_memory(pdev, dvsec, false);
+	if (rc2)
+		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n", rc2);
+	rc = rc ?: rc2;
+
+	pci_dev_reset_iommu_done(pdev);
+	return rc;
+}
+
+static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
+{
+	u16 saved_ctrl2;
+	int rc, rc2;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &saved_ctrl2);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(saved_ctrl2))
+		return -ENODEV;
+
+	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
+	if (!rc)
+		rc = __cxl_reset_execute(pdev, dvsec, cap);
+	/* Restore cache policy after any attempt to disable caching. */
+	rc2 = cxl_reset_restore_cache_policy(pdev, dvsec, saved_ctrl2);
+	return rc ?: rc2;
+}
+
+int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	u16 dvsec, cap, ctrl;
+	int rc;
+
+	rc = cxl_pci_device_dvsec(pdev, &dvsec, &cap);
+	if (rc)
+		return rc;
+	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
+	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
+		return -ENOTTY;
+
+	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
+	if (rc)
+		return pcibios_err_to_errno(rc);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return -ENODEV;
+	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
+	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	return cxl_reset_execute(pdev, dvsec, cap);
+}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9e218f236e66..743e65abd758 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -733,9 +733,14 @@ static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
 #ifdef CONFIG_CXL_RESET
 void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
 void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
+int cxl_reset_function(struct pci_dev *pdev, bool probe);
 #else
 static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev) { }
 static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev) { }
+static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
+{
+	return -ENOTTY;
+}
 #endif
 
 #ifdef CONFIG_PCI_NPEM
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ca3e77b72d87..7224857c7b30 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1352,10 +1352,22 @@
 #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
+#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
 #define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
+#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
 #define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
 #define  PCI_DVSEC_CXL_CTRL				0xC
+#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
+#define  PCI_DVSEC_CXL_CTRL2				0x10
+#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
+#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
+#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
+#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
+#define  PCI_DVSEC_CXL_STATUS2				0x12
+#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
+#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
+#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
 #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
-- 
2.43.0

