Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F5314B72;
	Tue, 24 Mar 2026 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336424; cv=none; b=dGkcTNJWqA7RM6/6x8sHfs1PI9+omzUaxqHYIFlqnP1m4TNO/gsTxyyTXjvsMI0eeyjl5dAiy6mcd+87dgWt3My2MzKnYKsJrwmahBmNDwk3s4QH+x967lZXXqjGPST7UDX7rQssByzLTSzFvtOtutD5nk6t0d54kYl+IciGpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336424; c=relaxed/simple;
	bh=BEQCK3T20vwV9FXpCZnGuBMjUPmDCTkQ/0wFCqML874=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwWf+WmT/C9x2VH63WUiNsJDdL622LoJVAnrVrgU+WrKzg/gvTxa026JTH9jc7dmrLt2orfeCnzxPmX2G7WeRJCRqYMhgcjE1Va28wNQ6hExGQiWb43NFjdVDZATuxtz11oy5cqBZLGI9sd6HGV9blpK8gz4PT0PF9rHjX+rfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpY8LbqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpY8LbqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51705C19424;
	Tue, 24 Mar 2026 07:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774336423;
	bh=BEQCK3T20vwV9FXpCZnGuBMjUPmDCTkQ/0wFCqML874=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpY8LbqMXKIRLaF3S6C1EG9sDL4rwb07YQP5aJV9/vOh2fioYnkHnealNZT2sZ08S
	 DaV5MpEWESeeB9EzKJ1pMnG1Q6Tev3oB4T1MHDu9w8crOsIXnwN6wkyc+bvntGxsCw
	 78NsWATeJvsZ6XpI/UKz9f4Z4AhWLla5SxuFtfl+JmFMzGGCQfW0xsDhEWGgWlSsQE
	 NUj8dCDM8+tMyhndZuHFYmPobLom/U7E+vuEuerDV3gKkwXV0iiYBzNhtYRJm262Nv
	 i9gmn0k4ssrjOXhMw4HQkeoipJ19O2qSBmriYvz7AG2fgcLr1T2b0lYGqHEVyOndKr
	 MHQ5C09jrcZWw==
Date: Tue, 24 Mar 2026 12:43:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Gary Yang <gary.yang@cixtech.com>, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, cix-kernel-upstream@cixtech.com
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: cix,sky1-pcie-host: Add
 power-domains
Message-ID: <fiipz7tlqsd2hm457qr5r36qmrgh3sp2qt52oaaauyp5wmwmz4@fgmqawxrhir4>
References: <20260313114914.1564115-1-gary.yang@cixtech.com>
 <20260313114914.1564115-2-gary.yang@cixtech.com>
 <20260314-maize-warthog-of-modernism-f74475@quoll>
 <abfEO6iW3NcnMyNx@nchen-desktop>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abfEO6iW3NcnMyNx@nchen-desktop>

On Mon, Mar 16, 2026 at 04:50:03PM +0800, Peter Chen wrote:
> On 26-03-14 10:26:11, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL
> > 
> > On Fri, Mar 13, 2026 at 07:49:13PM +0800, Gary Yang wrote:
> > > The Sky1 PCIe controller resides in a dedicated power domain managed
> > > via SCMI. Add the power-domains property to the binding to allow
> > > describing this dependency.
> > >
> > > Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> > > ---
> > >  Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > 
> Thank Krzysztof for kindly review it.
> 
> Mani, I assume this patch will go to PCIe tree, right?
> 

Yes, I'll take it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
