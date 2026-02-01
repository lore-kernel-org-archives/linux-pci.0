Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87CA224AE8
	for <linux-pci@vger.kernel.org>; Sun,  1 Feb 2026 06:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769927095; cv=none; b=QZULBDq9bsWk4kUMAhe4SVW8Cf8Fvvj9v2fE3mY+QSw0MZ9J4XnRS6Op8qHK0gKCCUctkJfI0/GCc2vWzpGfasUet8ERXM0Vy0JhsVGR9ZPwanjb/EhJ+n5LoiXjYAhy0ezSfLb1iMP9JsMLxUr0axGz9m+3JESBC3Dch/PLa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769927095; c=relaxed/simple;
	bh=VQgd/ntI7MrOtZ5XEOtaiTzReNsfs7DqrEP/Dk+Ea6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKcBZLEesokS97Kejmhqxvrqfe9E7kbSLCRx+I8C1wAmYr34L2YxPeAvpM8ErazsLhf/3E7ySPWrhFsRt4BixDrOKg0p7f3inrKsZa2RbOKIh09vgXlUwr38696kin+QrZi/OB9Uff3VwSIlEIr9cPqwx4PLFBWKKND3hV6OY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHOvPUKQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHOvPUKQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso35323405e9.2
        for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2026 22:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769927092; x=1770531892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1PDCVMHZp+0xGdbh+dSoCllMY4HTfCtaq+3usc0PNI=;
        b=mHOvPUKQALqLPbSqYLMQGioV7Jti3JWUGQwIoZ418grbkyir1jy9VVuLw4aMW1bbOE
         gn74qpV2K4XF2m/Q3x61GXChM8FZe9LwChNQmEPGkjy3rNRuM/xBPxm6NGc+E9cEpN+6
         aZVCxN4Ex9WlY6Wpb5wlyBacmwMceMJxHQJLknoskikmit3mrhUz/XcC3tn6DqYWlsL+
         a7lBAsmMDKKNCayLeLML5fmslieqgrSxmkZAW4yulMdzYO+vS1nSPf77u0tTM6PlEf/G
         Fl1bAgKw4VIpAJShOCMSsJjX3OCXh7G0YFVunwojwx0utvrbJAInne8rdeZydvb9f265
         gr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769927092; x=1770531892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1PDCVMHZp+0xGdbh+dSoCllMY4HTfCtaq+3usc0PNI=;
        b=S6f7FSqxQDVllaCjlKtH09h2i8wjVKtCFA8SKryWuAfWbA6sAGaQ/7F+J3KQuGK0NI
         Ny9+e4BwMZ04CRtPS28Jg2agRqkol5nY/uRoojL9osDgiTdA98mdNNf6K0BGB3o1Tfls
         F7NU/KLwdMb57yP5HkjK1o5ycZtMJI9wMDuO07FfUKndFat8jbcEklKr0ZligKGdHgZy
         eOU5UI4062DR6bA1bmbyucCd0yrSERPxnEzhYXpXNPFVREt/SI287x591hxAR2KlHRJp
         xsHxhvypddM/1bgFxIGqA73a8MzPkTAYrwlbR54jsOjLak6SH+KBk9jzJBP/E/YL2Hhc
         wT/g==
X-Forwarded-Encrypted: i=1; AJvYcCVLWArdacrvQ9mZSQrH8PpCntegXa8agLpr9AWotIZhTXbUEfeG13eemVy/G0qvMps5rfHo8l1gCtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKz+yVxKxZ6Ms3qJ9YN5OMlbcTg/HSTeJdRmbPT3/xIkHPYLN
	PisiIPrFQhIcf68asP6ivFWL0/x1bA7sjXjXdRqvy4JYthmKV+gz8GNU
