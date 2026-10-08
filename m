Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786C2F3C19;
	Thu,  8 Oct 2026 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486989; cv=none; b=dzC5Ubzi2lq9/3dpQ32EWcIIigxlXqFBIzeC8I0POiw3bVXAAp+8KwXSzr4yUaPuYT3355rdtxEXyLjIfyv74VOy6TAQa99ANDrhOFVwHAM3+Vq3w2opjoTGjwMLJwuNYynyh8vPV2CAHVzxV3Sblc7TD33B29ibiYnt8t+7ptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486989; c=relaxed/simple;
	bh=wolTIL0bHEKwihQ5BVKU/vMTJuw4z4vkAlWbVnPYdnU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mNpFxTrj72J4/fjq7SpSE2F0LHuivVMSO629nn5hKa9hkxrBzzqYeJscz4xWDK72H6yK7HPxMnvonpBvGwGNh38EjZuPThTPAu2oDT2EoRLxKMere+xHYzyeh+sipIz7HAsoRGbjpaBCjhg+1Ofk6w7BNLWzACzotok5hwY/EZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLJWRI/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLJWRI/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5111F000FF;
	Thu,  8 Oct 2026 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486988;
	bh=V/dD73O0qYWnuhR+33XqIFxZxWXjPtj5XHflOH4Zjvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GLJWRI/6MT72mRCXqxt/3cuE0brl79WCWUEzo0FwChIKhsN96PySr9Ey+mZ9pZLtQ
	 9fVNqZbjFcrzHWuyAQgl1Y59jYdrE0/YnYIbil307iewNozuKZ5GTTZaQ19TyBtRBZ
	 J/ikBLw2NGDZeZsd6diy0DK8ULj/iTD59ydFnwVtcywwdZ7S2iBdJxplE9rZ/6lohE
	 1vJbBv9LCOoxbpieBX3634jnTmHE0X5CmfBzkgNtaPU5wr/RG+yKXpg9IhgtcIFjhK
	 jcMyRvknJc8NrDg+avdGkpHjOetHFAtfS+x8ui/ufXPwP0G9i+Sy7DZNAAMw5ZWWLo
	 qPV1SXfJiLW0Q==
Date: Thu, 8 Oct 2026 14:16:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	amd-gfx list <amd-gfx@lists.freedesktop.org>,
	Christian Koenig <christian.koenig@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: GPU initialization failure with kernel 7.3
Message-ID: <20261008191626.GA918896@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW53m_ThtUQ@mail.gmail.com>

On Mon, Oct 05, 2026 at 04:14:45PM -0400, Alex Deucher wrote:
> Hi Lukas,
> 
> The following commit causes GPUs to fail to initialize on a number of
> our servers:
> eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> The change reverts cleanly and the GPUs initialize fine with it
> reverted.  I've filed a kernel bug to track this:
> https://bugzilla.kernel.org/show_bug.cgi?id=222095
> Happy to test patches, etc.

#regzbot introduced: eddba19b8b5f
