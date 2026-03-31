Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DC390223;
	Tue, 31 Mar 2026 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984564; cv=none; b=sdjVANCvdVRm/EkBkYMOEfMvuAsYhixjgRnClKgQTJBvzy9OEv73gGUvZy9UmYxt5scHr3VT6Rg6e5sC2yFwG7HA3mXfzUpHy9d3hM22WVA7D7kVS1U9AVhsGKzU/Wx/ZJb3lwXp5ZZ0IfX0O81cvRyRfdxbb1qtbz6egSItDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984564; c=relaxed/simple;
	bh=D1M5ZeEglwog6CySVLSlsBtzqB0QYAThJHIv7eOpdmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ocMVjqMMAhBqfBjlmwjDcj88b+bO3hrxiIIOFbQ1V/SgRWCkJjMF869lIV00fjbZ0oJj+j5/Um7YTdSv4UH3Fxe65rdJMUIS8HiAt+SX8AGvC5QzJ/xgBdyPOzIVTeii23KmDGr6n9+2rcBxYFe1Juho3BAAmpPjmzlvoIBcWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuEBa8Qp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuEBa8Qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA07C19423;
	Tue, 31 Mar 2026 19:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984563;
	bh=D1M5ZeEglwog6CySVLSlsBtzqB0QYAThJHIv7eOpdmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PuEBa8QpIXBv96NvND1wnobXueTgjOG97IOcEMk3Xv3xpPdwzngMmve4hZjokmeoh
	 C6skJH6UxfgzGaIR3gW8GItoyf+B1MJOUSV0pw2EfdYFkIIaFNHxbloiIvagx/S0N/
	 k/wWahzAfZUo1tBeGNekyj33xNZToxthQIGI+KdBJC0XaxfBK6gYG6lEJJdetNtuJg
	 Cv+N8V07OE/O0paRM0dseIZqpdtoL6TWilaf/I0hgeQwy3XgkDB99UsH3kDmmW0C19
	 hqavKZ97w9eRj9ZVkrjx2FjoExp7QorjlruAUKhOHfKRKKbQJwpl5AhIIWadj8CpNx
	 EAn9bsOiXY2Rw==
Date: Tue, 31 Mar 2026 14:16:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: bhelgaas@google.com, robh@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: dead code cleanup in Kconfig
Message-ID: <20260331191602.GA152534@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330214549.16157-1-julianbraha@gmail.com>

On Mon, Mar 30, 2026 at 10:45:49PM +0100, Julian Braha wrote:
> There is already an 'if PCI' condition wrapping several config options
> e.g. PCI_DOMAINS and VGA_ARB, making the 'depends on PCI' statement for
> each of these a duplicate dependency (dead code).
> 
> I propose leaving the outer 'if PCI...endif' and removing the individual
> 'depends on PCI' statement from each option.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---
>  drivers/pci/Kconfig | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

I think there might be more redundant dependencies, e.g.,

  - HOTPLUG_PCI in drivers/pci/hotplug/Kconfig depends on PCI but this
    file is only included 'if PCI'

  - there are several "depends on PCI" things in
      drivers/pci/controller/Kconfig
      drivers/pci/controller/cadence/Kconfig
      drivers/pci/controller/dwc/Kconfig
      drivers/pci/controller/plda/Kconfig
      drivers/pci/switch/Kconfig
    I think all these are only included 'if PCI'
