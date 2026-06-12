Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6538F62F
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301359; cv=pass; b=ZkHQpZbBQFA9GyiLREaLuTsaRVxC61xKqlo48s2jvHhljRfz0kagOXvnlRbtuJ/kvhesGPBrt8my174BgX1MW9+1PqUi9NxVeXwKN7bVWWlld4jIWPvsNGqDN70RumZ54hWOG7fUJYyJuPBoJz3GeO+1Ys7vBZ0pWPNdtraPrvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301359; c=relaxed/simple;
	bh=c5k4Oq5GSMIul/oHkFFhtzdDkxKeC/IuH3ROX9hOaro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEWa+B2q9rLDLQFGRmS8yWB7jJyNQG1zQW2on43cCoqLCufs86HmObpPKnMXr+DlN/c6SX2myVgqAt/T6+6z7Vmf90qz8DpPzWAS4BqRRiAlI7emwyX6iACQBETrOOwM6PY6h3I89u7Eo5EOKDVNKnWzE6hA9K7WRy4s1mPVusI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9+YVU/z; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9+YVU/z"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1384eb94d20so1636198c88.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 14:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781301357; cv=none;
        d=google.com; s=arc-20240605;
        b=VQ+DlEuHkW4DzvtRYVzekI1hSRPpHIAKRrW/byBHGJ4tZcao8QZjBiKTWC2urxojgO
         ZkxCcf/xAqw7G7ccjP0K4vHvcRRtsLeJsbmH8tcIE/6uU1QfnIph9ALuk808aEDAdDJF
         H2jjsCovh4E928fxxFlmxUnmNXnI4TcMNu3zCNqxHkSbExjwxRbr3dBr5C+PXnnJ79nT
         LcelKGKeqEd/h6yxAb73sn9GHi3P1HCgwoGPtqvaHeFuV0s0hBE3V7qDvO4OdYFfphbw
         Va0T5YrKro83zZEhEN9Lh6fJ4h+CupQas32aW0QmM2x2sg+GvXSaFy4YtTx9y9dgo5A7
         TCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c5k4Oq5GSMIul/oHkFFhtzdDkxKeC/IuH3ROX9hOaro=;
        fh=xYS5/tXthEEzWEc9PHTyIIm296pOz6RqlY7kt125fRg=;
        b=H0iKe7+JPMjNGT7HTOuDPe4N4V1aS06fHiQvL54XsTC4oU1bh2N+eDqkbecoqt675E
         qQAoCjG7BwPI/H7JwDHCpA7NAttvpSeRMxTs+DmkIBRTPgIFmfJEnsrRXpPUFLDOKu0R
         lkNl0GZTyqdP5PGuOhJCA8xFgv/t7xOifufH3FwgLQnCKKbEqoVS1iDX3Lmin+en6nlG
         zhTwciRGazdCdcv07mT2uJlpobJVP6ZkJBrI/EQViryK4NHst1IskgfQJ1fOIs/oYp2i
         JdXTiId2Wr39UZT/FVmS7FD0/9Y04vo+BqAZ4O2QvH6GdOHxX+7954nnJpCTMgKrW3ix
         2cZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781301357; x=1781906157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5k4Oq5GSMIul/oHkFFhtzdDkxKeC/IuH3ROX9hOaro=;
        b=P9+YVU/z1jzgsqTKkjiqEB6PedGNPnP09iRvyBo4aaOGtv4HCM3N2AWuU8ZnuU/Ofy
         /5XmRGumedS7TnQEJj1MCioxlbgYTOfq12awNfHN2tH6zYPIKVSNmcqhdAOA9cUN/5Ph
         CSKitrVj1P2W9UR2P6Xhcz6zJ7m4A2LOP5vit5sKnIWEc0A2v7qBXfLFanMi57GlCfjC
         0EuFnNAc7RxpERaIhqB7naKVDbNCqkhm43+cD7spPD0saa02P5t8siEan8YnIsIplL8m
         Zf3OxWDB1HZoCq+qjrwMd4q7AEaCklcc1Z5f6vJin+MGp0T9sE8fTqjHXy9yfX5DUK8o
         9O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781301357; x=1781906157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c5k4Oq5GSMIul/oHkFFhtzdDkxKeC/IuH3ROX9hOaro=;
        b=Aqaqq234FjhZchdtoVhhZUdP4GF4FuNJNCh4dif19yQQrbH11XmKexvxc6B5PghJhs
         lVl6zas9XTw6yiUxF/YePsoSdC8mz76vAA2/uWuktlsGFF16leaVm4eqoWjsUmv+xE9q
         uNNB9dBL0CYle+4hujVqKuDKVX6JWTHwqB/tdcCxh8J7vCmS3/eM5QyPSLaEviCtPxbm
         aTYjK8HuT7NRlZFGxo7my2eSl131mbJYwR3e/SkSuA+QjQ+CHjgRJrOim1GHiqGb3WPe
         IudhycYFlp+rgQKUwiaVznaWOiO3lHWyV8CbCs9QcXM1MXkm8zT6jldxI3vXBnpA8dw4
         RXnA==
