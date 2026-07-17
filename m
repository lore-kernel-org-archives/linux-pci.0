Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020124.outbound.protection.outlook.com [52.101.229.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A437268B;
	Fri, 17 Jul 2026 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264810; cv=fail; b=qQ0B5bV7rh1SXZA/VpAI8wzu8YatRfzJ4nWfIYVQWUb7K8Jhdwiwug6Gkm36Ol1nMvABYBZqhRrOnKP1euO/v2IQxk8XqXNOoC9EUnAexcW+OFwJBpTEYuqtNlLvSSPHK7fkF/kpCi7jyfgRfD3wPp/PHJIbc6VBEYXks3aq9fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264810; c=relaxed/simple;
	bh=v7W+ESp1ftnSKKA49nvqEwH0oUfT4WPUihLnW7aBlZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hcz6Y9aNlbA/p6sWI8EFxaNEBZF1wVTVUkrvcRLftH2+NlgsfOIzzLZ2335zfExiB/a6M65Cu9k/fhhDIB4EoIJJTILOKQUo4Rj7PXCJ67vShW+5LCb+cA6PaoQVS8hT2NzghTFVK/3TV1FXdDrxeADxbn1Ul3S4kCQvXrFv3sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XZBcmtMD; arc=fail smtp.client-ip=52.101.229.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XZBcmtMD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKj1a4SOjNNoLGF2JFHTCleUxppc0nJlyaR4bKMOUNoCu05Z09G+4K6Tb2qF3HIC2KPCHbqdmLNZ314sNdzU73bVtHoyt0LE3V6RwlsJnthPPE26JZd/61DpeuzZ/8R7pSeTAL4B925fxHlgc4KI1qcEPEEsIrGU/2KW9nfej6jnXfGcFfr2PT8BSQa0iRIlpgwUn4mqG2lF458VDJDOkGJnFkaIIOekymLFfnfzAMDYDEhb2wYFyl6hstRuqGSiVxSfWWGBldrAd6Ape1l1NR3r4F8fKxG7SAgj8GiLuKLTfIH7z1PfGlDR6mSRzNgmp9FY9zJskvIKpprF7kTfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en1zyoFTcCopa3ZDXKB2JxLHkNqz3OxHYp6Nwmtjp8s=;
 b=HZ8XN7AqcTr5t7JOYm54m5ZhEGV++EZqMth6TcOoHO1iqbrPHfkffOsem9cJCDZb8ukQrepR1fikqKaGde8mutY9cdscU8srf9kFAVVHSy2y1N2BKVy8/0n4NW4Li3x595twl+VLAgn/JjBLwqH8qdpmZYI4NxWjEXwO+IIGvShWIND6sGSC9N5nXSHX0C6xYt+rpPfui1PaDhCOiK3MdLpLEZz6Xwbyl9OnB/4Lg2nO8Akp3oY5JQQ7sDBsNGE13LkdOPx95XiCPnEsBMH5XA7GMarkJm8sXMVjIbdz/g7c3CRALjxn/CSGgNgsNkpMla/IG8BHuZ/NpXpFrtR3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en1zyoFTcCopa3ZDXKB2JxLHkNqz3OxHYp6Nwmtjp8s=;
 b=XZBcmtMDx80NNr7oFxZ/27a6gV4WsRBFBBYSZQq3WOzfbBH47xJcAH7z3Q4pphagjgSOnXyjrmn3XQaJpZNXsgkWzEV3uLwyhVCXypE9rFwxCqRrsIZSecykytO90AXk03QIsDjfgV9dIp+i4GOwOxMgT7bb7FUk9QNFtxh31Aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6910.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 05:06:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 05:06:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 3/6] PCI: endpoint: Add API to delegate EPC DMA channels to the host
