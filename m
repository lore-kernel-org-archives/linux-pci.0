Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4C43D51F;
	Thu, 26 Feb 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125252; cv=none; b=qrbVD49MvmrYdRLxM+BF9MF9TLEM0Ww5tFFs4eFngf8gkVQxuDaiR/9b7+MEmDDLBnJzrNM6Rko9tJ9hBrFlZSHAqnqI1ZKmujOGYRH/0/a4+xItN8cCNF+mwW3ftCV1G49aMizDbk2xSag5W+AY1m4V0BwVrBumDd3TppsOmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125252; c=relaxed/simple;
	bh=YDqBZOq+fF0XFfPl971H3yYC9SdXgSm5tmX75Hb8Qp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rWSPoqbUslziH8kwMdwIDjrbLktKB8GJLv1z0HW5TVARZDE9XGZSMOxW5MZHEtmOBk7vjLOuezpLT7h5T7q4GbDD8K6/gj8lam1mpuhayYd48DaPbhbe5pVY4Wznnjwvb16/IuVyhZ2UwQ1B8XUcOqeBafQMGqwTLT0jbRQp7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTy7rrI/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTy7rrI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A961C2BCB7;
	Thu, 26 Feb 2026 17:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772125251;
	bh=YDqBZOq+fF0XFfPl971H3yYC9SdXgSm5tmX75Hb8Qp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DTy7rrI/sUaPZmfq6KNO+ZEmaqTXtLGkXKvSvPKyDgv4uaQyRCjP3pCX//hti6Pk+
	 nxO0dxy8/B0xAwvIEhSlnm4abcYGFcNoyiXLOaKsy8jOAKyf9qsqMiP7CVI+4CGk1e
	 D/fjE6Asu3Zkra+pyrswwafK6WnMI2J0vvRRc1OdsA/ilECOaNHwW/SNLHo/lsiSwf
	 feKk5RIT7r4v5NvTvU84Iozbx0Cf4GayzFKi5hS6VrZLaRoS9KgNqz9Ol94vUMa00F
	 zEOKUVSr/zuKaIQSzeSdb64O2FMsmSNEk+Vpr5BBhzDfiDJbdcnkh+AuH43UTDh1PO
	 5apzdRupmrKng==
Date: Thu, 26 Feb 2026 11:00:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, alex@shazbot.org, chrisw@redhat.com,
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH v4 1/4] PCI/sysfs: Prohibit unaligned access to I/O port
Message-ID: <20260226170050.GA3812835@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116081723.1603603-2-duziming2@huawei.com>

On Fri, Jan 16, 2026 at 04:17:18PM +0800, Ziming Du wrote:
> Unaligned access is harmful for non-x86 archs such as arm64. When we
> use pwrite or pread to access the I/O port resources with unaligned
> offset, system will crash as follows:

> @@ -1166,12 +1167,16 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  			*(u8 *)buf = inb(port);
>  		return 1;
>  	case 2:
> +		if (!IS_ALIGNED(port, count))
> +			return -EINVAL;

I assume "IS_ALIGNED(port, 1)" is *always* true, so can we just do
this once before the switch instead of adding it to the "case 2" and
"case 4"?

>  		if (write)
>  			outw(*(u16 *)buf, port);
>  		else
>  			*(u16 *)buf = inw(port);
>  		return 2;
>  	case 4:
> +		if (!IS_ALIGNED(port, count))
> +			return -EINVAL;
>  		if (write)
>  			outl(*(u32 *)buf, port);
>  		else
> -- 
> 2.43.0
> 
