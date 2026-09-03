Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012050.outbound.protection.outlook.com [52.103.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E12378D9A;
	Thu,  3 Sep 2026 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407207; cv=fail; b=iCChP1qu+aS6LXWM1cv1DnuCerwk6Kg5tl5HyWPiVyo1NOkwvb4+cEBIaR+hzaRdSwQ1tvgm1wm1SoMTPthaLUyK6EWFypFyIsCJGt6UyJtrqPAWuis+DCBQ/s9r1xTkOCc0uZgwY85cOLsz2aSvi2KNxVMbpmCNkVACdG018ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407207; c=relaxed/simple;
	bh=JDDFczWJp8fbnXznPIN1e/zAMpoVUHPbsrIcwqPl+kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTqgnnMggRRfFELwNyzy0NT8HwrZzBueH72kJjvgQuSeClpXp5Y1uYtVB1Cmk0hVbs+gvj67EptawhekqRJzLTw6kHH+6Eus5YbHgrgPt7uKvpIA2/fhXxFuJ/sPpuACg5PffDx7uMxkm3cVd5pT3aCLEm/FGYde+knyrEGVF7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=GH7Qcf+4; arc=fail smtp.client-ip=52.103.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GH7Qcf+4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msmHL0kvIO028v+spR1ZyFNCZ54lsB64k4TAspZLbVmJE3V+f7LuyhbD2yOD+g+LRfEkWnNjTHzalL8jnvlCIGzo9sUZOuFtYbuEjny3YyzM+2BLt6wDdrc9GkthrNPD2Y3wz7v4OfIPubvXlbR9KRiZ7nOxb6hejgQk0Gv07NCPL9iN2dImwoNSO82UdqzyMdM2J0bJffoUTev0QoCwzwanla0WoFEMJveIURYFWYtFy3BCUN23Vn4PFSgFPLp/fJgerKTh4JgTe+4XNIm+yC8mbVqirHlL3eUXmxEalQApl70ylhJ9MUOIJ3gg/glg69PlAepKJPuXFyh+V9/Miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDbQ/BvaT2PEnHisP8URCkNlCYTW+I11iByFkNTKVWo=;
 b=C4iLTO9LCikX6zR7JF4pk3om3mRDg2WFqW2mpajqlRXMmHUT6srTKHCtKPe1ZHmjqdNSPWLZOA16uiXnPREur+qWggBkfIQipJRQVFsjcWEG/8bd24i8oj+JmaEuxHga+MPe845FnkAEp9aT1REdsVZMswDKElCCtC7AOLBy27S8Q+NjHxjq08D3H+xTD6MS4CxBL/DOBhA6gaE5zhRlZsBdyqDdCn70T4MgYsT5jnAO8qQJiMzDQo0IrJedFD0CdTB2k9bpv5huVp0DAqhpkRXaoIAmrMCi/lzFLHjdXTCub9tRqgTdW/2SCvZUtMCYcXcTnVfkBZLQcSqcNYUF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDbQ/BvaT2PEnHisP8URCkNlCYTW+I11iByFkNTKVWo=;
 b=GH7Qcf+4DL3gXSd4ZlV/vHnTmfMyF/D52aKuf+ThKv4tbW/Y3zA46gNRaAqOhSwlJf1lGeHTuihQIkmXr7UX9Z3nPjJwRC966dWkVBCXz1UluA5m488sV/45b4YyViOXnKCfRpKcWcAcpxast/8wkzsmMXAXhtdnDUl1xG2ZeC7/J36C73zA8FA8QFmvvZyxfsMQJIopxxCD+6NE2Z1vyJe19Ol3XeCq5/z7JgN1B72ap9GUGpq3WLkfA0n5K+Afdu2MrEdyCmODrAZFf7Te2YHTW0SBz5fjiAAEaoiVm7JboOk8+96x7ixwO2B/AHlAesjJPfgIH9Vf2IBPzVOy1Q==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4733.apcprd01.prod.exchangelabs.com
 (2603:1096:101:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 03:46:40 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:46:39 +0000
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
Subject: [PATCH v9 1/6] PCI: Validate ACS control bits against device-specific ACS capabilities
Date: Thu,  3 Sep 2026 11:46:13 +0800
Message-ID:
 <SI2PR01MB43931558B27C956BDBDCE0C6DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0092.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::7)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260903034618.1100387-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: b78fa96c-6562-4f99-e0ce-08df096df5c3
X-MS-Exchange-SLBlob-MailProps:
	Vs63Iqe4sQkGaLwEdeYxLY7yqos8lGqVCgqhJdHRvWEQLxVWzvFE6oneVu+wfb+G77HKluBt+vggnmnNknUknQ70MbuSPvdcRxFlww0+ybCbz4h5u1jV0DgeAT8sSL+SmtO6N77+UR7OG0yWAGtpX7XXn+wRSPBMkwaL/pktZ0tx1oNEAUSH3otvwIaYRYmTCnUnkQ3de2us8JkU7t81EKfSn9U3GQWJGXT3Lgw0zfN8EN7a1M71WxucY2ik2SxUWyFcfyfl2QIR1E4IjKbW4MGV7nts6KSxlyFO2kp3i4UzYjlABiUDRyTHaaMmILmP2e5+DnGy+QAxMVViwnv4Mf8yEfzIIEVWYd7TZneoFrVeLw0rooO/YmpqhfBoljDgbYA/czd71Bt2BnNNpZdcpGvMrUa3fbWNz/V6Dv85Ch/iuED1GMz+0G4Gp7In9Ee1vTAqsJU90OPrkgJBb/tbA9O4j2etIKlRSweRRrBnkjkkWaSdgw4nYFi8L+0/kB8vM82mM26SxuQfhBwBJ3ArZQ/4Y0G9WMaPAKtaprvF6iX+UartJKcevr0e9CWnSvbq73Eai2RQTzxV5i5sZoyBB/tFRXrdL9Wkma1T0mGKbOJ+ncUPZt3yL8q+YkYTl3S42xgdY6cpc1l+370BKLhbm4c5eRjUGjIzVwhG9+UB/nwNh55QOhV7bzzBN6ZXlRdPsRBW/DsIEfvhtPvxWMRUI/xB6MEMtZ73M8goZJPL7tI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|41001999006|5072599009|19110799012|25010399006|23021999003|8060799015|37011999003|45011099003|15080799012|51005399006|440099028|3412199025|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IiN60/NkYQdRfOjlun0VMR5NPyZC0fMI3Hf/VY1yxLfTTE24xT5sKbOozYgn?=
 =?us-ascii?Q?R4Aqg6ltLDLhmJEZBUplA+gfvGmvSuHaNgPHu/WzlJEPduIznzJk6lh5kSbI?=
 =?us-ascii?Q?+Qmhl+NjRRrNcXHrtSYb9wXz8rsxEFaOGtYc2xMtld5HhFz5+Eycy9QX1xSg?=
 =?us-ascii?Q?2mV+E3xNUXQ8I/QwCMAdEEhVJZdUefUiVUypcTakqua+zwyEJobRa5ki+tpZ?=
 =?us-ascii?Q?heBHtUbnrEmT0nV8V3de43VVvWacgHdZGyMnK3Gwk6MF52SvANw8LDT/90kp?=
 =?us-ascii?Q?v5Nk677yCcTl3XH/2ncW2ujt0VbQMfs5k/LSLafZFEeSB9YMEdoUjDBaza/p?=
 =?us-ascii?Q?P04d568u8IXiX4UWLyoDFunGZsx/ICGbvSYQA1DhIAfvmtNGEmAaWFYc7Q07?=
 =?us-ascii?Q?FSm4ig6Zx8wtrA/6QUSt2LCUrE3zF+QVmwwg+7tgxqScJqVj41SuF9uQo/E9?=
 =?us-ascii?Q?VPsetnnRH34QVLLAPG/cetHtJTu+fVGHPZnq99f1AZUGmZt0tbzBzwIHGTke?=
 =?us-ascii?Q?wFakgmLuJ2EmIbZlS+EBPmGT2gx48UvjUR4Yz7NZIeZsQ+nCbmEM/0HJpry6?=
 =?us-ascii?Q?fTcFfyltgyo4/Y87B87qPbSvZEQM/Qow71JmO7+xEhRqv2GlIy5J+l25ZSEe?=
 =?us-ascii?Q?qpNrzpvYDoVM6cbhX1W3MFvlKwxDLamxDViXOfzFw2mOyR5RKVWewCW1RHnY?=
 =?us-ascii?Q?E6R8Un0JmMMdmUQZ2KApBGgjgshkQM+n2GjEy5uDXoOhITS2I9rT7J+10RIH?=
 =?us-ascii?Q?R8eqAhcIuaE0ivSJlClmYP11keJiCl/lNJEr1D911/9KpnBrDuup4x/nkoAj?=
 =?us-ascii?Q?W3rpBDgO9OvIJy12qz6wai6R/a20o1SrkfjehDQvx2tX/eE9+xllFNBkiY3v?=
 =?us-ascii?Q?2GYiOreNo0o+EWHNwN6746sGh3hf1a99Rz1z7kYYZ1Wghm3sOdqQn9GP/uCk?=
 =?us-ascii?Q?fukSnr0kGRzyb+FRa+LXFCnS8ZgbJoH8h/N1l6IAgCGeLH0e+jwrQZW0FWS9?=
 =?us-ascii?Q?eXohAJAFZgi7aqhOVbvXxczkRCtvNWUHazTv4V2CzD31AbNBTOSjilyaP6xb?=
 =?us-ascii?Q?UmvveBq2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fXgB7de/cy3UYh/WCEjJF+wEi8g8YGiXnpfNCv9P6UeM1BZVbh0EWr+3WKzC?=
 =?us-ascii?Q?xpCNV33qgn8qJ00UHv27Qo2/if8vj1qhb2ACYcLEz9vajRUsj6GmMFw0Zl91?=
 =?us-ascii?Q?D5Dy07aQ63FrcU3I3ypkaOJozbrlm6xi7rca4g4n8lkUyqxiuAdTEQhm3HlS?=
 =?us-ascii?Q?dluGCsfYuX0kgZlPKHGXeE0PnMbY1x3nlKJMNUbhwji1K4K9aYtZ00f1DePz?=
 =?us-ascii?Q?aijjeDKktuChnE+/1YPMkJc+hHAYCKB6V9Pj9t/8w722CrRJS+X77AYe26ob?=
 =?us-ascii?Q?Xr3mPB6u8S4SxLqGZux/xxnvDrsOrkpUaCvsp5Wo0yAdlLxyB7bzGwKOwFFc?=
 =?us-ascii?Q?KGCpHDIGqDsCwKAKOiPZQHhP/M0pny31VmpDsi1axRdTu64pbdZtvbgy8VYr?=
 =?us-ascii?Q?8WFbOldJmmH6GRx6iHpc/dn7kZo1ZiQg51cwcGJrhoMeCOgDZJEWp4TrG7ws?=
 =?us-ascii?Q?uX0WkouNLa2fLl2pQz6B1JXhDPteJMZIU4/NnYziXMcLDe8DL6nxRiDWgT9z?=
 =?us-ascii?Q?TpI0y+LfWLDw5gLkbL3v5+riv17WDqujdXOiswCFBDqNjW07yBzFkbTUenMP?=
 =?us-ascii?Q?6/Mk1AxlQ7W57o0QKHS5INrpTvtrhVJKA2KYViXazTwaCjh2PFU1B0tiFljm?=
 =?us-ascii?Q?FKp3TniavwOJRjENvtHSlCNEIGvzeKy/8f4JAq02JVEA677sDPXjLFbJ1NOi?=
 =?us-ascii?Q?ZsCT6ayrecmW6oXtL7qEYegcljvihgmMPKVkzDT4p8N8oP8JQB1gK43FM41r?=
 =?us-ascii?Q?pY2CeWxYcIu9llcttPHxy66993UIH7/U0WX1D4aw8gRLp7DDdQnrRovwkfgl?=
 =?us-ascii?Q?6fpoFAqZyRdCzg2f9nEwAYZvMcTANbTQJbUSEcLAsOUTeDd4hrIYLN86njbB?=
 =?us-ascii?Q?XwQIfeLCt5huSpr3Ao9fwD0CQL/EB/UQY8Cr5nmsAfqBl8/sRfjqyxcUXLJK?=
 =?us-ascii?Q?ZRtlNx8Z3lKCDsRbIiRWWMbxU6APiyGEUHhZPqP5qLyTpt9BrFBeObpjxAQL?=
 =?us-ascii?Q?XZpyO/NuFXSXB2f71UzArrarq0rAFWGkDjB7ukldQTe56dItCuaoMIsOGyb0?=
 =?us-ascii?Q?chJqH3VRBWWSpWwN11SpBZ6KPsjmzKbBC4j/hcEyNALWMnemd+ZTsHmqEDM3?=
 =?us-ascii?Q?TVyAbasugCmQF9yxo7PE2531kM7zghhX/8gzxC2d0ByuofPqNiIqT3iOMqWC?=
 =?us-ascii?Q?aVZRMVEqJ4vB3n2GAmQ1dzBuELDx28PZn+YlPssN4OlWyJSiymPBiyWVi/zc?=
 =?us-ascii?Q?fKsghrYMuIMGO8q2M8LV1+FAHFGXpLI29jgxK13SVtx9pgm15PY0SqVVHJeA?=
 =?us-ascii?Q?EoiI7tavs7IbMVOypxDilQCmk7UaIp0KXziLVLTXpvx4KzitEqJpijbxt6Br?=
 =?us-ascii?Q?yHxSUEA4D1so2EjPJiNb7YW7dnQi?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b78fa96c-6562-4f99-e0ce-08df096df5c3
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:46:39.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4733

The ACS control validation used the kernel's full set of ACS control bits,
which allowed users to request ACS features that the device does not
support. Because hardware silently ignores these unsupported bits, users
have no indication that their config_acs= request was partially
ineffective.

Validate the requested ACS control bits against dev->acs_capabilities so
that only device-supported ACS controls are accepted. Mask the capability
with GENMASK_U16(6, 0) to select only the currently defined ACS control
bits (0-6). Higher bits in the capability structure (e.g. the egress
control vector size in bits 8-15) do not correspond to control bits in
the ACS control register. Add a debug message to report which unsupported
bits were ignored.

__pci_config_acs() is also called from disable_acs_redir_param(), which
passes a hardcoded acs_mask (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC) that
does not need validation. Gate the new check on !acs_mask so it only
fires for the config_acs_param path, which always invokes
__pci_config_acs() with acs_mask == 0 and builds the actual mask from
user input.

Also move the check after the device is matched, since the ctrl bits apply
only to the matched device.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..2af679111a9b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -910,6 +910,7 @@ struct pci_acs {
 static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 			     const char *p, const u16 acs_mask, const u16 acs_flags)
 {
+	u16 valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
 	u16 flags = acs_flags;
 	u16 mask = acs_mask;
 	char *delimit;
@@ -955,12 +956,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
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
@@ -983,6 +978,13 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
+	if (!acs_mask && (mask & ~valid_ctrl)) {
+		pci_dbg(dev, "Ignoring unsupported ACS bits: %#06x\n",
+			mask & ~valid_ctrl);
+		mask &= valid_ctrl;
+		flags &= valid_ctrl;
+	}
+
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
 	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-- 
2.51.0

