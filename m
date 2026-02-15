Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020074.outbound.protection.outlook.com [52.101.229.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123632F362D;
	Sun, 15 Feb 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173552; cv=fail; b=FIgEpifdeUAB0ReqXpOiKiSZutb/7k0tl/rL+c2+8YFqWACQ8qy7tFnii/z5vw+ZNdPWydK/LMO5sSe7QPlkhnFXzXp+CD1n3RMaOpG24fN9uxwrYabGL9Gbvah4gopdTrWiALHp5fKTEAN8XAA/EXQEQdvWsVmz53UDZQFsWEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173552; c=relaxed/simple;
	bh=Ib6kKl56UDvr2Y5Q/apv+VJV7oYBHV7X5Xo57HHyFtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G6sLY1LESl1lUrtJCs7XVj+QcJb6oHCcUogP4XjMuQFRRZXe12GbfGtOzl62nxjqMZsZKPgXzSYvEQauUpcR93gzXYUCUGP27dRJqN74oa6oISc7LgsT4De9VagvIZO5c/coZMaMMYvR/z5xWg2mlQ4Bi3s3tgvlOmqO1IrZLLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dn+Hy8kK; arc=fail smtp.client-ip=52.101.229.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dn+Hy8kK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3t13V/x1GdbMVe7gKGNZSFH5t5evaoRLUc4OQhQE/UjSXeRZ3qpojQN/NUXi8Lq5oKEPaFyRNR2aSKZHpGtZ0MUfI2cxFGUiR2cV72V6jWP1R/6ljiWgRrorFz2H58PD6qlykvCvLI0OhTV/J4SuHCy1D0T1ZZmtgZUIS6N97NF5NRwfGl/8jBFsMcg5RlDu/GyZA8tW42583pRJL8MN3lBVLerO5wWpkg+1o//EMmA2e5MLXdwnLAhzgIyf21ONsa0Che2dCbGHc3fTiUgoheSBWQ2zTs2gJ/CDeCmIko5l07Mc1R1iR0HXCMbHINAPxeKWi9674MaI/0Auyz1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j7VrNny21K3Eklartc96GfIRWb3fbVSSm8HKIdXzYo=;
 b=tDb9bhYeOHC4NAG1639vS3P1N3NO0gog/KT2PNnT7R9iHHi/ATTm/UxYLMXRQEEIbFLlVsEbUoEKxrgLWeGJI4LyfsNZisyx04z6vXxQfsFUvKQ+hfFjyBvST9tLaXBPKsK2TmmM91olUE88XoPG6g5oFXLBkugwK65K73rZfVhlhFtcoxhmnWxpOJoOiPGuKq9GVm9XGi3u9BtsSLJ3Cu2PX1VxPzc+g70CxLwp/KbQNaBwAl8VuTc3CpiQ2oiJKs4ALItR2kTUK5OPMzg8waAK3AJuNhS5kDtZhjuSG7N7qy1SmsXm8oTCL29EIZiZI91EvfZ01AKmQLkm1dzjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j7VrNny21K3Eklartc96GfIRWb3fbVSSm8HKIdXzYo=;
 b=dn+Hy8kKhE60RiSnpae3rPNXIorT8/vipnoCkQ91X2JYOIwJGnlqrpSNoGO14JG9MqhNOuj9+JopUyzf0N2bOpe9IteL3f1+68Fvg3LlQvcM9K34qyBPb+nyPNPnrW+Ut5DkeLCIC1noQX0WNfWvIfqDEymcwurl3Up38yDVC6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v7 3/9] PCI: endpoint: Add auxiliary resource query API
