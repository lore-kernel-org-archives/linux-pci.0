Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6C2771B
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085473; cv=none; b=gF4Jjh2GZh1/HPkMkDerk3roYNblbybV8fK1d0E0vXeXsVK+r5CDyLRX3+iVupMrmE/NKM7sx4pi3CdeAFAtk6fieL7ydCT13OVJsyFNJldE/YG7LnUSMzrpTv1Jg3sOlOkGpZKhD1YaFV1hRpvWJg9SImBaOYooqtj4x/XePwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085473; c=relaxed/simple;
	bh=HwPhK/sm4pTOAakje5v7D1r/K6bMRpeicEANH4ENtaM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DzCvEuCOtkBzDnjFDiK4ZCJNOlfO7uO6T3RL/REv+7/O70YPFJl2pSURPSCvfgbcDZfWBTJ9mtEYCqsp++D81JNV+0jEiT98RTj5DLR7cijHUd17Mme0rxmC9cs549izcp/xKOBhsooNLPT5sXSFHOAlU6+XwjqQT9MQWI2O1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgx4/XAN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgx4/XAN"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so9581455b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780085471; x=1780690271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+f5PwTRtQw0NnCrpunqjHa+0pqSt5ykYfwDM0Ecjt7k=;
        b=mgx4/XANoCPsRtW7xBzRpW1H9but9219eZNE2BZYs/Rfxc0o7p+lf/I8AJuASa4zBx
         PuNoBQJtg8madedyEd3s1AYmqi9VaZJKSftxaBsPi00PpHAC1abjJbAYtPOyWPmfAfP4
         A8lH9RXXZdIkEC+zNieURPCTsrXNVL2gX5B7L4S/86bgNhvDGoIDk2hUKMXTaZ375DI9
         lYuPaewjp7Wii0AuDD/nLde3BHE4vuqCBaSHLczbLNvI+C93E7a/YjxWIsusJx1sFGTY
         m45NrPr+90wWN0v488eBciXrNf1BZvLkHpCgID98o7Eu9Ri96IMNAbOZghB+03+jPl2s
         hwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780085471; x=1780690271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+f5PwTRtQw0NnCrpunqjHa+0pqSt5ykYfwDM0Ecjt7k=;
        b=QX3fH8JZvi3/GvU24EonUkHNfSkEyAXZfXLA/ajj/uqVZ1d48/kCZqAs83od50tmIE
         sZJDPuE43OyXQF1EuCznLvgHfxkvzjRgj/YLBtNhYoNz6YH6pdEXBvjNMPq1HCJToQCP
         jq4NykO8BHquuo10WV7hiRXbokauBjqcp8mEwjF47sZ+LjRX6/62/A8ioFADgQEQxz8j
         qEayQClmFOQ2U3g05vtEAXQPrnRNF85oYqkCCpRxznseWggl7arQXsbLnz4Wij7BZzhQ
         XdIamhw61OYPfrNze+XLrFc7VmMVB1e3ODewHP+V1uqwcgIVoW0zsHDD+SPVOKbJQzS6
         813g==
X-Forwarded-Encrypted: i=1; AFNElJ/TOrLeeiy9XAkWNDX8cFySEP1kFbSog30hP6TYcmwGkIOkJU60YU2bCJVOP9b12Ivhd2ieidgPCoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNfPXowAvU/wd2b6lHbKaJxA7fhsKVmUMTW3z0nL1Ewb1MFMq
	D0dmARgcQ4KZD4Tz8C04rZUIxKsEnj1fo9rMfnhFQgYIoxRL3VFA4DNXNgQLGQ5PzfODY7bPlFH
	8hA==
X-Received: from pfbga12.prod.google.com ([2002:a05:6a00:620c:b0:835:687a:d19d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a88c:b0:83a:35b2:2bf
 with SMTP id d2e1a72fcca58-8422579c5e4mr911561b3a.41.1780085470690; Fri, 29
 May 2026 13:11:10 -0700 (PDT)
Date: Fri, 29 May 2026 20:11:05 +0000
In-Reply-To: <20260403222750.1215002-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403222750.1215002-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529201105.1239477-1-praan@google.com>
Subject: Re: [PATCH v3] PCI: Ensure ATS disabled via quirk before notifying
 IOMMU drivers
From: Pranjal Shrivastava <praan@google.com>
To: dmatlack@google.com
Cc: aleksander.lobakin@intel.com, andriy.shevchenko@linux.intel.com, 
	baolu.lu@linux.intel.com, bartosz.pawlowski@intel.com, bhelgaas@google.com, 
	dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	rananta@google.com, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Apr 03, 2026 at 10:27:50PM +0000, David Matlack wrote:
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
> the pci=noats command line option, in that pci_ats_init() bails
> immediately and never initializes pci_dev.ats_cap.
>
> Note: In practice this fix only matters for PCI devices created after
> IOMMU bus notifiers are set up (e.g. hot-plugged devices and VFs).
>
> Fixes: a18615b1cfc0 ("PCI: Disable ATS for specific Intel IPU E2000 devices")
> Closes: https://lore.kernel.org/linux-iommu/aYUQ_HkDJU9kjsUl@google.com/
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> v3:
>  - Clarify in commit message that only devices added after boot are
>    affected (Baolu)
>  - Use header fixups instead of early to avoid breaking
>    quirk_amd_harvest_no_ats() (Sashiko)
>  - Use u8 instead of unsigned int for no_ats to avoid affecting the
>    offsets of existing fields in struct pci_dev (me)
>
> v2: https://lore.kernel.org/linux-pci/20260327211649.3816010-1-dmatlack@google.com/
>
> v1: https://lore.kernel.org/linux-pci/20260223184017.688212-1-dmatlack@google.com/
>
> Cc: Raghavendra Rao Ananta <rananta@google.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>  drivers/pci/ats.c    |  2 +-
>  drivers/pci/quirks.c | 50 ++++++++++++++++++++++----------------------
>  include/linux/pci.h  |  1 +
>  3 files changed, 27 insertions(+), 26 deletions(-)
>

Applying ATS quirks during the HEADER phase seems correct for the IOMMU
drivers to get the right view. I observed side effects due to the quirks
being applied in the FINAL phase [1] which seem to go away with this fix.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Tested-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20260504163842.2692314-1-praan@google.com/
