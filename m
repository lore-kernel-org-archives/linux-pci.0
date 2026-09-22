Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012059.outbound.protection.outlook.com [52.103.43.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A455D89F;
	Tue, 22 Sep 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089435; cv=fail; b=me0sK/sEyxwDRKwtbW5XT82TXIpu+kzD47pxJcC4ovyBUhRq6iWw2TmnJw8PdsDUbVQmyelew4tT3wmE+0NxTpvpM9grHwFvgYHFxrooLA4/GFMqtG5OaF5J1I58pmjYzVPJqdsCICINcacldzjWVbG+Wvr4kZH0rqwyzWn4bJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089435; c=relaxed/simple;
	bh=pYkbzXHr2s1vHvGeQ0xK3wDzWeIwCyyRjm29IDUByqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FvngyFiOSrvm9BUELfJQRUfC8Nu2KTttryd+63ULTcL9n2PimjDDDD2k8gVo1FhBhdNjCU6qd+j6Su0xZtbpfj34Xg5v1D0VFqS1QJEAUmfZVvO4odyS2BiLv/DNNLJ32MmPoMyzuC5TWYXRKce3SMrRCXJeXWi4jEW+WVAik+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=RTVuChZg; arc=fail smtp.client-ip=52.103.43.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="RTVuChZg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elSHzfzNSvZffRGa5xkt+LN8OREO+t3pdBSR04zBKjW+WtXKw8DI8I4w4eDMiHTqDPQH57WDTyKpQZCZpyYu01oTQFM6CMlHxRIUBPZ1OyIZaJeEgeLU/SdiF3WvAt7slDJi0sWfeXZE+QBNuyPqsd8oGLFWQWQ4pPeQD+9OdsHWhp3qR52+PRGM9UgL9EJo5gGc3yT/JY6DnRcTTqPIZ6KrKvoRiTBmS5tABNxNSNfDqJ/oU9OpYsR5DAG/lgN0ze49pNlp5xa5E3+N0TQ4uAdNayvWdRoXlrb9i3LnhUCIC0CYTjVGq8ERRo3Y+zndmgPgHzF8eh+8UJWeqHxjjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTJ8AOUo7jbIdTOCBXYJ7Jj6r3yuS+NOUMI1+wqzZ5I=;
 b=rn1maCg8FMSkwuuzTMO8IOVQNmKMZEFNrhAvPFYcYTpFM+yfeKv6yPJ+0/8wSV90X1bY5pKJQ5QPDWVYC/FkxBB3MdHgrWyOBYKQjgV1QFgCSyJjQqE9YKqMdPyLRhv2abZcouRWrATn3b4Pp69aH4z8TS9Co961/Q8c9lZJ4K0jQ3T+WL21KsA5gJAtU6xdAwhvqb9ve3mE8djngV1Sy+rQlSAzGtJpjpsstLM/ttQRXJVFZQfzEIV5sbtMmiu9g+JI+G00sbDeF9wbwmJJQxLdam2pgWMPY5yWIF1ddy0PAQtyQobnHzVyPev+xuEaVkzFaU63HUVe7zQRFkzXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTJ8AOUo7jbIdTOCBXYJ7Jj6r3yuS+NOUMI1+wqzZ5I=;
 b=RTVuChZgzxpaJ2Wa8fPmUXmBfDnO7Wy7HaoltuEJ7ylrLidmQ/E0ykZWLHWQjPWTPQIWnqYkcFJhnoit/6Ij16PvHYRts4PQQCaYDEI+Kyvtg/djaalfgubYnPxaO7ASAKbsR0efsJjCDPJTyiWNAPSY1qqADSEQtrcnoCLrMEstsAU9XHIs2u4nkHiodbjx4Q4qFwWk/X9U6q7CRO93Jt8rXNor2WxV5dKT8hB3TjaCuMXa8RzHeV8GVuXexKsA01IGyqAIUkdEO3V+bg4xDfItLpvYh/l0/uKvU2/n0Hh41x54E1pX7Akqn0xBGaEb530Vo13cYuz5LuUlZ1p8FQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5711.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:03:46 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:03:46 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	ben@cressey.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v10 6/6] PCI: Add the enhanced ACS controls check to pci_acs_flags_enabled()