Date: Mon, 16 Feb 2026 01:38:41 +0900
Message-ID: <20260215163847.3522572-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215163847.3522572-1-den@valinux.co.jp>
References: <20260215163847.3522572-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: bf366e5f-ffe6-4114-cc12-08de6cb0bae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OHY1xRdcZDRDL2kSXoUPJMZ641OJlWno1gH4/kD6nKkWHbjqWtLOQGfm0AZX?=
 =?us-ascii?Q?BhhYBou2sQ+Kp1860E1xQaRAxjmY5PjYIw303bcs9jsf4A9zqQuy0k4n5y/y?=
 =?us-ascii?Q?0AOa5TNt1uQX215yVdysOG0bwD9nWdz/npRxvoGPNaE5xYZ5DSTiO+Ix8v/M?=
 =?us-ascii?Q?4TV+Ycqpm86UdsP5WFyTOUObWHLQCff19DUqSit9weFmhH14GTW8Mqr7f28Q?=
 =?us-ascii?Q?meA2XjfHhFjP/oTHUsG/H+RKxi4gsWmI9HM1wvwrK79KaOIYd2xtiK8Xv2Kp?=
 =?us-ascii?Q?L43/JFYxphnMAoJ2mcDg1rjmSzZy7oSLlrmjNIgikv90/EzBuDAZr+d0VmFr?=
 =?us-ascii?Q?yy280wa9yOkPrKj6uEdDKgmN6anknrqWpJEoS81C18T5kmO60cRRIE1LQzJw?=
 =?us-ascii?Q?k6H56qHFLl3gM2/UondIK+NMwaAhE5dGsDlFzzyLt7aBqMc+IpmNQ5qWhsID?=
 =?us-ascii?Q?QOvocQSdjoFL/p7qe99yMG4V0VZthV+56XVnV1Fih7LGhf0B1P4vndcGHEDX?=
 =?us-ascii?Q?EQvNiNW5eLiNhDwpG5KJzcgZahB52YNS0P91i9FUyMq4eXX/GDVWXGhZLnaF?=
 =?us-ascii?Q?78LFpUxQ34w0yML3FpwmqwPfMdfalETN3vgowa/qnPVq/D/dHj89u8QovN8V?=
 =?us-ascii?Q?eURV5hAZFrTkrUnls+wItbbF8Bxj707OMRW9dZzjXAhm8m3ANOd7xDBdJU6N?=
 =?us-ascii?Q?+i/9yXBEahEUyYOMvsBj+hkUtj7DIeCW5OLQHPm1COPgPblpzswfUuAj0q2h?=
 =?us-ascii?Q?WMke9SXzDrjcDxr0ZctXrZooktukAWZRYqYmHb6l9/XVcLqSp1ZqYmr8nxmQ?=
 =?us-ascii?Q?tx3nDxczGChPWUFb3sepIfotOtG1QHMQ+PWpkw7GUzWY6dI9wR8yziB4YNYC?=
 =?us-ascii?Q?syxOqSJSG2edgRYrmf/QQ8hMY9S28CdBoKUy4Mpamic0QItyC9aNli2+od1Z?=
 =?us-ascii?Q?8CChs7A5to1XcAYmaqcQ1QWquXYEgslfj1t1hnHwxK91GDqqIVK4f2zzzX4m?=
 =?us-ascii?Q?Rw9nJGyiBvxK6nMbdIVJ89OggMjaEgO4joWGNykD2ha41Vu1kWdCfTv3Yq3t?=
 =?us-ascii?Q?v3AWnVcA2ilpMRP2yhWT5AruGGfbyNhaJLFaKMccxWpob05sxnmI9/Zq5WO1?=
 =?us-ascii?Q?e+t680yuQsMplk13Jx2eSKA6LgP75TjDIzh3sjR+far4DM1m/UvQKu8uCF+8?=
 =?us-ascii?Q?vRkgbip84ourLbZBJVUbvsCwMWiYF6fgpvST5Gxx1eT4Gr3KC/wRlOJwUQV1?=
 =?us-ascii?Q?WtX+I/Y4Tb6yDLNhde2LVX9GUzxOm/kcwSRQ4onlmepbcZax6eiYKokODvgl?=
 =?us-ascii?Q?QO/LeBgZCJLGUoRfgu8f2a7b0jow5lUf6I3K4PVwH7lqP/38yonfyelPeITP?=
 =?us-ascii?Q?msmXcLmzbvq4x3OiYxsPh+RpvNSah5gin3gBngaEof0HftYkR3gfR3Ygbn+O?=
 =?us-ascii?Q?bR8RGH47bsJRymamvtmOaQPTDE7kSp3PJTjfFDQ3Api0zs8dQQstVAyFmPUs?=
 =?us-ascii?Q?DZxt9qyc0d9wgwUPcZYgl+ue8GtFgbT96i2OaWUS/NeaOOtPJcqKcDB5JD8W?=
 =?us-ascii?Q?Jd2EceadxB7s1sSop89O2yaoHAUtZchFDbS++NyIzGvUu8Rt7tLOz72CtAJG?=
 =?us-ascii?Q?TA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?stEHwIcqj8kFLotzU0taSvhQR//w1QwTgo2kI49IrlsjF2T8PbBwipCy42md?=
 =?us-ascii?Q?5OYc9Ye1UmEpVVcCN5CnN049HVRlHdYJI3CrvgRlb+3hJ3pkyXC08nJHEn9f?=
 =?us-ascii?Q?OBj1vnWW5OVxM/Ejmow4bOd5MOvHnJZSxx1QyciVHH5wVDMGqbl+GikjEbT3?=
 =?us-ascii?Q?D5FnwDtMP3JZJklCOXB0haHytdiNLZ52j1AZQH2v1LRI1uKptapy1/NNj3vc?=
 =?us-ascii?Q?ROVEn+J945KnBeMQmbth0j0jC5T5tNoe8cbZMq7nX0K0n2XQR5alw8ISp/NQ?=
 =?us-ascii?Q?pISiNgwTf7Kr1M6IY5W6SCY1nTFs6xWBvXw5gIc7opij7v7g2NVAmwxqW9P3?=
 =?us-ascii?Q?w/hAemQf+gqYFuBZfLWhqEXiHJqnIEJM2en2IQhfRDa5t3Yi3yLYfvYpD2yJ?=
 =?us-ascii?Q?XROtpPFf19MqdK/wwYjBcLANkVlnkGigwafbehvyJQUZdiiVcoqynguK1VZy?=
 =?us-ascii?Q?X7qAqMFAomYzoCDEznIA5t1oyIYyNPBHIjjVxQuGW4hNNvL8SP0/iRRGlqR2?=
 =?us-ascii?Q?2+CwRV3gZdaeCa8Repc//gGG69Pd0wWhchJU1tThgv28xfxTDEpIuwOItwA2?=
 =?us-ascii?Q?qzJBl5PBntYvbQeyvzyXzXUswJZx7FzlfdiNYP9OWVjMupNdDVUtEkliz9E+?=
 =?us-ascii?Q?niqggl8vRu9RwsrMaw2ez9xEkIsJ1vb5WBBeOMTMDmBnTpC/jvHOQ8hMnzyW?=
 =?us-ascii?Q?pz4oNkqpDorKbmv0DY5KzRoyr/OQ20NpxWjlRUfqXLKhcIjCcSrR71nJVR7W?=
 =?us-ascii?Q?F846oOw5snMHODmrAkdHcfwiHdF5IzTx/q9LBK0AHAVG5QinKA4JBOwuhFPa?=
 =?us-ascii?Q?hykv5pDEhzCurcBeEevwPOOsZG2TxZxi2JkhvKEwju6RiVJa7EBGQUadPfw6?=
 =?us-ascii?Q?+j9wTaNisvjS/z/FilfuIANL7Q/6UFs1TP72KMjF2vIyC2dpJWiL7ON+olO2?=
 =?us-ascii?Q?GYI27j+Xy48zEQ0jBlPjdhdggOOvKWI90krvi7dSGQzChr8pE8sJOt+fCrT+?=
 =?us-ascii?Q?X3iecIwImdH792EZMLS+2/QOYM1dzPzU33lEmn3j45Qhk23LGF9nA2WJ6Odl?=
 =?us-ascii?Q?j0+0Mil4fBkNdn321aZrkJ2t7XxbXDOkkPUQLzlmJ/na80B621/3+K78cS5a?=
 =?us-ascii?Q?8Od2g1w0Md91Bm/y/NlAJCKBARQLYJXWQWIKJdqbv+MMY7ARUuhwupUsKf+p?=
 =?us-ascii?Q?42NixN3GDljN2QCKkVvXaDoucuuNdCAGD4Hy3MRw/3iM1lBveDxyTsdrJwuY?=
 =?us-ascii?Q?tV/4dpqQKnE8cQEBPs48tcHuqUlfoArnWvdH1gAxbYRsoD2ArI68sLOhQk2D?=
 =?us-ascii?Q?gtxsDuDJJw4ZRhjQbjDDPp/v9sZChj6ELm5Zzrbt1/Gmd7DUSv6mg62t4cz8?=
 =?us-ascii?Q?2PA6xEfq3MjsNGmc4Xz8lZeActGUy2ThU4SLIF4JkY1I2DzVq/p394BNHWUF?=
 =?us-ascii?Q?gm6xiRcW0I4fr57HKgM5qc3ZNneJFTm04lTgN4Ndm73ExOs6o9/NNkMZvmu5?=
 =?us-ascii?Q?ce117p89QAgyCIwn/cu6VIwgena7m+7bLAebq/FV2kpURo0dvmH19GxI4tjC?=
 =?us-ascii?Q?r85Mtft9KbLA55z7v3NYE5W7REXGJo4Sx0JNWwbSUPM7o18NPyMBgTrUvtjj?=
 =?us-ascii?Q?R6AG1fvOM4lBli1oiQ0wds1clA6ES6aHrAjw++T/dqFLV7ZMsZ3XPdclFBX0?=
 =?us-ascii?Q?43zbFNxlhK8SvdUmQ84XFWyPZgKnc8NXQWwOSOhekgIXXNxD/bIGS3bwQmXD?=
 =?us-ascii?Q?bOu/4igW73UFozQhvKkXPJr7Yh6NCqUR5DvS6nkHC2FJWmwwbcmx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bf366e5f-ffe6-4114-cc12-08de6cb0bae8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:03.9448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNensatSCXt3dVlbbO7FPgY9tuX6nyLsPyhcjaIy0fxHPeaGw2HpLvt6V+1olNjybQEBm8fA5yBktCkkBXEccQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