Date: Fri, 17 Jul 2026 14:06:32 +0900
Message-ID: <20260717050635.2145014-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260717050635.2145014-1-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0118.jpnprd01.prod.outlook.com
 (2603:1096:405:379::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fd3794-4068-48dd-9d0c-08dee3c13040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|10070799003|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1Jt7oebdKcgQauzGUoOgN48hfb65TJjMXoKzvyyPhNMGV7RGV5jrnC+LVXk17tqJYEW9SU1+kJC5FcQwnx9yEK6jVhe7mCnsYiqgaMcKLL8P1tWLFeUiy5uFd61fIQ6ap3KWmWVw5ILBsbixQcZa3kmjGdgGmBJ+OgYTMM6qxOp4AQt0wJ7EuMWJItTWKvwZmi9i3TKJNtnovW58+wqMhZyiWwSYtlm30oRw5/OOOrww1QlDJh0mAUvXrWd+H0Eyk7sgpHNsRxvOKOSfjLeuJ0b2SMwzA0sbA8GdKiL85XCm5gQh7sua0otN1YjAcOkO2knLfV8Vd+kZPqgTJHnwSHNTOwo4iDV95nIQg9cZw2H34VM2pKe2uPEsDnPofuKkBZKThI1bQmVSyuiim7mrpGMlNNsvs5rcak+sYsEYJt0vYisZvm2+YPdvDbXDzMjbXMJA32bFq1ZIr9A5CfbXFfh0Z3xstPf/p+U0BOIvIFjBuC21eZbqQ5LCEfu17jTeeM6OAL8w5TNltUFG4dxZB/qQ8M9NHrJkvpHakMS28TAi9KIJ6RpWoTzdceNHxLM55bUhUxwoqKEEH6yFMG36Ttqgc6KVumTfOl5oH8nYHKQfZd9GgKxoZEwIchCWT6Xp+yl74hi0xKag+6B5SN3M67yqC5sJfzI817svHq7rzkU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10070799003)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R9Xv9YJ319gEV6Cyr+m9WMDg6kIOKJ5ohBumOz2QHOBOUW4fJW/KJr4VPgLQ?=
 =?us-ascii?Q?5AEHml+OgrefCkqsPZlF5qqzvOPNSQwhHJ1l3vaY1ki7jYigMhKZkgcK5iPp?=
 =?us-ascii?Q?FQBKaR8UE7W+hvOLMBaekRdjVp3zzDiujnTCG1KV+ZQVrRUnkOzWoOzbt3iH?=
 =?us-ascii?Q?bdX3hbjKGwbnCvN2S3acctIFvQt30nFzgz1Y63Ggd9lQrNS0yYOszTpI5Iri?=
 =?us-ascii?Q?GVfqSU4Vwdee8MDx+5saJz2slYLR8xCjALdDy5asmn+CqLxWTuz2ylEAWycY?=
 =?us-ascii?Q?ks9U32TVuPoFAce0A69L8pI8cM86sIn4kskMwaMSO0t1L4L2w446/4xuRj/N?=
 =?us-ascii?Q?loSIHgN0qoV5BNLUsWoYsbNz3ky8v6BFPuzFDsL345nNowMRsWU7W5pEzixR?=
 =?us-ascii?Q?pDUTbEmA9YudAHcCoBtUsDkFe6i9mMt0kV87bml3RjI9spuefVLOi0IGyorS?=
 =?us-ascii?Q?lXxADL5FsmyUnmJKgDSJhbyQHqbRWDOPeadku3FrZkei4w8slkX7xi0wr4pj?=
 =?us-ascii?Q?uaqeWIb2tGFwJnQFWtVh2jP9qn3h7cOGbr6m7kz+PZ+rjcIFrt6Q5Td8Ph7D?=
 =?us-ascii?Q?N7tnY2lMIsSR4paLTWGlIG/RLEonKfbavb4IA7k8HpLVzQaKzRpFzaaS8/eW?=
 =?us-ascii?Q?84POcfGe7iNOp6Q1namPgzu33JGmlpgWoxWmRoejnksmHZaYAdLLlC+MKO2y?=
 =?us-ascii?Q?zGl8WvfxguVEm9XXp/GcAKKn7anZ3DySz8QCsCaHTekaYrw2ztHL4ereYAOz?=
 =?us-ascii?Q?mQsFF8LZxZrYEl46+8XBRdHS7XUoujIEfkzrTmqB/crGb7g3QJy4sPCgAJ9q?=
 =?us-ascii?Q?eN/typEppqRpumFgj8+7ZO/NASOWlNqYt83rLNXauTl9M+teDJnXe1dsLAcT?=
 =?us-ascii?Q?L+Vt6wU+c5fw+PRHbnHEmeId/No7eVsqo7fPu2zvyxKbSN0IX5kPT3yZ6UJ+?=
 =?us-ascii?Q?s/+R4jAaIRpC5QNCOQkI+3r2v93n2nH4bX0Wv/DTxqxvOciLieFG20ORjnMS?=
 =?us-ascii?Q?msyB8tal6gy19miu/6TxayST2i8hk0vIE0Ho4a43hm1+RMc6WmFebjdujg+2?=
 =?us-ascii?Q?LaGtmY/ZHvsr/GpxP6+tcFkcQ4wuWExkXiprM57Hb0nszvwRKE0/jbUO9Jln?=
 =?us-ascii?Q?JCEUtCQHCsejWy3RPLztRHfOsKUfeEHrgQCz14L3zIEWkQjdqhXotN4TL+Fo?=
 =?us-ascii?Q?c5V+mdxWqb0a5qnifPj57HStGo+xGleuPWBSjqbC/84R93yDBWjd2T3zS5Ui?=
 =?us-ascii?Q?7s4OuZA3XUS+JxWuLkoZhPWN7S/PPLHij44modm1j4+uG/fgr9ZdNIjR4DnN?=
 =?us-ascii?Q?FqJXo0HCJOQgIVHjSYpmAR6i7mRImGa3wW78q00Uusn39UKfg6Oab1XGWjwz?=
 =?us-ascii?Q?PRuRAolvSbBMFXS/uDf1LW+76tjYQoUopj6Xpo8XEJe3TbfjDWtTYCRfbQq3?=
 =?us-ascii?Q?Lbu8sX3zP5nKwzE9yLpNrqYD4bgCCbOuhAZUa7WEmueHWF2hLVWMy6iVzk9m?=
 =?us-ascii?Q?UuUr4Xq4jO6aQ9pBilkpwSJKnnlCuz3rpwVk62iBGyvJP76z2iJwEjIIm5Vk?=
 =?us-ascii?Q?KJ3Lc1/disNEdBRfPBdW4qYcQZzKf1fBHMtYwzvZ0S7Ux/xNgPp4u3LfJ2Ic?=
 =?us-ascii?Q?sMr3LUxTMUyrBgLmCHAej+bd0+zb1mR/+VV9sFS1dIVffAqe1Amm1Fr44lm8?=
 =?us-ascii?Q?CcmQtGBn35C7sbKh/uSHBhwD9IkSl+1nZOpitT/0gULnXnNo4nVDB/AiiHLX?=
 =?us-ascii?Q?JK1jDZhkyvETWOmVfGUYv+Ab5cy8UH0NsEdHpAy4wGC1H0teo2y3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fd3794-4068-48dd-9d0c-08dee3c13040
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 05:06:41.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwg/0rLC1V0bgPzCZKb6qw/IuZGzEXp4i3cGBJVWLZ562Tmppwl2GrxszGJ8Ub7bmunm7g7wOexXXpfM5TO9YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6910

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
Changes in v5:
  - Document provider-defined sharing groups and the best-effort reclaim
    contract.

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

