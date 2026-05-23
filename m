Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012062.outbound.protection.outlook.com [52.103.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C8383993;
	Mon, 25 May 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716594; cv=fail; b=feKokAAoLIq+ItCEzxi0rMbALjQ3xwHQAi8zBjw4JtfPWNIfmcTQqdq32wxzdUPGWXCcBdbKbhs35Var4XAwau2EKxJP9kjkwocoL7fPd3zTpX7JrHcccgrbJAfDugWZaWu70t/PFylL+VBbQ5jszDkqY29tEvO1Ndq52M2RUts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716594; c=relaxed/simple;
	bh=8H6RkZdYtdqF8bAsirIBAEdoGa6QfZy6qOf72BACXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQRF3pPqmgCZtV/j2o02Rxwd3thkhY0ecVLLTuJU6qJ6vTkj6LH8xQK7SJv/Rq5VQYxCZwWGtz4r29I5SFA5W1ulaS2fjqwRoUBFFXNJr/10HicJPBcRWji6H+gdjGthHHH/pyBajYL1qqobeZC7qVfCReaCo2dunbFTn53+avs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=lxBHE4I7; arc=fail smtp.client-ip=52.103.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="lxBHE4I7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtZCqkqLIJusUFGR/WVJluWjVq/J8EfE+m/KlfiV7ltI28NCKC49HMn5Izul4U/3/J9gbV3ODUz3XqjG+4ECsY8vKz+Bb55GCB8r38ll1XYRVT+RBnQMnjDP64oHYt5pYXAbtc49CmOLBnosg4YR2VEyeEwqmSvy4LaN7xzoqzckp7E/5hNOLEGsdKCplgi1DV7jjsZ9clrPWW4knKd0xhRWYVbLYRRsiwCCiCZTRBP4HfDZnINAs8SpL2ZS9AAdc6IWc73kMxSpNxWp2DSDdP9Y1uaw43GhQjOJtiX5+WnCgJerzD4TRrklwx+Z5xutT3bwx1XVz9JussjbqqVMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5Q5c2RIUR63I6nu0wwI1qH7DrGFvdnMhmzPQ9boA00=;
 b=D3l1GC9tXWFLGMBqkvL0iGEG1VLvBCJRWrwx726oib3K9ncsaq6jRwR8edhJ4AP+5jN8jNOxTHMUDaWfWnUwi1wlFoFoyh6QuXe64MjhHsfmndxGl/72zndU1sQJrCjU2HM4Fag/VPFByRjZyWEJdvVVP6bsoUDo1nlNv8VrX0a6Y0qslu17Iu7hFN3TP3z4LgfQyyM9/htEtytDxMJZKMY3zRAuikQK+fpG1EQiaawfV3R2x1elGrd0fKEb1UoQ/Dz0wI17pZfu4be8XC3nzxjRuZTG4r+MTriz/bM4Sxg0cle4IwIpauHq0XsKe8VSZLlqWaD7H4xGmRVtouRbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5Q5c2RIUR63I6nu0wwI1qH7DrGFvdnMhmzPQ9boA00=;
 b=lxBHE4I7RE4Xn0d01PBfdFVU+OPDAP8OS/BF/O5tVAY/4klg0QyDaI18bPt4iDnHGMZgOR403KIMPIhO3K0HpGyAiC1cV9H2d+CGnUpAOoa7NjGMUuT/nKNpRWJcLuAGjDLt3sGE39BhQbmFr1UkW4bOUxA8Es6PRDMuKq477pI7SmH2jL+Fr55ZouVX/eMEcIw/k8wfPQAEo97WWQJ5LhEoPx6KxNB71ZtjAreXlrZDy1I2y88tND/ezR+qziJk41MdgeelSD7IcKVvDkYp3bI/zKZW621WnhKzwF9iLWa/Qs3irqoamz0vwbiToJ+32M83gl5f5A5sLMbrmnC26A==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5718.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:43:08 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:43:08 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v8 1/6] PCI: Validate ACS enable flags against device-specific ACS capabilities
Date: Sat, 23 May 2026 22:01:38 +0800
Message-ID:
 <SI2PR01MB43932642FC4DD3D075983B1FDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779442182.git.wei.w.wang@hotmail.com>
