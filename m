Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021141.outbound.protection.outlook.com [40.107.74.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DC3955D5;
	Wed, 13 May 2026 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640593; cv=fail; b=OWI4Dm7aaV0gEaRNqZDnXfyCnFt6pvFocknasrAfo/reFlT+FAzvQWmom0ar7hLFM6nDRDRSl11lI1uYj/kcY/HBgHg/C8Hb/uWa4HTz+lqNyVcSgXg/xusNZ9IiVac6W5Y3amcxpqoiOEV2s6ZwogdN7TlUoHHECE2OP6KdC/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640593; c=relaxed/simple;
	bh=rSNa5GdSieh2JrgTXN05hXZmGomfIzxTerPvH8zLZ8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=svGBIbQlajE0N8jP7zHnB4cqXr5K026nZ4Ik+ocDlRl8lWKVAJCY26KUSGl4uXjPRpE1to1TLH4nkBv/kbM4UVjjotYKI5Rq91KqQuvynkuPKw3AVtPDKy7HPh3qFvAJd0j1ZzqRFRcUBD8+eyk5rBoxvUfWMoZBmraX/AWhm3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wkOqlJbJ; arc=fail smtp.client-ip=40.107.74.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wkOqlJbJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4JxyO27jp6EJcXU6T76fe1hu0KMJtb3j7rZyKSjImbzFFVIp2YZuYnzdBqYyqfdsdvezMcvv+ONixwAYkg38SurxV2LlMaTqKv2WrG6DRiNx3F8+aUf6fIl+PDBKbCQKusi77jeuKFiD9AWMq9WAD+8EelzdHK+zaZd5T8IW3CAKPMH6lcQqMq+zgVz6CUKxi4yd+TBK0fFOVVmBGTz52F9NpJElcuS9OvdyFm/8FXd/QZ5vcmElu4TkEXG+Tn091MITeNFvA//QIc8afVui7wKoM1d1uyEft1My599TJ0XnY9GIbliDI6FimmR9Djs3Hf0ijuxqo7a48Z97G9QnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKuHLLbTi5qHpvX+OPrWd55qEw4mRBx93vObvXCWRnQ=;
 b=UCR5Q3VduITTzQ/XEZEE0iTVZ2pKdi2GrsiKu5TT0gZoSEUA5XTi6sRIEUCGodAPyauxZ4KESGIMUwGFLaJkXu4gSh6vWWTGMOrDssMxVW8tn4/a+Y1262ok+8VWw8247X61CqTA6JbJ5u4w8jcU7S+j1WT/D+zFWgmF0uf7mCoil6DZyWO3VoE1D/rTEhUD7H/2XfVg0dQOLcDY2y0fExFtOK1LLHPD/VRPi2Hjdnmvo6UqO3MZm8F6BodQg7qnLJqftZ3w4Nzf0KlXRPqzl19VtOWGZu3Qbrty/GTHYz5VgyJUGD1c2VO68OffKv9aSPU8JlbaXfDQSJ/6wKIeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKuHLLbTi5qHpvX+OPrWd55qEw4mRBx93vObvXCWRnQ=;
 b=wkOqlJbJMCGdG+2ym0sH8I5mDT/UhdZCqHp5v+EDy4RRyQqngYi1Y0Dbe9aW87IGvHoXun5WiM31AT/5PUUF6uYTUlUcMfb2XinGTLnwMnVzz0IhLIJBSA5NEZq+vLE0RWvahkGyWHKkK6nMfs4TcdBp5XzeIVSBi6ygxFLTDbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5341.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:191::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 02:49:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 02:49:36 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v4 12/12] NTB: epf: Implement db_vector_count/mask for doorbells
