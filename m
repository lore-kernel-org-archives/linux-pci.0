Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021118.outbound.protection.outlook.com [40.107.74.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1D3F4DC3;
	Tue,  4 Aug 2026 03:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814756; cv=fail; b=T99ta8Toj/OkDctYsZ66GWM1ZnLRbXJS3PqsT5iaxemLKtWgDKtGZ6jNFqmRomxsnJPHqEG2wPiH0v7wltxDVo8JMddELIn7gSmq2H31HDbdV8P/ZNcrg5b8tDrDMHbFfHGE1Wz8vx4uCh/AUcMz5zPl0BvdSKxTdMTaw+zIgn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814756; c=relaxed/simple;
	bh=J82YMNJL/c2NWuXqm+10LuFnu3LUMjNd34XTQJDIsPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V9wQEZusjcP7/1JMluQIR8pSe0yEcmYML4ymm+Tde6T74X1TRNHFo9y1OpbDXaifCO+sWIUIT3hF+5GkPb0uhem5jM17FezvHESykN6USvBPvoiyLYjINOCo5sr3LJd3k9Nt6pATGmO84/RLmBS9IOKE1yWDJs1sEQx3b8H+W5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=a0OqYTZ0; arc=fail smtp.client-ip=40.107.74.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="a0OqYTZ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbDfA7AbFF9uD4jNSDPESUbRf3W6eIwTJPzq+KEOPqswIXOP2zLzHHSldkG3ARONfbX4VYb7WYk9mEe0mlGO1vHg2ML6k4BUHzvr9sT0ZADZMtIXzf6a8Biz2awFJS4eGBToXA4KijDz3DJ/zMjZTV/e5kXsVehoI87eMghNs3wbYXljHqP4wZVgKCR+NenzjRibymu0ZBKybwynpAWCpUXACBM1LNUWMv++KhEF86tbqVHPHWvRphmP2Upy2Krtgkc44sdH5kEwL1VPXMvqhWUyAnqB4lh1n3DHGnxnV3mh1PmzH/BFUsVZLjHmEpLFE2aWcr6qtZ7V+u35cn9Jkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly8W6esI32BXvJnaKhrOR2fY0lGzxdyTEyBQ1URcA2M=;
 b=VDsTuLhEB1Grf68lx504uOjQAxEDHYxrv9nU/jWukDr+cTpZwfidUuBhARLUF8q5x3p9Az1Iy9gztHqApdvwWZk+kGc2/wSBfnPIR7ljq91Qw/RE5zEqmHcsYuVPZ2FzSgdC8DgH3MSQ2G6LSYauQ+blsAMrXbCCvBR3gBGd2PD4/J5hxMn3uSpxWmnH5Wkh7untTbKKQnAGPwjmVGgLVJ09UqEhez39J19TN4zpxc7+cLoDO2Lgs4x1tewZxq3Gj3mU8zrD/yUJME7/i2JWaCQEylgZRAjJJfHK56fTS1kNdoy5mj2wBxiVKeNSOT1J4nEutrZOoXV9BThtXL7Nqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly8W6esI32BXvJnaKhrOR2fY0lGzxdyTEyBQ1URcA2M=;
 b=a0OqYTZ0jDEE06+8fJS6Ar99COShY5WQBgfJ4oHvr651Vc33FrsfQwOSi54z78xwryF1Els+JcXYpFRZzs5J3fC0PpH31dGQo5Z83gih/Mn50hJAbvWlTLhZDSxBHaZ6W+MOA3LbHt1JTNTdyYlUuXehifV7oqDfuzAZkdQNXBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7598.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:347::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 03:39:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 03:39:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] PCI: endpoint: Add API to delegate EPC DMA channels to the host
