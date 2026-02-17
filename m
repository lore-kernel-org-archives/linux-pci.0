Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021097.outbound.protection.outlook.com [52.101.125.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B52EEC0;
	Tue, 17 Feb 2026 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310349; cv=fail; b=FoLhUYH0b/ZYJLQT0dmibcz1rJvf408QuPwCByWJMHs7hRml6Nx2I6OojfktsbfMGfLzNpLX6zguUQC5p6MjJ022onu+btfuI0DaOQ0DeQWm0a0m9Cchn62v8dFtLJyIaWccF+QOfZ7oyXpeDyMrzTaeG8i1NJrJTugWb7ya06I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310349; c=relaxed/simple;
	bh=R+msq/wU2c3j+B1h5SmUTSx3HNjocDsAUVvLe27B6+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MVGjr70vuoBngHXX7AaTvmt7Y/p3YxScR2Zt75qI8XDSDvJ+LIwkaH9iwjpZi/TuIIwSfEFJZk3sZW40qyHB2wjlt67nWuhdn8p2lSo89HT8EqhftEyXVK0g/ACl1FN8JNq5NShqqpbnh3SV2+9YFHY9Lquvt5GibJ2PoHuTNDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ceuxtfgn; arc=fail smtp.client-ip=52.101.125.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ceuxtfgn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7OTQVSLVoZc8a0nH+kkWYspsZ9ux3weY+tIBIAjxM6TFUvBmLmHHHj8B1tc7QxSH4v6jvYSqru2A7q2qDh+T5E2kKOlDuCqU9mubifSrXTQaaH/yvBfnUtCDf9p7uy0thaDyeSRT7zxVKb4q8JcOgtkl6rJsxKQXQERCw7q2PAg0Ez2yrC0aVZc3QNMg2XjEj5Caqms7z27Rce5/pQo75+ELwsmqzEWj67ra2AGGpJXP1OT8lsm/IY4t9ZpPyobUG0aSflMnb31BpDZHx9e0Pe598mhAuySeS2F+5GFrIvu9h9wuMWLyvBoWIVK5uu1bg3flS+44zJyimqWCLrW1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npCbKe5i1w0XZBvkSofaaLCJgUNyMfbyAz152+QMj30=;
 b=R3z5wSTXj1pULqURekx59mk5YltIpIKIBp3/MIevM1Shcqhr4FJnxumqvUD/L6vBB+APcQd0IU7PjXJWktItNgLsSrJgigGoT+eQfJeIhdb/OJyQyk7cXi201sONZQaf3ZYmq0KYjcQrT+9HtcJklVWphBX6R8aFkhOnKFWrh0Gmt8ryeTaNgGQUrkzc8m1IDN0MFO2akeiH5XAKguXNQFeo5bv3rZ3HVTBzwEm8kMJA2XSDW6fAqfJ9z3uzozvbijmFiu1IfnpK9mo+nD3PPmHQO9jaOLC+ZpPJJJBYhv4SjKhczCVtUT56nJEo91FJdxVHxt7XFVguU6tbqMC3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npCbKe5i1w0XZBvkSofaaLCJgUNyMfbyAz152+QMj30=;
 b=ceuxtfgny9laPxpmyyBiT4KFsMbbBXHSKT8bFONb2njIPKGTCOnaLuY2ZatpFQku1VH+KUojLBh58QcgBWj+5zjjGoypnfzGvqr9jCpFTTMAQyrVUI/QmLvkOEvzm2uyVWMfjRDxKTJaOZpnVfJUYQxpHTWTzHc98TDlGzrvIlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7477.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:356::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 06:39:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 06:39:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 2/3] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
