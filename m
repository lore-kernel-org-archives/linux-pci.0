Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27F413255
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971201; cv=pass; b=UUceybAas3yXk+ml+2LsADQ2xMtanT1C9vH45JCtHUW1LlLQyHfDKMArOiNaQm3WFyTD+G0Z7G/4k9O+W0e1jHK84WynCilRZiLRf9h4wqpNr1RnJtEHN2abO953IitSLEzCg7qV1UF6NDN/1Jtn3LGnHPE4UD5+1+rROr7T+vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971201; c=relaxed/simple;
	bh=gD3aIRt1HRz4MbbLzOtK8OPo//uDsomBZ2XTxweSBms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rA7L8F0Mbcj94M8gOGFKh5usqH0jyuakawUA1t8ssNsES8gdZbH61ks/iAz8LzJ1xpKfn+mN5LVAOEBLEgBjT75/i+XcLeb1tCG+zfhmLptUj6C3DAmf08Mpb3jmhAomAErEGb7Fxrzrh+YXa3UdSKHr/cafVRsmLJfvAA9XFmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8jDCNKY; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8jDCNKY"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a723b2b29so49520321fa.2
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 08:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971188; cv=none;
        d=google.com; s=arc-20240605;
        b=kGDH1HYxn/yhBfWGhW3wGK6ZIs2PGeqWHwMxT+MO+VmmeMBdQz3e8Y44v7YpFR2vYx
         XZUGM0qoZHI/Ov+NXxLVB9A/19+FirZL8msUUic2ioO1GiUUPxHJwGtKMPCLwORx+EBX
         pY6lT959BtKqssRwcDSGkRijtmnUEndnkzRdS/ZVznDXsIHjZB21NjedRloYLIhbL0Yn
         B9Arxs9TRwpIFnSbhiJrdB02Xn0SxBpAEnW9ZF49h+NvL4SYfaw1W2nJM7MEvXKkWY7V
         4dt+cBPIU2wovVxgCsYehCa4wWNz14MfEhd/8RbgvTzx3KwDYMrf4k4x4rOQ0WcSi9Az
         wCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AJ4VqZu+5mQoj6EIb49j2AdbZlmHtkofnJRNL0M95Ps=;
        fh=0U9Bx14xFz/m21DC+RzlOX5v7x3hWz7NqTzyqz+sJcs=;
        b=Vup1E9NX3kuOEZIT/iXfmebIlgtW2QWmismZsJPSnek28ioYRC4rXBmg/753tpIMRq
         Z3yYr0vL7mklIWBrYtEkbU/S+rPr9GGRVC2BSQ28RixxWu2aOwu5kOr9SFFUIYKqUfQk
         tCPIvDThksiJK9WdKWzjXFa4W6zu1AW4WF7X+lco9CutcliPbyG23cIn8BWygqP8hOzO
         Y9cJ5G5E5nTVm74KRlTeMcJjrRL0MaSjJ+xOit4KbSpd5CznqzSnZoiJnOAQz/8eByFW
         5GOtPGlbE0HkxUS5DZClaY6wxXAqQqisOpZP7luA8drUvOs9XRcxDgrzpg5ijkQlHZc9
         8SwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774971188; x=1775575988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ4VqZu+5mQoj6EIb49j2AdbZlmHtkofnJRNL0M95Ps=;
        b=A8jDCNKY/5LN+suXYdoUWDdFzyC6f11NivIQBZGP8cA6DKeEiCIPqQXlzHsNBzMug/
         Erm+3k0YiLWfkkUReFaFkM57wzjUOSI1mHEJ4e3bDrBQAd13wCWaowYr88eht6dphYgc
         hl/NDN+rXp3O6E8iirRDSlmWGV4Yjc0E4yhe1S3UVPQ0jCLZNmsLmyrJVKxT+j8OeGvN
         DqEcMDhY3fbYFHCPLiqHv+UO9Twfvavyaq7AcNvB/gOW0qGhr4uvB3UBmgTP3lOHFgk5
         B9hqMzdLVd4dbFzucGTJ84ikq4Vfyc5/Sph22FJaUCkN4d1BkTbqMybE9LyxYzoYRo15
         vH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971188; x=1775575988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJ4VqZu+5mQoj6EIb49j2AdbZlmHtkofnJRNL0M95Ps=;
        b=oTVoGoXN8eGy1g3YqFKkNugbb64Djw3/69CUfDYzMjmii77EjhLDfombS3Nk4wg4R6
         A0GMvpsUJwrsB6QcJ9YLlSsowV7k+xBsf8Jf5HDtyJbaUuitFDU5IYJaZvbfQLSB0mD0
         degJZpb6kTTTO7IQQCXSsN6mQjPn5tbzI5rxM9EnmaynGox9FqE6jVS9lWJXDA+zLh3t
         M3EUy4Y8pACtf1v7uUirANYE9C1KwSMpRMSEBHS+4LlT1w4D5FvlzpWUqjd1ijiihFvM
         N+2tJ36k8VOyUsb+svB3s/4wpWDlA3DQOEru1l3w3d0shhKYe7aJANibChfTM7Mo1NXw
         VYdg==
X-Forwarded-Encrypted: i=1; AJvYcCVAqbin7Ajv9rWccqWtjeRck76+di61RHouHuYSgZRm5rBQjSPSU6P6DcCVIjDU1NrLRHecZ251p9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUy7X9CFaGZlaEaF3xHBfS+qOx8DKEC3uLhb36qU+/2bN0yoWO
	X6SMPwzrYqUdmfXjtzOP9i29aLFhIfF0ZMBUZcw3ZSBC9O3nChDark9/cPs+4WGo6rUIaE1uqHS
	JNHnbBqDyrEz4YrQsZoj0lUo+X7ZDxduV0za9gU7n