Date: Tue,  4 Aug 2026 12:38:52 +0900
Message-ID: <20260804033855.2115817-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260804033855.2115817-1-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: de887985-23a6-4c62-08ef-08def1d9ed9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|1800799024|7416014|366016|56012099006|3023799007|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4Nz88BZSc1WRp4+DeLd7HkgiWIYo4oKyFehLEkPcVYRL+H2d7fu27u/FJP7nGesnkMQcK86cUAWB3dVxo9xo5kQ1ikj72o3yUL617l4dFgQRW7n17dA+k0V0j6TIq297M57AEEzzxWNdq0ASwy6Hx1neW81g7HmWzunuMbc8OOEad/D3OcDI+a7kl9UbbADeiEa9FA8oFxIguE/ACOJfuenTGjOYIWRksin7W20Rk0q+zgXHvr8UMHzNudT9ES0ZfzwJF/EMDrk0mrWtbcztH1aU7wci4I1n5RFIwpJWJyT6Bu83kGhE7d8knQFr4tVz2YJB0Pe6MoTavbkA623floYi1dRqMl6dECivPM6XluPRQlwvdS5Vjg+H+jzjTZljiZQG63d0Fn8ul/Yu7aXC41pe16p8bCHzWvOBJ/+7kG3iJiqaD+bW0BZyMG8mYkCSdCZoxd9rQCWByyZujAGEs+igq1SxmuRprar3wL9QWoXxLl/VqLTopLu16hErPk7TCKRVyBZh4Qt/cshscI8Ez5ao6QMiBnn2QK1jSLfcVI+CQeDNTmjfkmy6ZKF68zh6QeGMYMlzf/emjpmVujwTUwoHhUkjvs9eOMn5mcF1xQ9aLlJdRXte+rBFSvFrv8t1g4Q13UPf8a9mezQ8GXpIokSp9zaitcVPro5E3PiuqTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(7416014)(366016)(56012099006)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wg9/uDMwEB+V1uUzRQkQ/vG193LMzdCwwXvBiCeyiKYOSZxwO2Emtk9EoNuR?=
 =?us-ascii?Q?Kyn8YKvwYtYRULw4ovlW11fpAK673mz9GIrF5K4Xqv5Gr/aM6l/oJt9FPBCr?=
 =?us-ascii?Q?44I39h1sntV8ykAyP+rcMDUUpeU62GzJJiNUkbSahHhcDw+9iP7DmqChn5Sm?=
 =?us-ascii?Q?W2G/vAQIS7D6Thg5VNCZebIoarkZy0+5HnibkDLFqdgy7XPWt6zD6Iyv/LF6?=
 =?us-ascii?Q?M3FUCeiShOQk5kE6x1b0P94O4hGG5XsqoVALDUPHY+Tbcu6mbjaOSX/5zkZu?=
 =?us-ascii?Q?yzFPPrF30Eu+ll+PrczdorpvjFb4M9q/ONuhzFzrAgc1cFybyb1Xgabxxq5F?=
 =?us-ascii?Q?w/QT2uZKGOHFiLCoNXB+diOVc7Ouv2XCg5jKMgO8jhpQDvAobRb7QinKyEsy?=
 =?us-ascii?Q?dSMFjkZh6SQL/axCVlzqBlRBPxEoOrncPqXusJT+8+1NJskvjJ+evqIDPsTg?=
 =?us-ascii?Q?MntnflFOeZP0JRH71mKTSfSGBg7HlKzBix3g2wFiksYu/tlq2QUVm/3bRHI+?=
 =?us-ascii?Q?wPVWKptJ+dsUcZCI31W1e1JuvJTWeTH0hOPIOTPNFbpf/5sd4H8uGmfLWzUq?=
 =?us-ascii?Q?MWUH2Ime24gaPbBZ69kqN338+ShrcRwAmyL8b6jNzmsf5rWx7PBx60iMts9+?=
 =?us-ascii?Q?ObTZ8fFzRndRTWo7of0CD6adLlFQ5SR3Ohx+C1y0fJWgWra2izBDupj592bh?=
 =?us-ascii?Q?OgBamfuPuZFSW0cSNHAVbg8gstTAIYEbkOZNks0r53rnlOBluMpIRK/hd+I5?=
 =?us-ascii?Q?BGJN03ekoTkBNM7GSuT7glGQNlkS6hYAAhLbPpD85gDfAENZ00+w/PR+uvA4?=
 =?us-ascii?Q?wk44goBMD2Al0PywH1FMoQhsCASYz2xRp+64yC6CD4r0FenXgnen/CNlpg1Y?=
 =?us-ascii?Q?+KdaqXdLxC/sz+U5/5fWsRl24R/h2oQiA7p1vsLMB+AthbK4cSOB17HIoRr+?=
 =?us-ascii?Q?tD+/ZJ4dg/q9U6HqFf4XMRGpiW2CEGLgerNXD4BvLGOlZ3L25sxs6Y1upzxP?=
 =?us-ascii?Q?Ur0nMlVyMy4XPoC6Ha2XTYOrl/JaBI37z6+F9G2bJn13BlUjgxAx7acmIgKq?=
 =?us-ascii?Q?NVp6I6gINbqYk3/q7p+pfloxTIKU421sSpwle+LJ9S+c9PCxgSWLx1jxxUVk?=
 =?us-ascii?Q?eVDNh5akK6XUEVbxI435JIgyzrxsm0Dft/kdqtMMwmiiiyuK1ymvS1fV3DuB?=
 =?us-ascii?Q?nUd7xyV5ohz3u0G+kEYJvmxgw6wlDQ2hXxEOcmT8VN8uWxxnaMqh838D2+vT?=
 =?us-ascii?Q?Lhhlsx+FUd0/evDq0V0T47B5GbWcq5jd5+s2ZrZ7b6EX36dSMcfwntEHio9F?=
 =?us-ascii?Q?K4NT58Upth+0fF3YykEdTWj1xyyaY7piqUo6dpPRb7qgDYzC+Fivi5gwYroa?=
 =?us-ascii?Q?35Ez13TMwtg4W6XWIctv/vQ+SsxnO29oXjI6QpYm/7ziobwxZMzkOrs6O3Fk?=
 =?us-ascii?Q?hFQtUjYEgn2f6ZSJqcxsrXw1NfbUMfNPmnBdU+KBhXh/ZSufcVmCHWBdDeVq?=
 =?us-ascii?Q?yzIJ3tmIyp50QSo++mPXYJ69OTFe26Iet1DM0Ic5ZES8VfMENW9G5wDohWe5?=
 =?us-ascii?Q?kz0qfcRpiX5kjhcVZ5oChyCxDnQdgWiyFkL8DYlxWJ3Qu+Q7nXoVWnPQDCy1?=
 =?us-ascii?Q?bH6gw+DzqfzQSbnnZtXzYiE0fwNmagrpUwjSSAHPuyZI2AMqVTfKIMZ9pEy4?=
 =?us-ascii?Q?9FtQ0anah09RUsirCqdH9CU3MPu9+HR7tI+3HXVR5STeFDFknM3GMSvCaqlQ?=
 =?us-ascii?Q?D3Tz3EiIWLZG7iW26sX1Po+4Fq1QY1ZIma2VQ/IRL6PQbMOmWtp3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: de887985-23a6-4c62-08ef-08def1d9ed9e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 03:39:03.0955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/JMn8PVK6ai496sn7RwaUYh0LzABNCZDcvzgFjL6Dsc6C+VdLBZyOe1YIXW6xbM1izWhM2v2jrfdP48ZvwbHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7598

