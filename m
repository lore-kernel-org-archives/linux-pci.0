Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B72F12DA;
	Tue, 12 May 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587411; cv=none; b=haBqtB7+o+rMZ48/dEbGCAW3ECLz9S74QpNlpd+wku9r2gWZsNYX9d/F6ZCmMqV1r7utzcepRg4yTdyksYV0pnzbPHNkV9t7OL4k1G8JOnB4RKrz/G/cgQ6rLbHQmdvjpFPs5hINamdmJwk9wRWWAmRdY63fndcIF+TFiXA7CX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587411; c=relaxed/simple;
	bh=BBYwGjLHKwHhymX8Vo8UZo9zZ2Zfh/y7xMRlLtINGBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/acg7fVPeCMdTIpJ4kLVT+/TRamRBI611jMtPBlfQJ9QFYqyCY/Y4/lMCBUVBqSGsT9TraKNNFBCndIbFvLRit0bobaeCSrw5MFDQ3/xxAuolKns1pdrLud1/a45FCA8UEm6sHNjMQZ7dobsbT5ieFzfA2VoUl6AZ95uk5opaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulZyNV1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulZyNV1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F13C2BCB0;
	Tue, 12 May 2026 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778587411;
	bh=BBYwGjLHKwHhymX8Vo8UZo9zZ2Zfh/y7xMRlLtINGBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulZyNV1m0vpZodm4jV8nkmzyj//1XSVdAqX6H57Db0egvA0NVdtGTSTfNFNo1jm97
	 EZmmvfK7xEyFMzSSyjfN0UXrad0ltoj0ACdDCGssAy869xPhppXzMdTI92MuIzzxg+
	 0fzFCn8tp0PPXdY2IWSsFhFRszzlacWzmXo8UPm8TlJN3jMb1D11MxyufjuYJgwLCB
	 HLVuXp5dcHEdWMrhuukhT73q0TSIszX/thXx/d6LmhS3iEQWcfqAwMLcuw9UJsj4gD
	 mzmT0y1jL5f4RPTPkE98H6liU5TXlaCiz50+BZd0wphXuRxX4A+r3k7hUYwwqCPmny
	 hYndN+BFQ5oEQ==
Date: Tue, 12 May 2026 17:33:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yanghui Ou <ouyanghui@eswincomputing.com>, Yu Ning <ningyu@eswincomputing.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: eswin: Fix resource leak on dw_pcie_host_init()
 failure
Message-ID: <yf5ygcwgnlmypii2rjhsoatcqkhxczwtjheralz3fucr7t2idt@5kydnepm7jn4>
References: <20260416-eswin-v1-1-a4991725b5ca@gmail.com>
 <gs3kbuwifduoa3gdhyxpg25tl5kifmlxdavgjgyxmihyt4hmr4@bcwz36emppw6>
 <CAN4SLj2BwACgt-doo6g3KTApC9Rjwm15jSvyWBp3gOysp0Og1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN4SLj2BwACgt-doo6g3KTApC9Rjwm15jSvyWBp3gOysp0Og1g@mail.gmail.com>

On Fri, Apr 17, 2026 at 06:14:39PM +0800, Felix Gu wrote:
> On Fri, Apr 17, 2026 at 5:35 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > Error path is really messed up. On pm_runtime_get_sync() failure, it should
> > go to 'err_free_ports' and on dw_pcie_host_init() failure, it should go to
> > err_pm_runtime_put.
> >
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> Hi Mani,
> For pm_runtime_get_sync() failure, it still needs a pm_runtime_put().
> So it doesn't need two labels here.
> 

Ah, I missed the fact that we need pm_runtime_put() in error path also. But
still, the order should be reverse. First pm_runtime_put() and then
list_for_each_entry_safe().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