engines) whose register windows and descriptor memories metadata need to
be exposed to a remote peer. Endpoint function drivers need a generic
way to discover such resources without hard-coding controller-specific
helpers.

Add pci_epc_get_aux_resources() and the corresponding pci_epc_ops
get_aux_resources() callback. The API returns a list of resources
described by type, physical address and size, plus type-specific
metadata.

Passing resources == NULL (or num_resources == 0) returns the required
number of entries.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++
 include/linux/pci-epc.h             | 51 +++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 068155819c57..01de4bd5047a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_features);
 
+/**
+ * pci_epc_get_aux_resources() - query EPC-provided auxiliary resources
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @resources: output array (may be NULL to query required count)
+ * @num_resources: size of @resources array in entries (0 when querying count)
+ *
+ * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
+ * registers and/or descriptor memories can be exposed to the host by mapping
+ * them into BAR space. This helper queries the backend for such resources.
+ *
+ * Return:
+ *   * >= 0: number of resources returned (or required, if @resources is NULL)
+ *   * -EOPNOTSUPP: backend does not support auxiliary resource queries
+ *   * other -errno on failure
+ */
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources)
+{
+	int ret;
+
+	if (!epc || !epc->ops)
+		return -EINVAL;
+
+	if (func_no >= epc->max_functions)
+		return -EINVAL;
+
+	if (!epc->ops->get_aux_resources)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->get_aux_resources(epc, func_no, vfunc_no, resources,
+					  num_resources);
+	mutex_unlock(&epc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 7a87f5962dd0..fd79784b31db 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -61,6 +61,50 @@ struct pci_epc_map {
 	void __iomem	*virt_addr;
 };
 
+/**
+ * enum pci_epc_aux_resource_type - auxiliary resource type identifiers
+ * @PCI_EPC_AUX_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
+ * @PCI_EPC_AUX_DMA_CHAN_DESC: Per-channel DMA descriptor
+ * @PCI_EPC_AUX_DOORBELL_MMIO: Doorbell MMIO, that might be outside the DMA
+ *                             controller register window
+ *
+ * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
+ * register windows and descriptor memories into BAR space. This enum
+ * identifies the type of each exposable resource.
+ */
+enum pci_epc_aux_resource_type {
+	PCI_EPC_AUX_DMA_CTRL_MMIO,
+	PCI_EPC_AUX_DMA_CHAN_DESC,
+	PCI_EPC_AUX_DOORBELL_MMIO,
+};
+
+/**
+ * struct pci_epc_aux_resource - a physical auxiliary resource that may be
+ *                               exposed for peer use
+ * @type:       resource type, see enum pci_epc_aux_resource_type
+ * @phys_addr:  physical base address of the resource
+ * @size:       size of the resource in bytes
+ * @bar:        BAR number where this resource is already exposed to the RC
+ *              (NO_BAR if not)
+ * @bar_offset: offset within @bar where the resource starts (valid iff
+ *              @bar != NO_BAR)
+ * @u:          type-specific metadata
+ */
+struct pci_epc_aux_resource {
+	enum pci_epc_aux_resource_type type;
+	phys_addr_t phys_addr;
+	resource_size_t size;
+	enum pci_barno bar;
+	resource_size_t bar_offset;
+
+	union {
+		/* PCI_EPC_AUX_DOORBELL_MMIO */
+		struct {
+			int irq;
+		} db_mmio;
+	} u;
+};
+
 /**
  * struct pci_epc_ops - set of function pointers for performing EPC operations
  * @write_header: ops to populate configuration space header
@@ -84,6 +128,7 @@ struct pci_epc_map {
  * @start: ops to start the PCI link
  * @stop: ops to stop the PCI link
  * @get_features: ops to get the features supported by the EPC
+ * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -115,6 +160,9 @@ struct pci_epc_ops {
 	void	(*stop)(struct pci_epc *epc);
 	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
 						       u8 func_no, u8 vfunc_no);
+	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     struct pci_epc_aux_resource *resources,
+				     int num_resources);
 	struct module *owner;
 };
 
@@ -337,6 +385,9 @@ int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
 const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 						    u8 func_no, u8 vfunc_no);
+int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      struct pci_epc_aux_resource *resources,
+			      int num_resources);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