Some endpoint functions expose an EPC-integrated DMA controller to the
host. The endpoint function should not need to know the backend-specific
mechanism used to reserve a channel locally and hand its programming
interface to the host.

Add pci_epc_delegate_dma_chan() and pci_epc_reclaim_dma_chan().
Add matching EPC operations. The public API returns an opaque handle,
while the EPC backend keeps any private channel state. This lets generic
endpoint functions delegate channels without depending on a specific
DMAengine provider.

Let reclaim callers tell the backend whether hardware exposed to host
programming needs to be quiesced before local ownership is restored.
The quiesce may cover a provider-defined sharing group, so callers must
hold every delegated member and stop peer programming before reclaim.
Bind failure paths that only unwind local reservations can skip quiesce.

Reclaim is best-effort because it runs from teardown paths that cannot be
aborted. The backend always consumes the delegation and reports any
quiesce failure itself. The opaque handle is always freed.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v6:
  - No changes.

 drivers/pci/endpoint/pci-epc-core.c | 105 ++++++++++++++++++++++++++++
 include/linux/pci-epc.h             |  16 +++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 831b40458dcd..344e54677bfa 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -18,6 +18,13 @@ static const struct class pci_epc_class = {
 	.name = "pci_epc",
 };
 
+struct pci_epc_dma_chan {
+	struct pci_epc *epc;
+	u8 func_no;
+	u8 vfunc_no;
+	void *data;
+};
+
 static void devm_pci_epc_release(struct device *dev, void *res)
 {
 	struct pci_epc *epc = *(struct pci_epc **)res;
@@ -236,6 +243,104 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
 
+/**
+ * pci_epc_delegate_dma_chan() - delegate an EPC-owned DMA channel to the host
+ * @epc: EPC device
+ * @func_no: function number
+ * @vfunc_no: virtual function number
+ * @dir: DMA channel direction relative to the endpoint
+ * @hw_ch: hardware channel number
+ * @chan: output delegated-channel handle
+ *
+ * Some EPC backends integrate DMA channels that can be exposed to the host.
+ * This helper asks the backend to reserve the specified channel locally and
+ * place it in a state where the host driver may program it through the exposed
+ * register window.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the backend does not support DMA channel
+ * delegation, or another -errno on failure.
+ */
+int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+			      struct pci_epc_dma_chan **chan)
+{
+	struct pci_epc_dma_chan *epc_chan;
+	void *data = NULL;
+	int ret;
+
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if (!chan)
+		return -EINVAL;
+	*chan = NULL;
+
+	if (dir != PCI_EPC_AUX_DMA_EP_TO_RC &&
+	    dir != PCI_EPC_AUX_DMA_RC_TO_EP)
+		return -EINVAL;
+
+	if (!epc->ops->delegate_dma_chan || !epc->ops->reclaim_dma_chan)
+		return -EOPNOTSUPP;
+
+	epc_chan = kzalloc_obj(*epc_chan, GFP_KERNEL);
+	if (!epc_chan)
+		return -ENOMEM;
+
+	mutex_lock(&epc->lock);
+	ret = epc->ops->delegate_dma_chan(epc, func_no, vfunc_no, dir, hw_ch,
+					  &data);
+	mutex_unlock(&epc->lock);
+	if (ret) {
+		kfree(epc_chan);
+		return ret;
+	}
+
+	epc_chan->epc = epc;
+	epc_chan->func_no = func_no;
+	epc_chan->vfunc_no = vfunc_no;
+	epc_chan->data = data;
+	*chan = epc_chan;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epc_delegate_dma_chan);
+
+/**
+ * pci_epc_reclaim_dma_chan() - reclaim a delegated EPC-owned DMA channel
+ * @chan: delegated-channel handle returned by pci_epc_delegate_dma_chan()
+ * @quiesce: quiesce affected hardware before reclaiming the channel
+ *
+ * Reclaim a channel previously delegated to the host. Set @quiesce for channels
+ * that may have been exposed to host programming. Bind failure paths that are
+ * unwinding local reservations before exposure may leave it clear.
+ *
+ * Some providers share enable and interrupt controls among channels. The
+ * caller must retain every delegated member of that sharing group and prevent
+ * further peer programming before requesting reclaim.
+ *
+ * Reclaim is best-effort because it runs from teardown paths that cannot be
+ * aborted. The backend always consumes the delegation and reports any quiesce
+ * failure itself.
+ */
+void pci_epc_reclaim_dma_chan(struct pci_epc_dma_chan *chan, bool quiesce)
+{
+	struct pci_epc *epc;
+
+	if (!chan)
+		return;
+
+	epc = chan->epc;
+	if (epc && epc->ops && epc->ops->reclaim_dma_chan) {
+		mutex_lock(&epc->lock);
+		epc->ops->reclaim_dma_chan(epc, chan->func_no, chan->vfunc_no,
+					    chan->data, quiesce);
+		mutex_unlock(&epc->lock);
+	}
+
+	kfree(chan);
+}
+EXPORT_SYMBOL_GPL(pci_epc_reclaim_dma_chan);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 8c89cb6d6733..2d15194a126b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -11,7 +11,9 @@
 
 #include <linux/pci-epf.h>
 
