Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898551F5842;
	Mon,  9 Mar 2026 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037903; cv=none; b=LKJSXgKUix1Ao+WmpK9rwvCIqk8trPXaCJOgVNwS8wm356RvW1HM9mZry+JCci2ZkhXBNG5QNAEFNYYHlqRVRRwyEvVMgGlrEXo318NI1BaCGBFK61UIkE78XU6SjK4t8paC7PpUEMcbFX+jtZ68nt13cGan5BOgNNd+XDAEkmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037903; c=relaxed/simple;
	bh=u4WqHSsi7MhLQ9EloFcBBv9DxI3CKDY2haYY37CvwW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN8YGbUspya2k14ZlOby4Fux5rmm0VEDfHTTVPz/L3mvkSe/0dcO4CKLh2oihVLZDxCkt+dtaYwb0NxYjESq3f3S6AeI55ZCje6fVniLYdkPHD0QnF3ddyTiOhTRe39odSaD00IjWUCYeMIg8wbB/j1571j3YUfoS6TietUsBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ4l59QS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ4l59QS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2949BC4CEF7;
	Mon,  9 Mar 2026 06:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773037903;
	bh=u4WqHSsi7MhLQ9EloFcBBv9DxI3CKDY2haYY37CvwW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQ4l59QSykiJKGI/c5n39m1bRo+zk3pLnlAAIxaVq6ks0+UoUYQxIzb/Gytwh14w9
	 k1lIy0577ACqqTP8Ca67zy3FQBGJTuCJmNTaeSNJ1Lysl6/gv/YA2i/gJfazZiyIM6
	 DollnoOC9mQ7ZxSdKUIZiPCpcPI5RWzRXH2ccX6XlRliKX6C6mybJ6Qzx0PbXsUmK7
	 A9AFpWEhzuI51xEYJTj/tpPMyRjyocL+KmMsXfEqgFxp8esOGbU2Eenys7WzP5tRxC
	 9B72C0K0Imm43MWJWbXg+6aZWJVDXkfexeRpQg3NHsU+elqrbLLD87hiHHzQecR+4K
	 ftIV/iuEljklA==
Date: Mon, 9 Mar 2026 12:01:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, yoshihiro.shimoda.uh@renesas.com, fancer.lancer@gmail.com, 
	Zhiqiang.Hou@nxp.com, gustavo.pimentel@synopsys.com, cassel@kernel.org, 
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: ep: Fix MSI-X configuration to write to
 correct physical function
Message-ID: <tlsbdp2o5qpizi4pqr4stiikglriaa37mbnxvo7ppks2k46pnd@klta5arlhkga>
References: <20260224083817.916782-2-a-garg7@ti.com>
 <20260306184519.GA131984@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306184519.GA131984@bhelgaas>

On Fri, Mar 06, 2026 at 12:45:19PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 24, 2026 at 02:08:16PM +0530, Aksh Garg wrote:
> > The MSI-X configuration code reads from the correct physical function's
> > register space using dw_pcie_ep_readw_dbi(), but writes back only to
> > PF0 using the old dw_pcie_writew_dbi() helper. This causes incorrect
> > MSI-X configuration for other PFs.
> > 
> > Fix this by using dw_pcie_ep_writew_dbi() to write to the correct PF's
> > register space, matching the read operation.
> 
> Is this another case of using "PF" in a non-SR-IOV context, as I asked
> about here?
> 
>   https://lore.kernel.org/all/20260223185558.GA3701139@bhelgaas
> 
> I do not want to use "PF" unless we're talking about a device with an
> SR-IOV Capability and we're doing something specific to SR-IOV.
> 

Fixed the subject and commit log:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=271d0b1f058ae9815e75233d04b23e3558c3e4f4

- Mani

-- 
மணிவண்ணன் சதாசிவம்
