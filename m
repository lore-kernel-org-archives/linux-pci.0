Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6A2F7EEC;
	Mon, 25 May 2026 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723327; cv=none; b=QT2Cxol17lD4YuIccwOpEVEpF4UTrzVWMz7v7Qkkdpe6FV04TclW55AwP7++m5iBcXigY4wS4w/P515jo9vCoSw1+XEGDmgDsaGS1ijLRb7H0Lt/CLAHl7oRyoeszZvHgZI9upFlSBCwT7WAe88va3HxXXtw/EHvrKFFtEDXo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723327; c=relaxed/simple;
	bh=kAWwXurdh8RCSR0nMQKqMeVKRqx6CMQmUhD5HGww6Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQg5cmFfzqY5XlPBiICww0UYBHaYa/G2K27SmJM5dGYrpROmcmRc3cEd6a587BnNr0Dkuc0rSYoV4m3eKcMfL7LHHjjGTLJ8vBkoYJfwraWHZdR1etDxW7FGBZO+GsPzrerAGvU2IKsUITxNeixfPeLUsn+m6xmtbMha5mTL/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9G55K0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9G55K0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D641F000E9;
	Mon, 25 May 2026 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723323;
	bh=4RU4mhDc8qVs92H5+4lAVgCVBlE9tWSHjhCyliyrIDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m9G55K0gx7YOL4cj4gOb2FGACR+7Bfe15lfJS/RfnYvFNkyHit4NSk1tP58/sP/tB
	 I6BOAYqUijW0t3roijovmeXpwe+RYWH4i0wH4oy+ac1ZmzLdvi66K+wjlpUQYpNELv
	 1lKvOPvFAcdMFR7xUTT8lv/k3BEsHVZjwLIy4VZsl7ih4LD+H4fnh6ZTddSBJ7KQJw
	 tzMDh6byuS6tJ5F0VQVYeWFeuc/ElBGk2PStD2NUvnfeS5t3Zrq8qkwLCKvMmrrO5Z
	 fErvA3e6nOrwsEakVqIgbbUUd47FrMMe1YW6ktTI03sm1dOOu/0NjeGsKqitzfLIP0
	 aKLB5Pny4Xk8Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Leon Romanovsky <leonro@nvidia.com>,  Lukas Wunner
 <lukas@wunner.de>,  Mike Rapoport <rppt@kernel.org>,  Parav Pandit
 <parav@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pranjal
 Shrivastava <praan@google.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Saeed Mahameed <saeedm@nvidia.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,  Vipin
 Sharma <vipinsh@google.com>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 04/12] PCI: liveupdate: Document driver binding
 responsibilities
In-Reply-To: <20260522202410.3104264-5-dmatlack@google.com> (David Matlack's
	message of "Fri, 22 May 2026 20:24:02 +0000")
References: <20260522202410.3104264-1-dmatlack@google.com>
	<20260522202410.3104264-5-dmatlack@google.com>
Date: Mon, 25 May 2026 17:35:16 +0200
Message-ID: <2vxzbje37b9n.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 22 2026, David Matlack wrote:

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.

Nit: Should you also note this in the documentation that this can change
in the future?

>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 96c43b84532c..4f2ec6ffdd16 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -70,6 +70,22 @@
>   * preserved. These may be relaxed in the future:
>   *
>   *  * The device cannot be a Virtual Function (VF).
> + *
> + * Driver Binding
> + * ==============
> + *
> + * In the outgoing kernel, it is the driver's responsibility to ensure that it
> + * does not release a device between pci_liveupdate_preserve() and
> + * pci_liveupdate_unpreserve().
> + *
> + * In the incoming kernel, it is the driver's responsibility to ensure that it
> + * does not release a preserved device between probe() and
> + * pci_liveupdate_finish().
> + *
> + * It is the user's responsibility to ensure that incoming preserved devices are
> + * bound to the correct driver. i.e. The PCI core does not protect against a
> + * device getting preserved by driver A in the outgoing kernel and then getting
> + * bound to driver B in the incoming kernel.
>   */
>  
>  #define pr_fmt(fmt) "PCI: liveupdate: " fmt

-- 
Regards,
Pratyush Yadav