Date: Wed, 13 May 2026 11:49:23 +0900
Message-ID: <20260513024923.451765-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0240.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dba584f-c089-4dc5-1986-08deb09a453d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GrNbonOmiTKIgRnbp6WJqcMS+7RVnjlwH3hu0ynBkMrKpAdsQL5Lme2y9YCv6sc+GLZohC8fKZm2XhD7GFKFn1uMXKVts9NyC+D1SDChxmr/R21/v5z6prgJDJNdR6/9ymDx2aO6SkFAPhv8UIgF3sXDKjC1K6DZsYtkbeMbm4vB5rjBiK6ted7KB3C5+qZnPPv3Awvcj+4wDvy8JNTKYXpgjFRJPOW5pbUAnCq5E0TYJ4idnBqXdPW8FYco7Rrt1KpghOTciu3T2cwTzV8nyOvhjMZMp1AmzxLm0C7brBiP/YeXf4nivb7VddtrnlnWwt2JxRhF4MdivcX6ATFjguDfbf41MHWefDZiC461CL0iAdVc9XFpqSbqSKiq8FxfEiKK/xpk0FcbyZWO+5SkONM+oX968pxZPdws0lV1Gto20gPcSGCCbKYM0W81Q3Kt3YokesYERrk5mrX3RjntKqgQYW5v/SVd5Xj0FIhUYRO1kiFCDHBnXpqN28XiAaxwKBvJ/3HKNVIai+6JUH9RkPo4slEkMb+wjF3N/WSzWIcPoKMGSdYOd9/9Uivi6UOMlZMZnMw1JHSbjLMHjCvK8zNr117dc9/RNjFA3aDs51rO3Q8LbWJDqmf0MZr06vetB/gD7gxsCzDemD7XgSx1rN5UnxSBz/hNpwmKeZYjZvcckfX6QZNuMYL/SEe5Pfw2gygdcBP7zA3yhAETIhQISyNO+t6yC6w2ecIUlZ+UbH0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NkRoPflSrss+RJB1soZQrNOJ7vgiRuo99Q3rhX7uS/Ln//m4/1UwP7Azja6V?=
 =?us-ascii?Q?fMIImaqv1HEeug8uzkj0NYkV2GzUhAK0EYTjC6tPPlwgF3uR5oZqc1xSCNmo?=
 =?us-ascii?Q?XWpVJT3FbFd5ceA+QgTWvyfi5gUoLwMUyIzpWLRIlHuBAEkUPRynEyZbcr++?=
 =?us-ascii?Q?1OFMe3CE4KFQ3SHVmCboyvzp9AmCv9Nk7xyt8G7fHuPoLtIIXtNuFEGqrwW9?=
 =?us-ascii?Q?2JYCk0QCVAzX5xbovJPiRD34/V0PEglBX6yF/OGjk9NUNiEWogAqkOfCB0eR?=
 =?us-ascii?Q?ui3/XLoQkbE/JAT1D4rPndqSIkn77leMNbVEtIczL61zaXNvOixWzbPJujc4?=
 =?us-ascii?Q?ESOlnjgZDvb/vAfY3sQH24YUkhzZ79XIQpGgIfbFUTEViJRbQFWAI7qy7Fw+?=
 =?us-ascii?Q?w/vcwe3hc0zab+QhTdwoRigTdOySuSqCjASUDo7SCh+vBq5JtheeYITi57fn?=
 =?us-ascii?Q?BPSnuejHYdxqUNkZeaTmZD88JBd90RgR/+rY36dmGTdRvDkdJQ8GGBD5jbtt?=
 =?us-ascii?Q?CrdNvjBnp9S0iPn80hqo5MrwFTZsC0CO6wVA4SEERvRUGnUntaxNMuDBp049?=
 =?us-ascii?Q?86b2+8lTxitXUzpZBmnJc4Ld/txJscEK4Kzt4DR/cVEumTICtI5N6Mcab7th?=
 =?us-ascii?Q?yPAyzKNtyK0i8yUAn0XVE/8Pny85m4ONSnjlU+DZX2DbqsAL0GuJrtbYSrIj?=
 =?us-ascii?Q?2l/Jc4Oou9dOyAP7LpiXTFrtGPYWfEmQAJxLTiayY8FW9I1+Umev1QQlZLpa?=
 =?us-ascii?Q?hVmJof5oDdJnHiUVVVVZpN3fgNNn6mc+WHJBa4AuPPRYFHlf9+oglq95PD4u?=
 =?us-ascii?Q?YK23Na8GgjvZm29w8IWc6A7fRqZAad4FpzIKi7iq3nib3xKTGAXPkMaD4TKR?=
 =?us-ascii?Q?iylfCDJxHIfk0MfMQVbDf9dQa71cKHq3T4B5e/95JLRsXfNJrIcDBTbmkj7e?=
 =?us-ascii?Q?P8Z489MDHb/z1pTawHhdGnS6pI2CDK7IviT/O84Lv5G6I1PeHWoDKnBRVa2y?=
 =?us-ascii?Q?3WBgeOvdfmr+hj7wnRXsG9Oj1IC4Gwv0sbnsQkGhCN39pOyw7+WlXL8qs1Sl?=
 =?us-ascii?Q?nTEZ92iOepERXpt97M0kHr3AcFfFP9i+tyiYZ9sKyXiyPrC+/Uu4Ei50t8cW?=
 =?us-ascii?Q?BH6hDGBaoiQnlOOVmtpQM15XULhYlpYh1H0NkaQtdR6WPkMQzZTwkmV+5+PG?=
 =?us-ascii?Q?VQI2fY7BdHRcLg5Iz0gK2PotHe1n+ZdQ7ro0RbcjhW1wgHO3sAIO/QEwvTGv?=
 =?us-ascii?Q?gMUIqku04aEwznsltkus3Kr/OWL8rff4Pewum4yzD19LGtDyAUQ9STA0316U?=
 =?us-ascii?Q?XUOZw5H7x6riC88m7T9XWeEuqJdpCED7WWCPKSWVHii7RGkDFXYiTnl4SP/F?=
 =?us-ascii?Q?kGNugVPPbxv4KIlL6ziXMA/WmCY8jpceSuk1Q089iWuczKyieRiVU3W8a415?=
 =?us-ascii?Q?Ycv7kRdIBZEnNktYlDsMjlsYSVJS9Nb7Sn2GA1hupNs4+ZhOb9I9pFnWBcMB?=
 =?us-ascii?Q?aMSB0GeKfxRO8pYyG6x0z53xt++luzltVz4cwZMHs887JwbdufCCaE3ljNEM?=
 =?us-ascii?Q?tj+AWq7xln+1uYhTZD/gQ9Pk8DE6sTGULgq1qbNayqQiJFLtT2mOywWJbSMM?=
 =?us-ascii?Q?7TO0m9N7DTmrJoni44eeYglSvUf0jvK9DbjK+DWyfaTh6zP/Kqh9PmwsP+q7?=
 =?us-ascii?Q?Ej36SQVF/zj/Ldx7BVdI6TKehLH1ApuQYYfVVR9zi3aUzaKljBsHBAKWI4LE?=
 =?us-ascii?Q?Rdf342giYsM+odQgInW+fHPGCPnhf2r9CuTogG0vB7IBYA2RkilZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dba584f-c089-4dc5-1986-08deb09a453d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 02:49:36.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpCusXmzrimXrKEvSgLFxDR3ppeitLrXMDmY+Rzewf8aTMms7n5q/1kjFnupHkL+ejZipWtfp8T1rN7TZMCjPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5341

