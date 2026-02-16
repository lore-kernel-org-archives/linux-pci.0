Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013076.outbound.protection.outlook.com [52.103.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353029B200;
	Mon, 16 Feb 2026 02:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771208838; cv=fail; b=B8mqTCUvJnk4N+VIrKFULjkzJQlTM1fBEm73HFzr75Z5wTktb7NSWL5rkfgMa/r81IlCVnSDEAWwcS8QO2ltkjoxMZeswBPmI8PoREHJ6swsRlC7ifVn4PFvxzUxJ3H44GNXTux6+JKkaNWbDhk3KLwklVRHrMdb38S8nubXFIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771208838; c=relaxed/simple;
	bh=kT9yFDJOJyXT6zUhr9HidIqrgt7TjIjp8JhXPtsJ6d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tGdxknXqa/mVVWUyczNx8PmJGdSv0OEONUXoLqx6AzFRJkTNh1CH1N491PHOR7rM7a6wFJpZ215s7OFIoRYQHymKU/biklaxI+HaX+C7KB7BIMBbVG4+GmLQP2jfAuRyNik6ep2D/xLghCXOFcXgaaonx70MK4VbKL3GRdAoL4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=m981DtoW; arc=fail smtp.client-ip=52.103.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="m981DtoW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBhj7IN4BuSbGTlmrh8r7jiyIsrqpG7LczB4D+5JPBw59jYSD9HDq273t0hw6howXajXraCabBn0lO236u2lrzL0DiKdep3eVOOsKJyeb0zRCr+BhZxBaq0S/oth5Qgv2QAlaOcGzWi5uiTzZSoU9nBqjIlmgdPCIiEaQHDDaAlT8SGL4O9Ano1gHArgXXZcDyrGYkiw1Ngc+x4CzoJsM1sCgXTSgqJ6/94m22mePRr/vOPIHU4AffCcBnsJcy4Mr4KmMLS2u3e+bfWu6UtKqeyxoo3+XlXbw57CbCnXi2e6WVHm2R2yXoKsRwNOZXYS43Klw6AcKENnP0vUe/U4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwpgY6vCpECJEC/Nr5qPH+gD53c7iC8KMzAvdM2a2vU=;
 b=bETLIqZYGR5ZfBy4avHNgXomhHaeoxAGKkaq2mwKSXZDbzamicP/wa0FYSIfpdiufbYw+WgMVi6zvLy+KBEJd65mKtGLwtbuWrgDfzh9jvl83KaVfs5eeI23tLTH5GbR4AH8ot8zd2dDBmAz4xwRW6h+Ag7PAxEDAMEoGvmAREJ1jE03b8HAjBBqJEbQ+g7E8Ku3BndULpCnT7FD7Y3ilmkgfD+C48Db+LW5tR6jPdFjwh5N/36j5a9/zoO+KdVLdZSS74FjYGWSpg76WoUgto7RhPcwbKIs1D75E8RHBCWR0uvkCovij6VizgTijZ/YZteaRBHaPbim0X1opKG76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwpgY6vCpECJEC/Nr5qPH+gD53c7iC8KMzAvdM2a2vU=;
 b=m981DtoWN9fBuxt8hsgy0lGrO+U98z9FVb9zCEO0GBDg5Ee1yKkJL4BABIOz5Ouvj3pIuoSxA6BKcQHPeUSLnRJ4LtOWl+MpnJMcXBmcjt0LjASpoa24Wfg+dJqJnLWOnFKygV+rCKZj07fPbjPBe8oXRLyDzz6xauNwvwlGMXKUJa/D6tqhxVG4XdFPyk92zuDX5POQ/JGUr7hRxulBvb6nO5VV+/dJahV0k6o62psIRdHR9C6TButL29tbtxEi2hwsDLsaGyouyhWinCNvniw+2XPFvrR+/kEqP2vezKjbhcdjvdW8pxGPCCPDsODjYJzdipNTOlY9piZwTT5Erg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEL0PF89D6F6B8B.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::5b3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:27:13 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 02:27:13 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v5 1/6] PCI: Validate ACS enable flags against device-specific ACS capabilities
