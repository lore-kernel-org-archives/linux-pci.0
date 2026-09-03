Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazolkn19012061.outbound.protection.outlook.com [52.103.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F238332F;
	Thu,  3 Sep 2026 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788407222; cv=fail; b=R70ZQfFwohlipW4rPfKaSWaHzNuGez/ae4CLptaJrGCbp5HLw09qfb0e+QV2WVlRbH9sexJUHss2z2f3sB9nINP0K2KFJYbIThIPErq8AKGsOj3l7IM6vEb+n6Bb5glBINcRvj/E9YCNEtLEUao48egzgni0tI2WWLZWsWxdhrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788407222; c=relaxed/simple;
	bh=yRDbJyeefe7/iD93mtDXQHAW3lA+eNtPFhIM991Q2to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ev0HWlMg2MgNnr6aSI5hHnuINMwK9G6MtJb2ImaV2o1r48CtJRLtLBITeU/LDOgJucHEJ2cEjlVTqubC0V0Vl4L0Ncq9hRnyh8RgwhJ1ocNcFx6IYZcHTdi1f6FgXBCwolDz5OH9oh+HB03dyFmrv0iXiGV7hWovARyLn79HZHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rpotDOFg; arc=fail smtp.client-ip=52.103.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rpotDOFg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWUdpExLGW4hs5hzMTtH85h/eAZW0gwaeo1C1AO/Va04EgvhX/w/fdWuquSTnoPZsU0l86hbo6WbwgKmCisnm/brxjvQ7G8UKLA81rsNLMC1+ZfCUv40DQhK4bUEu3iG77vrIaucjlU3nrgBjDIkqeuDZpO8B/2yE72DyOM9VQnr7nOd4AxdF0sVBrk/OprGAPeNmYEHco0gL0bK6L5iwmZn3eDHHbOQrEtAd/VIftwOftdAZWBj1yPtT07PTP+HQE4ja2WD/RKORG/b6vwOrNgtgopR9oy/d4ZrLBMKilXZq04Vfvz9hJKoyPd8wfSLlNoon4kEU6RmIe62SLOrZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gUtCQ7d5UcLEqnoI16Ce0rpCLOkPubzeHp2iexvqFE=;
 b=Ym80lvcrVbFESSmUS5Mmk0aI+sX/go80A7oQCwYwvfKt15vDaMJftSMK4TGn0azpBXuyA93Ax7XfiYjV+e+GeRtt/ycSaFQxc+8MjsPQTTFFatpj0v3ng8+Tcc924/jUBJnhCaKlwVz7U9mPK+n8MZuMjY6lJ0RF8eLoS3tJSXrhSSKFG805RCMlRiQ51H34s7K3jo9fljVDBMLkSaez8nANaU0dtEOzse18WG4BsqGF+U+AsVodQVlUPAxEtde8m4ZnKgkRTUH4BVRQSyZuYyrnJFFZXmO1qvMv76LkX4YI29t0J+KM366tI/90dn1VuUc4jWjLDPwOjHVWDJC02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gUtCQ7d5UcLEqnoI16Ce0rpCLOkPubzeHp2iexvqFE=;
 b=rpotDOFgSpbdnoFox28kO/u+YxnsvoK+d2+u1Q8kGaXOdggcgfHUGlButbZCxSgE10ZoLJGomK2L4zS3WH28uqvw4EyhiKXiJ+KRcUuhU8iOO13d3gXMAQ/zb4HsKGOH57vZHQ8x02AcpxJJ7wBX5PioIkobfsYvGro6A1g5YFDuajDZ0EwbZ6LfcQhDe98g9SqTm74hXebsRLd5vsR1nVhkWW3V2W8ypWfwfLr9KGsidaPyaMlxXhnxwOsymZAmImhvyh088zRVQmXqv4246uhdrZ5fHzXnVRYJ0CLvHPtX+1h4dYo45k3RZ3KOHwJ+RdFwSEtZZqHohbDPlIAGSQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB4278.apcprd01.prod.exchangelabs.com
 (2603:1096:101:41::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 03:46:52 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 03:46:51 +0000
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
Subject: [PATCH v9 4/6] PCI: Refactor disable_acs_redir and config_acs param handling
Date: Thu,  3 Sep 2026 11:46:16 +0800
Message-ID:
 <SI2PR01MB439380682B8703CB5340AD59DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0092.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::7)
 To SI2PR01MB4393.apcprd01.prod.exchangelabs.com (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260903034618.1100387-5-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a96ba09-7e46-4050-01ad-08df096dfcf4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|37011999003|23021999003|15080799012|16051099003|45011099003|41001999006|51005399006|25010399006|19110799012|8060799015|5072599009|2607281247196008|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/pIKYnTbtWmh5tQhO4Gkl0j/bG02xgoFbZ3bSy8A4bHmSdOqo5YutVqoUYk?=
 =?us-ascii?Q?3fKhjIaon9GZ68Sh82PNETN4a4Wt1bgf+vG5jhnMjVCt3A/hYFgcnUblJHUd?=
 =?us-ascii?Q?V9ACcuNKla7OFrxyVU7UxOlOez3d3vjXIk4fjIwabkdpDsEjjeJ7n6KIB4Yh?=
 =?us-ascii?Q?KVxkpikHJUE6Kgj1jPGD1hVgQ1a0mZW2tz+DxOeb5LtMGaofnCdR91wPAqgg?=
 =?us-ascii?Q?mBoKbaa1LNvLZrMHUFhvKhKHfFkUKNLKY428OUG4rWh+cJRSBVojZeW6Gxsf?=
 =?us-ascii?Q?ORlvuO02mDS3aAgjmylMIBzVWukz/FXW6tCro44XoTzlBmsxSojPTg4ou+WN?=
 =?us-ascii?Q?JfQwd11JXOZG71AYuomRq/5JzGdcB4iA4b6NUXuv7GN2ja3C1iiF31kKmMrn?=
 =?us-ascii?Q?VhW6FyJyLRISbCvQHKfBp/9x7B2rP3lPKyupWnvbM/VjHa9YLuW0DpRLXfc/?=
 =?us-ascii?Q?lvMF/tLUuXZQ7eA7nJZGGb+yfdHOeyk3Gsjz1H80Wq7NBARLQyJWNWeA5DBE?=
 =?us-ascii?Q?mZicDpR6BnYdKxRzHOrK5LhmdU1DOFNFpdSu2z5JzN5ezSjyNS+oq+rlrI1v?=
 =?us-ascii?Q?UxsY9hWgh97fi7/NLRelAPNnGLXiwEyuMYq89pKfCnY/PFSBPHHPLrhAMANc?=
 =?us-ascii?Q?6dyePkvRpYtS1wF5KoOXbwIEpoPDSxO/vWsI1tQDHSNlEdLpd/SCQ0adbk3g?=
 =?us-ascii?Q?IXCfv/vdWWq3aJpTNH6QLqeJCcK2xbuh+Bo3wQZjyFGlxUbU61kyr1zjdF/7?=
 =?us-ascii?Q?mffCR8StspflXtqTmAlTZkW+2kgF9kostUOKY8ddv1cqPWZLYo41b8L0IolV?=
 =?us-ascii?Q?JuX5KGUSa5oZoJLnSxofydlwKgeZGrjtRtyyaobgzTE7g9S751KHK9z4smmg?=
 =?us-ascii?Q?MS0LAkLFBmPH22MMl34FML/eMCMRCU9TaKz/c6suuwsbOiKe8HCgiypuMs2D?=
 =?us-ascii?Q?1uKQrd2VAIp9dv1aWhGiVsL5N7TDPjxGyrx28u5P9Erms0QkrDtS1mah+kJv?=
 =?us-ascii?Q?AWa+GYfZXM5S41ivc4ZiN8mMYE0khD6IDs9thxrs9czhQUfoTWCxKzf1xvcx?=
 =?us-ascii?Q?cMsxyXUjrB0Hg5ETITIpXuBYJFxWhg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8zab3USVzivmH7ApZ23JrWA1dwIeoctsgd4m15k13AjqJH48Z9ed61iwPRLq?=
 =?us-ascii?Q?C0yAdgehYrlelHDnCLT+z+K2aqYVTfydzMAFX0mGzO8wpqCcebgCleGUXEK/?=
 =?us-ascii?Q?NlCAFlKo3dzTR8YhSUN8AyJljvDpWw4RPdJor8lFJkwhmcfiL7osXDmNadZm?=
 =?us-ascii?Q?k+KexKLh+pvHnMNXT2C+wLHJYAXh461QS9RFLwN7wgBfMctG977raqRYEgoh?=
 =?us-ascii?Q?cSiMQEz0vnZKi0z9dL1IjUXNQXpZS6FMjNa9BQWnciMADgA/dkcYPcZVUK2+?=
 =?us-ascii?Q?+vtTwfT8MpTMXYCPWR3yJH7wnOd8HeEm9FaFyyP3Ofesk5dyAc2aZFmnwQ7O?=
 =?us-ascii?Q?GWDDBBWxyVV8imYzaf/8QF6cdmLH+EvS3knifBjgTNiobxu39yWcASkLgtpZ?=
 =?us-ascii?Q?w5ceLirk5I0Rz7zNhz1VnfowYFb4a9ucXy1JegfQWSV8iv5G4uhTmCo1oZtV?=
 =?us-ascii?Q?svW7cUeKH9Sz3t/i04mMAng3BgQa4K7HrFBPAtViX+LhXj4dfsTjLFcHNoYd?=
 =?us-ascii?Q?m+lj8D9wcBbRXp0QtxxNXNHgkhh9OwXayXtzihQNIxSVcvXUQBBa7idXbtBx?=
 =?us-ascii?Q?39UaTiEU3tzLr4+KZGfLn7GuOi7/jh4cBCCUHAu67arYnja72hK+mUcyQK2q?=
 =?us-ascii?Q?jbRQVXKLwVvr0HQtEgH+c9i22DWoYus+rNnYqHNni8mGzeEV3s/sEfTFRdRw?=
 =?us-ascii?Q?tC/r9UztLfCyOlc/O9lwqF3tlUfVLGxPN8a41vX8O4K0PbctNZROQNYd77qo?=
 =?us-ascii?Q?jfM++FRa2EoV3pExFjXp/HUBL5lQJrskUFPlOUul6zjyRtWRyjENDZ4plWrs?=
 =?us-ascii?Q?+V06W8dCn/gnJQDamMgyRO0HxyCugUmwVU1DNv8fjI9OKdi1/EeNzEWA9GM8?=
 =?us-ascii?Q?+/ijlai/PwNc1fsDf6kDbJrWlX3cgAvI9KBqzuHI6wAs1jA+DeZMICvLsoU4?=
 =?us-ascii?Q?LgMsdoCfeB3g0acx4InXQoiVigKu9iKoGphn8lE9ZMVQlRes1S366M/M0iXp?=
 =?us-ascii?Q?ttnjG99RyE22YGsPVTWeWks6eorN1zC+4UlZnvqN600SVEV/YkmWCUJFt5wF?=
 =?us-ascii?Q?dHLbDl2I+ddn4+PgAkdsBkWmuyGbqZZiA6Ga6xOTFWA3mYdwCWvyidrTewBX?=
 =?us-ascii?Q?7LdkrrGpffxpY0SKHSHdV/5yit/Oanulc1UJLyhRwOWqo8W01JLl/CWEqllP?=
 =?us-ascii?Q?evHkIK2hYdNekkVtoad4o68ljuNfIoW86ChvfQ9AT3c7jp/drUeOHoufyXmd?=
 =?us-ascii?Q?88h+4Sux/hOU67gFg1hiMWW0GVfHm6nUXvNQssZGs5IsDYGSiI0kEYEUeTUm?=
 =?us-ascii?Q?iz4P0Qhj6ykPnJbQl+vyNMv2rMzkERISgsSoyTt7RAmHyoHGFCE6ksR/h8Eh?=
 =?us-ascii?Q?rRtUKJWxLfsdAomSYZ6Q85rBoodp?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a96ba09-7e46-4050-01ad-08df096dfcf4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 03:46:51.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4278

The current implementation mixes disable_acs_redir and config_acs param
processing inside __pci_config_acs(), using acs_mask==0 as an implicit
signal to switch into config_acs_param mode. The intertwined logic is
hard to follow and easy to break:

  - The acs_mask==0 special case is non-obvious and obscures which code
    paths apply to which parameter.
  - The interleaved logic is fragile; changes intended for one parameter
    can unintentionally affect the other. For example,
    pci_dev_specific_disable_acs_redir() is invoked on the common path
    even though it should apply only to disable_acs_redir.

Split the two behaviors into dedicated functions,
pci_param_disable_acs_redir() and pci_param_config_acs(), making the
control flow explicit and easier to maintain.

The new pci_param_config_acs() implementation also improves on the
original logic:

  - It searches for the matching device first and parses ACS flags only
    for the matched device, avoiding unnecessary work.
  - A switch statement replaces multiple if/else blocks, improving
    readability.
  - Variable names (enabled_bits, disabled_bits) more clearly express
    their roles compared to the previous mask/flags pair.
  - Error messages are clearer.

This refactor separates concerns, improves robustness, and makes future
extensions to ACS parameter handling safer and easier to review.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 180 +++++++++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 587c013f04db..6cffdbba99d3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -915,90 +915,121 @@ struct pci_acs {
 	u16 fw_ctrl;
 };
 
-static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, const u16 acs_mask, const u16 acs_flags)
+static bool pci_dev_match_disable_acs_redir(struct pci_dev *dev, const char *p)
 {
-	u16 valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
-	u16 flags = acs_flags;
-	u16 mask = acs_mask;
-	char *delimit;
 	int ret = 0;
 
-	if (!p)
-		return;
-
 	while (*p) {
-		if (!acs_mask) {
-			/* Check for ACS flags */
-			delimit = strstr(p, "@");
-			if (delimit) {
-				int end;
-				u32 shift = 0;
-
-				end = delimit - p - 1;
-				mask = 0;
-				flags = 0;
-
-				while (end > -1) {
-					if (*(p + end) == '0') {
-						mask |= 1 << shift;
-						shift++;
-						end--;
-					} else if (*(p + end) == '1') {
-						mask |= 1 << shift;
-						flags |= 1 << shift;
-						shift++;
-						end--;
-					} else if ((*(p + end) == 'x') || (*(p + end) == 'X')) {
-						shift++;
-						end--;
-					} else {
-						pci_err(dev, "Invalid ACS flags... Ignoring\n");
-						return;
-					}
-				}
-				p = delimit + 1;
-			} else {
-				pci_err(dev, "ACS Flags missing\n");
-				return;
-			}
-		}
-
 		ret = pci_dev_str_match(dev, p, &p);
-		if (ret < 0) {
-			pr_warn_once("PCI: Can't parse ACS command line parameter\n");
-			break;
-		} else if (ret == 1) {
-			/* Found a match */
+		if (ret == 1) {
+			return true;
+		} else if (ret < 0) {
+			pr_warn_once("PCI: Can't parse disable_acs_redir param\n");
 			break;
 		}
 	}
 
-	if (ret != 1)
+	return false;
+}
+
+static void pci_param_disable_acs_redir(struct pci_dev *dev,
+					struct pci_acs *caps)
+{
+	const u16 acs_redir_mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
+
+	if (!disable_acs_redir_param ||
+	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
+	    !pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	if (!pci_dev_specific_disable_acs_redir(dev))
-		return;
+	caps->ctrl = caps->fw_ctrl & ~acs_redir_mask;
+}
 
-	if (!acs_mask && (mask & ~valid_ctrl)) {
-		pci_dbg(dev, "Ignoring unsupported ACS bits: %#06x\n",
-			mask & ~valid_ctrl);
-		mask &= valid_ctrl;
-		flags &= valid_ctrl;
-	}
-
-	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
-	pci_dbg(dev, "ACS flags = %#06x\n", flags);
-	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
-	pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
+static const char *pci_dev_match_config_acs(struct pci_dev *dev, const char *p)
+{
+	const char *seg;
+	int ret;
 
 	/*
-	 * For mask bits that are 0, copy them from the firmware setting
-	 * and apply flags for all the mask bits that are 1.
+	 * Example: 11101010x@0000:01:00.0;101x@0000:02:00.0;1@0000:03:00.0
+	 * Three segments delimited via ';'. @seg always points to the start
+	 * of a segment and p advances to the start of the device id (BDF)
+	 * after '@'. Upon match, return the start of the matching segment.
 	 */
-	caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);
+	while (*p) {
+		seg = p;
+		p = strchr(seg, '@');
+		/* If malformed string, stop parsing. */
+		if (!p) {
+			pci_err(dev, "ACS Flags missing\n");
+			break;
+		}
 
-	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
+		p++;
+		/* pci_dev_str_match() updates p to the next segment. */
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret == 1)
+			return seg;
+
+		if (ret < 0) {
+			pr_warn_once("PCI: Can't parse config_acs param\n");
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
+{
+	u16 shift = 0, valid_ctrl = dev->acs_capabilities & GENMASK_U16(6, 0);
+	u16 invalid_bits, enabled_bits = 0, disabled_bits = 0;
+	const char *p, *seg;
+
+	if (!config_acs_param || !valid_ctrl)
+		return;
+
+	seg = pci_dev_match_config_acs(dev, config_acs_param);
+	if (!seg)
+		return;
+
+	p = strchr(seg, '@');
+	/* Parse bitstring backwards from '@' */
+	while (p > seg) {
+		if (shift >= 16) {
+			pci_err(dev, "ACS bitstring exceeds 16 bits\n");
+			return;
+		}
+		switch (*--p) {
+		case '1':
+			enabled_bits |= BIT(shift);
+			break;
+		case '0':
+			disabled_bits |= BIT(shift);
+			break;
+		case 'x':
+		case 'X':
+			/* Skip this bit */
+			break;
+		default:
+			pci_err(dev, "Invalid ACS flag character '%c'\n", *p);
+			return;
+		}
+		shift++;
+	}
+
+	invalid_bits = (enabled_bits | disabled_bits) & ~valid_ctrl;
+	if (invalid_bits) {
+		pci_dbg(dev, "Ignoring unsupported ACS bits: %#06x\n",
+			invalid_bits);
+		enabled_bits &= valid_ctrl;
+		disabled_bits &= valid_ctrl;
+	}
+
+	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
+		enabled_bits, disabled_bits);
+
+	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
 }
 
 /**
@@ -1033,6 +1064,7 @@ void pci_enable_acs(struct pci_dev *dev)
 {
 	struct pci_acs caps;
 	bool enable_acs = false;
+	u16 kernel_default_ctrl;
 	int pos;
 
 	/* If an iommu is present we start with kernel default caps */
@@ -1051,14 +1083,18 @@ void pci_enable_acs(struct pci_dev *dev)
 	if (enable_acs)
 		pci_std_enable_acs(dev, &caps);
 
+	kernel_default_ctrl = caps.ctrl;
+
 	/*
 	 * Always apply caps from the command line, even if there is no iommu.
 	 * Trust that the admin has a reason to change the ACS settings.
 	 */
-	__pci_config_acs(dev, &caps, disable_acs_redir_param,
-			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
-			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
-	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
+	pci_param_disable_acs_redir(dev, &caps);
+	pci_param_config_acs(dev, &caps);
+
+	if (caps.ctrl != kernel_default_ctrl)
+		pci_info(dev, "User configured ACS to %#06x (default: %#06x)\n",
+			 caps.ctrl, kernel_default_ctrl);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
-- 
2.51.0

