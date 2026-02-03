Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491938F25A;
	Tue,  3 Feb 2026 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770104705; cv=none; b=irYauq5c8ak50WxBM2Gh4Xr/Fu0zHnGsAub17am+2/Xuv2Zx4TJo1ciJV2GYRIUcIdw/v1v+y8vkEUMKH9BupWEkykJxUuGHDSU8YzQYzX+xiIJtxwN13Z6f1Vo70msDfqHjespiRc7X1sabka25t8fOx0gh/AqcWTKYqOLW96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770104705; c=relaxed/simple;
	bh=WZR2xBpkNn4oSjDyYO/uFQ1+HM1i0cNvcz8kJScv9Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAQL4w0kxcI7bVOTjXt8Cl3/cWvqO9XFSxgGz2I4+V1W1uhcxNGetRJxkhMLUX1fhNI4GN5AOig/oNvknuIJplcwdQrOwIC0yHGvbYQjXo65mfDJQVdVItCT30I6uxkusaisvJZkO+0hu2LRtqAUJv1OoCQnHlzDjh3d37EuHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id C7AB02007FCC;
	Tue,  3 Feb 2026 08:44:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A334D290DB; Tue,  3 Feb 2026 08:44:59 +0100 (CET)
Date: Tue, 3 Feb 2026 08:44:59 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, terry.bowman@amd.com,
	tianruidong@linux.alibaba.com
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
Message-ID: <aYGne72Gjb_d9Myd@wunner.de>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
 <20260127104520.0000579c@huawei.com>
 <881e57b7-aa73-4df6-b37b-d71571567436@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <881e57b7-aa73-4df6-b37b-d71571567436@linux.alibaba.com>

On Wed, Jan 28, 2026 at 08:45:36PM +0800, Shuai Xue wrote:
> The revised the commit message is:
> 
> PCI/AER: Only clear error bits in PCIe Device Status register
> 
> Currently, pcie_clear_device_status() clears the entire PCIe Device
> Status register (PCI_EXP_DEVSTA), which includes both error status bits
> and other status bits.
> 
> According to PCIe Base Spec r6.0 sec 7.5.3.5, the Device Status register
> contains different types of status bits:

Always cite the latest spec revision, i.e. PCIe r7.0 sec 7.5.3.5.

> - RW1C (read/write 1 to clear) non-error bits: For example, Emergency
>   Power Reduction Detected (bit 6). Unconditionally clearing these bits
>   can interfere with other drivers or subsystems that rely on them.

It would be good to explicitly call out that this bit was introduced with
PCIe r5.0 in 2019 and that it's currently the only writable bit in the
register besides the error bits.

> - Reserved bits: May be used for future features and should be preserved.

Wrong, they're marked "RsvdZ" (not "RsvdP"), so they're supposed to be
written as zero (not preserved).

Thanks,

Lukas
