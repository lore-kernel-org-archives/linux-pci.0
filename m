Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60E322B61;
	Thu, 22 Jan 2026 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040021; cv=none; b=PXko3m/yyAgdqrS0rJj3iMKAiYHZYCoZoUmUijMdu+pr6/R8GiRPlgsCObU+D0tz1QIt8936RKvlHxZYkGpfAhy74ay6JyiLhKBrpmFUXmapsbulrfRk+IAKJ3vh3CjLBKmcxbC0fB+cYomaIuP1Q64GoGZ37qEvz2L6G39u3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040021; c=relaxed/simple;
	bh=CvEJQqj+xlyazJqlcbH8vEaAaMjIKjRUQx0RBbaHBQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zht0aqS4AMBKLR3DlQ427RwbazgvBBel+HzirEkANfKKti+tPl0SduQUalneo2dIInSZHmachv5KtPyhQoERjC4HdENMsUx7Yc+A3yX8MGW6Qf0CUDh68YF/CVh6ZiY7vwsyObwkdRc717L14l12y0kF9YAvGWSKy1pRUhU72v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8BZjd+G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8BZjd+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A77C4CEF1;
	Thu, 22 Jan 2026 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769040021;
	bh=CvEJQqj+xlyazJqlcbH8vEaAaMjIKjRUQx0RBbaHBQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d8BZjd+GhzFdOJ1BA/CELH4X//BLLogNSQfhGLO7hFwUfha43lADQdYEHSawBZ5Lc
	 Y1GRb5D3epn3sS27dI0mFeVTIewtxaIlVuWYooOcvcmMf27mIAS4wRm+cjgKJq2tOi
	 MVERYzz7ywLj7Ou0sFybktCUVa5/WcFJNthjRR81hBhnfktPLeXM8hHAINbVPRuHTP
	 QPQVJKGLu39r0oeYvMBKKjCzgnIkQS231aXrws9YWN0H+xl1APZU5pKJGmj6uieO3X
	 OV8CCmU8Q0jphGdJYY+WeDV+/B/64xeCIlrOv0if9j9W7jq2Ke+M9qrxVGD6i8hdhX
	 zPUFy1W93+8Pw==
Date: Wed, 21 Jan 2026 18:00:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: smadhavan@nvidia.com
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
	ming.li@zohomail.com, rrichter@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, huaisheng.ye@intel.com,
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com
Subject: Re: [PATCH v4 0/10] CXL Reset support for Type 2 devices
Message-ID: <20260122000019.GA1224145@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120222610.2227109-1-smadhavan@nvidia.com>

On Tue, Jan 20, 2026 at 10:26:00PM +0000, smadhavan@nvidia.com wrote:
> ...

>   [PATCH v4 1/10] cxl: move DVSEC defines to cxl pci header
>   [PATCH v4 2/10] PCI: switch CXL port DVSEC defines
>   [PATCH v4 3/10] cxl: add type 2 helper and reset DVSEC bits
>   [PATCH v4 4/10] PCI: add CXL reset method
>   [PATCH v4 5/10] cxl: add reset prepare and region teardown
>   [PATCH v4 6/10] PCI: wire CXL reset prepare/cleanup
>   [PATCH v4 7/10] cxl: add host cache flush and multi-function reset
>   [PATCH v4 8/10] cxl: add DVSEC config save/restore
>   [PATCH v4 9/10] PCI: save/restore CXL config around reset
>   [PATCH v4 10/10] cxl: add HDM decoder and IDE save/restore

Please run "git log --online" on the files you change and match the
style of subject lines.  In drivers/pci/, the subject lines start with
capital letters, e.g.,

  PCI: Switch CXL port ...
  PCI: Add CXL reset method (but please include the function name)
  ...
