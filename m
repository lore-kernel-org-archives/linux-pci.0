Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020118.outbound.protection.outlook.com [52.101.228.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4769336EC5;
	Thu, 19 Feb 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488812; cv=fail; b=pFsJu4MXbKfNQqLorXbzu7IbmSwhMWb2svCynQiVllWgaZ7B15SB6/luToIVgIpCUWjH1TscT0PxlCejjW9nm/VNJ704sfjk6CojzWL3cyHq5zHGkZ8MHuvLNV8agLwi5131uuD1AR+MIhYH2IdU1tPMI9ghJCPDcgM1ovQHXZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488812; c=relaxed/simple;
	bh=QiVBzYbFCwqKZctD9MIADOdusnrREp0UMwBNt/97368=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gh7IhjwGSCgiD2kLmQkje/YWtFIRhK6bq8bb8BbmnPY9AL0N1aVxczB5SOcahxx/vB3aK8+NEN9G0dTl2YBbh7CKEdO7IV+NK29MH+LfnXvmsNeRn2g8zWFTi9cnHYDKzeL9L51W83vChpb1fsOnFiRkJkM52r+gj2p2OyUWDd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gakf4MSo; arc=fail smtp.client-ip=52.101.228.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gakf4MSo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0q4KyGVrqGhW78S9AkR+UdTf9+1oDsItpsbQYeircWJHViFje4Lk6S4cHKYzazD5D8oLmfNcF4Ev86g582VD6jWWTXJtfHT1o0dBpCNEWJEfYIAYv723j74XW1M50s6bnCHPT2yB7eC6CBsSA0hLKrcyRbEoqy6OnIj08jN6tkpZiQV5pwqi+s2VihInqyDo0PVI4wXMuv0VQ2sU/CjiOMzFrLh0ppdYRaSJvr6g1jLnaMCrMbi/64cv10nTot1wyvBYfzpqVaKE3i3OqvOIvV86aylLE3fD1GmzbH2KNXrONtKVkhdiK9k9Lsrhh4gHUkR/PBLy6y6X+Mbsv1Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN0/TQ7jIIzGySPJfgpzE9PVGjocPXJa/8Wx7UgygPk=;
 b=A4Ed7uniZP/0mYdB71Nf/q5jVuIvhJ7NyhqsjUJWUqg52KUbIUHrnrL9J4TKZ27uBbKIMOChM000os+jiHj3iltcIKO0GFPpOUzBvRaDMwuacSSYySXAMhgkPLEI6VYEtnuCNaJATHsJqioauqJuBtOLeYw5es97aNvlxFQ7B/J/8+xdxeRFbVaG4Y6Wjy8zOGFq6SsNYP3osLEP7FLCMGZoFOPaZKsglxK9QuYASKiNF6zz9wMTMcF8rIlMHh3Um4Jr93abiMiQDqS0pzP9RtBt1/1CEwGtXqKz3JbVXR+2z8bEvE33E/a8WoZvmkSp/7s4b78Waq43sS8lxxblnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN0/TQ7jIIzGySPJfgpzE9PVGjocPXJa/8Wx7UgygPk=;
 b=gakf4MSooWyxZ6UI6HJr2BWt+Z/RG7RgV0FEdj02J0jEVsckcLryADcQ2M/BJ+Za2p/a0JWU1h7RThdXE/tJibLuUnl90TYCMlUkHpifl/CopzBx00ejeCxK/T+Vs1UezsBOB8chIgMJpU47d2zVOuJCBDlxzfS72DXbkhzW7BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB4397.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:300::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 08:13:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:13:27 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com,
	shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com
Cc: mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
Date: Thu, 19 Feb 2026 17:13:18 +0900
Message-ID: <20260219081318.4156901-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260219081318.4156901-1-den@valinux.co.jp>
References: <20260219081318.4156901-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 43979eac-d5d5-4223-c599-08de6f8ec279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0XMdkiLttm5JWge2ElrSR4h345gm6zpM0S4W9n/k9WyUV5FhP1xMd3Y5dKwI?=
 =?us-ascii?Q?i/VsvIlEAdVtLXTFQbbdqo+RNxwEeJoEkUvyeN3ZNN8TAais1AAUihEPv3H4?=
 =?us-ascii?Q?UfgtxzaaqpJUU62T+BKQ/+R0OOCgF8IYneLsdd9l9VNFIy0AN3U5TgashJfc?=
 =?us-ascii?Q?XodmpVAzTGKBrvSBPP55Mwz6G1G9haqDWJnHX3aKYxo1NKlROawItnb6/+as?=
 =?us-ascii?Q?c6B/laBRuGnBLIq9YjwXepqyt+UN2iiapxdh2oVZAcszKgLAmQkQgmIUclNH?=
 =?us-ascii?Q?3TQOdCm0OmTj82dn4eBVjbHire02zXqspZ/QjmSQzWFn7J6RerZRircZtoXq?=
 =?us-ascii?Q?pczsX28Yi/IB+i0+b9xsHNVbyGaytfpEDasfFZsrbjUye25bWu84KZnhRRQq?=
 =?us-ascii?Q?Dv6qy0Eq3x5Ey0CqDWpjpEwpdsQK6BffdBP77kEXXgrveEAvsdWNhB5p3IXu?=
 =?us-ascii?Q?nG5VChS/iUJ2tUiPD3JlGNCAqBCQZzzoScG3pRuWUaVMNQcVm+NbDZfpvvLp?=
 =?us-ascii?Q?/dBd+zeHP4b72WhcyK7IWzvSRc5eKiW/s5wobpsNNJZPK/ZfWCyuoHNilpgO?=
 =?us-ascii?Q?xSmfcDeyZ6vPB9q8LEgjN9fGuHQ7NDbSrNKFRc6T5791hrPPEDE1mEU8nh20?=
 =?us-ascii?Q?2Ali5H1bUj5jnr7/soyzWdc4jRQtwmePbxU7xGHTRKW9LpD5HU6EthcilgHZ?=
 =?us-ascii?Q?uWgPJ5qZfS7VJsVuO559RvU55KTCgjJaRDDCFI9GqNBMvZcTc0CXAEaAGOen?=
 =?us-ascii?Q?nNk3kwr3c0jkeGqOfKTZD1iKVNb6pEyOqd0cl0FA8HrWHPUXA3X1eRKXiCsm?=
 =?us-ascii?Q?uyAwMmr46rfkLHixcxn+HVsXL65QiBU+8CL55JTNhmgGagxw5w/GfkbeY6Ok?=
 =?us-ascii?Q?9jTZ4T7TNmklQeSJ2LBhJsuPM9/ySZB41RepFrjlHLL1HD/gm+LiqFUko6y0?=
 =?us-ascii?Q?uyIsB0/02YMpdXu67hu68h7wfNclDC3brgWed+kGiDQVA/YIOXvvm0F97rh/?=
 =?us-ascii?Q?1DpgVj2Sifz1fjfD6pmK9SQJ+T27ElASyF9T3x2TKRCgGHPOUqQFPDNfXLtW?=
 =?us-ascii?Q?V8VOufeKLzyXPRnurKcxBI+UCgs5vAe/s3NjrmbRRktA2/Pr2DwbAfbEIu/z?=
 =?us-ascii?Q?ijmPlCVbJqlL9qNxh8Xmepv+ofgOvOUgUR1azfLznBXOzSRAX3BtEA0Wlr3Q?=
 =?us-ascii?Q?pQLWl3Lhz88YWmOSeHJ0NkveWSCEMxGXuVjutbwmzrrAgE4OJAmvNAkWa3kF?=
 =?us-ascii?Q?eJCCZXWyPl8qKhxEsmZOwbDXtUdHrcbMS6bHWwHVaytbDX1Ivw+aYaIODi9V?=
 =?us-ascii?Q?5YqNbarUb6rDs41NQGASMDPUFwxrLDvkTOm4vKtVjdLBsDwWis0im+eV/ukV?=
 =?us-ascii?Q?Swq6lRI6SqP4M1IvhZy43NeY4EuxDoSvex93q7yCD5uZFtj/8ksdkhqrkiuM?=
 =?us-ascii?Q?J58RycH+Px97WKoUcl2aLHdOnxM4PBF5z3s7bSvvS1guyxfvsvUwq9pPuof9?=
 =?us-ascii?Q?t0mBQ2peyC8QRmO9IN4VsEFlPeLU52eP5T042XOgKh48hwU5gLik1F12A+e2?=
 =?us-ascii?Q?8J0V5ZrAhzw/E7QKOoUzQoCZV4VEiloqi5/EIsjsFd90x/8aIkPY7mczmGUK?=
 =?us-ascii?Q?Qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eKYYA1QqIsgfjGItSvH9XUL6p5O3q8X3wH9+zsfd1o453v3iv+wJxDVNLKXA?=
 =?us-ascii?Q?8RItReT1uHtMSdVOrJUjQS4B/ABb4I0LVtr6NLSyVjomeF4lIP4PCVqjHC5s?=
 =?us-ascii?Q?za+OvbTP0mfwL1wop5Ra7STISapd04+ItUadalXANeyhNvBslmBEpbAts9gI?=
 =?us-ascii?Q?imCNdyTwavANJEYKg3QOSBXqc+BsVlO/cKd9CaoiO3+aBdO59hgt1NTPjqv+?=
 =?us-ascii?Q?T1narczbUnCs8hWhDxndLIsuZa1t+4rMyYQO+TbcDEEAA1z1minrRTQ3vUcL?=
 =?us-ascii?Q?INqhM9TtIcpWE75x0qjVq2Qv2dB8IZiOEfVpUILqBAkUu9u6r/5lHyL9ClkC?=
 =?us-ascii?Q?C9VbVcJUkVPYvRbNK5x6VLr3GW7D0smEOp3guXWRYasaCy/bJB979fJUysw7?=
 =?us-ascii?Q?+ww60MVOpIFipYANUUpOgIDiXO0CghauiiJ+n+Hb2etK5GQmrXUxS7OFOAop?=
 =?us-ascii?Q?pxRFsCfARNtkXND1h7Ta1v2b0MoTsMRkICNKj9MxSIde+a61KXLwn9aZ8SAI?=
 =?us-ascii?Q?y8ssiwSGLI+NrCPFQd/AubB+491aU/14m3lHmNGuqLOP6JU7FeSUwGpink8k?=
 =?us-ascii?Q?kmLd5vTf3t3fucWhFXWNOfxqC0aYfv3o2uwARg2nWT6IiD50tRVVcx9VOYS6?=
 =?us-ascii?Q?0IZ5xypvsAei2VntEZk8KO566YQK64QqDZC0CJ79XR5KY7UfEouRuHeoXYOA?=
 =?us-ascii?Q?MtfGv25mkNxwo1SoxITsbgal99MaOGOo4jIA+Pdnpwjr81OxfCgLXGj5f4EH?=
 =?us-ascii?Q?BWVL3Kb9jxoRh5AZfPInPXg1js7A9cQ6T/eSPDegpP7PsGR5Y70UMFrwVC5Q?=
 =?us-ascii?Q?RtTd6Q6XAEHzzhYBySY39N9dDuSj6oU1WuIhLJ0F62DCJAMJPC/OkH5att2P?=
 =?us-ascii?Q?V6Vvfc/5e2w5rZ5JugT2vLvMAYPzu4E2MHil8g1rZ9oFgiVvR0N6NI20cmXa?=
 =?us-ascii?Q?XBq8fz6qKahzR9KB/PRomHvpwP+dJITjJ8+S7QDZr/ez7NXH3h53DceJBKLz?=
 =?us-ascii?Q?nHcSemM0ZZM6XEcpKm/IxUmtlXqWxdNxmfUskdps+M+/RKqMXqhe7gGFn9rY?=
 =?us-ascii?Q?KmefI7Olf1f558u39Tf4KdWnSMQfHUtQlEKDPzhN1R4DynPZR7AHe6pIxHGw?=
 =?us-ascii?Q?KijhFjNqmC+rBCaU5phv73oRw25lxcQDfaAKTJSrodfi/YPQADx/L8RW6Ojr?=
 =?us-ascii?Q?2MoudmA5VCgwTDOa/Y4hFgwBcKLuDt1bNxfW5f3FYOWOMW8joZkWMejJD+Wb?=
 =?us-ascii?Q?iX0ha8wg8jRDvyhaPmpuSrG7Dau26GbwZN0/AAfqhqbHsL5OJ44DPDpZqfzf?=
 =?us-ascii?Q?X7I0KpwlDcZccU9L/C5x/JHATGKioMfq7ilFaupoepd45RYjWr6MN422ywzx?=
 =?us-ascii?Q?7F6BCOzYykqPdeFcngl3cYiIe2KSBbYg4txqDTGHSpYI8dE2yHuiLGBLrzYl?=
 =?us-ascii?Q?b0J0uAzow5MvHIFAo/H1d6GajvSbVup+iYHBslqkiN8IfSs6X3nruGr3zkWy?=
 =?us-ascii?Q?Y8cibR2QwpFy1UQ6t0dO9D/GTEYZFOyZjGBi3q5it2hDkvmNfDkkYrQnf0M4?=
 =?us-ascii?Q?j8GqElbgs4sqjxK6YjQaQkLDw/YA5/6a0gXzzTPgppAUWzU/Qjgb/JpI2Vi/?=
 =?us-ascii?Q?L8WPXshCpe09PymaDTP5LJwxFfX27mzof7bSma0xjAT7LElvqIUl4Oe54CZx?=
 =?us-ascii?Q?yM3UO9gQgNw1tNRgzeOXaEfJyQfQipHW/zZTGKGGIJWJsTkH3T9lNmIURgDU?=
 =?us-ascii?Q?v/Cco9lvzrsLVGNDxibWcIZNkybq8/Gbk73CBQXa0UbOUCldV4zx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 43979eac-d5d5-4223-c599-08de6f8ec279
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 08:13:27.2610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEmq0Vn6pELilKFedxvSljyNTPJYZDWR8NzoNMyy7SXHBaaCAcPcTqJSqpglIkbM89WzYWMl/orHVFLrsVZ6qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4397

Some endpoint platforms cannot use platform MSI / GIC ITS to implement
EP-side doorbells. In those cases, EPF drivers cannot provide an
interrupt-driven doorbell and often fall back to polling.

Add an "embedded" doorbell backend that uses a controller-integrated
doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
doorbell).