Date: Mon, 16 Feb 2026 10:26:37 +0800
Message-ID:
 <SI2PR01MB43935B55263CD29E5B125212DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260216022642.112923-2-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEL0PF89D6F6B8B:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f9b80d-f674-4b69-88ab-08de6d02e4d4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|19110799012|23021999003|41001999006|8060799015|461199028|5072599009|37102599003|51005399006|12121999013|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ddeA7yzPsM1pjCNcatKao08hvY0ckZu6ctp/rflGH0Riwo9V+SDiDrISSJJ?=
 =?us-ascii?Q?XCMJQ6G+S4kgcE2Yh6dkFlOtFARAnASQdZmaOWc5oOJ2F3sRIHKi8ykPcHK+?=
 =?us-ascii?Q?lPxve9rLO7mvf6zW2G8ZTpnOAuFVPBcvih4rAD+bjq9t7hdDuN/laxmFqSXi?=
 =?us-ascii?Q?UJTZvVuvESn6LxH2tXGDMEzoJuFHQJuZ5/S1w5Y9l+hhTgkpBHT2TuzKvXOp?=
 =?us-ascii?Q?vaDYCF1QbWvu1dGXC4U+KZ4PTxFAHr5PMTFR2fkkdP4ByM75pTzFmOxTagnC?=
 =?us-ascii?Q?xztFB4/9SJ4vWwGYf+ARBRRJsO50UQOHXxs2Veny8q1dJ9A9V2GfS0VSvpV8?=
 =?us-ascii?Q?p7lk3AahpUBMlTpcdmgkvUhQdMipbv1j7XbRs1m+fWP8PGSDsDD8Q6b81enl?=
 =?us-ascii?Q?u7R8c6Uxr7ZDMuabaWmi12dSMQF2VqusdWa/AKfa7nGpp09uuk5iM+eryY7G?=
 =?us-ascii?Q?MOvErSr/dl7ab+2mz2GkX6OGiQLE3u5tPR3J92NgvbsCn0G8GfcwaUiczfog?=
 =?us-ascii?Q?31SzwDd7QF/WVLRYuiRDhzgmmQ2tvDaamg/btxR80BzixNtAiS9ATmKRZZzK?=
 =?us-ascii?Q?tbQgrll0VC8TxHAwo+suavy6oO609sd+aKbVAAU1h2mOyAZ1T26Q9RMJ/UFR?=
 =?us-ascii?Q?gkEqrSD0nym3+Ez7UVPs/L5yrPMHEzeQcCaiLoFlljwdVk/Fy+XbCDT8PkmE?=
 =?us-ascii?Q?UtDSWl6BSQXb+aGOmwDtXytNWPWZpvUuFc89m/nqcm+wq8rilDHcFFYfQgTH?=
 =?us-ascii?Q?7u3rou/TtOwZLDohYDl/mK6gicKVq41OhVZ7dylPNG6exlmQ6kIKHwcpX6X8?=
 =?us-ascii?Q?dpHliE06LSVjDebvfU8aeU35oKYDgEk2hwW/HKAdvOyS68XqeNEwDNAlPauu?=
 =?us-ascii?Q?uT0EO87qFvsZxhGIl5/OUFL9Mhqa8tO6+sBSUccilr4xjC76BYuhmFlM/Gpv?=
 =?us-ascii?Q?DJYOjNnTt+ZdmEzNSiOI06T0oi86Q15ipP+z6ih6PTCzWqqdUZ3Ko+1iMrMM?=
 =?us-ascii?Q?Wkcou5W43BkiheTcQ11HRm0hjLS8s0rXPu0E+s0tyKhoW+iwvk/3dRqEoNgZ?=
 =?us-ascii?Q?so3h932Ceku0db8F3zAjjfx9hyjl7fFbYzFThYA1+gUOhi/a3v5xevNYwxhD?=
 =?us-ascii?Q?IFrfzC3+lMFD8ZIrqWHBvUIytH1jR6+HAxI8yvvSA07qkUOn9w3SDk9RVr44?=
 =?us-ascii?Q?5uCTvTZDhfoqDIuVm46iVZCD4MEcc52rJkoVV7BQp+RIUSoFJ8tPz/TyRnF8?=
 =?us-ascii?Q?rbqLCLGNCR2eNsUFGUaq6Yt/tPl9q+lUkqLLyjdwYKiCkFM8OSQu+zfEs6hs?=
 =?us-ascii?Q?5z0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xoph/QwSOFAIsmTeFEkWd/R526Pcv6Rr2cPPmZtS5tytjSz2XybLYZUPrwmy?=
 =?us-ascii?Q?O/aolz90qr6Gu+8EeslhMu2mZ0lus5+w/FeHTHtcPtMgN/Yf8FZnzLBXZRyK?=
 =?us-ascii?Q?kSapRivN0uxA2AmvUXv4QVSt26SIxTY8RsSeOo59pKSwa4QlcPXH2yUlkA0j?=
 =?us-ascii?Q?I/kP5b2QUR4Fp/zSrY18pBUlEhElUAABdbXAJACgX+75mewW+lqZ/Jkoc1A7?=
 =?us-ascii?Q?leSLM8mH77jVOzBtoe0Yv7k4ZnXM27u8EwiWB5yt0CmHq+5LzA+2/vj4Ndc2?=
 =?us-ascii?Q?KB3zlKdy3Bc+2IzOJt1Egs1CCxa6uGu9Yi7qpjVDKw0slYyL0QHCO04/EaW4?=
 =?us-ascii?Q?Ey8ljtSSXYe/HsXmsy6+ZqA0T4cwPUKYglpOPIeH8m05R+D0k7gI1RpMp4+l?=
 =?us-ascii?Q?toSd/aa9f70Mu0pFBv7VuV6AmhfIBUu7q5a6czfn2Y/nSVdXRE0rYhTP/iMe?=
 =?us-ascii?Q?UkPDFtnHk/0z0UPVSge6/hxdDHiha+/HxcpZvpvXFMbA8oR0kbngq0BmrlVr?=
 =?us-ascii?Q?TubI8i6GQuaUBojfOqazVIh3+oXJO1xmHbHPe+T9uf+P1AvuqXRWfalomOTn?=
 =?us-ascii?Q?A5ZGXwqhnsMI0d/tlO0zs50tpnb6Xobq0RK2dRWqCEGwTCowkUjwDKOd+3wY?=
 =?us-ascii?Q?SkBOniMfM4BscsOsrjsRh8dMI0qxCeVuZvzeehg1AetJkRDlkZJy7SHmR9P2?=
 =?us-ascii?Q?AuYYDzBp4DRNCOdZuWXwOPeImcI2Zl92MJKKqxUZpZBE2aK/dlnaxy5yMLbV?=
 =?us-ascii?Q?FvR9I6ffNof/QNrJZlGrradz2oOTSuYJtfxW+xoCplDLWSTBMRi2omau5dRs?=
 =?us-ascii?Q?H6YvaE4Nj2A0+LVKYbDCbORDXedHP9fj+DxDCsrA6/8LWKWiA/ZTTWnBqM51?=
 =?us-ascii?Q?uqCTgt7TKWn8rk5dXAmgGPROfJVli/79mWQbtCO6hHJDeQslN+wO46xi2BuI?=
 =?us-ascii?Q?H+U7EhbJIDJsuMeS5692+8JYVaclVCi9nWMBqpVRn0ClDGq2L9Xxu8uaCm9Q?=
 =?us-ascii?Q?6VPeGyKzpWUe7pjify+bBfxHYztZhdfaf5HutoJgr6wHxgosZfLYLzwk6LSX?=
 =?us-ascii?Q?aWdEXUB+8oX4FWUlSrl7ewhbqmTUErRo4zfA+XyL5BBnXiw8vBtoV970Ialb?=
 =?us-ascii?Q?hfGbIHw145Z7i8u9AoPsmHnMHi926upPVGukdR1n467SEHX3+1OBQRoysCzA?=
 =?us-ascii?Q?y53KbMrY8La3MyNNnwAi+34LaJMp+11MqNPztJ+BQDwUvfc839EonIooBMbN?=
 =?us-ascii?Q?IvrUw3ii2e5Oio3QLb04ItrWgmPKpwnMsI0WM625fd+QEt8heCbq8V3g1K2I?=
 =?us-ascii?Q?Edcn53AN8hm220RgAJMasNkNuIdZs4mBeJ+4kEcAF/TbBJAyN6+XLOpqF3KT?=
 =?us-ascii?Q?IMSCJv9qyaipTCV27NLVFFla/Ji6?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f9b80d-f674-4b69-88ab-08de6d02e4d4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:27:13.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF89D6F6B8B

The ACS flag validation used the kernel's full set of ACS control bits,
which allowed users to request ACS features that the device does not
support. These unsupported bits would be silently ignored by hardware.
Validate the requested enable flags against dev->acs_capabilities so
that only device-supported ACS bits are accepted. Accordingly, move the
check after the device is matched, since the enable bits apply only to
the matched device.

Also change the validation to apply only to bits being enabled, since
attempting to disable unsupported features does not cause functional
issues.

Finally, improve the error message to report which invalid bits were
requested.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3244630bfd0..8973658441ec 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -941,12 +941,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
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
 			pr_info_once("PCI: Can't parse ACS command line parameter\n");
@@ -969,6 +963,12 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
+	if (flags & ~dev->acs_capabilities) {
+		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
+			(u16)(flags & ~dev->acs_capabilities));
+		return;
+	}
+
 	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
 	pci_dbg(dev, "ACS flags = %#06x\n", flags);
 	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-- 
2.51.0