+struct device;
 struct pci_epc;
+struct pci_epc_dma_chan;
 
 enum pci_epc_interface_type {
 	UNKNOWN_INTERFACE = -1,
@@ -174,6 +176,11 @@ struct pci_epc_aux_resource {
  * @get_aux_resources_count: ops to get the number of controller-owned
  *                           auxiliary resources
  * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
+ * @delegate_dma_chan: ops to delegate a controller-owned DMA channel to the
+ *                     host
+ * @reclaim_dma_chan: ops to reclaim a previously delegated DMA channel.
+ *		      The callback quiesces the channel or its provider-defined
+ *		      sharing group when requested.
  * @owner: the module owner containing the ops
  */
 struct pci_epc_ops {
@@ -210,6 +217,11 @@ struct pci_epc_ops {
 	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				     struct pci_epc_aux_resource *resources,
 				     int num_resources);
+	int	(*delegate_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				     enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+				     void **data);
+	void	(*reclaim_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				    void *data, bool quiesce);
 	struct module *owner;
 };
 
@@ -443,6 +455,10 @@ int pci_epc_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
 int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epc_aux_resource *resources,
 			      int num_resources);
+int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
+			      struct pci_epc_dma_chan **chan);
+void pci_epc_reclaim_dma_chan(struct pci_epc_dma_chan *chan, bool quiesce);
 enum pci_barno
 pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
-- 
2.51.0

