Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021109.outbound.protection.outlook.com [40.107.74.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1F32D0F5;
	Thu, 15 Oct 2026 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035076; cv=fail; b=Z2LyAgrod1J+tyNczSr2f4zTzL1kR3OZrj6NoDrbYfW8E2ZFOXnqBtZ9ItFrtj9B3Pp5IqPHrUmLmyNIzb+5TI8k5a079LOLU0mttjTkbKOkD60Rw7RgIzeYgkK39c6Dtt1uCohxAv5vc9bVhvPIVCVLLN2Pmhi43dkPcEexieM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035076; c=relaxed/simple;
	bh=AejOEdkyTt3FOWUsNT6+1+BzTpF+i7j7LicIp3ij3ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R5dL8UE0ONmptwWbBrG/nKormAqyCBWKBbKC0mGyAHHoE/nRElL40HhG/bToSx3u5t7RJeOpQB6ReguWMJ7uvHSbE4AkxUe3OZJJWDRhNNK0WiyXmkX5FjMe98LzE5rKOGJUkV7nhZwoeR3rIyJch59b+f7nzBu9HJfmL0SIhyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aihLmum8; arc=fail smtp.client-ip=40.107.74.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aihLmum8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox/d8QDpFB8Iu44O1JCOOoHgcsPi0wXq548FXAsPBaLbZoUVDE/Sticn5W0/PKFeQn9xADSOnN6wqWGNh6TaUzkhZtmnuVjzv+w/jGCDV/UG/B1B9KXFNYvwiURrecFknSIgykq6uZkndZofro/KlyPDRAFIAHQKs+X8Yx0IebrJ0WNysO1UowPm1cmv+95eb/SZavZJ74DWCy2shl/hXHdMkS76gDW9BXy1i9fa2UpZoB0r65nQ26Tvo1iFYFIw3hm7UzTHZ27Y/MEV+tPBuf7gh6bsqYllZKSR7aSoLTh+aeW2g5Z80Mp17kN8Ru1IJIoJNNsUxABcT0BzH0OF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcJ+HB1qtczVfdS6u7X7TkCrX7CANWVt9uLN/89rxqk=;
 b=o0IBj8HLCkHq4YtRUcfQ5WcUAP6Vfx2wEwxUAXyVHr4dbXTXeP1ejranZ81JKhb3es2eSeBkiKI1SzB932arxjkJ5Xs/ORlBXPyQwObKVmwtRXuBs6eihJpTdzUZt/OAvDJZEUfFIKHKYG8VP2/YsHykAs8nUwWbz3JQNIxXXIy+egCWLMg7KWNgTxB6scPUkRbs0dq8YN85aZuHuwX1ttNxQICYu6oNj77PJLbu2BM26XuuxtuXoPMEJy19Xr4/sXMlmZxOn9FORZtpUJDfNeQs+SZy2ZrQvpdke2nImC0GpKzqVdViS4zWUxFXXE66YE9S5fmLXTUwXIhZr/hiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcJ+HB1qtczVfdS6u7X7TkCrX7CANWVt9uLN/89rxqk=;
 b=aihLmum8QPKt24qB+J+VdA2zYhrJBA2swk5gA7h6MsbRYZvm2XUcqlMSzAylX1kiVQktSjp/Yx+JsdQ/R98o3+2UPPT1Ge2M77AJY0PoK/gBBAcu20uuaOnG6NGfy4j0ChBe6OEajT8YPCd5IKxy3Xa1qC8FJh9FeuNzDSrRaDs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2699.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:31:10 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:31:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/18] PCI: dwc: Add Renesas to the RAS DES VSEC list
