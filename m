Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013072.outbound.protection.outlook.com [52.103.74.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B838D69B;
	Thu, 12 Mar 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306429; cv=fail; b=MjGuxP7zGP8s1nwj34xhS8doDBA3hFfPogq2SMpum1aAKrEk9dByBgUtBiq7kTdwagb2/ntmGQ0iJewxbUIT5OoBPm9HntxjGbk+yjMc6b2ZFwDXgMeAycgn24cFJ0iXjJv35/JPtKz0j+dvrZJI1mZm3YvuTS8brT5O988bWi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306429; c=relaxed/simple;
	bh=cCFNPGunvDuZvnAI7lh9u+GrFnecds2dRBmDrncDkyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNtA+1mZ7+on+A0FEQ9QpvcSTiZ7S1fz6s/yjB/QeKf6vBBdn1VJrJknqETlzwZqK6FZshRnUfxTA+lrKs3z+P46DTGfSwM28XJHw9BzRb1WKTqjU2ddepYG5orSOqNAo4L5D3OBTItX4BvA108oI3j5NMt9rCVArIoHYUY2UmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=U0kTvn1v; arc=fail smtp.client-ip=52.103.74.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="U0kTvn1v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oM79dJYCZIazC+edOa0v5AgOE/t/kuWpKqoHdwF33bwBXvo3qEMvwAZRy8UW4cWa5GTmke2l0QxbC5CVWYmIg2vFYAc/bMziyq4yRvaZdO+OSNFkNff7n0WAY/lLbjF7SjKrLSk5faVgK3PlwXTSKcq43IwUU0ddkEp4S6hJukb0uM6206AabIOWpHCo37zxoB335eSamGfwJZyykZU+2MTIG1DjpGFW5pCtOrpT8m3qVucKZI/0SpCvFfJBjh/wu8P1rU49+Vo2BviUlAF38+/j5GNVPAsroWFo79G0Gfm6SrWkjhOaZ8LuboReQtuMHkNHZY3kvjREvo8MDmHHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcyxYtCJWKaWDVQn4hnFrVH3YZ0w+Wx4Dlxzb/WfVKM=;
 b=Gtsh3fEkr22X8rh+jvMSUeWORFV60ikL8Y7XZVFmVCiiLk7bh7wCJNQAETD01rpLBTnBBZiFDGJ4aQsCqvv1Z5ODB9+sAzrniMUu0aVfoQuwCQt9/miTTZW88XgRBlAaGivWsR4LPBb6nFb8zQdkz9d0Rvm8pqoKCWweR12ySHUCZDf9N7Gyfue1GuuapGP8WQNDF36ylzSq9KGmnFoQY8LvOyvoMIY/VyLrWCnkTH47hTjJI5RwtmWSsWL7ijpA214qSJPEL546XnKjR8KFC2fNA8hmha8e+XpagzFEgEifvVyW778fTTYU4/9MRt5zTVjZYq9T2D58m73hNJn6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcyxYtCJWKaWDVQn4hnFrVH3YZ0w+Wx4Dlxzb/WfVKM=;
 b=U0kTvn1vVJWpSM/0WbNWHBLhIZRJ6gC0lAbo1bRE38begOPetY1lTwJegt7mnB9I34ChJsus11s6D6ZjMTAD3kGrJiHrf5TMQLsDIvcHTP0OD5uwYapKZriNboTv9AFMBebawnMQcjNzHgVues/6YsW3Chxt1rIM15ms+TqO+4j6/VTvcp5uvOkf+qLYvT3fSq8JdeucHxx4JBpA+XXMP1EUb+un0Qrb9RKsw2HHrOsAw8AQhv9O+uTMV4wHtD3sHBMaciNBXrbAYMKcSq9vKf/NCYqOdtBfFbPhMyZN1Sz/hil1wSOeuRTowUENJpgMOdViqbncF5HtlJALRC8kYw==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by KL1PR01MB4704.apcprd01.prod.exchangelabs.com
 (2603:1096:820:c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:07:00 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::fa7b:b19f:e19e:ed75%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:07:01 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org,
	akpm@linux-foundation.org,
	bp@alien8.de,
	rdunlap@infradead.org,
	alex@shazbot.org,
	kevin.tian@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v6 4/6] PCI: Refactor disable_acs_redir and config_acs param handling
Date: Thu, 12 Mar 2026 17:06:35 +0800
Message-ID:
 <SEZPR01MB4399D142A87E89271F6E0805DC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::15) To SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13)