X-Forwarded-Encrypted: i=1; AFNElJ+1K6DoyDqSdmtJ4/uKpLzVk2kKSooQn6JDgujC0NU73NzD74V+NDDL1Q0rfzcHJqVu6TFV9YRWbeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxil2pXAiVnRkEikJW4gFf1BzelkLW3xu6CXwPLr1wCYSGF5D0o
	7ZZIpoaaozBQRyoKsVPzz1tP3/PNEHQbx76eNf1WnPgTglQaaI9CsL+ox52qLCRNGU7E/mXbafO
	y79rWGL8haANt0hB8ttstUCF0N+npJ8iqbtJk2Tdw
X-Gm-Gg: Acq92OGdEF0JpUl4FTIm0Q/iVqKtGJgetj3xvlF41AHYQ6zq/mPeS3E/AA93ypKgmBA
	JGDoAcYBtKkqPsIMWWFG34JWKfclfkMHtKa1M7wi446ldQIxGzWFv+zfT+UTmGI/0e3ayGW2/26
	Rg9WqafTPKP0xWKrELpCsB/e20iiopqrGWs4z5CXtGF23L43L4jndyxAp/3q0Nn1g06XEvXZAkz
	UggGoi+GP5SWe2t4RaP9NO79EQvsGeKD54iBvRdPwn7Y0DAqGxwT5oPihB+hUxvBxmeAomwFLCv
	/rIHppM=
X-Received: by 2002:a05:7022:6ba4:b0:138:2a54:f6d9 with SMTP id
 a92af1059eb24-1386f38e674mr711077c88.25.1781301356988; Fri, 12 Jun 2026
 14:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403222750.1215002-1-dmatlack@google.com>
In-Reply-To: <20260403222750.1215002-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 12 Jun 2026 14:55:30 -0700
X-Gm-Features: AVVi8Ce2pgU7oo0oNb2vLm78uTfzIT2w9i2XBkQwmi3VnduQ3RTcXQRPQMWDhj0
Message-ID: <CALzav=dFkQCDH3iFe1zbpOEy45xV-Ymtf0F1eoG1HbHX04ahAA@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Ensure ATS disabled via quirk before notifying
 IOMMU drivers
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>, David Woodhouse <dwmw2@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 3:27=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> Ensure that PCI devices always have ATS disable via quirk before IOMMU
> drivers are notified about the device. Fix this by converting the
> existing quirks from final to header fixups and changing the quirk logic
> to set a new no_ats bit in struct pci_dev that prevents pci_dev.ats_cap
> from ever getting set.
>
> Use header fixups instead of early fixups since not enough of struct
> pci_dev is set up in during early fixups: quirk_amd_harvest_no_ats()
> needs subsystem_device and subsystem_vendor to be set.
>
> This change ensures that pci_ats_supported() always takes quirks into
> account during iommu_ops.probe_device(), when IOMMU drivers are notified
> about devices, and that pci_ats_supported() returns the same value when
> the device is released in iommu_ops.release_device().
>
> Notably, the Intel IOMMU driver uses pci_ats_supported() in
> probe/release to determine whether to add/remove a device from a data
> structure, which easily leads to a use-after-free without this fix.
>
> This change also makes disabling ATS via quirk behave the same way as
> the pci=3Dnoats command line option, in that pci_ats_init() bails
> immediately and never initializes pci_dev.ats_cap.
>
> Note: In practice this fix only matters for PCI devices created after
> IOMMU bus notifiers are set up (e.g. hot-plugged devices and VFs).
>
> Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devic=
es")
> Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
> Signed-off-by: David Matlack <dmatlack@google.com>

Hi Bjorn,

Sorry for the ping but I wanted to double check if this one is still
on your radar and if it can be picked up for a future release.

Thanks.
