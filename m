Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020130.outbound.protection.outlook.com [52.101.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED194352C2A;
	Sat, 31 Jan 2026 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866630; cv=fail; b=Xp5KgQL2MHgaTOt4HUq/vXJHBQE5BNoOyyaKbM6OYZmArs/hjjarEVOT220Ob8z5jirZyPfe27uGfoRl67Rer1E5J5AJrfGaZfJEn51fSkG8BRFHe3pIgjwbnqmfgG6g3HxJQOeXRX7E1JYM+LDQS1xqV3j0KzdR1W2Doa1Rna0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866630; c=relaxed/simple;
	bh=v4EcHqBQerrJJRp9LZQJfWz/7u8fcoTA+g0oZWshLR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AHGEpPzFhvGgZBdYMm+Z91/ZAFDcIN067LNYA2F26dKV0/X9jt8MKOc71SBe9NhWKqZ+FuJ6JBnUKflcdykwzOiDCkyeGNxErdyrTcV4ie7Bdz1dYef6DhMq4il9p5f3oDvdcBJjd3TI0CxN4cJ4Scdq1bNtQK/i0eDM5SfkFaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dNx5lLHp; arc=fail smtp.client-ip=52.101.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dNx5lLHp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuMiwwtfMsGYyRas3uNFj2DFUfs7T8mnWgYChOMrqmSOB0uYFf/YV8zOLk90UgzecWdiUY065KDyoxhXrZQaoel+YP/gMxtSfU6wEZjFyU6oz68uOoIhW72QUbT/p2zGTLJnTB0ofuYYZyOT1i/fBJFI40txVQEvSLcDRbEoE/Ts9GmRJg2FF9dEBx7Z0UkSiROjvRtz9BY0DI3oeTOgRjv4WG7AtN8yFygLJCVgvmQW5l1I6ELGV8WcX+wNvv4bWRynf8BOWqk9GUCWNzwdWw6B+6VHy2Iqd+DDeOlsfI4BlR9iaBsFn323myONgiuUqy8iDspKk/WBamSyGVoKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUYyEqiVuTYL9H5N5UWfu7rg1sQhdovjZkqQSxBTm9k=;
 b=hsGCjHl0mqok3r9m/ZT28GN3AlvFydKfzb6n6hxRpkz1P4bwmyvWimA135pPGZVwMe/IrKdZl/Ldp0CSHi25smMWSGqMuIMpfQO0kEvV+DGsfp2cbTj8DaZ3a9PGprLnadwSF7f6GpjGCGd1sgTYTLWsHSCPVh/or8P788vyETswllPx+RyemPmfIKMxw+MCewQJDQJHdm5l/gbY06cyZEIz+fxtivQICsnasm0roYhY7BavE/o/XnN4OtNZRYIHflwWRLhml1ecpfnD6zWYKpUK8YbC3ML57uPSgcXRq7PHOkDj1CoXO9dn6SsnfpkIdO9BGT3jRSVOs9eWnld58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUYyEqiVuTYL9H5N5UWfu7rg1sQhdovjZkqQSxBTm9k=;
 b=dNx5lLHpUxllo2YR03YWsk+SY8hEBX2RDICPgzJrXCpyXNlOiNKJAsZvKenZHbsqpG1d/juhlokLrUE6KrElSuUd7hR/1IBPn4OPndiMqqY1ryhfIAh/oPrqSG0zn7zUKVGeV3UnblK1axvmZ91N9uB1Bmqf+ImgtCxEMNAVYFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5003.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Sat, 31 Jan
 2026 13:37:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Sat, 31 Jan 2026
 13:37:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	cassel@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: endpoint: pci-epf-test: Use dedicated pci_epf_bar for subrange mapping
Date: Sat, 31 Jan 2026 22:36:54 +0900
Message-ID: <20260131133655.218018-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131133655.218018-1-den@valinux.co.jp>
References: <20260131133655.218018-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0133.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: be3dfebb-7a20-4c26-ea66-08de60cdd1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qn6ruFFGbkbOD7nIJezLHwZnfD6PrLRyZ0aifUuHfjk7dyaTP15mnrrOlJOo?=
 =?us-ascii?Q?2bIuT3Lt5H9flthUtLs1guiwK5PVq5YZXOQklTvhrYMs6j/kDSL9TkrZQSw1?=
 =?us-ascii?Q?hDFDM3Te1xW9rIV+ODEXI7bXhlwGgOgHnCEeNIsNLJY0181VO8JgQWhy/TJd?=
 =?us-ascii?Q?EQSyMNSmYN1pRejqpCGCsvjam4oTUe6W6YvlPqfxDSuXWyO1GlauLFz4VR3V?=
 =?us-ascii?Q?/2kOOZ+dBf3gBlv0R4Yp5S9DfMFwCCX4UWSMyW9TRq1PFfK50Y7oYh+OWctB?=
 =?us-ascii?Q?NRnnEEFyCZelftw9d4J3EgTkki6Hl398b5FBLKuv7hrdCcEksen9LU5kbUzi?=
 =?us-ascii?Q?Nn9S6xVMlRhyf42CBhg8D0ZFjGDoceWGDwokonIQA/yRUO4VPg4E+mkvqZww?=
 =?us-ascii?Q?UAoQET3MjlYO85iC5IM3pdmcq//blOr1R32b3kt+X6ijzyjHNo46ZZLaNERd?=
 =?us-ascii?Q?d+12FO18jmT5+oCXalM1zwAJeBNJ3Z0nv8yuM9jAE6tCGyS8ELxuwEYrNQS/?=
 =?us-ascii?Q?IczFB+EG/eovS8mlVvxDD/AyCw0Y6l1txgmdAkdEp/ARmWK+g0UzvB7EEpds?=
 =?us-ascii?Q?vPHsCgUQjN8fA2ihPJikJ9gA8NxXKVV4h2snfIX4WGzf8+I5aRGDQlivrNfP?=
 =?us-ascii?Q?VMEp8pTnWhSJ0ylCFV/Vmj+5ZyyDYJV7H67F2HoJLxM+AyHVnvO7hv6MIyMw?=
 =?us-ascii?Q?bt0L4aIqY62J18kIe6f+oEVZNhUw5oZFB4u4P7sVB35nRUUGYU7wD3xyG2Ms?=
 =?us-ascii?Q?j1Ol4MSS9p9GYqoGrroSidGOiPbfl7k+OvH3+E7NAscVdE6PHTRgctveey+e?=
 =?us-ascii?Q?0MpPDZIDlBPh5rP3vRMCiMMUhTNbef5E/Abjqdn7q9ygiCKZW44mcusooJNv?=
 =?us-ascii?Q?ZNLu0G2UKyf9q/aZPK/xjywuvW7T8+/mCBOdq+Jiwbk6EP5U4G9tiwoJq8Am?=
 =?us-ascii?Q?9saTF2w80jXWFeCCTPeBvRdHjjDgtrpH+8vyR/6GK+zcpeTa2JLtwmNR5ChB?=
 =?us-ascii?Q?BxVBqAeDPf8nXmDKwnf0DvyboFyFEf/+D1cNU+A+RhzvK8maEkqmnpIP5C6e?=
 =?us-ascii?Q?4c72ObZ/JfE+JvskWSGi38pDO5i83V+Izk4GirMlNWdB8mY+ym9c6idn1kcI?=
 =?us-ascii?Q?pHZivWuAo/vXWa1Gz7it+UnZcRfloo8+JbxTUh7ObqgIMzkNoMEnQv5Hua8i?=
 =?us-ascii?Q?4xuWkz5d+Y4jkZynuEpg2KorsMc7vfXQaMoMhrBj1RATnE1WUtytggX2pP24?=
 =?us-ascii?Q?cD8tANiA2AmIevAoixumqpZGcBIbCnxGeQdXNf8fFXCSl2x1YLmpUxJO3cQE?=
 =?us-ascii?Q?I1KNfGbomWyB0pSyh0EYiLImi/wuMJdzCgd0h83nm1SFIQApOq7R2hJcPORd?=
 =?us-ascii?Q?kAZV8y4U5TN+B/1ypROPmMxi8Iggi4kgov2SomPBT+qvvrrWfziOqUc2FFK8?=
 =?us-ascii?Q?jyvhRhJGXmRUsTi9j41pZiEnXJrT4ckhpIiVaQzszkEUhFeUYorGiMns3Dcu?=
 =?us-ascii?Q?l+RZgNVXPOj49a27z4MEEwufuf+IwVBpdXm8p/MWsyUJf53fJA9fuOfu3A4S?=
 =?us-ascii?Q?ASV32lCnKneeEBMm8P5Z94b1ldKVDRiNE0puFBXeKuwAvTp1WUYSa4rN4eDX?=
 =?us-ascii?Q?Tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jG/10GZuru1xXch6Ysba8yoLrdyuLyV/DwEPe9pSFmc8eACYCeQvKMwaN7FM?=
 =?us-ascii?Q?0F9HzrnmPCG74AH8/7j7FGgqRY5uJK3VS1+aV6y0XPVDkPUvnqbi38Or1RdN?=
 =?us-ascii?Q?IGY8AuKDkwM4V8KnXV64ZjaatGhPh4lx0bM36Ed0ENvIJXjYMIZbliINI3VN?=
 =?us-ascii?Q?5mYxcEHzmeKckBMAmrAE5q9anvCV7uW0Z1csWhokd/ZJDI1JmNoB86QaNA1T?=
 =?us-ascii?Q?V2PEQAYcUAe8QybD+5M875GfUuAi/esoSPgYASrJuSxu3Ixb3ZRCRpohHVvR?=
 =?us-ascii?Q?j0ctvQjw7Py/M1NB6SBRzggzWlBr8Is2GeCS2BgntnpunZ5znVFV0milirLS?=
 =?us-ascii?Q?CMY0XXONdcCcucSEoEK42/e7aQ1+fIdfTq47UTlClzodteabhPyZS+2hda39?=
 =?us-ascii?Q?/MzuNYNEM/UmZTW0dchtpimtrobrge4zoCNgDpggF2Xa1/WcIy5t3E/IR41F?=
 =?us-ascii?Q?5qLMkyRZV8S5JCQS8UOpYe73kvdKxX3hbSn92aVHz/ERyDLTgnCSkD4AG8RQ?=
 =?us-ascii?Q?c8s4y7q3Q1KlE0WFMoNiReXcYhyWb4lIIt4ukEhgzhButFFYKIZMjuO3TDr1?=
 =?us-ascii?Q?O5Ux2L0eFE2K+ShANnFGvstClNpQyp6O2iWKzRtHYoUEqNLaroiFzG9cKYo4?=
 =?us-ascii?Q?c+vNlvbN1+fGFQmZ/qw985r335ahtpEBgluTzSBGjVW4wyob1dBmyW2PIQkX?=
 =?us-ascii?Q?ZDWsB8Cu7ZYmekRqhA/9gW5Iq8kXwDRA6JEGSZx+1TMhuXs76d3nSjL6PS9X?=
 =?us-ascii?Q?oOcfWlUO/Lptedr7u5bu/UtTWYlRW7clLN/OcdVmydPqUq2eoo5Wr5ufH9/U?=
 =?us-ascii?Q?GhMJQtF/JeGdnfDufI6mTRFpi/Cz9+LyQd1/RjVMbxe9UDMIA+HNyUfzRAMN?=
 =?us-ascii?Q?lbXccevYJQXdc5N3ZHWZenQXn61I0nrwX3Crg/liYXQ/+TSgaa7GcKppdSpS?=
 =?us-ascii?Q?rzT/xy+xge+x+8CxNOGbUcC0fwIbmlWCDvdBOINnCT7dUzV/dywbeWu5uVG+?=
 =?us-ascii?Q?AEzbE7jarOGjsBIwhFLzNd9CPq52cQKsJNFtONTd+Obv25cTFKbOXhHPibo2?=
 =?us-ascii?Q?86EZpp/h88Yb+pnxxg/9yigt1i7ToJ2mS5OerrFh8e3uAJNuDW+1g9v1NLOO?=
 =?us-ascii?Q?1Ji0IhQR/IVZqg7e9WyNwC0Yx/dQt9fT6ExiMXxuBgg68FswizWq2jTAZYL1?=
 =?us-ascii?Q?zNM172mcH0kSxkYf2x2fZTxoQ7NuZwuGYlmNihAmvBdXYg8NdFyhNAQlehLW?=
 =?us-ascii?Q?X+0vUjSFggvf5afE0N79yFabtazVs978B/R1JihshJVIwDOfSRAQzlF81tj3?=
 =?us-ascii?Q?ctVHs2Y02iucQdBfW9LCJtQrQW843ArFMssnH7oHf6kKYnx0dpTh+0kI6pcu?=
 =?us-ascii?Q?pqFMYZfqcklvjuOjos28m9R3IMZtdturv0Z+WfjwPhQ/aYaf2DG+rjInFSQe?=
 =?us-ascii?Q?0kKrn3MJWCaebbkfVBegeij2amk/7T3uwCP7pjfVuufEA9vO44qrqwplkDYu?=
 =?us-ascii?Q?S3R2+MtzQ+G0ky4rOn8rafETnLBvy4OyZHOoj3zwmZctT58hwy3sQIS8Y2Hb?=
 =?us-ascii?Q?LsV0Z/wVvE88mIOT8JCcDl7x1uhyxCW4qU7Re7rkfac1NbKrn/L5R7W3iToB?=
 =?us-ascii?Q?5uy/WqgaoU33UizE8M47HtcUD8IABac/BKg06K43bh/J08t/q+wVl8s33Z+O?=
 =?us-ascii?Q?3I4kTbYDEOMbUUX5lRmBwO38jycnsAh5zzVIO3rBlwPJzxuUNK6S7Y3OQe+o?=
 =?us-ascii?Q?cY93cAQ+mFQbsbfOy5ryqy64jTRv/k0h1igiv3YshnRmQ8RMBeqm?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: be3dfebb-7a20-4c26-ea66-08de60cdd1ac
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 13:37:03.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3jxl7VYpZyn7w9h5in2uMe04CuT86OznXjRak89w91TBiJhhrP3TrL0Gzj8hdwznE5cs6M2qzbwP4seAU5uLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5003

The BAR subrange setup/clear paths in pci-epf-test used to update
epf->bar[barno].submap in place and free/restore the submap around
pci_epc_set_bar() calls.

Some EPC drivers may keep a reference to the struct pci_epf_bar passed
to pci_epc_set_bar(). Mutating or freeing the same bar descriptor after
a successful set_bar() can therefore lead to unexpected behaviour.

Use a dedicated pci_epf_bar instance for the subrange mapping test and
only free the allocated submap after restoring the BAR mapping back to
the default epf->bar[barno] descriptor.

Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
Suggested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 32 ++++++-------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6952ee418622..fd6452d1dcc7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -86,6 +86,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	struct pci_epf_bar	subrange_bar[PCI_STD_NUM_BARS];
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -827,11 +828,11 @@ static u8 pci_epf_test_subrange_sig_byte(enum pci_barno barno,
 static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
 					    struct pci_epf_test_reg *reg)
 {
-	struct pci_epf_bar_submap *submap, *old_submap;
+	struct pci_epf_bar_submap *submap;
 	struct pci_epf *epf = epf_test->epf;
 	struct pci_epc *epc = epf->epc;
 	struct pci_epf_bar *bar;
-	unsigned int nsub = PCI_EPF_TEST_BAR_SUBRANGE_NSUB, old_nsub;
+	unsigned int nsub = PCI_EPF_TEST_BAR_SUBRANGE_NSUB;
 	/* reg->size carries BAR number for BAR_SUBRANGE_* commands. */
 	enum pci_barno barno = le32_to_cpu(reg->size);
 	u32 status = le32_to_cpu(reg->status);
@@ -857,7 +858,8 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
 		goto err;
 	}
 
-	bar = &epf->bar[barno];
+	bar = &epf_test->subrange_bar[barno];
+	*bar = epf->bar[barno];
 	if (!bar->size || !bar->addr) {
 		dev_err(&epf->dev, "bar size/addr (%zu/%p) is invalid\n",
 			bar->size, bar->addr);
@@ -883,21 +885,17 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
 		submap[i].size = sub_size;
 	}
 
-	old_submap = bar->submap;
-	old_nsub = bar->num_submap;
-
 	bar->submap = submap;
 	bar->num_submap = nsub;
 
 	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
 	if (ret) {
 		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
-		bar->submap = old_submap;
-		bar->num_submap = old_nsub;
+		bar->submap = NULL;
+		bar->num_submap = 0;
 		kfree(submap);
 		goto err;
 	}
-	kfree(old_submap);
 
 	/*
 	 * Fill deterministic signatures into the physical regions that
@@ -925,13 +923,11 @@ static void pci_epf_test_bar_subrange_clear(struct pci_epf_test *epf_test,
 					    struct pci_epf_test_reg *reg)
 {
 	struct pci_epf *epf = epf_test->epf;
-	struct pci_epf_bar_submap *submap;
 	struct pci_epc *epc = epf->epc;
 	/* reg->size carries BAR number for BAR_SUBRANGE_* commands. */
 	enum pci_barno barno = le32_to_cpu(reg->size);
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf_bar *bar;
-	unsigned int nsub;
 	int ret;
 
 	if (barno >= PCI_STD_NUM_BARS) {
@@ -940,23 +936,15 @@ static void pci_epf_test_bar_subrange_clear(struct pci_epf_test *epf_test,
 	}
 
 	bar = &epf->bar[barno];
-	submap = bar->submap;
-	nsub = bar->num_submap;
-
-	if (!submap || !nsub)
-		goto err;
-
-	bar->submap = NULL;
-	bar->num_submap = 0;
 
 	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
 	if (ret) {
-		bar->submap = submap;
-		bar->num_submap = nsub;
 		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
 		goto err;
 	}
-	kfree(submap);
+	kfree(epf_test->subrange_bar[barno].submap);
+	epf_test->subrange_bar[barno].submap = NULL;
+	epf_test->subrange_bar[barno].num_submap = 0;
 
 	status |= STATUS_BAR_SUBRANGE_CLEAR_SUCCESS;
 	reg->status = cpu_to_le32(status);
-- 
2.51.0

