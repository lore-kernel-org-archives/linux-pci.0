Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C161221D9B;
	Thu, 22 May 2025 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747897846; cv=none; b=Fo58Z6cASfRChQY1MHOv+9ao9KFS5AAbjqVprlbn4puw0Md9h06e3iIPvTl+iJ4kKkvUaqvilt6x/SQh+LaRwnobRCmeJmAoWCaXeh+hTk5PMMx25MrTnvxseMjlz0njQPz618itGMlkI+kwNFA/UEX2C2XFJ3SjkroECd1aaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747897846; c=relaxed/simple;
	bh=Ug1W8EFqGslpRqksKKj/3dbOeQK9KUmvYYxqb2arFMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUqbx+x5cqmTDyA62KRzMYRQphYc5r7bq3tHUZBCoHCKMnVksIfV9nZ9guNdrqOKtCDFeqfZzUtIacGN0zdyRnA/hjN8gm0UWcNFXoC1a9A7KG/P6vBQQ3hg8S9OxQmQ4CaSBPmhc60Z5+Y4M+4fLY9h9mAAl5GESWieHB5nil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=HUHdBhTU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="HUHdBhTU"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B6CBA4B84B;
	Thu, 22 May 2025 09:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747897836;
	bh=Ug1W8EFqGslpRqksKKj/3dbOeQK9KUmvYYxqb2arFMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HUHdBhTUQEfVecMBl9oB1ALPOaub2zSsDxBIHLUEcP+0Aci6NH7lmJbOqiR1Uy61V
	 E2STmdTOlzqitker2vja2GTYeZ+UaS80PLY/c6UikF5H6j4KJjrH4a3U0DCcr+jbKV
	 d4974q/m8vay76lA3WYlxxrDgWPBzceZul20MmyN/nrEC/UKVN/hujXg4VSOVGMuvj
	 dABS7SO3EpAozgMELyKbQLJG6V2bqfN463O4adn1dJ4I+uNQl0Oyo6NEBMrTrpFm4r
	 OJOeOnDGU3slYxeJAgfiUKfdC2yCJCQtfMx9YGGI4ERasZNhvX4cM7r6oHt8BtTYLK
	 giunrkE9QJR+Q==
Date: Thu, 22 May 2025 09:10:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tushar Dave <tdave@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	jgg@nvidia.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 rc] iommu: Skip PASID validation for devices without
 PASID capability
Message-ID: <aC7N6zeTWZJ-Adkj@8bytes.org>
References: <20250520011937.3230557-1-tdave@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520011937.3230557-1-tdave@nvidia.com>

Applied, thanks. 