X-Gm-Gg: AZuq6aJVLhD0WNAdNqq55qG056yid7uevD9xlykg+ilj6/tvbihYl/Kg80yFb9312ru
	9h88PBa1e9B/E88/EXuOepYviWFQRcPMCkzpXWiVj6IfX/nJkeHRE5dH9fTj8hTqY6r96vbOWTh
	cghuBrCeEeElsZTzcTykH3RsYln6HDgFKF6nfZOXTFXfwNH36lFN7xSEqvaa4ySQ+hf6A9jQuzf
	mEH9dft6RamGpizVuRwnxM6OhZVID23A5wEwxp4bseVrdcASui8aIDvrLxL0X7CaUZ/OdZCJTM1
	H5cwbilzk3KUyrOfgLcjbhk+MDmzjoeVvFtPla/+lrBHzFVlPUqgQU/VP8uXeeT9tP8Z2CaG/Pb
	IHindgaQVa7Aq+vAIknCWd7QOst9YlXXVbEP0TpfqwXUahwGN7CPiVndPWEN3GRq0efZPd28btK
	haxTcWybfn/06oEPluNKmzEPxSrbsSsEW7O5uDMtSEGfHQn8J7wj+yjzJfvotOZbh9MYStFB5NL
	7QFltPJ4OTWFjAXQzPZQoWUXE/N3HVQkHMsX8Lh80XcN5qNPHWYkw0v
X-Received: by 2002:a05:600c:818f:b0:480:49ce:42cc with SMTP id 5b1f17b1804b1-482db45f4b7mr97490525e9.9.1769927091907;
        Sat, 31 Jan 2026 22:24:51 -0800 (PST)
