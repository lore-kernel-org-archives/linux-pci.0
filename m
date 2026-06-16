Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625C4502F
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631275; cv=none; b=raHIhJOpKMG3VqT+dXaECFriHsxTJ4EMoSjNVDynIS4LK+k1/axpLjizESwj6Z9D628rs38wCZtmYCqz13nFH6HimAeMaDiEHjjmqmd+YZIFa37ukp1cGDET5lMsOZ7xlF8KjgJZToplyCUG8ANu2j+ExmliznSneQJReTPkNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631275; c=relaxed/simple;
	bh=hYMsCM6MsLNsadLZJMLyNz8OZ6JWnCIkL6qZbfi8A5g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dELy25Y1bdx5DPPR5kKNOFbydwWRLLZfbTSBC6FvLKS8lzFSV01FH5wnFb8MTk+7ECwClazLwY77MyGRZcke1gukOjNNM3DHUKvFhfNiPncN/je2VmGWQKZdQO9WmbRHuJKqwcQwP0ZKSZ8WQ4i0W9nECuOhZ0DYASn82C8F9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlG7xKHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlG7xKHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49E01F00A3A;
	Tue, 16 Jun 2026 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781631273;
	bh=LCWDQZIZGap6nQfAuNOlbgQoRHiTvNOD0M6LQaSMPRQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dlG7xKHMfYbnWHkRs/vt5gdxRUbdU5rhm46cHCGuP32f/Wg2ued5OzTFrEEyW6oUF
	 8Q6+hW9s4XLlIGJ8x1Tl4XrWca4CPBcCUyFMXBl8GO1WFY/X2cQNJdL2XEVwbCi5/R
	 LgYSfrK55q8nJcLNcxH0dq02WdHP1JSBaJoTC9Et/i40N0ambM7voQY5CaPSSLxhzi
	 ww8EI/KpEJUvedT+wFV2qBkFMYCIHVYAM3rj/w8rDQMNPR3ODbHbqwbgqpwielUF5i
	 865mdWDtivalAITEOa+rwUCcl/xH4OwC5ivNBWTuUWfGsnN/17Z8S5fYPM7EadaEr1
	 pdmZ4/ILdr1zg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id D744AF40082;
	Tue, 16 Jun 2026 13:34:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 16 Jun 2026 13:34:32 -0400
X-ME-Sender: <xms:KIkxargcq1-eOz0iu7VK-yQ1MkhGwiZMM7Ko9qC1wamLJLC9SNP43w>
    <xme:KIkxaskdxGMngd-hasE64VoS3WDP29v1oGd-lTTkL_acMo4KmL2HMx6_-2FII7hBf
    ezS8YnKh182gIdl6xv4tLL5MdozK3V3E41N9ViUBj4YnayaVUEvNQ>
X-ME-Received: <xmr:KIkxaoPEb7FYdfzoQ0do0tJC8PhL_KXjOuc11EqLm7W0YQJGWjTjNPyhoKH1gIs6BTP3QGYU1IbU9_eIT6wTHdOQt-nvwwzSlqc>
X-ME-Proxy-Cause: dmFkZTEZjNKkieDC5FUSjm8JTujve4vXzyj5XF9lUPCu95PoeIO7Z3QF61U57lMx4k7gk3
    r8n4HzqfjWRTZxAzycXejqSIkw8J09WeBk6YUVYVCVzkW0EuUQwVh8UZ+uqdwm7OKWbFx4
    Gzw/llBoZM6RmeJ1yg7YKh3ut6CTpDAm3u+ZrDq3itLchsT+gEQhJJDc2X8iFgUpFT4LiT
    rqvE5keh6M3mGdpBrtXISp8gRtp69lhubyDzYx3E9sG+o659tQNt+oig2xL7Dl/X6VUrD8
    tYlJGGBTMCCJluSXh+de6/vRLMXf6JAOE7iu98kud2i+/fijeA1S7vbvP83Z3A4VieCCHf
    sOHT5VsxhqY858tJta3Kfyu2Tpdam0BRTFYy38u/KTEfIgE65sB98EwSu7vQqO01z3MzoS
    Qd8EkW7Ll9yllaK2hk/odU0MhaiQgbyIIidR70pd5ztf1P0vFUP+Gvm7OHdD5Rb8+xreLj
    9Y4+Epnh7m9vczsPUvHV3Rn5escMp0RUndhFENRS2+waAvR5A0DM/KLpjqJbyVX7xN4Bt4
    VL6dsNqcn9be0t7WUFNOfj/Rr/96Tdh4qUuv2VxYrByXd3iU7BxKHCZhv8X18JlJCBnsEa
    CcjJAj9jkz6clJEgD0IXs0gnEJLIRKbWVYRWOykW8nI+N50Qx2ZuMrfkQ2aQ
