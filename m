Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B7F9D9;
	Tue, 12 May 2026 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563761; cv=none; b=pI8dC2kPIYeD2kzcUH0gwLKYVP6bWYmzDf8w+wjr1WSI/gGLfHpA3RGAp4wWSILhViDjIbpDoCc1iisX78aMjC92/e5SaH7m9gu1dv3sqc7n0d4Ff33PQwKTVf44tybSxzvFtf36r0tYKBWjcFSkKubvD7hTxVpKU2B0Ya/u7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563761; c=relaxed/simple;
	bh=5DNwwoc+9Y4Sv2x/Uibnay3me/mlJTOHMSfGbYSU3Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI+FlZ6XBlpExyHseaBrULLMDqF57Awf5PXbLGAdM6YDC6vKZ3LWxS1lHrUWEdIFNA7XsZIPPs7vXyH0cF+a+VQycpxQhs9cF1oIYo4mg4cYhY8UnerhPcbksUkpIo9ffQaxpraRnYHD/S/z9VpdVzYd+8PENrBqC3tHS1ulb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVOKKaxY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVOKKaxY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B517C2BCB0;
	Tue, 12 May 2026 05:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778563760;
	bh=5DNwwoc+9Y4Sv2x/Uibnay3me/mlJTOHMSfGbYSU3Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QVOKKaxYEZUnX+GQ2QykeuD6y4xUkFqCfUqLvV/DL9cNqf+RMecw66ONApo04A5eC
	 3FIDLS8e5VRFUtdaW0q5FbKh8ZlyhU4lPcIr07BkGwrNH7a+gwY0asI/YE/JtvJhso
	 Ix1j5amEJzxAoOoBOWJv+Dnufd06+bOwV9pXChzpuxcM4J32S+RqiiCc9G88lUWv0W
	 UsKc8c5WwVi6IPqGE2k61goL1xAhU3lrlYMsoBE0cnsKigxjKNghia1egX6j1tYi1p
	 DFRVQimN52uA4MpRpz7uzQaxO8UURCpXeOCL0V8GH0MmCYyt/6nvzTEWyd9TCRRGEr
	 KT3ENeLpOVj/g==
Date: Tue, 12 May 2026 14:29:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, den@valinux.co.jp, 
	Frank.li@nxp.com
Subject: Re: [PATCH 2/2] PCI: endpoint: pci-epf-ntb: Add check to detect
 'db_count' value of 0
Message-ID: <20260512051926.GA1687877@rocinante>
References: <20260407124421.282766-1-mani@kernel.org>
 <20260407124421.282766-3-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407124421.282766-3-mani@kernel.org>

Hello,

> @@ -1297,12 +1300,12 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
>  	vfunc_no = ntb_epc->vfunc_no;
>  
>  	db_count = ntb->db_count;
> -	if (db_count > MAX_DB_COUNT) {
> -		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
> +	if (!db_count || db_count > MAX_DB_COUNT) {
> +		dev_err(dev, "DB count %d out of range (1 - %d)\n",
> +			db_count, MAX_DB_COUNT);
>  		return -EINVAL;
>  	}

Something that I was wondering about here: would it make sense to also
remove this variable from here, too?  Even though it's referenced below
here (which is why I think you left it here).  Thoughts?

Thank you!

	Krzysztof