Date: Tue, 22 Sep 2026 23:02:58 +0800
Message-ID:
 <SI2PR01MB439336B71D997B10A96651E5DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::18) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260922150258.3087572-7-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 090119f3-80fa-4247-93e6-08df18bab339
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7SG3tA+qlVYPeZQg1JkVQ5mML4ijrbTOWfji1M5Atj02XeeqmN5lk6wlEMw1ssVOV0/IkQmWHEpL7HtlRQF3M+7YisQIsf8aUUY5NmiNwiYFzHmv9v/Sf/lpzbQLZPpK2+9g7+YO0IoFQhoSrJT1NTfe2QVY7mSaGMDY3qeLlXE6n7RgpcHDUGGnXYF3iVj+x1Tya0PsoF1cEss3yqNOEPuEuEXGll9BTi1ekewzA82nIqK+McKc9AdAOh1YNQ58pkDuHGoYptEKY6Jg87wstiR6UlyAa6byVvY30xqe4Cwd+GjhMREjaapp+SQK2Q5FiqCgM+Xa0WkKa5K3LKZMp2Pn3ifo94NroMXW8vwAMsfsRNP/0HVZLtb19ZDWsr15g7PP1WFD+qy8BHtaIphrvqv9KjM9dsNzwsyta3y/6Wdj3FWXd4hcEFdJinSoc+9SDHeYN+Y7j/wfnGqy+30xBXtmjlga2OhwoSTbVCjyVSyrEFE8VYlAfJJK8goYpnqhOE4kLj2rJi0gGnj1Dat4ynxBG2P3/UfxOvQmKdzaW+BIF1R8+/U6GOGRTXHy8TCwvZW5woKCSLOq0rVn/BbQNYcKGE8zfDQ72XFKsvNAuNBe4HAlSaBxHIyW6oaphnR6y37ekRxhRYUuJdRyF19asscGtlCI/qU809sNKiWR6DuAUgi8OQIKlBzdCnJWc2TLLml/XUjoFwp4VNYXt51XboBcun9SS1bst0g6IvtxyWi4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|19110799012|8060799015|5072599009|41001999006|51005399006|7042599007|12121999013|37011999003|15080799012|25010399006|23021999003|16051099003|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tkSJXVCrCaMZfraCIg2XV8JHW/osP1QWhZWIZnveslU39g4QsrDHXLIqwjgI?=
 =?us-ascii?Q?XlsFizmNrFHlw8WtKDYLnBGqk4YHTHntuD4wDDjwyIizDkAlI75KKglOItbi?=
 =?us-ascii?Q?gEe+O4YZYGnZ3iFda6J/Mk5zG7UF/7kmqGyF+jrIuDyNPCL7kgkdNF2xbsEC?=
 =?us-ascii?Q?DuO0PHhI0nXqsjYcrMAy4HeE5WSFKbvX5nsrI8Z729w8rVnfJDLof7x6ywAa?=
 =?us-ascii?Q?jvHhWqb4IC5e/gBqXZySwWkiLZQ30kOLzaS/y2VucQmh8De4SEfkl20SYjs+?=
 =?us-ascii?Q?e+8hJ17cFKq3KKoocifs4Rz+bY0MG3e3YhkvOUUS+IsOfqDUaxbRAvRaMkab?=
 =?us-ascii?Q?zssN12eJCPqRb6Oh3SgkHy7h2SSrUijo04jePkIBc924z4CTaibr3q9RkceC?=
 =?us-ascii?Q?/PPFv081FTZuk/o5FwLBI8hcunoti9hxtSp/Z9Cx3Mb+LRCMm72OvAPAtt2D?=
 =?us-ascii?Q?OIPrkytvc3BTj8/re0iNLgfXAnwByMqxu+UwTMQRBnuphVA8i1jqyeKCedmq?=
 =?us-ascii?Q?uAYD8q4p+RPoqs2qmDeKLo7GmVI7kwZBfoxWr7fTFWlWYt0dz6tIHyVvsQin?=
 =?us-ascii?Q?CLeg1PrFmNTkm7NiMPGYNrWp4SpYzIdX4xt7eviLA+VWTTxsraf8j3cyKxeB?=
 =?us-ascii?Q?+R+9RSF3apktnF/yfOiDqdOqlE+kGcpr3qaDmX6b6F7V78oiYWMCSyW5YTch?=
 =?us-ascii?Q?WAM0DHfJDUxO5pYbTdkqQ/vpN2YoXVI0ruqtZ6IURhvq++rTuhky73huol8l?=
 =?us-ascii?Q?gkC5mtmR34SOpPNOZVR9iAOCNnsr1sx4XCRxvrhsBlGGyifp7Ie/t+IQPgtl?=
 =?us-ascii?Q?KQDi065A/Y3k/amOX0Now/oW0r9QJiu1WvFMOgKxCtv2SMqMMzGwxMKlRSX3?=
 =?us-ascii?Q?HhDBOOuWbXnOvmMMVjtoCx2SOYOfNQzPTKlnR/5d4glCUejCqfCKlLTm3ULD?=
 =?us-ascii?Q?qHL94NQUtORVoQh0+nCAQf6nH/ec8X3C36cV9WvP+DIVyxVeMUUJ/Hcxho5D?=
 =?us-ascii?Q?EUlIEu3yWqk2+iB4Ya++dXCC1ArYKaaSvDmh/IB98d4qriEyjadvFf7ouF2n?=
 =?us-ascii?Q?/+j7yf6K2yrR/TOmUUxhsAt8mg3kDcmd0gBy1FE6pBJe98GmMlMuCh4cL/rl?=
 =?us-ascii?Q?iGjKsQC/B0U9?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IqeeIEJ26RtBAWNG5caUTsOYqtVsSXjervY6Ns944qkptvFdsl+0QtHjXiEc?=
 =?us-ascii?Q?AaUmTvX6Tl+SqQGNZ0PTxVTHeowaz3YwczhmNnHOcuEGaSg93Ngplah/geaf?=
 =?us-ascii?Q?XcAX6bh0zG4MlmCQexbiAorVCIvn5msEhYEA9BVCu0uBLpkb0gNh5XU9dzHo?=
 =?us-ascii?Q?cMqfEVs+aGxaIEK4g5Yuu6HplPwg028GQK5TGqSBdm9P6is0K2V0WBmEuTr3?=
 =?us-ascii?Q?CRy2FGm4uEGHJ57gtzfUJd/IYa9gMLQ+7bDImW69kcTD0nFW44UrioZVNTvo?=
 =?us-ascii?Q?GiNcrRLeLK1Qz6c1rDm5xZGIkLTWyd733FpoHqkKZe7CreGJr9s6Py2FIZUl?=
 =?us-ascii?Q?VgsdOOZNyU2FIDfIQDwGyBJW/RTyiAiL/NVVgrrpjwY517HjyWVTIsaArZ/t?=
 =?us-ascii?Q?Y9Lx6WzL3KCL5eZT80GorITgj7SK66DDcndye6YLEZhnrnodtcdW0zlKHhXv?=
 =?us-ascii?Q?1C3l0uOgsXnzu8PY80Cl6HX/gZnz/mLJ/aZ/I3bLB0PuLHfq9qbEQcxLawui?=
 =?us-ascii?Q?bTbzgX4LP2MdYZhhAOJorGoHvIN2uBmnOoFHqFayqT2zINdk6+1J60nVarO7?=
 =?us-ascii?Q?HyeRVtzTH8eR8BkW/eADBRYgrje9bqU0QcZ/Tp7uedBlWW6WDL6JzaG0IoWu?=
 =?us-ascii?Q?fEsL5j4dxoB2hBWT9iX3iE8S2LH/YiU6OMX6KkuEZOp7+NlQAVq7sIPnBQgF?=
 =?us-ascii?Q?i1ZVqKNVf0u5LkIOOncQDQaMmCz6qhRTpmkNsJkaCUXXelh9yBDdAK3LBuWJ?=
 =?us-ascii?Q?HGnolI4TpYK/g8gvbRl7fzZgtvPlQkZ0/+H2FGEMAx1t27oqLksJd6v1v+rr?=
 =?us-ascii?Q?NlGWTexpOkBpoJ2Orm3/r4yV35rihJEz1fKti7TKQIL8qzf/AGhJeNqN8cea?=
 =?us-ascii?Q?+N4Q8mNF3lCIv3MXSjYHVedZXIEAC4a66NlUnyj9NFx85YF7k0hsCLScnntk?=
 =?us-ascii?Q?3qPTSG9YIU0L66NNbRnwAjNRYQ56KAVdWNsSwI/HViLKwDOY+PgEfPRRIhWc?=
 =?us-ascii?Q?NVX1HUlWDO3pk4nL+dz8ZS70u3temQu7haKSc++ejU6yozct1mshnpXsJgCW?=
 =?us-ascii?Q?ZJUHVvM6FNVKbOcm1NnMzGLy4navdXbP+M+4KIJsR+ejnluI7OZG1wutqSpp?=
 =?us-ascii?Q?eQASbyYBH2gr3VOYpNP587x9kmND2vnktu/xuNthIP3NINIYjvCXFRwHIWyR?=
 =?us-ascii?Q?MzC2EHOh35LXre+lh8tU+iNnDw4TwnxNx5YHUb3UUNrHaDtvwktLMytn9tIC?=
 =?us-ascii?Q?iagQff1IiOeGH7VP39v/jvaUA5sEIVzOqGkEIO9NF+e0WIvhQpHR6vAGJ+pp?=
 =?us-ascii?Q?8Lk20Uq9Exh8wa8lvkUCt+Yv5WOj9OLcMa73ctB7SPrU1eReo9NQES6QBiVo?=
 =?us-ascii?Q?+d1/T5meQOgCtx5gp4prfjsCgbkv?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 090119f3-80fa-4247-93e6-08df18bab339
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:03:46.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5711

