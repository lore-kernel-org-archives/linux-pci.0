Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794058234;
	b=C6lCfYO3vsR4JIRUmevdJm5cz/JGszSHvqqxIK9LCMoDLEVz0+Wmzv08Rr9Adbs8wxLs
	 0uNPjTY4qSWhLPLdF238n2ty8H7TPGN2xxg7+ckTeD0L+tQGZwV10vLWZLAy5erO/H6Pr
	 YW0BfloHLwESBGIbucSfpdCcwuv7w7HXXBuvmUVGgU5gUTWAUICXloCnreTZtgjG1lAfW
	 EjQemvWx2nM0jqcf5GiXSrWG4J7rQkX3JBfaY01SfboldTr8BXk18tjMeeEiscRSTUDgh
	 hMnltcUzWgYgjxLkkjpVsg6dQpSVqdy+ReeEljoiNrQB92SrAG0JDNhMAiGwO/TbMKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058234;
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
	bh=QKeprGnJWifTGuiS54BwAF+dTDRlM6Hpw7T6hF5DQUs=;
	b=l7wEQYl0uLBXaE4j2/+S6W34ggB00vmRfPpVMmrlYAthjR3nBL6vtvU7ZUDJHzlX51xN
	 CIShBilV09KiCegb93UfoW4TVGha/6nJK/oveLI8C45fHytcgtBTGRErxWEQ97+TOl99x
	 Xu31Ii7RiPNHSvjJcY4QVWRZiEl9lxAhg4G2xLk7WuIr/FupFsw4X9I7FTeDOJ+0kyT2d
	 tI8G5RosAiqHk0w/BsvR5vpWUWfpkoze5a6dv5wQ/Zk76WiVZ9hqFNe8q09UbgO653G74
	 43+7Kn6Rxqa2kUcAO2qQgLuwNTllo3xjUppvEYhpTF+lcYk6/YGTqg2jUbVrQ+AbSpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ghe3wMqY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.79
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020079.outbound.protection.outlook.com [52.101.228.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5135606A32C;
	Sat,  7 Nov 2026 13:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5135606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=ghe3wMqY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwOEpTMYWFXgJur9iCiX2VKKp7YqJfecAz1zIPmdW18Q+L8weFA57qfFfZL4lx4F5oidR2C7L8af+jACsIncfFdhO5K5TCb5UO030wPPzot/anM48I5Mo9PT8Mlg/LIVNUZOpRZzDHhhRNtXVbcPmLhM2QNVri19xy0eotzhCfsf23prJREJQuz/hzcFmijsAhmRoVmlvDf9Z/79d7zpev2Fr/juLFAw5lrMotSVyo7Ch8bps6NRd0jqsZDYlI93HxGc9GOoKyWf25I4ZmHWN/xo6AM2Mu8F3K7yADoaZWu3MBCtut2IaNh5JacLBPdkrnSH88SbGd3qMnrl/EX5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKeprGnJWifTGuiS54BwAF+dTDRlM6Hpw7T6hF5DQUs=;
 b=E3O68/Cf3zGCqoAa+u5Z1VZRsflwCLWpr8jCWBscTbA1phuPs+o0HPfjQY6FDCYweipdUkEaXp/wGWwmRamDPIVApB2M7xZaVu2Sp+XncLgUfDHfMaqfd62vrypMlsNw9IB6nY8YngJlUbOzU7JibjFpKRt87UIXSk30RpVstFj4a5DOXPvqHZmQJ9BNHnJd5u+fUxejj+QI9dhttC/D5vC29DQMc9jK6fP7h/n6HQEqW3WoAj0UOUtrAon366pWocEJPCDhpE5inhskgmDnunO1E9tj1kVEA+I7kgpS1EWlF+Q9wxL3/4Ls501hHzcgVRDMaa6gW63XLHivFvnzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKeprGnJWifTGuiS54BwAF+dTDRlM6Hpw7T6hF5DQUs=;
 b=ghe3wMqYka11icUhH5f+DPKNXL/ldEhG4DYqZPGRhiwYk+ioCHS/ZOCXqXcqgUjBavT/UKCBkl46xcmcMtpWuBX5lidk5RgxD3aJOdTfsVay50uY2rY4lnJOXIGNJ9J6tMGgu7N73pCogPsqnebEiTjE7IZl4BrsHVkmkTkLpJ0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSOP286MB4356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:308::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 13:30:31 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 13:30:30 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devverma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v8 1/7] dmaengine: dw-edma: Add a channel transfer size operation
