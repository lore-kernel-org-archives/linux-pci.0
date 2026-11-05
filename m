Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905172;
	b=e6X5+n7IwJdnfPyzvRNip4jsFNenGWMYNtrOLdMS/6q1Pc9d3Lc3AS3a2sLpkk4GER+T
	 Fjsv9K8it4gyV06DEia1zdDlUZ02tOw0Igc+T1f95fEf2xKwiRhWhWDVByemIHSapPQ1c
	 YGLyJWimpSc4oZyrxGWvriZtkQjOZDIwmGhcN0NcfTJvk21U9mGZjHKwjmp6eLfcQGNVE
	 Wssrxq0yobzUFRdjDWPyMa6wVDq1KkZ/M/hKrgLbNaMrWTVBOi2uOYI+qq+2/epXgBmaf
	 KEKV3aXh43dz5NbEOy+ftQl4o4+rHWAsPiUOGbBD/U3bls3QbIZpKHU8VxQbUnmeVwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905172;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0Ly8F450nZ72wWTASogAS0fTpvz5KQaPbjkEOw8C+r0=;
	b=UKuuQ0ju/8lJNV0TsPgsWtrMbgFzj8DBx8aSwc1BJMBp+wXSpYrTrzhNidfJ0mgbpPJ9
	 q9YJ75umE7Okt5rEkUjfuIl+oH7Ph+lk6ZphVxT8ySVtR/nP2clpDlwkhErDbZKxWVWP+
	 chZEMcbztGj8aT3GqtM5FLCX438F+zDjF5IBh3jnP5tYeRuxqq3W1r48TKhDdHSL08n7o
	 Ait0YLsvt9tiFD98U+Q10bp4W1ETKuAsyOkCsFzTXB9gLKPeLplkA9tcXXOkvbI1EBO+s
	 +BjLe4HGKnsa2g3PAGMLJW6pRbKl/Upbyz6inJqao3YhJ3m9Ou8JHizbt5hVJUxsN4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LgxdAVLc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.25
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF650606A331;
	Thu,  5 Nov 2026 18:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF650606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LgxdAVLc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhAd1nt5/qyMgfD58Y0/vpmtSlEHTrLLsWTw+r41mfMAsjCXvA3xk7cj43JHIDGQtJRe3eLiOLGvYBFbE06xR+jcj0hqviHe6/oP+DtB9BO0YKqrXigg83EO55ZmVgZpdE0OpekmyIuhDv/If38Ec3ri5dS0G/jN0mnIKosUI+wCuev/fwRaIuND6tCqSGvlR7oj+Ksvf4zS9H5+4cb7EBGA/NS7uoMIVhkgOO27hSI3K5bxzsxF1bPkFp4x4O4X/nP1u/bEpAno/zwAVQugwm8wX7sesKyNSz+N3iWe8DmFrHXD7NSIPSsSkh3BUBaTwJvQM8VJ8KjeT35wHv1D6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ly8F450nZ72wWTASogAS0fTpvz5KQaPbjkEOw8C+r0=;
 b=dsP/gVXkGwuycwkYAEFSytcVKXoyBw57o4up2l2h5XedtC37hddg+Epxcdz+JNoc6o/8zX+DZD2KuiSYuzCA1a18XURFZZsssGsOODhepAoFIhCD12HoiPzLom51TkVFDuKACIimiR9cw7R1oA9TDj+kn7lOMdVzyZ/8Sc3r57VTGN6UtzOlMcK0dhB/1z6EasJoKqW03UF9T7P/EHZpdVOQTne6oQU+9ClPnOOwiuEpfBYD+cxf5Y7a/KpY8z1jbJFp5uU0nCbX+nEtneZnjZdIhnaMiF4MPKrCawTiWe5D4h+QFk20uHExJ6VyigOi4ylA8qPnwP/AG6rLBUZORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ly8F450nZ72wWTASogAS0fTpvz5KQaPbjkEOw8C+r0=;
 b=LgxdAVLc3lsNyp4OWSUxF4XsGMN3BrXf/jWYmzcbGztqLg8HWvTmCDzihCNdLoI/3tBPNObOpw0LRUDIY9a3HZ3RBCIFi/oZBNIlHjaARZRoYZl4jW4x8X5EVb297QacZ92EznFrwCnp4LCyr39nFVBssSj7QnYi/UK1rQArvQ3dxfkbDbsL+UmcR4BWZPQN3Zj34yNUekckxSk2t2pm2GCiJudSaelk8PxxRdoJfTyNfKaAeWpU7KRuvEbRNN1eDfvQd80EU6s2JDX4WOinZ/b9XbN2jAEzJOAi3FgaAJNrueSuGPBLVuv6oGXvIUaLlQ5OrMt7B9/NaKpGSILPPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DM6PR12MB4105.namprd12.prod.outlook.com
 (2603:10b6:5:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:25 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:25 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v17 02/19] cxl: Share CXL port upstream PCI device lookup
