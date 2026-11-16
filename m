Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848471;
	b=f19XkaTgIygMTBlMw3rpweBqZfFbgMAWQjWwHVd5hjYGf5SuskSy3UEeunvuymmOuigX
	 9NE9AuOVXf3/U9GE8LE95rYYqoTgSaTEVK1K0Skrk9ZFlGAf9keCoJBMRLTXIj0qDULX+
	 RhuOQ21qKHLzRTYvgmpVk0XgX8De4KjuSNCupWBlYbVJhWG3W7VYNR2ow51x2Glsg3roB
	 SZ9DEGftLNqnScSE9AvoI+OD+FUQGdgXTBwaZ9Cdc0edymQByhKZ6FMqRRzDGi4yMG03P
	 E6OnLQntvMNslylsjK45m13aH8TCfuGYI/f7g9WEj4/CKaxqyCkmgXEbcAvN4a/xV/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848471;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xelpX+ufg96HVCCaAqt67tyH2PxlvV/Ze+p6uSXQPsA=;
	b=K5weJkuHQ1xsyT5Vpls5DA4+G+CdN0PVtAL1KkrSRdjtQqQisIz4FYd68b+xkAd4dVou
	 hqpMz4OQuPp5isbGJcymkuAVoWgYxR6XVYOmnPfWJyTeQSE0tHIHlVaoqyesR2iiPiusV
	 g6HLk9HCkcA9ehHbBN/Gr7/6W7BlnBqPwN91ktHMCeLGnlGF3AQKq34hnJw+T9Qxw4HcE
	 M9R2M+ceJH/RBViLqG5q5VHnn1rIidA+Zc0rNP8+YMP0v1N6piqYBwsMXi5OaSuBJPlR0
	 ERiX2zVYAss5th5/tOOsvxMiOlnTj96mIO2apf9Ur7phdrOYpu2eJbO50Zb/D66ZRUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/Df+QdO";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27E606A31C;
	Mon, 16 Nov 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/Df+QdO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82861F000C4;
	Mon, 16 Nov 2026 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794848471;
	bh=xelpX+ufg96HVCCaAqt67tyH2PxlvV/Ze+p6uSXQPsA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=E/Df+QdOIhZCZIL1o9v5qm6cQkvAtLY1HKk1KkD8ato5pvyTNz1AAlB50hrwtGHvg
	 V3XWVHw3jwb2Fr9uxDtdaAdwfrKOTeX86rbGliNSP5GstU77UA3JUtZuGb5lS+azuC
	 TI++DRCQLAGe3PILcyrRAWISsbDbBbRly3v9CxDJLdVfkGehpHk3iU+hoCmuyhmVsW
	 fy/tUL8DIex2E63m9RnCG77Bgon14URcnvut/nXuSD18EaU0ex9kiDHhymzXARgy6+
	 B4CN7ma88p0ClTcES87G+0lLewIJSQvGm/oOs2gdRJmibmjsWFCGMDpun+fJ6JEW2+
	 NLKEIIc42e6rw==
Date: Mon, 16 Nov 2026 11:01:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, f@bhelgaas
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, robh@kernel.org,
	thierry.reding@kernel.org, jonathanh@nvidia.com, vidyas@nvidia.com,
	cassel@kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: tegra194: Use FIELD_*() for register fields
Message-ID: <20261116170109.GA71319@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109171905.GA211363@bhelgaas>

On Mon, Nov 09, 2026 at 11:19:06AM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 02, 2026 at 02:52:37PM +0530, Manikanta Maddireddy wrote:
> > Several Tegra194 APPL and DesignWare register fields are programmed
> > with open-coded shifts, which makes the register programming more
> > verbose than necessary.
> > 
> > Use FIELD_PREP(), FIELD_MODIFY() and FIELD_GET() at the Tegra call
> > sites where values are shifted into fields. The LTSSM state constants
> > are converted from pre-shifted register values to unshifted field
> > values for FIELD_GET().
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Link: https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvidia.com
> 
> Thanks for this patch; it's great to get rid of the redundant *_SHIFT
> definitions.
> 
> But I'm confused about why this Link: is here.  It points to "[PATCH
> v3 1/2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1
> entrance latency", which looks like a functional change.
> 
> This patch should be zero functional changes; it should be purely
> mechanical changes from explicit shifts to using FIELD_MODIFY() etc.
> 
> This patch doesn't mention aspm-l1-entry-delay-ns, so it doesn't
> *look* like this includes the [PATCH v3 1/2] content.

https://lore.kernel.org/r/20260515070753.3852840-2-mmaddireddy@nvidia.com
is a change that was already merged as 87f493041e20 ("PCI: tegra194:
Use aspm-l1-entry-delay-ns DT property for L1 entrance latency").

*This* patch only reworks it to use FIELD_MODIFY().  I dropped that
Link: tag to avoid confusion.  And also put both PORT_AFAC_L0S_ELM and
PORT_AFAC_L1_ELM on one line since they fit easily.
