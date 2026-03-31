Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646036C5BF;
	Tue, 31 Mar 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982334; cv=none; b=gSr4nDI9hsh7pkl5jzMPd8zZlh6l4x8qXNyL6OrotD6Prck83hP7dcmbM4QK10zY4ilhNfj9xhxZVK/Q4L+ifdnvp6C0jJ4NExDGs69hXuYoVj7/oZFRhvGD7oaFAMIok4GOVBl12inYwVrgwD6Dp1bJ4h0xXuIRjS/mBHyALDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982334; c=relaxed/simple;
	bh=YpAmwgJpCOgUiJ6BaRPYMlRVQEdfChkF5GmyVA8tL+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dlBRJbcaGBnxN6wtWdNjrNeF0N6FylC9usLKGI+v13JmOZgOv7eWPDmK7wkb4A2wbQn7ek6ZMFXs9hNIOdOtXCYE9mrxjQoBhVgHNZi3kp0PYUhEHCSmIkwrofiRq5rG+VuRddHcxQ8RX7gpyp9SBA4FMSvJDeQm+b/4fPMCAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0l3uGdk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0l3uGdk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A9AC19424;
	Tue, 31 Mar 2026 18:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774982334;
	bh=YpAmwgJpCOgUiJ6BaRPYMlRVQEdfChkF5GmyVA8tL+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=p0l3uGdkJ/ytr6FqXLxfV/Pj6zr8KPGFGtgOZuDsTAqavpZCIcoKpCyv+rJVI7Qgl
	 JTP7f1yD0g4jJtjsixlg+xsJK+E9sZDQbjTZ41gDDtZczqdy5l2bIg7NUaWuXaNb1U
	 iT6FbZPwox67AL5nxREXjiTMOWthSy23+MXyiSGGf3tS9lVpNBchFie4HfKfLP2lge
	 Vvq9ZMfQtOsSO4IzGQEuRPjfal5R2NwDCGNMi4TqfFdeDjkluj7KEk9nEPdpLdPew9
	 kYEVZXWzsN9kxsOmmoBZi7oTRp6Cw0ef5XlKhQJfxQiy/yF6lUUOOoPjXPdq5oZqSY
	 w/WFmbk+zvo7A==
Date: Tue, 31 Mar 2026 13:38:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU
 drivers
Message-ID: <20260331183852.GA150014@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=c7CuJmRjW0-KVk013r4pZZ_CsRtApn0rw9py9cTE-K+w@mail.gmail.com>

On Tue, Mar 31, 2026 at 09:01:53AM -0700, David Matlack wrote:
> On Fri, Mar 27, 2026 at 2:17 PM David Matlack <dmatlack@google.com> wrote:
> 
> >  /* AMD Raven platform iGPU */
> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_ats);
> 
> Sashiko found a bug here that would leave ATS enabled on this device:
> 
>   https://sashiko.dev/#/patchset/20260327211649.3816010-1-dmatlack%40google.com?patch=12646

Do you want to update the patch to use DECLARE_PCI_FIXUP_HEADER
instead of DECLARE_PCI_FIXUP_EARLY, as Sashiko suggested?

I don't know the IOMMU init ordering with respect to PCI enumeration,
but header fixups are run in pci_device_add() before it calls
device_add().