Date: Thu,  5 Nov 2026 18:59:00 +0000
Message-ID: <20261105185917.2667656-3-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::25) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9689b1c2-0bf3-4fc3-9590-08df3b6ee948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|921020|11063799006|261026121527099003|56012099006|261021123027099003|261026140227099003|261102130727099003|261009223027099003|261021121427099003|261102123227099003|261028144727099003|261022105027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	pLcqqJIflBzqIABJM61BAn9xDSY+pGefas48UxI4YUPXJ2K8ySHJRCz/CmIXMthWbN/E9TlM4S+PJvd7EOZaScxPxWJ15QWrUkjPzOzt0ajWSjGhOpfN+AFVx8HZilJxdo8QOA8pl/ONvNwnr418kk2+NJmgvpopJzXyn+3UaFxU+iA7IeCGsMeco8HTMUqSmQWJEGb16fB+A6ls9lQk6mOy5VRR2Bo8J2B5VKQ1kAWIbihT1x/7C1w69NogzvqcUQ8CeO+/Xk9157iFdDKUw3Ab1WdWC2Ss+I91bYNSx7cEHweqctSp/q8f4HucB0pEy4evDtvWD3WU7lRTYCJOP9QUnrc2vV/xVvFEU2ZIDv0VbHNsyc08rvGkl/wE/52Sc030LXcKUpjgF+E060N/hcHAZ2SbksnEyJVUtvViznsCGM4B+VFEgdQapM01RebDi7uZfoNFZNtWfjvVz24+9etWAYZuzU3Ec1hkg/WpKVDYNjsvI9Qf8am9M6bTrcgkF1wXSRrWciFoX0GbzZUXPaaORrr0BmqYw9dUN+NiKNpVaO01u7dQKtHa3oWvJuhna84aq37gMtodq379pvbJ7yYOlxxp8RFCjPNO0/ecjK5o1Yfv7SSpMgcsLm8StcuJDG16iDbznv9ilRsRp5KkTjYXkt9lzGo0QiKSZDksywiIFz0UCzOIUkNoAtxvLF12APtQn6gFVpLrDL3y7I3BTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(921020)(11063799006)(261026121527099003)(56012099006)(261021123027099003)(261026140227099003)(261102130727099003)(261009223027099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5pGPp/iXae91IwqRNCJOeXBcEE/nr+4mHmNDRPTRNyhSRJx6GEDLQUQRQBH?=
 =?us-ascii?Q?nqw4v9n//A3U2KT6vTUO9UXuZMjjdPoQcaXNQ/grd7s/CQ64n2rWWGaqljkm?=
 =?us-ascii?Q?jF0klSGRd4kVCEVJRYoWlVvXRs1uEUK5i+3rpUuupizIqOl8rBOcQQ+eDhoR?=
 =?us-ascii?Q?0XjqySj2LSgxpKNUKclE2JZ3isfNHR2w89gjNdBfAJeUnaeMdY6KO8yE2X81?=
 =?us-ascii?Q?Ne+m1WgiBi3i8XyoBM2nlW0YGSTEshI4brLtk0r5m/SmWMsFNdCXoBCPXFK8?=
 =?us-ascii?Q?8sYxprp++rdfMWVeYAKeNnN0HT8WazjvrYqh6rRuEb6cvTzZCzuYXwYiBPqX?=
 =?us-ascii?Q?M9fPW0oGm/mFIqpZPbgj3LncXPBTAqhUrWnuJcT9Y4Rzm6tcS83LirORgj/0?=
 =?us-ascii?Q?m4jcKwWmE+lfu5qHyH5F4gMLZL3M2S/RMzt3woT/SHQANb2DAf5/SJ4Wviud?=
 =?us-ascii?Q?L24srQTNXxyyiVcGN19rRJ/XMkeUp7e9iJ5YL+TxHtxBsiNjkcsLG/UYjQOg?=
 =?us-ascii?Q?E+mNTL7oh7hYLpghN+Mj616btFmeNlwpr7lKppX0a5S8hXdOTxXJDMGDPHcY?=
 =?us-ascii?Q?BKkshEAvnUVn8Hzp4LW0IoP8wXdppREoirNH9fsec0YwnU/rYD93nUcGK54z?=
 =?us-ascii?Q?gU/6KPOIJyGRFHM1lRtSgRcrWvi685pU4ZsPIyJZlSKHQ7qtwADp/GbhChCa?=
 =?us-ascii?Q?/GduoQjVeaTT51/R6aLQ+Ay4XSIeHJv6gBj5cLbON6RLaiNS41sytaWXkhAG?=
 =?us-ascii?Q?Tk1tGDLwaj8aBnTCoHCG7UqKx1VxU/Hhq0k5kZjfbPZSEXoYtEqhpAXpF+Zm?=
 =?us-ascii?Q?mSHEEkdCY2TCFEIyvApwLf1+uOALSFq2kFEMOXHezV5TekHJNFFuMEa+Ie0k?=
 =?us-ascii?Q?OdtzOsCX3zZb0h5d4GtcSMLMSR9heoBa4hz5PkIKaCyZjp8cslFJpsTWQzvY?=
 =?us-ascii?Q?gxc+aslGMliCFzuEoKHo02N95lXN0cFg6+R+zSapgR0/6hSwVpcA3/uCeUBy?=
 =?us-ascii?Q?0Bva7U7HElmyz3OTFxlje1Q8J0xaAV8fj1/UQErlH+wLjxNnju6hnxmkTFrN?=
 =?us-ascii?Q?kllvvgx7PjvbEPJ0eIlTDEAuLdsLqTuAe3hAHvjC5IrMv7CWBb/DGYuifX/X?=
 =?us-ascii?Q?8D8Yr1Mgr6b61dy0TBLIc5ybT9Os24dW3CZ+4Az9skaJ/J/D79UYweNUDDxE?=
 =?us-ascii?Q?+SFlGDsvusjOhhkHzSKAMks9cKCtAAL/Au0mBtW1p9sMpzjCq/wCv+ghB+5U?=
 =?us-ascii?Q?dCmOSWpfOmDAzvg4DNjAcJXFAZDYi2V+nPwVBgRr01SMDMhrBAHlNn/3AwhU?=
 =?us-ascii?Q?7+Qg5Fy/Ny+EI5MkYgVIXtRQqVutdjWentKT1XtsXA1TA/S1ne55SoWEuH28?=
 =?us-ascii?Q?XCpy7yHiCUzd36VAseJTR6AbMNECjCFR/RBk2swdma6ZYIfJC2ceP0pgmJZa?=
 =?us-ascii?Q?vULSEZUmXlOtEr4YcwGEnNrhD4zfdpyxt6xjPHSRavoDNHd1T8tK+Ivdb9wd?=
 =?us-ascii?Q?0bq+MfYbx7Y+EMAFzXwCQ0PS2eMK3HsecXPWGscObA9CGjLlDElTzrlZAtW+?=
 =?us-ascii?Q?wH0EowJmT7m8sqtMDn5ue42x7Rb3rv86DT0erwpRNxsPuRz2Aecedccgz88O?=
 =?us-ascii?Q?FaHmFdVl+GP8mRK2EY+b7HtgzeOqIVCVwnM3L2dghS8tp0IT69S+evIbJqj/?=
 =?us-ascii?Q?DBJ656ATbF/EQ1mRiGfmMBUszSm10R4XGE3zY2+R3NsBVNJdLwas262F7muP?=
 =?us-ascii?Q?NOe3MmS/Hw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9689b1c2-0bf3-4fc3-9590-08df3b6ee948
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:25.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3T6KRPmFjMb8GbEfHq9uRpH632NTvymT7ssu1sLAd6K054nmFVLsUHWDnxTIkeIExrckOQr8VW5W/pRfA8wWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

read_cdat_data() resolves a CXL port's upstream device to its backing PCI
device. HDM cache updates need the same mapping.

Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenced
PCI device to make caller ownership explicit.

Use automatic reference cleanup in read_cdat_data(), as suggested by
Li Ming, so early returns release the PCI device reference.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

---
Changes in v17:
- Use an explicit pci_dev_put() on a single exit path in
  read_cdat_data() instead of mixing __free() with goto cleanup
  (Sashiko)
  https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=2
---
 drivers/cxl/core/core.h |  1 +
 drivers/cxl/core/pci.c  | 24 ++++++------------------
 drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..983d7690c3a5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -157,6 +157,7 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port);
 
 static inline struct device *port_to_host(struct cxl_port *port)
 {
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..905892cfedef 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -564,26 +564,13 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct device *uport = port->uport_dev;
+	struct pci_dev *pdev = cxl_port_get_uport_pci_dev(port);
 	struct device *dev = &port->dev;
 	struct pci_doe_mb *doe_mb;
-	struct pci_dev *pdev = NULL;
-	struct cxl_memdev *cxlmd;
 	struct cdat_doe_rsp *buf;
 	size_t table_length, length;
 	int rc;
 
-	if (is_cxl_memdev(uport)) {
-		struct device *host;
-
-		cxlmd = to_cxl_memdev(uport);
-		host = cxlmd->dev.parent;
-		if (dev_is_pci(host))
-			pdev = to_pci_dev(host);
-	} else if (dev_is_pci(uport)) {
-		pdev = to_pci_dev(uport);
-	}
-
 	if (!pdev)
 		return;
 
@@ -591,14 +578,14 @@ void read_cdat_data(struct cxl_port *port)
 				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!doe_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
-		return;
+		goto out;
 	}
 
 	port->cdat_available = true;
 
 	if (cxl_cdat_get_length(dev, doe_mb, &length)) {
 		dev_dbg(dev, "No CDAT length\n");
-		return;
+		goto out;
 	}
 
 	/*
@@ -624,12 +611,13 @@ void read_cdat_data(struct cxl_port *port)
 
 	port->cdat.table = buf->data;
 	port->cdat.length = length;
-
-	return;
+	goto out;
 err:
 	/* Don't leave table data allocated on error */
 	devm_kfree(dev, buf);
 	dev_err(dev, "Failed to read/validate CDAT.\n");
+out:
+	pci_dev_put(pdev);
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..5dc2815d82d8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -34,6 +34,32 @@
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+/**
+ * cxl_port_get_uport_pci_dev - get the PCI device for a port's upstream device
+ * @port: CXL port to map to a PCI device
+ *
+ * Return: A referenced PCI device, or NULL if the upstream device is not PCI.
+ * The caller must release the returned reference with pci_dev_put().
+ */
+struct pci_dev *cxl_port_get_uport_pci_dev(struct cxl_port *port)
+{
+	struct device *uport = port->uport_dev;
+	struct device *host;
+
+	if (is_cxl_memdev(uport)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
+
+		host = cxlmd->dev.parent;
+	} else {
+		host = uport;
+	}
+
+	if (!host || !dev_is_pci(host))
+		return NULL;
+
+	return pci_dev_get(to_pci_dev(host));
+}
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
-- 
2.43.0

