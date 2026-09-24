Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22022C0294;
	Thu, 24 Sep 2026 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213501; cv=none; b=V8IzARtxdiVdTgQxNVJvB99heYHV0dbaCKkejO0X1TPkTOjsA7f7S61Jrh99HOj7MkCcoC0xkPQwuySXj1oVW6AONy2rNrQR6EVX5Y06rS0rBz0Unc/vfigQlFV+W3RE8a+rAVgHErkl61GRqY8jYCg5Evv2GiEKojXqQzaOTA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213501; c=relaxed/simple;
	bh=UDR0nbQMFET9FDQhIA8UYCdxGosvJXvtlrjnaoRB7Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SioJfLwE0CcdTj7C1IqTLOtM1XwBmHipdTtwkAfNlCjeqvCIt7uxFui2L9vwCfQBaihELKpst0Nu8xkLafMQDuugMyrb9U81IlB0ZYtilmEuRLFRp4MaiAKgGzdCZqv2b8mwqmBQepbdmeEJCTiNqGiNHf0quZXHqY/Uj5t2T5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB7QuYuJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB7QuYuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776D91F000FF;
	Thu, 24 Sep 2026 01:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213500;
	bh=QmYwkYIpNGIie6o8uVKCEr+W7CiDvTp5NNZUrL/u2Ng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AB7QuYuJtZ5AH2lshM2dr7dgyimicBRXA2HHtlQBp7TAGzKmn/pMcYC/+APF0qChp
	 Pl09GRMKFwr11gkLX1PsdPEGBidf3iB46gUSe5Oy1+8qVU00Z1fpaZTLRy4PA5fGYK
	 A/tL0Xxq6WCcXslJsOMQy7vCPCrbgDTk25LMvKGpvvJmnmkmjzGHXjyFJLSQQv7qDx
	 G9Xc9psKiTQOyqeXdW4WUCc8fkA2ENpEhox2blP7Ovfbl27SzAToWFLbF/aGE0OKyq
	 MkDHAPU7pabU9WAQDCIx257KTNXFD6hgP/erOSqqXlt5z3CCfZXhXagJp1KmEoUgA2
	 w/Tdwrz8SNRVQ==
Date: Thu, 24 Sep 2026 02:31:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 04/15] cxl: Move decoder declarations to shared
 header
Message-ID: <20260924023133.5cd3f051@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-5-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-5-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:13 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Move the common decoder declarations to include/cxl/cxl.h for use by
> shared decoder settings. Preserve their layout and documentation.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
