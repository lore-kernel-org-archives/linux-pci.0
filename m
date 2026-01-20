Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A23D649C;
	Tue, 20 Jan 2026 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768930178; cv=none; b=uYmeQpX1cLKbVUVm04tiQTppI/kOBb8CY1y3f3knSkXmsQHXh9Pl5jfCyI+W25zVt52/iw404BBrUNIVgzpFpvIhq4Saxn/cE7fVDjqJbEHp9zFX9+Ic8zcTwD7xBqiZa8yNTJHSyopchMDdo6wO5VuJ5TmCbK3ylG/tklG7xUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768930178; c=relaxed/simple;
	bh=TqtrdI7XvNtTzZR0mhDe/Of3hTma286poiEWK86JODE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=jdjysSz0jChukQm5H1pvTtzzso2oSZNijvrtEnL41VxdcW9dya011vKtGv76tuti/hIXTY5X5cQXkYBOTAsSrbkptsTpbedoPsPycLxYceJ6UOcbxGLpA2I1sgscuI8cd/OrDDgLQ0q56Pcg2Inl68awM11wdKNI3xnUP8a5K4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZeSp5Nu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZeSp5Nu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45B9C16AAE;
	Tue, 20 Jan 2026 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768930178;
	bh=TqtrdI7XvNtTzZR0mhDe/Of3hTma286poiEWK86JODE=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=eZeSp5NuauuBQ4bJF5+YX+BgPC/ONnEZcpwGrMCIX10T7ae8BZ1B1zHmYGFrkPan2
	 VRaRZfFTCQsVfbBt7sofAzmg1RGQz/lg5LSSsrH55R9QgEnJhLYgRgz+Nmppk2G+eL
	 FY6TzWxIdGF1yS/9lHeo4DXi7RYyMZF45tlBlUQdSCLV2YR0qJpPC9COEos4ef5hcR
	 J21QuUnXqoID7RYDp5UJfWURQCvDXHR+aB14b2i6uodE3TrJmDYmL1g8crAkKESHHh
	 BtWmLHhVldLtw0GsNdYAIPxtXyNvRigS1H/lA2TqpuKLq0VnhCcpadMjYf5YwVz5Ea
	 6752s9QYFCALQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 18:29:31 +0100
Message-Id: <DFTLEU18124W.D0BWYXPJXGHA@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-3-zhiw@nvidia.com> <aW83HV4lVR5MQlDd@google.com>
 <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
 <20260120192654.014ba848.zhiw@nvidia.com>
In-Reply-To: <20260120192654.014ba848.zhiw@nvidia.com>

On Tue Jan 20, 2026 at 6:26 PM CET, Zhi Wang wrote:
> On Tue, 20 Jan 2026 11:12:18 +0100
> "Danilo Krummrich" <dakr@kernel.org> wrote:
> Thanks for the comments and RBs! Agreed. I will adopt this approach in
> v11: using a single series of IoCapable<T> traits and retaining
> IoKnownSize.

Great, thanks!

(Please also remember to fix up the pwm_th1520 driver.)
