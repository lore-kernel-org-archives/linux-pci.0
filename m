Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600802F99AD;
	Fri, 30 Jan 2026 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741601; cv=none; b=gi8GeyL+gyt2DXnrIiznh1oGJJ0gLtjQHYizeeYJtV0VLQu8y29JD6gODdC2Md8WDzHZgHpEMW3aQYvtGDG8GkD5xdDJX/7FThGp+iG/bk+7U9eJW2kFKZ5V4Swzp6aG9FwQ5B3YpEkDaJYQd7xl7qf6bdx72MGi7whauAdnMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741601; c=relaxed/simple;
	bh=p5JasSD4IQZuvox2fyRIr9Gdi5bOXFkGxTunRvaq0dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7FMG6O/V5U4OHbTFYwpEtt+L5eSOoWsIy4E16AfwvDP8ZNPkjRuuQCLjfAkNF5s/Ij+4eW4MsHgJ8cxIUuLV7PYTLnLgTCXPK+uzyzpjYsl2qH8ygSyCCqRSlmFxYSkY2yMjJx/Xh2uNCTYsqzO7/r7d4NB0Z12/KAfCcxMchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvvRrFs3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvvRrFs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779E7C4CEF7;
	Fri, 30 Jan 2026 02:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741601;
	bh=p5JasSD4IQZuvox2fyRIr9Gdi5bOXFkGxTunRvaq0dk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EvvRrFs3ulBjln6SQAeoTYBfblkJtE8Ft66bzBN5CpREKQTt16GqeXsiMiCUY31gP
	 536GE0exuOME9T7riuuZsxLJIt2XroiRS4HgiYW+nocIEwmcx8lz48IiWL0YUFWt7k
	 kaFc3uQmiJh7WO1olnSm2NikZA4Dnt6bDgDuGWarmGG6cO3/3RuLSqqiOMunq0brqj
	 2eSx1iNSiX3Iz/ace80skveTmF0Dwsk1iyQ0lkNHQ/FlJLoeuzF+OSYjM0lDIuAVz/
	 JrZoJ8zfjSsNMcv01wMs5Fd2daIjM9GzBOfvc/JmVsFEGXOXBHxN2wCs9aeMnB3Bd/
	 WOG6eo1WZ7oiA==
Message-ID: <feabcb08-bbc1-4d99-8529-7f3a7a442fcf@kernel.org>
Date: Fri, 30 Jan 2026 11:53:17 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-test: Allow overriding default
 BAR sizes
To: Niklas Cassel <cassel@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Frank.Li@nxp.com, Koichiro Den <den@valinux.co.jp>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260129132324.2036310-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260129132324.2036310-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/26 22:23, Niklas Cassel wrote:
> Add bar{0,1,2,3,4,5}_size attributes in configfs, so that the user is not
> restricted to run pci-epf-test with the hardcoded BAR size values defined
> in pci-epf-test.c.
> 
> This code is shamelessly more or less copy pasted from pci-epf-vntb.c
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

One nit below.


> +#define PCI_EPF_TEST_BAR_SIZE_W(_name, _id)				\
> +static ssize_t pci_epf_test_##_name##_store(struct config_item *item,	\
> +					    const char *page,		\
> +					    size_t len)			\
> +{									\
> +	struct config_group *group = to_config_group(item);		\
> +	struct pci_epf_test *epf_test =					\
> +		container_of(group, struct pci_epf_test, group);	\
> +	int val;							\
> +	int ret;							\

You can use one line to declare both variables.

> +									\
> +	/*								\
> +	 * BAR sizes can only be modified before binding to an EPC,	\
> +	 * pci_epf_test_alloc_space() is called in .bind().		\
> +	 */								\
> +	if (epf_test->epf->epc)						\
> +		return -EINVAL;						\
> +									\
> +	ret = kstrtouint(page, 0, &val);				\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	if (!is_power_of_2(val))					\
> +		return -EINVAL;						\
> +									\
> +	epf_test->bar_size[_id] = val;					\
> +									\
> +	return len;							\
> +}


-- 
Damien Le Moal
Western Digital Research
