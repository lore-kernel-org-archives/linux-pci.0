Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46981476CE0;
	Tue,  4 Aug 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859624; cv=fail; b=ByMumOgT/PS5ih7TfwVKu/p+aeFfshygATRV+LRwCKpXqpOfFYwR3JjUb17MfTY2e3OGc12sM+2QPdZiS7omijbD/8MVLPullVCIphMIpEYi+9bc2aW+PK7IPbLfaipsxA+OjrlJXcuyUJ5C7/JGUMI532zRlybbcd8wuaJQSR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859624; c=relaxed/simple;
	bh=xsT6KynSJWbc6c0UfgsFQUjPUl9eFaOHF7SigaswSDY=;
	h=Date:From:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f48hK89vYmPyT072u3Ao0kDs90qSjr5Msqh8JOWcO2lwQp58/QvYaQ+qCza94us2y+x/U+suqAjTFs4wdB0trHGYuSoS/l5IvlAA5bxDzwQJ1lEqNZtFRjcSUir6BaDXmFlNPai1KlWGakHL4pNOzXoiM8wv0nzZ6/oNgPEfEUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=knpRGS3G; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="knpRGS3G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCPY6o9J4hx2JD9Ln8Wv5pJ5/P+Y3gVDiFoVxNowvPUJp1Xm5TsBbIpQ/iC10WuxIDPS8GvVVgnxKtQkfhNIiTFWQM/OKXPhKkDoEDj1g7ENLX9rjCuhhSBS9bNjI1jBRVRe+W/6wnbPlZmD+/cNyKbFK96boCa3y2FLhTrF93ukTEf7/GxzjJqjbA4W5pdlYkXlycVtezKW1kYPvD5phokcEYhDbMRMwgG50YnsERXc0pt0dGlyBPdy5yuLazFSoI+Jx05LjwdwYg6iGFgXCZq86ky4R7gEsPRjIANrZzKT8fUjJXDxaz2tHPF1HVRkDH8SoTwlR2MS0AKAz7NwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjnZRDgHcY0DHo0vdc5RS4lFDi/YZnamksacuoVeZa0=;
 b=JmGOnUIFa26tfQMubqM3XgP7XgKd3yzKrX3E4t2JPI7d73AHZxscYipBDSDW40oayVNpMzBNFfORW+eFB5QXvECMuZN2SObeKbUzVnVkYJ6tinqMtIAOpsk0mRYp4IBP/qrUsuk9qWrF8ErAWmXlQyZ2axH1lQnmDZk/2nriE4BCrJr5/PjAy15kkWyA/hdB7rXMaCOwfRJAA36hq5CsP/6Wc6YjbGVMVTLj0jKLRbQDzMEQqKHB0qMSWsvITod8vz47p29MLkgE9qjzasasfSCS+FzxCo+BTLkSkK3HRePj9Yxw6W4DAmKfKw1JHRoBPJuFstC6+6t0V3ufKtpWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjnZRDgHcY0DHo0vdc5RS4lFDi/YZnamksacuoVeZa0=;
 b=knpRGS3GJrDKvGO064mjjZTI/kvchL6sH+ph+/hl0cB04Rq0g7yYTHH5JI+dcfgqQ/FIYjgVKDErowFNlAOwe1zS4XJM7an0VRGGRGuU/hEg1zn6LsAgiaZ4DVsFPVJyFqO/ydEspUg9ZuAm+jzRvXlEWOHB8LGnYAr5e0Q1fJdpgEuU6Q3Shcga9bnranqNvd4fbzBCaG2GHzBUn0lfRVG5ZV2qFtgYYQWb1sz63+cGCIkPegzrv0Kbq40kBGhBCXSG+P1KR8utv93kUIm44hTkfyFVrjcfSI6+ehCR+JeCbc5+KXHElV7hHyQoAQIS0fIvEVopdpuZzTA2ABxs/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7753.eurprd04.prod.outlook.com (2603:10a6:10:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 16:06:55 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 16:06:55 +0000
Date: Tue, 4 Aug 2026 11:06:45 -0500
From: Frank Li <Frank.li@oss.nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/6] PCI: endpoint: Add API to delegate EPC DMA
 channels to the host