Date: Tue, 17 Feb 2026 15:38:55 +0900
Message-ID: <20260217063856.3759713-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217063856.3759713-1-den@valinux.co.jp>
References: <20260217063856.3759713-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e16a86-7325-4abf-7a8b-08de6def3e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q1cqyzx1eZQtzCU/ED0pwYOwchTyBEwZ+HJL1tMAJhsCOWZjYADdeRg2xcnd?=
 =?us-ascii?Q?r2uhYwJsXBlMBm0PlntN04RTNyvIv6vp5oYeK4CIzZC3Bb2ImaCH+O6qP09e?=
 =?us-ascii?Q?/UtSntBhitGWc1EzUq4FAcNZhvse0v7xFBhpkhMv+t6BEBRB0x48e84m/TNc?=
 =?us-ascii?Q?qdYKS2ccgbYOrUX/Dn9jjz056U7k4Kdo0GOESO5HIz91H5zPXc78j59youkt?=
 =?us-ascii?Q?P2P3feXwxnvgUj36TntPBolrDKQTWsF9uu+1uFNzGy5kxEz7FwRG8ezkyRF1?=
 =?us-ascii?Q?T/UofPgqCwftAAv7rXdMsR17OPBuFNI4Wf4vuW7TfdgqsmEaQXoUGxGljdWK?=
 =?us-ascii?Q?L4ryFsj6hIuOZnvMcY48skOfussS8oTU31QZ09zEC/a+8Ko18gdNUzHrRC3u?=
 =?us-ascii?Q?joZc/C8TH+qnpUCC9bSAvO3mUfauZdjTlzJaRfJjBBeIaT4str/R2ewKsvuL?=
 =?us-ascii?Q?4WekIY+3j7SBocg2/Y77+lhxapFsNf1ZZd/WjQZU2g0r2a8owHEZ6y7+wl1S?=
 =?us-ascii?Q?mugycaGGz5MapsOdp31KSD3H2mjVaQZWr626jCWyXm/po0dAx00Vxj/pr88L?=
 =?us-ascii?Q?5c+Vqvbihd63Az4m65Z69LuMgdVSsSJaJXy4Ax94Nz0Zt04U7WloVKK4GLyG?=
 =?us-ascii?Q?wTQmoKxmnGxgAHOGAurK047h4J1pGyoM/wcsGnOMrj1dbr6m73cKE2XHdzR3?=
 =?us-ascii?Q?1ZcckXpzpSBInxwThtc9LhG+x8KMZ1w6RQEDXd+iEtqPk1s9RHFqsrmL418t?=
 =?us-ascii?Q?ES2/Zwy/6TOICtybilLF1FCh2CQtfrHZlraNlHGd1wCwRSpk/2d1YFwGO+/+?=
 =?us-ascii?Q?loD4hY7tOmfycDxhcATaVHr3PSrdyhNl1FP1OGQbjMEDuhN7akSc75ijMo+e?=
 =?us-ascii?Q?LTiso/IsxecO3aZXm0fr4pbjrEpFJvcpP7J2h03owinkWBSY+6Vvze67Y5qv?=
 =?us-ascii?Q?+KAG7Vv7COPiz9+teZjvDHn470SJOGoY61N2XihC99+O10GcBhMpMgJfH16H?=
 =?us-ascii?Q?hX5tvxi2YEYUTkgjF+LMQm+fxuVGWYvcRLGeWyH9VawLbHmUL7gv6b1VVdG8?=
 =?us-ascii?Q?1Jd76kv9jLuWJj9flpL+ASByjNM4of79B7uI6keAMyICvFiL38YXtvjHPGNd?=
 =?us-ascii?Q?7b4pPELEfnxFE6U0fjT3/a6xz2ZdyX1JLYOVzKHH7gSFd6eb4VZ6sPvBuZKl?=
 =?us-ascii?Q?YxWFmcs6BMS7NEyxDvbu685Ix/eldiaDzN5HZpwm1e/2869caJaXUKamdPmS?=
 =?us-ascii?Q?bBzRxm/O1MSkyWsyKc6PVhARAPEVBEr5YoVWNnPt3LHDfqK3CKDYAPHOj/Xy?=
 =?us-ascii?Q?Nwlvc6EPU7ILyd4mmx1ELfhHuNta4e3TUjlTE8KlRoKmTuXbd0Md/A41pX4L?=
 =?us-ascii?Q?nA98B+Qn6BPoZddH46W+mUFmE/73bv6V9VkpEvIimZkIGl5ED4oicGt+Ywro?=
 =?us-ascii?Q?3LW5GOldTtEKnpabzBlRKZ79ErtJ2LGHflHKM+QVm58cNx1WaXlq1I34dgPK?=
 =?us-ascii?Q?eP9eMJYL7pgGfN/zEGY+WeexNjZF+AJVHWFBr4ESdmlina7hJKMehtwZSpI7?=
 =?us-ascii?Q?njPCO7w8bRvwGclH4yE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xwvXblyyNBF9mRtSuxkpBGYWSdxMUF/Dw7kV6IOrNe5o+jwybXm8Ng27xiA?=
 =?us-ascii?Q?4AgzAPC6AyYIbshc17Qa6LqRP4QBwEMESL8jF2ERevqNFLIM3rZzIdAfw972?=
 =?us-ascii?Q?BeazRDKd4tWCz+v3GYN39bYRmqmDKYIuWc45GgKJZuZSdNUCszzbdQdkHKzQ?=
 =?us-ascii?Q?m0cWHzifFbZON0bMazXjr/kANErvWCFlDrKbBjXgiqKLQgrpucpII/zuT5M5?=
 =?us-ascii?Q?NVhNNjajyiaHrg2WTsJezr3+LUbbxKl2H4m2ZxGenkpsI2Qt9p62xlZahqXq?=
 =?us-ascii?Q?iehZQEMsjvUfNWBaaPlTAfnTdtTvID1gN7+mXa2Vxc1VntIeMzGzu11G7851?=
 =?us-ascii?Q?DdXYGlI94lm1n2I4JVFO8B56rUes5lMV/Vqkb40XIMXJOIZmL31IG8WE44/Q?=
 =?us-ascii?Q?IE1DnuAAI4TUGwayg9882JhzJo+tS0v234YsYCWnYnMavYDU5oDMMncztiqT?=
 =?us-ascii?Q?ZxifSLc78bj0/gr7eWyTbOP01VBvcw4D2eKErnT7I+qCb4rAzp+JdhilTri7?=
 =?us-ascii?Q?4pIEN0ljcqXR3hBf1e7XvKTwHPqMXVpgZ3dEi9Ks6LUFTKvQ8ZF90ij1R3zu?=
 =?us-ascii?Q?BI/94hn5VeZQiYaHdV5rSFs6T73Xb9YtiX1jzIfCOJPOZjT+PlEVh56usGLo?=
 =?us-ascii?Q?NnTvXMW8S9LKBysRK9Z73SN8wntinpNRY6OQvoR8S3tVWS/v35UgbRCt48Ol?=
 =?us-ascii?Q?gBAqm2wZ32OC0S++9LTd01PusanbUnSUXLF2Pg1aRF4BTVamjYe4vjCTQOz2?=
 =?us-ascii?Q?4x/Hed/dGGa98pY5Em+faMeNFw403N0x54ZXkQXThV29jD5CCaWefUpuYDoA?=
 =?us-ascii?Q?900QUIV9PuJjDrdOeXEvGW51rEukVDkljXWrPw9UMOaiyg5bEd6JSjGHJDT3?=
 =?us-ascii?Q?PHDNuK1tSfgLvq2sPVYsRYHu5QAAat9K/1oCTYZ69odKswcBDZ0qBI2spG49?=
 =?us-ascii?Q?7mVMSXE91k5XriMi5LLw25NDAa4YkTi+ixImgXOPb8lN3S369Y9Bv2EQYWx1?=
 =?us-ascii?Q?ILSE+rzyi+uvx5VwMEdPKyHidDkeFcL7dTWMcbwJ+KlcRveqgJzYKGlN/miJ?=
 =?us-ascii?Q?+Ivwz71Q1l/EsAjN5r9Fm9GIe6GWDqrxalkivohn6I4ecO0jSSJED7aSDVY3?=
 =?us-ascii?Q?VbF4JSjC9NcgSrIaOCiCivxOCZQGESKsdTqGt2zVc+R/cldM+0FcjJDhqEez?=
 =?us-ascii?Q?56u53v7GM5x85HWuSHH3TM6WkvfmEQlkaAdlJ40wP2XXYdUJP1zg+aOOPf5R?=
 =?us-ascii?Q?o6BTRsJRoHV30BrMNe+kmoQJUz3CADfwAglCULACbRIkDja1n3NVlMm8g4Wm?=
 =?us-ascii?Q?RASW3sCnvP7Ee+Sdo9Ft5eH1vRSXoOqbkC2/DAaDRx3tgBbH84c6XS4kN1LP?=
 =?us-ascii?Q?wvMpd+kN+Z/D7PEcHvi7K9hnT81p/qhff3HRr2mktqilqjVeBvd3/lRuWHnD?=
 =?us-ascii?Q?UoOsZzAmrD8mcY/brUxeKEYhgSdFygtAvjXONMtPts8T2iOgyi29/+Bn0dWZ?=
 =?us-ascii?Q?lxa6vL49K00/QkmpvILdpfmwRw22XCM36UaIWm8Qd8Ud+ZrxA8ls3ZS8xPuo?=
 =?us-ascii?Q?sPltLGeETRsGCsy7+ky9cDG2r6fA3f5WDVbUwc3LOIyFOySvSDvyiqQDm34s?=
 =?us-ascii?Q?ECTogonBaQljvPUiTMaYauOJW0typCfWduf/omX25FIiUSOd8Y2ij351FDkM?=
 =?us-ascii?Q?iBrV567Jd4837OjeCTzpzQQw7FDWSXVHM9sibpiKuj3es5ZqsiLk+tniPAGN?=
 =?us-ascii?Q?IIHBVuseY23K2AgcF1y5eHB9PXw0LJ61DTp3nY0D3Z947CEXmgiW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e16a86-7325-4abf-7a8b-08de6def3e67
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 06:39:04.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUA9nrUWoeDkukmn7fTq6wSm+ATQ/EzYKz2Xt1sxpeRFs50c//pJzQLA0o15S2EId8j4eJDSvt64NMPPx7tPvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7477

pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
doorbell virq, which can trigger "Trying to free already-free IRQ"
warnings when the IRQ was never requested or when request_threaded_irq()
failed.

Move free_irq() out of pci_epf_test_doorbell_cleanup() and invoke it
only after a successful request, so that free_irq() is not called for
an unrequested IRQ.

Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0cb7af0919dc..12705858e502 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -715,7 +715,6 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epf *epf = epf_test->epf;
 
-	free_irq(epf->db_msg[0].virq, epf_test);
 	reg->doorbell_bar = cpu_to_le32(NO_BAR);
 
 	pci_epf_free_doorbell(epf);
@@ -759,7 +758,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 					 &epf_test->db_bar.phys_addr, &offset);
 
 	if (ret)
-		goto err_doorbell_cleanup;
+		goto err_free_irq;
 
 	reg->doorbell_offset = cpu_to_le32(offset);
 
@@ -769,12 +768,14 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 
 	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
 	if (ret)
-		goto err_doorbell_cleanup;
+		goto err_free_irq;
 
 	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
 	return;
 
+err_free_irq:
+	free_irq(epf->db_msg[0].virq, epf_test);
 err_doorbell_cleanup:
 	pci_epf_test_doorbell_cleanup(epf_test);
 set_status_err:
@@ -794,6 +795,7 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto set_status_err;
 
+	free_irq(epf->db_msg[0].virq, epf_test);
 	pci_epf_test_doorbell_cleanup(epf_test);
 
 	/*
-- 
2.51.0

