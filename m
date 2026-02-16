Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013073.outbound.protection.outlook.com [52.103.43.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20152C11DB;
	Mon, 16 Feb 2026 02:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771208844; cv=fail; b=RnyUOO7jWv5oMm5L62HqDHK86s602EG8lZNvnGJDJ7g/qeHLKglXe69h+NLqk+Ij4UWKwxobwmDy4MyIYlnbHP+KK+s90N2c/01Muvnscy37ijnhvo1Pe1f0DWAQMfx4WcntRnTdxOAePrEBc4OuexpcvLuH375wlI74XNKk4Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771208844; c=relaxed/simple;
	bh=xHEqKoLZ/zSAG7HTisvKLeDxqQk1Nsja7950ceWYXt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kjwdsev8uly6qZYDrzydadUXOuJAGKgYJtpa+aHDzBBnWDzxJ2AJmMXnYr6DM18gamRdEqHKrb2oun8dForAnS7BEmh4EiI2pKeFS2D0ZlUePFwJmW/LMWIpGDBNIpPbr36nxLwQN0FgW9PaiwPPzdnavrFDH0PxJtJuEcoNQvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=mAGUs4qW; arc=fail smtp.client-ip=52.103.43.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="mAGUs4qW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIc3zSxAPnZFNctYS/ATzMMZxFHWLUm03NabK40vCwWte01SHS3ub6/uBpBeRwSg5t1YXDTGOsfADJ2pMlmimTqENK0jrYlEGcfULqD19HtWekasfPd+b+qZnlqxZOC4jStbl2G9YPhm3TG5L1alHFyaW9tE5xW1OtzDEdIGdrdjduyV259pKmA14XQHYORoYYcP6oSaKaLN3KF1C4udIYjPswY+b9OlcTD4K9DPb0h5fotqZkyE7h16f3xThYSlJhto+/AHYaP2yj0LLwGv/Ce9WtUT2DwIfAzbbX/6yUug0M0GSDIPvID4Fl4qyNbPdMANJhwleIiaXRTXpuauqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ78yrSN9VDJVkxhL6JVYON/0qgmvGVxJFiJ88gH+zU=;
 b=XeQ+jqP8eX7UYXIXH0pqWFKfNEh3Ek2nEEPqEPfZTT1FlzSJfVcTWf5D3KDC8WCeM2Wgp9m2wlCl9djP3z2amjqYz0CtUjS/r5mBDcgL+rqnkfdiqabMPq9aabTLPqMtcUkidIyFltJIg7tRRRjsMB2CtR4Yv+znMAyzKb/ldWdHNasAfoBfZk5ut9NNQLgWC4YWw8McLQ33V6Ol7vtOW07Fm2E3mm0tdV9cj/uVBAWT8VTZqx63N0vILH9f4jAMKG9tDT4iNnc3jUPeGQJMPIYis0p9Dgjbs11UETpW6WTdJpiSrY6odfu0jb/dGmw/2yrAl7WAbfu4C3zmC6OtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ78yrSN9VDJVkxhL6JVYON/0qgmvGVxJFiJ88gH+zU=;
 b=mAGUs4qWmtkNDF/PqcwCAtsltiqedMKc3+ma/tQvVYG4mCcWzrrCmgB+3r9Ze4+QYJOR1IvBoGmtcBUWsps4t3u9I6WNwjXlIOO9rzd6gyNn4LwliXOcj7IkvhWGuxJpv0cPnnVgbcjBp7ifdfOvF0hV6kYt/0BAD11hNljPIxD2+rP6VaVNkd4aZBA3oamkyy9R+0cybetPiLJXn6fYcUQCUIWBrmpJRAcxeW5ak3PvT9F7jBDQ1HdEuzWveoffdaCOBvDdy5x1SfxVtH+4qm52/7MZE4C+RBFc7SQ4erC2kxFm2LAV+QaV1wZ85HPQpZPUC78QIL9PM3feAfxCsw==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB5340.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:27:19 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 02:27:19 +0000
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
Subject: [PATCH v5 3/6] PCI: Consolidate delimiter handling into pci_dev_str_match()
Date: Mon, 16 Feb 2026 10:26:39 +0800
Message-ID:
 <SI2PR01MB439352E0D54243099CAAA118DC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB439326AF08A79D1C5661C29BDC6CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260216022642.112923-4-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ca9f9e-3d54-434a-ace8-08de6d02e837
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|5072599009|461199028|41001999006|8060799015|19110799012|37102599003|15080799012|23021999003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K+nFOmToMk/sXULJItfyOnkjsh2gZelN7LOZ8rCafazx30usSe4obs4f86Ob?=
 =?us-ascii?Q?65rGG8U/XVEJ1YWbWyF/vjFEv+3oSxzZIsnfJ2/0AKi2QLRHK+Cyl2QiIQju?=
 =?us-ascii?Q?BZDqWZEji19VKGd38D6XwfnitBW5grjh7p04P+XEE0ryQ2rIA/lwsJfwoT8C?=
 =?us-ascii?Q?YsNr4ffHqlpj0cpkJRyJAevYOUAWLAKwyHS6H2skwiONoVi10bKWWU6xvNQs?=
 =?us-ascii?Q?HMMYOd+5rkG8ErdhikA8Pqt65Cg0yeUOfp3Vn3B8X9AuYB2txgAf0e4JoiXZ?=
 =?us-ascii?Q?0kbEVt3zQ7OtVKpv2RVnmQyWzRh0sLDKsP3sPBrMz4fsVmaY10l028C4I/At?=
 =?us-ascii?Q?MNpXqEV6TS/6+vLQ9PxFGYmOgpxkNzPDtKA2N0yNrDEJ8bsPO1Sge/Qw92yE?=
 =?us-ascii?Q?RsiQ4Wp3CoZm1lViluFvodcWEx3voO163dbSUWNS/6kDFjmOJzm+GOOhBSuU?=
 =?us-ascii?Q?OWwr7brmf2cPLZvbneoZx+WtuvXGbuqYsdr1U55dyBewPohNBAu3iBWRTt6q?=
 =?us-ascii?Q?RHSBpAt/zg8FmBWfq3upJg7MDcHlUVts99dA5d3BXpy2LXuPLzZqKZg8NCzl?=
 =?us-ascii?Q?Amg2q+3YVbuubG7qr10IeaZPIQie9A3W/h/RpJj7v/juQCvrgTbUgCvWqHyU?=
 =?us-ascii?Q?CtYDJYnyeWrnw4osPxFSFkWjimU6GPWE26n33SEZONytwtz4ylSZOXhw9wd8?=
 =?us-ascii?Q?bJo7C6hHRSrkkDCz6lU3IVGNDdOFB46MZqsOOHqbIRTi1PV61Oi6bWaKuZjU?=
 =?us-ascii?Q?/HgthntE4vrmeUij6abVNJesVhOUrUf51mseOFa7bYqiDLxPyfZXj0YT8wV8?=
 =?us-ascii?Q?SJHapCeGfGCENEQZzaiEykjjbaTn5ul56WK08QsZPEtkMRVYPSxzC28VsvMm?=
 =?us-ascii?Q?pX8e/blyGkkJA7e4yPvm0fy2W7y4HaKeiLP9c3wYuPUhZGwvD3GsuWdbfxBN?=
 =?us-ascii?Q?5sx+10jk5YOQVIoTJBjcnpPZwqDymzn8veJpVoSZAha4/t2B8gs3dw0adLX2?=
 =?us-ascii?Q?LcXKkL23XJUri95lpTjfHAxGjONsBk2GP66kPa0Sz9y/ImYwJPPntDDZ61wc?=
 =?us-ascii?Q?T4lf37hjkFTh1K3ntA4Ljg8BVr796gqyjbPvb9LkBSl2T+2juiwwI701lL4+?=
 =?us-ascii?Q?6useoRsIazTIpRjBrEFjJI286FmPp6EyrHbpOjEl3ZxsE+ePjKOLPCjlXzNi?=
 =?us-ascii?Q?3NVQrGTioAg0gQw4ZqvRI0Xzhj7P1hNTfaMmwBtqyZrVywBcXfsW5CSQDjov?=
 =?us-ascii?Q?kTQ1plSwrbxdk0El3/vQhF2gr+dmSLUhN0m7MtX25A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CI4x6qRRpFJWA136hYLy64jPd30TatBK+57Q8LYbFBL5sUZYeKKXgIb8k/aH?=
 =?us-ascii?Q?VxkUZGr5DmrUKL3Hi6S6AoCPDtoobM5PBZRli7hbiPIZ+0IVY7oyhM0nwh8D?=
 =?us-ascii?Q?b9iTCP3kXB6O8coCBcNTKt7tMzhUsLm7l35D6+yeHIUdS+eCbQ7rNuyIayuc?=
 =?us-ascii?Q?pOC1ZCguCzUia9hHC67yadM1C7ShEY/bSTXGPWXRDw13R2y8Kdr+rx1fFuG1?=
 =?us-ascii?Q?MZ89X8GpxfnGJBrDY6/7/NsXQAxSxyuaaN6gI9ZK1XBE64wGJpRnrj670fB1?=
 =?us-ascii?Q?EErhXf+O2B0KzNS69miL6PNCOno41pILq2OrDJpPy7mw5O00DbQhY4qBchvZ?=
 =?us-ascii?Q?/NtSlNVFy5sYSBIgRl9F2x3+iQPDINm4ZNRe1wS9hW9DGUQHQo+R195P8cg3?=
 =?us-ascii?Q?M22pcPMTKwomaGkb/poMD6IYBx42+EOvXeZf2AeTIgLE6eTE68o/jrmDcKjQ?=
 =?us-ascii?Q?zzxXntd290wyMLTgDCw93ZjWvVmpfxvg4ZeMUyMeLaInkwQ5a/xho6On+lr2?=
 =?us-ascii?Q?27ljBN4fQWsC7BKmZEXsItE+IEmJWcrG5BI7Is5A236PTzG+tqqGWmdPkeqZ?=
 =?us-ascii?Q?V/d2eUB8PM4E+QGCfHAp6SO+n+EmNYc4TJD8nYWJoyPD7LtIeOv/oX6qKQbY?=
 =?us-ascii?Q?TfK1Ultij9Pbu6z5Z5EIw78cLAi0Jn4f+2xDK3SiI8GhJ6LKsm/EfYfC6kWW?=
 =?us-ascii?Q?UJ95OA3jjVAr11/NiNsjfxdLiwvVVg9VuIe9NsLVaMEUgMVWOKSzckrXURSQ?=
 =?us-ascii?Q?0nDGEvWy7/MuzN8iiFHDpgmVrYXzFgm55AcfViiEWSepgYTeK3+/vc8gd7fa?=
 =?us-ascii?Q?F7m9gejVds1W8p6QuXAxsi35XCCuGWIscyzyxGQAtbaWwgUSEB+L9wowX/9y?=
 =?us-ascii?Q?cAFhkFm87am4XCWJbemQq+X3RmFwHXyxOG8KmeZv8+X6rNUqdpszdnM7YNqm?=
 =?us-ascii?Q?P1KEUeTbciL9zNSK3E9o+TMR5Ls6INxtbfa6MhyqWjlgTiMrZcA5quMwB7by?=
 =?us-ascii?Q?hRPLSLnjXPDZhvHcbVOwMsLCOW5Xrojl0ctotwygJNQdt5M99BHu8OrSH8TL?=
 =?us-ascii?Q?i7VQwyQSegdQLzyyFv8679fuPuXAzkoDnA9iAzIz/dFL6HiERsRW81YQsljZ?=
 =?us-ascii?Q?bwurVWn8A3halqB8j8AMtGMyokfTgVnNjgvF9KG2dGxrUA1hHkYmkpvUOBVh?=
 =?us-ascii?Q?hvdYt+j97biHgXyrl/cq6kpoTlMXp4bO349w8SIxMe/jJSVuny1Xdbuf0B2K?=
 =?us-ascii?Q?trdXDQ0AXvkmeMne7xyxeOqtktDzsvfJvvLqvG+RA9Cbi+mQ5nj9+SCAme5a?=
 =?us-ascii?Q?Y4joYxw/XGfCmI4JF0A24445hTsUUqbeEyS30FAEnIqWGlJBDy9QHkLhDIdr?=
 =?us-ascii?Q?86wAu06YpQcNCaWOW79A9oQ6G91n?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ca9f9e-3d54-434a-ace8-08de6d02e837
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:27:19.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5340

Callers of pci_dev_str_match() manually checked for the ';' or ','
delimiter and advanced the parameter pointer past it. Move this common
logic into pci_dev_str_match() so callers no longer need to duplicate it.

When no delimiter is found (end of parameter list or malformed entry),
pci_dev_str_match() now returns -ENODEV to indicate that no further entries
can be parsed, preserving the previous caller behavior of stopping parsing.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8973658441ec..0f0b384e782f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -344,7 +344,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
  * pci_dev_str_match - test if a string matches a device
  * @dev: the PCI device to test
  * @p: string to match the device against
- * @endptr: pointer to the string after the match
+ * @endptr: pointer to the string after the match, with the delimiter skipped
  *
  * Test if a string (typically from a kernel parameter) matches a specified
  * PCI device. The string may be of one of the following formats:
@@ -384,8 +384,10 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 			     &subsystem_vendor, &subsystem_device, &count);
 		if (ret != 4) {
 			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
-			if (ret != 2)
-				return -EINVAL;
+			if (ret != 2) {
+				ret = -EINVAL;
+				goto not_found;
+			}
 
 			subsystem_vendor = 0;
 			subsystem_device = 0;
@@ -407,16 +409,28 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		 */
 		ret = pci_dev_str_match_path(dev, p, &p);
 		if (ret < 0)
-			return ret;
+			goto not_found;
 		else if (ret)
 			goto found;
 	}
 
-	*endptr = p;
-	return 0;
+not_found:
+	if (ret < 0)
+		pr_err("PCI: Can't parse parameter: %s\n", p);
+
+	if (*p != ';' && *p != ',') {
+		/*
+		 * End of param or invalid format. Return -ENODEV so the caller
+		 * stops parsing.
+		 */
+		return -ENODEV;
+	}
+
+	*endptr = p + 1;
+	return ret;
 
 found:
-	*endptr = p;
+	*endptr = *p == '\0' ? p : p + 1;
 	return 1;
 }
 
@@ -943,18 +957,11 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
 
 		ret = pci_dev_str_match(dev, p, &p);
 		if (ret < 0) {
-			pr_info_once("PCI: Can't parse ACS command line parameter\n");
 			break;
 		} else if (ret == 1) {
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
@@ -6382,16 +6389,8 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 			align = 1ULL << align_order;
 			break;
 		} else if (ret < 0) {
-			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
-			       p);
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

