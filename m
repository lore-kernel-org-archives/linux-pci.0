Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745847DD46;
	Tue,  3 Mar 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549582; cv=none; b=PjI66bowKpron5YBf44oe4CC2rwNLR0YCG0kfEilbKlEcFXOhJGWcOUxoiNKJ7T832x29smH26/qBHheFbgSyTxymCxbJ0ji8Vm9WVEjMM4dbWDqoWAuRk47brFOEVGGOdth6ZhIrIx80eTqL4/V2EIPmupjGEy8Rrch0OO3gJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549582; c=relaxed/simple;
	bh=MrTQbJL8WtAysTJfR0EUPZ1xAb54MTWR1q0gK9yByRA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fM8R87qrK94Rll2ieonIyehTogJdHln7t1AW+URe4U1m7JZzf0bsZSGdjXo48gyo9auet/QbGBqWPmCBgaQeKYirtE6yGQHbzl9PdayZGvH1alxudoAEPZSYX2tr0KsTlLGlxgrMSTqQ1iR/OxCZ1EdsLSvWZ7WPGl/mr1OwXrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fQJgF2L04zJ46Bs;
	Tue,  3 Mar 2026 22:52:25 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 877444056E;
	Tue,  3 Mar 2026 22:52:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Mar
 2026 14:52:57 +0000
Date: Tue, 3 Mar 2026 14:52:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <lukas@wunner.de>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
	<benno.lossin@proton.me>, <boqun.feng@gmail.com>, <a.hindborg@kernel.org>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>,
	<ojeda@kernel.org>, <wilfred.mallawa@wdc.com>, <aliceryhl@google.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v3 20/27] crypto: sha: Load early in boot
Message-ID: <20260303145256.00006306@huawei.com>
In-Reply-To: <20260211032935.2705841-21-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
	<20260211032935.2705841-21-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 11 Feb 2026 13:29:27 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Work is ongoing to support PCIe device attestation and authentication.
> As part of this probing a PCIe device will require generating hashes via
> the SPDM protocol to the kernel.
> 
> Linux should verify the device before enabling the device, which means we
> need the crypto functions to be ready before arch initilisation (where PCIe
> init happens). Move the crypto init to postcore to
> ensure it's loaded before PCIe devices.
> 
> This allows us to verify the certificate chain provided by a PCIe device
> via SPDM before we enable it.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
