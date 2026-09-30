Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DE64CCDDF
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766971; cv=none; b=MTacVkXd+UH+8TUXFo/1wQ0tQe9qr5K323q5nHLwdyq6gPt9TV1mG3f+jIw7Xj6E7NHLNtlDhmygX2+fWHOivzO7EUgFxEIN9hrbJPHeQhTDhz3uZSN+8AhaPsEGeb+/C49iy4RoeljcbJp3Pr9LI9z1eIs3ebP6F+1t8O0m6fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766971; c=relaxed/simple;
	bh=ZsjyXoTLEOggldzf9Iy0psOGxgbnbPtVAlO5pYMWG9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpZMCHIpfZG6bloJ3iKFqBWNZbAvtXTru5IiK1sFXSKAD8xZRsKOtt1caOMAdjl48fLZ6jQtWVaTj98OWsA7/SmvwxgghbFZ54MlUy9xzfFtwtVli0Mc93VSKQljLLTbRiyK3XNyvYb0oabhp0o1Ti7citpXrYFe1W1OlWmvGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GOPKu7Rt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GOPKu7Rt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD41497;
	Wed, 30 Sep 2026 04:16:05 -0700 (PDT)
Received: from [10.57.9.178] (unknown [10.57.9.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B253F86F;
	Wed, 30 Sep 2026 04:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790766968; bh=ZsjyXoTLEOggldzf9Iy0psOGxgbnbPtVAlO5pYMWG9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GOPKu7RtkypA4/arJKEc/r9+1xM/rmVS9g53WT5+98MrGTptyuZqA676/gx5xA/bo
	 DD9ApatuAcrdcH4F95uMO35UI/6VFKp8znRMOpdnhsQ8FinfHzg755WSirl5vyh1yY
	 +dZpeF9b4a4hE6FUcJrGaxyGVy8v1ht8oG5KxjYg=
Message-ID: <9c9402e6-ac2f-49fa-a4b5-88122b7e618e@arm.com>
Date: Wed, 30 Sep 2026 12:16:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coco/tsm: Update maintainership
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, ankita@nvidia.com,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Cedric Xing <cedric.xing@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Eric Biggers <ebiggers@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Kai Huang <kai.huang@intel.com>,
 Kees Cook <kees@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Lukas Wunner <lukas@wunner.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
 Fang Peter <peter.fang@intel.com>, Petr Pavlu <petr.pavlu@suse.com>,
 rick.p.edgecombe@intel.com, Samuel Ortiz <sameo@rivosinc.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Saravana Kannan <saravanak@google.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Steven Price <steven.price@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Will Deacon <will@kernel.org>, yilun.xu@intel.com,
 Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <0-v1-52697321555d+14e66-tsm_maintainer_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 00:26, Jason Gunthorpe wrote:
> With Dan's passing Aneesh and Jason have volunteered to take this on, with
> the support of their employers.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   CREDITS     | 9 +++++++++
>   MAINTAINERS | 3 ++-
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> I've now spoken to all the main companies contributing here and asked for
> volunteers. This is what I could confirm at this point. I'll be at LPC also
> for any further discussion. Regards
> 
> diff --git a/CREDITS b/CREDITS
> index a0bd941ca5dd26..7749f1e477ab43 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -4414,6 +4414,15 @@ W: ftp://ftp.uk.linux.org/pub/linux/people/willy/
>   D: Linux/PARISC hacker.  Filesystem hacker.  Random other hacking.  Custom
>   D: PPC port hacking.
>   
> +N: Dan Williams
> +D: Technical Advisory Board member
> +D: Asynchronous Transfers/Transforms (IOAT) API, Compute Express Link (CXL),
> +D: Device Direct Access (DAX), Filesystem Direct Access (DAX),
> +D: Intel I/OAT DMA driver, libnvdimm BTT: block translation table,
> +D: libnvdimm PMEM: persistent memory driver,
> +D: libnvdimm: non-volatile memory device subsystem,
> +D: Trusted Execution Environment Security Manager (TSM)
> +
>   N: G\"unter Windau
>   E: gunter@mbfys.kun.nl
>   D: Some bug fixes in the polling printer driver (lp.c)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72294ddfa5b757..729ab465af96a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27788,7 +27788,8 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/trigger-source/*
>   
>   TRUSTED EXECUTION ENVIRONMENT SECURITY MANAGER (TSM)
> -M:	Dan Williams <djbw@kernel.org>
> +M:	Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> +M:	Jason Gunthorpe <jgg@nvidia.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e

FWIW:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thank you for stepping in !

Suzuki