Message-ID: <anIOFfPBRuNkr2hL@SMW015318>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033855.2115817-4-den@valinux.co.jp>
X-ClientProxiedBy: PH7P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: a2584f72-62bd-4236-cd6c-08def2426765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|7416014|23010399003|6133799003|11063799006|3023799007|4143699003|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	OzniDl6sa7+COzAnP/aEmAfOxOjf80flZlIVps6PCutUZr40twisrWFsgeddfeM67bsx2GhEdCzbSKUIJd2jjhe1y4+fbz8GSp2cuawbsU6KfJS1KWyJ7x89erhbTWFUeqX7Wrwup0xjyjqxsOXhY+1NxJmovkNeieXF/3a1BY0GkSLSIbA4pyZIBJcNmOST4144KsfeYr2f/4+nguA7B7TnY7YQyi1KCqlGWxRR0XkkGg2oazJ69YsmNzc4mpZhZlJz/uxod8Va+1LbJNNp2OazOBLbxt9pa/1Lq38IZQew1EyalT5oM/0xSvOgHIGDS3wr1dSJas2AbRbqjArMNFxz8afsivX3/F2G3nYxeZ83WfL4jc4QfMZjhPjW0+5L5+oYdIPuJjt85tUnvGCqpW18hXOSGymZm447dh/3SKumU/b6ibNMI3uTWSpJA50TNiUSVVFsL5DkObTXzBLcOOmXb02mEUB4YThvY1mWEjdvXodY+AS+Qnr17AqE2dcAtwBwWrY2YJFr9Qho7EESgMqooQVuA4oZxNMlfjIFzJ0zXyDdgO0lV1PPlZnaYAlpWxDhcU4s7G0GeZynI4gP58p9YxOmbPNvVRMv5vxp+3aht6oO1H1QEvDQ3JLH0sj5N/Qxh3sZ7bi//kj9SRY68D2qpB9CAQF3g6hBQuoyrcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(7416014)(23010399003)(6133799003)(11063799006)(3023799007)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5E1RZJqLkSeCIWB7cIEfrDh0FCEYLMYe9ghI7TnYP+cJYJ2F0feCYI8oQvKT?=
 =?us-ascii?Q?OeyO6docNsU4QEQdM8lZfqPxFKvv6JUyVjZAA2BHPj+yxj1phcyLo4lcZrLc?=
 =?us-ascii?Q?+3envAr3jIdchVnY2ce25xxEIW7zALcSexrAPAhHsmU7IID+TS4fBht37tpE?=
 =?us-ascii?Q?a0/0DMZI75JdOS/ZVZzhz12XqEnpAB9cL+nVZQ1e9QPo1/l3cGyc8d4OM/hP?=
 =?us-ascii?Q?LiyHywfKvouxfq60Hsa/G1D6VZLuKkt71WWa4E9PI70SHuP5mFdam3RBX2vj?=
 =?us-ascii?Q?T1UM9oTXCzAmRM/jKQ5DaInndyjyoTzfffdiX4wvh9Rx07yxAPwVUiEKVq/4?=
 =?us-ascii?Q?Eunb+KXl7ibDUuuLHHKPcdUhO7BZXyUxc1FdOf35H4XkTqSLrCR+GHH/CADo?=
 =?us-ascii?Q?vuGS+SIRwS1II/T2EQPRrb30EzyPDntGYq+wK8hzu5aLsmjkYCzJtbwTkHkg?=
 =?us-ascii?Q?jVg9Kg+fg2wntlFmHYoTB7S773mozfGM5kz6u5XtJY0W8YGz6uINat9rkfXi?=
 =?us-ascii?Q?Q3hW0vn83dtmGiFgGOJsuexuRW+1bL/kCcH4UoAKzA0KKbTSqp3ix1QVz6lZ?=
 =?us-ascii?Q?Nr4EMt58cc1DVtsNUkbVmv0sBADdPxICL8+lm/Lid82rUBhgn68xo3hHuBoR?=
 =?us-ascii?Q?zN8X4mMo4zZtSPtKkMSrqBu/JUucVDfh3SbqMv7wY8yoB5nO6rHwv39ntk07?=
 =?us-ascii?Q?5WY66rxAzkP0xwgCYe7I2teSowLy5Jn9ArHvz3vXqekMnwjnVLwmKHjJCoN2?=
 =?us-ascii?Q?2kBIv9pTzHRzcqRniWT66xMewJLlcC5z1v0/NeWObZgJ1NFd+F3ekKtEl3az?=
 =?us-ascii?Q?+1sA1ARnD8szwakLT+A4A0yUsnGlNKLBUMWSajkeCoIoDF8NEu/brWuAaSct?=
 =?us-ascii?Q?KUyiExll48APmmqKu77/XyYGKa+emxzFhKLDU5DbYkbfA5kqBv6OaP1y9agr?=
 =?us-ascii?Q?+K1QdYOsVxtA/q0s1a2Cpeu4z0IVSiQ6yLIMggzTHNdXuHMhlkbn0X1cXUnJ?=
 =?us-ascii?Q?uuRxzhGz30NRZvwtbolo1fTZlBxDMLxg7rtZIlvzcB7ov8rXmD9NVV4Qw4o2?=
 =?us-ascii?Q?jj+N+QjP1h++A+eraXsh88eFB+EGzlPXoYGwNJMZE2FzFtip/ZNugD7VqGWh?=
 =?us-ascii?Q?7/dnGJrWCqEGfiHwkkZ5/S0kAX9m1UC8ZkcrUza/O8u9qrpnq/JK/e7I7CjR?=
 =?us-ascii?Q?fwbl+6ML5/weCdwKm/1SpZa+wTg1bfDaatOkY88n4gbPR1rEje+zZCU16v+z?=
 =?us-ascii?Q?BJSqGeRDlzkob0hfmzAP9BD+nFO5csZa5diR+9/gbtNqPcYGsTO3ubWOned/?=
 =?us-ascii?Q?TOSGKMaWWCgFIpbLbzS4TnQsJWGv2nnIHtug/JmDxmMJnXlCKF8pyZBe9pd+?=
 =?us-ascii?Q?2CtE6C5UxWcrjAEdHH+t+SQy+ElY4pjae7HYfEfvAvR8HHLo4d5eJnAqdLCw?=
 =?us-ascii?Q?05Qujxyi9AVe/7s7tz7wFV+5r9+3D1OSmt+GVCYjC2IHDJAwZezrpp00spXP?=
 =?us-ascii?Q?IdHA2pwfWXifqNK6j7Juk5j7WxUi9dMxYApA1McYzbJT3qgdZseU4JatAuTX?=
 =?us-ascii?Q?URNBlIffXT2/YlJYNOh25sgMdiWlTTaJsDwrcsgs0DWhyzyonDNT492dP7j4?=
 =?us-ascii?Q?mW2hinX9g/zUEf3y2onw+lpUrekayVOXf0z208j+wv+Xq07b3Fi88lmfK4d2?=
 =?us-ascii?Q?v0NzM5tN7UI6w1+bFbgYC3KvLCAuRh7yKBEnDASX27OrL9k9RBf3iR9tG9yw?=
 =?us-ascii?Q?b4WgTIJvwvq+i9LJfVOAbCbxaqhqst5FtGe+PeVBhUcWj1/VgxzV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2584f72-62bd-4236-cd6c-08def2426765
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:06:55.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kO4g2GBQkdfc0PpiR+N71EulGzFSTZVp1+rWtFVUHBtzNJdh1zE30VuB8cqEKXkPHdwPECKYvIkKY2z52HzMdKzEDzPb8oZBaHKAoIi7JgBuOF50Ap9kRkRAdjTcSdeP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7753