The backend locates the doorbell register and a corresponding Linux IRQ
via the EPC aux-resource API. If the doorbell register is already
exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
the physical address so EPF drivers can map it into BAR space.

When MSI doorbell allocation fails with -ENODEV,
pci_epf_alloc_doorbell() falls back to this embedded backend.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v8:
  - Add MMIO address alignment check
  - Drop 'eDMA' word from the subject

 drivers/pci/endpoint/pci-ep-msi.c | 99 ++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 50badffa9d72..f287fbf684ca 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -6,6 +6,8 @@
  * Author: Frank Li <Frank.Li@nxp.com>
  */
 
+#include <linux/align.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -36,6 +38,86 @@ static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	pci_epc_put(epc);
 }
 
+static int pci_epf_alloc_doorbell_embedded(struct pci_epf *epf, u16 num_db)
+{
+	const struct pci_epc_aux_resource *doorbell = NULL;
+	struct pci_epf_doorbell_msg *msg;
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	int count, ret, i;
+	u64 addr;
+
+	count = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					  NULL, 0);
+	if (count == -EOPNOTSUPP || count == 0)
+		return -ENODEV;
+	if (count < 0)
+		return count;
+
+	struct pci_epc_aux_resource *res __free(kfree) =
+				kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	ret = pci_epc_get_aux_resources(epc, epf->func_no, epf->vfunc_no,
+					res, count);
+	if (ret == -EOPNOTSUPP || ret == 0)
+		return -ENODEV;
+	if (ret < 0)
+		return ret;
+
+	count = ret;
+
+	for (i = 0; i < count; i++) {
+		if (res[i].type == PCI_EPC_AUX_DOORBELL_MMIO) {
+			if (doorbell) {
+				dev_warn(dev,
+					 "Duplicate DOORBELL_MMIO resource found\n");
+				continue;
+			}
+			doorbell = &res[i];
+		}
+	}
+	if (!doorbell)
+		return -ENODEV;
+
+	addr = doorbell->phys_addr;
+	if (!IS_ALIGNED(addr, sizeof(u32)))
+		return -EINVAL;
+
+	msg = kcalloc(num_db, sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	/*
+	 * Embedded doorbell backends (e.g. DesignWare eDMA interrupt emulation)
+	 * typically provide a single IRQ and do not offer per-doorbell
+	 * distinguishable address/data pairs. The EPC aux resource therefore
+	 * exposes one DOORBELL_MMIO entry (u.db_mmio.irq).
+	 *
+	 * Still, pci_epf_alloc_doorbell() allows requesting multiple doorbells.
+	 * For such backends we replicate the same address/data for each entry
+	 * and mark the IRQ as shared (IRQF_SHARED). Consumers must treat them
+	 * as equivalent "kick" doorbells.
+	 */
+	for (i = 0; i < num_db; i++)
+		msg[i] = (struct pci_epf_doorbell_msg) {
+			.msg.address_lo = (u32)addr,
+			.msg.address_hi = (u32)(addr >> 32),
+			.msg.data = doorbell->u.db_mmio.data,
+			.virq = doorbell->u.db_mmio.irq,
+			.irq_flags = IRQF_SHARED,
+			.type = PCI_EPF_DOORBELL_EMBEDDED,
+			.bar = doorbell->bar,
+			.offset = (doorbell->bar == NO_BAR) ? 0 :
+				  doorbell->bar_offset,
+		};
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+	return 0;
+}
+
 static int pci_epf_alloc_doorbell_msi(struct pci_epf *epf, u16 num_db)
 {
 	struct pci_epf_doorbell_msg *msg;
@@ -109,8 +191,21 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 	if (!ret)
 		return 0;
 
-	dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
-	return ret;
+	/*
+	 * Fall back to embedded doorbell only when platform MSI is unavailable
+	 * for this EPC.
+	 */
+	if (ret != -ENODEV)
+		return ret;
+
+	ret = pci_epf_alloc_doorbell_embedded(epf, num_db);
+	if (ret) {
+		dev_err(dev, "Failed to allocate doorbell: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "Using embedded (DMA) doorbell fallback\n");
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
 
-- 
2.51.0

