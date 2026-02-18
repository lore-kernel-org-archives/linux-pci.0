Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B5315D48;
	Wed, 18 Feb 2026 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404178; cv=none; b=mFRUT4rI4O7WOtH2/dt4vyYUXooc4YwmLICxmQCeLHkbz48OITBqsMBUhy88Ex6CbOYUbBPqh2ydudiOPUX1DMiWnCPv5IdTzYi1DhUzRvTVWzbnt9cAD0Yi3H1xieAY/ESdH/9d02wk02wWoeL4QxrqANVED1a0633m+tKiCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404178; c=relaxed/simple;
	bh=XGDh63kEKb+uKjIWILU6LT8Qvnn1xIjjWINB461hNVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj9SfIVf+hnyAMrSkgeqqMPekNLxQrvURSI+vsUhG3UyPnvNqNp15dYmnC9aYE/uMvcA382/itKC++af8NAtmtk4nmmBNpCYFpkVaa2sBP32+dgQ768fcCmc+swTShCh57OZbVcyQ5FpS1xXC5/rPANMRUx9xpMxU0nq20Isank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxHcqdl9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxHcqdl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38C0C19421;
	Wed, 18 Feb 2026 08:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771404178;
	bh=XGDh63kEKb+uKjIWILU6LT8Qvnn1xIjjWINB461hNVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxHcqdl9ln1Y2jMJ4lGuuOqmFXDWylqb8v0qEDmHt1pjm6V0q7RcVbmONUoXF3RK7
	 Gzi4jXPubRkKEDJdyff2BDfX0VEYY0UgX0NI+BIBfU+I4AKF1yIzYvQNy/7b7yMYt5
	 RJDazQ08ekdXxX0L2ImfKf2iVgxqkeh+fdCOOmCktm+lnYi7Kc88E2txcBxVK7uDS8
	 AoGrh438XVUdYiUAuUXfF6ros+qH7+9K6/yG3ELdf0AHowRtuE1WfKh9JsOcx1pGNZ
	 mLvoLA9NEZ/nJWpCZL7AsIlQ1u8quyTwY8FzYYEtLx64RBVlLP/r9rDl3ujcm91S2B
	 w87TJvubB2h2A==
Date: Wed, 18 Feb 2026 10:42:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: George Abraham P <george.abraham.p@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, giovanni.cabiddu@intel.com,
	Wei Huang <wei.huang2@amd.com>, Jing Liu <jing2.liu@intel.com>,
	Paul Luse <paul.e.luse@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V2 RESEND] PCI/TPH: Skip Root Port completer check for
 RC_END devices
Message-ID: <20260218084254.GA10368@unreal>
References: <20260109052923.1170070-1-george.abraham.p@intel.com>
 <564e872c-ecc0-479c-86c3-68b5d3fda512@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564e872c-ecc0-479c-86c3-68b5d3fda512@intel.com>

On Wed, Feb 18, 2026 at 10:24:28AM +0530, George Abraham P wrote:
> [+cc TPH authors that were missed in the previous mail]
> 
> On 09-Jan-26 10:59 AM, George Abraham P wrote:
> > Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
> > directly integrated into the root complex and do not have an
> > associated Root Port in the traditional PCIe hierarchy. The current
> > TPH implementation incorrectly attempts to find and check a Root Port's
> > TPH completer capability for these devices.
> > 
> > Add a check to skip Root Port completer type verification for RC_END
> > devices, allowing them to use their full TPH requester capability
> > without being limited by a non-existent Root Port's completer support.
> > 
> > For RC_END devices, the root complex itself acts as the TPH completer,
> > and this relationship is handled differently than the standard
> > endpoint-to-Root-Port model.
> > 
> > Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> > Signed-off-by: George Abraham P <george.abraham.p@intel.com>
> > ---
> > v1->v2:
> >   - Added "Fixes:" tag to link the commit hash that introduced the code

I do not have a strong preference; I am fine with adding a Fixes tag or
leaving it out. Up to commit 2961f841b025, pcie_enable_tph() is called
in two drivers: bnxt and mlx5. Which of these devices is the RC_END
device?

Thanks
