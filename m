Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B152F7F07;
	Fri, 14 Aug 2026 01:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669970; cv=none; b=uudTTE3u1hfe4c43ZqDDnxNPYKz9hyIYu+09uPuV+cCvSXhUZ0BlM2d4pyI3UC5WGvWKhtNp/AciTgxEmlkF2GwG7zsJxpLrknu4GNV3rSLQPDRbjXO3ymPsninKg2nfTRKIJuqjSGw5kSTZKoonaIsepKaaZ90v2EWd9mO9CLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669970; c=relaxed/simple;
	bh=XxoP72+4onHvtorUWYmdLFUXTS6VCsdbv9XtwQqPQ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKzCRtPYzZQ6/q7m8S8OnXcuSTyfiw2B8hvL9w9S0H0ahFI+Tuze9ASuvdA3lHzJlDAwkvwxQfWN0OhF8Dj1YFD6XGeHdXaAGNaYLUwrgsET4hA9uiT5pFXC1SBOil4pUmefdjdF7CZAFLbOKU4Ht+HHy2Tq9BO/JRTUT6xGKe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EEIthWc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EEIthWc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931DC1F000E9;
	Fri, 14 Aug 2026 01:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786669969;
	bh=XxoP72+4onHvtorUWYmdLFUXTS6VCsdbv9XtwQqPQ2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EEIthWc9NqH1d8nnlQ7teioLM4ezt8RmFQMpSPjHuIr5MV+nn1hs65SpxDVafNRlb
	 62QiB4OiDSCRuNBKJWpsLHQM2PzgYo03kgmaQ+T0DQVWC+MHdebNElS7NpP+vsTxlX
	 0cp+VTUfHxSRurWFDEeX/lqXLuoyUZ3o6rBwIAlg=
Date: Fri, 14 Aug 2026 10:11:15 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, arnd@arndb.de,
	bhelgaas@google.com, daniel@riscstar.com, mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] misc: tc9564: introduce base PCI driver
Message-ID: <2026081455-eternity-douche-900b@gregkh>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813222943.1655453-3-elder@riscstar.com>

On Thu, Aug 13, 2026 at 05:29:42PM -0500, Alex Elder wrote:
> +#define DRIVER_NAME "tc9564-pci"

What about just using KBUILD_MODNAME?

> +static int
> +tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)

But wow, this is a tiny driver, feels odd to have it in misc/ but ok, if
you think it should be here...

thanks,

greg k-h