Date: Sat,  7 Nov 2026 22:30:21 +0900
Message-ID: <20261107133027.364237-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107133027.364237-1-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0138.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSOP286MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e474119-0deb-4f0a-a48e-08df3cd34b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|7416014|261102123227099003|261009223027099003|261021121427099003|261026121527099003|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xLPDdkBX8CVPAQPT2cnnsA9izQeD8KMLKXaknNU2CCyFSMY76s4RRchvgmPe2l1EpyhHHhV5u1aVPtAoKCcDgIZXcs9JKpRzMhbC9tGytnEk2ktTJC2Jj4Bn0Ed/NWAUQaNtlD3jox5rlBIAtPeGGHJRDOchGAqL8ByLbvlCrlVzm/onrkQ60JZOdvn05RSUbCCHCJ9SwtyyK1vYIkvx1IpxQwQU+8uy7r5qMjWHHUAqq5M1i5Xb8DmXICwy4QdSgvYOYmuuK9atWgXKmFjg9SffKgSOsT9vIClu1p2J8sgTscU7ha9Dha0IZ4y9XEa6SgML9jVR1bnQzfFqOqqRjtacrXaTEap4m4RF3LUrHsdMzVsNDBb0DC6pGT5XGGhnj2EFLT+x3Iq+5LVeks/y1ZtlTsMIzMoFp8hNWJWT6bLsm4IG1k/3/EFvlDXrvbzGyPxDVPmmuPBqu1nuUjONn2aizp8CAqP06RfhUwMKnJRaG6Xcb0hvwhiVZOKCkTANxSyFc4KAmG8qvFZ/yfGexyXPXO1zXvgW/IGzTQNsxi2RKOBxNwGLcu53Aa3GBnKRUQnClxBE1w7j3Akob9aqN32WC22xyrMh4Xn2b2yRQek7v0yLLXoSwE0/5CMPI4TXIu+UujHDvlGt9bau/8MXPdWb//WBpeeyM0hrsg4YKTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(7416014)(261102123227099003)(261009223027099003)(261021121427099003)(261026121527099003)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yIxo5DujEPPnsdYw47tKNOaXOz42pZAqU90E2UcqY3hMibkRpyf/gCAha7V0?=
 =?us-ascii?Q?5yDmAYy8e1DQiUuX/uWU9ysrPFkVSoK38yeZHhqpDXvbhFAkhkpMGbFwONTt?=
 =?us-ascii?Q?60nZUHphLPKZUhtGg2S+5ioObAnSAOn7W6ufDWjU5w1dieTmY5aOFSi/AcJ0?=
 =?us-ascii?Q?2cW0HLK+YnmU6LRgMDiLKRFUeX6RM4QAtsq08AVcg3GK5E613JvcFVCxjv/j?=
 =?us-ascii?Q?tgZiviDGxTghT6otGbS1WRHv8pBvWTcIBOSIhKbTVpSBZN62EGHL7RC8sOUE?=
 =?us-ascii?Q?2czgpHqLANsQTLOAHr9pzx5SSCxyyfM6x/vT1ZLNz44hwWwcGkB+2oLdjblp?=
 =?us-ascii?Q?zF5VPiUjN9FTafXq+9fPMtTlyGtsNRPLFwh+rx5DCYgdY+8PxAFEj0slAPjW?=
 =?us-ascii?Q?crhOFUlpNTaG/JvEZAW6cbRfCz2WtpajmdUw04ekbTdn5cciVjhwSaPys89+?=
 =?us-ascii?Q?ahW7YQG5wp21Q8vxwNrHwQJ3RAlhYzugQ63XJH3UWM7ig7OR7hUoYyQTC0xB?=
 =?us-ascii?Q?O1GvKCiojEEYbbwRUHyiXxhZtB7C62WX4CwHW+G06yRlFh3Zz/UMiNLzJnfT?=
 =?us-ascii?Q?E03SIpLpI34QMBNKJvFPpD8FibNzRQvai7DKiNhtuToBPjQHUFppJ/PRHZPq?=
 =?us-ascii?Q?mzRkcxSl3JMX2tTwv0sGBa7X+GkX10o0kASoAnrAqXHWlXeEkDy54FI6gQDx?=
 =?us-ascii?Q?Ev/UPao8ZRyj+PK81bjzrj7IlUYHdx1rJ15LJpHN5p5ITXY67aBTwz+ssw9J?=
 =?us-ascii?Q?3oLa9N4/1uFjPC0YqYQevSAGfKZW59hKHancbLsFOh4WWHu+xbGom09m1j84?=
 =?us-ascii?Q?h6WsVbvZHMzPp/3nVw2wnLHm1pQq3RuM3adws59CzLSIskMoXADMokkbMN+D?=
 =?us-ascii?Q?h2rZ9tlYKjFPAGMhpW+iQrzrLyAUaubhU7P6yPeo+ZPi48EhO6R4s9e6jdMX?=
 =?us-ascii?Q?GuZ4nkbc2yKS6sznSBCfuw+Wt2QNP/cX74ZSv84v0tVHhUdYq7OXXoPiroX0?=
 =?us-ascii?Q?b2xvazqhKUMcLGjWBznyGkIRS3mcNRsgHYF8ZQ+nD48Lw+D8Lq89XBU28y8p?=
 =?us-ascii?Q?PX2w17XckUfuCnRwpFLfzfU5n6MYOcyrX6Z7KhqGADXMwt8b8LlCbGKHJYZc?=
 =?us-ascii?Q?62ZYS3sFB5y0WjHvMp/OAIj3+wyQmp/KK8z316ZeR+KTJm+RlFN+1GIWQyLj?=
 =?us-ascii?Q?q2FW6MIu2h57qw6SSUOySZ6s5wVmuaFjfpWXHpoIMHZSiDhdfHxbOc/W3OVd?=
 =?us-ascii?Q?lXd5CKFM1G8E+x8QMMZMGT3EGOB0UcxG+5wd+DfRG0230193DTAY3dJlHI7P?=
 =?us-ascii?Q?mpRuWnq7E+ifR7kiBpAwYxLwu9CgdKF0nb03lQjpvFLFcZ+YrR/3U9pF6X61?=
 =?us-ascii?Q?gkDpUDuYTzr86GQOizomqo64e4pDuOKFV1GFUjm9vYBZ9g0aEy/lM6Q28xQy?=
 =?us-ascii?Q?Bcl7fdrwYORo70xrl15KQNeQIhDM2nZ4OBJFDoWjnxrg1gm7TieXb5NxESgY?=
 =?us-ascii?Q?FUrP5/tJINlmrohs6VMfE4XOw6FrdWhpq7KNihn8if194ibCMPOdgibDv7bc?=
 =?us-ascii?Q?NeCFAuRq7lDmltZ/wXWSpacYG3eS0lB5J+lIKl6xxvuAd1awkowVEaerS6BU?=
 =?us-ascii?Q?b9gsVx3uL159IJz8yiY641W4fGmvKcT+NrOLbhVq/ZzOQz+s0/pe9iAB5D2Q?=
 =?us-ascii?Q?p+aTzn2NtmH0lUe1Kt9QoBTHV/u5mgMhHCFWoAK2e11AyrZjIqnTgv14EIHd?=
 =?us-ascii?Q?/yjznHM4acvIDxpi0folNgW8c7eNakZbs+fRTgvw/t8MQVYrS26N?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e474119-0deb-4f0a-a48e-08df3cd34b20
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:30:30.6753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0bFeFurSxRlj2L7fIjieq3DrzALOYafJkDFIe3n3q3QR8GDwZx+XDrYSQR/+Eag2/lPmz8ndS2AA/MDMK5LOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4356