Implement .db_vector_count and .db_vector_mask so ntb core/clients can
map doorbell events to per-vector work.

Report vectors as 0..(db_count - 2) (skipping the unused slot) and return
BIT_ULL(db_vector) for the corresponding doorbell bit. Use
ntb_epf_db_vector_count() for bounds checks in ntb_epf_db_vector_mask(), so
the same lower-bound guard is applied before building the bitmask.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - Reuse ntb_epf_db_vector_count() from ntb_epf_db_vector_mask() for bounds.
  - Return 0 when db_count is below NTB_EPF_MIN_DB_COUNT.
  - Drop Reviewed-by tags due to the changes.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 10618e462229..af5755472842 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -434,6 +434,36 @@ static u64 ntb_epf_db_valid_mask(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->db_valid_mask;
 }
 
+static int ntb_epf_db_vector_count(struct ntb_dev *ntb)
+{
+	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
+	unsigned int db_count = ndev->db_count;
+
+	/*
+	 * db_count includes an extra skipped slot due to the legacy
+	 * doorbell layout. Expose only the real doorbell vectors.
+	 */
+	if (db_count < NTB_EPF_MIN_DB_COUNT)
+		return 0;
+
+	return db_count - 1;
+}
+
+static u64 ntb_epf_db_vector_mask(struct ntb_dev *ntb, int db_vector)
+{
+	int nr_vec;
+
+	/*
+	 * db_count includes one skipped slot in the legacy layout. Valid
+	 * doorbell vectors are therefore [0 .. (db_count - 2)].
+	 */
+	nr_vec = ntb_epf_db_vector_count(ntb);
+	if (db_vector < 0 || db_vector >= nr_vec)
+		return 0;
+
+	return BIT_ULL(db_vector);
+}
+
 static int ntb_epf_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
 {
 	return 0;
@@ -568,6 +598,8 @@ static const struct ntb_dev_ops ntb_epf_ops = {
 	.spad_count		= ntb_epf_spad_count,
 	.peer_mw_count		= ntb_epf_peer_mw_count,
 	.db_valid_mask		= ntb_epf_db_valid_mask,
+	.db_vector_count	= ntb_epf_db_vector_count,
+	.db_vector_mask		= ntb_epf_db_vector_mask,
 	.db_set_mask		= ntb_epf_db_set_mask,
 	.mw_set_trans		= ntb_epf_mw_set_trans,
 	.mw_clear_trans		= ntb_epf_mw_clear_trans,
-- 
2.51.0

