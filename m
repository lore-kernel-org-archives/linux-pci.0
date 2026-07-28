Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C542F12A1;
	Tue, 28 Jul 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785252920; cv=none; b=bzHXPXEehOiiBHoQgS+WohsByjwuIglPU44hNNUeocRi//Tnu6y8vEz9I1dm4m2+2E4B3Hi783Yd4mO78g5O6gj7At67wmDaN7zLCtvfSW3GfRmbJXeWSVDHbIUNaRAmKaOypfyd0zY0MrRjfJdyGNrhJpU5MBI2PwuPlvSmhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785252920; c=relaxed/simple;
	bh=se1LO4F+tfnAfWpzGNIgmHCNMrloDTm9wGgsE06pvbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psyRXRc/pfqD3hUeYbkZ6nE76ddxGo8uwYRUbWFsctedn5b+zS9YO8yT9pcZS0jTVzuhIT4Vga1bUrrMuzzSBdbghOApaFHuVDkI92iMMTa2kzD0k4s+wLCbt/ToUomKUhgMyu+tRQuQchGUZunmLw2r3LidWNYlaiCYzXzOA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYmd0VR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYmd0VR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A9E1F000E9;
	Tue, 28 Jul 2026 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785252919;
	bh=+2JcHl8MfmFGDDE0iuJ04h6g0/9yIgXDGUpOvLTjqOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eYmd0VR2hgXybyxtDQE2qFPhh5MyXwNgmJXUq9K5iVioZDuqqVBcpSlf9rn6VH5dS
	 GPZQl5y738ZsQHLfzC7FGzQPyVGLSQphIfGzHL9j6/BsyG5kuge5tORgEs3e03v2gS
	 MG2CZJZk0PTUJNJ0PaAPWuoMQAVkNPMN//e4aCwoLg3M6TchU6SKzjD2JoQvnFrNmz
	 GDo4bGGitaLZ1vRn6xLNrSQHuvPHBQeyyGsZxu9SAztePMz/d/8nUsRNa+gJmGa/BC
	 ks+h/iaM5z/XWi0IAGvWVmDzC1sMt4zLs8fcTi8zOmjrJIjAq/ANPFOE1EphjUmKw0
	 LQCGHzjgSS75Q==
Date: Tue, 28 Jul 2026 17:35:10 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated
 Ethernet MAC Endpoint node
Message-ID: <ztbtztpa6km6pak5ovzpjikhhpvh2sepgyuyckvszvyic4ufhe@3owfriffgar5>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
 <5348ff47-910b-4614-a935-6e99ad3b066d@riscstar.com>
 <uavzur74w3w6d4acq4keoi42pcob4p3jez7e5p2aubw27k5geo@ccaewywqbz3b>
 <elrj4hfxzrtn2hfldhvk4ychlbmxcrksmttg45a6nw2h3gulso@4nk3lrgo5rvu>
 <24fe82ef-ff0e-48ec-a6b6-c04d687e7359@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24fe82ef-ff0e-48ec-a6b6-c04d687e7359@riscstar.com>

On Tue, Jul 28, 2026 at 08:41:02AM -0500, Alex Elder wrote:
> On 7/28/26 8:38 AM, Manivannan Sadhasivam wrote:
> > > > If so I think the DT binding could explain and possibly enforce
> > > > that, but I won't insist on that...
> > > > 
> > > It is being enforced in Patch 1.
> > > 
> > Sorry, the current enforcement is only for PHY related properties like Tx
> > Amplitude, DFE and N_FTS. I didn't limit ASPM properties in function 1 though.
> > Doesn't seem to be strictly needed as no one would configure per-function ASPM
> > settings in DT (mostly unlikely).
> 
> I think it's fine.  You enforce what's needed at run time
> regardless, right?
> 

Well, we don't parse the properties even if they are available in the function
DT nodes other than function 0.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