X-ME-Proxy: <xmx:KIkxavHuo_wpxAmKsYbAAGuJ7rdEfDpHxOEFckgw4HLHjXMzD-0Hrg>
    <xmx:KIkxamtX2qXOgUoNOzfGwIYn-XEJoxfyabBYYKe7cguD81v6wp3sGw>
    <xmx:KIkxanT669UmRZvdDYKz_Nt88tlj5hvPgjXcM5cPHLb7VsT0rEggvw>
    <xmx:KIkxaoP_1K6NoMIvPoYai2gzURwctLa6ZCRoYYgBCvU9CFxFaYW-fg>
    <xmx:KIkxat6BL4kMTSA7gV3NxaxbG87Q90eBR9QCPvO-3jkBa7q2ZtnEh7rE>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 13:34:32 -0400 (EDT)
Date: Tue, 16 Jun 2026 10:34:31 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Lukas Wunner <lukas@wunner.de>, 
 Dan Williams <djbw@kernel.org>, 
 Ashish Kalra <ashish.kalra@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: Vivaik Balasubrawmanian <vivaik.balasubrawmanian@intel.com>, 
 John Allen <john.allen@amd.com>, 
 Bjorn Helgaas <helgaas@kernel.org>, 
 linux-coco@lists.linux.dev, 
 linux-pci@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Yilun Xu <yilun.xu@linux.intel.com>, 
 Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 Alexey Kardashevskiy <aik@amd.com>
Message-ID: <6a3189272d3ce_9b8551008b@djbw-dev.notmuch>
In-Reply-To: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
References: <7bdfaf14d7e5a466f3f650150c688a60e947a7a9.1781527060.git.lukas@wunner.de>
Subject: Re: [PATCH] PCI/TSM: Resume device to D0 for CMA-SPDM operation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Lukas Wunner wrote:
> Per PCIe r7.0 sec 6.31.3, CMA-SPDM operation in non-D0 states is optional.
> The spec does not define a way to determine if it's supported, so resume
> to D0 unconditionally for the duration of a CMA-SPDM exchange.  Vivaik has
> talked to Windows engineers and they said that Windows does the same.
> 
> Note that for plain DOE operation, it is sufficient for the device to be
> in D3hot and its parents in D0 because config space remains accessible in
> D3hot.  So CMA-SPDM goes beyond the requirements of plain DOE and hence
> resuming to D0 needs to (only) be done in code paths which use DOE
> specifically for CMA-SPDM.
> 
> The pattern used herein for runtime resume is the best practice introduced
> by commit ef8057b07c72 ("PM: runtime: Wrapper macros for ACQUIRE()/
> ACQUIRE_ERR()").
> 
> Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Encryption")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.19+
> Cc: Vivaik Balasubrawmanian <vivaik.balasubrawmanian@intel.com>
> ---
> We're in the merge window for v7.2 and this isn't super urgent,
> so it's targeting v7.3 via tsm.git/next.
> 
> Technically I'd have permission to apply myself,
> but I wouldn't want to without acks from Dan and AMD!
> Thanks for taking a look!

Thanks, Lukas. A few questions:

This says Fixes, but I assume it is based on inspection and not a
report?

There are no upstream usages of pci_tsm_doe_transfer() yet, but the ones
in flight would suffer from the "D0 -> D3hot -> D0 -> D3hot" bounce that
you described to sashiko. I.e. the runtime acquire should be done at a
higher level.

I think the natural place to add PM_RUNTIME_ACQUIRE() that covers all
cases is withing pci_tsm_connect() and pci_tsm_disconnect().

I also think failure to power manage the device in the disconnect path
should not be fatal to performing the rest of the cleanup.
