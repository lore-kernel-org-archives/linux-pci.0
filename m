Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378756;
	b=bDULs1YozwL1aLGktJqB949VNt0jpGbkyXB31S/6aoZzOM0wgm2BcfbyqFeVCYjItC6f
	 Yc+E+jdeW46GaD7ahwLGddxdS0jcWnKWUZumofbMCxRx+9G9ErwbIIEvtsxSBMlikt+V4
	 Qt7Ju2vJlGj7toO0810Y/j0oqtU8Cjr9f86L1R2LBAoUQO+YXSamqsshhj1L2JHisNbl3
	 ZS6shuuciw1Owd6J8v7ixyqTh65+U05fzdM5H9stARUPvQrZ//JErRg/mn7poq8z82dCh
	 QF2thzDdpQQ6FwILSyn8PzLQBM1v6dK7VK+77j9lBBDt3pfcV7V5V/qdj9VbgaX3rhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
	b=VmNdA5hzM7bt5Y/9VwXubI1GFxTSyFLmwxDsexcFg57VP757wR98Main68xe7lOeVB63
	 5k9UQUcWELa5cBr+NcCJYJddYAOifOjAnYLWlHANKNAh0ltfUCuvCXZuX0fLeNxrJXNxL
	 NUvn21ycaNtUxhF+x1Vxf7rd1xOOTTOZT/rX7VGCnvJILZckV4xOGYSE9PnMlfbHLGTtz
	 9M21BG0CtcY9aL2PyLDkY2pbWM82zkXG5mjVx67ML7mGShLS+CmrV/cYItwX6vxHsvefS
	 22ISqw+yU2Ro4WgDO1E4nTV2PcLwUYLgaVFnEzswkJlWC/rXHA9fr/Sq5xId/xqkh4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHlREPoq;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03364606A326
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03364606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tHlREPoq
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so32065385e9.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 22:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794378754; x=1794983554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
        b=tHlREPoqa3VREtd/3FqXEUOQP7wEvLpOjRoM9iujAcGnu2x208KdouZARqXfWc8LUp
         xQPFMmdwxe0xffIOTCemDQi04ZE3O+U7kC7Az5oHwzwHT0Kb/PNDdI8MkPRuIC165xZi
         J9LjxfJQyt7jUVlixwSoVo4Au61L8iJDi0e7wUe4P5RENdlkHX28QizsvyhSScqj7GLA
         9uTuUbaAnv7tzNWvwEHBoa9OD9fTDDsYS71kqMeeJ5Z3BL5Sq6qoectk/JdgJLn9+rnC
         iiHX7XhC2ap7sdO9RGcsPVuCZ+FTEamoYDxeG8NQ80Ij2fqXLNBF/mvJnCFJybSK73Rb
         FWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794378754; x=1794983554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iG+inULdiX/9F1jgHvoIofo1nPKwdx5Mas8WwwOmeh8=;
        b=l+f+etpCyGT6wXTd4I0rd++7nW7np2UJZPJHYu+bUi/ek2VZb8Xd0EJyjEGlQfkmM3
         NldJ718O/faoKdPEg7gORbsrFVh2QFJk7J4o/5Zv4CWGXDJLWgbYHjhZfM15F4BQy0lU
         gVcFcvuRKZ2Wn+r/EFvDZ4nTNBhYg0N4nmUQELbEGbXSax+rZkv3x0FPuXNAYC8i6/i0
         KMAFFn7g1LsWPWwiXE5QKVxSf9pjfa1E1rRQgAkc93AGnKYOghyy23bXVXG8hBcrWE7S
         sUu4Tm6Ufa7i8mZZXh5oWiF29KWO4g6AXTyiKjU/YyH8wyTmo2ISw1s6as381sgpnUwq
         KkYw==
X-Forwarded-Encrypted: i=1; AL+hErF/EMfNA7oIASapKJltEHj4GRB9my4EtUJjUbMUH6faGDFBhUX9dpBiPIXHea3py6dSTojM5MXbCfQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MjnlMWC3WDlXEk3m48CJQLldJN6m9zY5avJi7pLHth45DaX4Y
	ZENNgX4M0fCCnYOLfuCA+toumo1RfPQm7ub3UodxYt+VOLPrzrTAtxch