References: <cover.1779442182.git.wei.w.wang@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <40cfc10eb2b020f96df8fbe58e2d35dcb88c5d86.1779442182.git.wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dba96bc-9702-4089-10f2-08deba638ded
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|55001999006|45011099003|37011999003|51005399006|12121999013|41001999006|5072599009|15080799012|8060799015|19110799012|23021999003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u48HU4gsdyfxuuJ5zomPQOH8HMAwhJqA78scw+6vKcySGRs6YDEL2fPSsUVo?=
 =?us-ascii?Q?F8HN4nD/NIrtNUCtXtI1j/cQKrHCrxGg6WttzCb52xUY4NUo/WhM8IhL2sbN?=
 =?us-ascii?Q?DEMZCp3yg3WS03YSKOC6XoC2Jr6Fqmi0aWmN4BTKZAU7dbD/cz9xJLqdZzik?=
 =?us-ascii?Q?QL7XgSe1lHNoWiE3ksBZ8ta4ujX74qQpHCbHF9i9Qkc/H9Pa3vYPSYKMWFHx?=
 =?us-ascii?Q?XN31stWwkZy0d15bmh3Jy8mG8xLjt19jHb6kV5lETVML+xDaYQnrn6Q7inpk?=
 =?us-ascii?Q?E6eBgU0DtKFSTT/OusRJSeZxvF6nNvWBrUxBZ1Yx4s2DueUjocbJr/PGsfdz?=
 =?us-ascii?Q?fhv70NusQ0rjhZo+THvt9//5/64Zsm1HuerE5tnhukO4ZJSHpQFAxyE0nB1U?=
 =?us-ascii?Q?I3pQumy6l1R+05CuU1HyALDkOLNtkrkcIOqmQ6/7PLSPTXp1E1Amh99KuisZ?=
 =?us-ascii?Q?Uaw09SfgOys2OdaSdA+BkX600AoxBftNZCQFEfNpf5QHDqkbvuNAnRvlerEZ?=
 =?us-ascii?Q?STmX/rerwyt1Ie8Qe0ppCnQRwYpUmrmn7cy8DCpyv05eoZKUe0qb/kP6Tc29?=
 =?us-ascii?Q?VvVRWrRdaooFasddLNagcUz25kuw3eb1TnClj7K+sS53QXJ9GmAkiO2G6nrF?=
 =?us-ascii?Q?obpBhBAnDtR3mnrb3gza9RSLZ/mw0u4mEOavT5y9v5C+xEtg1njPhOFHj2N8?=
 =?us-ascii?Q?74CXfJCpsmkxfbhkA1um6OH9Y8StU1GPmszIIgRIf4LdhVmKzZBqv+s7e4SR?=
 =?us-ascii?Q?VRp66mQo5tIFSVhHEZ5oZOa1DPb1UrDeiOrRSDofLuB//lR3TDYjbmfu/ZmH?=
 =?us-ascii?Q?/4UfObd5/+RBGeDTfFFaj7/mfy2PpnfNve4Xyr3VYai62V8Upio7akwcSJQD?=
 =?us-ascii?Q?irbpcg9lDmgg8rewlOGjfI1T0oSZeZcTFR8fynFyJGvNVaUo8VuInbi3cl0/?=
 =?us-ascii?Q?En6NfueJP9JvAlwcAl8vJMBq+SZQDzNvXGMNCLVSmuRymW2yPsg79jXh0fdT?=
 =?us-ascii?Q?KUlG80Wen9J/R+X8TFW4g5ExvTcjjlwB9acKWdqblY8kulRZGHZHw1e086vY?=
 =?us-ascii?Q?xN6A9DbaqOv3JuGyO6Utztd82sZpe/KZiORW3Y6+DRVeiRqZPzaB5ZVXuEzC?=
 =?us-ascii?Q?7MK8gHO1FYkk?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iAdV+YBIS/YiY3Qq7BYoFP+LFLIi+kvlPE2f68C2q8BuG5oYfCqQrsOLGdbL?=
 =?us-ascii?Q?K+FL1kgf5Ms5giDmZz5f6finh9r4fJMfGGONpnFIsPSu5gjMLQ56qwtSUPHa?=
 =?us-ascii?Q?lompdDwD86p5SnRcSNZc2bGo19tNHwxnmBuXJDOFZFC2gedh9z721U/hQlda?=
 =?us-ascii?Q?JWO5Y/3btzXAQSFntIgJcaUF53PdTkiDjWsS5z3Sie/L/xYZYbNcNliDN3Z7?=
 =?us-ascii?Q?STplIqhnJ/xBWdzrl3Q9Jw0s/VXOwgpiMB+x+qXjEDiosSqOd/Ylag+Yn1nV?=
 =?us-ascii?Q?LIOn1YRw7huZmHWqq614fwCrJTJRrRUztfH2ctU/Aehd8AmJofxmcouSs0rn?=
 =?us-ascii?Q?QSfXFwdmNY0uaelH2IAIoJZb0y4j2TglfhHeN9xCt+4kdDd8dhGneadN1PVi?=
 =?us-ascii?Q?vlNLH+HRwiN46u8LRf8OmmEo8AQigLwkyEXzMMprHIMmVYnAW715pANn6fsH?=
 =?us-ascii?Q?fOBp0mZGFvSxit/WVJtB/0J5f0WpRSU3+B68TiUE3/qBmYkOrM0BTC6I315b?=
 =?us-ascii?Q?7DQuhtACPuLCv3m55x5d1dEegixZPrBiUt4e9WwXDxKqCrry1PbwmpEnQkSR?=
 =?us-ascii?Q?L58cRNPqWjckxm6+cg0RQjymTAslsQMX2Ag7mpWH4bV5roRGXyxXBmcT+/k+?=
 =?us-ascii?Q?vSuZgwIHG+zZPaeoUVdY8EtVr5V0BRNMUJ0qJFk80K/aBenROhcS3eyDyvxH?=
 =?us-ascii?Q?Q2VIN9/xl+FhHxM6pKxz5botPNikcXxYuFJwvh0RXxNaceAejECaN3i2nhDY?=
 =?us-ascii?Q?TAIIptiYb3TWYmGlLIeRGJ9L1SCNy+xqXFuftZQeiy+97RJiYam2wQEzKQp4?=
 =?us-ascii?Q?C4f1r3j1+sDHbkaJmvUDNs8JSd+mJbKJvRnuELPWNL6Z1JAl8DbPMN3TKC6W?=
 =?us-ascii?Q?5QN2dTztBjXSp3QItu/tQ96+3bomaYDE5DyFBt+1dEdv60fY7wHNM04uEmba?=
 =?us-ascii?Q?x2XKP3ESm+Cbi8wYS0j8O/pI1AILFsx4pKFQWIJjIjUv/2gNXeF5Qot26Jtd?=
 =?us-ascii?Q?0GC/XVQqzF4AS921dSSaKxyPgm/pd7ndjDxnbKgJpivudhdvmUjDHjBsJ+tW?=
 =?us-ascii?Q?4cSVTC2lv4j0ZzgoPrHqgWVx8/oXwZOYNDkwTdWn5AaEYAXPMUTnLkQUjEfn?=
 =?us-ascii?Q?z4xAoz6opVg9XOin7ms4qkmc9jxI3T5Ljlk//sLM/RYkZDmzi80cRrptMKQD?=
 =?us-ascii?Q?Jx35Lsqiry6W1lYVlAgwHXZwiW23PmIl5x+mdmqbVSciykXHXC7IaffdPd0f?=
 =?us-ascii?Q?eARlUXciypqIPzQI5U+i/ZDQglhXWeyrgSL6n6wuj6LS7Px+U2yuViEcv5kA?=
 =?us-ascii?Q?M15Vdacpr6Kdx9o8j5ffB2OsSifzLhsgUvaiNg/vcQv1iEbWRGjXkidgJH6b?=
 =?us-ascii?Q?aG/8mhrtJ4WqSGU75GFlRR5doHN+?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dba96bc-9702-4089-10f2-08deba638ded
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:43:08.5297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5718

