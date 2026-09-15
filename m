Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67056413780
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508055; cv=none; b=mQaoE+9YiPkm57+HdUpk+cWLB2/zlR4sNkBHTB9vNP1FwuqsXlfF2WZf3UgZAoJ/bbclP1wW4F+1DMYveUx/3JIQMIaix+kI0us0xfpF/61Cw7ltouZ8M8t58e6agCj5unQ48KB/eQJdyXTJI1smNuZBkSmZJcPBpdke/zs/yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508055; c=relaxed/simple;
	bh=GdNxUeq7c3e4zdJniS9UOqpH5GxMr5cUzj3hWg7LTMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t4dQbssOuEuMiMI5avloNnojFpEL8RKO4Bdpn7tYDI7lMtGShW9HuoQiBklzWmEqPwYbefTLAva8mhoxoM3iVM00jSfWRbky7aEVJPoIkOb9XcNzc/yWOOXjQOW2V8zpoT4PKSoTsgSUpj0udv9PEm8N3P/OT2deydDWaUIW1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WptSUa5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WptSUa5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53051F000FF;
	Tue, 15 Sep 2026 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789508054;
	bh=qKxwS7LKSWluw4F9wxUbFAf/iyBiHwqmlZOoW42P2LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WptSUa5pJLhkP8v3gt+kzSJHwTCfokuQuSLI+WGgnLkGK/lPeQfytk4osRPDP7U8U
	 KTkVylbQE+bzM/iujES8nGd91jPEXJZQSdLtp6uemhHCl6V5QYhUpkgzQcnUn6JmF2
	 aBVak8/4lTNGD6SVFA1U5TIE0m5LuckB5X8fQNYbt2YOpLacVLNN4co8eG23rj7iE0
	 w9socOUNx05fa66gHgBIyqaV6ve4EkVeq9EAC2hCvpGTxbVQzYZGzV/7q+OIY7ZA7q
	 BmBfrxA1dsMK8Tvhv3ymykcD7M0WRcLQvS5i4mRUYVh80jY35w5zzmM/Gqrmeggkln
	 TIBgMoEN9yNHA==
Date: Tue, 15 Sep 2026 16:34:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G304 switches
 [12d8:b304]
Message-ID: <20260915213412.GA868738@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820082041.13470-1-johannes.goede@oss.qualcomm.com>

On Thu, Aug 20, 2026 at 10:20:41AM +0200, Hans de Goede wrote:
> According to the existing quirk the Pericom E5 errata for ACS P2P applies
> to PI7C9X2G404, PI7C9X2G304 and PI7C9X2G303 models.
> 
> The Arduino Ventuno Q board has a PI7C9X2G304 switch (verified from chip
> markings) with a product-id of 0xb304. Add 12d8:b304 to the existing
> list of quirks for this erratum.
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Applied to pci/virtualization for v7.4, thanks!

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..1b4e15d744e8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6259,6 +6259,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
>  			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb304,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb304,
> +			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
> -- 
> 2.55.0
> 
