Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A43E515983;
	Wed, 30 Sep 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789226; cv=none; b=KZ1cIAykIESEnZDK+ZkQir2q1kbMYF3xBCenhj07cii3gzYvbXQ4c6pYgud/likAQpfsHjK2AS6Zd0SyiQyNb50gNSF7BYz5B/SIg6pK6zaAcCBWLcDoPpgIo0q5oLnd6bA31Z8n6rvi1pdGoCsXFFVMmof2k/R3sb/Ows0XFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789226; c=relaxed/simple;
	bh=tF6H2KL7XGyCCwH6VN/AUmtLrWKtn1xQFlxz6gsBm5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTXGGHEC8MCM7GqQBjC/3cS8XMC2XEBN6ANjWKCkfCO71kbgiYDThaCNfYL7vAQR3SAznQHkutvq5BLfsOdJ0Io1e/gqLBplzJM9j7FnGqH4xiW9VGmwCCaUQSm3AGpB9fNkXpVi0PCGuwuT3NJJT8AjmrjMINW+nq/DH1UsAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmzW6fAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmzW6fAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14AC1F00898;
	Wed, 30 Sep 2026 17:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789225;
	bh=ehvQnoRpqkJ63F5T57nRH09Oj5QF9HmV41dwKQgW0aQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hmzW6fAlvYD+Seqv8iViLUln91rQa/KEvv6y5V8OQU8t+2+oWFdttTd43VlMNIKqb
	 MhDHJoPdK4ho94BiySmQ8nrqjBhTBCrmbJiXtzUjAJpVNAgaGRA/NYI899QtAfA7hC
	 jBcfVO79cAosSWYVlI/lcgRnBSe4FrqS3F/rQy5CRY5eHfexEuXknAkkImXQaQX24E
	 lbR/3gBn48MusQu2a1U+3brP4zQOze8wB5AIaP8fMRR0JXhwJCP6y4hqmirqz7IpGd
	 /oO99qvAg4ZDHJynBfgNb1k6AJfbXsbepDNdWE4Xwdy7M3BYSQWmouXRKl0/J6/SnX
	 yeqSgxF7yqohg==
Date: Wed, 30 Sep 2026 18:27:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, "Aneesh Kumar K.V (Arm)"
 <aneesh.kumar@kernel.org>, ankita@nvidia.com, Arnd Bergmann
 <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, "Borislav Petkov
 (AMD)" <bp@alien8.de>, Cedric Xing <cedric.xing@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Eric Biggers <ebiggers@kernel.org>, Jani Nikula
 <jani.nikula@intel.com>, Jiri Pirko <jiri@resnulli.us>, Kai Huang
 <kai.huang@intel.com>, Kees Cook <kees@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Lukas Wunner
 <lukas@wunner.de>, Luis Chamberlain <mcgrof@kernel.org>, Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>, "Fontenot, Nathan"
 <Nathan.Fontenot@amd.com>, Fang Peter <peter.fang@intel.com>, Petr Pavlu
 <petr.pavlu@suse.com>, rick.p.edgecombe@intel.com, Samuel Ortiz
 <sameo@rivosinc.com>, Sami Tolvanen <samitolvanen@google.com>, Saravana
 Kannan <saravanak@google.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, Will Deacon <will@kernel.org>,
 yilun.xu@intel.com, Kevin Tian <kevin.tian@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>
Subject: Re: [PATCH] coco/tsm: Update maintainership
Message-ID: <20260930182700.5414d840@jic23-hlaptop>
In-Reply-To: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 20:26:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> With Dan's passing Aneesh and Jason have volunteered to take this on, with
> the support of their employers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
