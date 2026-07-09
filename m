Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4544999E;
	Thu,  9 Jul 2026 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637929; cv=none; b=JzUcstnV+ql/guO3N96/B81eidWVen/G87VNMXthSNi+6UMhE/jOaf0E3lhcjSuBaS1Ulh417R68yve9fpOY4IQANpl3gx6lI7Tcxb3WFzbfh7HOK78EGjw/LbUzTPaS9BNJVL0G2bluUHeK6hk0xVj1O3mKCvseAY+PVpduyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637929; c=relaxed/simple;
	bh=9e1R0pFtu0H3jDACACFpW/nxWroj0bZ7nDGnW8rsvnE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=si8XTn/Bt9DKUuhUKbRT6ir/HIwVzr3b+mcuQvCboHkDRZT62tNezO5iN6zidMfxhWc2nnz5CLd1a7ELsjHyT+BktqLzt944hxohqQWd0m8TWqfESwEWBezxW0/xvCjHyjWOYBIIvipW4RamuLu5PoenCYSp4AJb3Urst0RWABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH+ESDPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH+ESDPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7851F000E9;
	Thu,  9 Jul 2026 22:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637928;
	bh=9e1R0pFtu0H3jDACACFpW/nxWroj0bZ7nDGnW8rsvnE=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=aH+ESDPNV+5DxWdCMPm8DRgaglYH7KfN4az0cldTgf9JUifU9i2687B6kM86NQ5/P
	 Jps1lXeMpJZYFJ2hzFvLpPtdc+ywAspB9rkNOeLAAkPfLMcobfodRBshcIcWJyw/eb
	 umPTnQb9g7fyTIb2UjhPebDiRQ7LHhB0EBkR/TLmZl5siaRSOOQkwLuSVQuNT8I50s
	 xnlJDUA/dLITh6GPyzlAWcgYopjafipL1AV0CQnyaXBBllKFGQRfIVwkWgsiU7zuo9
	 sg4BWsEmVzGBD46CwblHTVwRWIHAxnDMPsbY+RkVkE2ACVhmEdqa/t4L/YMr5M8oZW
	 yFMOeJqoL63Lg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 00:58:41 +0200
Message-Id: <DJUEVH5W3FVL.7AAY8VTL9IUD@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/6] PCI/IOV: Return unsigned int from
 pci_sriov_get_totalvfs()
Cc: "Zhi Wang" <zhiw@nvidia.com>, <acourbot@nvidia.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>, <apopple@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "David Laight" <david.laight.linux@gmail.com>,
 <linux-pci@vger.kernel.org>
To: "Bjorn Helgaas" <helgaas@kernel.org>
References: <20260709150206.1046839-2-zhiw@nvidia.com>
 <20260709224623.GA914514@bhelgaas>
In-Reply-To: <20260709224623.GA914514@bhelgaas>

On Fri Jul 10, 2026 at 12:46 AM CEST, Bjorn Helgaas wrote:
> Feel free to merge via another tree, or let me know if you want me to
> take just this patch via PCI.

Thanks, will take it through the drm-rust tree then.
