Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD0136358;
	Mon, 20 Jul 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550668; cv=none; b=bHfoc9A/T3V0+BMNBjCGS/46YWl+stIa41Kah1/YBCfA4eUNc0kJ94yom6AMccbU24hT8i+GY/6qYZwiaGeCY6Yvbn6PpIugzRAErhNo3iDvqOrkMitdfbVXa7fUXccUSeB/jdmSnItYrbGnaGawcW3kdy7qOGGAjquRiM58bJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550668; c=relaxed/simple;
	bh=QeULvMY3aAZTOlq87YsF7f+aZ+lAeuqQsCHij5e5S58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Auz9q/TzKk0J5F6Jm1DknwPhUYWX084do005g9ve0I9LOCSkHJilemLJ552E3vZf9xxVqzAlmfhd47mIQQ3aBYniDu02ZVUV8/sSsug/J96BfJMbxWn3gqeHZYu4E5V4LmWO65Oasn1iGUuZGtXzfnV1z5qa4JSIuPe3I2bazio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEKuY0rI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEKuY0rI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595771F00A3A;
	Mon, 20 Jul 2026 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784550667;
	bh=DMlN1youUMPy6J4fwS9F2+VJ/1xkblWtnWO8k1SbWdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MEKuY0rI94HRZebnBjw9DMp2eKl8WeLyWpQgVpJYxkRJxjj7rtEW6DIOQBC+kDeLg
	 zSTdl2RbBVsI7Pk8c5zUTVX7Cj3D7mNvom2uvEjM7ROirnDE5Lrl+MeM6KZE2lP1vN
	 9wmd/mG6v57MaaoQ36fZOsiEs/NkhvXelnVwcAXlaBuJ5rvkTxo3DLpaKXGbTzpwah
	 k/VKU70AaOsrGAeoPBs04Kx4LrcjnnLjM3SF64FpXc06D2h6TF8JJZCUJx+nODT+Wc
	 fwn5B278ovqKiGv+7KRjWJ9KzbgIEQDDmuIKgD7K+cm/QLyhkRmZJE6xRC2QA766b6
	 QDlOcI7znN5jQ==
Date: Mon, 20 Jul 2026 14:31:00 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Braden Zhang <braden_zhang@lecomputing.com>
Cc: Brett Zhou <brett_zhou@lecomputing.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 v3] PCI: dwc: Add pci id for LECARC pcie pmu
Message-ID: <sixmkaddyeeucylq7yjbn32lxkv35sph7n6kfsjy25a3odltu6@e4u4tl72ilp5>
References: <20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com>
 <aik4muvixggxmphxjlpsr4kbfw3sxuh5pj5u7g3olhlg65shfp@kaqahgep3kdu>
 <al3Rk_bPzfEpFTnc@arm01>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al3Rk_bPzfEpFTnc@arm01>

On Mon, Jul 20, 2026 at 03:43:15PM +0800, Braden Zhang wrote:
> On Mon, Jul 13, 2026 at 07:14:25AM +0200, Manivannan Sadhasivam wrote:
> > Date: Mon, 13 Jul 2026 07:14:25 +0200
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > To: Braden Zhang <braden_zhang@lecomputing.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
> >  linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Brett Zhou
> >  <brett_zhou@lecomputing.com>, Bjorn Helgaas <helgaas@kernel.org>
> > Subject: Re: [PATCH v3 v3] PCI: dwc: Add pci id for LECARC pcie pmu
> > 
> > On Mon, Jul 13, 2026 at 10:10:13AM +0800, Braden Zhang wrote:
> > > From: Brett Zhou <brett_zhou@lecomputing.com>
> > > 
> > > This patch adds support for the PCIe PMU found
> > > on LECARC SoCs, which utilize the DesignWare PCIe Controller IP
> > > 
> > 
> > LECARC looks like a ACPI based platform. I'm wondering how you are able to make
> > use of this patch without adding the ACPI ID support to enumerate the DWC
> > driver.
> > 
> > - Mani
> > 
> > > Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
> > > Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>
> > > ---
> > > 
> > > ---
> > > base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
> > > change-id: 20260710-pcie-pmu-5ef78c56c3b6
> > > 
> > > Best regards,
> > > --  
> > > Braden Zhang <braden_zhang@lecomputing.com>
> > > 
> > 
> > -- 
> Hi Mani,
> 
> Thanks for the review.
> 
> LECARC platforms use the standard DesignWare PCIe Controller, and the
> existing DWC driver already handles the enumeration and basic
> functionality through the generic PCIe core.
> This patch only adds the
> PCI vendor ID to the vendor-specific capability (VSEC) list, which
> enables the standard DWC RAS/DES feature detection.
> 
> We don't require a separate PMU driver or additional ACPI ID support
> because the PMU functionality is already covered by the generic DWC
> PMU framework. The existing driver infrastructure handles the PMU
> features transparently once the vendor ID is recognized in the VSEC
> table.
> 

Ah, makes sense now. It didn't occur to me that 'dwc_pcie_rasdes_vsec_ids'
struct array is used by the PMU driver also.

Please incorporate comments from Bjorn and resend.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