The ACS flag validation used the kernel's full set of ACS control bits,
which allowed users to request ACS features that the device does not
support. These unsupported bits would be silently ignored by hardware.

Validate the requested ACS enable bits against dev->acs_capabilities so
that only device-supported ACS controls are accepted. Mask the capability
with GENMASK_U16(6, 0) to select only the currently defined ACS control
bits (0-6); higher bits in the capability structure (e.g. the egress
control vector size in bits 8-15) do not correspond to control bits in
the ACS control register.

__pci_config_acs() is also called from disable_acs_redir_param(), which
passes a hardcoded acs_mask (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC) that
does not need validation. Gate the new check on !acs_mask so it only
fires for the config_acs_param path, which always invokes
__pci_config_acs() with acs_mask == 0 and builds the actual mask from
user input.

Also move the check after the device is matched, since the ctrl bits apply
only to the matched device.

Finally, improve the error message to report which invalid bits were
requested.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e305dbec39a5..ff7e1cbd6595 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -886,6 +886,7 @@ struct pci_acs {
 static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 			     const char *p, const u16 acs_mask, const u16 acs_flags)
 {
+	u16 valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
 	u16 flags = acs_flags;
 	u16 mask = acs_mask;
 	char *delimit;
@@ -931,12 +932,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 			}
 		}
 
-		if (mask & ~(PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
-			    PCI_ACS_UF | PCI_ACS_EC | PCI_ACS_DT)) {
-			pci_err(dev, "Invalid ACS flags specified\n");
-			return;
-		}
-
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret < 0) {
 			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
@@ -959,6 +954,12 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
+	if (!acs_mask && (mask & ~valid_ctrl)) {
+		pci_err(dev, "Invalid ACS bits specified: %#06x\n",
+			mask & ~valid_ctrl);
+		return;
+	}
+
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
 	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-- 
2.51.0