X-Gm-Gg: AYBFou1tQnHGrGNJbLXtzcONXwRFVktSqxw7L+j4IaV33IKoEEB1/5NLkFnBlMLVrZF
	d4k0I+0JbLcdvWxHBQBcH1xFYbYstZ6wVgByAqP1c56/YS/LM+pHhy0rQ4n68FHidkyIT60ASuK
	2C+Lem+v4yMKaX9kHCdNlOQsvDPZysPSFKJatEkJxyBDNyNnt9zBIIusw1oF1MF4VWDbhZt3LV7
	KYW3LS3zMEaN9qE0FYXmfOJSCEAoJN3s3mp6pSKYHX36xDVTOkAPzJxnOQ703IPb3ZpFBQ2C8ir
	dik5fkNZhD25Twlarmvih8M5ScrmEmoZNaJ9RYm/Ky/AKl5jQoesip3NuMosv8t0xE1UyojmwyU
	sDcZegxp7LhnOZSPdqHgVg1kR3FE0omiLChaCb0R3/knPL+BWHgfU+yQKFXJD5zEbQiMrg3kv+4
	1ZDqJa3ZQWsbhlCjs1njC1JOZX3hGLlI81A5vtbxjYjQBytjg7e4ugb2ZrWoYzvVdabwNc0iVHO
	hbH1PNENRh+IrOhCR97ILLU8nxEbPRObAih+nKW/WT/zzdmJM7aQOewXAUsEblRpGQzjK4jH6wg
	bSnULDd1FIH8Eo9u5gGAxjPXGAcabmmcZ7XVh73sR9C6VdTFHRN29//D2PYSBFHl5f3c/bitoQ=
	=
X-Received: by 2002:a5d:64e3:0:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-499c903d741mr1957954f8f.23.1794378754237;
        Tue, 10 Nov 2026 22:32:34 -0800 (PST)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c027sm8981259f8f.24.2026.11.10.22.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:32:33 -0800 (PST)
From: Victor Carreras <vicajilau@gmail.com>
To: rafael@kernel.org,
	hdegoede@redhat.com,
	bhelgaas@google.com,
	lukas@wunner.de
Cc: mika.westerberg@linux.intel.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Wed, 11 Nov 2026 07:32:27 +0100
Message-ID: <20261111063227.14511-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAJZ5v0iqOoS8t-5PFeLPuaJrpeByx2Yr-dnpYU2fT6yTb6-7=A@mail.gmail.com>
References: <CAJZ5v0iqOoS8t-5PFeLPuaJrpeByx2Yr-dnpYU2fT6yTb6-7=A@mail.gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 9, 2026 at 8:32 PM Rafael J. Wysocki wrote:
> Please see Sashiko's feedback on this one and let me know what you
> think about it:

Hi Rafael,

Sashiko is right, v2 does not work as intended. Clearing can_wakeup in a
final fixup is undone by pcie_pme_can_wakeup() when the PME service
binds, and in any case acpi_pci_wakeup() and acpi_pci_propagate_wakeup()
only look at adev->wakeup.flags.valid, so _DSW on PEG0 still gets
evaluated, both for the root port itself and when wakeup is propagated
from the dGPU below it.

v3 follows the suggestion: it clears adev->wakeup.flags.valid from a
DECLARE_PCI_FIXUP_EARLY quirk, which runs in pci_setup_device() after
pci_set_acpi_fwnode() and before device_add() calls pci_acpi_setup(),
so pci_acpi_setup() and pci_acpi_cleanup() stay balanced and both
paths skip PEG0. With v3 and the SSDT workaround removed, the root port
and the dGPU reach D3cold on my MS-1594 and the touchpad keeps working
across repeated D3cold cycles. I'm sending it as a reply to this thread.

Thanks,
Victor
