Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FED37F730;
	Thu,  9 Apr 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720942; cv=none; b=t2Dmtsrkk00gMJPl9/eXjFaPzRFkVmMwnayXGFctujeAxP0y5Z1X0NeDJ2tITw0f8Q+u74IKN5+nuK9LOj1Q8LrP/peCuAH48hR1Sfo4N5VD3GAX9gTYFEJ0TR1ZypDrtAOLKS6TfbjwG/KhJEAbwZCfUCRR2WnEAxYJb4aGNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720942; c=relaxed/simple;
	bh=GgfjMdAGkfOUH8Y4ydekfBDu776jt9O6ZctxIDezV8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q7xKQZKAhK3Gv/q7FNMkfUvLVhJk5K/jRGdM0SmTlsMz+MaMu7haiE0sgD3Ib3dRUtqY80ZpYXuqpaVHmP9QY6RSugehTTLH5PBHY3gUsKI2+Sz4nxHXaJJFYaIyMlIbQbAbZ0U6rEgbNplRhp3kfHCBp64hRsQsmzuLajjzMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQQD66CX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQQD66CX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30581C4CEF7;
	Thu,  9 Apr 2026 07:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775720942;
	bh=GgfjMdAGkfOUH8Y4ydekfBDu776jt9O6ZctxIDezV8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FQQD66CXdyuN+sZrYZWUCA6kHKCQzurIPDXtmZFoPkOByXflcsoJ01Mj0CyRHBYPs
	 nwyo/ltUgwPhqfUpMN/8pkQYcAdH8/9FLvn9iLdMDgpPS70GLtDs30CBN+A6glc//4
	 PYY+q8qkC/GIaFq81JWte+UVq/yudBpNBl1gzmmmNzCl72aEZaTvcmZaF4Xx+Ckzgq
	 SFGgjJKPcoB2brY/ItuV9Ps6EcX2MKFOILmbvyng/h1FCFEK5pUKoa9ddggkjwI9cX
	 f0MGRaYI/kzeyky0Z8Ia85+8VFbC52uc+q9yWiwoGoWnuWuZmksC6tdQjppudVdPaS
	 IHKavxr7Oj9TA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	aik@amd.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
In-Reply-To: <20260313133658.GD1586734@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
 <yq5a4imuanoa.fsf@kernel.org> <abPlt8oNUOqGvbA3@yilunxu-OptiPlex-7050>
 <20260313133658.GD1586734@nvidia.com>
Date: Thu, 09 Apr 2026 13:18:53 +0530
Message-ID: <yq5afr548tga.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Mar 13, 2026 at 06:23:51PM +0800, Xu Yilun wrote:
>
>> My understanding is, it is the obfuscated host start pfn of this range,
>> if this range has offset to the BAR start, this field should also be
>> offsetted.
>
> The OS must get an idea of the bar layout out of the report, so there
> have to be restrictions on how it is formed otherwise it is
> unparsible. IMHO the PCI spec created this very general mechanism but
> the CPU CC specs need to constrain it to be usable by an OS.
>

ARM CCA spec mention these restrictions in section

A9.6.2 Realm validation of device memory mappings

-aneesh
