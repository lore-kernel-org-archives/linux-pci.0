Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE103E00A5;
	Sat,  5 Sep 2026 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607858; cv=none; b=JYSszwqa3Z/E5Ox6zflXxZRvIZJi8jhTuSxDpSohRaMhstPvBRgmWT9s9HdjVt11HeKmCHUHFkKZYPym9jqq5gatV1Xu2ymHTgFUJveRoYrHAqcIG4YqJLuKnEr2Nfd5Q2OUhxoWjXkN1t5a/M1hMVkeG3pwutMjVDqBYpuova0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607858; c=relaxed/simple;
	bh=maFTYAXrslngym6UpC8jN+SMqgee7/aOIO+WCHPCdcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbWzSt8+SSyebILk8xBK4tmGjk4s5sydU+lnDDSK6d2dQr2syBG9T0Nm5uG0oswXnT6VYnI889+pjqf1XfZSLsWeTfT+yQDUcQZ3tanok9nzOMHUtf89+4h2E45o4x78cV3LBbcdPm77W2n54Dbk4wKx2wLcE9fgI7JgtjNkUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ljyzQ61h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ljyzQ61h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6561F00A3D;
	Sat,  5 Sep 2026 11:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788607856;
	bh=cjQbOv3OS+Rkr81lmfPRnC5MozHa05tocJXmiA0asO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ljyzQ61hM09ESjFJs65ThgWUZDNoEDzICBUfHo/ulPccb0xn7jkTnroPMrzBW6Ir3
	 4oA6vDclfjOGYg76awApxJuR8CvsUyKBGUN0vjCn0rhefGK2h7LitSacHVUmsuhfnK
	 bN495BehPGVK4Vuk94Juezhzz2dZoR7+lESotFIs=
Date: Sat, 5 Sep 2026 13:29:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Breno Rodrigues Alves <breno3011alves@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org, linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] Kconfig: purge twenty-nine legacy ghost options
Message-ID: <2026090551-abrasion-fool-3586@gregkh>
References: <20260904231240.87106-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904231240.87106-1-breno3011alves@gmail.com>

On Fri, Sep 04, 2026 at 08:12:40PM -0300, Breno Rodrigues Alves wrote:
> You can keep a dead config option around for a while out of sympathy.
> After a couple of releases it stops being "transitional" and starts
> being "you are confusing every user who greps for it". These options
> select nothing, gate nothing, and -- I checked by hand, this is not a
> regex accident -- are referenced by exactly nobody in the tree.
> 
> Evidence for each removal:
>   * no CONFIG_<sym> reference outside the Kconfig definition itself
>   * no <sym> reference as an 'if'/'select'/'depends on' target
>   * no mention in any defconfig, any Documentation, or any source build
>   * the code they used to gate is gone (removed or folded into a real
>     driver that already has its own, functioning config symbol)
> 
> Headliners of the graveyard:
>   - HID_THINGM: help text literally said "will be removed soon". Well.
>     Gone now. The blink(1) driver is HJID_LED.
>   - USB_CONFIGFS_F_TCM: the real fabric always built via USB_F_TCM; the
>     "CONFIGFS" name was a leftover from when someone could not decide
>     what to call the thing.
>   - USB_EHCI_TEGRA, USB_OCTEON_OHCI, USB_OHCI_HCD_SSB: help text says
>     "driver was removed, use X instead". The other X already exists.
>   - PANEL: proudly labeled "OLD OPTION" with its own "Deprecated
>     options" section in the file. The actual parport lcd driver has
>     always been PARPORT_PANEL.
>   - COMMON_CLK_MT6765_*: seven sysclk entries with no matching object
>     in the Makefile. Zero files built, zero regrets.
>   - The usual kconfig-vandalism suspects (HAVE_PWRCTL, REGULATOR_MT6316,
>     INTERCONNECT_MTK_MT8196, CLK_SUNXI_PRCM_SUN9I, DVB_ULE_DEBUG, ...).
> 
> Validated: defconfig, olddefconfig and randconfig parse clean on both
> x86_64 and arm64; headers_install (the target that replaced the dearly
> departed headers_check, which this tree does not have) succeeds with a
> clean UAPI on both architectures. Because someone will ask: yes, I
> checked the s390/arm/riscv No, I did not delete any arch/* Kconfig, and
> no, I did not touch a single include/uapi/ file.
> 
> Why should you care? Because "make menuconfig" allegedly lets people
> configure the kernel, and leaving a menu full of options that do
> nothing makes them feel like they have a choice when they really are
> just being sold snake oil. Clean it up.
> 
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Did you forget the Assisted-by: tag here?

ANd this should be broken up per subsystem please.

thanks,

greg k-h