Date: Thu, 15 Oct 2026 12:30:46 +0900
Message-ID: <20261015033103.3076869-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015033103.3076869-1-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0073.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2699:EE_
X-MS-Office365-Filtering-Correlation-Id: 39aa2bf4-cb37-43f4-02d7-08df2a6cc1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|7416014|366016|376014|10067099003|22082099003|18002099003|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EBZa7BBSCxqPa0vjd8Tjbs3fvyqXLIRPr8LaRDZSQvm5ihkk6QA47BkSsjQ3xmzgii875tRxNPBhVe0ux9PUN1h+L7mZEZ8AB/JbXLLcPMWB3wyOqtCySMQUgBVRgMXseC/VHiRxkdEw+ZeVQ5KfTL22kqhqMiluUsxC/SN4VRkPcpiSOiDZt9URVUi/fZBrQxCUE/j3t9LOvA0pfM5PA2v+SyBa/UhXXYxzVyDIS34gF4jhi/DT2XGnDfiTXLUu7bd1rVrdhUnzK8XYXvuyJ01ZXQfv0JA2mflXlaMn0l/BXYjSxZBCiablIXJw52VPqmg1EfgvcUqGcGJQmaO/EdUnKg87H6mxLvzA3gOAVtw15C0qg2HDqHzimaDPURbt4LfAnPf6Wf2XMIDUOm3qdP2hXqX3Gp2YKyZWnM7W5gQ0EodSHElt4Lt8RotIyksN5AcPMAjWleHEh9nu7s3n1XbuJ6otta1wY5nV8QDon/EiNQs+DKxt0Ba/kpcIlq8Pwrv3a/QUU3rDLtWo36tfJLfjBmX0iruC0fkdl+W3d497e/j7j04Yy2Z1uEETbF84bhVuNNfMSUup2rHW+iT4CgPnTHBAgkgO8qBqXSJTRs0I1cONwgChmGml9CwYrsxhuW/1MYMCBt2D7//8Zr8wfCDTNzuogpD1kwYY+OuhWDQpAw6pvX36YBOinKPeG67meQq6S76hpjY91xl6SbBqEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(7416014)(366016)(376014)(10067099003)(22082099003)(18002099003)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EWPEOvh0LVpQ4CRiv+TnyVYU33H2djYGcH9um2R453ozH0DvMKRRL90Rxvkq?=
 =?us-ascii?Q?7Q3KqJ0Rxxm2Sg/uifOvqYs/4VGmcq93zGo/3Qqa0KO02RXAneiZtivYX1HQ?=
 =?us-ascii?Q?Olc0tS5qwLAH8P8d3dSVPnene9L1HFxZoJ7/AIP9yK9J9aa9BC6AXi6q+GAE?=
 =?us-ascii?Q?SxhCmwZGzhTSiyt0FV560zvxUjg293iRiiOQtGqr5VKxSSWYRZTWfnBBY5wI?=
 =?us-ascii?Q?6y8nB6LGI03BIjWcE2ClLl2lRIpdRPPWozsbe6Ezk+HBPI6Apw2CjH8MXOr1?=
 =?us-ascii?Q?lJCgKo/rQYGl9pd6K9sLB1R7itJbLyKFxR8u7L3VWU4ZMRTicnuxMDViAkyF?=
 =?us-ascii?Q?YpzW0CMzdUDBV/xyNjedEbDde5KBknq1nCOKgx0rn0eBYPn/9HUvj7yUTHgT?=
 =?us-ascii?Q?WOTQL9tdfFAZr8c6SjZp6vhApyNGYaDylL6h0BvEzyCX6Kx5FMwguwpKmlzO?=
 =?us-ascii?Q?+JND7ZsgLFUdD6R7vhE4C6zsnCfG0XbwE4WtEmTDVS/GAPNdbFMIMz6j/Zjv?=
 =?us-ascii?Q?wtyllgvtUOqYb8VXudKswLjjvjQLHH3EXQmKZQgZc0nT+zUPlmxkBK/Bv5sQ?=
 =?us-ascii?Q?MjPvVjlLUIbMN/Sf4IqDn+7CtemvcGam4KDCimo2yAE5D84cLYjbIEnB3XRy?=
 =?us-ascii?Q?y50u29J0GLLPd/lNG+iabq0iEUhJ5LO0gLSg2bK8dx1RGS1IIhTVdcIvLNNT?=
 =?us-ascii?Q?sQq8H0Qab6shW3fmWGwm9z55E1vKHxttxDxzFIFrpOar/7tQAPJ2z/wdmkTM?=
 =?us-ascii?Q?nHHIsx8Qpilk/MhKEYjd86V0cqfeiVBuKEU4kcF7YPSPGW5k6DXVSjHQgHJm?=
 =?us-ascii?Q?Ur/JG8ZmyeIqZ/G1yLge/JBp203h0KRZYTnWIvLpDQ+VNroW9/njFlxtGJbU?=
 =?us-ascii?Q?/rviSo6wn1yQ3HMpefwjbg9lHz5I/XkI7JyKS0ERIhskXeWyEtHuMSmWQ+fQ?=
 =?us-ascii?Q?f3KfBAjVk75ugZpxKflkrKx6ZEM+AjVtnD385JqdkS1xU4fE+wfux5Q9HrMI?=
 =?us-ascii?Q?eFti+Ebz+V0D1u9IcAjnE0lfq/kMPCO+yMTbEhFb3u0IB2BHOsvQfyHWhVdQ?=
 =?us-ascii?Q?4gzKdbvWj20oRMl6yvY6a4yGFJkqT0B55GwTHGC+s0rK1uMITMhnOLWlb+3X?=
 =?us-ascii?Q?MFvZF6VWEBhsBRgsPjqwdMWjeByg57aTCorDXwvMkHOB+KxQPz6E5VM3Tk0b?=
 =?us-ascii?Q?8hs74UlJntsepbkQFQ+7y9Hcv6Pw1yU5rM3b0v5D44iXK8jFbmCnf2Pi5/O4?=
 =?us-ascii?Q?IMtBKSNyFZYMqRHeQMlEv3DjWCZxHVVvW/anN0DCKEDNgvkfpewGFLRnrFDi?=
 =?us-ascii?Q?CqqdWiWp0kJgTke5k6OLInPktd/H51Q7NMhKsBLGx/ZdQqfw4jh4R7dTaUC1?=
 =?us-ascii?Q?hCmaDj0+62YqPUFYQjbBE5Egbs45JfDiVm81yhOsVSXfqfWhMyfMAadVcHZn?=
 =?us-ascii?Q?M2WfdjdGXGxMIze+4mdv7moccmbt8a0UpFap1OuRHDieOBLczhtXWBhsX9t+?=
 =?us-ascii?Q?pSX0XmvXM3C3LDmf44WBx9Rb/8dBib26sLxBb5ylXh+d/cT9X/F0hWmhlmwM?=
 =?us-ascii?Q?poU96DsYuKvWardkVXYK4CmSTkOQnO1wehXDt8U7yvAcdIh7PQINqHA8YO/z?=
 =?us-ascii?Q?x/ZHh2tGLkcJp5/5m8FzSVBlJnrdj/6C+iK7hhkcCl9AlYW8juUcGUT/CQ5+?=
 =?us-ascii?Q?6uaxDJ4RVp46/4iIjsoT3+WXhI5vzP6Mne/mN4NuxinQY7P+w1PVsdXGysNQ?=
 =?us-ascii?Q?WlGbL2V+vIuLqcr1cqCniSwJhKV8AdbWesKivkGXoXYardiwBfzg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 39aa2bf4-cb37-43f4-02d7-08df2a6cc1b1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:31:10.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoc8MJedxXjV39+mCQdUQ94rhxjwiiMFfVe7V9GlZfXkH/kwpLgXVOMnayS2RE4dimKSXfcMoA8sBtyEVcUEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2699

The Root Port on R-Car Gen4 SoCs (DWC 5.20a) carries the RAS DES capability
with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes since v3:
  - No changes.

 include/linux/pcie-dwc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 097e806c714c..e5693895dbd5 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -38,6 +38,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_LECARC,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_RENESAS,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{}
 };
 
-- 
2.54.0

