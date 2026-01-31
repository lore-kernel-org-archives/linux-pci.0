Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8434EEE4;
	Sat, 31 Jan 2026 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880920; cv=none; b=LXD02EEG7m82aYK1uYY3BI/tcvEDTBotQghFzO/zoWZchsZ8cMQd1q7xKY8z5mo5ZGzmUabDXTCmMsBd3pcYxka5mOmyY7z3WXrIbuPoisjofDRr3M+6bA5RMOyPAYmv5B0ZAdvVlWc5bUK79mXMx4EKUw0GJZI6Pol+kl2ndwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880920; c=relaxed/simple;
	bh=+dri6J0Bx7uOsLbd49Yn2k0TdPm0FAHLxYH/6NKndbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EimeiUgVWrQKTe3qkdsTfFBPmTY5qYwrgRgmiPfUFfR2PB1e/N7a/maXuFApkmvA70uXRvGsFiLceUVWCghGDJZD5LHQ8aSxfHJdfsPsLktzyvB+d8Hb3VT/GXk4/ZfL+3cr5Ioao8YWPuGHt2P4vQZ6apay5HxuaO4zWmmsugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdYvG3PW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdYvG3PW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17196C4CEF1;
	Sat, 31 Jan 2026 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769880919;
	bh=+dri6J0Bx7uOsLbd49Yn2k0TdPm0FAHLxYH/6NKndbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdYvG3PW7K3yr1rfRSAz40WpLX7f8wXla96G4GT1L03zfKqQDMECDsgtCW/1c7gPp
	 qczWdPEZq7Nr8iga0o12z7oB/N3rhvOCcUbsXPjN6vTK3xVY+OpedDuFWZ1nVc+ycX
	 n76bAePpLd807W8NaTLctINJ8joGa9O6DxdnKknIUe9nYCU8IFjcADFfMQk22tDa4o
	 sfAeRykWL1RuNBE/7jmXV9QerPlYvBii6TKH/K/NmS8rGWMxoQunx92OgxtzJasty9
	 UBJI3Z4JzAlcUZ9RJoqIJTk2rDafN6rr6dNHiTDgUNH2pkHMIisPDXynvzRabfTp2K
	 htt1vMnTZKN9A==
Date: Sat, 31 Jan 2026 18:35:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com,
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: pci-epf-test: Use dedicated
 pci_epf_bar for subrange mapping
Message-ID: <aX49Ucwd1PalCcGr@fedora>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131133655.218018-3-den@valinux.co.jp>

On Sat, Jan 31, 2026 at 10:36:54PM +0900, Koichiro Den wrote:
> The BAR subrange setup/clear paths in pci-epf-test used to update
> epf->bar[barno].submap in place and free/restore the submap around
> pci_epc_set_bar() calls.
>
> Some EPC drivers may keep a reference to the struct pci_epf_bar passed
> to pci_epc_set_bar(). Mutating or freeing the same bar descriptor after
> a successful set_bar() can therefore lead to unexpected behaviour.
>
> Use a dedicated pci_epf_bar instance for the subrange mapping test and
> only free the allocated submap after restoring the BAR mapping back to
> the default epf->bar[barno] descriptor.
>
> Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 32 ++++++-------------
>  1 file changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 6952ee418622..fd6452d1dcc7 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -86,6 +86,7 @@ struct pci_epf_test {
>	bool			dma_private;
>	const struct pci_epc_features *epc_features;
>	struct pci_epf_bar	db_bar;
> +	struct pci_epf_bar	subrange_bar[PCI_STD_NUM_BARS];


If we compare your test:
pci_epf_test_bar_subrange_setup(), the host side decides which BAR you
want to configure.

For pci_epf_test_enable_doorbell(), the function itself uses
pci_epc_get_next_free_bar(), so the EP side decides which BAR to use.

This is a difference, but I think your way is fine.



Another difference is that you have:
struct pci_epf_bar      subrange_bar[PCI_STD_NUM_BARS];

while the doorbell test case has:

struct pci_epf_bar      db_bar;

Looking at the code, you allow multiple BARs to be configured in subrange
mapping mode (even though the selftest itself will only enable+disable it
for one BAR one by one, but I guess someone could theoretically write their
own test program that puts all the BARs in subrange mapping mode at the same
time).

This is another difference from enable_doorbell(), but again I think your
way is also fine.



Looking at the pci-epf-test code, I realize that, because:
struct pci_epf_bar      db_bar;
is just a single struct, doing ioctl ENABLE_DOORBELL multiple times will
just overwrite the existing db_bar struct... Not very nice...

Since it is only one db_bar, pci-epf-test should return an error if
ENABLE_DOORBELL is called multiple times in a row, rather than just silently
overwrite pci_epf_bar db_bar, leaving the previous BAR still configured
while programming yet another BAR for a HW doorbell... This means that
calling DISABLE_DOORBELL will incorrectly just cleanup one BAR and not two...
This is not your bug however...



TL;DR: I think your code looks fine, even though it is different that
the doorbell test case in a few ways.

Also the doorbell test case is buggy, but that is not really your problem.


Kind regards,
Niklas