X-Gm-Gg: ATEYQzyhncE3mEBZzk3XWDBhI55Y3JGcJRvIPliGKHRI9Bi2GbeDXTEvv7RlUEZOVxr
	hUMWPGMF82mq/PWWwKvBuFhou3OhV4qhhpO712J/E442q+Un6t9Hr/zsdkMM4MG0Oyr0usd95Oh
	g4W6LmORAivQnKIwwBp8VV0lGYn/dUUafrQ12sIc+WRoq8pvO0+baz8Zyu9GPvnTix1E83xfht+
	+3B8bHgyv+VydVZY3HcYXpRR41ioKEEfGh/QI56DGMHCATXdZgfVl9CVRGdCI9QCTvvsYprf1Xf
	ZnCUpr3N
X-Received: by 2002:a05:651c:19a2:b0:389:e6d4:e7cb with SMTP id
 38308e7fff4ca-38c732638cfmr59500411fa.22.1774971186881; Tue, 31 Mar 2026
 08:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327211649.3816010-1-dmatlack@google.com> <d309de55-a1ec-4c99-b464-9ae9c0d9e027@linux.intel.com>
In-Reply-To: <d309de55-a1ec-4c99-b464-9ae9c0d9e027@linux.intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 31 Mar 2026 08:32:38 -0700
X-Gm-Features: AQROBzDWmLoJJPtDwKE_h2mNri9rVZpvA9S02cLOU60cK-aPBjr_r_Lu7fINV4o
Message-ID: <CALzav=d8GxA6uT6FDeThZkT4n7auvp=iuYWAhytbiCuq5dBWkQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU drivers
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 8:32=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 3/28/26 05:16, David Matlack wrote:
> > Ensure that PCI devices with ATS disabled via quirk have it disabled
> > before IOMMU drivers are notified about the device rather than after.
> > Fix this by converting the existing quirks from final to early fixups
> > and changing the quirk logic to set a new no_ats bit in struct pci_dev
> > that prevents pci_dev.ats_cap from ever gettting set.
> >
> > This change ensures that pci_ats_supported() takes quirks into account
> > during iommu_ops.probe_device(), when IOMMU drivers are first notified
> > about devices. It also ensures that pci_ats_supported() returns the sam=
e
> > value when the device is released in iommu_ops.release_device().
> >
> > Notably, the Intel IOMMU driver uses pci_ats_supported() in
> > probe/release to determine whether to add/remove a device from a data
> > structure, which easily leads to a use-after-free without this fix.
>
> Can you please shed more light on the above issue? In my investigation,
> iommu_ops.probe_device() is always called after the no_ats quirk,
> regardless of whether this patch is applied.
>
> The diff of the changes I made for testing is as follows:
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 442271a1b92a..c024964ac53b 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3271,6 +3271,8 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>                                  info->pfsid =3D pci_dev_id(pci_physfn(pd=
ev));
>                          info->ats_qdep =3D pci_ats_queue_depth(pdev);
>                  }
> +               pci_info(pdev, "ATS %s\n", info->ats_supported ?
> +                        "supported" : "not supported");
>                  if (sm_supported(iommu)) {
>                          if (pasid_supported(iommu)) {
>                                  int features =3D pci_pasid_features(pdev=
);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 48946cca4be7..c63616d108b7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5714,6 +5714,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,
> 0x1457, quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459,
> quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a,
> quirk_intel_e2000_no_ats);
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c,
> quirk_intel_e2000_no_ats);
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0b25, quirk_no_ats);
>   #endif /* CONFIG_PCI_ATS */
>
>   /* Freescale PCIe doesn't support MSI in RC mode */
>
>
> The related kernel messages are shown below:
>
> # dmesg | grep "0000:00:01.0"
> [   15.834944] pci 0000:00:01.0: [8086:0b25] type 00 class 0x088000 PCIe
> Root Complex Integrated Endpoint
> [   15.836382] pci 0000:00:01.0: BAR 0 [mem
> 0x1e0fff980000-0x1e0fff99ffff 64bit pref]
> [   15.836655] pci 0000:00:01.0: BAR 2 [mem
> 0x1e0fff900000-0x1e0fff93ffff 64bit pref]
> [   15.837904] pci 0000:00:01.0: calling
> quirk_igfx_skip_te_disable+0x0/0xe0 @ 1
> [   15.838614] pci 0000:00:01.0: quirk_igfx_skip_te_disable+0x0/0xe0
> took 0 usecs
> [   21.205177] pci 0000:00:01.0: calling  quirk_no_ats+0x0/0x40 @ 1
> [   21.206767] pci 0000:00:01.0: disabling ATS
> [   21.207916] pci 0000:00:01.0: quirk_no_ats+0x0/0x40 took 1122 usecs
> [   21.305357] pci 0000:00:01.0: DMAR: ATS not supported
> [   21.306925] pci 0000:00:01.0: Adding to iommu group 4
> [   42.564912] idxd 0000:00:01.0: Intel(R) Accelerator Device (v200)
> [   42.568653] probe of 0000:00:01.0 returned 0 after 87413 usecs
>
>
> Anything I missed?

The Closes link above has the details of my investigation:

  https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/

Can you check if you see the same ordering for VFs? That was the
scenario where I saw the IOMMU drivers notified before final fixups
were applied.