X-Microsoft-Original-Message-ID:
 <20260312090637.71548-5-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4399:EE_|KL1PR01MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: 6884ed93-5f25-4c90-8c06-08de8016b809
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|37011999003|5072599009|12121999013|51005399006|15080799012|19110799012|23021999003|8060799015|461199028|41001999006|37102599003|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnZxZHN4dVJEcHhFVWZ5c1pISmYyWjd1UTlndmF1cDhVUjNSLy9oa1pSU0tL?=
 =?utf-8?B?UktuWDYyRWQ1L25Ld2lqRlBVNXZKZ24xUjNwT2RueVovM0FHdXdrQm5IaWln?=
 =?utf-8?B?clhGUzNlZ1k1Njg4WTU0WERGMmRwRnJ2ZFZCMVgrejIyNU5XeHFER2sydXN6?=
 =?utf-8?B?eDV2dnZraVJCYjVhMDZiUU81Syt4QVE4MnJCOHEweE5RdUdEM2hYSlZHK3RL?=
 =?utf-8?B?R1dJdWthNG05YzBTa3hibnozQ1dWMUxNT3p5ZGVnUVJPWXpsYUpLWDJESGtv?=
 =?utf-8?B?c1lJWjljMXpOeTJ1M3I5RTFzVDVsNXBwc1RZcmJWU1k1RXlRSDZuRm02aG5I?=
 =?utf-8?B?UzlsRnVlZHBETkpzNXozQ21mbnNkRXdpbzZkaStSd2RUWnZCMnoraDRlMjZk?=
 =?utf-8?B?WkpVcktOdXovTVZhSlZVTFk4WFpSRWFjL0Z5VXo5S2V4ZHVTSGQrRFN6Sjlo?=
 =?utf-8?B?NVFqc1Jha3FhZC9uVzV3TVhiWXJPRGYrSzZuY1VDYXZoRXdLQ2ptUnNRdHl6?=
 =?utf-8?B?cDc1TmNXTnlTTk04bXZQck53am84WE9pck82VlFIREN0ZXozeUt2aStGdmZ0?=
 =?utf-8?B?Zlo3c0JaWjVpTTFMOGQ0NDliQnQwRzZnVWM4UlFXTXoyejMrNUI2VTNkZHcr?=
 =?utf-8?B?RS9YKzFNUy82M01IK016RW9iTjdRYlFjUDhCVWZhM2o3Q3FEcVNnamlCQktZ?=
 =?utf-8?B?NEdpbTI5dWQxdHRlY1pSdEVtTWp0bHBFbnI1TXZjYllVdGpURzN4V05OQW4x?=
 =?utf-8?B?WFNQbUZOcjlNcVZzUDh0TDZHY0hpODVRQ3N3aUhkWWkxMDJPMzIxUmRKR2RQ?=
 =?utf-8?B?YVZ4dDljNUV3VEdYTmtsU2Y0YldUcWpJRlpZUVFRQ0lBWWRTTWtNeHRtdGVp?=
 =?utf-8?B?UkZhR2hMSlh5Qk1SU25ZeU52UnJGUFdUYzlqUXhVT1Z3VHVKL2xGeXA0Wkhl?=
 =?utf-8?B?aFBhdlQ0NVZya1U3T21vWkNBTUorWUU1aU9TclJqdTE2ZjQwRVA1Z0hsWjhW?=
 =?utf-8?B?SHJnNzgreVE5MnY5UXZsaE8yajBVV3R1Q0ZaMmN5NzhsSHN1WWNuVTdCdm1E?=
 =?utf-8?B?Tk5uRGJSSjMxZC9PaHlCV0llOUpwcCtORUlaLzExTmkyY1lhVWc5d3duZFA0?=
 =?utf-8?B?Y283eTZteFM5Tm9KcG1pMUhIbEdWTDM3dHRMWVF1TUNaR2dzUkdDSDRkb094?=
 =?utf-8?B?QzdsS2NuYmV1c3lPM2FxUVhIcnczSHBUa0NsemlBNlNWZVFaNHdtdEo2VVVo?=
 =?utf-8?B?SzhMQnkzS3poUkQ5YlRsaktnWGNwSlNZeVIzRHdrNTgxVVhMalByUldqd05K?=
 =?utf-8?B?eTgvQ2xVdjFIRVoyRnM5anlBc2lyQ1J5N2kxczFRK3NMMVRVTHcrcHJhK0k3?=
 =?utf-8?B?dmlzbGRCeWxTb3VNS0FLV2JJOFRoa2FWSlRMRS9XS3cxVWZsVmZOZDR4OTdS?=
 =?utf-8?B?VDdXWkUrNGlRQXlKaFRsbjUwZnBkZVRsZTd4RWdnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzcvaG93QkVzVXhSNVREUERsNzVPOUxZdVYycHdSbEMvb1VhVnZFOTk1a2xU?=
 =?utf-8?B?b1AxcHVCdVc5K0tpdmZpTUpYRkRQRTFwSGJYTTlNazU1OVNWT051dTRRS09r?=
 =?utf-8?B?K091R2ZoQllwTVdrWHFUOUxwWU1PekdmaTd6MUoyZExIM2xMWjUvVDhYWEtG?=
 =?utf-8?B?a1ZIQ0JMV3VxVTNDRGZCZlVYQkZsZ05vOXJZVUdaQUE3dnhnRXhxWUtTZWlD?=
 =?utf-8?B?WTRGZEw0aUZwM0dCSUdoMzJxVFBKR2g4MWswMDFqdG1TVjBXTFhGUURjV29z?=
 =?utf-8?B?MEtQTFhsTmpLWXhWZEhzVi9sdDQ4V1laSEtITHRwU3pRS2hDQTQ4RHpnOG16?=
 =?utf-8?B?aGViQ25ZZmh3WTl1OTNVMXZoRmNCT3c1eWVqUXNrWDM3K1VmSUNKUWJtMk5K?=
 =?utf-8?B?UnBQdGxDWDdhRU95Vlppbjd6QXlvbjdSbXZJMFozMXNtYkpQQ3FjSU03bDNs?=
 =?utf-8?B?VGo4UkhOSWs3bnFhRFV1OXJnWmlpNURnRVQreHJpcWpKM2FCd2w1V1pqZGY0?=
 =?utf-8?B?QzZ5aVc4c1FSREREcTNRSzM5Z1UrdzVCSGNqRHYxc3ZNNTJLY0dhT0Nrdklh?=
 =?utf-8?B?ckhSb25NZzN4N2ozN2twK21ienh1ell5am9rZnNsOExWbmtvaGFRbHpGTkFO?=
 =?utf-8?B?L282Mm4wbGIvaGVyWFROaytYT1lkbysyR1VIUVZmR1Z0bCszRnEzeVJTR2JR?=
 =?utf-8?B?NnJNcGY3blpneXVyY3lwdUo1QlhQK3l2SGxsNmRIR1QzUGYya1QyOEx3RjB5?=
 =?utf-8?B?dEkwcUVyNjJEMXZ1azdlZmlFd2pIMUtuZ2hNVDhFcU5NaEdTazdUZ2FDUEJE?=
 =?utf-8?B?ZEQ3YnJWZmtpSXFmZmM0MCtGY3JlTUkwQUxPaTV0SjVYa0pUVDdMdHZMc2tK?=
 =?utf-8?B?cWptaGtpVnliSHZ1YnFqQVJucWJ2WmlJZGdlWVZMQmRQV1lyeEo1aVdJR2xw?=
 =?utf-8?B?Qy9NWER0NUF4Q1IxOFQzdW1TSjZDODkycGdVZU9FZlZFWSswL0ZxN2NiMDNh?=
 =?utf-8?B?Y2NMTysxcWhzall2bjZoVFUzMXlzLzVwemxwVjUxYXcwWWZ1V0dqQ1V0MUlZ?=
 =?utf-8?B?bXVjZzRCSllVdkxDdnN0YWtNMXA0UTlKV21zZ0JlVU5ZVjh0MitSMVlEYTNZ?=
 =?utf-8?B?bHpkSXc4N1QxTGdTRDFPYzFqZjNPeWlZekF3Q1dBdUh3OHJ0QUpqaHR3Mkoy?=
 =?utf-8?B?V3hpL0ZVTURwK05hR3dJWGxVODcxNkZ2Z090ZWNBRytDNndpTzRjZ0NLUzhQ?=
 =?utf-8?B?SWR0VGIycjVRSnBDNEJvQnkzejE5dm5yOHNVRC80dWxiU3hOZEhBUDBmdG9Z?=
 =?utf-8?B?eGF4SEthczRZR05JaEtzdm9KMFFLYmQ1YlUrTGlvWGtESG92ZVIzT3gyUkNq?=
 =?utf-8?B?WlRiYlczQUZMZTFCQnBqU24rZTZSdStpVUk3cW5zZmkyRlpCZnNZdG05SkxD?=
 =?utf-8?B?TGdDMjdTU1lQWE5xZWdHWlFCVGhIZ3NyZzIrR0NqVE9OQVMyaGJCeWp5bklB?=
 =?utf-8?B?VmlGd3NaOWVueDE1ZW1IRDlIZ1FWQ1RxUzFyNm1WcEtnQ2lvQlZCRDZMeFl4?=
 =?utf-8?B?SzdtTUE1aXpraERXQWVXNVA5STBDTTg3elN5SkwvZGlaZ3p2Z0dKTDJRZ1RG?=
 =?utf-8?B?SEZjaVhDWEM4d2Z2SkliKzBjOHI5UCszOExNbmRwcHBtOVorTUdrMFZKUnJW?=
 =?utf-8?B?TW4yc0t2ZEtDUU0xSlhIRzVwSHZDVFpBUkxWV3ZLZ3RHSExmSUNOZXgwc3FL?=
 =?utf-8?B?eWd2QmV3UFNhaXFVcGtrZVBZWXdmYUo3UVZ3MG1sRHhnaDlYNHFWdkNJVW13?=
 =?utf-8?B?WXlpa0tLWXNoWHo1cVF0cGMvdHZIeEZKTlBSMzdHdG5WVEk0RzdDWVlZdWRJ?=
 =?utf-8?Q?hodoGWIpoccHG?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6884ed93-5f25-4c90-8c06-08de8016b809
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:07:00.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB4704

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
  - Bounds checking (max_shift) prevents overrunning the device’s ACS
    capability bits.
  - Variable names (enabled_bits, disabled_bits) more clearly express
    their roles compared to the previous mask/flags pair.
  - Error messages are simplified to reduce dmesg noise.

