Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B933CEB0;
	Mon,  8 Jun 2026 15:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933628; cv=none; b=Ya+86ZpMlSNtRx4+LIlajwoAMDPJulFcZwB98lRzov3Rw8AijBMNLkXBsttOVy9UDexNZDwWWlaqhDDYwAkoVdIun1650c2fl2z6E+n2OsNJ7PlPAhjJStUIBQp/W1p2f5XeikFheSNB4vGX+wixHL/YFch2VMMH1xtQfqve41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933628; c=relaxed/simple;
	bh=Iq+6ojP7AgppYPts7xyLxCZYGE1ZVizTuyix4WGPuxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FMHoY4zJp4eNn8Ouky9WLdwpfXXhp5tC2s12UpcpLdNHpKdItgMNNpHTFBHsRniPq26aZNYIGg0GcYg0wSASFXxvaiI3gVudz4XovDvyGsucLKky2/ELgFmZfwX0Mc55D4JT1KtU1GAQGfKctkeiDNifbSEozhIDNFOun+xFSr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHNRSNQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHNRSNQU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0ADBC1F00893;
	Mon,  8 Jun 2026 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933627;
	bh=n4hnVEfxComf4F6YWKkdUl61CJnEKjlTtTpb1nSSawg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eHNRSNQUsT4haJHtOCo0wLuutOOuztmdqV3Sy4EbW8Pl+mExGkdKvt3Dl1z68GS0Q
	 0wNe9fnB/TXtocgurldMflVdrO5J3fzfyclVziZhW88hWAeSsJzvBG1hbhfUpZ2jLr
	 D0jf7VAVsLLGQ5xtpQAkObz6AFN/iUT7p/z8dQdFqi2of4vpD7bKC3Gcv1fjwdKl1X
	 sxnQdMEV76YBya/DzftB8Ezev3BYTdqLtANYz8v2nnqJwxWGxV+vrfllDyC8jcQbZd
	 Cfb3nNc5EYrYPh7wt+dY+yNzzXaXR46s96GSB50nbC3TjjU9GwLOJyU1MxtVadf89r
	 VILX745YZXFUQ==
Date: Mon, 8 Jun 2026 10:47:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org, jgg@ziepe.ca,
	yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <20260608154705.GA36965@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528115613.63f1b178@shazbot.org>

On Thu, May 28, 2026 at 11:56:13AM -0600, Alex Williamson wrote:
> On Thu, 28 May 2026 09:38:40 +0000
> Ankit Agrawal <ankita@nvidia.com> wrote:
> ...
> >  drivers/vfio/pci/nvgrace-gpu/main.c | 144 ++++++++++++++++++++++++++--
> >  include/uapi/linux/pci_regs.h       |   1 +
> 
> Bjorn, I assume you don't object to this trivial addition:
> 
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 14f634ab9350..718fb630f5bb 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -1357,6 +1357,7 @@
> >  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
> >  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
> >  #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> > +#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)
> >  #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
> >  #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
> >  #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))

Yep, looks fine to me.
