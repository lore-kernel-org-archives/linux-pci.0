Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3D26560D;
	Thu, 29 Jan 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696994; cv=none; b=W8XsGjalEwrTf+ndGUnFSNPbxZXTuyCBQpQA35NW7mwvEH3gsgNw3TlGZHWzlfCa26mLlA84PXl6+t/Rm7h0j+Vy6vplfR2W2bOTyQUbNgOKFlOCPnES9GhYUauQYDQQXorkfZjtdZoX0UfxPgPxikRAg8gCU3tHF0Ouqs0rbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696994; c=relaxed/simple;
	bh=UKA9R4qgln1sqxh0CDdml8eimmbHOY4bqjY2l05sqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stum65tcDTD0jNIOeapZQTQzADIB17pOl01MK1BHZrAlBThv0toRB6QDBQH5KuTIql/qXHJBRJnrZscS/6E32Ujt4156NXg91rd92nbkHBg9JPhGfMK1mr7ZPSh3TyIeMRL/ZhZJCOmMl5TlQqQ3Zp7Z9ZcEyUKKIfbWQRTEFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic5CY6Ww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic5CY6Ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3C3C4CEF7;
	Thu, 29 Jan 2026 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769696994;
	bh=UKA9R4qgln1sqxh0CDdml8eimmbHOY4bqjY2l05sqLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ic5CY6WwC/ybILmnkH/6mEKftE+LYvh4QSENQkWZU7f0T6EVKgHkyRnks/nxD1Sym
	 67SyuxgtIIXLg41OP+ujmRQ5eiMQ2dJNu2YDBhT82lMFBboz5YWgCuEtEkAbqozFok
	 EpDwzue6WYXuii27BSmLW1qDyN7nqZpK0s/GQG1tKatz9dq4Sng2nlc8KtQEHjnKe0
	 Kb9SELa/OIiwRWWHluizAdo/Y65BOGvRYEBzQus3zp6BTp08WO2NA8oMyARbTlLnwy
	 yVDL6kVny0Xqweyjr8BITdU1TBDglZeayF8GX0nNwh0NBi4Wtu1dWnVCE5DB3iRhCv
	 /TRLMp0NdPVkQ==
Date: Thu, 29 Jan 2026 15:29:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Frank.Li@nxp.com, dlemoal@kernel.org, Koichiro Den <den@valinux.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-test: Allow overriding default
 BAR sizes
Message-ID: <aXtu3eDffk5nsDx0@ryzen>
References: <20260129132324.2036310-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129132324.2036310-2-cassel@kernel.org>

On Thu, Jan 29, 2026 at 02:23:25PM +0100, Niklas Cassel wrote:
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
> +									\
> +	/*								\
> +	 * BAR sizes can only be modified before binding to an EPC,	\
> +	 * pci_epf_test_alloc_space() is called in .bind().		\

Argh...

This comment was supposed to be:
... EPC,
as pci_epf_test_alloc_space() is called in .bind().

(I forgot to readd the word "as" when rewrapping the comment...)

Mani, if no other comments, perhaps you could fixup while applying?

(Sorry for the trouble...)


Kind regards,
Niklas


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
