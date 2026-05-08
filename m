Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA83164B4
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778212282; cv=none; b=RT6emuujbfyJnfBSX9BDeqCwF5Ov0zFXK1BoiZaUEmY+8h0b9iYPEOD8kdfy2aqoMjqN0zB/L50XWoy40KQSew+B5cr4SziMK/GDj+G2oCKTdUeproOtXnnuoOY4J0TJ9ENmurTZzYDc2uRdhvVl5CQflJv0hZ06nxSjdjiVmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778212282; c=relaxed/simple;
	bh=z+5oA5BPPIEqNHttbRIYC/r5Gs4ENfdToHy8KAl0PI0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZMKFxHIYzlbzhhWiLBvWXxg/g0llBSPc5dU8p9Bl5TgtAA8cFJrE7W2PsrHaZKHhHstOWFDGd4yW9SGzI8QlR5yb2CMS7Ygw/CxjxOIrowydY7CyhgTh3J/vBcFJAhNp9ooim3beMbp+G0WsVFkqJECp64tfy27fv5bGx9u06nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SONPOt6l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SONPOt6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5CEC2BCB0;
	Fri,  8 May 2026 03:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778212282;
	bh=z+5oA5BPPIEqNHttbRIYC/r5Gs4ENfdToHy8KAl0PI0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SONPOt6lI5DzliodITB9Z/pKBA4Y4C6Q6b9zM1SW3gSY4uNRTNe1NqJEHleoKszuj
	 d+XJFuAySaUiwbHFUrdYHnJ8+fbC8W4nQtteQF4ZijVdQUi4j52YaDDNp1Z+09MWCw
	 q/yVpJIXQjjrvULSF2ca4cgiZVXaNwt3VxvscZfjBw2aGJZDFpyD+E34cxk3Btyqs/
	 khygxEYDLyHA0RtfeECskjJgseImNvzvjmuikbibhyvBzURkc3Mge0XPvDjLCa6cl3
	 h9aNYAYsueDaDtTlSkaLQyuwTD1gWDi2P1ht/LZ+O9g+Syh2CkePwTJNuN6gcNSo68
	 KroaxSZxzXjDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/18] rust: error: impl From<FromBytesWithNulError> for
 Kernel Error
Reply-To: sashiko@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260508031710.514574-7-alistair.francis@wdc.com>
References: <20260508031710.514574-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 03:51:21 +0000
Message-Id: <20260508035122.2C5CEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added import `use core::ffi::FromBytesWithNulError;` does=
 not follow the required kernel vertical import style.
--

commit 125b12ec12dfbbb7b1bcebfd39f627c83e1aa2f3
Author: Alistair Francis <alistair.francis@wdc.com>

rust: error: impl From<FromBytesWithNulError> for Kernel Error

Implement From<FromBytesWithNulError> for the Kernel Error type.

> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05cf869ac0908..5463addbfd957 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -12,6 +12,7 @@
>      str::CStr,
>  };
> =20
> +use core::ffi::FromBytesWithNulError;
>  use core::num::NonZeroI32;
>  use core::num::TryFromIntError;
>  use core::str::Utf8Error;

This isn't a bug, but should this newly added import follow the kernel
vertical import style documented in the general coding guidelines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031710.5145=
74-1-alistair.francis@wdc.com?part=3D6
