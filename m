Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737325B09D;
	Tue, 22 Sep 2026 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041430; cv=none; b=lIKmx99ubGSl436hiQJRWIbMUzxfxmJ+6oaMAALI0VskdnPfYEJuuJU71W0SzpH6m3EORWJVyNsULTPFZ+H1KVc2cFcBGjtMsTwqMfNu5gxieWTc90xqnKaS1nYmVeeQ1iVK5Vej9W9qoTXTy0x7W/1ls6govthO/yMcllOvkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041430; c=relaxed/simple;
	bh=85Irrw/6ITJdM9jK3Jei8UXGHQGiPCBPYfuqxqIj434=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xp8LIc4oKbAQY0vUZ++SbgjIL9OjlS9SAzp1a+zsLN8ZEJEkudo1ziEO1wl7OxGmh96ZROGINJ7ImzLWBE47tuNrbxjPYRKrkIkU4M3+XjRf58+7vmaau2N6C1Ywn4nkGUXEejodnUEQ0GfQKcbK32/eW73RmFQP6LKZPM4AxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUrrUo2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUrrUo2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABB81F000FF;
	Tue, 22 Sep 2026 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790041429;
	bh=UtV4KTLxwuDmHdF0FWGFMdJtpQqeq4ANSo2rE8OSC3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EUrrUo2cChS02DweDNqOl9Sx7mzyGYQwBvRFFVxHQreeYHgvoKW/XO8gzCItOSVdu
	 ZE6aVJrCY4deRHf76GCdH6U/KBnp3PYlmjFH3WIiNeh9AIp9U2cNAJ1fdIvQWEbbJt
	 YxoMV4UZd/6Mrd1Gm3qpCxZFSqXXiufbwbWnnsBPfelVTy1hRPioKmNjGuEdn1Zmef
	 vVRlUrOMRlt4ZCY9Ai1kbYXwZ/O7mhCpyqV8RqkZ2bJH4vukHDNMySUb0fLtxhmSa0
	 yhwsca2vin8q2kq1bkMFCdIos+W2aYwR9J1rpdD2M2OI65pJZ2+50Xyt7OBxaU8VKx
	 dobqtVa47YAhg==
Date: Tue, 22 Sep 2026 02:43:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 03/27] cxl: Move component register defines to
 uapi/cxl/cxl_regs.h
Message-ID: <20260922024341.7aecc867@jic23-hlaptop>
In-Reply-To: <20260916183540.3813685-4-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-4-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:16 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> The CXL component and HDM decoder register layout is spec-defined and is
> needed by a userspace consumer that cannot include the private
> drivers/cxl/cxl.h
> 
> The vfio-cxl selftest
> (tools/testing/selftests/vfio/vfio_cxl_type2_test.c) builds against
> installed uapi headers only. Move those defines to a new uapi header, the
> way PCI register offsets live in uapi pci_regs.h, and include it from
> drivers/cxl/cxl.h so existing in-kernel users are unchanged.
> 
> No functional change; the GENMASK and BIT forms are written as plain
> values as a uapi header requirement.

I thought we'd fixed that these days...  And indeed we have
see include/uapi/linux/bits.h for __GENMASK()
and include/uapi/linux/const.h for _BITUL()

Both are in use in pci_regs.h for instance.

Jonathan