The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
isolation. On devices that support the PCI_ACS_ECAP capability, the
controls are required to be enabled properly:
- ACS I/O Request Blocking needs to be enabled to avoid unintended
  upstream I/O requests.
- ACS DSP and USP Memory Target Access Control needs to be set with
  Request Redirect or Request Blocking to ensure the Downstream and
  Upstream Port memory resource ranges are not accessed by upstream
  memory requests.
- ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
  areas that lies within a Switch's Upstream Port memory apertures but not
  within any Downstream Port memory apertures get redirected.

To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
support, pci_acs_enabled() skips checking for the capability.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4942bb6f1e11..89dd519cd311 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3652,6 +3652,57 @@ void pci_configure_ari(struct pci_dev *dev)
 	}
 }
 
+static bool pci_dev_has_memory_bars(struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM)
+			return true;
+	}
+
+	return false;
+}
+
+static bool pci_acs_ecap_enabled(struct pci_dev *pdev, u16 ctrl)
+{
+	struct pci_dev *upstream_pdev;
+
+	/*
+	 * For ACS DSP/USP Memory Target Access Control, either Request
+	 * Redirect or Request Blocking must be enabled to enforce isolation.
+	 * According to PCIe spec 7.0, the DSP Memory Target Access is
+	 * applicable to both Root Ports and Switch Downstream Ports that have
+	 * applicable Memory BAR space to protect. So if the device does not
+	 * have a Memory BAR, it skips the check.
+	 */
+	if (pci_dev_has_memory_bars(pdev) &&
+	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
+	    FIELD_GET(PCI_ACS_DMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
+		return false;
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
+		upstream_pdev = pci_upstream_bridge(pdev);
+
+		/*
+		 * The USP Memory Target Access is only applicable to
+		 * downstream ports that have applicable Memory BAR space in
+		 * the Switch Upstream Port to protect.
+		 */
+		if (upstream_pdev && pci_dev_has_memory_bars(upstream_pdev) &&
+		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RB &&
+		    FIELD_GET(PCI_ACS_UMAC_MASK, ctrl) != PCI_ACS_MAC_RR)
+			return false;
+
+		/* PCI_ACS_URRC is applicable to Downstream Ports only. */
+		if (!(ctrl & PCI_ACS_URRC))
+			return false;
+	}
+
+	/* PCI_ACS_IB is applicable to both Root and Downstream Ports. */
+	return ctrl & PCI_ACS_IB;
+}
+
 static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 {
 	int pos;
@@ -3669,6 +3720,18 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
 	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	if (acs_flags & PCI_ACS_ECAP) {
+		if (!pci_acs_ecap_enabled(pdev, ctrl))
+			return false;
+		/*
+		 * The check for the required controls in PCI_ACS_ECAP has
+		 * passed. Clear the ECAP flag and continue to check the
+		 * basic ACS controls.
+		 */
+		acs_flags &= ~PCI_ACS_ECAP;
+	}
+
 	return (ctrl & acs_flags) == acs_flags;
 }
 
@@ -3727,6 +3790,8 @@ bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	case PCI_EXP_TYPE_DOWNSTREAM:
 	case PCI_EXP_TYPE_ROOT_PORT:
+		/* PCI_ACS_ECAP applies to Root and Downstream Ports only */
+		acs_flags |= PCI_ACS_ECAP;
 		return pci_acs_flags_enabled(pdev, acs_flags);
 	/*
 	 * PCIe 3.0, 6.12.1.2 specifies ACS capabilities that should be
-- 
2.51.0