This refactor separates concerns, improves robustness, and makes future
extensions to ACS parameter handling safer and easier to review.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 drivers/pci/pci.c | 168 +++++++++++++++++++++++++++-------------------
 1 file changed, 98 insertions(+), 70 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4d0fb70c4bed..66842df07589 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -910,87 +910,117 @@ struct pci_acs {
 	u16 fw_ctrl;
 };
 
-static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
-			     const char *p, const u16 acs_mask, const u16 acs_flags)
+static bool pci_dev_match_disable_acs_redir(struct pci_dev *dev, const char *p)
 {
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
+		if (ret == 1)
+			return true;
+		else if (ret < 0)
 			break;
-		} else if (ret == 1) {
-			/* Found a match */
-			break;
-		}
 	}
 
-	if (ret != 1)
+	return false;
+}
+
+static void pci_param_disable_acs_redir(struct pci_dev *dev,
+					struct pci_acs *caps)
+{
+	u16 acs_redir_mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
+
+	if (!disable_acs_redir_param ||
+	    !pci_dev_match_disable_acs_redir(dev, disable_acs_redir_param) ||
+	    !pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	if (!pci_dev_specific_disable_acs_redir(dev))
-		return;
+	caps->ctrl = caps->fw_ctrl & ~acs_redir_mask;
+}
 
-	if (flags & ~dev->acs_capabilities) {
-		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
-			(u16)(flags & ~dev->acs_capabilities));
-		return;
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
+		if (!p || p == seg)
+			break;
 
-	pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
+		p++;
+		/* pci_dev_str_match() updates p to the next segment. */
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret == 1)
+			return seg;
+		else if (ret < 0)
+			break;
+	}
+
+	return NULL;
+}
+
+static void pci_param_config_acs(struct pci_dev *dev, struct pci_acs *caps)
+{
+	u16 shift = 0, max_shift = fls(dev->acs_capabilities) - 1;
+	u16 enabled_bits = 0, disabled_bits = 0;
+	const char *p, *seg;
+
+	if (!config_acs_param)
+		return;
+
+	seg = pci_dev_match_config_acs(dev, config_acs_param);
+	if (!seg)
+		return;
+
+	p = strchr(seg, '@');
+	/* Parse bitstring backwards from '@' */
+	while (p > seg) {
+		if (shift > max_shift) {
+			pci_err(dev, "ACS flag bit %d exceed range %d\n",
+				shift, max_shift);
+			return;
+		}
+
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
+	if (enabled_bits & ~dev->acs_capabilities) {
+		pci_err(dev, "Invalid ACS enable flags specified: %#06x\n",
+			(u16)(enabled_bits & ~dev->acs_capabilities));
+		return;
+	}
+
+	pci_dbg(dev, "ACS enabled: %#06x, disabled: %#06x\n",
+		enabled_bits, disabled_bits);
+
+	caps->ctrl = (caps->fw_ctrl | enabled_bits) & ~disabled_bits;
+
+	pci_info(dev, "Configured ACS to %#06x (FW default: %#06x)\n",
+		 caps->ctrl, caps->fw_ctrl);
 }
 
 /**
@@ -1047,10 +1077,8 @@ void pci_enable_acs(struct pci_dev *dev)
 	 * Always apply caps from the command line, even if there is no iommu.
 	 * Trust that the admin has a reason to change the ACS settings.
 	 */
-	__pci_config_acs(dev, &caps, disable_acs_redir_param,
-			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
-			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
-	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
+	pci_param_disable_acs_redir(dev, &caps);
+	pci_param_config_acs(dev, &caps);
 
 	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
-- 
2.51.0

