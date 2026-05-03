Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8D3128CC;
	Sun,  3 May 2026 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777847893; cv=none; b=E5ti7tJyZLBSfFJN9l1G97MwVoRX53MPQDVr3tzf4Ln4wWS4zU2WtitMzagdsyk8U2IgoOw+3+zj4Weg6m96yOGyF0d4JHUsOIsE7+v1B+JfXE+rF0ZAlJlJx8DKX0hV+urEzzgzmf7cbAOB+f/uxFbPyO35DBljuQ1KBJkpQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777847893; c=relaxed/simple;
	bh=pPXjMhOfCpflhhmlyYKkumuR52jBGn/kk46viaJUi78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL3ur/5WRVY141zfVUEB7soPnP9vxnox4RAZV+3B8jMjGJtWO57Br+unv74eGY2j/IXGaqQCCM69IXvAwmVSUHcBqGzHyGDBSV+TFkhTeqAIOPRstFrUOxFqe651UgL8rOjjJKMY9GmAw0jauYWxerCxrXI8MeCH9Vr+v0JXZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZTIwwbB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZTIwwbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52633C2BCB4;
	Sun,  3 May 2026 22:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777847893;
	bh=pPXjMhOfCpflhhmlyYKkumuR52jBGn/kk46viaJUi78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZTIwwbBnUphlmwz2hbt0/bs5dFD0DM/W5RfCBU0+AoMsof/Pi7lUO1Q0vTYv/eT1
	 wdQxyw1/FrMewmRR/2TXNOTRi7aD8f0NC9nLozyl2lR+npFVl5F07Rx+I4cKxSaT30
	 zP306iB6zqy51AABNhWTJebH6aZvcXCnPfexeIrIAOM67AUxhJXeZf9pVaGi6kjTL4
	 WpKbz3eHNt5dhfK1G2O97jf8IcuxnfawA59MCzhUUJIokhKMJZUOmVJD3b2llf6adI
	 kMXTWD8D3DrlIjMm3LUv3WG4fs7SLXedebQ4/gJrt9c0GgKumwiHjsKlj0/SvnDQtC
	 MTHHz2YZVAM/A==
Date: Mon, 4 May 2026 07:38:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH 4/4] PCI: Prevent overflow in proc_bus_pci_read()
Message-ID: <20260503222916.GA3862479@rocinante>
References: <20260414024544.2975605-1-duziming2@huawei.com>
 <20260414024544.2975605-5-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414024544.2975605-5-duziming2@huawei.com>

Hello,

> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index a5db7d23353a..f11f48becf52 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -29,7 +29,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
>  				 size_t nbytes, loff_t *ppos)
>  {
>  	struct pci_dev *dev = pde_data(file_inode(file));
> -	unsigned int off = *ppos;
> +	loff_t off = *ppos;
>  	unsigned int count = nbytes;
>  	unsigned int size;

You could merge this patch with the previews one.  This will close the gap
on the signed/unsigned promotion issue that Sashiko is complaining about.

Thank you!

	Krzysztof
