Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012053.outbound.protection.outlook.com [52.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A66385519;
	Mon, 25 May 2026 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716600; cv=fail; b=CF7DG1ZCR9IqH3KYh4Cnd4bgpZOYSZ/ZygPaqBBLUB5nIoLgKr6RFUfz8NqRil4aaODe3Wz7xWG+GroREQK4GzwehQiBqzTJ3aV1/FlZXoXTgUM5RiOTpFNTTa7exdBnXiFqbBV24DIMWmUJTuH9zDGJy6vp31rWMPKfavQyUL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716600; c=relaxed/simple;
	bh=K3IgvbqL9vS41NaLeoHALtAKI9BtnmA1ZjZS/k00uf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f4TUBFVOf9UfGYvr6/B16yYXKNfGoETkmY2iV1wlc3ZSAWVonnK4w/cVf7cuu89i1VfG1mGIc4S+48pxqOkU3+1t/dD69nLyl2Ly/CuFfNfLOrmmxLceDaGVC+uvFPvwY/oPiCY7cig2S81d5X0UO68gHq330iIWrA9FRWLBr+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=nGw0upSq; arc=fail smtp.client-ip=52.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nGw0upSq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jdlyc5bTx2MIjLbiVQnPXK7uHIqtv5WqTiXkPr/NFC+P/lD6uFvOlRQHUTVPWIetwnaA0c9R+ALVeY3+u1OezsA5Kgy5bdtNF8BN1bTit4SUdpUuGLNc5eiVixJQGCEP9tQOhf9k4rxvtZtfS+THGZxaG/s+/HKEvF8Ksrqze/pAbsQsmdclzJIbb9S6siznxOgmJC4/6lnD0e0/EwatyfUpga0yzOVLfO2kAuuubBBFd/PqiUghpfeCzWKLDXrMe/eQD358slEVnEp0jSNJSzeC51dpPfyTvtZ3NfX4u/+f4qJZj31SfTy+/XHtC6Lqi3SiNkYdOBlxmtSUUpu1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UQAvoGHe6Shn2+5VvvziPbiLjQCV3OqpfxVsvd7bZg=;
 b=CjARzJkYzhOQAHcbrkrU44sS6DSm2U+O3WpNBdh2HEombF26D1QyCUFvOhhwhrawgGtDsrSG3wq6AIWsJfr+Hk3jysNSm+ms5lxF1JmXJekf2eqwQMUez58ErTJlCWruK6kp16KLV0pjxFzDhC/K5HM01niix61+ZomhJjcAhENek0GzZ1L3NCM3bl4iEA95g4tG3VGayDRuNRcW2KR8zUoo+Jf6m94egPxjNDEVCMhnv1njUfb3WTqHVvZK90DGw9hw9zxEzuIaRyGEcTpk/AzwGRJjmh7s0HZwQjeDWMpI5Wi+0u4QshoqlNBi5mzywecfyrghZ/FVEZPHbWRLsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UQAvoGHe6Shn2+5VvvziPbiLjQCV3OqpfxVsvd7bZg=;
 b=nGw0upSq8c+nTA60EkY0bCIBFWB+eYPGiCJCCgeswHJpMPu91s6jLp7YzSZxtPsXzpVNUc077EfAZNCEly91VWdIUGAiO0E4h7OMMLVCZrTNzRF3kGkDGdgLdwUqJ177st+dXT+vE9HE+9LdT84cbggOmZ1rbKQU/TcoZJxQDVNyfuZ+al+QJupU7MuRUA/xAz7MwGnkkNVncO2AYbzgZFp154Te79ZSrutdEy3W3na90vMy69A6DC5BbWYvKiiqW7IQuV/se4+3tGKHga8AGOq2juxQDq/cImtMnSJ+MK/FgPYakJP2r56rjGvkt+++s6JhEv2HSULjj3U/N9+HBQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5718.apcprd01.prod.exchangelabs.com
 (2603:1096:101:1ae::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:43:14 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:43:14 +0000
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
Subject: [PATCH v8 3/6] PCI: Consolidate delimiter handling into pci_dev_str_match()
Date: Sat, 23 May 2026 22:01:40 +0800
Message-ID:
 <SI2PR01MB4393C2C65FB9EF8916B9DF4EDC0A2@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779442182.git.wei.w.wang@hotmail.com>
References: <cover.1779442182.git.wei.w.wang@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::16) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <6336890a7d480a5833b48fe60fe2ad70d10d7f6f.1779442182.git.wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 95343231-556f-4cd0-33e1-08deba63914a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7042599007|55001999006|45011099003|37011999003|51005399006|41001999006|5072599009|15080799012|8060799015|19110799012|23021999003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wy+pwZkaOKNxLLSgLE+G98BK5573egfBCJOl6ekX9fUKizVbpfb1NGKgaHoE?=
 =?us-ascii?Q?h+tWkVe/+EQQv6mUN/RuzMAumCIjwPReqqNiGWMjfhX6Z+pyzLg2IdquK7JA?=
 =?us-ascii?Q?zsWnnRUvz6ImrfkeYbP1qY64vX+Yqj+a567oLigdta4R3IPHFFB0CIe9dZsN?=
 =?us-ascii?Q?wbF3oTzFW+4MmOWB+N9xgfIhyo6/4EMxAYqQSXW3Gv1IXNZCXr8oDu45bTMF?=
 =?us-ascii?Q?JE4blN+GAfCM2qNFPIzXewv0E7+6lwa9iMRKeC0aAKsZb46N5bLchmNk64UM?=
 =?us-ascii?Q?znEDtR3vS9Yw2L3uewFvLU6APDMCcAw5p3H7QOR5P0p/tgdeOhTzDMfnRyso?=
 =?us-ascii?Q?UlLF9fyBAtALj/jvHL0IjrBP3TbYWvvntcLtG5bhIgYMWyqHuksrIhgyerq9?=
 =?us-ascii?Q?8LXv0UKEcCbqmbKU9klGnFWCr4G9rJqfHOJ0SORUQU4Jr255Ac6XfdqkSVIK?=
 =?us-ascii?Q?Mqb8158SXvk+XdHctLGuYiCVgAw/E0L8DcZnBmUpgZh57ZlYMOx39l9w/iCu?=
 =?us-ascii?Q?j1r8dhk+tPpLPlM1o5zcFph5HD+ruJyjkAVrtdJU/lkbVGvhXAEZ8OwRxWMz?=
 =?us-ascii?Q?n5RU8MIzUZNEH5C086UmAPWu7TmaTXYO8itZphjI3fyzScsBdsnjUhFxGqlS?=
 =?us-ascii?Q?4qA/aQ5p+r+9v3Dm050sXwKiMT+BKfpApKDuYEsYiWI6rfjUnyDBUyGKZWml?=
 =?us-ascii?Q?hJ7RRsZHGbRA3sh+8dujBhRdY/9UzO0TcrXvKf0KHws6Upp3pVaMrdduT4Ob?=
 =?us-ascii?Q?ekkdlVNeTCm34AqQUk7JgQnMXqvVdDhDGp6ss61thEiIOh0r3sqHJ1Jmc+zz?=
 =?us-ascii?Q?Aow9qggQBnfHD/dvh9BUWD92Ujko2xYfPYoOCLCMGevVs5n3KG5S/WWevftJ?=
 =?us-ascii?Q?APP2zWdWguCfxlGvwV3S8in8bTDd+GycJ5m4ShyhUV8Jb96S/AdP8XM7/e5I?=
 =?us-ascii?Q?sN3F+bCmNij505vPGdf5FU0a67SKrHsb5Wbhhhh3W2LkCXAsYAw5w3swBrwl?=
 =?us-ascii?Q?DVD1f/ROi+uMpLzaUJ69FcbRhq6Pm39Omb7AFWA6ffYHXv/5be24qCxP39p7?=
 =?us-ascii?Q?+Gi8HMJHk7hBGKDzxn0mjNQQJIr8dw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NY4K4eVhHmud/TrO1HBsmYRqTGsqufNNkVgOi6Hk9J4NyIDKkwIDojWz3xm0?=
 =?us-ascii?Q?ULbuwppOJaF+KhwYO2gKGtEjHnibaJfDw18+hjnrzxHaO1DsIc3zU/JdvI01?=
 =?us-ascii?Q?UnsUlGZNNq+CCgrXofHYNbGepRTJA0lt71ibVMCD9QzzUjLQRqqmTwP94fvt?=
 =?us-ascii?Q?FXjIrHhc+VrSFyLN96KVQwBlbwLNuBPqP8929L6/XXDEOYiDSYNfwOUxs1PH?=
 =?us-ascii?Q?HDwsyEkQEiYDehhIwT5qQcQ7KXv0BCJMFzjZ6J2vGXG4kiOhciKOHkZROhsa?=
 =?us-ascii?Q?oJPWl4CDu8VOuU4Vm+M7r6xnASgo6lQnDPlACJCOQhYAznas9TZS9eU+XPzJ?=
 =?us-ascii?Q?T3v4lYTiqa5LFMEOa+uMycAWU5ydylYfpfeBZKv9gQhb6IQHXO6H15HiMc/N?=
 =?us-ascii?Q?403bHGtG3saBjvmfsg2oE8gDlsZgB5DsGKRxsnciA9zH04ZuJz9cc93OYzoP?=
 =?us-ascii?Q?+QAlnLoHnRoKE/mHZqiegaQuk30uUNSe2DKCqUFA0IEKHRgpDn2Y5HunN2mE?=
 =?us-ascii?Q?IjExwgW5r6woG0VoMDPSuNkpysvE9DU/DBffxWmDeTtTQ/a9YuWd2SPU2iSl?=
 =?us-ascii?Q?0anxCPVbQAE/oxRARCRw1QOBoHoaKPDCNzFfWwZSkzjEvJYEupzS/IxVgu6v?=
 =?us-ascii?Q?UR0/3ybDvuhF38GfGM/yxGxbkuS9H/h+OXgoT9LM6CfhOkVWiZyCjwJlBVja?=
 =?us-ascii?Q?eEPq8M+osoqm494ymJHqrMfL16H33CzSKaQN+5ayaHXNfA8ktPXfL1DDwnPK?=
 =?us-ascii?Q?rE4/yStdZujPBBbUnj99hnAm4SVCy2eCnsqsZzb3ot6dBdKL60sib4QukE/W?=
 =?us-ascii?Q?BswXQq2GILujfBo2Q4u7BPOKkXgvLCr8EfhgP97uB21LOJFmASaKoO2OjjQs?=
 =?us-ascii?Q?u/FoNNVmksHvRu55rLXEagqNuOaTx7dVQ8I+P0D9JXggBL3EyebGev7CRn+8?=
 =?us-ascii?Q?2QaNET7/sdrj/YCVIpDSPLWdrqwO1W3zt680YWaueYooHFEXOMDFtLPf+w03?=
 =?us-ascii?Q?lxedJJxwZnGdDwiLIeAeMPYL8emCV7CCXX2/lQXS4KQD6O0VWpBAlGjoY9iX?=
 =?us-ascii?Q?dR0J6hZYiT95rWwldUi3USH8156AexJs80SLT7aiJbf/1lYoS8sfBveXoFTk?=
 =?us-ascii?Q?YCrgdsTfQ4li9LBZzXJ36Xh/voBE+ItKYowM6C1n9kIh1p9Uq6UAFKy+sIkN?=
 =?us-ascii?Q?0x2z3uxNLvYTa492xpygA82dHVU5h5fmX57/JZOdZhBtt0y4NlLW6gGaAAcO?=
 =?us-ascii?Q?lFQ0qzcdEboJzViRhIC0u2PZiLsU9WVtdodLtq5buCON1ZL9tMZe+JI5Po0j?=
 =?us-ascii?Q?dLMwA5+E46rumzLXOkOyhpWaXZat4nCa4TvkyzTYZMRmujaox0OoXvf6cKqO?=
 =?us-ascii?Q?L2lZZXiy3mYI0u/MK3NZm0ytGt68?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 95343231-556f-4cd0-33e1-08deba63914a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:43:14.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5718

Callers of pci_dev_str_match() manually checked for the ';' or ','
delimiter and advanced the parameter pointer past it. Move this common
logic into pci_dev_str_match() so callers no longer need to duplicate it.

As a side effect of this consolidation, pci_dev_str_match() now enforces
stricter boundary checks on successful matches. Previously, if a user
provided a malformed parameter with garbage characters appended to a
valid BDF (e.g., "pci=config_acs=110x@0000:04:00.0foo"), the callers
would silently accept the prefix match and ignore the trailing garbage.
Now, pci_dev_str_match() strictly verifies that the matched token is
immediately followed by a valid delimiter (';', ',') or the null
terminator ('\0'), returning -EINVAL if it encounters invalid trailing
characters.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/pci/pci.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ff7e1cbd6595..e9d39dbb117e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -334,7 +334,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * pci_dev_str_match - test if a string matches a device
  * @dev: the PCI device to test
  * @p: string to match the device against
- * @endptr: pointer to the string after the match
+ * @endptr: pointer to the string after the match, with the delimiter skipped
  *
  * Test if a string (typically from a kernel parameter) matches a specified
  * PCI device. The string may be of one of the following formats:
@@ -388,8 +388,13 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		    (!subsystem_vendor ||
 			    subsystem_vendor == dev->subsystem_vendor) &&
 		    (!subsystem_device ||
-			    subsystem_device == dev->subsystem_device))
-			goto found;
+			    subsystem_device == dev->subsystem_device)) {
+			ret = 1;
+			goto out;
+		}
+
+		/* No matching string found */
+		ret = 0;
 	} else {
 		/*
 		 * PCI Bus, Device, Function IDs are specified
@@ -399,15 +404,18 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		if (ret < 0)
 			return ret;
 		else if (ret)
-			goto found;
+			goto out;
 	}
+out:
+	/*
+	 * Whether we matched (ret == 1) or didn't (ret == 0),
+	 * ensure the token ends with a valid boundary.
+	 */
+	if (*p != '\0' && *p != ';' && *p != ',')
+		return -EINVAL;
 
-	*endptr = p;
-	return 0;
-
-found:
-	*endptr = p;
-	return 1;
+	*endptr = *p == '\0' ? p : p + 1;
+	return ret;
 }
 
 static u8 __pci_find_next_cap(struct pci_bus *bus, unsigned int devfn,
@@ -940,12 +948,6 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 			/* Found a match */
 			break;
 		}
-
-		if (*p != ';' && *p != ',') {
-			/* End of param or invalid format */
-			break;
-		}
-		p++;
 	}
 
 	if (ret != 1)
@@ -6398,12 +6400,6 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 			       p);
 			break;
 		}
-
-		if (*p != ';' && *p != ',') {
-			/* End of param or invalid format */
-			break;
-		}
-		p++;
 	}
 out:
 	spin_unlock(&resource_alignment_lock);
-- 
2.51.0