On Tue, Aug 04, 2026 at 12:38:52PM +0900, Koichiro Den wrote:
> Some endpoint functions expose an EPC-integrated DMA controller to the
> host. The endpoint function should not need to know the backend-specific
> mechanism used to reserve a channel locally and hand its programming
> interface to the host.
>
> Add pci_epc_delegate_dma_chan() and pci_epc_reclaim_dma_chan().
> Add matching EPC operations. The public API returns an opaque handle,
> while the EPC backend keeps any private channel state. This lets generic
> endpoint functions delegate channels without depending on a specific
> DMAengine provider.
>
> Let reclaim callers tell the backend whether hardware exposed to host
> programming needs to be quiesced before local ownership is restored.
> The quiesce may cover a provider-defined sharing group, so callers must
> hold every delegated member and stop peer programming before reclaim.
> Bind failure paths that only unwind local reservations can skip quiesce.
>
> Reclaim is best-effort because it runs from teardown paths that cannot be
> aborted. The backend always consumes the delegation and reports any
> quiesce failure itself. The opaque handle is always freed.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v6:
>   - No changes.
>
>  drivers/pci/endpoint/pci-epc-core.c | 105 ++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  16 +++++
>  2 files changed, 121 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 831b40458dcd..344e54677bfa 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -18,6 +18,13 @@ static const struct class pci_epc_class = {
>  	.name = "pci_epc",
>  };
>
> +struct pci_epc_dma_chan {
> +	struct pci_epc *epc;
> +	u8 func_no;
> +	u8 vfunc_no;
> +	void *data;
> +};
> +
>  static void devm_pci_epc_release(struct device *dev, void *res)
>  {
>  	struct pci_epc *epc = *(struct pci_epc **)res;
> @@ -236,6 +243,104 @@ int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_aux_resources);
>
> +/**
> + * pci_epc_delegate_dma_chan() - delegate an EPC-owned DMA channel to the host
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @dir: DMA channel direction relative to the endpoint
> + * @hw_ch: hardware channel number
> + * @chan: output delegated-channel handle
> + *
> + * Some EPC backends integrate DMA channels that can be exposed to the host.
> + * This helper asks the backend to reserve the specified channel locally and
> + * place it in a state where the host driver may program it through the exposed
> + * register window.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the backend does not support DMA channel
> + * delegation, or another -errno on failure.
> + */
> +int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
> +			      struct pci_epc_dma_chan **chan)
> +{
> +	struct pci_epc_dma_chan *epc_chan;
> +	void *data = NULL;
> +	int ret;
> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;
> +
> +	if (!chan)
> +		return -EINVAL;
> +	*chan = NULL;
> +
> +	if (dir != PCI_EPC_AUX_DMA_EP_TO_RC &&
> +	    dir != PCI_EPC_AUX_DMA_RC_TO_EP)
> +		return -EINVAL;
> +
> +	if (!epc->ops->delegate_dma_chan || !epc->ops->reclaim_dma_chan)
> +		return -EOPNOTSUPP;
> +
> +	epc_chan = kzalloc_obj(*epc_chan, GFP_KERNEL);
> +	if (!epc_chan)
> +		return -ENOMEM;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->delegate_dma_chan(epc, func_no, vfunc_no, dir, hw_ch,
> +					  &data);
> +	mutex_unlock(&epc->lock);
> +	if (ret) {
> +		kfree(epc_chan);
> +		return ret;
> +	}
> +
> +	epc_chan->epc = epc;
> +	epc_chan->func_no = func_no;
> +	epc_chan->vfunc_no = vfunc_no;
> +	epc_chan->data = data;
> +	*chan = epc_chan;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_delegate_dma_chan);
> +
> +/**
> + * pci_epc_reclaim_dma_chan() - reclaim a delegated EPC-owned DMA channel
> + * @chan: delegated-channel handle returned by pci_epc_delegate_dma_chan()
> + * @quiesce: quiesce affected hardware before reclaiming the channel
> + *
> + * Reclaim a channel previously delegated to the host. Set @quiesce for channels
> + * that may have been exposed to host programming. Bind failure paths that are
> + * unwinding local reservations before exposure may leave it clear.
> + *
> + * Some providers share enable and interrupt controls among channels. The
> + * caller must retain every delegated member of that sharing group and prevent
> + * further peer programming before requesting reclaim.
> + *
> + * Reclaim is best-effort because it runs from teardown paths that cannot be
> + * aborted. The backend always consumes the delegation and reports any quiesce
> + * failure itself.
> + */
> +void pci_epc_reclaim_dma_chan(struct pci_epc_dma_chan *chan, bool quiesce)
> +{
> +	struct pci_epc *epc;
> +
> +	if (!chan)
> +		return;
> +
> +	epc = chan->epc;
> +	if (epc && epc->ops && epc->ops->reclaim_dma_chan) {
> +		mutex_lock(&epc->lock);
> +		epc->ops->reclaim_dma_chan(epc, chan->func_no, chan->vfunc_no,
> +					    chan->data, quiesce);
> +		mutex_unlock(&epc->lock);
> +	}
> +
> +	kfree(chan);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_reclaim_dma_chan);
> +
>  /**
>   * pci_epc_stop() - stop the PCI link
>   * @epc: the link of the EPC device that has to be stopped
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 8c89cb6d6733..2d15194a126b 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -11,7 +11,9 @@
>
>  #include <linux/pci-epf.h>
>
> +struct device;
>  struct pci_epc;
> +struct pci_epc_dma_chan;
>
>  enum pci_epc_interface_type {
>  	UNKNOWN_INTERFACE = -1,
> @@ -174,6 +176,11 @@ struct pci_epc_aux_resource {
>   * @get_aux_resources_count: ops to get the number of controller-owned
>   *                           auxiliary resources
>   * @get_aux_resources: ops to retrieve controller-owned auxiliary resources
> + * @delegate_dma_chan: ops to delegate a controller-owned DMA channel to the
> + *                     host
> + * @reclaim_dma_chan: ops to reclaim a previously delegated DMA channel.
> + *		      The callback quiesces the channel or its provider-defined
> + *		      sharing group when requested.
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -210,6 +217,11 @@ struct pci_epc_ops {
>  	int	(*get_aux_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  				     struct pci_epc_aux_resource *resources,
>  				     int num_resources);
> +	int	(*delegate_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				     enum pci_epc_aux_dma_dir dir, u16 hw_ch,
> +				     void **data);
> +	void	(*reclaim_dma_chan)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				    void *data, bool quiesce);
>  	struct module *owner;
>  };
>
> @@ -443,6 +455,10 @@ int pci_epc_get_aux_resources_count(struct pci_epc *epc, u8 func_no,
>  int pci_epc_get_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			      struct pci_epc_aux_resource *resources,
>  			      int num_resources);
> +int pci_epc_delegate_dma_chan(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			      enum pci_epc_aux_dma_dir dir, u16 hw_ch,
> +			      struct pci_epc_dma_chan **chan);
> +void pci_epc_reclaim_dma_chan(struct pci_epc_dma_chan *chan, bool quiesce);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> --
> 2.51.0
>
