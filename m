Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51324679C;
	Thu,  9 Jul 2026 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638018; cv=none; b=Dot8o1f7Mwl0L6YiNiX/2JsufGBbvR7thHD2WB7Kgrqo3YS7k6nwqBoKRnNThIMMsFI4wIoIJm22+Oo2gu/B3kevFfjt73BD/HkTFrVW5L5pJyt85dtv1m6r0LK1hLBbIrmDoxFRKPRPV25fI6EUlCibqBOybKbwqThKViMp1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638018; c=relaxed/simple;
	bh=5XMSlPIPteBXXKphqGMQDa8bWogviL59xDS4PNHtanI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qtB2khp5HR+xxAhwVEd49r9BaAw37LJAYGp4FDDmJXFB9iyJKXegOiy29u8GraRxfy5SZ7oSR2FRVqgFizMxv9vKWcD+w5fSluykxUHxnaWfup1DH3ozUe1I9AOzdTatSgR5LWEDMmG9GhroJ8nLjyDeVOU/TdiSERXC1F45cpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkgsVUKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkgsVUKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D519C1F000E9;
	Thu,  9 Jul 2026 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783638017;
	bh=VQfRKcKr/FiJOmiOPVZNODxFNKFmPKQQB4/ctfiZftM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=mkgsVUKUomDA+fsyMRIhv/GZ8glUbl5N4iyqn+0H7+2RHqrm55VBOElWbF/+7DLFb
	 aSXrucjLHfxUOq5GnlItp2xoKtk5XbP1A9s4XUYPQ6Y616mCycMU61REgXN+jg34W3
	 zO+a106t9tgbIrNLr3RslQ7mJYw2oi40un1FQZW49i6dYn5UnhjNVLkw3U5JhwkCim
	 l+h+r7k3JRsYCA+m1R7m8+Rfnmgl8KI9HpGNMkoynmijSSgWnZCW1Q8FO8r3f7Vxdy
	 jsVTKgYzYGzTS3oQzVspUDVfHnOoZDDHQKt4nxYRLuAbQGm0FXtRC6Y1UdLz0BGE+1
	 hMn3aAazCmtbQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 01:00:09 +0200
Message-Id: <DJUEWLO5YJFE.3BKHFV0J9K3TA@kernel.org>
Subject: Re: [PATCH v4 2/6] rust: pci: add sriov_get_totalvfs() helper
Cc: <acourbot@nvidia.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "David Laight"
 <david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260709150206.1046839-1-zhiw@nvidia.com>
 <20260709150206.1046839-3-zhiw@nvidia.com>
In-Reply-To: <20260709150206.1046839-3-zhiw@nvidia.com>

On Thu Jul 9, 2026 at 5:02 PM CEST, Zhi Wang wrote:
> +    /// Returns the total number of VFs, or [`None`] if SR-IOV is not av=
ailable.
> +    #[inline]
> +    pub fn sriov_get_totalvfs(&self) -> Option<NonZero<u16>> {
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_d=
ev`.
> +        let total_vfs =3D unsafe { bindings::pci_sriov_get_totalvfs(self=
.as_raw()) };
> +
> +        // CAST: The C function returns `unsigned int`, but the value or=
iginates
> +        // from TotalVFs/driver_max_VFs (which are defined as `u16`), so=
 this cast
> +        // cannot truncate.
> +        NonZero::new(total_vfs as u16)
> +    }
>  }
> =20
>  impl<'a> Device<device::Core<'a>> {

It is not a problem yet, but sriov_get_totalvfs() should go into the
Device<Core> impl above.

Once we also have sriov_set_totalvfs() this would otherwise be a potential =
data
race.
