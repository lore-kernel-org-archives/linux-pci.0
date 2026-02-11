Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E3221FB4;
	Wed, 11 Feb 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799401; cv=none; b=bPID5cHZbTfUFE8yd9LmyMKCQifu8+iWNv07j8/+xm0JeIK3Rg86Ub/zbZKroPfObP+O3jJayyBVIglNPTq+2GvsCKlOzjzua2vn8LgmQywt5I+aC+ke1K61suZkvqB57OpTYWb+ppF7dzHPolbeCOcWfK/teBDEni42Gnk5c9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799401; c=relaxed/simple;
	bh=ez+Ml4J41qU4oJFO8qpTIO8/vPHlgWtkumy3f4leCq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKXPYhh9uZhMa7agjVg38KfTcoLiSoxMSaIyRlVg10IRZgKOt7yA6Fa3zQApCcaGrjcKU5Rvzr5zH3w0aKDogKJdK5QxhsMPQYXMGAYU/y91YzHle8YlZtQXiFafTaD1fcHZsxFitgCsJYT6JfiGIaWCnKP/7Ok4eZ+1IdY80Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRl4DO+U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRl4DO+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1EAC4CEF7;
	Wed, 11 Feb 2026 08:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770799401;
	bh=ez+Ml4J41qU4oJFO8qpTIO8/vPHlgWtkumy3f4leCq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uRl4DO+UEflDSODXPLxgbETiDBZ24LqhmXcf/LO/0WxwQpVrQWi54ESZbrjJCX4Qm
	 SgOv7Q/tUl1QGkHvrwlMofVwwJ4gKD4RIHZE5eWq7gG0NJmJ9Kky+x3fSB3r1N7B02
	 K+rL9xlUEtHc9Ua4ItiDlhdwjuHoujhDz0MxAggXzRwA84hmfNZTkMtEOx3Zqjnp1W
	 4XwzW3xb0WQHTCqNebp8TtuYZEyi2I6lIPagFIh5t0B+evgKIwZMEg+hHKPrrdNaUo
	 08GwqjV+EtybUyO9sfFid5ShfQdJaAuIGYVuYXhtCrXQdsT7gR2c6TXMdrsDhm11ag
	 boxANc6+V7ZJw==
Message-ID: <a2a0afd3-35d6-48f9-80e9-0c7e6bd1ce7f@kernel.org>
Date: Wed, 11 Feb 2026 17:43:18 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: select configfs
To: Arnd Bergmann <arnd@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kishon Vijay Abraham I
 <kishon@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260211070812.4087119-1-arnd@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260211070812.4087119-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/26 16:07, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Like some of the other endpoint modules, this one now also
> uses configfs, but is missing an indication in Kconfig:
> 
> arm-linux-gnueabi-ld: drivers/pci/endpoint/functions/pci-epf-test.o: in function `pci_epf_test_add_cfs':
> pci-epf-test.c:(.text.pci_epf_test_add_cfs+0x2c): undefined reference to `config_group_init_type_name'
> 
> Select the symbol as needed.
> 
> Fixes: ffcc4850a161 ("PCI: endpoint: pci-epf-test: Allow overriding default BAR sizes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
