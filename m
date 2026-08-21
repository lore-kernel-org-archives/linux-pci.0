Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB7746C830;
	Fri, 21 Aug 2026 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305828; cv=none; b=utmvIVaN6jvVuIhcO+KP6oyf/6Krco+kSRSNzIJg9d5b1aYtqkxp23t0oHk9N94qiEdg/ynEFc5lzTSGij0pTg60un/0OCT40j87ZG4rhWqxpslwOelWp7yKf2dU6ZNTq+sn9PFjn6ZT0JUKNfJA146gIpU9K88IO4RzFyg1qK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305828; c=relaxed/simple;
	bh=SR4DWJiqGghBFTzS3KA9iUFdXu7xAoAxfyqQ3MDAWcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lHf3QbR275V2G9xvq2VydOUarRVqC8RZTKHMlLie1Q7bdQh5HeDNU/vlz6iO9lufEm9r3wqYxqhiMsDQxbGUQHLx6sC2SlxqlIvDy/PalYYcVtkBneFIug0TQzbHuQDEyDCn8lLLFWgxfSxCBEy+1AnD6uMSgrl5nluWAxEl3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvgItWec; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvgItWec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787305818; x=1818841818;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SR4DWJiqGghBFTzS3KA9iUFdXu7xAoAxfyqQ3MDAWcc=;
  b=GvgItWec9OtdZMnEyoZ7lBsWLdTfiTAaRt5nFgJ8VINyufRZDSVJALTV
   y9zLM8GpoLNscUD8FqH5b9cksVGMVrHXEDVQM2sZqRpTDXPyt7iQi3wUH
   RkzbPVlHShEqLFMuJjxYpzsQ+SqCq6o8MAkihM/L/p5+eMFzkB+c7cD2N
   EicBTM4bgEDSVpwy+RMSkEUrp5HeSD+m4Q/HmDOAhkzTtXtlZ79iRwEeV
   4G+m+nedccZiduaP8hpEtvmbC3WOqGChDe3qJTRzy0nonuc376Z8tcNjL
   J0NXcA7PmLKI59Hic6z6GLbME3zER1v9LtfLst8rf5fKm8rUN3nsgmBGk
   Q==;
X-CSE-ConnectionGUID: U8CYjOXgSnyYlYUcwpMgeg==
X-CSE-MsgGUID: kpTT7kFyR5+3XLFdUDlEKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="105388735"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="105388735"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 02:50:12 -0700
X-CSE-ConnectionGUID: 1PROpwKxT+SxKbHirQrlqA==
X-CSE-MsgGUID: oIdSvDRGRhSh7sfO/n/mKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="263643428"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.165])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 02:50:09 -0700
Message-ID: <4bd61f0e5667100e9773e06c8cefe25a9f9c00ad.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable not supported reset methods on DG1 0x4905
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Joonas Lahtinen	
 <joonas.lahtinen@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
  Krzysztof Karas <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, linux-kernel@vger.kernel.org
Date: Fri, 21 Aug 2026 11:50:07 +0200
In-Reply-To: <aogQ4fNchLVm9Pbg@zenone.zhora.eu>
References: <20260819102509.1662504-2-janusz.krzysztofik@linux.intel.com>
	 <aogQ4fNchLVm9Pbg@zenone.zhora.eu>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andi,

On Fri, 2026-08-21 at 10:51 +0200, Andi Shyti wrote:
> Hi Janusz,
>=20
> On Wed, Aug 19, 2026 at 12:24:53PM +0200, Janusz Krzysztofik wrote:
> > DRM CI consequently reports failing device reset attempts on Intel DG1
>=20
> do you mean "consistently reports"?

Yeah, consistently is the right word.

@Bjorn: should I submit v2, or can you handle that correction?

Thanks,
Janusz

>=20
> > discrete graphics adapters.  Manual reproduction attempts allowed to
> > narrow down the scope of that problem to a specific revision of that
> > hardware, SKU 8086:4905.  It has been confirmed that both reset methods
> > claimed by the device, i.e., flr and bus, suffer from that issue.
> >=20
> > Since consecutively failing device resets may lead to system hangs,
> > disable both useless reset methods.  A respective CI test will then be
> > skipped instead of aborting whole CI jobs.
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/118=
14
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
>=20
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
>=20
> Thanks,
> Andi
