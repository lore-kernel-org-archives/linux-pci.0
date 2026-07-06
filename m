Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801F35898;
	Mon,  6 Jul 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333228; cv=none; b=tegNwqJnfadYJ4NkDP1e0nMv95xRjk3XuBiDNBwuLVpQtLF+ExGqSJqxFST49I5D1X2iJGa6zgpex3A3jAP38NTqsRD6ofop0mPEG5EC4AcuPOcVhQWkCLH6zAtKGkUicG44JEXfaftVxlPobFo+MZ3AObRWOQbI8epyTS8DwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333228; c=relaxed/simple;
	bh=Y0syRuIVofEMjjtOeH1ANg/7jjajXELMxkgB/W/o9bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taxETZw7V8fT6MQJPVGPnXS6YglSwYy7SnpbRbsmXsfKZB2jQDmWiGgGft+l1aPbZQN6SqIjC11mHsmHKA1NkUzVIMpebqRM+8t9wYVoGeYGONa8QUIBxMDYbkvdW56XUJ6+/BHhTYF7ebAVyN3WN1ev0bizfHh9wBCacK9Y49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYQoNd7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYQoNd7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1278A1F000E9;
	Mon,  6 Jul 2026 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333225;
	bh=kdbgxryyt7nPSImKYfr1DLB9M/vQ6ED7BOqODhY7wXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CYQoNd7u0Jr9BrkiPChKd82GoPZDDwC8AlOHXpwgtwr5PKOzPcDA/RefbgH2Nr+/x
	 K1RjsOcUtWBG3KebLTuitnFrrUKJpgDW5vp5p9gg414HukAWEPJCLIxG4Epj5Rmsve
	 /VtPMP9JXfUmvETrGR9AIa6Yp/wTvIgjyRgEGnnspf3Deqq/UkzDRCQzasAM5UrikO
	 N2IANFLOT6PLkpceXy1I3NY0G5Xk0Xqk6JrwyEqE5xElkdR4RO+a8VuojTmEqm3IlV
	 WdvZF5lGaU3hVuiZ2sLuWnU1OytLhPi0rLestZkN20IWQxXbGJHNo+m3zK9nxGHMG9
	 Q3tCPG4qOkX5g==
Date: Mon, 6 Jul 2026 12:20:07 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Max Lee <max.lee@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acelan.kao@canonical.com, helgaas@kernel.org, 
	kaihengf@nvidia.com, victorshihgli@gmail.com, lukas@wunner.de, pandoh@google.com
Subject: Re: [PATCH v3] PCI: Disable ASPM L0s for Realtek RTS525A
Message-ID: <jnxtx4pl36dzuddqugpfack5hfmwo2wazg5t7g2sill37urtng@3bvsmzehfygl>
References: <20260610024723.188514-1-max.lee@canonical.com>
 <20260706025358.516607-1-max.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706025358.516607-1-max.lee@canonical.com>

On Mon, Jul 06, 2026 at 10:53:58AM +0800, Max Lee wrote:
> The Realtek RTS525A PCIe card reader reports an AER Correctable Replay
> Timer Timeout storm when ASPM L0s is enabled on its link.  On an affected
> HP ZBook Power 16 inch G11, the Root Port received tens of millions of
> AER interrupts from the RTS525A even when the rtsx_pci driver was
> blacklisted and the endpoint was not enabled by a driver.
> 
> Testing with OS-native AER control showed that disabling only L0s on the
> RTS525A link stops new AER interrupt and counter growth while leaving L1
> enabled.  Disabling L1, L1 substates, or Clock PM alone did not stop the
> storm.
> 
> Prevent the broken L0s configuration by removing L0s from the RTS525A
> advertised ASPM capability.  This avoids enabling the non-working ASPM
> state instead of masking the resulting AER Replay Timer Timeout reports.
> 

If you can add the AER log snippet here, it will help others to find this quirk
in the future.

> Signed-off-by: Max Lee <max.lee@canonical.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

One minor nit below...

> ---
> Changes in v3:
>   - Disable ASPM L0s for RTS525A instead of masking AER Replay Timer
>     Timeout reports.
>   - Keep ASPM L1 enabled based on testing that only L0s is required to
>     reproduce the storm.
>   - Drop the endpoint/root-port AER mask quirk from v2.
> 
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc0..e63ed055f466 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2520,6 +2520,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
>  
> +/* Realtek RTS525A generates Replay Timer Timeouts when L0s is enabled. */

s/Replay Timer Timeouts/Replay Timer Timeout Storm

to stress the severity.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