Received: from ?IPV6:2003:df:bf2d:e300:2541:f823:ac24:da0b? (p200300dfbf2de3002541f823ac24da0b.dip0.t-ipconnect.de. [2003:df:bf2d:e300:2541:f823:ac24:da0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c3c6sm303675385e9.10.2026.01.31.22.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 22:24:51 -0800 (PST)
Message-ID: <d8549758-e2ac-4d5a-8231-790498556de3@gmail.com>
Date: Sun, 1 Feb 2026 07:24:50 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rust: pci: add capability lookup helpers
To: Zijing Zhang <zijing.zhang@ry.rs>, dakr@kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 gary@garyguo.net
References: <20260131040200.1242566-1-zijing.zhang@ry.rs>
 <20260131151749.1444030-1-zijing.zhang@ry.rs>
 <20260131151749.1444030-2-zijing.zhang@ry.rs>
Content-Language: en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20260131151749.1444030-2-zijing.zhang@ry.rs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Zijing,

some quite minor stylistic nits below:

On 31.01.26 16:17, Zijing Zhang wrote:
> Add thin wrappers around pci_find_capability() and
> pci_find_ext_capability().

pci_find_capability() -> `pci_find_capability()`

Same for the other cases and the 2nd commit message.

> The helpers return the capability offset in config space, or None if the
> capability is not present.
> 
> Introduce CapabilityId and ExtendedCapabilityId newtypes so drivers can use
> named constants without importing raw bindgen constants, while still
> allowing uncommon IDs via from_raw().
> 
> Signed-off-by: Zijing Zhang <zijing.zhang@ry.rs>
> ---
>  rust/kernel/pci.rs | 149 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 82e128431f08..213ff856f538 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -41,6 +41,118 @@
>      Vendor, //
>  };
>  pub use self::io::Bar;
> +
> +/// A standard PCI capability ID.
> +///
> +/// This is a thin wrapper around the underlying numeric capability ID.
> +#[repr(transparent)]
> +#[derive(Clone, Copy, Debug, Eq, PartialEq)]
> +pub struct CapabilityId(u8);
> +
> +impl CapabilityId {
> +    /// Creates a [`CapabilityId`] from a raw value.
> +    #[inline]
> +    pub const fn from_raw(id: u8) -> Self {
> +        Self(id)
> +    }
> +
> +    /// Returns the raw value.
> +    #[inline]
> +    pub const fn as_raw(self) -> u8 {
> +        self.0
> +    }
> +
> +    /// Power Management.
> +    pub const PM: Self = Self(bindings::PCI_CAP_ID_PM as u8);
> +    /// Accelerated Graphics Port.
> +    pub const AGP: Self = Self(bindings::PCI_CAP_ID_AGP as u8);
> +    /// Vital Product Data.
> +    pub const VPD: Self = Self(bindings::PCI_CAP_ID_VPD as u8);
> +    /// Slot Identification.
> +    pub const SLOTID: Self = Self(bindings::PCI_CAP_ID_SLOTID as u8);
> +    /// Message Signalled Interrupts.
> +    pub const MSI: Self = Self(bindings::PCI_CAP_ID_MSI as u8);
> +    /// CompactPCI HotSwap.
> +    pub const CHSWP: Self = Self(bindings::PCI_CAP_ID_CHSWP as u8);
> +    /// PCI-X.
> +    pub const PCIX: Self = Self(bindings::PCI_CAP_ID_PCIX as u8);
> +    /// HyperTransport.
> +    pub const HT: Self = Self(bindings::PCI_CAP_ID_HT as u8);
> +    /// Vendor-Specific.
> +    pub const VNDR: Self = Self(bindings::PCI_CAP_ID_VNDR as u8);
> +    /// Debug port.
> +    pub const DBG: Self = Self(bindings::PCI_CAP_ID_DBG as u8);
> +    /// CompactPCI Central Resource Control.
> +    pub const CCRC: Self = Self(bindings::PCI_CAP_ID_CCRC as u8);
> +    /// PCI Standard Hot-Plug Controller.
> +    pub const SHPC: Self = Self(bindings::PCI_CAP_ID_SHPC as u8);
> +    /// Bridge subsystem vendor/device ID.
> +    pub const SSVID: Self = Self(bindings::PCI_CAP_ID_SSVID as u8);
> +    /// AGP 8x.
> +    pub const AGP3: Self = Self(bindings::PCI_CAP_ID_AGP3 as u8);
> +    /// Secure Device.
> +    pub const SECDEV: Self = Self(bindings::PCI_CAP_ID_SECDEV as u8);
> +    /// PCI Express.
> +    pub const EXP: Self = Self(bindings::PCI_CAP_ID_EXP as u8);
> +    /// MSI-X.
> +    pub const MSIX: Self = Self(bindings::PCI_CAP_ID_MSIX as u8);
> +    /// Serial ATA Data/Index Configuration.
> +    pub const SATA: Self = Self(bindings::PCI_CAP_ID_SATA as u8);
> +    /// PCI Advanced Features.
> +    pub const AF: Self = Self(bindings::PCI_CAP_ID_AF as u8);
> +    /// PCI Enhanced Allocation.
> +    pub const EA: Self = Self(bindings::PCI_CAP_ID_EA as u8);
> +}
> +
> +/// A PCIe extended capability ID.
> +///
> +/// This is a thin wrapper around the underlying numeric capability ID.
> +#[repr(transparent)]
> +#[derive(Clone, Copy, Debug, Eq, PartialEq)]
> +pub struct ExtendedCapabilityId(u16);
> +
> +impl ExtendedCapabilityId {
> +    /// Creates an [`ExtendedCapabilityId`] from a raw value.
> +    #[inline]
> +    pub const fn from_raw(id: u16) -> Self {
> +        Self(id)
> +    }
> +
> +    /// Returns the raw value.
> +    #[inline]
> +    pub const fn as_raw(self) -> u16 {
> +        self.0
> +    }
> +
> +    /// Advanced Error Reporting.
> +    pub const ERR: Self = Self(bindings::PCI_EXT_CAP_ID_ERR as u16);
> +    /// Virtual Channel.
> +    pub const VC: Self = Self(bindings::PCI_EXT_CAP_ID_VC as u16);
> +    /// Device Serial Number.
> +    pub const DSN: Self = Self(bindings::PCI_EXT_CAP_ID_DSN as u16);
> +    /// Vendor-Specific Extended Capability.
> +    pub const VNDR: Self = Self(bindings::PCI_EXT_CAP_ID_VNDR as u16);
> +    /// Access Control Services.
> +    pub const ACS: Self = Self(bindings::PCI_EXT_CAP_ID_ACS as u16);
> +    /// Alternate Routing-ID Interpretation.
> +    pub const ARI: Self = Self(bindings::PCI_EXT_CAP_ID_ARI as u16);
> +    /// Address Translation Services.
> +    pub const ATS: Self = Self(bindings::PCI_EXT_CAP_ID_ATS as u16);
> +    /// Single Root I/O Virtualization.
> +    pub const SRIOV: Self = Self(bindings::PCI_EXT_CAP_ID_SRIOV as u16);
> +    /// Resizable BAR.
> +    pub const REBAR: Self = Self(bindings::PCI_EXT_CAP_ID_REBAR as u16);
> +    /// Latency Tolerance Reporting.
> +    pub const LTR: Self = Self(bindings::PCI_EXT_CAP_ID_LTR as u16);
> +    /// Downstream Port Containment.
> +    pub const DPC: Self = Self(bindings::PCI_EXT_CAP_ID_DPC as u16);
> +    /// L1 PM Substates.
> +    pub const L1SS: Self = Self(bindings::PCI_EXT_CAP_ID_L1SS as u16);
> +    /// Precision Time Measurement.
> +    pub const PTM: Self = Self(bindings::PCI_EXT_CAP_ID_PTM as u16);
> +    /// Designated Vendor-Specific Extended Capability.
> +    pub const DVSEC: Self = Self(bindings::PCI_EXT_CAP_ID_DVSEC as u16);
> +}

Missing empty line before `pub use self::irq` below?

>  pub use self::irq::{
>      IrqType,
>      IrqTypes,
> @@ -427,6 +539,43 @@ pub fn pci_class(&self) -> Class {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
>          Class::from_raw(unsafe { (*self.as_raw()).class })
>      }
> +
> +    /// Finds a PCI capability by ID and returns its config-space offset.
> +    ///
> +    /// Returns `None` if the capability is not present.
> +    ///
> +    /// This is a thin wrapper around `pci_find_capability()`.
> +    #[inline]
> +    pub fn find_capability(&self, id: CapabilityId) -> Option<u8> {

Depending on the future use of this function (and
`find_ext_capability()` below) would it be an option to introduce a
type for the returned u8/u16 offset?

> +        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
> +        // `struct pci_dev`.
> +        let offset = unsafe { bindings::pci_find_capability(self.as_raw(), id.as_raw().into()) };
> +
> +        if offset == 0 {
> +            None
> +        } else {
> +            Some(offset)
> +        }

In

https://lore.kernel.org/rust-for-linux/CANiq72kiscT5euAUjcSzvxMzM9Hdj8aQGeUN_pVF-vHf3DhBuQ@mail.gmail.com/

it was proposed to use the style

if offset == 0 {
    return None;
}

Some(offset)


Best regards

Dirk


> +    }
> +
> +    /// Finds an extended capability by ID and returns its config-space offset.
> +    ///
> +    /// Returns `None` if the capability is not present.
> +    ///
> +    /// This is a thin wrapper around `pci_find_ext_capability()`.
> +    #[inline]
> +    pub fn find_ext_capability(&self, id: ExtendedCapabilityId) -> Option<u16> {
> +        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
> +        // `struct pci_dev`.
> +        let offset =
> +            unsafe { bindings::pci_find_ext_capability(self.as_raw(), id.as_raw().into()) };
> +
> +        if offset == 0 {
> +            None
> +        } else {
> +            Some(offset)
> +        }
> +    }
>  }
>  
>  impl Device<device::Core> {

