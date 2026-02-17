Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021097.outbound.protection.outlook.com [52.101.125.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8622BE026;
	Tue, 17 Feb 2026 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310347; cv=fail; b=AiRqq6CMa6xy20pTec8sMMyvOJBhhy5QMHNwTQTrE5BplPB87gpmqeeMt6QHm2ML9EdH3QbbkUDF0mI8n8wJjAXAheCUmJyBW6UGQM2+e0N7S/Wms0zC5LvxxDGu0GGSnNj5Q9ovy8ZrdVVwbMFFW34+cuumRBZmWxb89xN/jwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310347; c=relaxed/simple;
	bh=nMrS7oxwkesM4/o9eLnwS8pi7xrJ5MbKuZqT3Z9L2hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWQyzWwqGsr/OtN8mUe5NQFHhtNHpTYtbXZPl/dnW5zYQGkf3U15KYB1EtnJwZwL0u+Awfg6bAZHPDX/8HA8leK2EXjIcpTlrwkMzZZFSVgtoxcSU6mPRN1UbU3/r8qrf1kfjiXWU6xIk4E2KzgNMAY441y0Det1dG2Q5nUscm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YItfG/y5; arc=fail smtp.client-ip=52.101.125.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YItfG/y5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCX6BlrEjYb/k4Tg3KmB9r/ffJ///OoR4x91jotSkBgG4EftxzkCQJGnN9z3WpBpmZHp9OdFrWiynPr4zlBWsvkLVMcdBphYK8oLAvBVPwDSr5mNeFnBQ42oUk1FEZqTKLzQ/5on6aYIiSjtZ4II0tgHv1RGANJ8zHSpG+fu9CzcVh9tc6d91qn0vIzeJ8Ghl5QrgZ81NKlKLwXOxkQMYJZI0Usf4fsQrsQQ83jMMhNgyFAOzsOLnv1KcLxNsSFi0/J+g5LeUQWFLNZeJONND8+3XsSTgqbNWSvqzDmN3X8zNL8Squo0C6f6mbVNqd1JgnrTTaMmI4gswN5QFXoNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqoMmfMctpC6HfEFGVnqTroLmzj7eCr+SnZN88+sRRs=;
 b=m5DQGdutOiPppQBaL+bjAb1hdr7ide1TzTcCSAQjgkW7llNxRBhNpUUSWzZqHxuXZ3+LcVOtCAvf8CMW/gLrPuoiUCLIEGpxzVuyBfm4VbHXp06rJqjbdOKlRLj/90M79fI0FSiuUuIeSqTuZSgDZqgekvIbeRAJ55Ipua2jVgoJMMsRK58blYyzWlA0uV+4d+SGKS5y6s3a/Vv9Vypm+RARvm07SvIOS+eL+hHssoFDTfVFpe8mlpYhx56RlAGa0Nc2jORsnn+G9ELlKsOL3gG55NQWdCxoX3sKS04UOQK5Nv8aUmaEGZ6n1L26SKdnv//zZHUarEkrI6ByMoIBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqoMmfMctpC6HfEFGVnqTroLmzj7eCr+SnZN88+sRRs=;
 b=YItfG/y5ebZClRY07kOyqwOQZMTNQYv5Lu5esjdCMRTiWVNPY1XMZTp1q0nX9OqD/6dNQtJuWOwdWK1riEAHaVxdTRaXUrAqHtcy0LZM6t222Hfr5I2ZNfwEc8xEuVam/JIFO0z8SiNRxyFp+ASk28s/HBmQi1CqB9pSIInJ4hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7477.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:356::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 06:39:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 06:39:03 +0000
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
Subject: [PATCH v2 1/3] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
Date: Tue, 17 Feb 2026 15:38:54 +0900
Message-ID: <20260217063856.3759713-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217063856.3759713-1-den@valinux.co.jp>
References: <20260217063856.3759713-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0250.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8ef417-d853-4ce8-5424-08de6def3df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9A7v6pv4BUsDtfKcgBLy7wxHmedeJAgMavQINXnZAQW5MMdOlU7AxnlYuS5S?=
 =?us-ascii?Q?+JeW/Otvdurq2JtAmvD9ABXtW7+rcTaXQOZYi4S2ATyxKO+cYZD7TZgU7Gy1?=
 =?us-ascii?Q?x6DTmmpnGSpR+ILVstslAEjk1mOsJOwKV7ZEMoL1YktC7vLYNjvQK7Qr6buA?=
 =?us-ascii?Q?0CdLmS3x1BSb+7JY+GvqRdVuHbbPaextcLQMhvDKqx/oF2E2KrSnVDs3lOXH?=
 =?us-ascii?Q?GOAzESc+BaXNgtuG3EgXgzMO5fgTQxLTKYFP+dNymDZxWAoWZySwJad4fChA?=
 =?us-ascii?Q?5E2Fhk+b8edKxuVOd13QvuhTBH7yli7e6/sje0wNVrkg45c0fii2Qcn7J6y4?=
 =?us-ascii?Q?bwM14qWlCAasDbJLD+J5KL1ndd0FT5UXVzcGZtPWBVSdEw2Hq+3pSK557V0q?=
 =?us-ascii?Q?IZpkXA9SXi2Hr/sprfVlPOUSuoc2ij3cDGLPwOGsVn0gIX9d1hY3/jVy6lGs?=
 =?us-ascii?Q?03pZ6pPj4OF0r3xhOUSTZeynCCrpMkm0rokFhwQs8QENTKhSeqogXhItUhUe?=
 =?us-ascii?Q?HFsdnUr5PPbZCtfau6c/OMdNYNiCD/Wzeqmr/3oCkllIS1nNwinciTO9YeGk?=
 =?us-ascii?Q?KczR7Rfkyg4ffKgyq7/43nx/UafPOwIJODPOlf9jkjFM5dv1CYLk3tiBA8qB?=
 =?us-ascii?Q?VQOnyLXduK+M+ZvHq+gSwXLXqizscPndukKMDzwiQfplezJshs23AL0zjJnX?=
 =?us-ascii?Q?mD03wYOK2JEiHZT5tpwI2muL78yqFYeWv8g6W8B+yYGfzl+LVURRAIS0Xijw?=
 =?us-ascii?Q?cWI988GoWvoLKMfkArJQLP5KsQ9DgfqTo98vKENEwAUdGCB0+WuW9J4rc/mZ?=
 =?us-ascii?Q?q+WMlT+1oufx/yZi8W/dppnpNiWSDZIkBwlTIvK3hkagG8PCVNvk3d+3kelg?=
 =?us-ascii?Q?mbwZ6JtqcHxxfy3qWiJXFiOc4t02G+j49IZLmfztt0EUd3hsN2M28JKqzF0A?=
 =?us-ascii?Q?TytgPzFiXhuFVmqeURPXFy0JwDkD0ZvBNU7Ip2J6+lAdn4iAfZuVlyLPAa+N?=
 =?us-ascii?Q?EWTarH16hZTohYKzgFqDxyUlMxf1i491zd9boQl2dUK13cBHrJl33KwvUhjw?=
 =?us-ascii?Q?Mh/XzW+yrbJq9bhUtsePSH+hVHWhTdfnitEtjK24mC4pYcMDkZDPJDIVc24w?=
 =?us-ascii?Q?dTMJqkFYJn7pjVpk3NI8znFOdEAedW0r44+Y930yonkoboNMvaCIkZUV3Rkv?=
 =?us-ascii?Q?7cA+OOdtLrmAjRkVPrNOIOaEmYH/948TSVZHie8MFdlLRyVeAd3q1acxTvFQ?=
 =?us-ascii?Q?i/6j0n+OpBp2LktYVPI/XyO53I9PogffNdKqq9rEm8Z4dfzU69iwtD3JRzPi?=
 =?us-ascii?Q?ucyD2xWqqcz9oaI9H7BjcTo7+hYn9y9JAqY8v8SAtpeClpc5ZMWgezBPKS1i?=
 =?us-ascii?Q?vCcV5Gm8hm7PhfK1wSsW74o02r6RJwgwFOIOMBDCSeoO6DNLDD0Ggit664mN?=
 =?us-ascii?Q?p90ULXNAkL/0M2DHOLBsRWgELgh4uLKv7ZO0ZcI7uL2aXDQ7sJfGkp1AW3Fd?=
 =?us-ascii?Q?q+pmgu6egEBfnFHUkKZvAyCrSNR8RChDEHqxBmI3PX22CIKPtea/lXIErjoV?=
 =?us-ascii?Q?VI8UhCwiwlaJIxmn0S8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IWmXkqJJBf7dBYeoIqnU2xRnr0dcfeWMDG6DHHtU4VOvpcZAcO1ETOvkGwiq?=
 =?us-ascii?Q?1bJ6KCVZLBtXr/ESr9kSR2+bw7yXHNejAJk3sETmTri/hTKV3V59EiK3cjAn?=
 =?us-ascii?Q?TVlCqxOYpSXKLbOu5394/V8f+XheXIkRyRBeTxDnRa7GSL4CUiKwneD01WZB?=
 =?us-ascii?Q?5yK4C3+WgEeUBjwYlqRrkGxA4tWlQyciyxZM/ZHODUnbR7BzluW28+xWStGl?=
 =?us-ascii?Q?8/uKqnNTdi6rCk+HThx5WpZAV8RN/Uck1xprQEPTw4hFnN0u1zt72zrbXg5W?=
 =?us-ascii?Q?GKZa6hliAn27WvLv1l8ghpaCjQ3ezjkDWwS5ap2RvCtwFYBTXTX2LWLClV/K?=
 =?us-ascii?Q?01F/DlkioYH63c4o0daiYVlyxF/Unqtf0EcghbPZdfxbutkNj6jDN3eEDSC6?=
 =?us-ascii?Q?DgdWfC0YYNnJnGPMOQr5t0QbhAb9OR79Xju1dFmbwXfrlGUSlMmVty0QHl8R?=
 =?us-ascii?Q?PbVZ17uSei22XIPx+1Wp7JSWhTGbyp5ekY/Ylknj1LNLnaexrB6f3vne8v56?=
 =?us-ascii?Q?I6XcqS80wj1RxJ29CIl/z3dX2xSParxuPwwkmB/sgR1z1fCMaCKpn1qOcDcz?=
 =?us-ascii?Q?6duGi0oMakV2NmZjym47f+u5lPiHOz4CPjtAX54MDzXSfL6AyZs8nlUVK0v8?=
 =?us-ascii?Q?5J5MP4IYF2ZldC+Xf/nabAMZoKTozwXl1oiAMPmGc4hWf1caV+nx+RBxfShD?=
 =?us-ascii?Q?Gfx0Mihpqwx2gOdLnDvbIKq3Sb/X3fqFBmHHo/4UdQcqeI5dp/RVQSmqXzDw?=
 =?us-ascii?Q?s7rU0dHePuPMZueNK0uFkrtqnXG5yPY79rgGmN1a0USk03UcZbOMXlINJI+B?=
 =?us-ascii?Q?QZxlrK4ir2YhPu2cZ4wx9Rq/fKCPgPYJrhw31pt+zPM5OjM1VO/tSvv1Qrk4?=
 =?us-ascii?Q?eK/kORsNMbHAy341FOJziuKuO6+PahBLhjPMjhhH6h5vynw0YJ4McmqP1tnu?=
 =?us-ascii?Q?X3sS53hxwGtCIOh2zbc98RQ/axJv+CLNc9BSWNj+rq8aHD9ut8c4WRJruFsA?=
 =?us-ascii?Q?yejGXTF7Eib3Jw34dbHHFaqqTZwkczaWBEYZ2Z96LnF8tXxochK4LkM6/i7O?=
 =?us-ascii?Q?s2Rtki3OFnYYaaKQTs/mlVl0DxipKCCmTTU8HBIlLI8OtLVAa5YdtpE4W19i?=
 =?us-ascii?Q?Jgn9+n5wgyQfvpzFLupy9x7lMMfhQRfbuxM5nNXvItACFDTB+KccaKn6grv/?=
 =?us-ascii?Q?Q4qSP7SKLnMfoVIb3ls31ueVppqx62iaM+xWOU0ehBk5s6C3ayTi9uxV6p70?=
 =?us-ascii?Q?YrvUT0xR9je3HTYL2NASVncJyM8LrcqGCR39PjbhPpiiOf8q1JO0/zzS6G9+?=
 =?us-ascii?Q?gc0L0of0HDr239UlI2Y6Atu9ZKbOteUTuQFCVtpd6ZN8zbIINE1O+vLmot+l?=
 =?us-ascii?Q?4cIMOgSMZU9rkcggafCIDo3Beo1m197fwgu62EF/VD63cArsxzoZlj+8cwAS?=
 =?us-ascii?Q?ceaMGzOuttcL78CzhAS9ScLcGSazULiEsO40gCwUdk1JWbaEH35Ca8hhSL+B?=
 =?us-ascii?Q?nC/2RUDpPCO2vlQUaOF1ikeS15JMukij23TmkAVdNq0h3zezki4e07mLC/bo?=
 =?us-ascii?Q?bBfpvj2M8ndsvYmBxWIuWvo7UvATES8y780Kri5jKE5sNCIfYJ01PKSywQNI?=
 =?us-ascii?Q?wQlF2DVtpbz8T0yW5Go4FTxcJqfbRCr5zqaikslurnMtqjJdu2Rs6a7D1oXs?=
 =?us-ascii?Q?2oG6MAmlf4Uqk93a8lp2F0qDuSH8/wv44Zs6q/Hk+YwTaL7+AiA79qi8rmqn?=
 =?us-ascii?Q?Mh6cAjF8DnHg9ojsHDJRv/BW4MF7nhDNvJPSQ9YsqjlSTDbo0hbO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8ef417-d853-4ce8-5424-08de6def3df0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 06:39:03.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a1hFHQe2+y/S0zgO4B2rRAr64HQC61IZplyIzzO/jOf5EiZ3YvrlJl4OZUJ31Llyaqzo+cE9viyVQSiiJMk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7477

epf_ntb_db_bar_init_msi_doorbell() requests ntb->db_count doorbell IRQs
and then performs additional MSI doorbell setup that may still fail.
The error path unwinds the requested IRQs, but it uses a loop variable
that is reused later in the function. When a later step fails, the
unwind can run with an unexpected index value and leave some IRQs
requested.

Track the number of successfully requested IRQs separately and use that
counter for the unwind so all previously requested IRQs are freed on
failure.

Fixes: dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..52cf442ca1d9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -527,20 +527,20 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	struct msi_msg *msg;
 	size_t sz;
 	int ret;
-	int i;
+	int i, req;
 
 	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < ntb->db_count; i++) {
-		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
+	for (req = 0; req < ntb->db_count; req++) {
+		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
 				  0, "pci_epf_vntb_db", ntb);
 
 		if (ret) {
 			dev_err(&epf->dev,
 				"Failed to request doorbell IRQ: %d\n",
-				epf->db_msg[i].virq);
+				epf->db_msg[req].virq);
 			goto err_free_irq;
 		}
 	}
@@ -598,8 +598,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
 	return 0;
 
 err_free_irq:
-	for (i--; i >= 0; i--)
-		free_irq(epf->db_msg[i].virq, ntb);
+	for (req--; req >= 0; req--)
+		free_irq(epf->db_msg[req].virq, ntb);
 
 	pci_epf_free_doorbell(ntb->epf);
 	return ret;
-- 
2.51.0

