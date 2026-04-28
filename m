Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F83DA5B6;
	Tue, 28 Apr 2026 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370691; cv=none; b=bZhVeP4BzNZ4hZG10mESD5T24DlZt1iFvrZUrvYQrhO+2jYaP2WHKTtzcLYIV0cC97MWUE4zV+iaWEHJGcN/h4cq9TfSFeLjDanaSn9l7vRMCW6DRgT0yKxLvY3PqWWUDPAEJmLSMmJT8Pn0OESpO43nbvH97zVkxQZrzgWybqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370691; c=relaxed/simple;
	bh=THDA4pSnz8O0I8vbRxRJhS+Zowg7suy5Oc816KLBmBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=el05fRpq5NDG2Fy+4RlxWi4PpsYlkpMOODqqmdKvXcB9FJb5U09hYagjIBbp/5vaj2BaYI/risDCa0u1F1eMeU3EYk5B3BFWp1T8cjP8HTUH9c+Mdu3z2EsMTnhc9Su0iF0L+atiYMv8dU2G0humRggdeAFRKB1Mu0z8p1DeTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW32II6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW32II6V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7495C2BCAF;
	Tue, 28 Apr 2026 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777370691;
	bh=THDA4pSnz8O0I8vbRxRJhS+Zowg7suy5Oc816KLBmBQ=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=CW32II6Vi5epjGbH85TrnoRsJam4VJ57mGOa8wDqbkmv1awiASfTD6wpYZ5Xgo7gt
	 cveKQQkEkfPH6nqNJEpBGD3g+Xnw3q4COpis2etqpyJYseDnU2crRhK4BJUB6izqT/
	 BBGFZyvDciDPMPrGIRRmf/jR+HyOo8a1aePha945K9ehKl7CF2tXAMe48rJbJRd6vI
	 AOh/9OwF+UjCPr9FFE4UHOd2DyvzX8ENL/aZeDmhpQWHfPJbe8/01pckTaAR3t87cB
	 U+DRN5WryXLuj+jE4XBHoNLE7CFUPXylmoECZcniahdwBsDXTMDqij3eepjht1fZGQ
	 QitOdXqeyWx5Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:04:44 +0200
Message-Id: <DI4PBO6KS860.1699VQUG68OI0@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Cc: <m.wilczynski@samsung.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <afB-p7vhyVYlcTn6@monoceros>
In-Reply-To: <afB-p7vhyVYlcTn6@monoceros>

On Tue Apr 28, 2026 at 11:37 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> I didn't try to understand what you do here, but there is nothing
> scheduled so far for the pwm_th1520 driver in my tree, so

Compressed to one sentence, it is driver core plumbing to allow bus device
private data (and registration data) to represent their lifetime being tied=
 to
the device / driver lifecycle with native Rust lifetimes.

Drivers can take advantage of this subsequently; for reference see the nova=
-core
changes at the end of this series.

> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
>
> for patches #12 and #19 touching this driver for merging through (I
> guess) the rust tree.

Thanks -- as mentioned, it is driver core plumbing, so eventually I'll take=
 it
through the driver core tree.

- Danilo