Expose the channel transfer size through a core operation for eDMA and
HDMA. LL progress handling will use it to check for a stopped channel
with no payload left to transfer.

PCI Express DM Controller Databook 6.10a-lca06, section 7.3.4,
"Detecting the End of the HDMA Transfer", documents this polling method:

  STATUS field of the HDMA Write/Read Channel Status register
  (HDMA_STATUS_OFF_[WR|RD]CH_i) is Stopped, and the HDMA Transfer Size
  register is 0x0.

The same condition applies to eDMA as well.

No functional change on its own.

Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes from v7:
  - No changes.

 drivers/dma/dw-edma/dw-edma-core.h    | 6 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 76fd5a41a707..84a811bdcb6d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -163,6 +163,7 @@ struct dw_edma_core_ops {
 	int (*ch_quiesce)(struct dw_edma_chan *chan);
 	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
+	u32 (*ch_transfer_size)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t handler);
 	void (*non_ll_start)(struct dw_edma_chan *chan, struct dw_edma_burst *child);
@@ -262,6 +263,11 @@ enum dma_status dw_edma_core_ch_status(struct dw_edma_chan *chan)
 	return chan->dw->core->ch_status(chan);
 }
 
+static inline u32 dw_edma_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return chan->dw->core->ch_transfer_size(chan);
+}
+
 static inline irqreturn_t
 dw_edma_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 			dw_edma_handler_t handler)
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index c053cb4c2844..fa8be85c7ac1 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -318,6 +318,11 @@ static enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 		return DMA_ERROR;
 }
 
+static u32 dw_edma_v0_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return GET_CH_32(chan->dw, chan->dir, chan->id, transfer_size);
+}
+
 static void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -665,6 +670,7 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_quiesce = dw_edma_v0_core_ch_quiesce,
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
+	.ch_transfer_size = dw_edma_v0_core_ch_transfer_size,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.ll_data = dw_edma_v0_core_ll_data,
 	.ll_link = dw_edma_v0_core_ll_link,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index d42cb4ad49a2..aa430219d0af 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,6 +156,11 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
 		return DMA_ERROR;
 }
 
+static u32 dw_hdma_v0_core_ch_transfer_size(struct dw_edma_chan *chan)
+{
+	return GET_CH_32(chan->dw, chan->dir, chan->id, transfer_size);
+}
+
 static void dw_hdma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
@@ -425,6 +430,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_quiesce = dw_hdma_v0_core_ch_quiesce,
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
+	.ch_transfer_size = dw_hdma_v0_core_ch_transfer_size,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.non_ll_start = dw_hdma_v0_core_non_ll_start,
 	.ll_data = dw_hdma_v0_core_ll_data,
-- 
2.54.0

