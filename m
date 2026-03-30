Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4843939C1;
	Mon, 30 Mar 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875517; cv=none; b=Fra+0dAMqp8IwpIMJbHHNAHuDJbg8lzlQjvHlcMDG5U/3LBRhr+o+3ZivplkFQ/kFE9llluMwYB2YaXYLJqSH3sPAuJo3HQ++jExfrCjirPKemMfLOI6joEqme8UHdvqrG59pqonwR0JyqlxAbWtWBOC7Q94i53QLLW/P7JevN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875517; c=relaxed/simple;
	bh=PRWRS1y7X/MfBpQo+6Te6Xklvs2aCvMc7pgAzbZXuQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou40ewn+/Mog3nxzLkqdYPDUmqhb3PBrCz1F0+p1HabertJ1ISmsWCVjdlcNU7n1zsKov6JdNQLjFn2+Q9SJfyDcg9jAiVeS77c+cc2UUoSzi3YuRvpnThZ9cuOj7P1ayV4/mKd7kRm7PZnayiOjohBJanWGk0LGbmM6B7hzods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uwdjQ7U3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uwdjQ7U3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NMFeae0iIn+44Qzvy0HJXF2cjdWqleXSSD6r9aF4fCo=; b=uwdjQ7U3/lspCYMY9lvohrzx3Y
	vqO2yqqx+XB1NGIhV9jKU25DPk0LUwOwF+0YWqdQ9FZCS9wQ0TAuxTwybtf7C7goqGsDO3VQs0BPk
	ObzF7ayoZPs9dhTwivF9ccnJRElEYE9gA+un5lBQvyDOtlyUQeHEsh1BmbaHJrAZ1LwD+fEJYTjlc
	QTkUMQfgYN8UVaUe6+CwN6doq8HIo9oy5GHCnkKN7qkBjHxPkT+cpEN4YKblBefDO+c2mAh/sp0VV
	h2nnP3EuNXIWrXqjaaDAV30kkMNLESrfKYrdMmFNGH6vsQ7GC0YtgcZtbeGToP/3VZsTtygsJyfif
	ANi6ZiHA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w7CCE-001SdQ-03;
	Mon, 30 Mar 2026 12:58:20 +0000
Date: Mon, 30 Mar 2026 05:58:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: rafael@kernel.org, jonathan.cameron@huawei.com, helgaas@kernel.org, 
	guohanjun@huawei.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev, linux-hardening@vger.kernel.org, 
	Shiju Jose <shiju.jose@huawei.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Jason Tian <jason@os.amperecomputing.com>
Subject: Re: [PATCH v3 1/3] ACPI: APEI: GHES: Add
 devm_ghes_register_vendor_record_notifier()
Message-ID: <acpzW5JwnGISimIU@gmail.com>
References: <20260330094203.38022-1-kaihengf@nvidia.com>
 <20260330094203.38022-2-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330094203.38022-2-kaihengf@nvidia.com>
X-Debian-User: leitao

On Mon, Mar 30, 2026 at 05:41:55PM +0800, Kai-Heng Feng wrote:
> Add a device-managed wrapper around ghes_register_vendor_record_notifier()
> so drivers can avoid manual cleanup on device removal or probe failure.
> 
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>

Reviewed-by: Breno Leitao <leitao@debian.org>
