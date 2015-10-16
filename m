Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17318 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbbJPFpI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 01:45:08 -0400
Subject: Re: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback reusable
To: Marc Zyngier <marc.zyngier@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com>
 <1444923568-17413-5-git-send-email-marc.zyngier@arm.com>
Cc: Ma Jun <majun258@huawei.com>, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <56208EE0.1030604@linux.intel.com>
Date: Fri, 16 Oct 2015 13:45:04 +0800
MIME-Version: 1.0
In-Reply-To: <1444923568-17413-5-git-send-email-marc.zyngier@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/15 23:39, Marc Zyngier wrote:
<snit>
> +int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
> +			    int nvec, msi_alloc_info_t *arg)
> +{
> +	struct msi_domain_info *info = domain->host_data;
> +	struct msi_domain_ops *ops = info->ops;
> +	int ret;
> +
> +	ret = ops->msi_check(domain, info, dev);
> +	if (ret == 0)
> +		ret = ops->msi_prepare(domain, dev, nvec, arg);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
Seems a simple "return ret" is enough:)
